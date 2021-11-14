
import 'package:access_control/src/usecases/message_retriever/message_retriever.usecase.dart';

class MessageRetrieverUseCaseImpl extends MessageRetrieverUseCase {
  MessageRetrieverUseCaseImpl({
    required onConnected,
    required onDisconnected,
    required onSubscribed,
    required onSubscribedFail,
    required on,
    required pong,
    required repository,
  }): super(
      on: on,
      onConnected: onConnected,
      onDisconnected: onDisconnected,
      onSubscribed: onSubscribed,
      onSubscribedFail: onSubscribedFail,
      pong: pong,
      repository: repository
  );

}