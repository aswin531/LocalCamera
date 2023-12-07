
class CameraModel {
  int? id;
  final String path;

  CameraModel({this.id, required this.path});

  static CameraModel fromMap(Map<String, Object?> map) {
    final id = map['id'] as int?;
    final path = map['path'] as String;

    return CameraModel(id: id, path: path);
  }
}
