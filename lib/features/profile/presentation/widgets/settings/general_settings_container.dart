import 'package:chef_app/features/profile/presentation/cubits/settings_cubit/settings_cubit.dart';
import 'package:chef_app/features/profile/presentation/widgets/settings/app_updates_list_tile.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utilis/app_colors.dart';
import '../../../../../core/utilis/app_text_styles.dart';
import '../../../../../core/widgets/space_widget.dart';
import 'bill_reminder_list_tile.dart';
import 'edit_profile_settings_row.dart';
import 'notifications_settings_list_tile.dart';

class GeneralSettingsContainer extends StatelessWidget {
  const GeneralSettingsContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.all(20.w),
      decoration: BoxDecoration(
          color: AppColors.cF6F8FA,
          borderRadius: BorderRadius.circular(16.r)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.tr('general_Settings'),
            style: AppTextStyles.bold18(context).copyWith(
                color: AppColors.c181C2E),),
          SpaceWidget(height: 16,),
          EditProfileRowSettings(),
          SpaceWidget(height: 16,),
          Divider(
            color: AppColors.cEEF2F6,
            thickness: 4,
            height: 10,
          ),
          BlocBuilder<SettingsCubit, SettingsState>(
            builder: (context, state) {
              return NotificationsSettingsListTile(
                  settingsCubit: SettingsCubit.get(context));
            },
          ),
          Divider(
            color: AppColors.cEEF2F6,
            thickness: 4,
            height: 10,
          ),
          BlocBuilder<SettingsCubit,SettingsState>(
            builder: (context, state) {
              return BillReminderListTile(
                settingsCubit: SettingsCubit.get(context),);
            },
          ),
          Divider(
            color: AppColors.cEEF2F6,
            thickness: 4,
            height: 10,
          ),
          BlocBuilder<SettingsCubit,SettingsState>(
            builder: (context, state) {
              return AppUpdatesListTile();
            },
          ),



        ],
      ),
    );
  }
}



