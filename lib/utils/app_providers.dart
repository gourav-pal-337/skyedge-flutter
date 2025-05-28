import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:skyedge/providers/auth_provider.dart';
import 'package:skyedge/providers/questionnaire_provider.dart';
import 'package:skyedge/providers/socket_provider.dart';
import 'package:skyedge/providers/theme_provider.dart';
import 'package:skyedge/providers/wallet_provider.dart';
// import 'package:skyedge/repositories/socket_repository.dart';
import 'package:skyedge/utils/progress_tracker.dart';

final List<SingleChildWidget> appProviders = [
  ChangeNotifierProvider(create: (_) => ThemeProvider()),
  ChangeNotifierProvider(create: (_) => AuthProvider()),
  ChangeNotifierProvider(create: (_) => ProgressTracker()),
  ChangeNotifierProvider(create: (_) => WalletProvider()),
  ChangeNotifierProvider(create: (_) => QuestionnaireProvider()),
  ChangeNotifierProvider(create: (_) => SocketProvider()),
];
