abstract class SLDBModel {
  abstract String tbName;
  Map<String, dynamic> toMap();
  SLDBModel.fromMap(Map<String, dynamic> map);
}