import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<BitmapDescriptor> createCustomMarkerIcon(
  String imagePath,
  double rating,
  BuildContext context,
) async {
  final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
  final ui.Canvas canvas = Canvas(pictureRecorder);

  // Device pixel ratio for crisp rendering
  final double dpr = MediaQuery.of(context).devicePixelRatio;

  // Optimal base dimensions (logical pixels)
  const double baseWidth = 70;
  const double baseHeight = 90;

  final double width = baseWidth * dpr;
  final double height = baseHeight * dpr;

  // Draw white rounded rectangle background
  final Paint bgPaint = Paint()..color = Colors.white;
  final RRect bgRect = RRect.fromRectAndRadius(
    Rect.fromLTWH(0, 0, width, height),
    Radius.circular(15 * dpr),
  );
  canvas.drawRRect(bgRect, bgPaint);

  // Draw circular restaurant image
  final ui.Image image = await _loadImageFromAsset(imagePath, context);
  final double imageRadius = 25 * dpr;
  final Offset imageCenter = Offset(width / 2, imageRadius + 10 * dpr);

  canvas.save();
  canvas.clipPath(Path()..addOval(Rect.fromCircle(center: imageCenter, radius: imageRadius)));
  paintImage(
    canvas: canvas,
    rect: Rect.fromCircle(center: imageCenter, radius: imageRadius),
    image: image,
    fit: BoxFit.cover,
  );
  canvas.restore();

  // Draw rating container at bottom center
  final double ratingHeight = 20 * dpr;
  final double ratingWidth = 50 * dpr;
  final double ratingX = (width - ratingWidth) / 2;
  final double ratingY = height - ratingHeight - 8 * dpr;

  final RRect ratingRect = RRect.fromRectAndRadius(
    Rect.fromLTWH(ratingX, ratingY, ratingWidth, ratingHeight),
    Radius.circular(5 * dpr),
  );
  final Paint ratingBg = Paint()..color = const Color(0xFFA93929);
  canvas.drawRRect(ratingRect, ratingBg);

  // Draw star
  final double starSize = 12 * dpr;
  final TextPainter starPainter = TextPainter(textDirection: TextDirection.ltr);
  starPainter.text = TextSpan(
    text: '★',
    style: TextStyle(fontSize: starSize, color: Colors.white, fontWeight: FontWeight.bold),
  );
  starPainter.layout();

  // Draw rating text
  final double fontSize = 12 * dpr;
  final TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr);
  textPainter.text = TextSpan(
    text: rating.toStringAsFixed(1),
    style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.white),
  );
  textPainter.layout();

  // Center star + text horizontally in the rating container
  const double spacing = 4 * 1.0; // spacing between star and rating
  final double totalWidth = starPainter.width + spacing + textPainter.width;
  final double startX = ratingX + (ratingWidth - totalWidth) / 2;
  final double starY = ratingY + (ratingHeight - starPainter.height) / 2;
  final double textY = ratingY + (ratingHeight - textPainter.height) / 2;

  starPainter.paint(canvas, Offset(startX, starY));
  textPainter.paint(canvas, Offset(startX + starPainter.width + spacing, textY));

  // Convert to BitmapDescriptor
  final ui.Image markerAsImage =
      await pictureRecorder.endRecording().toImage(width.toInt(), height.toInt());
  final ByteData? byteData =
      await markerAsImage.toByteData(format: ui.ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
}

// Helper function to load image from asset
Future<ui.Image> _loadImageFromAsset(String path, BuildContext context) async {
  final data = await DefaultAssetBundle.of(context).load(path);
  final bytes = data.buffer.asUint8List();
  final codec = await ui.instantiateImageCodec(bytes);
  final frame = await codec.getNextFrame();
  return frame.image;
}
