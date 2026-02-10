import 'package:blablah_car/ui/screens/pickLocation/location_picker_screen.dart';
import 'package:blablah_car/ui/screens/search_screen/search_screen.dart';
import 'package:blablah_car/ui/widgets/actions/blabutton.dart';
import 'package:blablah_car/ui/widgets/display/bla_divider.dart';
import 'package:flutter/material.dart';

import '../../../../model/ride/locations.dart';
import '../../../../model/ride_pref/ride_pref.dart';

///
/// A Ride Preference From is a view to select:
///   - A depcarture location
///   - An arrival location
///   - A date
///   - A number of seats
///
/// The form can be created with an existing RidePref (optional).
///
class RidePrefForm extends StatefulWidget {
  // The form can be created with an optional initial RidePref.
  final RidePref? initRidePref;
  final Function(RidePref)? onSearch; // Callback to parent

  const RidePrefForm({super.key, this.initRidePref, this.onSearch});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;

  // ----------------------------------
  // Initialize the Form attributes
  // ----------------------------------

  @override
  void initState() {
    super.initState();
    if (widget.initRidePref != null) {
      departure = widget.initRidePref!.departure;
      arrival = widget.initRidePref!.arrival;
      departureDate = widget.initRidePref!.departureDate;
      requestedSeats = widget.initRidePref!.requestedSeats;
    } else {
      departureDate = DateTime.now();
      requestedSeats = 1;
    }
  }

  // ----------------------------------
  // Handle events
  // ----------------------------------
  void _onDepartureChanged(Location? location) {
    setState(() => departure = location);
  }

  void _onArrivalChanged(Location? location) {
    setState(() => arrival = location);
  }

  void _onDateChanged(DateTime date) {
    setState(() => departureDate = date);
  }

  void _onSeatsChanged(int seats) {
    setState(() => requestedSeats = seats);
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: departureDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null) {
      _onDateChanged(picked);
    }
  }

  Future<void> _selectDeparture(BuildContext context) async {
    final location = await Navigator.push<Location>(
      context,
      MaterialPageRoute(builder: (context) => LocationPickerScreen()),
    );
    if (location != null) {
      _onDepartureChanged(location);
    }
  }

  Future<void> _selectArrival(BuildContext context) async {
    final location = await Navigator.push<Location>(
      context,
      MaterialPageRoute(builder: (context) => LocationPickerScreen()),
    );
    if (location != null) {
      _onArrivalChanged(location);
    }
  }

  // ----------------------------------
  // Compute the widgets rendering
  // ----------------------------------

  // ----------------------------------
  // Build the widgets
  // ----------------------------------
  @override
  Widget build(BuildContext context) {
    //  Column for the form
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          //  Column for the picker
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Leaving From
              GestureDetector(
                onTap: () => _selectDeparture(context),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.04,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on, color: Colors.grey[400]),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                      Text(
                        departure?.name ?? "Leaving from",
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ),

              const BlaDivider(),

              // Going to
              GestureDetector(
                onTap: () => _selectArrival(context),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.location_on, color: Colors.grey[400]),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                      Text(
                        arrival?.name ?? "Going to",
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ),

              const BlaDivider(),

              // Date
              GestureDetector(
                onTap: () => _selectDate(context),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.calendar_today, color: Colors.grey[400]),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                      Text(
                        departureDate.day == DateTime.now().day
                            ? "Today"
                            : "${departureDate.toString().split(' ')[0]}",
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ),
              const BlaDivider(),

              // Seats
              GestureDetector(
                onTap: () => _showSeatsPicker(context),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.05,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.person, color: Colors.grey[400]),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                      Text(
                        "$requestedSeats",
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ),
              const BlaDivider(),

              // Search Button
              BlaButton(
                label: "Hell Yeah",
                onPressed: () => Navigator.pop(context),
              ),
              BlaButton(
                label: "Hell Nooo",
                onPressed: () => Navigator.pop(context),
                type: BlaButtonType.secondary,
              ),

              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => SearchScreen()),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: EdgeInsets.all(16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    "Search",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showSeatsPicker(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Select number of seats"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(6, (index) {
            final seats = index + 1;
            return ListTile(
              title: Text("$seats"),
              onTap: () {
                _onSeatsChanged(seats);
                Navigator.pop(context);
              },
            );
          }),
        ),
      ),
    );
  }
}
