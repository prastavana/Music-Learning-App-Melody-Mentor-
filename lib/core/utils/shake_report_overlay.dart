import 'dart:async';

import 'package:flutter/material.dart';

import 'shake_detector.dart';

class ShakeReportOverlay extends StatefulWidget {
  final GlobalKey<OverlayState> overlayKey;

  const ShakeReportOverlay({Key? key, required this.overlayKey})
      : super(key: key);

  @override
  _ShakeReportOverlayState createState() => _ShakeReportOverlayState();
}

class _ShakeReportOverlayState extends State<ShakeReportOverlay> {
  final ShakeDetector _shakeDetector = ShakeDetector();
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _shakeDetector.startListening(() {
      _showReportWidget();
    });
  }

  @override
  void dispose() {
    _shakeDetector.stopListening();
    super.dispose();
  }

  void _showReportWidget() {
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: ReportConfirmationWidget(
          onConfirm: () {
            _confirmReport();
          },
          onCancel: () {
            _removeOverlay();
          },
        ),
      ),
    );
    widget.overlayKey.currentState?.insert(_overlayEntry!);
  }

  void _confirmReport() {
    setState(() {
      _showConfirmReportMessage();
    });
  }

  void _showConfirmReportMessage() {
    final confirmationEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: 20,
        left: 20,
        right: 20,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            'Problem reported!',
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );

    widget.overlayKey.currentState?.insert(confirmationEntry);

    Future.delayed(const Duration(seconds: 3), () {
      confirmationEntry.remove();
    });
    _removeOverlay();
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}

class ReportConfirmationWidget extends StatelessWidget {
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const ReportConfirmationWidget({
    Key? key,
    required this.onConfirm,
    required this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final overlayHeight = screenHeight * 0.35;

    return Material(
      elevation: 8,
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: Container(
        height: overlayHeight,
        decoration: const BoxDecoration(
          color: Color(0xFFF9F9F9),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Report a Problem',
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'If you are experiencing a problem, please let us know. We will investigate and fix it.',
                  style: TextStyle(color: Color(0xFF666666), fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: onConfirm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE53935),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                      ),
                      icon: const Icon(Icons.report_problem, size: 20),
                      label: const Text('Report'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: onCancel,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                      ),
                      icon: const Icon(Icons.cancel, size: 20),
                      label: const Text('Cancel'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
