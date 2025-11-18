import 'package:cozytask/components/backbutton.dart';
import 'package:flutter/material.dart';

void main() => runApp(const ViewTaskPage());

/* -------------------------------------------------- */
/*  App shell                                         */
/* -------------------------------------------------- */
class ViewTaskPage extends StatelessWidget {
  const ViewTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
        fontFamily: 'GillSansMT',
      ),
      home: const Scaffold(
        body: Center(
          child: ViewTask()
        )
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

/* -------------------------------------------------- */
/*  View-Task page                                    */
/* -------------------------------------------------- */
class ViewTask extends StatefulWidget {
  const ViewTask({super.key});

  @override
  State<ViewTask> createState() => _ViewTaskState();
}

class _ViewTaskState extends State<ViewTask> {
  /* ---------- dates ---------- */
  DateTime _startDate = DateTime(2025, 9, 1);
  DateTime _endDate = DateTime(2025, 9, 21);

  /* ---------- picker ---------- */
  Future<void> _pickDate(bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isStart ? _startDate : _endDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null)
      setState(() => isStart ? _startDate = picked : _endDate = picked);
  }

  /* ---------- UI ---------- */
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        /* ---- back arrow ---- */
        CustomBackButton(),

        const SizedBox(height: 10),

        /* ---- circle ---- */
        Center(
          child: CirclePercent(
            percent: 0.75,
            radius: 85,
            ringColor: const Color(0xFF004562),
            ringWidth: 25,
          ),
        ),

        /* ---- title ---- */
        Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 10),
          child: Text(
            '  App Dev Presentation',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
              color: Color(0xFF004562),
            ),
          ),
        ),

        /* ---- priority / status ---- */
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.check_circle, color: Color(0xFF004562), size: 30),
            Text(
              'Priority',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            const SizedBox(width: 20),
            Text(
              'Status:',
              style: TextStyle(fontSize: 16, color: Colors.black),
            ),
            Text(
              'Unfinished',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        /* ---- description label ---- */
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              'Description',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),
        const SizedBox(height: 2),

        /* ---- description box ---- */
        Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 360),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFD8E8F5),
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: const Text(
                'Prepare slides and practice the presentation for the app development project.',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 14, color: Colors.black),
              ),
            ),
          ),
        ),
        const SizedBox(height: 2),

        /* ---- date labels ---- */
        Row(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 25, top: 10),
                child: Text(
                  'Start Date:',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 150),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 0, top: 10),
                child: Text(
                  'End Date:',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
            ),
          ],
        ),

        /* ---- date chips ---- */
        Row(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 25, top: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFD8E8F5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: InkWell(
                    onTap: () => _pickDate(true),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${_startDate.year}-${_startDate.month.toString().padLeft(2, '0')}-${_startDate.day.toString().padLeft(2, '0')}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Color(0xFF004562),
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 95),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 0, top: 10),
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFD8E8F5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: InkWell(
                    onTap: () => _pickDate(false),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${_endDate.year}-${_endDate.month.toString().padLeft(2, '0')}-${_endDate.day.toString().padLeft(2, '0')}',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: Color(0xFF004562),
                          size: 20,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        /* -------------------------------------------------- */
        /*  SUB-TASKS  (only part changed)                    */
        /* -------------------------------------------------- */
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 25),
            child: Text(
              'Subtasks',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
        ),

        /* ---- bounded sub-task list ---- */
        SizedBox(
          height: 100, // adjustable
          child: ListView(
            padding: const EdgeInsets.only(top: 8, left: 20),
            children: [
              _subTaskRow('Create presentation slides'),
              _subTaskRow('Practice the pitch'),
              _subTaskRow('Add speaker notes'),
            ],
          ),
        ),

        /* ---- add sub-task ---- */
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: SizedBox(
                width: 315, // ← adjust this to your desired width
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFFD8E8F5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('Add Subtask..........'),
                ),
              ),
            ),
            const Icon(Icons.add_box, color: Color(0xFF004562), size: 50),
          ],
        ),

        const SizedBox(height: 35),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF004562),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            'MARK AS DONE',
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  /* -------------------------------------------------- */
  /*  sub-task row helper  (inside State)               */
  /* -------------------------------------------------- */
  Widget _subTaskRow(String text) => Padding(
    padding: const EdgeInsets.only(left: 25, bottom: 8),
    child: Row(
      children: [
        const Icon(Icons.square_rounded, color: Color(0xFF004562)),
        const SizedBox(width: 10),
        Text(text, style: const TextStyle(fontSize: 14, color: Colors.black)),
      ],
    ),
  );
}

/* -------------------------------------------------- */
/*  Circle painter (unchanged)                        */
/* -------------------------------------------------- */
class CirclePercent extends StatelessWidget {
  final double percent, radius, ringWidth;
  final Color ringColor;
  final TextStyle? textStyle;
  const CirclePercent({
    super.key,
    required this.percent,
    this.radius = 50,
    this.ringWidth = 8,
    this.ringColor = Colors.blue,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: radius * 2,
      height: radius * 2,
      child: CustomPaint(
        painter: _RingPainter(
          percent: percent,
          color: ringColor,
          strokeWidth: ringWidth,
        ),
        child: Center(
          child: Text(
            '${(percent * 100).round()}%',
            style:
                textStyle ??
                TextStyle(
                  fontSize: radius * 0.35,
                  fontWeight: FontWeight.bold,
                  color: ringColor,
                ),
          ),
        ),
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double percent, strokeWidth;
  final Color color;
  _RingPainter({
    required this.percent,
    required this.color,
    required this.strokeWidth,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final c = Offset(size.width / 2, size.height / 2);
    final r = (size.shortestSide - strokeWidth) / 2;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    paint.color = color.withOpacity(.2);
    canvas.drawCircle(c, r, paint);
    paint.color = color;
    canvas.drawArc(
      Rect.fromCircle(center: c, radius: r),
      -90 * 0.0174533,
      360 * percent * 0.0174533,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
