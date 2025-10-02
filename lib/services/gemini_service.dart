import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  final GenerativeModel model;

  GeminiService({required String apiKey})
      : model = GenerativeModel(
    model: 'gemini-2.0-flash',
    apiKey: apiKey,
  );

  Future<String> generateResponse(String prompt) async {
    try {
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);
      return response.text ?? "Sorry, I couldn't generate a response";
    } catch (e) {
      return 'Error: $e';
    }
  }
}
