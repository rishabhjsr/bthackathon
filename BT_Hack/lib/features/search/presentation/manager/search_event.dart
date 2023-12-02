part of 'search_bloc.dart';

@immutable
abstract class SearchEvent {}

class SearchInitialEvent extends SearchEvent{
  final String query;

  SearchInitialEvent(this.query);

  @override
  List<Object?> get props => [query];

  @override
  String toString() => 'SearchInitialEvent { query: $query }';
}

class SearchHomeBtnClickedEvent extends SearchEvent{}

class SearchProductCardBtnNavigateEvent extends SearchEvent{
  final Product product;
  SearchProductCardBtnNavigateEvent({required this.product});
}
