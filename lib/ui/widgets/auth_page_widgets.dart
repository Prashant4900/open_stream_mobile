import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:open_stream_mobile/constant/colors.dart';

class MyAuthButtonWidget extends StatelessWidget {
  const MyAuthButtonWidget({
    Key key,
    @required String label,
    @required Color color,
    Function onTapped,
    double borderRadius,
    double width,
  })  : _color = color,
        _width = width,
        _label = label,
        _onTapped = onTapped,
        _borderRadius = borderRadius,
        super(key: key);
  final String _label;
  final Color _color;
  final Function _onTapped;
  final double _borderRadius;
  final double _width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTapped,
      child: Container(
        height: 60,
        width: _width ?? double.infinity,
        decoration: BoxDecoration(
          color: _color,
          borderRadius: BorderRadius.circular(_borderRadius ?? 10),
        ),
        child: Center(
          child: Text(
            _label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class MyTestField extends StatelessWidget {
  const MyTestField({
    Key key,
    @required String label,
    String hintText,
    TextInputType inputType,
    IconData icon,
    Widget suffixIcon,
    bool obscureText = false,
    bool enabled = true,
    bool autocorrect = true,
    @required TextEditingController controller,
  })  : _label = label,
        _icon = icon,
        _hintText = hintText,
        _inputType = inputType,
        _controller = controller,
        _suffixIcon = suffixIcon,
        _obscureText = obscureText,
        _autocorrect = autocorrect,
        _enabled = enabled,
        super(key: key);

  final String _label, _hintText;
  final TextInputType _inputType;
  final IconData _icon;
  final TextEditingController _controller;
  final Widget _suffixIcon;
  final bool _autocorrect, _enabled, _obscureText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5),
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                _label,
                style: TextStyle(color: Colors.white),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xff4b5d67),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: EdgeInsets.only(top: 5),
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: TextField(
                controller: _controller,
                cursorColor: Colors.black87,
                keyboardType: _inputType ?? TextInputType.name,
                obscureText: _obscureText,
                enabled: _enabled,
                autocorrect: _autocorrect,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: _hintText,
                  suffixIcon: _suffixIcon,
                  icon: Icon(
                    _icon,
                    color: Colors.black,
                  ),
                ),
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyAuthAppBar extends StatelessWidget {
  const MyAuthAppBar({
    Key key,
    @required String label,
  })  : _label = label,
        super(key: key);

  final String _label;

  @override
  Widget build(BuildContext context) {
    return new AppBar(
      backgroundColor: kBackGroundColor,
      toolbarHeight: double.maxFinite,
      leading: new GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: new Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
          child: new Icon(LineAwesomeIcons.angle_left, size: 15),
        ),
      ),
      title: new Text(
        _label,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
      ),
    );
  }
}

class MyLoginIcons extends StatelessWidget {
  const MyLoginIcons({
    Key key,
    @required String label,
    Color fontColor,
  })  : _label = label,
        _fontColor = fontColor,
        super(key: key);

  final String _label;
  final Color _fontColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 55,
        margin: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
        decoration: BoxDecoration(color: Color(0xff2c2c2c), borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: Text(
            _label,
            style: GoogleFonts.roboto(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: _fontColor ?? Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
