import 'package:cached_network_image/cached_network_image.dart';
import 'package:chef_app/core/widgets/space_widget.dart';
import 'package:chef_app/features/home/data/models/get_meals_model/system_all_meals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utilis/app_colors.dart';
import '../../../../../core/utilis/app_text_styles.dart';
import '../../cubits/favourites_and_history_cubit/favourites_and_history_cubit.dart';
import 'favourite_meal_container_shape.dart';

class GridMealItem extends StatelessWidget {
  const GridMealItem(
      {super.key, required this.meal, required this.mealsList, required this.index,});

  final SystemMeals meal;
  final List<SystemMeals> mealsList;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.r),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
                color: AppColors.c96969A,
                blurRadius: 10,
                offset: const Offset(12, 12),
                spreadRadius: 0
            )
          ]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.only(start: 17.w, end: 14.w),
            child: Container(
              height: 84.h,
              decoration: meal.images!.first.isNotEmpty ? BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(
                          meal.images!.first
                      ), fit: BoxFit.cover)
              ) : null,
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(start: 12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SpaceWidget(height: 15,),
                Text(
                    meal.name!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bold15(context).copyWith(
                        color: AppColors.c32343E
                    )),
                SpaceWidget(height: 5,),
                Padding(
                  padding:  EdgeInsetsDirectional.only(end: 22.w),
                  child: Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      meal.description!,
                      style: AppTextStyles.regular13(context).copyWith(
                          color: AppColors.c646982
                      )),
                ),
                SpaceWidget(height: 8,),
                Row(
                  children: [
                    Text('\$${meal.price}'.toString(), style: AppTextStyles
                        .bold15(context).copyWith(
                        color: AppColors.c32343E
                    )),
                    Spacer(),
                    BlocBuilder<FavouritesAndHistoryCubit, FavouritesAndHistoryState>(
                      builder: (context, state) {
                        return Padding(
                            padding: EdgeInsetsDirectional.only(end: 10.w),
                            child: GestureDetector(
                              onTap: () async
                              {
                                FavouritesAndHistoryCubit.get(context)
                                    .changeFavouriteHeartShape(
                                    index: index, mealList: mealsList);
                              },
                              child: AddMealContainerShapeToFavourites(
                                isActivated: meal.itemIsSelected,
                              ),
                            )
                        );
                      },
                    )
                  ],
                ),
                SpaceWidget(height: 15,),

              ],
            ),
          ),


        ],
      ),
    );
  }
}


