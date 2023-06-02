import 'package:flutter/material.dart';
import 'package:hostalapp/screen/preview_screen.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
// ignore: depend_on_referenced_packages
import 'package:pdf/pdf.dart';

import '../models/models.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';

class TiquetScreen extends StatelessWidget {
  const TiquetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderProvider = Provider.of<OrderProvider>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Comandas finalizadas"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: orderProvider.comandasByType.length,
        itemBuilder: (context, index) {
          Comanda comanda = orderProvider.comandasByType[index];
          return ListTile(
            title: Text(
              'Comanda de la mesa: ${comanda.mesa.toString()}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              /*
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PreviewScreen(doc: doc)));
                      */
            },
          );
        },
      ),
    );
  }

/*
  void dipslayPdf(PdfPageFormat format, String title, Comanda comanda) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await PdfGoogleFonts.nunitoExtraLight();
    final productos = comanda.productos;

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.SizedBox(
                width: double.infinity,
                child: pw.FittedBox(
                  child: pw.Text(
                    title,
                    style: pw.TextStyle(
                      font: font,
                      color: const PdfColor.fromInt(0xFF006400),
                    ),
                  ),
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Text(
                'ID: ${comanda.id}',
                style: const pw.TextStyle(fontSize: 16),
              ),
              pw.Text(
                'Mesa: ${comanda.mesa}',
                style: const pw.TextStyle(fontSize: 16),
              ),
              for (var producto in productos!)
                pw.Text(
                  '${producto.nombre} ${producto.cantidad}',
                  style: const pw.TextStyle(fontSize: 16),
                ),
              pw.Text(
                'Precio: ${comanda.precio}/€',
                style: const pw.TextStyle(fontSize: 16),
              ),
            ],
          );
        },
      ),
    );
  }
}
*/
}
