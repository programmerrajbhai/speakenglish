class ConversationTurn {
  final String id;
  final int tutorExampleIndex;
  final int correctReplyIndex;
  final List<int> replyOptionIndexes;

  const ConversationTurn({
    required this.id,
    required this.tutorExampleIndex,
    required this.correctReplyIndex,
    required this.replyOptionIndexes,
  });
}