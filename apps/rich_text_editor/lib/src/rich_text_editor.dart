import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class RichTextEditor extends StatefulWidget {
  const RichTextEditor({Key? key, required this.textSpan}) : super(key: key);

  final TextSpan textSpan;

  @override
  State<RichTextEditor> createState() => RichTextEditorState();
}

class RichTextEditorState extends State<RichTextEditor> {
  @override
  Widget build(BuildContext context) {
    return _RichTextEditor();
  }
}

class _RichTextEditor extends MultiChildRenderObjectWidget {
  @override
  RenderRichTextEditor createRenderObject(BuildContext context) {
    return RenderRichTextEditor();
  }
}

class TextParentData extends ContainerBoxParentData<RenderBox> {
  double? scale;
}

class RenderRichTextEditor extends RenderBlock {}

class RenderBlock extends RenderBox
    with
        RelayoutWhenSystemFontsChangeMixin,
        ContainerRenderObjectMixin<RenderBox, TextParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, TextParentData>
    implements TextLayoutMetrics {
  @override
  TextSelection getLineAtOffset(TextPosition position) {
    // TODO: implement getLineAtOffset
    throw UnimplementedError();
  }

  @override
  TextPosition getTextPositionAbove(TextPosition position) {
    // TODO: implement getTextPositionAbove
    throw UnimplementedError();
  }

  @override
  TextPosition getTextPositionBelow(TextPosition position) {
    // TODO: implement getTextPositionBelow
    throw UnimplementedError();
  }

  @override
  TextRange getWordBoundary(TextPosition position) {
    // TODO: implement getWordBoundary
    throw UnimplementedError();
  }
}
