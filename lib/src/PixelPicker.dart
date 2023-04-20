import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:pick_color/pick_color.dart';
import 'package:pick_color/src/FindPixelColor.dart';

class ColorPicker extends StatefulWidget {
  final Widget child;
  final Widget? trackerImage;
  final Function(PickerResponse color) onChanged;

  const ColorPicker(
      {Key? key,
      required this.child,
      required this.onChanged,
      this.trackerImage})
      : super(key: key);

  @override
  _ColorPickerState createState() => _ColorPickerState();
}

extension hexcode on Color {
  String getHexCode() {
    return '#${this.value.toRadixString(16)}';
  }
}

class _ColorPickerState extends State<ColorPicker> {
  FindPixelColor? _colorPicker;
  Offset fingerPostion = Offset(0, 0);
  Color? selectedColor;

  final _repaintBoundaryKey = GlobalKey();
  final _interactiveViewerKey = GlobalKey();

  Future<ui.Image> _loadSnapshot() async {
    final RenderRepaintBoundary _repaintBoundary =
        _repaintBoundaryKey.currentContext!.findRenderObject()
            as RenderRepaintBoundary;

    final _snapshot = await _repaintBoundary.toImage();

    return _snapshot;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      children: [
        RepaintBoundary(
          key: _repaintBoundaryKey,
          child: InteractiveViewer(
            key: _interactiveViewerKey,
            maxScale: 10,
            onInteractionStart: ((details) {
              final _offset = details.focalPoint;
              fingerPostion = details.focalPoint;
              _onInteract(_offset);
            }),
            onInteractionUpdate: (details) {
              final _offset = details.focalPoint;
              fingerPostion = details.focalPoint;
              _onInteract(_offset);
            },
            child: widget.child,
          ),
        ),
        Positioned(
            left: fingerPostion.dx,
            top: fingerPostion.dy - 30,
            child: widget.trackerImage == null
                ? Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Colors.white, width: 1)),
                  )
                : widget.trackerImage!)
      ],
    );
  }

  _onInteract(Offset offset) async {
    if (_colorPicker == null) {
      final _snapshot = await _loadSnapshot();

      final _imageByteData =
          await _snapshot.toByteData(format: ui.ImageByteFormat.png);

      final _imageBuffer = _imageByteData!.buffer;

      final _uint8List = _imageBuffer.asUint8List();

      _colorPicker = FindPixelColor(bytes: _uint8List);

      _snapshot.dispose();
    }

    final _localOffset = _findLocalOffset(offset);

    final _color = await _colorPicker!.getColor(pixelPosition: _localOffset);
    selectedColor = _color;

    PickerResponse response = PickerResponse(
        selectedColor ?? Colors.black,
        selectedColor?.red ?? 0,
        selectedColor?.blue ?? 0,
        selectedColor?.green ?? 0,
        "#${selectedColor?.toHex().substring(3)}",
        fingerPostion.dx,
        fingerPostion.dy);

    widget.onChanged(response);
  }

  _findLocalOffset(Offset offset) {
    final RenderBox _interactiveViewerBox =
        _interactiveViewerKey.currentContext!.findRenderObject() as RenderBox;

    final _localOffset = _interactiveViewerBox.globalToLocal(offset);

    return _localOffset;
  }
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
