class SLDevice {
  final int id;
  final String name;
  final bool isActive;

  SLDevice({
    required this.id,
    required this.name,
    required this.isActive
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'isActive': isActive
    };
  }

  @override
  String toString() {
    return 'SmartLockDevice { id: $id, name: $name, isActive: $isActive}';
  }

}