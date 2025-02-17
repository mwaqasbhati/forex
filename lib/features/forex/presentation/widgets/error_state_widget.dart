import 'package:flutter/material.dart';

class ErrorStateWidget extends StatelessWidget {
  final String? errorMessage;

  const ErrorStateWidget({Key? key, this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error, color: Colors.red, size: 40),
          const SizedBox(height: 8),
          const Text(
            'Something went wrong!',
            style: TextStyle(fontSize: 16, color: Colors.red),
          ),
          const SizedBox(height: 4),
          Text(
            errorMessage ?? '',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
