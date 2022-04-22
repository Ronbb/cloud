part of 'rich_text_editor.dart';

abstract class Node {
  const Node();

  String get plainText;

  Node applyDelta(int offset, TextEditingDelta delta);

  @override
  String toString() {
    return plainText;
  }
}

abstract class Inline extends Node {
  const Inline();
}

abstract class Text extends Inline {
  const Text();
}

abstract class Block extends Node {
  const Block();

  List<Inline> get inlines;

  @override
  String get plainText => inlines.map((inline) => inline.plainText).join();
}

abstract class Document extends Node {
  const Document();

  List<Block> get blocks;

  @override
  String get plainText => blocks.map((inline) => inline.plainText).join();
}
