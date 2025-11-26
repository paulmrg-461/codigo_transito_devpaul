import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class GeminiService {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://generativelanguage.googleapis.com/v1beta',
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'Accept': 'application/json',
      },
    ),
  );

  static String get _apiKey => dotenv.env['GEMINI_API_KEY'] ?? '';
  static String get _model {
    final m = dotenv.env['GEMINI_MODEL'] ?? '';
    return m.isNotEmpty ? m : 'gemini-2.5-flash';
  }

  static String get _fileUri => dotenv.env['GEMINI_FILE_URI'] ?? '';

  static Future<String> sendMessage(String message) async {
    try {
      final payload = {
        'system_instruction': {
          'role': 'system',
          'parts': [
            {
              'text':
                  'Eres un asistente experto en la Ley 769 de 2002 del Código Nacional de Tránsito de Colombia. Responde siempre en español colombiano, en texto plano, sin bloques de código ni JSON ni coordenadas. Proporciona una respuesta jurídica clara, citando artículos aplicables cuando sea útil.',
            },
          ],
        },
        'generationConfig': {
          'temperature': 0.7,
          'maxOutputTokens': 500,
          'response_mime_type': 'text/plain',
        },
        'contents': [
          {
            'role': 'user',
            'parts': [
              if (_fileUri.isNotEmpty)
                {
                  'file_data': {
                    'mime_type': 'application/pdf',
                    'file_uri': _fileUri,
                  },
                },
              {'text': message},
            ],
          },
        ],
      };

      final response = await _dio.post(
        '/models/$_model:generateContent',
        queryParameters: {'key': _apiKey},
        data: payload,
      );

      if (response.statusCode == 200) {
        final data = response.data;
        final candidates = data['candidates'];
        if (candidates is List && candidates.isNotEmpty) {
          final content = candidates[0]['content'];
          if (content is Map) {
            final parts = content['parts'];
            if (parts is List && parts.isNotEmpty) {
              final first = parts[0];
              final text = first['text'];
              if (text is String && text.isNotEmpty) {
                return text;
              }
            }
          }
        }
        throw Exception('Respuesta de Gemini inválida');
      } else {
        throw Exception('Error en la API de Gemini: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error al conectar con Gemini: $e');
    }
  }
}
