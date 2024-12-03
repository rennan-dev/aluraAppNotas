import 'package:flutter_webapi_first_course/services/http_interceptors.dart';
import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/intercepted_client.dart';

class JournalService {
  static const String url = "http://192.168.80.107:3000/";
  static const String resource = "learnhttp/";
  
  http.Client client = InterceptedClient.build(interceptors: [LoggerInterceptor()]);

  String getUrl() {
    return "$url$resource";
  }

  Future<void> register(String content) async {
    final response = await client.post(
      Uri.parse(getUrl()),
      headers: {
        "Content-Type": "application/json", // Informar ao servidor que os dados são JSON
      },
      body: '{"content": "$content"}', // Corpo da requisição no formato JSON
    );

    if (response.statusCode == 201 || response.statusCode == 200) {
      print("Sucesso: ${response.body}");
    } else {
      print("Erro: ${response.statusCode}");
    }
  }

  Future<String> get() async {
    http.Response response = await client.get(Uri.parse(getUrl()));
    print('Response Body Teste: ${response.body}');
    return response.body;
  }
}