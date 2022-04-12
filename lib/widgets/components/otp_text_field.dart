import 'package:flutter/cupertino.dart';
import 'package:packs/constants/app_constants.dart';

class OtpTextField extends StatelessWidget {
  final Function onChangeField;

  OtpTextField({required this.onChangeField});

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      _textFieldOTP(
          first: true,
          last: false,
          context: context,
          onChange: (v) {
            onChangeField(v, 0);
          }),
      _textFieldOTP(
          first: false,
          last: false,
          context: context,
          onChange: (v) {
            onChangeField(v, 1);
          }),
      _textFieldOTP(
          first: false,
          last: false,
          context: context,
          onChange: (v) {
            onChangeField(v, 2);
          }),
      _textFieldOTP(
          first: false,
          last: false,
          context: context,
          onChange: (v) {
            onChangeField(v, 3);
          }),
      _textFieldOTP(
          first: false,
          last: false,
          context: context,
          onChange: (v) {
            onChangeField(v, 4);
          }),
      _textFieldOTP(
          first: false,
          last: true,
          context: context,
          onChange: (v) {
            onChangeField(v, 5);
          }),
    ]);
  }
}

Widget _textFieldOTP({bool? first, last, BuildContext? context, onChange}) {
  return Container(
    height: 45,
    child: AspectRatio(
      aspectRatio: 1,
      child: CupertinoTextField(
        autofocus: true,
        onChanged: (value) {
          onChange(value);
          if (value.length == 1 && last == false) {
            FocusScope.of(context!).nextFocus();
          }
          if (value.length == 0 && first == false) {
            FocusScope.of(context!).previousFocus();
          }
        },
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            border: Border.all(color: PXColor.lightGrey)),
        readOnly: false,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        keyboardType: TextInputType.number,
        maxLength: 1,
      ),
    ),
  );
}
