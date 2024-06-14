import 'dart:convert';

RawMenuModal rawMenuModalFromJson(String str) =>
    RawMenuModal.fromJson(json.decode(str));

class RawMenuModal {
  String bottomNav;
  String parentId;
  String resourceDescription;
  String resourceIcon;
  String resourceId;
  String resourceName;
  String resourceType;
  String route;

  RawMenuModal(
      {required this.bottomNav,
      required this.parentId,
      required this.resourceDescription,
      required this.resourceIcon,
      required this.resourceId,
      required this.resourceName,
      required this.resourceType,
      required this.route});

  factory RawMenuModal.fromJson(Map<String, dynamic> json) => RawMenuModal(
        bottomNav: json["bottom_nav"],
        parentId: json["parent_id"],
        resourceDescription: json["resource_description"],
        resourceIcon: json["resource_icon"],
        resourceId: json["resource_id"],
        resourceName: json["resource_name"],
        resourceType: json["resource_type"],
        route: json["route"],
      );
}

class MenuModal {
  String resourceIcon;
  String resourceId;
  String resourceName;
  bool isSelected = false;
  int clickIndex = -1;
  List<MenuModal> children;
  String route = "/";

  MenuModal({
    required this.resourceIcon,
    required this.resourceId,
    required this.resourceName,
    required this.children,
    required this.route,
  });

  Map<String, dynamic> toJson() => {
        "children": children,
        "resource_icon": resourceIcon,
        "resource_id": resourceId,
        "resource_name": resourceName,
      };
}
