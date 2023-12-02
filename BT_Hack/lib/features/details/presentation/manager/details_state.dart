part of 'details_bloc.dart';

@immutable
abstract class DetailsState {}

abstract class  DetailsActionState extends DetailsState{}

class DetailsInitial extends DetailsState {}

class DetailsLoadingState extends DetailsState{}

class DetailsLoadedSuccessState extends DetailsState{
  final Product product;
  DetailsLoadedSuccessState({required this.product});
}

class DetailsErrorState extends DetailsState{}

class DetailsNavigateToHomePageActionState extends DetailsActionState{}