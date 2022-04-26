import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:notifications/notification.dart';
import 'package:notifications/otherPage.dart';
import 'package:notifications/utils/color_utils.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Notifications'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final FlutterLocalNotificationsPlugin localNotifications =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();

    final AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/icon');

    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid,
            iOS: initializationSettingsIOS);

    localNotifications.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async => await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => otherPage(payload: payload)),
      );

  int id = 0;

  int _incrementCounter() {
    setState(() {
      id++;
    });
    return id;
  }

  @override
  Widget build(BuildContext context) {
    final elevatedButtonStyle = ElevatedButton.styleFrom(
      primary: Color.fromRGBO(31, 122, 140, 5),
      onPrimary: Color.fromRGBO(255, 255, 255, 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
    );

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
          hexStringToColor("ffc362"),
          hexStringToColor("ffab62"),
          hexStringToColor("ff9262")
        ], begin: Alignment.topCenter, end: Alignment.center)),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Flutter Local Notifications',
                style: TextStyle(
                  fontSize: 35,
                ),
                textAlign: TextAlign.center,
              ),
              Divider(
                height: 15,
              ),
              ElevatedButton.icon(
                style: elevatedButtonStyle,
                onPressed: () {
                  Notifications().showNotification(
                      localNotifications,
                      _incrementCounter(),
                      "show - " + id.toString(),
                      "Show a notification with an optional payload that will be passed back to the app when a notification is tapped.",
                      "show");
                },
                label: const Text('Make a show notification'),
                icon: const Icon(Icons.notifications_rounded),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                style: elevatedButtonStyle,
                onPressed: () {
                  Notifications().cancelIdNotifications(2);
                },
                label: const Text('Cancel Id notifications.'),
                icon: const Icon(Icons.notifications_off),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                style: elevatedButtonStyle,
                onPressed: () {
                  Notifications().cancelAllNotifications();
                },
                label: const Text('Cancel All notifications'),
                icon: const Icon(Icons.notifications_off),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                style: elevatedButtonStyle,
                onPressed: () {
                  Notifications().scheduleNotification(
                      localNotifications,
                      _incrementCounter(),
                      "schedule - " + id.toString(),
                      "Schedules a notification to be shown at the specified date and time.",
                      DateTime.now(),
                      'schedule');
                },
                label: const Text('Make a schedule notification'),
                icon: const Icon(Icons.notifications_rounded),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                style: elevatedButtonStyle,
                onPressed: () {
                  Notifications().zonedScheduleNotification(
                      localNotifications,
                      _incrementCounter(),
                      "zoned Schedule - " + id.toString(),
                      "Schedules a notification to be shown at the specified date and time relative to a specific time zone.",
                      1,
                      'zoned Schedule');
                },
                label: const Text('Make a zonedSchedule notification'),
                icon: const Icon(Icons.notifications_rounded),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                style: elevatedButtonStyle,
                onPressed: () {
                  Notifications().periodicallyShowNotification(
                      localNotifications,
                      _incrementCounter(),
                      'periodically Show - ' + id.toString(),
                      'Periodically show a notification using the specified interval.',
                      RepeatInterval.everyMinute,
                      'periodically Show');
                },
                label: const Text('Make a periodicallyShow notification'),
                icon: const Icon(Icons.notifications_rounded),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                style: elevatedButtonStyle,
                onPressed: () {
                  Notifications().showDailyAtTimeNotification(
                      localNotifications,
                      _incrementCounter(),
                      'show Daily At Time - ' + id.toString(),
                      'Shows a notification on a daily interval at the specified time.',
                      Time(20, 27, 0),
                      'show Daily At Time');
                },
                label: const Text('Make a showDailyAtTime notification'),
                icon: const Icon(Icons.notifications_rounded),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton.icon(
                style: elevatedButtonStyle,
                onPressed: () {
                  Notifications().showWeeklyAtDayAndTimeNotification(
                      localNotifications,
                      _incrementCounter(),
                      'show Weekly At Day And Time - ' + id.toString(),
                      'Shows a notification on weekly interval at the specified day and time.',
                      Day.monday,
                      Time(20, 27, 0),
                      'show Weekly At Day And Time');
                },
                label: const Text('Make a showWeeklyAtDayAndTime notification'),
                icon: const Icon(Icons.notifications_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
