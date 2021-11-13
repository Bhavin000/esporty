import 'package:esporty/src/data/models/player_model.dart';
import 'package:esporty/src/presentation/routes/route_definations.dart';
import 'package:esporty/src/presentation/widgets/icon_btn.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class NavDef {
  static const List<Map<String, dynamic>> screensData = [
    {
      'label': 'home',
      'icon': EvaIcons.home,
      'activeIcon': EvaIcons.homeOutline,
    },
    {
      'label': 'squad',
      'icon': EvaIcons.people,
      'activeIcon': EvaIcons.peopleOutline,
    },
    {
      'label': 'notifications',
      'icon': EvaIcons.email,
      'activeIcon': EvaIcons.emailOutline,
    },
    {
      'label': 'instant games',
      'icon': EvaIcons.grid,
      'activeIcon': EvaIcons.gridOutline,
    }
  ];

  static List<Map<String, dynamic>> appBarData(
          BuildContext context, PlayerModel playerModel) =>
      [
        {
          'title': const Text('eSporty'),
          'actions': [
            IconBtn(
              onPressed: () {},
              size: 24,
              icon: EvaIcons.search,
            ),
            const SizedBox(width: 12),
          ],
        },
        {
          'title': const Text('Chatty'),
          'actions': [
            IconBtn(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  Routes.squadNoticationsPage,
                  arguments: playerModel.playerSquadJoined,
                );
              },
              size: 24,
              icon: EvaIcons.bellOutline,
            ),
            const SizedBox(width: 12),
          ],
        },
        {
          'title': const Text('Notifications'),
        },
        {
          'title': const Text('Instant Games'),
        },
      ];
}
