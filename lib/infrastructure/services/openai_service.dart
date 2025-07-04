import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class OpenAIService {
  static const String _baseUrl = 'https://api.openai.com/v1';
  
  static String get _apiKey => dotenv.env['OPENAI_API_KEY'] ?? '';
  static String get _model => dotenv.env['OPENAI_MODEL'] ?? '';

  static Future<String> sendMessage(String message) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/chat/completions'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'Authorization': 'Bearer $_apiKey',
          'Accept': 'application/json',
          'Accept-Charset': 'utf-8',
        },
        body: jsonEncode({
          'model': _model,
          'messages': [
            {
              'role': 'system',
              'content': 'Eres un asistente experto en la Ley 769 de 2002 del Código Nacional de Tránsito de Colombia. Responde de manera precisa y útil sobre temas relacionados con el tránsito y transporte en Colombia. Utiliza siempre el español colombiano correcto con todos los acentos y tildes apropiados. Mantén un lenguaje formal y profesional.'
            },
            {
              'role': 'user',
              'content': message
            }
          ],
          'max_tokens': 500,
          'temperature': 0.7,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        return data['choices'][0]['message']['content'];
      } else {
        throw Exception('Error en la API de OpenAI: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al conectar con OpenAI: $e');
    }
  }
}