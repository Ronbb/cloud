import 'dart:async';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

part 'cursor_controller.dart';
part 'document.dart';
part 'painter.dart';
part 'rendering.dart';

class RichTextEditor extends StatefulWidget {
  const RichTextEditor({Key? key}) : super(key: key);

  @override
  State<RichTextEditor> createState() => RichTextEditorState();
}

class RichTextEditorState extends State<RichTextEditor>
    with TickerProviderStateMixin
    implements DeltaTextInputClient, AutofillClient {
  TextInputConnection? _textInputConnection;

  late Document document;
  late TextSelection selection;
  late CursorController cursorController;

  @override
  void initState() {
    super.initState();
    document = _Document(blocks: [
      Paragraph.empty(),
    ]);
    selection = const TextSelection.collapsed(offset: 0);
    cursorController = CursorController(vsync: this);
    cursorController.addListener(() {});
    _textInputConnection = TextInput.attach(this, textInputConfiguration);
    _textInputConnection!.show();
  }

  @override
  void dispose() {
    cursorController.dispose();
    _textInputConnection?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (value) {
        debugPrint('focus changed $value');
      },
      child: Builder(
        builder: (context) {
          return TextSelectionGestureDetector(
            onTapDown: (details) {
              final FocusNode focusNode = Focus.of(context);
              final bool hasFocus = focusNode.hasFocus;
              if (!hasFocus) {
                focusNode.requestFocus();
              }
            },
            child: _DocumentWidget(
              cursorController: cursorController,
              document: document,
              selection: selection,
            ),
          );
        },
      ),
    );
  }

  @override
  void connectionClosed() {
    // TODO: implement connectionClosed
    debugPrint('connectionClosed');
  }

  @override
  AutofillScope? currentAutofillScope;

  @override
  TextEditingValue? currentTextEditingValue;

  @override
  void performAction(TextInputAction action) {
    // TODO: implement performAction
    debugPrint('performAction');
  }

  @override
  void performPrivateCommand(String action, Map<String, dynamic> data) {
    // TODO: implement performPrivateCommand
    debugPrint('performPrivateCommand');
  }

  @override
  void showAutocorrectionPromptRect(int start, int end) {
    // TODO: implement showAutocorrectionPromptRect
    debugPrint('showAutocorrectionPromptRect');
  }

  @override
  void updateEditingValue(TextEditingValue value) {
    assert(false, "use with delta instead");
  }

  @override
  void updateEditingValueWithDeltas(List<TextEditingDelta> textEditingDeltas) {
    setState(() {
      for (final delta in textEditingDeltas) {
        document = document.applyDelta(0, delta) ?? document;
        selection = delta.selection;
      }
    });
  }

  @override
  void updateFloatingCursor(RawFloatingCursorPoint point) {
    // TODO: implement updateFloatingCursor
  }

  @override
  void autofill(TextEditingValue newEditingValue) {
    // TODO: implement autofill
  }

  @override
  String get autofillId => 'RichTextEditor-$hashCode';

  @override
  // TODO: implement textInputConfiguration
  TextInputConfiguration get textInputConfiguration {
    return TextInputConfiguration(
      inputType: TextInputType.multiline,
      readOnly: false,
      obscureText: false,
      autocorrect: false,
      smartDashesType: SmartDashesType.enabled,
      smartQuotesType: SmartQuotesType.enabled,
      enableSuggestions: false,
      inputAction: TextInputAction.newline,
      textCapitalization: TextCapitalization.none,
      keyboardAppearance: Brightness.light,
      autofillConfiguration: AutofillConfiguration(
        uniqueIdentifier: autofillId,
        autofillHints: const [],
        currentEditingValue: currentTextEditingValue ?? TextEditingValue.empty,
      ),
      enableIMEPersonalizedLearning: true,
      enableDeltaModel: true,
    );
  }

  @override
  void insertTextPlaceholder(Size size) {
    // TODO: implement insertTextPlaceholder
    debugPrint('insertTextPlaceholder');
  }

  @override
  void removeTextPlaceholder() {
    // TODO: implement removeTextPlaceholder
    debugPrint('removeTextPlaceholder');
  }

  @override
  void showToolbar() {
    // TODO: implement showToolbar
    debugPrint('showToolbar');
  }
}

class _DocumentWidget extends MultiChildRenderObjectWidget {
  _DocumentWidget({
    Key? key,
    required this.document,
    required this.selection,
    required this.cursorController,
  }) : super(
          key: key,
          children: _createBlocks(document, selection),
        );

  final Document document;

  final TextSelection selection;

  final CursorController cursorController;

  static List<Widget> _createBlocks(
    Document document,
    TextSelection selection,
  ) {
    int offset = 0;
    return document.blocks.map(
      (block) {
        final blockSelection = selection.copyWith(
          baseOffset: offset + selection.baseOffset,
          extentOffset: offset + selection.extentOffset,
        );
        offset += block.plainText.length;
        return _BlockWidget(
          key: ValueKey(block),
          block: block,
          selection: blockSelection,
        );
      },
    ).toList();
  }

  @override
  RenderDocument createRenderObject(BuildContext context) {
    return RenderDocument(
      document: document,
      selection: selection,
      cursorController: cursorController,
    );
  }

  @override
  void updateRenderObject(BuildContext context, RenderDocument renderObject) {
    renderObject
      ..document = document
      ..selection = selection;
  }
}

class _BlockWidget extends LeafRenderObjectWidget {
  const _BlockWidget({
    required this.block,
    required this.selection,
    Key? key,
  }) : super(key: key);

  final Block block;
  final TextSelection selection;

  @override
  RenderBlock createRenderObject(BuildContext context) {
    return RenderBlock(block: block, selection: selection);
  }

  @override
  void updateRenderObject(BuildContext context, RenderBlock renderObject) {
    renderObject
      ..block = block
      ..selection = selection;
  }
}
