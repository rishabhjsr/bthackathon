part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

abstract class HomeActionState extends HomeState{}


class HomeLoadingState extends HomeState{}

class HomeLoadedSuccessState extends HomeState{

  final List<Product> products;

  HomeLoadedSuccessState({required this.products});
}

class HomeErrorState extends HomeState{}

class HomeNavigateToDetailsPageActionState extends HomeActionState{
  final Product products;
  HomeNavigateToDetailsPageActionState({required this.products});
}

class HomeNavigateToSearchPageActionState extends HomeActionState{

}