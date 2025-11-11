import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../controllers/home_controller.dart';
import 'package:intl/intl.dart';

class HistoryTab extends GetView<HomeController> {
  const HistoryTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        centerTitle: true,
      ),
      body: Obx(() => controller.conversions.isEmpty
          ? Center(
              child: Text(
                'No conversions yet',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            )
          : ListView.builder(
              itemCount: controller.conversions.length,
              padding: const EdgeInsets.all(16),
              itemBuilder: (context, index) {
                final conversion = controller.conversions[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: ListTile(
                    leading: Icon(
                      conversion.originalFormat.toLowerCase() == 'pdf'
                          ? Icons.picture_as_pdf
                          : Icons.description,
                      color: Theme.of(context).primaryColor,
                    ),
                    title: Text(conversion.fileName),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${conversion.originalFormat.toUpperCase()} → ${conversion.convertedFormat.toUpperCase()}',
                        ),
                        Text(
                          DateFormat.yMMMd().add_jm().format(conversion.timestamp),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.download),
                          onPressed: () async {
                            final url = Uri.parse(conversion.downloadUrl);
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            }
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete_outline),
                          onPressed: () => controller.deleteConversion(conversion.id),
                        ),
                      ],
                    ),
                    isThreeLine: true,
                  ),
                );
              },
            )),
    );
  }
}
