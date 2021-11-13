import 'package:esporty/src/logic/cubits/squad_cubit/squad_cubit.dart';
import 'package:esporty/src/presentation/components/chats.dart';
import 'package:esporty/src/presentation/components/create_or_join_squad.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SquadScreen extends StatelessWidget {
  const SquadScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: BlocBuilder<SquadCubit, SquadState>(
          builder: (context, squadState) {
            if (squadState is SquadSucceed &&
                squadState.squadModel.squadName.isNotEmpty) {
              return Column(
                children: [
                  Expanded(child: Chats()),
                ],
              );
            }
            return const CreateOrJoinSquad();
          },
        ),
      ),
    );
  }
}
