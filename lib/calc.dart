class Calculator {
  static final list_op = ['+', '-', '×', '÷'];
  static var number = [];//項のリスト
  static var op = [];//演算子の保持

  static String buffer = '';
  static void PutList(String selectedButton) {
    if (list_op.contains(selectedButton)) {
      op.add(selectedButton);
      number.add(double.parse(buffer));
      buffer = '';
    } else if (selectedButton == 'AC') {
      number.clear();
      op.clear();
      buffer = '';
    } else {
      buffer += selectedButton;
      //演算子が押されるまで、押された数字の値をbufferに保持
    }
  }

  static double progress = 0;
  static String FinalResult() {
    number.add(double.parse(buffer));

    if (number.length == 0) return '0';
    progress = number[0];
  //numberに項が１つ入った場合、progressに代入
    for (int i = 0; i < op.length; i++) {
      if (op[i] == '+') {
        progress += number[i + 1];
      } else if (op[i] == '-') {
        progress -= number[i + 1];
      } else if (op[i] == '×') {
        progress *= number[i + 1];
      } else if (op[i] == '÷' && number[i + 1] != 0) {
        progress /= number[i + 1];
      } else {
        return 'e';
      }
    }
    number.clear();
    op.clear();
    buffer = '';

    var progressStr = progress.toString().split('.');
    return progressStr[1] == '0' ? progressStr[0] : progress.toString();
  }//小数点以下の0などが文字列に返らないように
}
