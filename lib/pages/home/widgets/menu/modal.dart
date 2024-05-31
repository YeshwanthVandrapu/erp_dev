class RawMenuModal {
  int parentId;
  String resourceIcon;
  int resourceId;
  String resourceName;
  bool isSelected = false;

  RawMenuModal({
    required this.parentId,
    required this.resourceIcon,
    required this.resourceId,
    required this.resourceName,
  });

  factory RawMenuModal.fromJson(Map<String, dynamic> json) => RawMenuModal(
        parentId: json["parent_id"],
        resourceIcon: json["resource_icon"],
        resourceId: json["resource_id"],
        resourceName: json["resource_name"],
      );
}

class MenuModal {
  String resourceIcon;
  int resourceId;
  String resourceName;
  bool isSelected = false;
  int clickIndex = -1;
  List<MenuModal> children;

  MenuModal({
    required this.resourceIcon,
    required this.resourceId,
    required this.resourceName,
    required this.children,
  });

  Map<String, dynamic> toJson() => {
        "children": children,
        "resource_icon": resourceIcon,
        "resource_id": resourceId,
        "resource_name": resourceName,
      };
}
