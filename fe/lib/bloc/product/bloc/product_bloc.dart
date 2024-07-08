import 'package:bloc/bloc.dart';
import 'package:fe/data/model/product.dart';
import 'package:fe/data/repository/api_repository.dart';
import 'package:meta/meta.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ApiRepository apiRepository;
  ProductBloc({required this.apiRepository}) : super(ProductInitial()) {
    on<ProductEvent>((event, emit) async {
      if (event is LoadProductEvent || event is PullToRefreshEvent) {
        emit(LoadingState());
        try {
          final products = await apiRepository.getProductList();
          emit(LoadedState(products: products));
        } catch (e) {
          emit(FailedToLoadState(message: e.toString()));
        }
      }
    });
  }
}
