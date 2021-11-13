import 'package:esporty/src/presentation/navigator/bottom_navigator.dart';
import 'package:esporty/src/presentation/pages/create_contest_page.dart';
import 'package:esporty/src/presentation/pages/create_player_profile_page.dart';
import 'package:esporty/src/presentation/pages/create_room_page.dart';
import 'package:esporty/src/presentation/pages/create_squad_page.dart';
import 'package:esporty/src/presentation/pages/create_tournament_page.dart';
import 'package:esporty/src/presentation/pages/join_squad_page.dart';
import 'package:esporty/src/presentation/pages/sign_in_page.dart';
import 'package:esporty/src/presentation/pages/sign_up_page.dart';
import 'package:esporty/src/presentation/pages/squad_notifications_page.dart';
import 'package:esporty/src/presentation/routes/route_definations.dart';
import 'package:esporty/src/presentation/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AppRoutes {
  Route onGeneratedRoutes(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.bottomNavigator:
        return MaterialPageRoute(
          builder: (context) => const BottomNavigator(),
        );
      case Routes.signInPage:
        return MaterialPageRoute(
          builder: (context) => SignInPage(),
        );
      case Routes.signUpPage:
        return MaterialPageRoute(
          builder: (context) => SignUpPage(),
        );
      case Routes.createPlayerProfilePage:
        return MaterialPageRoute(
          builder: (context) => const CreatePlayerProfilePage(),
        );
      case Routes.createSquadPage:
        return MaterialPageRoute(
          builder: (context) => const CreateSquadPage(),
        );
      case Routes.joinSquadPage:
        return MaterialPageRoute(
          builder: (context) => const JoinSquadPage(),
        );
      case Routes.squadNoticationsPage:
        final result = routeSettings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => SquadNotificationsPage(
            squadId: result,
          ),
        );
      case Routes.createContestPage:
        final result = routeSettings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => CreateContestPage(
            squadId: result,
          ),
        );
      case Routes.createRoomPage:
        final result = routeSettings.arguments as String;
        return MaterialPageRoute(
          builder: (context) => CreateRoomPage(
            squadId: result,
          ),
        );
      case Routes.createTournamentPage:
        return MaterialPageRoute(
          builder: (context) => const CreateTournamentPage(),
        );
      default:
        return MaterialPageRoute(
          builder: (context) => const Splash(),
        );
    }
  }
}
