import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gareda/shared/components/components.dart';
import 'package:gareda/shared/components/shimmer.dart';
import 'package:gareda/shared/cubit/cubit.dart';
import 'package:gareda/shared/cubit/states.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GaredaCubit, GaredaStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var articles = GaredaCubit.of(context).searchNews;
        return Scaffold(
          appBar: AppBar(
            title: Padding(
              padding: const EdgeInsets.all(20.0),
              child: defaultFormField(
                context: context,
                controller: searchController,
                keyboardType: TextInputType.text,
                labelText: 'Search',
                prefixIcon: Icons.search,
                onValidate: (value) {
                  if (value!.isEmpty) {
                    return 'Type Anything To Search';
                  }
                  return null;
                },
                onChange: (value) {
                  GaredaCubit.of(context).getSearchNews(value!);
                },
              ),
            ),
          ),
          body: Column(
            children: [
              state is! GetBusinessNewsLoadingState
                  ? Expanded(
                      child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) => buildArticleItem(
                          articles[index],
                          context,
                        ),
                        separatorBuilder: (context, index) => buildDivider(),
                        itemCount: articles.length,
                      ),
                    )
                  : ShimmerLoading(),
            ],
          ),
        );
      },
    );
  }
}
