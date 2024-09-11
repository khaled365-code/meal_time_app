import 'package:bloc/bloc.dart';
import 'package:chef_app/core/database/cache/cache_helper.dart';
import 'package:chef_app/core/utilis/services/local_notifications_service.dart';
import 'package:chef_app/core/utilis/services/push_notifications_service.dart';
import 'package:meta/meta.dart';

import '../../../../../core/database/api/api_keys.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());





  bool isDarkModeActive=false;

  Future<void> onDarkModeSwitched({required bool value}) async
  {
    if(isDarkModeActive==value)
      {
        return;
      }
    else
      {
        isDarkModeActive=value;
        await CacheHelper().saveData(key: ApiKeys.darkModeIsActive, value: value);
        emit(DarkModeSwitchedState());
      }

  }



  bool locationIsActive=false;

  Future<void> onLocationSwitched({required bool value}) async
  {
      locationIsActive=value;
      await CacheHelper().saveData(key: ApiKeys.locationIsActive, value: value);
      emit(LocationSwitchedState());


  }


  bool notificationIsActive=true;

  Future<void> onNotificationSwitched({required bool value}) async
  {
        notificationIsActive=value;
        if(notificationIsActive==false)
          {
            await Future.wait([
             LocalNotificationsService.cancelAllNotifications(),
             PushNotificationsService.disablePushNotifications(),
             PushNotificationsService.unSubscribeToTopicFun(),
            ]);
          }
        else
          {
            await Future.wait([
             PushNotificationsService.subscribeToTopicFun(),
              PushNotificationsService.getDeviceToken()
            ]);

          }
        await CacheHelper().saveData(key: ApiKeys.notificationIsActive, value: value);
        emit(NotificationSwitchedState());
  }


}
