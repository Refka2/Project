class FormValidation{
  String? validateName(String? value){
    if(value!.isEmpty) {
      return 'Required Field';
    } else if(value.length < 6) {
      return 'Name is too short';
    } else {
      return null;
    }
  }
  String? validateAge(String? value){
    String pattern = r'^10|[1-9]{2}$';
    RegExp regExp = RegExp(pattern);
    if(value!.isEmpty) {
      return 'Required Field';
    } else if(!regExp.hasMatch(value)) {
      return 'Not in range';
    } else if(value.length > 2  ) {
      return 'Not in range';
    } else {
      return null;
    }
  }


  String? validateEmail(String? value){

    String  pattern = r"^[a-zA-Z0-9.a-zA-Z0-9.!!#$&*%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+$";
    RegExp regExp = RegExp(pattern);
    if(value!.isEmpty) {
      return 'Required Field';
    } else if(!regExp.hasMatch(value)) {
      return 'Not an Email Form';
    } else {
      return null;
    }
  }

}