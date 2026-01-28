import 'package:category_b/core/services/models/anekdots.dart';
import 'package:hive_ce/hive_ce.dart';

@GenerateAdapters([AdapterSpec<Anekdot>()])
part 'hive_adapters.g.dart';
