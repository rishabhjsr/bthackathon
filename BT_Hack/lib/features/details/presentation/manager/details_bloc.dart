import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/models/product_model.dart';

part 'details_event.dart';
part 'details_state.dart';

class DetailsBloc extends Bloc<DetailsEvent, DetailsState> {
  DetailsBloc() : super(DetailsInitial()) {
    on<DetailsNavigateToHomePageEvent>(detailsNavigateToHomePageEvent);
    on<DetailsInitialEvent>(detailsInitialEvent);
  }

  FutureOr<void> detailsInitialEvent(event, Emitter<DetailsState> emit) async {
    emit(DetailsLoadingState());
    final product=await event.product;
    emit(DetailsLoadedSuccessState(product: product));
  }

  FutureOr<void> detailsNavigateToHomePageEvent(event, Emitter<DetailsState> emit) {
    print("navigate back to Home page");
    emit(DetailsNavigateToHomePageActionState());
  }
}

