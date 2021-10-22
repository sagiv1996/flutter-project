import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location, time, flag, url;
  bool isDayTime;
  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try{
      Response respone = await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(respone.body);
      String datetime = data['datetime'], offset = data['utc_offset'];
      offset = offset.substring(1, 3);
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));
      this.isDayTime = now.hour > 6 && now.hour < 20;
      this.time = DateFormat.jm().format(now);
    }
    catch (e){
      print('this error: $e');
      this.time = 'faild get time';
    }

  }
}


