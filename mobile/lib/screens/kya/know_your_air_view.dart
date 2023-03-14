import 'package:app/blocs/blocs.dart';
import 'package:app/constants/constants.dart';
import 'package:app/models/models.dart';
import 'package:app/utils/utils.dart';
import 'package:app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'kya_title_page.dart';
import 'kya_widgets.dart';

class KnowYourAirView extends StatelessWidget {
  const KnowYourAirView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KyaBloc, KyaState>(
      builder: (context, state) {
        if (state.kya.isEmpty) {
          return NoKyaWidget(
            callBack: () {
              context.read<KyaBloc>().add(const RefreshKya());
            },
          );
        }
        final completeKya = state.kya.filterCompleteKya();
        if (completeKya.isEmpty) {
          final inCompleteKya = state.kya.filterInProgressKya();

          if (inCompleteKya.isEmpty &&
              state.status == KyaStatus.noInternetConnection) {
            return NoInternetConnectionWidget(
              callBack: () {
                _refresh(context);
              },
            );
          }

          if (inCompleteKya.isEmpty &&
              state.status == KyaStatus.noInternetConnection) {
            return NoInternetConnectionWidget(
              callBack: () {
                _refresh(context);
              },
            );
          }

          return NoCompleteKyaWidget(
            callBack: () async {
              if (inCompleteKya.isEmpty) {
                showSnackBar(context, 'Oops.. No Lessons at the moment');
              } else {
                await _startKyaLessons(context, inCompleteKya.first);
              }
            },
          );
        }

        return AppRefreshIndicator(
          sliverChildDelegate: SliverChildBuilderDelegate(
            (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  top: Config.refreshIndicatorPadding(
                    index,
                  ),
                ),
                child: KyaCardWidget(
                  completeKya[index],
                ),
              );
            },
            childCount: completeKya.length,
          ),
          onRefresh: () {
            _refresh(context);

            return Future(() => null);
          },
        );
      },
    );
  }

  void _refresh(BuildContext context) {
    context.read<KyaBloc>().add(const RefreshKya());
  }

  Future<void> _startKyaLessons(BuildContext context, Kya kya) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return KyaTitlePage(kya);
        },
      ),
    );
  }
}
