import 'package:fit_memoir/providers/main_page_data.dart';
import 'package:fit_memoir/providers/page_details_provider.dart';
import 'package:fit_memoir/providers/user_details_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userDetailsProvider = ChangeNotifierProvider<UserDetailsProvider>((ref) {
  return UserDetailsProvider();
});

final pageDataProvider = ChangeNotifierProvider<PageDetailsProvider>((ref) {
  return PageDetailsProvider();
});

final bottomNavItemProvider = ChangeNotifierProvider<MainPageData>((ref) {
  return MainPageData();
});
