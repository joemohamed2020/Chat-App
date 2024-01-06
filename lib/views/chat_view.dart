import 'package:chat_app/constants.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/widgets/chat_widget.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class ChatView extends StatefulWidget {
  ChatView({super.key});
  static String id = "ChatView";

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  CollectionReference messages = FirebaseFirestore.instance.collection(kMessagesCollection);
  ScrollController listViewController = ScrollController();
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: messages.orderBy(kCreatedAt).snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/scholar.png", height: 50,),
                  const Text("Chat",),
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(itemCount: snapshot.data!.docs.length,
                  controller: listViewController,
                  itemBuilder: (context, index) {
                    return ChatWidget(text: snapshot.data!.docs[index]['message']);
                  }),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  height: 80,
                  child: TextField(
                    controller: textEditingController,
                    decoration: InputDecoration(
                        hintText: "Message",
                        suffixIcon: IconButton(icon: const Icon(Icons.send),
                          color: kPrimaryColor,
                          onPressed: () {
                            messages.add({
                              kMessage: textEditingController.text,
                              kCreatedAt : DateTime.now()
                            });
                            textEditingController.clear();
                            listViewController.animateTo(listViewController.position.maxScrollExtent, duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
                          },),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: kPrimaryColor,),
                            borderRadius: BorderRadius.circular(16)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: kPrimaryColor,),
                            borderRadius: BorderRadius.circular(16))
                    ),
                  ),
                )
              ],
            ),

          );
        }
        else{
          return const Scaffold(body: Center(child: CircularProgressIndicator()));
        }
      }
    );
  }
}
sendMessage(){

}
