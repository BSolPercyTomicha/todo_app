import '../../../../../ai/clients/ia_client.dart';

abstract class IADataSource {
  Future<String> generateDescription(String task);
}

class IARemoteDataSource implements IADataSource {
  final IAssistantClient client;

  IARemoteDataSource(this.client);

  @override
  Future<String> generateDescription(String task) {
    return client.generateDescription(task);
  }
}
