import 'package:flutter/foundation.dart';


class pageViewHolder extends ChangeNotifier{
  double value;

  pageViewHolder(this.value);

  void setValue(newValue){
    this.value = newValue;
    notifyListeners();
  }


}