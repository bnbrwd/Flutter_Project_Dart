part of 'app_theme_bloc.dart';

// abstract class AppThemeState extends Equatable {
//   const AppThemeState();

//   @override
//   List<Object> get props => [];
// }

// class AppThemeInitial extends AppThemeState {}

class AppThemeState extends Equatable {
  final ThemeData theme;
  const AppThemeState({required this.theme});

  @override
  List<Object> get props => [theme];
}
