import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesUtils {

    // 储存(int类型)
    static save (String key, value) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        return prefs.setInt(key, value);
    }

    // 取值
    static get(String key) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        return prefs.get(key);
    }

    // 删除对应的key
    static remove(String key) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        return prefs.remove(key);
    }

    // 清空所有键值对
    static clear() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        return prefs.clear();
    }


}