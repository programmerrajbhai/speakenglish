import '../models/conversation_turn.dart';

class ConversationData {
  ConversationData._();

  static const List<ConversationTurn> turns = [
    ConversationTurn(
      id: 'conversation_01',
      tutorExampleIndex: 0,
      correctReplyIndex: 0,
      replyOptionIndexes: [0, 4, 12],
    ),
    ConversationTurn(
      id: 'conversation_02',
      tutorExampleIndex: 5,
      correctReplyIndex: 6,
      replyOptionIndexes: [6, 8, 11],
    ),
    ConversationTurn(
      id: 'conversation_03',
      tutorExampleIndex: 7,
      correctReplyIndex: 8,
      replyOptionIndexes: [8, 6, 11],
    ),
    ConversationTurn(
      id: 'conversation_04',
      tutorExampleIndex: 10,
      correctReplyIndex: 11,
      replyOptionIndexes: [11, 8, 13],
    ),
    ConversationTurn(
      id: 'conversation_05',
      tutorExampleIndex: 9,
      correctReplyIndex: 12,
      replyOptionIndexes: [12, 13, 14],
    ),
  ];
}