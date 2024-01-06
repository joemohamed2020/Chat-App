import 'package:chat_app/constants.dart';

class MessageModel{
  String message;
  MessageModel({required this.message});
  factory MessageModel.fronJSON(Map<String,dynamic>map){
    return MessageModel(message: map[kMessage]);
  }
}