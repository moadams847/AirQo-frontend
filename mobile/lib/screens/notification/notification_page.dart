import 'package:app/blocs/blocs.dart';
import 'package:app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'notification_widgets.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppTopBar('Notifications'),
      body: AppSafeArea(
        widget: BlocBuilder<NotificationBloc, NotificationState>(
          buildWhen: (previous, current) {
            return previous.notifications != current.notifications;
          },
          builder: (context, state) {
            if (state.notifications.isEmpty) {
              context
                  .read<NotificationBloc>()
                  .add(const RefreshNotifications());

              return const EmptyNotifications();
            }

            return AppRefreshIndicator(
              sliverChildDelegate: SliverChildBuilderDelegate(
                (context, index) {
                  return Padding(
                    padding:
                        EdgeInsets.fromLTRB(16, index == 0 ? 24.0 : 4, 16, 4),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return NotificationView(
                                appNotification: state.notifications[index],
                              );
                            },
                          ),
                        );
                      },
                      child: NotificationCard(
                        appNotification: state.notifications[index],
                      ),
                    ),
                  );
                },
                childCount: state.notifications.length,
              ),
              onRefresh: () {
                _refresh(context);

                return Future(() => null);
              },
            );
          },
        ),
      ),
    );
  }

  void _refresh(BuildContext context) {
    context.read<NotificationBloc>().add(const RefreshNotifications());
  }
}
