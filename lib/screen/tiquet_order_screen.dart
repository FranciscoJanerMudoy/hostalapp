import 'package:flutter/material.dart';
import 'package:hostalapp/screen/preview_screen.dart';
import 'package:provider/provider.dart';
// ignore: depend_on_referenced_packages
import 'package:pdf/pdf.dart';
// ignore: depend_on_referenced_packages
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../models/models.dart';
import '../providers/providers.dart';

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
          return Material(
            color: Colors.white,
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                title: Text(
                  'Comanda de la mesa: ${comanda.mesa}',
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                trailing: GestureDetector(
                  child: const Icon(Icons.delete),
                  onTap: () {
                    orderProvider.deleteById(comanda.mesa!);
                  },
                ),
                onTap: () {
                  displayPdf('HOSTAL ALGAIDA', comanda, context);
                },
              ),
            ),
          );
        },
      ),
    );
  }

  void displayPdf(String title, Comanda comanda, BuildContext context) async {
    final doc = pw.Document();
    final font = await PdfGoogleFonts.nunitoExtraLight();
    final productos = comanda.productos;
    // ignore: use_build_context_synchronously
    final Size size = MediaQuery.of(context).size;

    doc.addPage(
      pw.Page(
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
                      fontSize: 32,
                    ),
                  ),
                ),
              ),
              pw.SizedBox(height: 20),
              pw.Row(
                children: [
                  pw.Text(
                    'Comanda #${comanda.id}',
                    style: const pw.TextStyle(fontSize: 20),
                  ),
                  pw.SizedBox(width: size.width * 0.6),
                  pw.Text(
                    'Mesa: ${comanda.mesa}',
                    style: const pw.TextStyle(fontSize: 20),
                  ),
                ],
              ),
              pw.SizedBox(height: 20),
              pw.Divider(thickness: 2),
              pw.SizedBox(height: 20),
              pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.Text(
                    'Cantidad',
                    style: const pw.TextStyle(fontSize: 16),
                  ),
                  pw.Text(
                    'Descripción',
                    style: const pw.TextStyle(fontSize: 16),
                  ),
                  pw.Text(
                    'Importe (€)',
                    style: pw.TextStyle(fontSize: 16, fontFallback: [font]),
                  ),
                ],
              ),
              pw.SizedBox(height: 10),
              for (var producto in productos!)
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.Text(
                          'x${producto.cantidad}',
                          style: const pw.TextStyle(fontSize: 14),
                        ),
                        pw.Expanded(
                          child: pw.Text(
                            '${producto.descripcion}',
                            style: const pw.TextStyle(fontSize: 14),
                          ),
                        ),
                        pw.Text(
                          producto.precio!.toStringAsFixed(2),
                          style: const pw.TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 8),
                  ],
                ),
              pw.SizedBox(height: 20),
              pw.Divider(thickness: 2),
              pw.SizedBox(height: 10),
              pw.Text(
                'Precio Total: ${comanda.precio!.toStringAsFixed(2)} €',
                style: pw.TextStyle(fontSize: 16, fontFallback: [font]),
              ),
            ],
          );
        },
      ),
    );

    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PreviewScreen(doc: doc),
      ),
    );
  }
}
