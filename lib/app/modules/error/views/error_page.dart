import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ErrorPage extends StatelessWidget {
  final String? message;
  const ErrorPage({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 80, color: Colors.red[400]),
              const SizedBox(height: 16),
              Text(
                'Terjadi kesalahan',
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                message ?? 'Aplikasi mengalami kendala tak terduga.',
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // reload page
                  Navigator.of(context).pop();
                },
                child: const Text('Coba lagi'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
