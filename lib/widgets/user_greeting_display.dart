import 'package:fit_memoir/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/global_providers.dart';

class UserGreetingDisplay extends ConsumerStatefulWidget {
  const UserGreetingDisplay({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserGreetingDisplayState();
}

class _UserGreetingDisplayState extends ConsumerState<UserGreetingDisplay> {
  @override
  Widget build(BuildContext context) {
    return Text(
      "${CustomUtils.greetingText()} \n${ref.watch(userDetailsProvider).userDetails!.user!.displayName}",
      style: Theme.of(context).textTheme.displayLarge?.copyWith(
            fontWeight: FontWeight.w900,
            fontSize: 60,
          ),
    );
  }
}
