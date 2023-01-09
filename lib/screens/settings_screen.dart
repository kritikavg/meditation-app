import 'package:fit_memoir/constants.dart';
import 'package:fit_memoir/providers/global_providers.dart';
import 'package:fit_memoir/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Account Details".toUpperCase(),
                  style: TextStyle(
                    letterSpacing: 1,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Cairo",
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: Card(
                  color: cardColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 20,
                    ),
                    child: Center(
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              ref
                                  .watch(userDetailsProvider)
                                  .userDetails!
                                  .user!
                                  .displayName
                                  .toString(),
                              style: TextStyle(
                                letterSpacing: 1,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: "Cairo",
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              TextEditingController _controller =
                                  TextEditingController(
                                text: ref
                                    .read(userDetailsProvider)
                                    .userDetails!
                                    .user!
                                    .displayName,
                              );

                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Change User Name"),
                                    content: StatefulBuilder(
                                      builder: (context, setState) {
                                        return Consumer(
                                          builder: (context, ref, child) {
                                            return Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                CustomTextField(
                                                  textfieldChild: TextField(
                                                    controller: _controller,
                                                    decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                    ),
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text(
                                                        "Cancel",
                                                      ),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        ref
                                                            .read(
                                                                userDetailsProvider)
                                                            .changeUserName(
                                                              _controller.text,
                                                            )
                                                            .then(
                                                          (value) {
                                                            Navigator.pop(
                                                                context);
                                                            return value;
                                                          },
                                                        );
                                                      },
                                                      child: Text(
                                                        "Ok",
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                            child: CircleAvatar(
                              backgroundColor: kBlueColor,
                              child: Icon(
                                Icons.edit,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Card(
                  color: cardColor,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 20,
                    ),
                    child: Text(
                      ref
                          .watch(userDetailsProvider)
                          .userDetails!
                          .user!
                          .email
                          .toString(),
                      style: TextStyle(
                        letterSpacing: 1,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Cairo",
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
