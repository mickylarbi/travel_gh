import 'dart:async';

import 'package:travel_gh/utils/firestore_data.dart';
import 'package:travel_gh/utils/models/route.dart';
import 'package:travel_gh/utils/search_bloc/search_events.dart';
import 'package:travel_gh/utils/search_bloc/search_state.dart';

class SearchBloc {
  List<CustomRoute> _routes;
  List<CustomRoute> _displayRoutes;
  String _destination;
  String _departure;
  DateTime _dateTime;

  final StreamController<SearchEvent> _searchEventController =
      StreamController<SearchEvent>();
  final StreamController<List<CustomRoute>> _searchStateController =
      StreamController<List<CustomRoute>>();

  StreamSink<SearchEvent> get searchEventStreamSink =>
      _searchEventController.sink;
  StreamSink<List<CustomRoute>> get _searchStateStreamSink =>
      _searchStateController.sink;
  Stream<List<CustomRoute>> get searchStateStream =>
      _searchStateController.stream.asBroadcastStream();

  createInstance() {
    _searchEventController.stream.listen(mapEventToState);
  }

  mapEventToState(SearchEvent event) {
    _routes = _displayRoutes = event.routes;
    _destination = event.destination;
    _departure = event.departure;
    _dateTime = event.dateTime;
    print(_routes.length);


    if (event is DepartureSelectEvent) {
      if ((_destination == null || _destination.isEmpty) && _dateTime == null)
        _displayRoutes = _routes
            .where((element) => element.departure != _departure)
            .toList();
      else if (_dateTime == null)
        _displayRoutes = _routes
            .where((element) =>
                element.departure != _departure ||
                element.destination != _destination)
            .toList();
      else if (_destination == null || _destination.isEmpty)
        _displayRoutes = _routes
            .where((element) =>
                element.departure != _departure ||
                element.dateTime != _dateTime)
            .toList();
    }
    if (event is DestinationSelectEvent) {
      // _destination = event.destination;

      if ((_departure == null || _departure.isEmpty) && _dateTime == null)
        _displayRoutes = _routes
            .where((element) => element.destination != _destination)
            .toList();
      else if (_dateTime == null)
        _displayRoutes = _routes
            .where((element) =>
                element.destination != _destination ||
                element.departure != _departure)
            .toList();
      else if (_departure == null || _departure.isEmpty)
        _displayRoutes = _routes
            .where((element) =>
                element.destination != _destination ||
                element.dateTime != _dateTime)
            .toList();
    }
    if (event is TimeSelectEvent) {
      _dateTime = event.dateTime;

      if ((_destination == null || _destination.isEmpty) &&
          (_departure == null || _departure.isEmpty))
        _routes.removeWhere((element) => element.dateTime != _dateTime);
      else if (_departure == null || _departure.isEmpty)
        _routes.removeWhere((element) =>
            element.dateTime != _dateTime ||
            element.destination != _destination);
      else if (_destination == null || _destination.isEmpty)
        _routes.removeWhere((element) =>
            element.dateTime != _dateTime || element.departure != _departure);
    }

    _searchStateStreamSink.add(_displayRoutes);
    print('dr ${_displayRoutes.length}');
  }

  void dispose() {
    _searchEventController.close();
    _searchStateController.close();
  }
}
