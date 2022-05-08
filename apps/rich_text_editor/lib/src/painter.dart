part of 'rich_text_editor.dart';

abstract class RenderBlockPainter extends ChangeNotifier {
  bool shouldRepaint(covariant RenderBlockPainter? oldDelegate);

  void paint(RenderBlock renderBlock, PaintingContext context, Offset offset);
}

class CursorPainter extends RenderBlockPainter {
  @override
  void paint(RenderBlock renderBlock, PaintingContext context, Offset offset) {
    final selection = renderBlock.selection;
    if (!selection.isCollapsed || !selection.isValid) {
      return;
    }
    final block = renderBlock.block;
    if (block is Paragraph) {
      final rect =
          Offset.zero & Size(1.0, block._textPainter.preferredLineHeight);
      final cursorOffset = block._textPainter.getOffsetForCaret(
        selection.base,
        rect,
      );
      const color = Color(0xFF0099FF);
      context.canvas.drawRect(
        rect.shift(cursorOffset + offset),
        Paint()
          ..color = color.withOpacity(
            renderBlock.document?.cursorController.opacity ?? 1,
          ),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CursorPainter? oldDelegate) {
    return true;
  }
}
