part of 'rich_text_editor.dart';

abstract class Node {
  const Node();

  String get plainText;

  Node? applyDelta(int offset, TextEditingDelta delta);

  @override
  String toString() {
    return plainText;
  }
}

abstract class Inline extends Node {
  const Inline();

  Inline? applyInsertion(int offset, TextEditingDeltaInsertion delta) => null;

  Inline? applyDeletion(int offset, TextEditingDeltaDeletion delta) => null;

  Inline? applyNonTextUpdate(int offset, TextEditingDeltaNonTextUpdate delta) =>
      null;

  Inline? applyReplacement(int offset, TextEditingDeltaReplacement delta) =>
      null;

  @override
  Inline? applyDelta(int offset, TextEditingDelta delta) {
    if (delta is TextEditingDeltaInsertion) {
      return applyInsertion(offset, delta);
    }

    if (delta is TextEditingDeltaDeletion) {
      return applyDeletion(offset, delta);
    }

    if (delta is TextEditingDeltaNonTextUpdate) {
      return applyNonTextUpdate(offset, delta);
    }

    if (delta is TextEditingDeltaReplacement) {
      return applyReplacement(offset, delta);
    }

    throw UnimplementedError("unknown TextEditingDelta, $delta");
  }

  InlineSpan get span;
}

abstract class Block extends Node {
  const Block();

  List<Inline> get inlines;

  @override
  String get plainText =>
      inlines.map((inline) => inline.plainText).join() + '\n';

  @override
  Block? applyDelta(int offset, TextEditingDelta delta);

  void paint(
    covariant RenderBlock renderBlock,
    PaintingContext context,
    Offset offset,
  );

  Size layout(covariant RenderBlock renderBlock);
}

class Text extends Inline {
  const Text(this.text);
  const Text.empty() : text = "";

  final String text;

  @override
  String get plainText => text;

  @override
  Text? applyDeletion(int offset, TextEditingDeltaDeletion delta) {
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
  Text? applyInsertion(int offset, TextEditingDeltaInsertion delta) {
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
  Text? applyReplacement(int offset, TextEditingDeltaReplacement delta) {
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
  Document? applyDelta(int offset, TextEditingDelta delta);
}

class Paragraph extends Block {
  Paragraph({
    required this.inlines,
  }) : _textPainter = _createTextPainter(inlines);

  final TextPainter _textPainter;

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

  @override
  final List<Inline> inlines;

  @override
  Block? applyDelta(int offset, TextEditingDelta delta) {
    List<Inline> newInlines = inlines.isEmpty ? [const Text.empty()] : inlines;
    newInlines = newInlines.fold<List<Inline>>(
      [],
      ((previousValue, inline) {
        final newInline = inline.applyDelta(offset, delta);
        if (newInline != null) {
          previousValue.add(newInline);
        }
        return previousValue;
      }),
    );
    return Paragraph(inlines: newInlines);
  }

  @override
  Size layout(RenderBlock renderBlock) {
    if (_textPainter.text != null) {
      _textPainter.layout();
      return _textPainter.size;
    }
    return Size.zero;
  }

  @override
  void paint(RenderBlock renderBlock, PaintingContext context, Offset offset) {
    _textPainter.paint(context.canvas, offset);
  }
}

class _Document extends Document {
  const _Document({
    required this.blocks,
  });

  @override
  final List<Block> blocks;

  @override
  Document? applyDelta(int offset, TextEditingDelta delta) {
    List<Block> newBlocks = blocks.isEmpty ? [Paragraph.empty()] : blocks;
    newBlocks = newBlocks.fold<List<Block>>(
      [],
      ((previousValue, block) {
        final newBlock = block.applyDelta(offset, delta);
        if (newBlock != null) {
          previousValue.add(newBlock);
        }
        return previousValue;
      }),
    );
    return _Document(blocks: newBlocks);
  }
}
