import 'dart:convert';
import 'package:http/http.dart' as http;

// 替换成你的API Key或JWT Token
const String apiKey = '318890d6614e2132e69aea4d70420387.1g8DrW8j2mNT50iN';
const String apiUrl = 'https://open.bigmodel.cn/api/paas/v4/chat/completions';

// 对话历史记录
List<Map<String, String>> conversationHistory = [];

Future<String> getChatbotResponse(String message) async {
  // 将用户消息添加到对话历史记录中
  conversationHistory.add({'role': 'user', 'content': message});

  final response = await http.post(
    Uri.parse(apiUrl),
    headers: {
      'Authorization': 'Bearer $apiKey',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({
      'model': 'glm-4', // 根据需求修改模型
      'messages': conversationHistory,
    }),
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    final chatbotMessage = data['choices'][0]['message']['content'];

    // 将机器人消息添加到对话历史记录中
    conversationHistory.add({'role': 'assistant', 'content': chatbotMessage});

    return chatbotMessage;
  } else {
    throw Exception('Failed to load response');
  }
}
