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

  final CursorController _cursorController;
  CursorController get cursorController => _cursorController;

  @override
  bool get isRepaintBoundary => true;

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

  RenderDocument? document;
  RenderBlockPainter<CursorPainter> renderCursor =
      RenderBlockPainter<CursorPainter>()..painter = CursorPainter();

  Iterable<RenderBlockPainter> get renderBlockPainters sync* {
    yield renderCursor;
  }

  void visitRenderBlockPainters(RenderBlockPainterVisitor visitor) {
    for (final renderBlockPainter in renderBlockPainters) {
      visitor(renderBlockPainter);
    }
  }

  @override
  TextParentData? get parentData => super.parentData as TextParentData?;

  @override
  bool get isRepaintBoundary => true;

  @override
  void attach(covariant PipelineOwner owner) {
    super.attach(owner);

    document = parentData?.document;
    assert(document != null);

    visitRenderBlockPainters(adoptChild);
  }

  @override
  void detach() {
    document = null;

    visitRenderBlockPainters(dropChild);

    super.detach();
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    _block.paint(this, context, offset);
    defaultPaint(context, offset);
    visitRenderBlockPainters(((child) {
      context.paintChild(child, child.parentData!.offset + offset);
    }));
  }

  @override
  void performLayout() {
    size = _block.layout(this);
    visitChildren((child) {
      child.layout(constraints);
    });
    visitRenderBlockPainters(((child) {
      child.layout(constraints);
    }));
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

typedef RenderBlockPainterVisitor = void Function(RenderBlockPainter child);

class RenderBlockPainter<T extends BlockPainter> extends RenderBox {
  T? _painter;
  T? get painter => _painter;
  set painter(T? painter) {
    if (_painter != painter) {
      final oldPainter = _painter;
      _painter = painter;
      if (attached) {
        oldPainter?.detach();
        _painter?.attach(this);
      }
      markNeedsPaint();
    }
  }

  @override
  RenderBlock? get parent => super.parent as RenderBlock?;

  @override
  BoxParentData? get parentData => super.parentData as BoxParentData?;

  @override
  void paint(PaintingContext context, Offset offset) {
    final parent = this.parent;
    if (parent != null) {
      painter?.paint(parent, context, offset);
    }
  }

  @override
  void performLayout() {
    size = Size(parent!.size.width, parent!.size.height);
  }

  @override
  bool get isRepaintBoundary => true;

  @override
  void attach(covariant PipelineOwner owner) {
    painter?.attach(this);
    super.attach(owner);
  }

  @override
  void detach() {
    painter?.detach();
    super.detach();
  }
}
