import 'package:bukuku_sample_test/View/login/state/login_state.dart';
import 'package:bukuku_sample_test/global_state.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => GlobalState()),
  ChangeNotifierProvider(create: (_) => LoginState())
];
