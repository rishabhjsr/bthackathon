import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bt_hack/features/search/presentation/manager/search_bloc.dart';
import 'package:bt_hack/features/search/presentation/manager/search_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/models/product_model.dart';
import '../../../../core/services/search_api_service.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchInitialEvent>(searchInitialEvent);
    on<SearchProductCardBtnNavigateEvent>(searchProductCardBtnNavigateEvent);
    on<SearchHomeBtnClickedEvent>(searchHomeBtnClickedEvent);
  }

  FutureOr<void> searchInitialEvent(event, Emitter<SearchState> emit) async {

    SearchApiService client=SearchApiService();
    emit(SearchLoadingState());

    final products=await client.getProduct(event.query);
    emit(SearchLoadedSuccessState(products: products));
  }

  FutureOr<void> searchProductCardBtnNavigateEvent(SearchProductCardBtnNavigateEvent event, Emitter<SearchState> emit) {
    emit(SearchNavigateToDetailsPageActionState(products: event.product));
  }

  FutureOr<void> searchHomeBtnClickedEvent(SearchHomeBtnClickedEvent event, Emitter<SearchState> emit) {
    emit(SearchNavigateToHomePageActionState());
  }
}
