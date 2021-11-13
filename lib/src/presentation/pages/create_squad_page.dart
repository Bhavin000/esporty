import 'package:esporty/src/constants/games.dart';
import 'package:esporty/src/logic/cubits/image_util_cubit/image_util_cubit.dart';
import 'package:esporty/src/logic/cubits/squad_cubit/squad_cubit.dart';
import 'package:esporty/src/presentation/routes/route_definations.dart';
import 'package:esporty/src/presentation/widgets/bnr.dart';
import 'package:esporty/src/presentation/widgets/dropdown.dart';
import 'package:esporty/src/presentation/widgets/elevated_btn.dart';
import 'package:esporty/src/presentation/widgets/image_selector.dart';
import 'package:esporty/src/presentation/widgets/text_btn.dart';
import 'package:esporty/src/presentation/widgets/tf.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CreateSquadPage extends StatefulWidget {
  const CreateSquadPage({Key? key}) : super(key: key);

  @override
  State<CreateSquadPage> createState() => _CreateSquadPageState();
}

class _CreateSquadPageState extends State<CreateSquadPage> {
  late GlobalKey<FormBuilderState> _formKey;
  late int _currentStep;
  late String _imageUrl;

  List<Step> getSteps() => [
        Step(
          isActive: _currentStep >= 0,
          title: const Text('Select Game'),
          content: Column(
            children: [
              const SizedBox(height: 8),
              Dropdown(
                label: 'Select Game',
                data: games.keys.toList(),
                onChanged: (idx) {
                  setState(() {});
                },
              ),
            ],
          ),
          state: _currentStep >= 0 ? StepState.complete : StepState.indexed,
        ),
        Step(
          isActive: _currentStep >= 1,
          title: const Text('Squad Details'),
          content: Column(
            children: [
              const SizedBox(height: 12),
              ImageSelector(onPressed: () {
                BlocProvider.of<ImageUtilCubit>(context)
                    .uploadSquadProfileImg();
              }),
              const SizedBox(height: 22),
              const TF(label: 'Enter Name'),
            ],
          ),
          state: _currentStep >= 1 ? StepState.complete : StepState.indexed,
        ),
      ];

  @override
  void initState() {
    super.initState();
    _currentStep = 0;
    _formKey = GlobalKey<FormBuilderState>();
    _imageUrl = '';
  }

  Map<String, dynamic> get getCurrentStateValues {
    if (_formKey.currentState == null) {
      return {'Select Game': null, 'Enter Name': null};
    }
    _formKey.currentState!.save();
    return _formKey.currentState!.value;
  }

  String get getSelectedGameName =>
      games.keys.toList()[getCurrentStateValues['Select Game']];

  get isLastStep => _currentStep >= getSteps().length - 1 ? true : false;
  get isFirstStep => _currentStep <= 0 ? true : false;

  bool canProceed() {
    final data = getCurrentStateValues;
    switch (_currentStep) {
      case 0:
        if (data['Select Game'] == null) {
          return false;
        }
        return true;
      case 1:
        if (data['Enter Name'] == null ||
            data['Enter Name'].isEmpty ||
            _imageUrl.isEmpty) {
          return false;
        }
        return true;
      default:
        return false;
    }
  }

  onSubmitPressed(context) async {
    final data = getCurrentStateValues;

    BlocProvider.of<SquadCubit>(context)
        .createSquad(data['Enter Name'], _imageUrl, getSelectedGameName);

    final result =
        await BlocProvider.of<SquadCubit>(context).isSquadDetailsCompleted();
    if (result == true) {
      await Future.delayed(const Duration(milliseconds: 500));
      Navigator.of(context).pushReplacementNamed(Routes.bottomNavigator);
    } else {
      bnr(context, 'failed to complete profile!! Try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ImageUtilCubit, ImageUtilState>(
      listener: (context, imageState) {
        if (imageState is ImageSquadProfileImgUploadSucceed) {
          setState(() {
            _imageUrl = imageState.imageUrl;
          });
        } else {
          setState(() {
            _imageUrl = '';
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Create Squad'),
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
              controlsBuilder: stepperControllsBuilder,
              onStepContinue: canProceed()
                  ? () {
                      if (isLastStep) {
                        onSubmitPressed(context);
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
      ),
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
