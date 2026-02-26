import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'models/auto_complete_config.dart';

class AutoCompleteInput extends StatefulWidget {
  final List<Map<dynamic, dynamic>> data;
  final List<String>? searchFields;
  final String Function(Map<dynamic, dynamic>) displayBuilder;
  final Function(Map<dynamic, dynamic>) onSelected;
  final AutoCompleteConfig config;

  const AutoCompleteInput({
    Key? key,
    required this.data,
    required this.displayBuilder,
    required this.onSelected,
    this.searchFields,
    this.config = const AutoCompleteConfig(),
  }) : super(key: key);

  @override
  State<AutoCompleteInput> createState() => _AutoCompleteInputState();
}

class _AutoCompleteInputState extends State<AutoCompleteInput> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  OverlayEntry? _overlayEntry;
  List<Map<dynamic, dynamic>> _filtered = [];

  String _generateHint() {
    if (widget.config.hintText != null) {
      return widget.config.hintText!;
    }
    return "Search...";
  }

  @override
  void dispose() {
    _removeOverlay();
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _filter(String query) {
    if (query.isEmpty) {
      _filtered = [];
    } else {
      final lowerQuery = query.toLowerCase();

      _filtered = widget.data.where((item) {
        // 🔹 If searchFields is provided → use them
        if (widget.searchFields != null && widget.searchFields!.isNotEmpty) {
          return widget.searchFields!.any((field) {
            final value = item[field]?.toString().toLowerCase() ?? "";
            return value.contains(lowerQuery);
          });
        }

        // 🔹 Otherwise fallback to displayBuilder
        final displayValue = widget.displayBuilder(item).toLowerCase();

        return displayValue.contains(lowerQuery);
      }).toList();
    }

    _showOverlay();
  }

  void _showOverlay() {
    _removeOverlay();

    if (_filtered.isEmpty) return;

    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder: (context) =>
          Positioned(
            left: offset.dx,
            top: offset.dy + size.height + 5,
            width: size.width,
            child: Material(
              elevation: 4,
              borderRadius:
              BorderRadius.circular(widget.config.borderRadius),
              child: Container(
                constraints: BoxConstraints(
                  maxWidth: widget.config.maxWidth,
                  maxHeight: widget.config.maxHeight,
                ),
                decoration: BoxDecoration(
                  color: widget.config.suggestionBgColor,
                  borderRadius:
                  BorderRadius.circular(widget.config.borderRadius),
                ),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemCount: _filtered.length,
                  itemBuilder: (context, index) {
                    final item = _filtered[index];
                    return ListTile(
                      title: Text(
                        widget.displayBuilder(item),
                        style: widget.config.suggestionTextStyle,
                      ),
                      onTap: () => _select(item),
                    );
                  },
                ),
              ),
            ),
          ),
    );

    overlay.insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  void _select(Map<dynamic, dynamic> item) {
    _controller.text = widget.displayBuilder(item);
    widget.onSelected(item);
    _removeOverlay();
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.config.maxWidth,
      child: RawKeyboardListener(
        focusNode: FocusNode(),
        onKey: (event) {
          if (event.isKeyPressed(LogicalKeyboardKey.enter) &&
              _filtered.isNotEmpty) {
            _select(_filtered.first);
          }
        },
        child: TextField(
          controller: _controller,
          focusNode: _focusNode,
          decoration: InputDecoration(
            hintText: _generateHint(),
            filled: widget.config.primaryColor != null,
            fillColor: widget.config.primaryColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                  widget.config.borderRadius
              ),
            ),
          ),
          style: widget.config.inputStyle,
          onChanged: _filter,
        ),
      ),
    );
  }
}