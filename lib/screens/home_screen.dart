import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fit_memoir/models/excersise_model.dart';
import 'package:fit_memoir/providers/global_providers.dart';
import 'package:fit_memoir/providers/page_details_provider.dart';
import 'package:fit_memoir/screens/details_screen.dart';
import 'package:fit_memoir/screens/diet_screen.dart';
import 'package:fit_memoir/widgets/category_card.dart';
import 'package:fit_memoir/widgets/custom_drawer.dart';
import 'package:fit_memoir/widgets/user_greeting_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';
import '../widgets/bottom_nav_bar.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<ScaffoldState> key = GlobalKey();
    var size = MediaQuery.of(context)
        .size; //this gonna give us total height and with of our device
    return Scaffold(
      key: key,
      endDrawer: CustomDrawer(),
      bottomNavigationBar: BottomNavBar(),
      body: Stack(
        children: <Widget>[
          Container(
            // Here the height of the container is 45% of our total height
            height: size.height * .45,
            decoration: const BoxDecoration(
              color: Color(0xFFF5CEB8),
              image: DecorationImage(
                alignment: Alignment.centerLeft,
                image: AssetImage("assets/images/undraw_pilates_gpdb.png"),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: InkWell(
                      onTap: () {
                        key.currentState!.openEndDrawer();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 52,
                        width: 52,
                        decoration: BoxDecoration(
                          color: Color(0xFFF2BEA1),
                          shape: BoxShape.circle,
                        ),
                        child: SvgPicture.asset("assets/icons/menu.svg"),
                      ),
                    ),
                  ),
                  const UserGreetingDisplay(),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: ref.watch(bottomNavItemProvider).currentPage,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Center(
          child: Material(
            borderRadius: BorderRadius.circular(13),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 20,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.directions_walk,
                      size: 40,
                      color: buttonColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Total Steps",
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w900,
                        color: kActiveIconColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "5000",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        color: kBlueColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: AllExerciseGrid(),
        ),
      ],
    );
  }
}

class AllExerciseGrid extends ConsumerWidget {
  const AllExerciseGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<PageData> pageData = ref.read(pageDataProvider).pageData;
    Stream<QuerySnapshot<Map<String, dynamic>>> firebasedata = FirebaseFirestore
        .instance
        .collection("exercise_data")
        .snapshots(includeMetadataChanges: true);
    double height = MediaQuery.of(context).size.height;
    print(height);
    return StreamBuilder<QuerySnapshot>(
      stream: firebasedata,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        List<String> allAdminIds = [];
        List<ExcersiseModel> excerciseData = snapshot.data!.docs.map(
          (eachElement) {
            allAdminIds.add(eachElement.id);
            return ExcersiseModel.fromMap(
              eachElement.data() as Map<String, dynamic>,
            );
          },
        ).toList();

        print("data $excerciseData");
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: .85,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          itemCount: pageData.length,
          itemBuilder: (context, index) {
            return index == 0
                ? CategoryCard(
                    title: pageData[index].title,
                    svgSrc: pageData[index].image,
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DietScreen(
                            image: pageData[0].image,
                            pageData: pageData[0],
                          ),
                        ),
                      );
                    },
                  )
                : CategoryCard(
                    title: excerciseData[index - 1].title,
                    svgSrc: pageData[index].image,
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(
                            pageData: excerciseData[index - 1],
                            image: pageData[index].image,
                          ),
                        ),
                      );
                    },
                  );
          },
        );
      },
    );
  }
}
