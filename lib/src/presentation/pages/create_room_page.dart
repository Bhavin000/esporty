import 'package:esporty/src/constants/games.dart';
import 'package:esporty/src/logic/cubits/contest_cubit/contest_cubit.dart';
import 'package:esporty/src/presentation/widgets/dropdown.dart';
import 'package:esporty/src/presentation/widgets/elevated_btn.dart';
import 'package:esporty/src/presentation/widgets/text_btn.dart';
import 'package:esporty/src/presentation/widgets/tf.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CreateRoomPage extends StatefulWidget {
  final String squadId;
  const CreateRoomPage({
    Key? key,
    required this.squadId,
  }) : super(key: key);

  @override
  State<CreateRoomPage> createState() => _CreateRoomPageState();
}

class _CreateRoomPageState extends State<CreateRoomPage> {
  late GlobalKey<FormBuilderState> _formKey;
  late int _currentStep;

  List<Step> getSteps() => [
        getStep(
          0,
          'Select Game',
          [
            const SizedBox(height: 8),
            Dropdown(
              label: 'Select Game',
              data: getGameNames,
              onChanged: (value) {},
            ),
            const SizedBox(height: 8),
            Dropdown(
              label: 'Select Mode',
              data: getGameModes,
              onChanged: (value) {},
            ),
            const SizedBox(height: 8),
            Dropdown(
              label: 'Select Map',
              data: getGameMaps,
              onChanged: (value) {},
            ),
          ],
        ),
        getStep(
          1,
          'Room Details',
          [
            const SizedBox(height: 8),
            const TF(label: 'Enter Title'),
            const SizedBox(height: 12),
            const TF(label: 'Enter Description'),
            const SizedBox(height: 12),
            const TF(label: 'Enter Id'),
            const SizedBox(height: 12),
            const TF(label: 'Enter Password'),
          ],
        ),
        getStep(
          2,
          'Room Visibility',
          [
            const SizedBox(height: 8),
            Dropdown(
              label: 'Select Visibility',
              data: gameVisibility,
              onChanged: (value) {},
            ),
          ],
        ),
      ];

  @override
  void initState() {
    super.initState();
    _currentStep = 0;
    _formKey = GlobalKey<FormBuilderState>();
  }

  List<String> get getGameNames => games.keys.toList();
  List<String> get getGameModes => getSelectedGameName == null
      ? []
      : games[getSelectedGameName]!.keys.toList();
  List<String> get getGameMaps => getSelectedGameMode == null
      ? []
      : games[getSelectedGameName]![getSelectedGameMode]!.toList();

  Map<String, dynamic> get getCurrentStateValues {
    if (_formKey.currentState == null) {
      return {'Select Game': null, 'Select Mode': null, 'Select Map': null};
    }
    _formKey.currentState!.save();
    return _formKey.currentState!.value;
  }

  String? get getSelectedGameName =>
      getCurrentStateValues['Select Game'] == null
          ? null
          : getGameNames[getCurrentStateValues['Select Game']];

  String? get getSelectedGameMode =>
      getCurrentStateValues['Select Mode'] == null
          ? null
          : getGameModes[getCurrentStateValues['Select Mode']];

  String? get getSelectedGameMap => getCurrentStateValues['Select Map'] == null
      ? null
      : getGameMaps[getCurrentStateValues['Select Map']];

  String? get getSelectedGameType => getCurrentStateValues['Game Type'] == null
      ? null
      : gameType[getCurrentStateValues['Game Type']];

  String? get getSelectedGameVisibility =>
      getCurrentStateValues['Game Visibility'] == null
          ? null
          : gameVisibility[getCurrentStateValues['Game Visibility']];

  get isLastStep => _currentStep >= getSteps().length - 1 ? true : false;
  get isFirstStep => _currentStep <= 0 ? true : false;

  bool canProceed() {
    final data = getCurrentStateValues;
    switch (_currentStep) {
      case 0:
        if (data['Select Game'] == null ||
            data['Select Mode'] == null ||
            data['Select Map'] == null) {
          return false;
        }
        return true;
      case 1:
        if (data['Enter Title'] == null ||
            data['Enter Title'].isEmpty ||
            data['Enter Description'] == null ||
            data['Enter Description'].isEmpty ||
            data['Enter Id'] == null ||
            data['Enter Id'].isEmpty ||
            data['Enter Password'] == null ||
            data['Enter Password'].isEmpty) {
          return false;
        }
        return true;
      case 2:
        if (data['Select Visibility'] == null) {
          return false;
        }
        return true;
      default:
        return false;
    }
  }

  onSubmitPressed(context, _squadId) async {
    if (_squadId.isEmpty) {
      return;
    }
    final data = getCurrentStateValues;
    await BlocProvider.of<ContestCubit>(context)
        .createContest(data, 'room', _squadId);
    await Future.delayed(const Duration(milliseconds: 500));
    Navigator.of(context)
      ..pop()
      ..pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Room'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: FormBuilder(
          key: _formKey,
          onChanged: () {
            setState(() {});
          },
          child: Stepper(
            type: StepperType.vertical,
            steps: getSteps(),
            currentStep: _currentStep,
            // controlsBuilder: stepperControllsBuilder,
            onStepContinue: canProceed()
                ? () {
                    if (isLastStep) {
                      onSubmitPressed(context, widget.squadId);
                    } else {
                      setState(() => _currentStep += 1);
                    }
                  }
                : null,
            onStepCancel: isFirstStep
                ? null
                : () {
                    setState(() => _currentStep -= 1);
                  },
          ),
        ),
      ),
    );
  }

  Step getStep(int _idx, String _title, dynamic _children) {
    return Step(
      isActive: _currentStep >= _idx,
      title: Text(_title),
      content: Column(
        children: _children,
      ),
      state: _currentStep >= _idx ? StepState.complete : StepState.indexed,
    );
  }

  Widget stepperControllsBuilder(context, {onStepCancel, onStepContinue}) {
    return Row(
      children: [
        isLastStep
            ? Expanded(
                child: ElevatedBtn(label: 'Submit', onPressed: onStepContinue))
            : Expanded(
                child: ElevatedBtn(label: 'Next', onPressed: onStepContinue)),
        isFirstStep
            ? const SizedBox()
            : Expanded(
                child: TextBtn(text: 'Previous', onPressed: onStepCancel)),
      ],
    );
  }
}
