part of 'rich_text_editor.dart';

abstract class RichTextEditorAction<T extends Intent> extends ContextAction<T> {
  RichTextEditorAction(this.editor);

  final RichTextEditorState editor;
}

class ExtendSelectionByCharacterAction
    extends RichTextEditorAction<ExtendSelectionByCharacterIntent> {
  ExtendSelectionByCharacterAction(super.editor);

  @override
  Object? invoke(ExtendSelectionByCharacterIntent intent,
      [BuildContext? context]) {
    final value = editor.currentTextEditingValue ?? TextEditingValue.empty;
    var selection = value.selection;
    final offset = intent.forward
        ? min(selection.end + 1, value.text.length - 1)
        : max(selection.start - 1, 0);
    if (intent.collapseSelection) {
      selection = TextSelection.collapsed(offset: offset);
    } else {
      selection = selection.extendTo(
        TextPosition(offset: offset),
      );
    }

    editor.currentTextEditingValue = value.copyWith(
      selection: selection,
    );
    editor.refresh();
    editor.cursorController.start();
    return null;
  }
}
