part of 'order_bloc.dart';

class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrderLoading extends OrderState {}

class OrderLoaded extends OrderState {}

class OrderError extends OrderState {
  final String error;

  const OrderError(this.error);

  @override
  List<Object> get props => [error];
}
