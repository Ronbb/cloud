import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

part 'document.dart';

class RichTextEditor extends StatefulWidget {
  const RichTextEditor({Key? key}) : super(key: key);

  @override
  State<RichTextEditor> createState() => RichTextEditorState();
}

class RichTextEditorState extends State<RichTextEditor>
    implements DeltaTextInputClient, AutofillClient {
  TextInputConnection? _textInputConnection;

  String text = "";

  @override
  void initState() {
    super.initState();
    _textInputConnection = TextInput.attach(this, textInputConfiguration);
    _textInputConnection!.show();
  }

  @override
  void dispose() {
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
            child: _RichTextEditor(
              text: TextSpan(
                text: text,
                style: const TextStyle(
                  color: Color(0xFF000000),
                ),
              ),
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
    for (var delta in textEditingDeltas) {
      if (delta is TextEditingDeltaInsertion) {
        setState(() {
          text = text + delta.textInserted;
        });
        continue;
      }
      if (delta is TextEditingDeltaDeletion) {
        setState(() {
          final range = delta.deletedRange;
          text = text.substring(0, range.start) + text.substring(range.end);
        });
        continue;
      }
      if (delta is TextEditingDeltaNonTextUpdate) {
        continue;
      }
      if (delta is TextEditingDeltaReplacement) {
        setState(() {
          final range = delta.replacedRange;
          text = text.substring(0, range.start) +
              delta.replacementText +
              text.substring(range.end);
        });
        continue;
      }
      debugPrint("unknown TextEditingDelta, $delta");
    }
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

class _RichTextEditor extends MultiChildRenderObjectWidget {
  _RichTextEditor({Key? key, this.text}) : super(key: key);

  final TextSpan? text;

  @override
  RenderRichTextEditor createRenderObject(BuildContext context) {
    return RenderRichTextEditor()..text = text;
  }

  @override
  void updateRenderObject(
      BuildContext context, RenderRichTextEditor renderObject) {
    renderObject.text = text;
  }
}

class TextParentData extends ContainerBoxParentData<RenderBox> {
  double? scale;
}

class RenderRichTextEditor extends RenderBlock {
  final TextPainter _textPainter = TextPainter(
    textDirection: TextDirection.ltr,
  );
  TextSpan? _text;
  TextSpan? get text => _text;
  set text(TextSpan? text) {
    _text = text;
    markNeedsPaint();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    _textPainter.text = _text;
    _textPainter.layout();
    _textPainter.paint(context.canvas, offset);
  }
}

class RenderBlock extends RenderBox
    with
        RelayoutWhenSystemFontsChangeMixin,
        ContainerRenderObjectMixin<RenderBox, TextParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, TextParentData>
    implements TextLayoutMetrics {
  @override
  void performLayout() {
    size = constraints.biggest;
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }

  @override
  bool hitTestSelf(Offset position) => true;

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

  @override
  void handleEvent(PointerEvent event, covariant BoxHitTestEntry entry) {}
}
