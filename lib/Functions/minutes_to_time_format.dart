abstract class MinutesToTimeFormat{

  String mm(int minutes){

    return _timeString(minutes%60);
  }

  String hh(int minutes){
    return _timeString(minutes~/60);
  }

  String hhmm(int minutes){
    return '${_timeString(minutes~/60)}:${_timeString(minutes%60)}';
  }

  String _timeString(int time){
    if(time<10){
      return '0$time';
    }
    else{
      return '$time';
    }
  }

}