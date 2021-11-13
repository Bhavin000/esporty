import 'package:cached_network_image/cached_network_image.dart';
import 'package:esporty/src/data/models/contest_model.dart';
import 'package:esporty/src/data/models/room_model.dart';
import 'package:esporty/src/data/models/squad_model.dart';
import 'package:esporty/src/logic/cubits/contest_close_cubit/contest_close_cubit.dart';
import 'package:esporty/src/logic/cubits/room_cubit/room_cubit.dart';
import 'package:esporty/src/logic/cubits/squad_cubit/squad_cubit.dart';
import 'package:esporty/src/presentation/widgets/card_list_tile.dart';
import 'package:esporty/src/presentation/widgets/text_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageBottomSheet extends StatefulWidget {
  final String notificationType;
  final ContestModel contestModel;
  final String squadId;
  const MessageBottomSheet({
    Key? key,
    required this.notificationType,
    required this.contestModel,
    required this.squadId,
  }) : super(key: key);

  @override
  _MessageBottomSheetState createState() => _MessageBottomSheetState();
}

class _MessageBottomSheetState extends State<MessageBottomSheet> {
  @override
  void initState() {
    BlocProvider.of<ContestCloseCubit>(context)
        .startContestCloseStream(widget.contestModel.contestId!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      )),
      child: Column(
        children: [
          Text(widget.contestModel.contestCreatedAt.toString()),
          Text(widget.contestModel.contestTitle),
          Text(widget.contestModel.contestDescription),
          Text(widget.contestModel.contestType),
          Text(widget.contestModel.contestVisibility),
          widget.notificationType == 'uploaded'
              ? BlocBuilder<ContestCloseCubit, ContestCloseState>(
                  builder: (context, state) {
                    if (state is ContestCloseSucceed) {
                      return Expanded(
                        child: ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount:
                              state.contestCloseModel.contestApplied.length,
                          itemBuilder: (context, index) {
                            final contestApplied =
                                state.contestCloseModel.contestApplied[index];

                            return FutureBuilder<SquadModel>(
                              future: BlocProvider.of<SquadCubit>(context)
                                  .getSquadDetails(contestApplied),
                              builder: (context, snapshot) => snapshot.hasData
                                  ? CardListTile(
                                      leading: ClipOval(
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              snapshot.data!.squadProfileImg,
                                          height: 40,
                                          width: 40,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      title: snapshot.data!.squadName,
                                      trailing: state
                                              .contestCloseModel.contestAccepted
                                              .contains(contestApplied)
                                          ? const TextBtn(
                                              text: 'Accepted', onPressed: null)
                                          : TextBtn(
                                              text: 'Accept',
                                              onPressed: () {
                                                BlocProvider.of<
                                                            ContestCloseCubit>(
                                                        context)
                                                    .acceptCloseContest(
                                                        widget.contestModel
                                                            .contestId!,
                                                        contestApplied);
                                              }),
                                    )
                                  : const SizedBox(),
                            );
                          },
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                )
              : const SizedBox(),
          widget.notificationType == 'joined'
              ? BlocBuilder<ContestCloseCubit, ContestCloseState>(
                  builder: (context, state) {
                    if (state is ContestCloseSucceed) {
                      return state.contestCloseModel.contestAccepted
                              .contains(widget.squadId)
                          ? FutureBuilder<RoomModel>(
                              future: BlocProvider.of<RoomCubit>(context)
                                  .getRoomDetails(
                                      widget.contestModel.contestId!),
                              builder: (context, snapshot) {
                                return snapshot.hasData
                                    ? Text(snapshot.data!.password)
                                    : const SizedBox();
                              },
                            )
                          : const SizedBox();
                    }
                    return Container();
                  },
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}
