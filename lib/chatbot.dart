import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:health_app/user_controller.dart';
import 'package:health_app/utils/constants/api_constants.dart';
import 'package:health_app/utils/constants/colors.dart';
import 'package:health_app/utils/helpers/helper_functions.dart';



class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}
class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _sc=ScrollController();
  final List<Map<String, String>> _messages = [];
  final controller = Get.put(UserController());
  Future<void> talkWithGemini (String message)
  async {
    setState(() {
      _messages.add({'user': message});
      _sc.jumpTo(_sc.position.maxScrollExtent+100);

    });

    final model= GenerativeModel(model: 'gemini-1.5-flash-latest', apiKey: tSecretAPIKey
    );
    final content = [Content.text(message)];
    final response = await model.generateContent(content);
    setState(() {
      _sc.jumpTo(_sc.position.maxScrollExtent+50);
      _messages.add({'bot': response.text!+""});

    });

  }
  @override
  void initState() {
    super.initState();
    // TODO: implement initState
    _messages.add({'bot': 'Hi ${controller.user.value.fullName}, How can I help you ?'});

  }



  Widget _buildMessageBubble(String message, bool isUserMessage) {
    return Align(
      alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isUserMessage ? Colors.blue : Colors.green,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomLeft: isUserMessage ? Radius.circular(16) : Radius.circular(0),
            bottomRight: isUserMessage ? Radius.circular(0) : Radius.circular(16),
          ),
        ),
        child:

        Text(
          message,
          style: Theme.of(context).textTheme.headlineSmall!.apply(color: Colors.white)

        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final darkMode = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(

        title: Text('Doc Assistant', style: GoogleFonts.poppins(fontSize: 20)),
        backgroundColor: darkMode?TColors.black:Colors.white,
        leading: IconButton(icon:Icon(Icons.navigate_before,color: darkMode?Colors.white:Colors.black ),onPressed: ()=>Get.back(),),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              color: darkMode?TColors.black:Colors.white,
              child: ListView.builder(

                controller: _sc,
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index];
                  final isUserMessage = message.containsKey('user');
                  return _buildMessageBubble(
                    isUserMessage ? message['user']! : message['bot']!,
                    isUserMessage,
                  );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.0),
                color: Colors.grey[200],
              ),

              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                        hintStyle: GoogleFonts.roboto(),
                        border: InputBorder.none,
                      ),
                      style: const TextStyle(color: Colors.black,fontSize: 16),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.send, color: Colors.blueAccent),
                    onPressed: () {
                      if (_controller.text.isNotEmpty) {
                        talkWithGemini(_controller.text);
                        _controller.clear();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
