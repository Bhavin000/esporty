import 'package:cached_network_image/cached_network_image.dart';
import 'package:esporty/src/data/models/contest_model.dart';
import 'package:esporty/src/data/models/room_model.dart';
import 'package:esporty/src/data/models/squad_model.dart';
import 'package:esporty/src/logic/cubits/contest_cubit/contest_cubit.dart';
import 'package:esporty/src/logic/cubits/room_cubit/room_cubit.dart';
import 'package:esporty/src/logic/cubits/squad_cubit/squad_cubit.dart';
import 'package:esporty/src/presentation/widgets/card_list_tile.dart';
import 'package:esporty/src/presentation/widgets/elevated_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Contests extends StatelessWidget {
  final String squadId;
  const Contests({
    Key? key,
    required this.squadId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ContestCubit, ContestState>(
      builder: (context, contestState) {
        if (contestState is ContestLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (contestState is ContestSucceed) {
          final listContestModel = contestState.listContestModel
              .where((element) => element.contestCreatedBy != squadId)
              .toList();

          return ListView.builder(
            shrinkWrap: true,
            primary: false,
            itemCount: listContestModel.length,
            itemBuilder: (context, index) => FutureBuilder<SquadModel>(
              future: BlocProvider.of<SquadCubit>(context)
                  .getSquadDetails(listContestModel[index].contestCreatedBy),
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
                    title: snapshot.data!.squadName,
                    subtitle: listContestModel[index].contestTitle,
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

  void openBottomSheet(BuildContext context, ContestModel _contestModel) {
    showModalBottomSheet(
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        height: 400,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        )),
        child: Column(
          children: [
            Text(_contestModel.contestCreatedAt.toString()),
            Text(_contestModel.contestTitle),
            Text(_contestModel.contestDescription),
            Text(_contestModel.contestType),
            Text(_contestModel.contestVisibility),
            _contestModel.contestVisibility == 'close' &&
                    _contestModel.contestCreatedBy != squadId
                ? BlocBuilder<SquadCubit, SquadState>(
                    builder: (context, squadState) {
                      if (squadState is SquadSucceed) {
                        if (squadState.squadModel.squadAppliedContests
                            .contains(_contestModel.contestId)) {
                          return const ElevatedBtn(
                            label: 'Applied',
                            onPressed: null,
                          );
                        }
                        return ElevatedBtn(
                          label: 'Apply',
                          onPressed: () {
                            BlocProvider.of<SquadCubit>(context).applyToContest(
                                _contestModel.contestId!, squadId);
                          },
                        );
                      }
                      return const CircularProgressIndicator();
                    },
                  )
                : const SizedBox(),
            _contestModel.contestVisibility == 'open'
                ? FutureBuilder<RoomModel>(
                    future: BlocProvider.of<RoomCubit>(context)
                        .getRoomDetails(_contestModel.contestId!),
                    builder: (context, snapshot) => snapshot.hasData
                        ? Column(
                            children: [
                              Text(snapshot.data!.roomId),
                              Text(snapshot.data!.password),
                              Text(snapshot.data!.roomGameName),
                              Text(snapshot.data!.roomGameMode),
                              Text(snapshot.data!.roomGameMap),
                            ],
                          )
                        : const SizedBox(),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
