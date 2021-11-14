import 'dart:async';

import 'package:access_control/src/usecases/message_retriever/repository/message_client.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

abstract class MessageRepository {
  final String url;
  final int port;
  final String clientID;
  abstract String? username;
  abstract String? password;
  abstract MessageClient messageClient;
  abstract void Function() onConnected;
  abstract void Function() onDisconnected;
  abstract void Function(String) onSubscribed;
  abstract void Function(String) onSubscribedFail;
  abstract Function on;
  abstract void Function() pong;
  late final StreamSubscription? streamSubscription;

  MessageRepository({
    required this.url,
    required this.port,
    required this.clientID
  });

  Future<MqttServerClient> mqttClient({required void Function(List<MqttReceivedMessage<MqttMessage>>) messageHandler});
}
