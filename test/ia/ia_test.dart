import 'dart:io';
import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:todo_app/ai/clients/azure_open_ai_client.dart';

void main() {
  late HttpServer server;
  late int port;

  setUp(() async {
    server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    port = server.port;

    server.listen((HttpRequest request) async {
      if (request.method == 'POST') {
        final responseJson = {
          "choices": [
            {
              "message": {"content": "Descripcion generada correctamente"}
            }
          ]
        };

        request.response
          ..statusCode = 200
          ..headers.contentType = ContentType.json
          ..write(jsonEncode(responseJson));

        await request.response.close();
      }
    });

    await dotenv.load(fileName: '.env.test');

    dotenv.env['AZURE_OPENAI_ENDPOINT'] = 'http://localhost:$port/';
    dotenv.env['AZURE_OPENAI_DEPLOYMENT_NAME'] = 'fake-deployment';
    dotenv.env['AZURE_OPENAI_API_VERSION'] = 'v1';
    dotenv.env['AZURE_OPENAI_API_KEY'] = 'test-key';
  });

  tearDown(() async {
    await server.close();
  });

  test('IA genera una descripción simulada desde el servidor local', () async {
    final client = AzureOpenAIClient();
    final result = await client.generateDescription('Tarea de prueba');

    expect(result, contains('Descripcion generada correctamente'));
  });
}
