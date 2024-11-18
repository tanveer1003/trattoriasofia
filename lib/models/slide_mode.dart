class SlideModel {
  int slideId = 0;
  String title = "";
  String url = "";
  String image = "";
  String thumbnail = "";
  String description = "";

  SlideModel();

  SlideModel.fromJson(Map<String, dynamic> json) {
    this.slideId = json["id"] ?? 0;
    this.title = json['name'] != null ? json['name'] : '';
    this.image = json['image'] != null ? json['image'] : '';
    this.url = json['category'] != null ? json['category'] : '';
    this.thumbnail = json['image'] != null ? json['image'] : '';
    this.description = json['description'] != null ? json['description'] : '';
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = slideId;
    data['title'] = title;
    data['image'] = image;
    data['Category'] = url;
    data['image'] = thumbnail;
    data['description'] = description;
    return data;
  }
}
