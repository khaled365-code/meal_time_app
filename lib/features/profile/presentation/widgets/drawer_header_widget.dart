import 'package:cached_network_image/cached_network_image.dart';
import 'package:chef_app/core/database/cache/cache_helper.dart';
import 'package:chef_app/core/utilis/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/database/api/api_keys.dart';
import '../../../../core/utilis/app_colors.dart';
import '../../../../core/utilis/app_text_styles.dart';
import '../../../../core/widgets/space_widget.dart';

class DrawerHeaderWidget extends StatelessWidget {
  const DrawerHeaderWidget({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
     return Row(
          children: [
            Container(
              width: 100.w,
              height: 100.h,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: CacheHelper().getData(key: ApiKeys.profilePic)!=null?
                  DecorationImage(
                      image: CachedNetworkImageProvider(
                          CacheHelper().getData(key: ApiKeys.profilePic)
                      ), fit: BoxFit.fill):
                  DecorationImage(
                              image: AssetImage(ImageConstants.userDefaultImage),
                              fit: BoxFit.fill)

              ),
            ),
            SpaceWidget(width: 32,),
            Padding(
              padding: EdgeInsetsDirectional.only(end: 55.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(CacheHelper().getData(key: ApiKeys.name),
                    style: AppTextStyles.bold20(context).copyWith(
                        color: AppColors.c32343E),),
                  SpaceWidget(height: 8,),
                  Text('I love fast food',
                    style: AppTextStyles.regular14(context).copyWith(
                        color: AppColors.cA0A5BA),),
                ],
              ),
            )
          ],
        );
  }
}