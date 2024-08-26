import 'package:state_management/utils/contants/app_enums.dart';

class Message {
  final String? senderId;
  final String? recieverid;
  final String? text;
  final MessageEnum? type;
  final DateTime? timeSent;
  final String? messageId;
  final bool? isSeen;
  final String? repliedMessage;
  final String? repliedTo;
  final MessageEnum? repliedMessageType;

  Message({
    this.senderId,
    this.recieverid,
    this.text,
    this.type,
    this.timeSent,
    this.messageId,
    this.isSeen,
    this.repliedMessage,
    this.repliedTo,
    this.repliedMessageType,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'recieverid': recieverid,
      'text': text,
      'type': type!.type,
      'timeSent': timeSent!.millisecondsSinceEpoch,
      'messageId': messageId,
      'isSeen': isSeen,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderId: map['senderId'] ?? '',
      recieverid: map['recieverid'] ?? '',
      text: map['text'] ?? '',
      type: (map['type'] as String).toEnum(),
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent'] ?? ""),
      messageId: map['messageId'] ?? '',
      isSeen: map['isSeen'] ?? false,
      // repliedMessage: map['repliedMessage'] ?? '',
      // repliedTo: map['repliedTo'] ?? '',
      // repliedMessageType: (map['repliedMessageType'] as String).toEnum(),
    );
  }
}
