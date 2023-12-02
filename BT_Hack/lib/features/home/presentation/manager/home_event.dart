part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent{}

class HomeSearchBtnClickedEvent extends HomeEvent{}

class HomeChangeCategoryEvent extends HomeEvent{}

class HomeProductCardBtnNavigateEvent extends HomeEvent{
  final Product product;
  HomeProductCardBtnNavigateEvent({required this.product});
}
