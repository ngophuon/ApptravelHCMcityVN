import 'package:complex_ui_rive_animation/weather/src/features/weather/domain/forecast/forecast.dart';
import 'package:complex_ui_rive_animation/weather/src/features/weather/domain/weather/weather_data.dart';

/// Derived model class used in the UI
class ForecastData {
  const ForecastData(this.list);
  factory ForecastData.from(Forecast forecast) {
    return ForecastData(
      forecast.list.map((item) => WeatherData.from(item)).toList(),
    );
  }
  final List<WeatherData> list;
}
