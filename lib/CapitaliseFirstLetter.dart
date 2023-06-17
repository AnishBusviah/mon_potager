String CapitaliseFirstLetter(var inputString){
  //print(inputString);
  var NewString = "";

  List <String> words = inputString.split(" ");
  // print(words);
  for(var i = 0; i < words.length; i++){
    NewString += (words[i].substring(0,1).toUpperCase() + words[i].substring(1) + " ");
  }

  return NewString;

}