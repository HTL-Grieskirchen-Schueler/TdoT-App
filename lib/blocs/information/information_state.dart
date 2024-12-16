part of 'information_bloc.dart';

sealed class InformationState extends Equatable {
  const InformationState();

  @override
  List<Object> get props => [];
}

final class InformationInitial extends InformationState {}

class InformationInitializedState extends InformationState {
  final String infoText;

  const InformationInitializedState({
    required this.infoText,
  }) : super();

  @override
  List<Object> get props => [infoText];
}

class InformationLoadingErrorState extends InformationState {
  final String errorMessage;

  const InformationLoadingErrorState({required this.errorMessage}) : super();

  @override
  List<Object> get props => [errorMessage];
}
