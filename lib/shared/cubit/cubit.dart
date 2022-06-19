import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gareda/modules/business/business_screen.dart';
import 'package:gareda/modules/science/science_screen.dart';
import 'package:gareda/modules/sports/sports_screen.dart';
import 'package:gareda/shared/components/constants.dart';
import 'package:gareda/shared/cubit/states.dart';
import 'package:gareda/shared/network/local/cache_helper.dart';
import 'package:gareda/shared/network/remote/dio_helper.dart';

class GaredaCubit extends Cubit<GaredaStates> {
  GaredaCubit() : super(GaredaInitialState());

  static GaredaCubit of(BuildContext context) => BlocProvider.of(context);

  int pageIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.business_center_outlined,
          size: 30,
        ),
        label: 'Business'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.sports_basketball_outlined,
          size: 30,
        ),
        label: 'Sports'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.science_outlined,
          size: 30,
        ),
        label: 'Science'),
  ];

  List<Widget> pages = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  List<dynamic> businessNews = [];
  List<dynamic> sportsNews = [];
  List<dynamic> scienceNews = [];
  List<dynamic> searchNews = [];

  void changePageIndex(int value) {
    pageIndex = value;

    emit(GaredaBottomNavBarState());
    if (value == 1) {
      getSportsNews();
    } else if (value == 2) {
      getScienceNews();
    }
  }

  void getBusinessNews() {
    if (businessNews.isEmpty) {
      emit(GetBusinessNewsLoadingState());
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'business',
          'apiKey': apiKey,
        },
      ).then((value) {
        print('Business News Total Result : ${value.data['totalResults']}');
        businessNews = value.data['articles'];

        emit(GetBusinessNewsSuccessState());
        print(DateTime.parse(businessNews[0]['publishedAt']));
      }).catchError((error) {
        print('getBusinessNews Error : ${error.toString()}');
        emit(GetBusinessNewsErrorState(error.toString()));
      });
    } else {
      emit(GetBusinessNewsSuccessState());
    }
  }

  void getSportsNews() {
    if (sportsNews.isEmpty) {
      emit(GetSportNewsLoadingState());
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': apiKey,
        },
      ).then((value) {
        print('Sports News Total Result : ${value.data['totalResults']}');
        sportsNews = value.data['articles'];

        emit(GetSportNewsSuccessState());
      }).catchError((error) {
        print('getSportsNews Error : ${error.toString()}');
        emit(GetSportNewsErrorState(error.toString()));
      });
    } else {
      emit(GetSportNewsSuccessState());
    }
  }

  void getScienceNews() {
    if (scienceNews.isEmpty) {
      emit(GetScienceNewsLoadingState());
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': apiKey,
        },
      ).then((value) {
        print('Science News Total Result : ${value.data['totalResults']}');
        scienceNews = value.data['articles'];

        emit(GetScienceNewsSuccessState());
      }).catchError((error) {
        print('getScienceNews Error : ${error.toString()}');
        emit(GetScienceNewsErrorState(error.toString()));
      });
    } else {
      emit(GetScienceNewsSuccessState());
    }
  }

  void getSearchNews(String value) {
    emit(GetSearchNewsLoadingState());
    searchNews.clear();
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': '$value',
        'apiKey': apiKey,
      },
    ).then((value) {
      print('Search News Total Result : ${value.data['totalResults']}');
      searchNews = value.data['articles'];

      emit(GetSearchNewsSuccessState());
    }).catchError((error) {
      print('getSearchNews Error : ${error.toString()}');
      emit(GetSearchNewsErrorState(error.toString()));
    });
  }
}

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit of(BuildContext context) => BlocProvider.of(context);

  bool isDark = false;

  void changeAppThemeMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ChangeAppThemeState());
    } else {
      isDark = !isDark;
      CacheHelper.setThemeMode(isDark: isDark).then((value) {
        emit(ChangeAppThemeState());
      });
    }
  }
}
