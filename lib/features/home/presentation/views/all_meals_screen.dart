
import 'package:chef_app/core/commons/commons.dart';
import 'package:chef_app/features/home/presentation/cubits/home_screen_cubit/home_screen_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/utilis/app_colors.dart';
import '../../../../core/widgets/space_widget.dart';
import '../widgets/all_available_meals/all_available_meals_row.dart';
import '../widgets/all_available_meals/all_meal_app_bar.dart';
import '../widgets/all_available_meals/available_meals_loading_widget.dart';
import '../widgets/all_available_meals/grid_meal_item.dart';
import '../widgets/all_available_meals/no_meals_yet_widget.dart';

class AllMealsScreen extends StatelessWidget {
  const AllMealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeScreenCubit, HomeScreenState>(
      listener: (context, state) {

      },
      child: Scaffold(
        backgroundColor: AppColors.cF3F3F3,
        body: SafeArea(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:
                    [
                      SpaceWidget(height: 24,),
                      AllMealsAppBar(),
                      SpaceWidget(height: 24,),
                      AllAvailableMeals(),
                      SpaceWidget(height: 24,)

                    ],
                  ),
                ),
                BlocBuilder<HomeScreenCubit, HomeScreenState>
                  (builder: (context, state) {
                  if (state is GetAllMealsLoadingState)
                  {
                    return AllAvailableMealsLoadingWidget();
                  }
                   if (HomeScreenCubit.get(context).allMealsModel!.meals!.isNotEmpty)
                  {
                    return SliverFillRemaining(
                      child: Column(
                        children: [
                          Expanded(
                            child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              padding: EdgeInsetsDirectional.only(start: 24.w, end: 24.w),
                             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                               crossAxisCount: 2,
                               mainAxisSpacing: 21.h,
                               crossAxisSpacing: 21.w,
                               mainAxisExtent: 200.h
                             ),
                               itemCount: HomeScreenCubit.get(context).allMealsModel!.meals!.length,
                              itemBuilder: (context, index) {
                               return GestureDetector(
                                    onTap: () {
                                      navigate(context: context,
                                          route: Routes.mealDetailsScreen,
                                          arg: HomeScreenCubit.get(context).allMealsModel!.meals![index]);

                                    },
                                    child: GridMealItem(
                                      index: index,
                                      mealsList: HomeScreenCubit.get(context).allMealsModel!.meals!,
                                      meal:HomeScreenCubit.get(context).allMealsModel!.meals![index],
                                    ),
                                  );
                                },

                            ),
                          ),
                        ],
                      ),
                    );

                  }
                   if (HomeScreenCubit.get(context).allMealsModel!.meals!.isEmpty) {
                    return SliverFillRemaining(
                        hasScrollBody: false,
                        child: NoMealsYetWidget());
                  }
                  else
                  {
                    return SliverToBoxAdapter(child: Text('Error'),);
                  }
                }),
                SliverToBoxAdapter(child: SpaceWidget(height: 32,))


              ],
            )),
        floatingActionButton: _buildFloatingButton(context),
      ),
    );
  }

  _buildFloatingButton(BuildContext context)
  {
    return FloatingActionButton(
      elevation: 0, onPressed: ()
    {
      navigate(context: context, route: Routes.addMealScreen);
    },
    child:Container(
      width: 45.w,
      height: 49.h,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.c181C2E
      ),
      child: Center(child: Icon(
        Icons.add, color: AppColors.white,)),
    )
    );
  }


}
