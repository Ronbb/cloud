part of 'rich_text_editor.dart';

abstract class BlockPainter {
  RenderBlockPainter? _renderBlockPainter;
  RenderBlockPainter? get renderBlockPainter => _renderBlockPainter;

  @mustCallSuper
  void attach(RenderBlockPainter renderBlockPainter) {
    assert(_renderBlockPainter == null);
    _renderBlockPainter = renderBlockPainter;
  }

  @mustCallSuper
  void detach() {
    assert(_renderBlockPainter != null);
    _renderBlockPainter = null;
  }

  bool shouldRepaint(covariant BlockPainter? oldDelegate);

  void paint(RenderBlock renderBlock, PaintingContext context, Offset offset);
}

class CursorPainter extends BlockPainter {
  RenderDocument? _document;

  @override
  void attach(RenderBlockPainter<BlockPainter> renderBlockPainter) {
    super.attach(renderBlockPainter);
    _document = renderBlockPainter.parent?.parentData?.document;
    _document?.cursorController.addListener(_onCursorTick);
  }

  @override
  void detach() {
    _document?.cursorController.removeListener(_onCursorTick);
    super.detach();
  }

  void _onCursorTick() {
    renderBlockPainter?.markNeedsPaint();
  }

  @override
  void paint(RenderBlock renderBlock, PaintingContext context, Offset offset) {
    final selection = renderBlock.selection;
    if (!selection.isCollapsed || !selection.isValid) {
      return;
    }
    final block = renderBlock.block;
    if (block is Paragraph) {
      final rect =
          Offset.zero & Size(2.0, block._textPainter.preferredLineHeight);
      final cursorOffset = block._textPainter.getOffsetForCaret(
        selection.base,
        rect,
      );
      const color = Color(0xFF0099FF);
      context.canvas.drawRect(
        rect.shift(cursorOffset + offset),
        Paint()
          ..color = color.withOpacity(
            _document?.cursorController.opacity ?? 1,
          ),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CursorPainter? oldDelegate) {
    return true;
  }
}
