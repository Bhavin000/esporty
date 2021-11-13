import 'package:esporty/src/presentation/routes/route_definations.dart';
import 'package:esporty/src/presentation/widgets/elevated_btn.dart';
import 'package:flutter/material.dart';

class CreateContestPage extends StatelessWidget {
  final String squadId;
  const CreateContestPage({
    Key? key,
    required this.squadId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Contest'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedBtn(
              label: 'Create Room',
              onPressed: () {
                Navigator.of(context).pushNamed(
                  Routes.createRoomPage,
                  arguments: squadId,
                );
              },
            ),
            ElevatedBtn(
              label: 'Create Tournament',
              onPressed: () {
                Navigator.of(context).pushNamed(Routes.createTournamentPage);
              },
            ),
          ],
        ),
      ),
    );
  }
}
