import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class RichTextEditor extends StatefulWidget {
  const RichTextEditor({Key? key}) : super(key: key);

  @override
  State<RichTextEditor> createState() => RichTextEditorState();
}

class RichTextEditorState extends State<RichTextEditor>
    implements DeltaTextInputClient, AutofillClient {
  TextInputConnection? _textInputConnection;
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
    return TextSelectionGestureDetector(
      child: _RichTextEditor(),
    );
  }

  @override
  void connectionClosed() {
    // TODO: implement connectionClosed
  }

  @override
  AutofillScope? currentAutofillScope;

  @override
  TextEditingValue? currentTextEditingValue;

  @override
  void performAction(TextInputAction action) {
    // TODO: implement performAction
  }

  @override
  void performPrivateCommand(String action, Map<String, dynamic> data) {
    // TODO: implement performPrivateCommand
  }

  @override
  void showAutocorrectionPromptRect(int start, int end) {
    // TODO: implement showAutocorrectionPromptRect
  }

  @override
  void updateEditingValue(TextEditingValue value) {
    // TODO: implement updateEditingValue
  }

  @override
  void updateEditingValueWithDeltas(List<TextEditingDelta> textEditingDeltas) {
    // TODO: implement updateEditingValueWithDeltas
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
      autocorrect: true,
      smartDashesType: SmartDashesType.enabled,
      smartQuotesType: SmartQuotesType.enabled,
      enableSuggestions: true,
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
}

class _RichTextEditor extends MultiChildRenderObjectWidget {
  @override
  RenderRichTextEditor createRenderObject(BuildContext context) {
    return RenderRichTextEditor();
  }
}

class TextParentData extends ContainerBoxParentData<RenderBox> {
  double? scale;
}

class RenderRichTextEditor extends RenderBlock {}

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
}
