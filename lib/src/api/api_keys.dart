import 'package:get_it/get_it.dart';
import 'api.dart'; 

final sl = GetIt.instance;
const String apiKey = '83b899d8a21e6649d827fbe2388fc245';

void setupInjection() {
  sl.registerSingleton<OpenWeatherMapAPI>(
    OpenWeatherMapAPI('83b899d8a21e6649d827fbe2388fc245'),
    instanceName: 'api_key',
  );
}
