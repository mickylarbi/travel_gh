import 'package:travel_gh/utils/models/route.dart';

abstract class SearchEvent {
  final List<CustomRoute> routes;
  final String departure;
  final String destination;
  final DateTime dateTime;
  SearchEvent(this.routes, {this.departure, this.destination, this.dateTime});
}

class UpdateRoutes extends SearchEvent {
  UpdateRoutes(List<CustomRoute> routes) : super(routes);
}

class DestinationSelectEvent extends SearchEvent {
  DestinationSelectEvent(List<CustomRoute> routes, String destination)
      : super(routes, destination: destination);
}

class DepartureSelectEvent extends SearchEvent {
  DepartureSelectEvent(List<CustomRoute> routes, String departure)
      : super(routes, departure: departure);
}

class TimeSelectEvent extends SearchEvent {
  TimeSelectEvent(List<CustomRoute> routes, DateTime dateTime)
      : super(routes, dateTime: dateTime);
}
