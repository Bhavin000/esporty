import 'package:bloc/bloc.dart';
import 'package:esporty/src/constants/enums.dart';
import 'package:esporty/src/presentation/themes/app_theme.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> with HydratedMixin {
  ThemeCubit() : super(ThemeState(appTheme: LightTheme()));

  changeTheme(ThemeType themeType) {
    if (themeType == ThemeType.lightTheme) {
      emit(ThemeState(appTheme: LightTheme()));
    } else if (themeType == ThemeType.darkTheme) {
      emit(ThemeState(appTheme: DarkTheme()));
    }
  }

  @override
  ThemeState fromJson(Map<String, dynamic> json) {
    return ThemeState.fromMap(json);
  }

  @override
  Map<String, dynamic> toJson(ThemeState state) {
    return state.toMap();
  }
}
