import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fuzzywuzzy/fuzzywuzzy.dart' as fuzz;
//import 'package:intl/intl.dart';


class APIKey {
  static const apiKey = "your-key";
}
class ChatGPTScreen_1 extends StatefulWidget {
  @override
  _ChatGPTScreenState createState() => _ChatGPTScreenState();
}

class _ChatGPTScreenState extends State<ChatGPTScreen_1> {
  final List<Message> _messages = [];
  final TextEditingController _textEditingController = TextEditingController();



  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void onSendMessage() async {
    final userMessage = _textEditingController.text;

    if (userMessage.isNotEmpty) {
      Message message = Message(text: userMessage, isMe: true);
      _textEditingController.clear();

      setState(() {
        _messages.insert(0, message);
      });

      String response = await getResponse(userMessage);
      Message chatGpt = Message(text: response, isMe: false);

      setState(() {
        _messages.insert(0, chatGpt);
      });
    }
  }

  Future<String> getResponse(String message) async {
    // Parse the JSON data
    String jsonData = await rootBundle.loadString('data/data.json');
    final parsedData = json.decode(jsonData);

    // Iterate through the responses and find the best match
    final responses = parsedData['responses'];

    String bestMatch = "";
    int bestScore = 0;

    for (var response in responses) {
      String question = response['question'];
      int score = fuzz.ratio(message.toLowerCase(), question.toLowerCase());

      if (score > bestScore) {
        bestScore = score;
        bestMatch = response['answer'];
      }
    }

    // If the best match has a similarity of more than 70%, return the answer
    if (bestScore > 60) {
      return bestMatch;
    }

    // Otherwise, send the message to OpenAI
    return await sendMessageToChatGpt(message);
  }

  Future<String> sendMessageToChatGpt(String message) async {
    Uri uri = Uri.parse("https://api.openai.com/v1/chat/completions");
    print(message);
    Map<String, dynamic> body = {
      "model": "gpt-3.5-turbo",
      "messages": [
        {"role": "user", "content": message}
      ],
      "max_tokens": 1000, // Số lượng token tối đa của câu trả lời
      "temperature": 0.7, // Điều chỉnh độ ngẫu nhiên trong câu trả lời (0.0 - 1.0)
      "stop": ["\n"] // Dừng câu trả lời sau ký tự xuống dòng đầu tiên
    };

    final response = await http.post(
      uri,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${APIKey.apiKey}",
      },
      body: json.encode(body),
    );

    // Xử lý và trả về câu trả lời từ phản hồi của API
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes)); // Giải mã UTF-8 cho phản hồi
      List<dynamic> choices = data['choices'];
      if (choices.isNotEmpty) {
        String reply = choices[0]['message']['content'];
        print(reply);
        return reply;
      }
    }

    // Trả về một câu trả lời mặc định nếu không có câu trả lời
    return "Xin lỗi, tôi không thể hiểu câu hỏi của bạn.";
  }


  Widget _buildMessage(Message message) {
    bool isUser = message.isMe;

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0), // Khoảng cách từ rìa
        padding: EdgeInsets.all(10.0),
        width: MediaQuery.of(context).size.width * 0.70, // Chỉ chiếm 75% màn hình
        decoration: BoxDecoration(
          color: isUser ? Colors.blueGrey :  const Color(0xFF7553F6),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              isUser ? "Bạn" : "ChatGPT",
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 5),
            Text(
              message.text,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'vni',
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: ClipRRect(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
          child: AppBar(
            backgroundColor: const Color(0xFF293C70),
            title: Text(
              'TRAVEL CHAT BOT',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(24.0),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
              ),
            ),
          ),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          child: Column(
            children: <Widget>[
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    return _buildMessage(_messages[index]);
                  },
                ),
              ),
              Divider(height: 1.0),
              Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: TextField(
                        controller: _textEditingController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(10.0),
                          hintText: 'Bạn muốn đi đâu...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: onSendMessage,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Message {
  final String text;
  final bool isMe;

  Message({required this.text, required this.isMe});}
