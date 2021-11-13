import 'package:cached_network_image/cached_network_image.dart';
import 'package:esporty/src/data/models/player_model.dart';
import 'package:esporty/src/logic/cubits/player_cubit/player_cubit.dart';
import 'package:esporty/src/logic/cubits/squad_cubit/squad_cubit.dart';
import 'package:esporty/src/presentation/widgets/card_list_tile.dart';
import 'package:esporty/src/presentation/widgets/text_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SquadNotificationsPage extends StatelessWidget {
  final String squadId;
  const SquadNotificationsPage({
    Key? key,
    required this.squadId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: Column(
        children: [
          Flexible(
            child: BlocBuilder<SquadCubit, SquadState>(
              builder: (context, squadState) {
                if (squadState is SquadSucceed) {
                  return ListView.builder(
                    itemCount: squadState.squadModel.squadPlayersJoined.length,
                    itemBuilder: (context, index) => FutureBuilder<PlayerModel>(
                        future: BlocProvider.of<PlayerCubit>(context)
                            .getPlayerDetails(squadState
                                .squadModel.squadPlayersJoined[index]
                                .toString()),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return CardListTile(
                              title: snapshot.data!.playerName,
                              leading: SizedBox(
                                height: 30,
                                width: 30,
                                child: ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: snapshot.data!.playerProfileImg,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              trailing: squadState.squadModel.squadCreatedBy !=
                                      BlocProvider.of<PlayerCubit>(context)
                                          .getCurrentPlayerId
                                          .toString()
                                  ? null
                                  : TextBtn(
                                      text: 'Acept',
                                      onPressed: () {
                                        BlocProvider.of<SquadCubit>(context)
                                            .acceptPlayerRequest(
                                                squadId,
                                                squadState.squadModel
                                                    .squadPlayersJoined[index]
                                                    .toString());
                                      },
                                    ),
                            );
                          }
                          return const SizedBox();
                        }),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
