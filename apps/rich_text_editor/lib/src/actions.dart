part of 'rich_text_editor.dart';

abstract class RichTextEditorAction<T extends Intent> extends ContextAction<T> {
  RichTextEditorAction(this.editor);

  final RichTextEditorState editor;
}

class DeleteCharacterAction
    extends RichTextEditorAction<DeleteCharacterIntent> {
  DeleteCharacterAction(RichTextEditorState editor) : super(editor);

  @override
  Object? invoke(DeleteCharacterIntent intent, [BuildContext? context]) {
    final editingValue = editor.currentTextEditingValue!;
    final delta = TextEditingDeltaDeletion(
      oldText: editingValue.text,
      deletedRange: TextRange(
        start: editingValue.move(intent.forward).offset,
        end: editingValue.collapse(intent.forward).offset,
      ),
      selection: editingValue.translate(intent.forward, true),
      composing: editingValue.composing,
    );
    editor.updateEditingValueWithDeltas([delta]);
    editor.refresh();
    return null;
  }
}

class ExtendSelectionByCharacterAction
    extends RichTextEditorAction<ExtendSelectionByCharacterIntent> {
  ExtendSelectionByCharacterAction(super.editor);

  @override
  Object? invoke(ExtendSelectionByCharacterIntent intent,
      [BuildContext? context]) {
    final value = editor.currentTextEditingValue!;

    editor.currentTextEditingValue = value.copyWith(
      selection: value.translate(
        intent.forward,
        intent.collapseSelection,
      ),
    );
    editor.refresh();
    editor.cursorController.start();
    return null;
  }
}

extension on TextEditingValue {
  TextPosition move(bool forward) {
    return TextPosition(
        offset: forward
            ? min(selection.end + 1, text.length - 1)
            : max(selection.start - 1, 0));
  }

  TextPosition collapse(bool forward) {
    return TextPosition(
      offset: forward
          ? min(selection.end, text.length - 1)
          : max(selection.start, 0),
    );
  }

  TextSelection translate(bool forward, bool collapseSelection) {
    var selection = this.selection;
    final offset = forward
        ? min(selection.end + 1, text.length - 1)
        : max(selection.start - 1, 0);
    if (collapseSelection) {
      selection = TextSelection.collapsed(offset: offset);
    } else {
      selection = selection.extendTo(
        TextPosition(offset: offset),
      );
    }

    return selection;
  }
}
