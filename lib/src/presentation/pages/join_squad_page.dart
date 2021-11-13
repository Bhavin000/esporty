import 'package:cached_network_image/cached_network_image.dart';
import 'package:esporty/src/data/models/squad_model.dart';
import 'package:esporty/src/logic/cubits/player_cubit/player_cubit.dart';
import 'package:esporty/src/logic/cubits/squad_cubit/squad_cubit.dart';
import 'package:esporty/src/presentation/widgets/card_list_tile.dart';
import 'package:esporty/src/presentation/widgets/elevated_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class JoinSquadPage extends StatefulWidget {
  const JoinSquadPage({Key? key}) : super(key: key);

  @override
  _JoinSquadPageState createState() => _JoinSquadPageState();
}

class _JoinSquadPageState extends State<JoinSquadPage> {
  List<SquadModel> listSquads = [];
  late List<SquadModel> searchedSquads;

  @override
  void initState() {
    searchedSquads = [];
    super.initState();
    getAllSquads();
  }

  getAllSquads() async {
    listSquads = await BlocProvider.of<SquadCubit>(context).getAllSquads();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join Squad'),
        elevation: 0,
      ),
      body: Column(
        children: [
          searchSquad(),
          Expanded(child: squadList()),
        ],
      ),
    );
  }

  Widget squadList() {
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      itemCount: searchedSquads.length,
      itemBuilder: (context, index) => CardListTile(
        title: searchedSquads[index].squadName,
        subtitle: searchedSquads[index].squadId.toString(),
        onPressed: () {
          openBottomSheet(searchedSquads[index]);
        },
      ),
    );
  }

  void openBottomSheet(SquadModel _squadModel) {
    showModalBottomSheet(
      isDismissible: true,
      backgroundColor: Colors.amber,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
      ),
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        height: 300,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        )),
        child: Column(
          children: [
            SizedBox(
              height: 80,
              width: 80,
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: _squadModel.squadProfileImg,
                  alignment: Alignment.center,
                  placeholder: (context, url) =>
                      const ColoredBox(color: Colors.green),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Text(_squadModel.squadName),
            Text(_squadModel.squadSelectedGame),
            ElevatedBtn(
                label: 'Apply',
                onPressed: () {
                  BlocProvider.of<PlayerCubit>(context)
                      .requestToJoinSquad(_squadModel.squadId!);
                }),
          ],
        ),
      ),
    );
  }

  Widget searchSquad() {
    return TextField(
      autofocus: true,
      textAlign: TextAlign.start,
      style: Theme.of(context).textTheme.bodyText1,
      textAlignVertical: TextAlignVertical.center,
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        border: InputBorder.none,
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 24),
        hintText: "Search Here...",
        prefixIcon: Icon(Icons.search),
      ),
      onChanged: (value) {
        setState(() {
          if (value.isEmpty) {
            searchedSquads = [];
          } else {
            searchedSquads = listSquads
                .where((element) => element.squadName.startsWith(value))
                .toList();
          }
        });
      },
    );
  }
}
