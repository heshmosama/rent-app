import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent_flutter_task/core/di/di_configuration.dart';
import 'package:rent_flutter_task/features/home/presentation/bloc/province/province_bloc.dart';
import 'package:rent_flutter_task/features/home/presentation/bloc/province/province_event.dart';
import 'package:rent_flutter_task/features/home/presentation/bloc/province/province_state.dart';
import 'package:rent_flutter_task/features/home/presentation/bloc/state-code/state_code_states.dart'
    as state_codes_state;
import 'package:rent_flutter_task/features/home/presentation/bloc/state-code/state_code_bloc.dart';
import 'package:rent_flutter_task/features/home/presentation/bloc/state-code/state_code_event.dart';
import 'package:rent_flutter_task/features/home/presentation/wedgits/search_widget.dart';
import '../../../../core/utils/builders.dart';

class HeaderWidget extends StatefulWidget {
  final Function(String)? onTextChanged;
  final Function(int?) onStateCodeChanged;
  final Function(String?) onProvinceChanged;
  const HeaderWidget(
      {Key? key,
      this.onTextChanged,
      required this.onStateCodeChanged,
      required this.onProvinceChanged})
      : super(key: key);

  @override
  State<HeaderWidget> createState() => HeaderWidgetState();
}

class HeaderWidgetState extends State<HeaderWidget> {
  int initStateCodeValue = -1;
  String initProvinceValue = 'All';
  late final ProvincesBloc _provinceBloc;
  late final StateCodeBloc _stateCodeBloc;
  final List<String> _provinces = [];
  final List<int> _stateCodes = [];

  @override
  void initState() {
    _provinceBloc = getIt<ProvincesBloc>();
    _stateCodeBloc = getIt<StateCodeBloc>();
    _stateCodeBloc.add(GetAllStateCodeEvent());
    _provinces.add(initProvinceValue);
    _stateCodes.add(initStateCodeValue);

    _provinceBloc.add(GetAllProvinceEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 16.0,
          ),
          Expanded(
              child: SearchField(
            onChange: widget.onTextChanged,
          )),
          const SizedBox(
            width: 16.0,
          ),
          const Icon(Icons.filter_alt),
          const SizedBox(
            width: 16.0,
          ),
          const Text('State code'),
          const SizedBox(
            width: 16.0,
          ),
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: BlocConsumer(
                  bloc: _stateCodeBloc,
                  builder: (context, state) {
                    if (state is state_codes_state.Loading) {
                      return buildLoadingWidget();
                    } else if (state is state_codes_state.Loaded) {
                      return buildStateCodeDropDown(_stateCodes);
                    }
                    return Container();
                  },
                  listener: (context, state) {
                    if (state is state_codes_state.Error) {
                      showSnackBar(context, state.message);
                    } else if (state is state_codes_state.Loaded) {
                      _stateCodes.addAll(state.codes);
                    }
                  })),
          const SizedBox(
            width: 16.0,
          ),
          const Text('Province'),
          const SizedBox(
            width: 16.0,
          ),
          BlocConsumer(
              bloc: _provinceBloc,
              builder: ((context, state) {
                if (state is Empty) {
                  return Container();
                } else if (state is Loaded) {
                  return buildProvinceDropDown(_provinces);
                } else if (state is Loading) {
                  return buildLoadingWidget();
                }
                return Container();
              }),
              listener: (context, state) {
                if (state is Error) {
                  showSnackBar(context, state.message);
                } else if (state is Loaded) {
                  _provinces.addAll(state.provinces);
                }
              }),
          const SizedBox(
            width: 16.0,
          ),
        ],
      );

  DropdownButton buildStateCodeDropDown(List<int> stateCodes) => DropdownButton(
      value: initStateCodeValue,
      focusColor: Colors.transparent,
      items: List.generate(
        stateCodes.length,
        (index) => DropdownMenuItem(
            value: stateCodes[index],
            child: Text(index == 0 ? 'All' : stateCodes[index].toString())),
      ),
      onChanged: (value) {
        setState(() {
          initStateCodeValue = value!;
          widget.onStateCodeChanged(value);
        });
      });

  DropdownButton buildProvinceDropDown(List<String> provinces) =>
      DropdownButton(
          value: initProvinceValue,
          focusColor: Colors.transparent,
          items: List.generate(
              provinces.length,
              (index) => DropdownMenuItem(
                  value: provinces[index], child: Text(provinces[index]))),
          onChanged: (value) {
            setState(() {
              initProvinceValue = value;
              widget.onProvinceChanged(value);
            });
          });
}
