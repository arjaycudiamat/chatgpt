import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final String botLogoAsset = 'Assets/Images/chatgpt_logo.png';
  final TextEditingController _inputController = TextEditingController();
  final List<String> _conversation = [];
  final ScrollController _scrollController = ScrollController();
  bool isLoading = false; // Variable for loading state

  Future<void> _sendUserInput(String userInput) async {
    try {
      setState(() {
        isLoading = true; // Set isLoading to true before sending the request
      });

      _conversation.add('User: $userInput'); // Add user message to the conversation

      if (userInput.toLowerCase() == 'clear') {
        setState(() {
          _conversation.clear();
        });
      } else {
        final response = await http.post(
          Uri.parse('http://10.0.2.2:8000/chat'), // Update the server URL if needed
          body: {'input': userInput},
        );

        if (response.statusCode == 200) {
          setState(() {
            _conversation.add('ChatGPT: ${response.body.trim()}');
          });
        }
      }

      Future.delayed(const Duration(milliseconds: 300), () {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      });
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        isLoading = false; // Set isLoading to false after the request
      });
    }
  }

  Widget _buildMessage(String message, bool isNewResponse) {
    IconData? icon;
    String text = message;
    bool isUserMessage = false;

    if (message.startsWith('User')) {
      icon = Icons.account_circle;
      text = message.substring(6);
      isUserMessage = true;
    } else if (message.startsWith('ChatGPT')) {
      icon = null;
      text = message.substring(9);
    } else {
      icon = Icons.account_box;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      child: ListTile(
        leading: icon != null
            ? CircleAvatar(
          backgroundColor: Colors.yellow,
          radius: 10.0,
          child: Icon(
            icon,
            size: 10.0,
            color: Colors.white,
          ),
        )
            : CircleAvatar(
          backgroundImage: AssetImage(botLogoAsset),
          radius: 10.0,
        ),
        title: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: icon != null ? Colors.blue : Colors.grey,
          ),
          padding: const EdgeInsets.all(8.0),
          child: isNewResponse && !isUserMessage
              ? Text(
            text,
            style: const TextStyle(
              fontSize: 12.0,
              color: Colors.white,
            ),
          )
              : Text(
            text,
            style: const TextStyle(
              fontSize: 12.0,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }



  @override
  void dispose() {
    _scrollController.dispose();
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50), // Adjust the height as needed
        child: AppBar(
          centerTitle: true,
          title: const Text("CARD MRI Memo's and Policies"),
          backgroundColor: const Color.fromARGB(255, 6, 184, 12),
        ),
      ),
      body: Container(
        color: const Color.fromARGB(58, 206, 180, 180), // Replace with your desired background color
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: _conversation.length,
                  itemBuilder: (context, index) {
                    final message = _conversation[index];
                    final isNewResponse = index == _conversation.length - 1; // Check if it's the last message

                    return _buildMessage(message, isNewResponse);
                  },
                ),
              ),
              if (isLoading)
                Container(
                  // Loading widget container with adjusted spacing
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0), // Adjust the margin as needed
                  child: const SizedBox(
                    width: 20.0, // Adjust the width of the loading widget
                    height: 20.0, // Adjust the height of the loading widget
                    child: CircularProgressIndicator(), // Choose the appropriate loading widget
                  ),
                ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.black.withOpacity(0.1)),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white10.withOpacity(1.0),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(15.0, 8.0, 15.0, 20.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          border: Border.all(color: const Color.fromARGB(255, 103, 33, 33)),
                          color: const Color.fromARGB(255, 241, 239, 239),
                        ),
                        child: TextField(
                          controller: _inputController,
                          minLines: 1, // Set the minimum number of lines
                          maxLines: null, // Allow unlimited lines
                          keyboardType: TextInputType.multiline, // Enable multiline input
                          onChanged: (value) {
                            // Update the height of the container and text field based on text length
                            setState(() {});
                          },
                          decoration: InputDecoration(
                            hintText: 'Type (Table of Contents) to view the titles',
                            hintStyle: const TextStyle(color: Colors.black),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.all(14.0),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.send),
                              onPressed: () {
                                final userInput = _inputController.text.trim();
                                if (userInput.isNotEmpty) {
                                  _inputController.clear();
                                  _sendUserInput(userInput);
                                }
                              },
                            ),
                          ),
                        ),
                      ),
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
