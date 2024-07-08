part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}


class LoadProductEvent extends ProductEvent{}

class PullToRefreshEvent extends ProductEvent {}