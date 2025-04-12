class JoinClubRequest {
  final int userId;
  final int clubId;
  final String reasonToJoin;

  JoinClubRequest({
    required this.userId,
    required this.clubId,
    required this.reasonToJoin,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'clubId': clubId,
      'reasonToJoin': reasonToJoin,
    };
  }
}
