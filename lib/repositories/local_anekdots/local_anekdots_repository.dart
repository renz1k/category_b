import 'package:anekdots_b/repositories/local_anekdots/model/local_anekdot.dart';

abstract class LocalAnekdotsRepository {
  // Получить все локальные анекдоты
  Future<List<LocalAnekdot>> getAll();

  // Добавить батч из Firebase (FIFO: если > MAX → clear + add)
  Future<void> addBatchFromFirebase(List<LocalAnekdot> batch);

  // Очистить локальный кэш
  Future<void> clear();

  // Количество локальных анекдотов
  Future<int> getTotal();

  // Последнее обновление Firebase
  Future<DateTime?> getLastUpdateTime();

  // Обновить timestamp обновления
  Future<void> setLastUpdateTime(DateTime time);
}
