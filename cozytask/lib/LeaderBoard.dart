import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: LeaderBoardPage()));

class Player {
  final String id;
  final String name;
  final int score;
  const Player(this.id, this.name, this.score);
}

class LeaderboardRepo {
  static Future<List<Player>> fetchLeaderboard() async {
    await Future.delayed(const Duration(milliseconds: 400));

    final raw = <Player>[
      Player('u4', 'tea', 1376),
      Player('u2', 'zam', 1221),
      Player('u7', 'jims', 1092),
      Player('u5', 'luris', 890),
      Player('u1', 'mikil', 670),
      Player('u6', 'jistir', 548),
      Player('u3', 'arjey', 123),
      Player('u3', 'arjey', 123),
      Player('u3', 'arjey', 123),
      Player('u3', 'arjey', 123),
      Player('u6', 'jistir', 548),
    ]..sort((a, b) => b.score.compareTo(a.score));

    final top10 = raw.take(10).toList();

    while (top10.length < 10) {
      top10.add(Player('', '——', 0));
    }

    return top10;
  }
}

class LeaderBoardPage extends StatelessWidget {
  const LeaderBoardPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF004562);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            // header bar -------------------------------------------------------
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Arrow: ALIGNED LEFT
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

                // 2. Title: CENTERED
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

            // table + banner ---------------------------------------------------
            Expanded(
              child: FutureBuilder<List<Player>>(
                future: LeaderboardRepo.fetchLeaderboard(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No data'));
                  }

                  final players = snapshot.data!;
                  final topPlayerName = players.first.name;

                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        _header(),

                        ...players.asMap().entries.map(
                          (e) => _row(index: e.key, player: e.value),
                        ),

                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Text(
                            'Number 1: ${topPlayerName[0].toUpperCase()}${topPlayerName.substring(1)}',
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

  // --- UPDATED ROW LOGIC ---
  Widget _row({required int index, required Player player}) {
    final isTopThree = index < 3;
    // 1. Determine Background Color
    Color rowColor;
    if (index == 0) {
      // Rank 1 gets the special light blue color
      rowColor = const Color(0xFFd8e8f4);
    } else {
      // The rest use zebra striping
      rowColor = index.isEven ? Colors.white : Colors.grey.shade50;
    }

    final textStyle = TextStyle(
      fontWeight: isTopThree ? FontWeight.w900 : FontWeight.normal,
      color: isTopThree ? const Color(0xFF004562) : Colors.black,
      fontSize: isTopThree ? 15 : 14,
    );

    return Column(
      children: [
        Container(
          color: rowColor, // <--- Applied here
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 40,
                child: Center(child: Text('${index + 1}', style: textStyle)),
              ),
              Expanded(
                child: Text(
                  player.name,
                  textAlign: TextAlign.center,
                  style: textStyle,
                ),
              ),
              SizedBox(
                width: 60,
                child: Text(
                  '${player.score}',
                  textAlign: TextAlign.right,
                  style: textStyle,
                ),
              ),
            ],
          ),
        ),
        // Only show divider if it's NOT the special rank 1 row,
        // to make the color block look cleaner.
        if (index != 0) Divider(height: 1, color: Colors.grey.shade300),
      ],
    );
  }
}
