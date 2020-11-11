import 'package:flutter/material.dart';

const Duration _kExpand = const Duration(milliseconds: 200);

class AppExpansionTile extends StatefulWidget {
  const AppExpansionTile({
    Key key,
    this.leading,
    @required this.title,
    this.backgroundColor,
    this.onExpansionChanged,
    this.children,
    this.trailing,
    this.itemIndex,
    this.selectedItemIndex,
    this.initiallyExpanded: false,
  })  : assert(initiallyExpanded != null),
        super(key: key);

  final Widget leading;
  final Widget title;
  final ValueChanged<bool> onExpansionChanged;
  final Widget children;
  final Color backgroundColor;
  final Widget trailing;
  final bool initiallyExpanded;
  final int itemIndex;
  final int selectedItemIndex;

  @override
  AppExpansionTileState createState() => new AppExpansionTileState();
}

class AppExpansionTileState extends State<AppExpansionTile>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  CurvedAnimation _easeOutAnimation;
  CurvedAnimation _easeInAnimation;
  ColorTween _borderColor;
  ColorTween _headerColor;
  ColorTween _iconColor;
  ColorTween _backgroundColor;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(duration: _kExpand, vsync: this);
    _easeOutAnimation =
        new CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _easeInAnimation =
        new CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _borderColor = new ColorTween();
    _headerColor = new ColorTween();
    _iconColor = new ColorTween();
    _backgroundColor = new ColorTween();

    _isExpanded =
        PageStorage.of(context)?.readState(context) ?? widget.initiallyExpanded;
    if (_isExpanded) _controller.value = 1.0;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void expand() {
    _setExpanded(true);
  }

  void collapse() {
    _setExpanded(false);
  }

  void toggle() {
    _setExpanded(!_isExpanded);
  }

  void _setExpanded(bool isExpanded) {
    if (_isExpanded != isExpanded) {
      setState(() {
        _isExpanded = isExpanded;
        if (_isExpanded)
          _controller.forward();
        else
          _controller.reverse().then<void>((value) {
            setState(() {
              // Rebuild without widget.children.
            });
          });
        PageStorage.of(context)?.writeState(context, _isExpanded);
      });
      if (widget.onExpansionChanged != null) {
        widget.onExpansionChanged(_isExpanded);
      }
    }
  }

  Widget _buildChildren(BuildContext context, Widget child) {
    final Color borderSideColor =
        _borderColor.evaluate(_easeOutAnimation) ?? Colors.transparent;

    return new Container(
      decoration: new BoxDecoration(
          color: _backgroundColor.evaluate(_easeOutAnimation) ??
              Colors.transparent,
          border: new Border(
            top: new BorderSide(color: borderSideColor),
            bottom: new BorderSide(color: borderSideColor),
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(children: [
            Expanded(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: widget.itemIndex == widget.selectedItemIndex
                          ? Color.fromRGBO(96, 182, 227, 1)
                          : Colors.transparent,
                      width: 5,
                    ),
                  ),
                ),
                child: InkWell(
                  onTap: toggle,
                  child: widget.title,
                ),
              ),
            ),
          ]),
          ClipRect(
            child: Align(
              heightFactor: _easeInAnimation.value,
              child: child,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    _borderColor.end = theme.dividerColor;
    _headerColor
      ..begin = theme.textTheme.subtitle2.color
      ..end = theme.accentColor;
    _iconColor
      ..begin = theme.unselectedWidgetColor
      ..end = theme.accentColor;
    _backgroundColor.end = widget.backgroundColor;

    final bool closed = !_isExpanded && _controller.isDismissed;
    return new AnimatedBuilder(
      animation: _controller.view,
      builder: _buildChildren,
      child: closed ? null : widget.children,
    );
  }
}
