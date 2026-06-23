import 'package:bus_mate_bd/features/notification/providers/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  static const String name = '/notification';

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<NotificationProvider>();

    return Scaffold(
      appBar: AppBar(title: Text("Notifications (${provider.count})")),

      body: ListView.builder(
        itemCount: provider.festivals.length,

        itemBuilder: (_, index) {
          final item = provider.festivals[index];

          return ListTile(
            leading: const Icon(Icons.notifications),

            title: Text(item.title),

            subtitle: Text(item.date.toString()),

            trailing: IconButton(
              icon: const Icon(Icons.delete),

              onPressed: () {
                provider.deleteFestival(index);
              },
            ),
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          provider.addFestival(title: "Eid", date: DateTime.now());
        },

        child: const Icon(Icons.add),
      ),
    );
  }
}
