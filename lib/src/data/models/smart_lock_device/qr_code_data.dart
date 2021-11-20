class QRCodeData {
  late int id;
  late String name;
  late String url;
  late int port;

  QRCodeData({
    required this.id,
    required this.name,
    required this.url,
    required this.port
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'url': url,
      'port': port
    };
  }

  @override
  String toString() {
    return 'SmartLockDevice { id: $id, name: $name, url: $url, port: $port}';
  }

  QRCodeData.fromMap(Map<String, dynamic> map) {
    id = map['id']!;
    name = map['name']!;
    url = map['url'];
    port = map['port']!;
  }

}