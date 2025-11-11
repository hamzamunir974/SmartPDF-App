import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/conversion_controller.dart';

class ConversionPage extends GetView<ConversionController> {
  const ConversionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, String>?;
    final fromFormat = args?['from'] ?? 'pdf';
    final toFormat = args?['to'] ?? 'docx';
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Convert ${fromFormat.toUpperCase()} to ${toFormat.toUpperCase()}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => Get.toNamed('/history'),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : const SizedBox.shrink()),
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'PDF to Word',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () => controller.convertFile('pdf', 'docx'),
                        icon: const Icon(Icons.upload_file),
                        label: const Text('Convert PDF to Word'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Word to PDF',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () => controller.convertFile('docx', 'pdf'),
                        icon: const Icon(Icons.upload_file),
                        label: const Text('Convert Word to PDF'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Obx(() => controller.progress.value > 0
                  ? Column(
                      children: [
                        LinearProgressIndicator(
                          value: controller.progress.value,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${(controller.progress.value * 100).toStringAsFixed(1)}%',
                        ),
                      ],
                    )
                  : const SizedBox.shrink()),
              const SizedBox(height: 16),
              Obx(() => controller.error.value.isNotEmpty
                  ? Text(
                      controller.error.value,
                      style: const TextStyle(color: Colors.red),
                    )
                  : const SizedBox.shrink()),
            ],
          ),
        ),
      ),
    );
  }
}
