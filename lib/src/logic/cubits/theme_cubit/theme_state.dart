part of 'theme_cubit.dart';

class ThemeState {
  final AppTheme appTheme;
  const ThemeState({required this.appTheme});

  List<Object> get props => [appTheme];

  Map<String, dynamic> toMap() {
    return {
      'appTheme': appTheme is LightTheme ? 'lightTheme' : 'darkTheme',
    };
  }

  factory ThemeState.fromMap(Map<String, dynamic> map) {
    return ThemeState(
      appTheme: map['appTheme'] == 'lightTheme' ? LightTheme() : DarkTheme(),
    );
  }
}
