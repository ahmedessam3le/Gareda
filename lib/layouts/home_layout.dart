import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gareda/modules/search/search_screen.dart';
import 'package:gareda/shared/components/components.dart';
import 'package:gareda/shared/cubit/cubit.dart';
import 'package:gareda/shared/cubit/states.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GaredaCubit, GaredaStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = GaredaCubit.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Gareda',
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    navigateTo(context: context, widget: SearchScreen());
                  },
                  icon: Icon(Icons.search)),
              IconButton(
                  onPressed: () {
                    AppCubit.of(context).changeAppThemeMode();
                  },
                  icon: Icon(Icons.brightness_4_outlined)),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.pageIndex,
            onTap: (value) {
              cubit.changePageIndex(value);
            },
            items: cubit.bottomItems,
          ),
          body: cubit.pages[cubit.pageIndex],
        );
      },
    );
  }
}
