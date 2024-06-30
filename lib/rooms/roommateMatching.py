from matching.games import StableRoommates
import sys
sys.setrecursionlimit(3000)
import json
import pandas as pd
from flask import Flask, jsonify, request 
import urllib

app = Flask(__name__) 

def getStudents(path):
    with open(path,'r') as f:
        students = json.load(f)
    
    return pd.DataFrame(students)

def rscore2(name, roommates):
  potential = []

  # Weeding out top priority dissimilar roommates
  for i in roommates:
    if i['id'] != name['id']:
      if [ i["batch"]] == [name["batch"]]:
        potential.append([i,0])
      else:
        potential.append([i,-1000])

  # Score matrix
  for j in potential:
    score = 0
    if (j[0]["program"] == name["program"]):
      score += 250
    # Might have to specify this more?
    if (j[0]["city"] == name["city"]):
      score -= 80
      if (j[0]["prev_school"] == name["prev_school"]):
        score -= 100
      else:
        score += 70
    else:
      score += 160
    
    encodedPrefs = {
    "Cold": 1,
    "Moderate": 2,
    "Doesn't matter": 3,
    "Warm": 4,
    "Clean": 1,
    "Early to bed": 1,
    "Normal (10pm)": 2,
    "Late to bed": 4,
    "Yes": 1,
    "No": 4,
    "Silent": 1,
    "Noisy": 4,
    "OK": 1,
    "Not OK": 4
    }
    params = ['temp', 'clean', 'bedtime', 'lights_on', 'noise', 'guests']
    priority = {
        'temp': 1,
        'clean': 2,
        'bedtime': 3,
        'lights_on': 4,
        'noise': 5,
        'guests': 6
    }
    for param in params:
        score += preference_score(encodedPrefs[name[param]], encodedPrefs[j[0][param]], priority[param])
    # Add the score to the list
    j[1] += score

  sorted_candidates = sorted(potential, key=lambda x: x[1], reverse=True)
  return sorted_candidates

def preference_score(given_pref, check_pref, param_priority):
    # preference groups
    pref1 = [[1,1],[2,2],[3,3],[4,4]]
    pref2 = [[1,3],[2,3],[4,3],[3,1],[3,2],[3,4]]
    # pref3 = [[1,2]]

    if [given_pref, check_pref] in pref1:
        return 100 / param_priority
    elif [given_pref, check_pref] in pref2:
        return 75 / param_priority
    else:
        return -200 / param_priority

def matchRoommates(roommates):
    suitorPrefs = {}
    for r in roommates:
        matches = []
        scores = rscore2(r, roommates)
        for m in scores:
            matches.append(m[0]['id'])
        suitorPrefs[r["id"]] = matches

    matching = StableRoommates.create_from_dictionary(suitorPrefs)
    solved = matching.solve()
    return {
            "sex": roommates[0]["sex"],
            "school": roommates[0]["school"],
            "matches": {player.name: match.name if match is not None else None for player, match in solved.items()}
          }

@app.route('/<string:path>', methods = ['GET','POST'])
def main(path):
    decoded_path = urllib.parse.unquote(path)
    studentList= getStudents(decoded_path)

    roommatesBySchoolAndSex = {}
    schoolKeys = ["SIAS","IFMR","GSB"]
    sexKeys = ["Male","Female","Other"]

    for _,student in studentList.iterrows():
        if student["school"] not in roommatesBySchoolAndSex:
            roommatesBySchoolAndSex[student["school"]] = {
                "Male": [],
                "Female": [],
                "Other": [],
            }
        roommatesBySchoolAndSex[student["school"]][student["sex"]].append(student)
    
    allMatches = []
    for school in schoolKeys:
        for sex in sexKeys:
            if len(roommatesBySchoolAndSex[school][sex]) != 0:
              allMatches.append(matchRoommates(roommatesBySchoolAndSex[school][sex]))
    
    return jsonify({'Result': allMatches})

# main("C%3A%5CUsers%5CADMIN%5Croommate_student_list.json")
if __name__ == '__main__': 
    app.run(debug = True)