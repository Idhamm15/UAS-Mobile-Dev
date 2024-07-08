part of 'product_bloc.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}

final class LoadingState extends ProductState {}

final class LoadedState extends ProductState {
  final List<Product> products;
  LoadedState({
    required this.products,
  });
}

class FailedToLoadState extends ProductState {
  final String message;
  FailedToLoadState({required this.message});
}
