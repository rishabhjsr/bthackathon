import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/models/product_model.dart';
import '../../../../core/services/api_service.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<HomeChangeCategoryEvent>(homeChangeCategoryEvent);
    on<HomeProductCardBtnNavigateEvent>(homeProductCardBtnNavigateEvent);
    on<HomeSearchBtnClickedEvent>(homeSearchBtnClickedEvent);
  }

  FutureOr<void> homeInitialEvent(HomeInitialEvent event, Emitter<HomeState> emit)async {
    ApiService client=ApiService();
    emit(HomeLoadingState());

    final products=await client.getProduct();
    emit(HomeLoadedSuccessState(products: products));
  }

    FutureOr<void> homeProductCardBtnNavigateEvent(HomeProductCardBtnNavigateEvent event, Emitter<HomeState> emit) {
      print("navigate inside the selected product");
      emit(HomeNavigateToDetailsPageActionState(products: event.product));

    }

  FutureOr<void> homeChangeCategoryEvent(HomeChangeCategoryEvent event, Emitter<HomeState> emit) {
  }

  FutureOr<void> homeSearchBtnClickedEvent(HomeSearchBtnClickedEvent event, Emitter<HomeState> emit) {
    print("navigate to searched product's result page");
    emit(HomeNavigateToSearchPageActionState());

  }
}
