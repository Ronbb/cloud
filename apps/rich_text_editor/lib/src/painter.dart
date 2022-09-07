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

  Rect? calculateCursorRect(Block block) {
    if (block is TextPainterProviderMixin) {
      final rect =
          Offset.zero & Size(2.0, block.textPainter.preferredLineHeight);
      return rect;
    }

    return null;
  }

  Offset? calculateCursorOffset(Block block, Rect rect, TextPosition position) {
    if (block is TextPainterProviderMixin) {
      return block.textPainter.getOffsetForCaret(position, rect);
    }

    return null;
  }

  @override
  void paint(RenderBlock renderBlock, PaintingContext context, Offset offset) {
    final selection = renderBlock.selection;
    if (!selection.isCollapsed || !selection.isValid) {
      return;
    }
    final block = renderBlock.block;
    final rect = calculateCursorRect(block);
    if (rect != null) {
      final cursorOffset = calculateCursorOffset(block, rect, selection.base);

      if (cursorOffset != null) {
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
  }

  @override
  bool shouldRepaint(covariant CursorPainter? oldDelegate) {
    return true;
  }
}
