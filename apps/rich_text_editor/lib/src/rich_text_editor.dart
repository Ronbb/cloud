import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

part 'actions.dart';
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
  final _documentKey = GlobalKey();

  TextInputConnection? _textInputConnection;

  late Document document;
  late CursorController cursorController;

  Action<T> _overridable<T extends Intent>(Action<T> defaultAction) {
    return Action<T>.overridable(
      defaultAction: defaultAction,
      context: context,
    );
  }

  Action<T> _action<T extends Intent>() {
    return Action<T>.overridable(
      defaultAction: CallbackAction<T>(onInvoke: _onInvoke),
      context: context,
    );
  }

  late final Map<Type, Action<Intent>> _actions = {
    DeleteCharacterIntent: _overridable(DeleteCharacterAction(this)),
    DeleteToNextWordBoundaryIntent: _action<DeleteToNextWordBoundaryIntent>(),
    DeleteToLineBreakIntent: _action<DeleteToLineBreakIntent>(),
    UpdateSelectionIntent: _action<UpdateSelectionIntent>(),
    DoNothingAndStopPropagationTextIntent: DoNothingAction(consumesKey: false),
    ReplaceTextIntent: _action<ReplaceTextIntent>(),
    DirectionalFocusIntent: _action<DirectionalFocusIntent>(),
    DismissIntent: _action<DismissIntent>(),
    ExtendSelectionByCharacterIntent: _overridable(
      ExtendSelectionByCharacterAction(this),
    ),
    ExtendSelectionToNextWordBoundaryIntent:
        _action<ExtendSelectionToNextWordBoundaryIntent>(),
    ExtendSelectionToLineBreakIntent:
        _action<ExtendSelectionToLineBreakIntent>(),
    ExpandSelectionToLineBreakIntent:
        _action<ExpandSelectionToLineBreakIntent>(),
    ExpandSelectionToDocumentBoundaryIntent:
        _action<ExpandSelectionToDocumentBoundaryIntent>(),
    ExtendSelectionVerticallyToAdjacentLineIntent:
        _action<ExtendSelectionVerticallyToAdjacentLineIntent>(),
    ExtendSelectionToDocumentBoundaryIntent:
        _action<ExtendSelectionToDocumentBoundaryIntent>(),
    ExtendSelectionToNextWordBoundaryOrCaretLocationIntent:
        _action<ExtendSelectionToNextWordBoundaryOrCaretLocationIntent>(),
    ScrollToDocumentBoundaryIntent: _action<ScrollToDocumentBoundaryIntent>(),
    SelectAllTextIntent: _action<SelectAllTextIntent>(),
    CopySelectionTextIntent: _action<CopySelectionTextIntent>(),
    PasteTextIntent: _action<PasteTextIntent>(),
  };

  Object? _onInvoke(Intent intent) {
    debugPrint(intent.toString());
    return null;
  }

  bool get _hasInputConnection => _textInputConnection?.attached ?? false;

  RenderDocument get _renderDocument =>
      _documentKey.currentContext!.findRenderObject()! as RenderDocument;

  bool get _hasRenderDocument =>
      _documentKey.currentContext?.findRenderObject() != null;

  void _openConnection() {
    if (!_hasInputConnection) {
      _textInputConnection = TextInput.attach(this, textInputConfiguration);
      _textInputConnection!.show();
      _updateSizeAndTransform();
      _updateComposingRect();
      _updateCaretRect();
    } else {
      _textInputConnection!.show();
    }
  }

  void _closeConnection() {
    _textInputConnection?.close();
  }

  void _updateComposingRect() {
    if (_hasInputConnection) {
      if (_hasRenderDocument) {
        var range = _currentTextEditingValue?.composing ??
            _currentTextEditingValue?.selection;
        if (range != null && range.isValid) {
          range = _currentTextEditingValue?.selection;
        }
        if (range != null && range.isValid) {
          var rect = _renderDocument.getRectForComposingRange(range);
          if (rect == null) {
            final offset = range.start;
            rect = _renderDocument.getLastLocalRectForCursor(
              TextPosition(offset: offset),
            );
          }
          if (rect != null) {
            _textInputConnection!.setComposingRect(rect);
          }
        }
      }
      SchedulerBinding.instance.addPostFrameCallback(
        (Duration _) => _updateComposingRect(),
      );
    }
  }

  void _updateCaretRect() {
    if (_hasInputConnection) {
      if (_hasRenderDocument) {
        final selection = _renderDocument.selection;
        if (selection.isValid && selection.isCollapsed) {
          final currentTextPosition =
              TextPosition(offset: selection.baseOffset);
          final caretRect =
              _renderDocument.getLastLocalRectForCursor(currentTextPosition);
          if (caretRect != null) {
            _textInputConnection!.setCaretRect(caretRect);
          }
        }
      }
      SchedulerBinding.instance.addPostFrameCallback(
        (Duration _) => _updateCaretRect(),
      );
    }
  }

  void _updateSizeAndTransform() {
    if (_hasInputConnection) {
      if (_hasRenderDocument) {
        final Size size = _renderDocument.size;
        final Matrix4 transform = _renderDocument.getTransformTo(null);
        _textInputConnection!.setEditableSizeAndTransform(size, transform);
        // _updateSelectionRects();
      }
      SchedulerBinding.instance
          .addPostFrameCallback((Duration _) => _updateSizeAndTransform());
    }
  }

  void refresh() {
    currentTextEditingValue = _currentTextEditingValue;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    document = _Document(blocks: [
      Paragraph.empty(),
    ]);
    cursorController = CursorController(vsync: this);
    _openConnection();
  }

  @override
  void dispose() {
    cursorController.dispose();
    _closeConnection();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Actions(
      actions: _actions,
      child: DefaultTextEditingShortcuts(
        child: Focus(
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
                onDoubleTapDown: (details) {
                  debugPrint('onDoubleTapDown');
                },
                onDragSelectionEnd: (details) {
                  debugPrint('onDragSelectionEnd');
                },
                onDragSelectionStart: (details) {
                  debugPrint('onDragSelectionStart');
                },
                onDragSelectionUpdate: (startDetails, updateDetails) {
                  debugPrint('onDragSelectionUpdate');
                },
                onForcePressEnd: (details) {
                  debugPrint('onForcePressEnd');
                },
                onForcePressStart: (details) {
                  debugPrint('onForcePressStart');
                },
                onSecondaryTap: () {
                  debugPrint('onSecondaryTap');
                },
                onSecondaryTapDown: (details) {
                  debugPrint('onSecondaryTapDown');
                },
                onSingleLongTapEnd: (details) {
                  debugPrint('onSingleLongTapEnd');
                },
                onSingleLongTapMoveUpdate: (details) {
                  debugPrint('onSingleLongTapMoveUpdate');
                },
                onSingleLongTapStart: (details) {
                  debugPrint('onSingleLongTapStart');
                },
                onSingleTapCancel: () {
                  debugPrint('onSingleTapCancel');
                },
                onSingleTapUp: (details) {
                  debugPrint('onSingleTapUp');
                },
                child: _DocumentWidget(
                  key: _documentKey,
                  cursorController: cursorController,
                  document: document,
                  selection: currentTextEditingValue?.selection ??
                      const TextSelection.collapsed(offset: 0),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void connectionClosed() {
    debugPrint('connectionClosed');
  }

  @override
  AutofillScope? currentAutofillScope;

  TextEditingValue? _currentTextEditingValue;
  @override
  TextEditingValue? get currentTextEditingValue => _currentTextEditingValue;
  set currentTextEditingValue(TextEditingValue? value) {
    _currentTextEditingValue = value;
    if (_currentTextEditingValue != null) {
      _textInputConnection!.setEditingState(_currentTextEditingValue!);
    }
  }

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
        document = document.applyDelta(delta);

        _currentTextEditingValue = TextEditingValue(
          text: document.plainText,
          selection: delta.selection,
          composing: delta.composing,
        );
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
