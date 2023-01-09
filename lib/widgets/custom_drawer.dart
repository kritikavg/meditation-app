import 'package:fit_memoir/constants.dart';
import 'package:fit_memoir/providers/global_providers.dart';
import 'package:fit_memoir/screens/login_screen.dart';
import 'package:fit_memoir/widgets/user_name_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CustomDrawer extends ConsumerStatefulWidget {
  const CustomDrawer({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends ConsumerState<CustomDrawer> {
  var calenderCtrl = CalendarController();
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return SizedBox(
      width: height * 0.4,
      child: Material(
        color: cardColor,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CircleAvatar(
                backgroundColor: kBlueColor,
                radius: 100,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlutterLogo(
                    size: 40,
                  ),
                ),
              ),
            ),
            const UserNameDisplay(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SfCalendar(
                controller: calenderCtrl,
                view: CalendarView.month,
                backgroundColor: buttonColor,
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.06,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                    ),
                    onPressed: () {
                      ref.read(userDetailsProvider).logout();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Logout",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 21,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
