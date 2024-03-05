import 'package:flutter/material.dart';

class CounterButton extends StatelessWidget {
  final Function() onIncrementSelected;
  final Function() onDecrementSelected;
  final Widget label;
  final Axis orientation;
  final Size size;
  final double padding;

  const CounterButton({
    super.key,
    required this.onIncrementSelected,
    required this.onDecrementSelected,
    required this.label,
    this.padding = 10.0,
    this.size = const Size(20, 20),
    this.orientation = Axis.horizontal,
  });

  Widget button(
      Icon icon, Function() onTap, Color backgroundColor, Color borderColor) {
    return RawMaterialButton(
      constraints: BoxConstraints.tight(size),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
        side: BorderSide(color: borderColor),
      ),
      fillColor: backgroundColor,
      onPressed: onTap,
      child: icon,
    );
  }

  List<Widget> body() {
    return [
      button(
        const Icon(Icons.remove, color: Color(0XFF009AAD)),
        onDecrementSelected,
        Colors.white,
        Color(0XFF009AAD),
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: padding),
        child: label,
      ),
      button(
        const Icon(Icons.add, color: Colors.white),
        onIncrementSelected,
        Color(0XFF009AAD),
        Color(0XFF009AAD),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return orientation == Axis.horizontal
        ? Row(mainAxisAlignment: MainAxisAlignment.end, children: body())
        : Column(children: body().reversed.toList());
  }
}
