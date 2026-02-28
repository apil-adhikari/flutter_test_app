class AlbumModel {
  final int userId;
  final int id;
  final String title;

  AlbumModel({required this.userId, required this.id, required this.title});

  // Factory constructor(this will not create a new instance everytime, it can reuse the older instances)
  factory AlbumModel.fromJson(Map<String, dynamic> json) {
    return AlbumModel(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
    );
  }

  Map<String, dynamic> toJson() => {"userId": userId, "id": id, "title": title};
}
