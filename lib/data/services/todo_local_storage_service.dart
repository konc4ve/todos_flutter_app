import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoLocalStorageService {
  TodoLocalStorageService({required SharedPreferences plugin})
    : _plugin = plugin;
  final SharedPreferences _plugin;

  @visibleForTesting
  static const kTodosCollectionKey = '__todos_collection_key__';

  String? getString() {
    return _plugin.getString(kTodosCollectionKey);
  }

  Future<void> setString(String string) async {
    await _plugin.setString(kTodosCollectionKey, string);
  }
}
