import 'package:flutter/material.dart';

import '../../init/app_state/app_state.dart';
import '../../init/navigation/navigation_service.dart';
import '../../init/network/dio_manager.dart';

 mixin BaseCubit {
  BuildContext? context;
  DioManager dioManager = DioManager.instance;
  NavigationService navigation = NavigationService.instance;
  AppStateManager appStateManager = AppStateManager.instance;
  void setContext(BuildContext context);
  void init();
}
