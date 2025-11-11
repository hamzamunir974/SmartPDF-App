import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class DashboardTab extends GetView<HomeController> {
  const DashboardTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SmartPDF'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(() => controller.error.value.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Text(
                              controller.error.value,
                              style: const TextStyle(
                                color: Colors.red,
                                fontSize: 14,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : const SizedBox()),
                    _ConversionCard(
                      title: 'PDF to Word',
                      icon: Icons.picture_as_pdf,
                      color: Colors.blue,
                      onTap: () => Get.toNamed('/convert', arguments: {'from': 'pdf', 'to': 'docx'}),
                    ),
                    const SizedBox(height: 20),
                    _ConversionCard(
                      title: 'Word to PDF',
                      icon: Icons.description,
                      color: Colors.red,
                      onTap: () => Get.toNamed('/convert', arguments: {'from': 'docx', 'to': 'pdf'}),
                    ),
                  ],
                ),
              ),
              Obx(() => controller.isLoading.value
                  ? Column(
                      children: [
                        LoadingAnimationWidget.threeArchedCircle(
                          color: Theme.of(context).primaryColor,
                          size: 30,
                        ),
                        const SizedBox(height: 10),
                        LinearProgressIndicator(
                          value: controller.progress.value,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '${(controller.progress.value * 100).toStringAsFixed(0)}%',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    )
                  : const SizedBox()),
            ],
          ),
        ),
      ),
    );
  }
}

class _ConversionCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ConversionCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Icon(
                icon,
                size: 48,
                color: color,
              ),
              const SizedBox(height: 10),
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
