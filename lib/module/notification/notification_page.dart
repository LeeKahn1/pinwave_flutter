import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:tubes_pinwave/api/endpoint/notification/list/notification_list_response.dart';
import 'package:tubes_pinwave/api/endpoint/notification/list/notification_list_response_item.dart';
import 'package:tubes_pinwave/helper/dialogs.dart';
import 'package:tubes_pinwave/helper/formats.dart';
import 'package:tubes_pinwave/helper/generals.dart';
import 'package:tubes_pinwave/module/nav_menu/nav_menu_bloc.dart';
import 'package:tubes_pinwave/module/notification/notification_bloc.dart';
import 'package:tubes_pinwave/widgets/custom_shimmer.dart';
import 'package:tubes_pinwave/widgets/no_data.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  bool loading = true;
  NotificationListResponse? notificationListResponse;

  @override
  void initState() {
    super.initState();

    refresh(true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationBloc, NotificationState>(
      listener: (context, state) {
        if (state is NotificationGetDataLoading) {
          setState(() {
            loading = true;
            notificationListResponse = null;
          });
        } else if (state is NotificationGetDataSuccess) {
          setState(() {
            notificationListResponse = state.notificationListResponse;
          });
        } else if (state is NotificationGetDataFinished) {
          setState(() {
            loading = false;
          });
        } else if (state is NotificationLoading) {
          context.loaderOverlay.show();
        } else if (state is NotificationFinished) {
          context.loaderOverlay.hide();
        } else if (state is NotificationRealAllSuccess) {
          refresh(false);

          Generals.showSnackBar(context, "Berhasil menandai semua telah dibaca");

          context.read<NavMenuBloc>().add(NavMenuGetUnreadNotification());
        } else if (state is NotificationReadByIdSuccess) {
          refresh(false);

          Generals.showSnackBar(context, "Berhasil menandai notifikasi terpilih telah dibaca");

          context.read<NavMenuBloc>().add(NavMenuGetUnreadNotification());
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Notifications'),
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 1,
        ),
        body: body(),
      ),
    );
  }

  Widget body() {
    if (loading) {
      return CustomShimmer();
    }

    if (notificationListResponse!.notifications.isEmpty) {
      return RefreshIndicator(
        onRefresh: () async => refresh(true),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: NoData()
        )
      );
    }

    return RefreshIndicator(
      onRefresh: () async => refresh(true),
      child: ListView.builder(
        itemCount: notificationListResponse!.notifications.length,
        itemBuilder: (context, index) {
          NotificationListResponseItem item = notificationListResponse!.notifications[index];

          return NotificationCard(
            title: item.message,
            imageUrl: 'assets/logo.jpeg',
            time: Formats.convertToAgo(item.createdAt),
            markRead: item.readAt == null,
            onTap: () {
              if (item.readAt == null) {
                Dialogs.confirmation(
                  context: context,
                  title: "Tandai telah dibaca?",
                  positiveCallback: () {
                    context.read<NotificationBloc>().add(NotificationReadById(notificationId: item.id));
                  },
                );
              }
            }, // Example time
          );
        },
      ),
    );
  }

  void refresh(bool isLoading) {
    context.read<NotificationBloc>().add(NotificationGetData(isLoading: isLoading));
  }
}

class NotificationCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String time;
  final bool markRead;
  final void Function() onTap;

  const NotificationCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.time,
    required this.markRead,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      color: markRead ? Colors.blue : Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.asset(
                  imageUrl,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: markRead ? null : Colors.blue
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      time,
                      style: TextStyle(
                        fontSize: 12,
                        color: markRead ? Colors.white : Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}