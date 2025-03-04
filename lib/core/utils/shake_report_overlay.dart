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
        bottom: MediaQuery.of(context).size.height * 0.3,
        left: 20,
        right: 20,
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
    Future.delayed(const Duration(seconds: 3), () {
      if (_overlayEntry != null) {
        _removeOverlay();
      }
    });
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
    return const SizedBox.shrink(); // Return an empty SizedBox.
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
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Report a problem?',
            style: TextStyle(color: Colors.black),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: onConfirm,
                child: const Text('Yes'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: onCancel,
                child: const Text('No'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
