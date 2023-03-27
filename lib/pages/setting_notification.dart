import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingNotificationPage extends StatefulWidget {
  const SettingNotificationPage({Key? key}) : super(key: key);

  @override
  State<SettingNotificationPage> createState() => _SettingNotificationPageState();
}

class _SettingNotificationPageState extends State<SettingNotificationPage> {

  var _likeSwitch = false;


  _saveBool(String key, bool value) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  _restoreValues() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      _likeSwitch = prefs.getBool('bool1') ?? false;

    });
  }

  @override
  void initState() {
    _restoreValues();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    const divider = Divider(
      thickness: 2,
      height: 0,
      color: Colors.black12,
    );

    return Scaffold(
      backgroundColor: Color(0xffFDF3E6),
      appBar: AppBar(
        backgroundColor: Color(0xffFDF3E6),centerTitle: true,
          leading: IconButton(
            color: Colors.black,
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          title: Text('通知設定ページ',
            style: TextStyle(color: Colors.black),
          ),

      ),
      body: ListView(
        children: [
          ListTile(
            trailing: CupertinoSwitch(
              activeColor: Colors.pink,
              trackColor: Colors.blueGrey,
              value: _likeSwitch,
              onChanged: (value){
                setState(() {
                  _likeSwitch = value;
                  _saveBool('bool1', value);
                });
              },
            ),
            title: Text('リマインド'),
          ),
          divider,
        ],
      ),
    );
  }
}