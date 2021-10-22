import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:financial_app/helpers/api_helper.dart';
import 'package:financial_app/models/user.dart';
import 'package:meta/meta.dart';

class UserPortfolioBloc extends Bloc<UserPortfolioEvent, UserPortfolioState> {

  UserPortfolioBloc(UserPortfolioState initialState) : super(initialState);


  @override
  UserPortfolioState get initialState => InitialUserScreenState();

  @override
  Stream<UserPortfolioState> mapEventToState(UserPortfolioEvent event) async* {
    if (event is LoadUserEvent) {
      try {
        yield UserLoadingState();
        UserList? usersList = await API().getListFromServer();
        if (usersList != null) {
          yield UserLoadedState(usersList);
        }
      } catch (e) {
        yield UserLoadErrorState(errorMessage(e.toString()));
      }
    }
  }
}

@immutable
abstract class UserPortfolioEvent {}

class LoadUserEvent extends UserPortfolioEvent {}

@immutable
abstract class UserPortfolioState {}

class InitialUserScreenState extends UserPortfolioState {}

class UserLoadingState extends UserPortfolioState {}

class UserLoadedState extends UserPortfolioState {
  final UserList userApiResponseList;

  UserLoadedState(this.userApiResponseList);
}

class UserLoadErrorState extends UserPortfolioState {
  final String errorMessage;

  UserLoadErrorState(this.errorMessage);
}
