import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'ia_client.dart';

class AzureOpenAIClient implements IAssistantClient {
  final String _apiVersion = dotenv.env['AZURE_OPENAI_API_VERSION'] ?? '';
  final String _azureEndpoint = dotenv.env['AZURE_OPENAI_ENDPOINT'] ?? '';
  final String _apiKey = dotenv.env['AZURE_OPENAI_API_KEY'] ?? '';
  final String _deploymentName =
      dotenv.env['AZURE_OPENAI_DEPLOYMENT_NAME'] ?? '';

  AzureOpenAIClient() {
    if (_apiKey.isEmpty ||
        _azureEndpoint.isEmpty ||
        _deploymentName.isEmpty ||
        _apiVersion.isEmpty) {
      throw Exception(
          'Faltan variables necesarias en el .env para configurar AzureOpenAIClient');
    }
  }

  @override
  Future<String> generateDescription(String task) async {
    final url = Uri.parse(
      '$_azureEndpoint/openai/deployments/$_deploymentName/chat/completions?api-version=$_apiVersion',
    );

    final headers = {
      'Content-Type': 'application/json',
      'api-key': _apiKey,
    };

    final body = jsonEncode({
      "messages": [
        {"role": "system", "content": "Eres un asistente útil"},
        {
          "role": "user",
          "content":
              "Generame la descripción para la siguiente tarea: $task, en 20 palabras o menos."
        }
      ],
      "max_tokens": 100,
      "temperature": 0.7
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final raw = data['choices'][0]['message']['content'] as String;

        final fixed = utf8.decode(latin1.encode(raw));
        return fixed;
      } else {
        throw Exception("Error ${response.statusCode}: ${response.body}");
      }
    } catch (e) {
      print('Error al enviar prompt a Azure OpenAI: $e');
      rethrow;
    }
  }
}
