part of 'details_bloc.dart';

@immutable
abstract class DetailsEvent {}

class DetailsInitialEvent extends DetailsEvent{
  final Product product;
  DetailsInitialEvent({required this.product});
}

class DetailsNavigateToHomePageEvent extends DetailsEvent{
}
