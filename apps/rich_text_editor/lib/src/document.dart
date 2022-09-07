part of 'rich_text_editor.dart';

abstract class Node {
  const Node();

  String get plainText;

  Node? applyDelta(TextEditingDelta delta, {int offset = 0});

  @override
  String toString() {
    return plainText;
  }
}

abstract class Inline extends Node {
  const Inline();

  InlineSpan get span;

  Inline? applyDeltaInsertion(
    int offset,
    TextEditingDeltaInsertion delta,
  ) =>
      this;

  Inline? applyDeltaDeletion(
    int offset,
    TextEditingDeltaDeletion delta,
  ) =>
      this;

  Inline? applyDeltaNonTextUpdate(
    int offset,
    TextEditingDeltaNonTextUpdate delta,
  ) =>
      this;

  Inline? applyDeltaReplacement(
    int offset,
    TextEditingDeltaReplacement delta,
  ) =>
      this;

  @override
  Inline? applyDelta(TextEditingDelta delta, {int offset = 0}) {
    if (delta is TextEditingDeltaInsertion) {
      return applyDeltaInsertion(offset, delta);
    }

    if (delta is TextEditingDeltaDeletion) {
      return applyDeltaDeletion(offset, delta);
    }

    if (delta is TextEditingDeltaNonTextUpdate) {
      return applyDeltaNonTextUpdate(offset, delta);
    }

    if (delta is TextEditingDeltaReplacement) {
      return applyDeltaReplacement(offset, delta);
    }

    throw UnimplementedError("unknown TextEditingDelta, $delta");
  }
}

abstract class Block extends Node {
  const Block();

  List<Inline> get inlines;

  @override
  String get plainText =>
      '${inlines.map((inline) => inline.plainText).join()}\n';

  @override
  Block? applyDelta(TextEditingDelta delta, {int offset = 0});

  void paint(
    covariant RenderBlock renderBlock,
    PaintingContext context,
    Offset offset,
  );

  Size layout(covariant RenderBlock renderBlock);
}

mixin TextPainterProviderMixin on Block {
  TextPainter get textPainter;
}

class Text extends Inline {
  const Text(this.text);
  const Text.empty() : text = "";

  final String text;

  @override
  String get plainText => text;

  @override
  Text? applyDeltaDeletion(int offset, TextEditingDeltaDeletion delta) {
    final range = delta.deletedRange;
    final length = plainText.length;
    final start = range.start - offset;
    final end = range.end - offset;
    if (start > length || end < 0) {
      return this;
    }

    final newText = plainText.substring(0, max(0, start)) +
        plainText.substring(min(length, end), length);
    if (newText.isEmpty) {
      return null;
    }

    return Text(newText);
  }

  @override
  Text? applyDeltaInsertion(int offset, TextEditingDeltaInsertion delta) {
    final insertionOffset = delta.insertionOffset - offset;
    final length = plainText.length;
    if (insertionOffset < 0 || insertionOffset > length) {
      return this;
    }

    final newText = plainText.substring(0, insertionOffset) +
        delta.textInserted +
        plainText.substring(insertionOffset);

    return Text(newText);
  }

  @override
  Text? applyDeltaReplacement(int offset, TextEditingDeltaReplacement delta) {
    final range = delta.replacedRange;
    final length = plainText.length;
    final start = range.start - offset;
    final end = range.end - offset;
    if (start > length || end < 0) {
      return this;
    }

    final newText = plainText.substring(0, max(0, start)) +
        delta.replacementText +
        plainText.substring(min(length, end), length);
    if (newText.isEmpty) {
      return null;
    }

    return Text(newText);
  }

  @override
  InlineSpan get span => TextSpan(text: text);
}

abstract class Document extends Node {
  const Document();

  List<Block> get blocks;

  @override
  String get plainText => blocks.map((inline) => inline.plainText).join();

  @override
  Document applyDelta(TextEditingDelta delta, {int offset = 0});
}

class Paragraph extends Block with TextPainterProviderMixin {
  Paragraph({
    required this.inlines,
  }) : _textPainter = _createTextPainter(inlines);

  final TextPainter _textPainter;

  @override
  TextPainter get textPainter => _textPainter;

  factory Paragraph.empty() => Paragraph(inlines: const [Text.empty()]);

  static TextPainter _createTextPainter(List<Inline> inlines) {
    return TextPainter(
      textDirection: TextDirection.ltr,
      text: TextSpan(
        style: const TextStyle(color: Color(0xFF000000)),
        children: [
          for (final inline in inlines) inline.span,
        ],
      ),
    );
  }

  Block? _update(_InlineUpdater updater) {
    List<Inline> newInlines = inlines.isEmpty ? [const Text.empty()] : inlines;
    newInlines = newInlines.fold<List<Inline>>(
      [],
      ((previousValue, inline) {
        final newInline = updater(inline);
        if (newInline != null) {
          previousValue.add(newInline);
        }
        return previousValue;
      }),
    );
    return Paragraph(inlines: newInlines);
  }

  @override
  final List<Inline> inlines;

  @override
  Block? applyDelta(TextEditingDelta delta, {int offset = 0}) {
    return _update((inline) => inline.applyDelta(offset: offset, delta));
  }

  @override
  Size layout(RenderBlock renderBlock) {
    if (_textPainter.text != null) {
      _textPainter.layout(maxWidth: renderBlock.constraints.maxWidth);
      return _textPainter.size;
    }
    return Size.zero;
  }

  @override
  void paint(RenderBlock renderBlock, PaintingContext context, Offset offset) {
    _textPainter.paint(context.canvas, offset);
  }
}

typedef _InlineUpdater = Inline? Function(Inline inline);
typedef _BlockUpdater = Block? Function(Block block);

class _Document extends Document {
  const _Document({
    required this.blocks,
  });

  @override
  final List<Block> blocks;

  Document _update(_BlockUpdater updater) {
    List<Block> newBlocks = blocks.isEmpty ? [Paragraph.empty()] : blocks;
    newBlocks = newBlocks.fold<List<Block>>(
      [],
      (previousValue, block) {
        final newBlock = updater(block);
        if (newBlock != null) {
          previousValue.add(newBlock);
        }
        return previousValue;
      },
    );
    return _Document(blocks: newBlocks);
  }

  @override
  Document applyDelta(TextEditingDelta delta, {int offset = 0}) {
    return _update(
      (block) => block.applyDelta(offset: offset, delta),
    );
  }
}
