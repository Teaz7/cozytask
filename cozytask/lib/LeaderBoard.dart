import 'package:flutter/material.dart';
import 'package:cozytask/database/dbHelper.dart';
import 'package:cozytask/database/models/userLeaderboardModel.dart'; // ✅ Correct import

class LeaderBoardPage extends StatelessWidget {
  const LeaderBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF004562);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            // Header
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 8.0),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: primaryColor,
                        size: 28,
                      ),
                      onPressed: () => Navigator.maybePop(context),
                    ),
                  ),
                ),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      'LEADERBOARD',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Data Table
            Expanded(
              child: FutureBuilder<List<UserLeaderboard>>(
                // ✅ Correct type
                future: DBHelper.instance.fetchLeaderboardUsers(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  // Get users or pad with empty slots
                  final users = snapshot.data ?? [];
                  final topUsers = users.take(10).toList();

                  while (topUsers.length < 10) {
                    topUsers.add(
                      UserLeaderboard(userName: '——', userPoints: 0),
                    ); // ✅ Correct constructor
                  }

                  final topUserName = users.isNotEmpty
                      ? users.first.userName
                      : 'No players'; // ✅ Use userName

                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        _header(),
                        ...topUsers.asMap().entries.map(
                          (e) => _row(index: e.key, user: e.value),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            'Number 1: ${topUserName.isNotEmpty ? "${topUserName[0].toUpperCase()}${topUserName.substring(1)}" : "No players"}',
                            style: const TextStyle(
                              color: primaryColor,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header() => Container(
    decoration: const BoxDecoration(
      color: Color(0xFF004562),
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
    ),
    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
    child: const Row(
      children: [
        SizedBox(
          width: 40,
          child: Text(
            'Rank',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        Expanded(
          child: Text(
            'User',
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        SizedBox(
          width: 60,
          child: Text(
            'Points',
            textAlign: TextAlign.right,
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ],
    ),
  );

  Widget _row({required int index, required UserLeaderboard user}) {
    // ✅ Correct type
    final isTopThree = index < 3;
    Color rowColor = index == 0
        ? const Color(0xFFd8e8f4)
        : (index.isEven ? Colors.white : Colors.grey.shade50);

    final textStyle = TextStyle(
      fontWeight: isTopThree ? FontWeight.w900 : FontWeight.normal,
      color: isTopThree ? const Color(0xFF004562) : Colors.black,
      fontSize: isTopThree ? 15 : 14,
    );

    return Column(
      children: [
        Container(
          color: rowColor,
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              SizedBox(
                width: 40,
                child: Center(child: Text('${index + 1}', style: textStyle)),
              ),
              Expanded(
                child: Text(
                  user.userName,
                  textAlign: TextAlign.center,
                  style: textStyle,
                ),
              ), // ✅ Use userName
              SizedBox(
                width: 60,
                child: Text(
                  '${user.userPoints}',
                  textAlign: TextAlign.right,
                  style: textStyle,
                ),
              ), // ✅ Use userPoints
            ],
          ),
        ),
        if (index != 0) Divider(height: 1, color: Colors.grey.shade300),
      ],
    );
  }
}
