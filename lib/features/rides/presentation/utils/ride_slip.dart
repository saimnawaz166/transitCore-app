import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../../../core/utils/formatters.dart';
import '../../domain/ride_models.dart';

/// A one-page, print-ready slip with just enough to spot the passenger at
/// pickup — job ID/time to tell slips apart, the passenger's name, and both
/// addresses. Deliberately leaves out fare/vehicle/notes; this is meant to
/// be printed and carried, not a full booking record.
abstract final class RideSlip {
  static const _gold = PdfColor.fromInt(0xFFC9A227);
  static const _muted = PdfColor.fromInt(0xFF666666);

  static Future<void> printOrSave(Ride ride) async {
    final doc = pw.Document();

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a5,
        margin: const pw.EdgeInsets.all(28),
        build: (context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              'TransitCore',
              style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold, color: _gold),
            ),
            pw.Text('Ride Slip', style: const pw.TextStyle(fontSize: 11, color: _muted)),
            pw.SizedBox(height: 18),
            pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                _label('JOB ID', ride.jobId),
                _label('DATE & TIME', Formatters.dateTime(ride.scheduledAt)),
              ],
            ),
            pw.SizedBox(height: 18),
            pw.Divider(color: _muted, thickness: 0.5),
            pw.SizedBox(height: 18),
            pw.Text('PASSENGER', style: pw.TextStyle(fontSize: 9, color: _muted, letterSpacing: 1)),
            pw.SizedBox(height: 4),
            pw.Text(ride.passenger.name, style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 22),
            _locationBlock('PICKUP', ride.pickup.label, ride.pickup.address),
            pw.SizedBox(height: 18),
            _locationBlock('DROP-OFF', ride.dropoff.label, ride.dropoff.address),
          ],
        ),
      ),
    );

    await Printing.layoutPdf(onLayout: (_) => doc.save(), name: 'ride-${ride.jobId}.pdf');
  }

  static pw.Widget _label(String caption, String value) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(caption, style: pw.TextStyle(fontSize: 9, color: _muted, letterSpacing: 1)),
          pw.SizedBox(height: 2),
          pw.Text(value, style: const pw.TextStyle(fontSize: 12)),
        ],
      );

  static pw.Widget _locationBlock(String caption, String label, String address) => pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(caption, style: pw.TextStyle(fontSize: 9, color: _muted, letterSpacing: 1)),
          pw.SizedBox(height: 4),
          pw.Text(label, style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 2),
          pw.Text(address, style: const pw.TextStyle(fontSize: 11, color: _muted)),
        ],
      );
}
