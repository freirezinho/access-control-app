import 'package:access_control/src/usecases/message_retriever/repository/message_client.dart';
import 'package:access_control/src/usecases/message_retriever/repository/message_repository.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

abstract class MessageRetrieverUseCase {
  late final MessageRepository repository;
  final void Function() onConnected;
  final void Function() onDisconnected;
  final void Function(String) onSubscribed;
  final void Function(String) onSubscribedFail;
  final void Function() on;
  final void Function() pong;

  MessageRetrieverUseCase({
    required this.onConnected,
    required this.onDisconnected,
    required this.onSubscribed,
    required this.onSubscribedFail,
    required this.on,
    required this.pong,
    required this.repository,
  }) {
    this.repository.onConnected = onConnected;
    this.repository.onDisconnected = onDisconnected;
    this.repository.onSubscribed = onSubscribed;
    this.repository.onSubscribedFail = onSubscribedFail;
    this.repository.on = on;
    this.repository.pong = pong;
  }

  Future<MqttServerClient> connectMqtt({required void Function(List<MqttReceivedMessage<MqttMessage>>)  messageHandler}) async {
    return this.repository.mqttClient(messageHandler: messageHandler);
  }

  static allow() {
    _publishMessage("allow");
  }

  static deny() {
    _publishMessage("deny");
  }

  static _publishMessage(String message) {
    final builder = MqttClientPayloadBuilder();
    builder.addString(message);
    MessageClient.shared.mqttClient.publishMessage("endpoint", MqttQos.exactlyOnce, builder.payload!);
  }

}