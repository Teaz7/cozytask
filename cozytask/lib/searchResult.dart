import 'package:cozytask/components/backButton.dart';
import 'package:cozytask/components/taskWidget.dart';
import 'package:cozytask/database/dbHelper.dart';
import 'package:cozytask/database/models/taskModel.dart';
import 'package:flutter/material.dart';

class SearchResultPage extends StatelessWidget {
  final int? userid;
  final String search;
  const SearchResultPage({super.key, required this.userid, required this.search});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
        fontFamily: 'GillSansMT',
      ),
      home: Scaffold(body: Center(child: SearchResult(userid: userid, search: search,))),
      debugShowCheckedModeBanner: false,
    );
  }
}

enum SingingCharacter {Deadline, Name, Last_Updated, Date}

class SearchResult extends StatefulWidget {
  final int? userid;
  final String search;
  const SearchResult({super.key, required this.userid, required this.search});

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {

  String _selectedSort = 'Deadline';
  String _selectedOrder = 'Ascending';
  String _selectedStatus = 'Mark As Done';
  String _selectedPriority = '1';
  
  List<Task> tasklist = [];

  void _openSort() => showDialog(
    context: context,
    builder: (_) => Dialog(
      backgroundColor: Colors.transparent,
      child: StatefulBuilder(
        builder: (context, setDialogState) {
          return _sortOverlay(setDialogState);
        },
      ),
    )
  );

  Widget _sortRadio (String label, String value, StateSetter setDialogState) => InkWell(
    onTap: () {
      setDialogState(() {
        _selectedSort = value;
      });
    },
    child: Container(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      child: Row(
        children: [
          SizedBox(width: 20),

          Container(
            padding: EdgeInsets.only(right: 10),
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.black,
                width: 2
              ),
              color: _selectedSort == value
                ? Colors.black : Colors.white
            ),
            child: _selectedSort == value
              ? Icon(
                Icons.circle,
                size: 12,
                color: Colors.black,
              ) : null,
          ),

          SizedBox(width: 30),

          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Color(0XFF004463),
            ),
          )
        ],
      ),
    ),
  );

  Widget _priorityRadio (String label, String value, StateSetter setDialogState) => InkWell(
    onTap: () {
      setDialogState(() {
        _selectedPriority = value;
      });
    },
    child: Container(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      child: Row(
        children: [
          SizedBox(width: 10),

          Container(
            padding: EdgeInsets.only(right: 10),
            width: 15,
            height: 15,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: Color(0XFF004463),
                width: 2
              ),
              color: _selectedPriority == value
                ? Color(0XFF004463) : Colors.white
            ),
            child: _selectedPriority == value
              ? Icon(
                Icons.circle,
                size: 12,
                color: Color(0XFF004463),
              ) : null,
          ),

          SizedBox(width: 10),

          Text(
            label,
            style: TextStyle(
              fontSize: 16,
            ),
          ),

          SizedBox(width: 10),
        ],
      ),
    ),
  );

  Widget _sortOverlay(StateSetter setDialogState) => Container(
    width: 300,
    height: 600,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20)
    ),
    child: Column(
      children: <Widget>[
        SizedBox(height: 30),

        Text(
          'SORT & FILTER',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0XFF004463),
          ),
        ),

        Container(
          padding: EdgeInsets.only(top: 10),
          width: 250,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Sort by:',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0XFF004463),
                ),
              ),

              _sortRadio('Deadline', 'Deadline', setDialogState),
              _sortRadio('Name', 'Name', setDialogState),
              _sortRadio('Last Updated', 'Last Updated', setDialogState),
              _sortRadio('Date', 'Date', setDialogState)
            ],
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                setDialogState(() {
                  _selectedOrder = 'Ascending';
                });
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(130, 30),
                backgroundColor: _selectedOrder == 'Ascending' ? Color(0XFF004463) : Color(0XFF898989),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                )
              ),
              child: const Text(
                'Ascending',
                style: TextStyle(
                  fontSize: 16
                ),
              ),
            ),

            SizedBox(width: 10),

            ElevatedButton(
              onPressed: () {
                setDialogState(() {
                  _selectedOrder = 'Descending';
                });
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(130, 30),
                backgroundColor: _selectedOrder == 'Descending' ? Color(0XFF004463) : Color(0XFF898989),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                )
              ),
              child: const Text(
                'Descending',
                style: TextStyle(
                  fontSize: 16
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 15),

        Container(
          width: 280,
          height: 1.5,
          decoration: BoxDecoration(
            color: Color(0XFF004463),
            borderRadius: BorderRadius.circular(10)
          ),
        ),

        SizedBox(height: 10),

        Text(
          'Status',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),

        SizedBox(height: 5),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                setDialogState(() {
                  _selectedStatus = 'Mark As Done';
                });
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(130, 30),
                backgroundColor: _selectedStatus == 'Mark As Done' ? Color(0XFF004463) : Color(0XFF898989),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                )
              ),
              child: const Text(
                'Mark As Done',
                style: TextStyle(
                  fontSize: 16
                ),
              ),
            ),

            SizedBox(width: 7),

            ElevatedButton(
              onPressed: () {
                setDialogState(() {
                  _selectedStatus = 'Unfinished';
                });
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(100, 30),
                backgroundColor: _selectedStatus == 'Unfinished' ? Color(0XFF004463) : Color(0XFF898989),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                )
              ),
              child: const Text(
                'Unfinished',
                style: TextStyle(
                  fontSize: 16
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 15),

        Container(
          width: 280,
          height: 1.5,
          decoration: BoxDecoration(
            color: Color(0XFF004463),
            borderRadius: BorderRadius.circular(10)
          ),
        ),

        SizedBox(height: 10),

        Text(
          'Priority Level',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        ),

        SizedBox(height: 10),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _priorityRadio('1', '1', setDialogState),
            _priorityRadio('2', '2', setDialogState),
            _priorityRadio('3', '3', setDialogState),
            _priorityRadio('4', '4', setDialogState),
            _priorityRadio('5', '5', setDialogState),
          ],
        ),

        SizedBox(height: 40),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {

              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(130, 30),
                backgroundColor: Color(0XFF004463),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                )
              ),
              child: const Text(
                'Apply',
                style: TextStyle(
                  fontSize: 18
                ),
              ),
            ),

            SizedBox(width: 10),

            ElevatedButton(
              onPressed: () {

              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size(130, 30),
                backgroundColor: Color(0XFF898989),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                )
              ),
              child: const Text(
                'Clear',
                style: TextStyle(
                  fontSize: 18
                ),
              ),
            ),
          ],
        )
      ],
    ),
  );

  @override
  void initState() {
    super.initState();
    loadTasks();
  }
  
  Future<void> loadTasks() async {
    final data = await DBHelper.instance.readAllTask(widget.userid);
    setState(() {
      tasklist = data;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        CustomBackButton(userid: widget.userid,),

        Container(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          width: 320,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Search Results',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Color(0XFF004463),
                ),
              ),

              GestureDetector(
                onTap: _openSort,
                behavior: HitTestBehavior.translucent,
                child: Container(
                  height: 25,
                  width: 55,
                  decoration: BoxDecoration(
                    color: Color(0XFF004463),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Image.asset(
                    'assets/icon/Filter.png',
                    width: 25,
                  ),
                ),
              )
            ],
          ),
        ),

        TaskWidget(
          tasklist: tasklist,
          userid: widget.userid,
          dashboard: true,
        )
      ],
    );
  }
}