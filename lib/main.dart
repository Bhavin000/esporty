import 'package:esporty/src/app.dart';
import 'package:esporty/src/data/repositories/authentication_repository.dart';
import 'package:esporty/src/data/repositories/chat_repository.dart';
import 'package:esporty/src/data/repositories/contest_close_repository.dart';
import 'package:esporty/src/data/repositories/contest_repository.dart';
import 'package:esporty/src/data/repositories/game_repository.dart';
import 'package:esporty/src/data/repositories/player_repository.dart';
import 'package:esporty/src/data/repositories/room_repository.dart';
import 'package:esporty/src/data/repositories/squad_repository.dart';
import 'package:esporty/src/data/repositories/util_repository.dart';
import 'package:esporty/src/presentation/routes/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
  await Firebase.initializeApp();

  runApp(App(
    appRoutes: AppRoutes(),
    authenticationRepository: AuthenticationRepository(),
    utilRepository: UtilRepository(),
    playerRepository: PlayerRepository(),
    gameRepository: GameRepository(),
    squadRepository: SquadRepository(),
    chatRepository: ChatRepository(),
    contestRepository: ContestRepository(),
    roomRepositoty: RoomRepositoty(),
    contestCloseRepository: ContestCloseRepository(),
  ));
}
