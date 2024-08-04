import 'package:chat_bot_app/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = [];

  void _sendMessage() async {
    final message = _controller.text;
    if (message.isNotEmpty) {
      setState(() {
        _messages.add('You: $message');
        _controller.clear();
      });

      try {
        final response = await getChatbotResponse(message);
        setState(() {
          _messages.add('Bot: $response');
        });
      } catch (e) {
        setState(() {
          _messages.add('Bot: Error occurred');
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //设置状态栏颜色为随机

      //添加一个侧滑菜单
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('GLM-4 Chatbot',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
              ),
            ),
            //显示一张网络图片
            InkWell(
                //点击后用默认浏览器打开网页链接
                onTap: () async {
                  //打开网页链接
                  const url =
                      'https://space.bilibili.com/1834448890'; // 这里替换成你需要的网页链接
                  launchUrl(
                    Uri.parse(url),
                    mode: LaunchMode.externalApplication,
                  );
                },
                child: ListTile(
                  leading: Image.network(
                    'https://android-artworks.25pp.com/fs08/2021/04/15/0/110_a1c6eb62a7b1139bee62358a2f0ebf02_con_130x130.png',
                    fit: BoxFit.cover,
                  ),
                  title: Text('关注up',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                )),
            //显示一张网络图片
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('GLM-4 Chatbot',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            )),
        backgroundColor: Colors.blueAccent,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUserMessage = message.startsWith('You:');
                return Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  alignment: isUserMessage
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: ConstrainedBox(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.7),
                      child: Card(
                        //长按文字复制

                        // elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: isUserMessage
                            ? Colors.blueAccent
                            : Colors.grey[200],
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: InkWell(
                            onLongPress: () {
                              Clipboard.setData(ClipboardData(text: message));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('已复制到剪贴板'),
                                ),
                              );
                            },
                            child: Text(
                              message,
                              style: TextStyle(
                                  color: isUserMessage
                                      ? Colors.white
                                      : Colors.black87),
                            ),
                          ),
                        ),
                      )),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    //回车发送消息
                    onSubmitted: (value) {
                      _sendMessage();
                    },
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.blue, width: 2),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    ),
                  ),
                ),
                IconButton(
                  //编辑框中有文字时图标为蓝色，没有文字时图标为灰色
                  icon: _controller.text.isNotEmpty
                      ? Icon(Icons.send, color: Colors.blue)
                      : Icon(Icons.send, color: Colors.grey),

                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
