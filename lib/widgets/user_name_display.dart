import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/global_providers.dart';

class UserNameDisplay extends ConsumerStatefulWidget {
  const UserNameDisplay({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserNameDisplayState();
}

class _UserNameDisplayState extends ConsumerState<UserNameDisplay> {
  @override
  Widget build(BuildContext context) {
    return Text(
      "${ref.watch(userDetailsProvider).userDetails!.user!.displayName}",
      style: Theme.of(context).textTheme.displayLarge?.copyWith(
            fontWeight: FontWeight.w900,
            fontSize: 60,
          ),
    );
  }
}
