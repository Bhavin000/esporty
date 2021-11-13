import 'package:cached_network_image/cached_network_image.dart';
import 'package:esporty/src/data/models/contest_model.dart';
import 'package:esporty/src/data/models/squad_model.dart';
import 'package:esporty/src/logic/cubits/contest_close_cubit/contest_close_cubit.dart';
import 'package:esporty/src/logic/cubits/contest_cubit/contest_cubit.dart';
import 'package:esporty/src/logic/cubits/squad_cubit/squad_cubit.dart';
import 'package:esporty/src/presentation/components/message_bottom_sheet.dart';
import 'package:esporty/src/presentation/widgets/card_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Message extends StatelessWidget {
  final String notificationType;
  final String squadId;
  const Message(this.notificationType, this.squadId, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContestCubit, ContestState>(
      builder: (context, contestState) {
        if (contestState is ContestLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (contestState is ContestSucceed) {
          return BlocBuilder<SquadCubit, SquadState>(
            builder: (context, squadState) {
              if (squadState is SquadSucceed) {
                List<ContestModel> listContestModel = [];
                switch (notificationType) {
                  case 'uploaded':
                    listContestModel = contestState.listContestModel
                        .where((element) => element.contestCreatedBy == squadId)
                        .toList();
                    break;
                  case 'joined':
                    listContestModel = contestState.listContestModel
                        .where((element) => element.contestCreatedBy != squadId)
                        .where((element) => squadState
                            .squadModel.squadAppliedContests
                            .contains(element.contestId))
                        .toList();

                    break;
                  case 'invited':
                    listContestModel = contestState.listContestModel
                        .where((element) => element.contestCreatedBy != squadId)
                        .where((element) => squadState
                            .squadModel.squadInvitedContests
                            .contains(element.contestId))
                        .toList();
                    break;
                  default:
                    listContestModel = [];
                }
                return ListView.builder(
                  primary: false,
                  itemCount: listContestModel.length,
                  itemBuilder: (context, index) => FutureBuilder<SquadModel>(
                    future: BlocProvider.of<SquadCubit>(context)
                        .getSquadDetails(
                            listContestModel[index].contestCreatedBy),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return CardListTile(
                          leading: ClipOval(
                            child: CachedNetworkImage(
                              imageUrl: snapshot.data!.squadProfileImg,
                              fit: BoxFit.cover,
                              height: 50,
                              width: 50,
                              cacheKey: snapshot.data!.squadProfileImg,
                              memCacheHeight: 50,
                              memCacheWidth: 50,
                              maxWidthDiskCache: 50,
                              maxHeightDiskCache: 50,
                            ),
                          ),
                          title: listContestModel[index].contestTitle,
                          subtitle: listContestModel[index].contestDescription,
                          trailing: snapshot.data!.squadIsVerified == true
                              ? const Icon(
                                  Icons.verified,
                                  color: Colors.blue,
                                )
                              : null,
                          onPressed: () {
                            openBottomSheet(context, listContestModel[index]);
                          },
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                );
              }
              return const SizedBox();
            },
          );
        }
        return const SizedBox();
      },
    );
  }

  void openBottomSheet(BuildContext context, ContestModel _contestModel) async {
    final sheet = showModalBottomSheet(
      constraints: BoxConstraints(
        minHeight: 300,
        minWidth: double.infinity,
        maxHeight: MediaQuery.of(context).size.height * 0.6,
      ),
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (context) => MessageBottomSheet(
        notificationType: notificationType,
        contestModel: _contestModel,
        squadId: squadId,
      ),
    );
    await sheet;
    BlocProvider.of<ContestCloseCubit>(context).closeStream();
  }
}
