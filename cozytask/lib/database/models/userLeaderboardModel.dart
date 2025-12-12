class UserLeaderboard {
  final int? userId;
  final String userName;
  final int userPoints;

  UserLeaderboard({
    this.userId,
    required this.userName,
    required this.userPoints,
  });

  // Factory constructor to create from database map
  // Adjust column names to match your actual database schema
  factory UserLeaderboard.fromMap(Map<String, dynamic> map) {
    return UserLeaderboard(
      userId: map['USER_ID'] ?? map['id'], // Try both common patterns
      userName: map['USER_Name'] ?? map['name'] ?? 'Unknown',
      userPoints: map['USER_Points'] ?? map['points'] ?? 0,
    );
  }

  // Convert back to map for database operations
  Map<String, dynamic> toMap() {
    return {
      'USER_ID': userId,
      'USER_Name': userName,
      'USER_Points': userPoints,
    };
  }

  // Helper for display (capitalize first letter)
  String get displayName {
    if (userName.isEmpty || userName == '——') return userName;
    return userName[0].toUpperCase() + userName.substring(1);
  }
}
