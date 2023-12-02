part of 'search_bloc.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}

abstract class SearchActionState extends SearchState{}


class SearchLoadingState extends SearchState{}

class SearchLoadedSuccessState extends SearchState{

  final List<Product> products;

  SearchLoadedSuccessState({required this.products});
}

class SearchErrorState extends SearchState{}

class SearchNavigateToDetailsPageActionState extends SearchActionState{
  final Product products;
  SearchNavigateToDetailsPageActionState({required this.products});
}

class SearchNavigateToHomePageActionState extends SearchActionState{

}