part of 'index.dart';

@protected
class AppMiddleware {
  /// logging
  static LoggingMiddleware<AppState> from() =>
      LoggingMiddleware<AppState>.printer(
          logger: new Logger("LoLottery_Redux"), level: Level.INFO);
}
