import 'package:flutter/material.dart';
import 'package:open_weather_example_flutter/src/constants/app_colors.dart';
import 'package:open_weather_example_flutter/src/features/weather/application/providers.dart';
import 'package:provider/provider.dart';

class CitySearchBox extends StatefulWidget {
  const CitySearchBox({super.key});

  @override
  State<CitySearchBox> createState() => _CitySearchBoxState();
}

class _CitySearchBoxState extends State<CitySearchBox> {
  static const _radius = 30.0;

  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    final initialCity = context.read<WeatherProvider>().city;
    _searchController = TextEditingController(text: initialCity);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearch() {
    FocusScope.of(context).unfocus(); // hide keyboard
    final city = _searchController.text.trim();
    if (city.isNotEmpty) {
      context.read<WeatherProvider>().city = city;
      // TODO: Trigger weather fetch logic if not handled by provider setter
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        height: _radius * 2,
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Enter city name',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(_radius),
                      bottomLeft: Radius.circular(_radius),
                    ),
                    borderSide: BorderSide.none,
                  ),
                ),
                textInputAction: TextInputAction.search,
                onSubmitted: (_) => _onSearch(),
              ),
            ),
            InkWell(
              onTap: _onSearch,
              child: Container(
                height: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: AppColors.accentColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(_radius),
                    bottomRight: Radius.circular(_radius),
                  ),
                ),
                child: Text(
                  'Search',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
