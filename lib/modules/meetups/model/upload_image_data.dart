class UploadImageDetails {
  String id;
  String imageURL;

  UploadImageDetails({required this.imageURL, required this.id});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> map = <String, dynamic>{};
    map['id'] = id;
    map['imageURL'] = imageURL;
    return map;
  }
}
