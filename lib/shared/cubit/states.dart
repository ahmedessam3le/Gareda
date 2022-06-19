abstract class GaredaStates {}

class GaredaInitialState extends GaredaStates {}

class GaredaBottomNavBarState extends GaredaStates {}

class GetBusinessNewsLoadingState extends GaredaStates {}

class GetBusinessNewsSuccessState extends GaredaStates {}

class GetBusinessNewsErrorState extends GaredaStates {
  final String error;

  GetBusinessNewsErrorState(this.error);
}

class GetSportNewsLoadingState extends GaredaStates {}

class GetSportNewsSuccessState extends GaredaStates {}

class GetSportNewsErrorState extends GaredaStates {
  final String error;

  GetSportNewsErrorState(this.error);
}

class GetScienceNewsLoadingState extends GaredaStates {}

class GetScienceNewsSuccessState extends GaredaStates {}

class GetScienceNewsErrorState extends GaredaStates {
  final String error;

  GetScienceNewsErrorState(this.error);
}

class GetSearchNewsLoadingState extends GaredaStates {}

class GetSearchNewsSuccessState extends GaredaStates {}

class GetSearchNewsErrorState extends GaredaStates {
  final String error;

  GetSearchNewsErrorState(this.error);
}

abstract class AppStates {}

class AppInitialState extends AppStates {}

class ChangeAppThemeState extends AppStates {}
