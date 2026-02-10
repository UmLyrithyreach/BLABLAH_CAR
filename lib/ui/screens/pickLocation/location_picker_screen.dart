import 'package:flutter/material.dart';
import '../../../../data/dummy_data.dart';
import '../../../../model/ride/locations.dart';

class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({super.key});

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  late TextEditingController _searchcontroller;
  bool _hasText = false;
  List<Location> filteredLocations = fakeLocations;

  @override
  void initState() {
    super.initState();
    _searchcontroller = TextEditingController();
    _searchcontroller.addListener(_updateSearchState);
    filteredLocations = fakeLocations;
  }

  @override
  void dispose() {
    _searchcontroller.dispose();
    super.dispose();
  }

  void _updateSearchState() {
    setState(() {
      _hasText = _searchcontroller.text.isNotEmpty;
      if (_searchcontroller.text.isEmpty) {
        filteredLocations = fakeLocations;
      } else {
        filteredLocations = fakeLocations
            .where(
              (location) => location.name.toLowerCase().contains(
                _searchcontroller.text.toLowerCase(),
              ),
            )
            .toList();
      }
    });
  }

  void _clearSearch() {
    _searchcontroller.clear();
    setState(() {
      _hasText = false;
      filteredLocations = fakeLocations;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(25),
          child: Column(
            children: [
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.grey[200],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.arrow_back),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: _searchcontroller,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Search location...',
                        ),
                      ),
                    ),
                    if (_hasText)
                      IconButton(
                        onPressed: _clearSearch,
                        icon: Icon(Icons.close),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredLocations.length,
                  itemBuilder: (context, index) {
                    final location = filteredLocations[index];
                    return ListTile(
                      leading: Icon(Icons.location_on, color: Colors.grey[400]),
                      title: Text(location.name),
                      subtitle: Text(location.country.name),
                      onTap: () {
                        Navigator.pop(context, location);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
