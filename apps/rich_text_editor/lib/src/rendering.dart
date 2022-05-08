part of 'rich_text_editor.dart';

class TextParentData extends ContainerBoxParentData<RenderBox> {
  RenderDocument? document;
}

class RenderDocument extends RenderBox
    with
        RelayoutWhenSystemFontsChangeMixin,
        ContainerRenderObjectMixin<RenderBox, TextParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, TextParentData> {
  RenderDocument({
    required Document document,
    required TextSelection selection,
    required CursorController cursorController,
  })  : _document = document,
        _selection = selection,
        _cursorController = cursorController;

  Document _document;
  Document get document => _document;
  set document(Document document) {
    if (_document != document) {
      _document = document;
      markNeedsLayout();
    }
  }

  TextSelection _selection;
  TextSelection get selection => _selection;
  set selection(TextSelection selection) {
    if (_selection != selection) {
      _selection = selection;
      markNeedsPaint();
    }
  }

  final CursorPainter _cursorPainter = CursorPainter();
  CursorPainter get cursorPainter => _cursorPainter;

  final CursorController _cursorController;
  CursorController get cursorController => _cursorController;

  @override
  void setupParentData(RenderBlock child) {
    if (child.parentData is! BoxParentData) {
      child.parentData = TextParentData()..document = this;
    }
  }

  @override
  void performLayout() {
    size = constraints.biggest;
    visitChildren((child) {
      child.layout(constraints);
    });
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    defaultPaint(context, offset);
  }

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) {
    return defaultHitTestChildren(result, position: position);
  }

  @override
  bool hitTestSelf(Offset position) => true;
}

class RenderBlock extends RenderBox
    with
        RelayoutWhenSystemFontsChangeMixin,
        ContainerRenderObjectMixin<RenderBox, TextParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, TextParentData>
    implements TextLayoutMetrics {
  RenderBlock({
    required Block block,
    required TextSelection selection,
  })  : _block = block,
        _selection = selection;

  Block _block;
  Block get block => _block;
  set block(Block block) {
    if (_block != block) {
      _block = block;
      markNeedsLayout();
    }
  }

  TextSelection _selection;
  TextSelection get selection => _selection;
  set selection(TextSelection selection) {
    if (_selection != selection) {
      _selection = selection;
      markNeedsPaint();
    }
  }

  @override
  TextParentData? get parentData => super.parentData as TextParentData?;

  RenderDocument? document;

  CursorPainter? get _cursorPainter => document?.cursorPainter;

  void _onCursorTick() {
    markNeedsPaint();
  }

  @override
  void attach(covariant PipelineOwner owner) {
    document = parentData?.document;
    document?.cursorController.addListener(_onCursorTick);
    super.attach(owner);
  }

  @override
  void detach() {
    document?.cursorController.removeListener(_onCursorTick);
    super.detach();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    _block.paint(this, context, offset);
    defaultPaint(context, offset);
    _cursorPainter?.paint(this, context, offset);
  }

  @override
  void performLayout() {
    size = _block.layout(this);
    visitChildren((child) {
      child.layout(constraints);
    });
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
