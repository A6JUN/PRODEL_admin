import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prodel_admin/blocs/suggestions/suggestions_bloc.dart';
import 'package:prodel_admin/ui/widgets/custom_action_button.dart';
import 'package:prodel_admin/ui/widgets/custom_alert_dialog.dart';
import 'package:prodel_admin/values/colors.dart';

class SuggestionScreen extends StatefulWidget {
  const SuggestionScreen({super.key});

  @override
  State<SuggestionScreen> createState() => _SuggestionScreenState();
}

class _SuggestionScreenState extends State<SuggestionScreen> {
  SuggestionsBloc suggestionsBloc = SuggestionsBloc();

  @override
  void initState() {
    suggestionsBloc.add(GetAllSuggestionEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SuggestionsBloc>.value(
      value: suggestionsBloc,
      child: Center(
        child: SizedBox(
          width: 1000,
          child: BlocConsumer<SuggestionsBloc, SuggestionsState>(
            listener: (context, state) {
              if (state is SuggestionFailureState) {
                showDialog(
                  context: context,
                  builder: (_) => CustomAlertDialog(
                    message: state.message,
                    title: 'Failure',
                    primaryButtonLabel: 'Ok',
                  ),
                );
              }
            },
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Suggestions',
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                  const Divider(
                    thickness: 1,
                    color: Color.fromARGB(255, 165, 163, 163),
                    height: 30,
                  ),
                  Expanded(
                    child: state is SuggestionLoadingState
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : state is SuggestionSuccessState
                            ? state.suggestions.isNotEmpty
                                ? DataTable2(
                                    columnSpacing: 12,
                                    horizontalMargin: 12,
                                    columns: [
                                      DataColumn2(
                                        size: ColumnSize.S,
                                        label: Text(
                                          "#ID",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ),
                                      DataColumn2(
                                        size: ColumnSize.L,
                                        label: Text(
                                          "Suggestion",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ),
                                      DataColumn2(
                                        size: ColumnSize.S,
                                        label: Text(
                                          "User Name",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ),
                                      DataColumn2(
                                        size: ColumnSize.S,
                                        label: Text(
                                          "Phone",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                      ),
                                    ],
                                    rows: List<DataRow>.generate(
                                      state.suggestions.length,
                                      (index) => DataRow(
                                        cells: [
                                          DataCell(
                                            Text(
                                              state.suggestions[index]
                                                      ['suggestion']['id']
                                                  .toString(),
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              state.suggestions[index]
                                                  ['suggestion']['feedback'],
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              state.suggestions[index]
                                                  ['profile']['name'],
                                            ),
                                          ),
                                          DataCell(
                                            Text(
                                              state.suggestions[index]
                                                  ['profile']['phone'],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : const Center(
                                    child: Text('No suggestions found !'))
                            : state is SuggestionFailureState
                                ? Center(
                                    child: CustomActionButton(
                                      onPressed: () {
                                        suggestionsBloc
                                            .add(GetAllSuggestionEvent());
                                      },
                                      label: 'Retry',
                                      iconData: Icons.refresh_outlined,
                                      mainAxisSize: MainAxisSize.min,
                                    ),
                                  )
                                : const SizedBox(),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
