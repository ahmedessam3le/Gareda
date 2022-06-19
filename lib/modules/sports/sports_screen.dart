import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gareda/shared/components/components.dart';
import 'package:gareda/shared/components/shimmer.dart';
import 'package:gareda/shared/cubit/cubit.dart';
import 'package:gareda/shared/cubit/states.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GaredaCubit, GaredaStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var articles = GaredaCubit.of(context).sportsNews;
        return state is! GetSportNewsLoadingState
            ? ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => buildArticleItem(
                  articles[index],
                  context,
                ),
                separatorBuilder: (context, index) => buildDivider(),
                itemCount: articles.length,
              )
            : ShimmerLoading();
      },
    );
  }
}
