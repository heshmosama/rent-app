import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rent_flutter_task/core/di/di_configuration.dart';
import 'package:rent_flutter_task/core/utils/builders.dart';
import 'package:rent_flutter_task/features/home/domain/entities/account_entity_response.dart';
import 'package:rent_flutter_task/features/home/presentation/bloc/accounts/account_event.dart';
import 'package:rent_flutter_task/features/home/presentation/bloc/accounts/account_state.dart';
import 'package:rent_flutter_task/features/home/presentation/bloc/accounts/accounts_bloc.dart';
import 'package:rent_flutter_task/features/home/presentation/wedgits/account_item_widget.dart';
import '../../domain/entities/account_entity_request_query.dart';
import '../wedgits/header_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  late final AccountsBloc _accountsBloc;
  String searchText = '';
  final Map<String, dynamic> filterParams = {};
  @override
  void initState() {
    _accountsBloc = getIt<AccountsBloc>();
    _accountsBloc
        .add(GetAllAccounts(const AccountEntityRequestQuery(null, null)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                children: [
                  HeaderWidget(
                    onTextChanged: (value) {
                      searchText = value;
                      Future.delayed(const Duration(seconds: 3));
                      _accountsBloc.add(GetAllAccounts(
                          AccountEntityRequestQuery(value, null)));
                    },
                    onStateCodeChanged: (value) {
                      if (value == -1) {
                        filterParams.remove('statecode');
                        _accountsBloc.add(GetAllAccounts(
                            AccountEntityRequestQuery(
                                searchText, jsonEncode(filterParams))));
                      } else {
                        filterParams.addEntries([MapEntry("statecode", value)]);
                        _accountsBloc.add(GetAllAccounts(
                            AccountEntityRequestQuery(
                                searchText, jsonEncode(filterParams))));
                      }
                    },
                    onProvinceChanged: (value) {
                      if (value?.toLowerCase() == 'all') {
                        filterParams.remove('address1_stateorprovince');
                        _accountsBloc.add(GetAllAccounts(
                            AccountEntityRequestQuery(
                                searchText, jsonEncode(filterParams))));
                      } else {
                        filterParams.addEntries(
                            [MapEntry("address1_stateorprovince", value)]);
                        _accountsBloc.add(GetAllAccounts(
                            AccountEntityRequestQuery(
                                searchText, jsonEncode(filterParams))));
                      }
                    },
                  ),
                  Expanded(
                    child: SizedBox(
                      child: BlocConsumer(
                        bloc: _accountsBloc,
                        builder: ((context, state) {
                          if (state is Loaded) {
                            return _buildItems(state.accounts);
                          } else if (state is Loading) {
                            return buildLoadingWidget();
                          }
                          return Container();
                        }),
                        listener: (context, state) {
                          if (state is Error) {
                            showSnackBar(context, state.message);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      );

  Widget _buildItems(List<AccountEntityResponse> accountEntityResponse) {
    if (accountEntityResponse.isEmpty) {
      return const Center(child: Text('No Accounts'));
    }
    return ListView.builder(
        itemCount: accountEntityResponse.length,
        itemBuilder: (context, index) => AccountItemWidget(
              name: accountEntityResponse[index].name!,
              address: accountEntityResponse[index].addressComposite!,
              province: accountEntityResponse[index].addressStateOrProvince!,
              stateCode: accountEntityResponse[index].stateCode!.toString(),
              email: accountEntityResponse[index].email!,
              imageSrc: accountEntityResponse[index].imageUrl,
            ));
  }
}
