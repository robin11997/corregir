import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'dart:math' show pi;
import 'package:bloc/bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'dart:async';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_gradients/flutter_gradients.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

const String testDevice = 'YOUR_DEVICE_ID';
void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(MyApp());
}

final repository = StationRepository(
  apiClient: ApiClient(httpClient: http.Client()),
);

////////////////////  V  A  R I  A  B  L  E  S   ////////////////////
final urlBaseDatos = 'https://contador-63b43.firebaseio.com/';
final tituloApp = 'BANGLADESH RADIO';
final tituloMenu = 'Menú';
final fondoImg = 'assets/1.jpg';

final politicas = 'Politicas';

final compartir = 'Compartir';

final calificar = 'Calificar';

final salir = 'Salir';

final juego = 'Tic Tac Toe';
final calculadora = 'Calculadora';

final urlPoliticas =
    'http://chubisdesarrolladores.blogspot.com/2017/09/privacy-policy-for-mobile-applications.html';

const urlCalificar =
    'https://play.google.com/store/apps/details?id=com.mobirix.jp.snowbrothers&hl=es-419';

final textoAlCompartir =
    'Descargate esta app!!!  https://play.google.com/store/apps/details?id=com.mobirix.jp.snowbrothers&hl=es-419';

final colorBarReproduccion = Color.fromRGBO(45, 22, 91, 1.0);
final colorFondoCirculoBarra = Colors.lightBlue;
final gradienteConfiguracion = FlutterGradients.fabledSunset(
  type: GradientType.sweep,
  // type: GradientType.linear,
  // type: GradientType.radial,
);

final gradienteConfiguracionFondo = FlutterGradients.frozenHeat(
  // type: GradientType.sweep,
  type: GradientType.linear,
  // type: GradientType.radial,
);
final fuenteAppbar = GoogleFonts.lemonada(
    textStyle: TextStyle(color: Colors.white, fontSize: 18.0));

///FUENTE DEL TITULO DEL    A  P  B  A  R  NO TIENE QUE TENER LA ETIQUETA TEXTTHEME
final estiloFuente = TextStyle(
    fontSize: 16.0,
    // fontWeight: FontWeight.bold,
    color: Colors.black.withOpacity(0.8));

final estiloFuenteSubtitulo = TextStyle(
    fontSize: 12.0,
    // fontWeight: FontWeight.bold,
    color: Colors.black.withOpacity(0.5));

///////////// COLORES  JUEGO
Color crossColor = Color.fromRGBO(13, 143, 218, 1.0);
Color circleColor = Color.fromRGBO(44, 211, 193, 1.0);
Color accentColor = Colors.pinkAccent;
final colorTemaTicTac = Colors.cyan;

/////////

final angle = ZoomDrawer.isRTL() ? 180 * pi / 180 : 0.0;

// ///////////  C  O  D  I  G  O  S  -----  A  D  M  O  B -----------  ///////////////

// //////////----  C  O  D  I  G O  S  -- A  N  D  R  O  I  D  ---------  ////////////

// /////////  B  A  N  N  E  R

String adBanner = BannerAd.testAdUnitId;
// String adBanner = "ca-app-pub-6537864605541294/5980945338";

// /////////  I  N  T  E  R  S  T  I  C  I  A  L

String adIntersticial = InterstitialAd.testAdUnitId;
// String adIntersticial = "ca-app-pub-6537864605541294/3626599957";

//////////Palabras Clave
final palabraClave1 = "palabra ";
final palabraClave2 = "palabra ";
final palabraClave3 = "palabra ";
final palabraClave4 = "palabra ";
final palabraClave5 = "palabra ";
final palabraClave6 = "palabra ";
final palabraClave7 = "palabra ";
final palabraClave8 = "palabra ";
final palabraClave9 = "palabra ";
final palabraClave10 = "palabra ";

final numeroClics = 4;

///////////////////
int counttaps = 0;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: tituloApp,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.sansitaTextTheme(
          //// fuente del M E N U   L A T E R A L, TIENE QUE TENER LA ETIQUETA TEXTTHEME
          Theme.of(context).textTheme,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => HomeScreen(),
        'calculadora': (BuildContext context) => MyHomePage(),
        'juego': (BuildContext context) => JuegoTicTac(),
        'home': (BuildContext context) => HomeScreen(),
      },
    );
  }
}

////////////////////////////

class StationsPage extends StatefulWidget {
  @override
  _StationsPageState createState() => _StationsPageState();
}

class _StationsPageState extends State<StationsPage> {
  static final AdRequest request = AdRequest(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    keywords: <String>[
      palabraClave1,
      palabraClave2,
      palabraClave3,
      palabraClave4,
      palabraClave5,
      palabraClave6,
      palabraClave7,
      palabraClave8,
      palabraClave9,
      palabraClave10,
    ],
    contentUrl: urlPoliticas,
    nonPersonalizedAds: true,
  );

  InterstitialAd _interstitialAd;
  bool _interstitialReady = false;

  @override
  void initState() {
    super.initState();
    MobileAds.instance.initialize().then((InitializationStatus status) {
      print('Initialization done: ${status.adapterStatuses}');
      MobileAds.instance
          .updateRequestConfiguration(RequestConfiguration(
              tagForChildDirectedTreatment:
                  TagForChildDirectedTreatment.unspecified))
          .then((value) {
        createInterstitialAd();
      });
    });
  }

  void createInterstitialAd() {
    _interstitialAd ??= InterstitialAd(
      adUnitId: adIntersticial,
      request: request,
      listener: AdListener(
        onAdLoaded: (Ad ad) {
          print('${ad.runtimeType} loaded.');
          _interstitialReady = true;
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('${ad.runtimeType} failed to load: $error.');
          ad.dispose();
          _interstitialAd = null;
          createInterstitialAd();
        },
        onAdOpened: (Ad ad) => print('${ad.runtimeType} onAdOpened.'),
        onAdClosed: (Ad ad) {
          print('${ad.runtimeType} closed.');
          ad.dispose();
          createInterstitialAd();
        },
        onApplicationExit: (Ad ad) =>
            print('${ad.runtimeType} onApplicationExit.'),
      ),
    )..load();
  }

  @override
  void dispose() {
    _interstitialAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int counttaps = 0;
    return GestureDetector(
      onTap: () {
        counttaps++;
        print("TAPS = " + counttaps.toString());
        if (counttaps == numeroClics) {
          if (!_interstitialReady) return;
          _interstitialAd.show().whenComplete(() => counttaps = 0);
          _interstitialReady = false;
          _interstitialAd = null;
        }
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.lemonadaTextTheme(
            Theme.of(context)
                .textTheme, ////// F  U  E  N  T  E   P A G I N A, TIENE QUE TENER LA ETIQUETA TEXTTHEME
          ),
        ),
        home: Scaffold(
          appBar: AppBar(
            elevation: 20.0,
            backgroundColor: colorBarReproduccion,
            automaticallyImplyLeading: false,
            title: Text(
              tituloApp,
              style: fuenteAppbar,
            ),
            leading: Transform.rotate(
              angle: angle,
              child: PlatformIconButton(
                icon: Icon(
                  Icons.menu,
                  color: Colors.white,
                ),
                onPressed: () {
                  ZoomDrawer.of(context).toggle();
                },
              ),
            ),
          ),
          body: Stack(
            children: [
              // FondoGrad(),
              // FondoImagen(),

              BlocBuilder<StationsBloc, StationsState>(
                builder: (context, state) {
                  if (state is StationsLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is StationsError) {
                    return Center(
                        child: Text(
                      'Error! ' + '\nNo Internet Connection!' + '\n:(',
                      textAlign: TextAlign.center,
                    ));
                  } else if (state is StationsLoaded) {
                    return Column(
                      children: [
                        Expanded(
                          child: ListView.builder(
                            itemCount: state.stations.length,
                            itemBuilder: (context, index) {
                              final station = state.stations[index];
                              return InkWell(
                                child: StationItem(station: station),
                                // onTap: () => BlocProvider.of<StationsBloc>(context)
                                //     .add(StationsSelect(selectedStation: station)),

                                onTap: () {
                                  BlocProvider.of<StationsBloc>(context).add(
                                      StationsSelect(selectedStation: station));
                                  counttaps++;

                                  print("TAPS = " + counttaps.toString());
                                  if (counttaps == numeroClics) {
                                    if (!_interstitialReady) return;
                                    _interstitialAd
                                        .show()
                                        .whenComplete(() => counttaps = 0);
                                    _interstitialReady = false;
                                    _interstitialAd = null;
                                  }
                                },
                              );
                            },
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            left: 33.0,
                            right: 15.0,
                          ),
                          height: 50.0,
                          child: BannerAdWidget(AdSize.banner),
                        ),
                        // SizedBox(
                        //   height: 10.0,
                        // ),
                      ],
                    );
                  }
                  return Container();
                },
              ),
              // PaAd()
            ],
          ),
          bottomNavigationBar: BlocBuilder<StationsBloc, StationsState>(
            builder: (context, state) {
              final currentStation =
                  state is StationsLoaded ? state.selectedStation : null;
              final playbackStatus =
                  state is StationsLoaded ? state.playbackStatus : null;

              if (null != currentStation) {
                return PlayerBar(
                  currentStation: currentStation,
                  playbackStatus: playbackStatus,
                );
              } else {
                return const SizedBox(width: 0, height: 0);
              }
            },
          ),
        ),
      ),
    );
  }
}

////////////////////////////
///

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => new _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: ZoomDrawerController(),
      menuScreen: MenuScreen(),
      mainScreen: App(repository: repository),
      borderRadius: 24.0,
      showShadow: true,
      angle: -12.0,
      backgroundColor: Colors.grey[300],
      slideWidth:
          MediaQuery.of(context).size.width * (ZoomDrawer.isRTL() ? .45 : 0.65),
    );
  }
}
//////////////////////////////

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final widthBox = SizedBox(
    width: 16.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          // gradient: LinearGradient(
          //   colors: [
          //     Theme.of(context).primaryColor,
          //     Colors.pink,
          //   ],
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          // ),

          gradient: gradienteConfiguracion,
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 24.0, left: 24.0, right: 24.0),
                child: Container(
                  alignment: Alignment.topLeft,
                  child: Icon(
                    Icons.radio,
                    size: 55.0,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    bottom: 36.0, left: 24.0, right: 24.0),
                child: Text(
                  (tituloMenu),
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    // fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(
                  FontAwesomeIcons.calculator,
                  size: 20.0,
                  color: Colors.white,
                ),
                title: Text(
                  calculadora,
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                  textAlign: TextAlign.left,
                ),
                onTap: () {
                  Navigator.pushNamed(context, 'calculadora');
                },
                // onTap: () => MyHomePage(),
              ),
              Divider(
                color: Colors.white,
              ),
              ListTile(
                leading: Icon(
                  FontAwesomeIcons.gamepad,
                  size: 20.0,
                  color: Colors.white,
                ),
                title: Text(
                  juego,
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
                onTap: () {
                  Navigator.pushNamed(context, 'juego');
                },
              ),
              Divider(
                color: Colors.white,
              ),
              ListTile(
                leading: Icon(
                  FontAwesomeIcons.book,
                  size: 20.0,
                  color: Colors.white,
                ),
                title: Text(
                  politicas,
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
                onTap: _launchURL,
              ),
              Divider(
                color: Colors.white,
              ),
              ListTile(
                  leading: Icon(
                    FontAwesomeIcons.shareAlt,
                    size: 20.0,
                    color: Colors.white,
                  ),
                  title: Text(
                    compartir,
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                  onTap: () {
                    Share.share(textoAlCompartir);
                  }),
              Divider(
                color: Colors.white,
              ),
              ListTile(
                leading: Icon(
                  FontAwesomeIcons.star,
                  size: 20.0,
                  color: Colors.white,
                ),
                title: Text(
                  calificar,
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
                onTap: _launchURLCalificar,
              ),
              Divider(
                color: Colors.white,
              ),
              ListTile(
                leading: Icon(
                  FontAwesomeIcons.signOutAlt,
                  size: 20.0,
                  color: Colors.white,
                ),
                title: Text(
                  salir,
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
                onTap: () => exit(0),
              ),
              Divider(
                color: Colors.white,
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

///
/// Top level widget.
class App extends StatelessWidget {
  final StationRepository _repository;

  /// Requires [repository].
  const App({Key key, @required StationRepository repository})
      : assert(null != repository),
        _repository = repository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: tituloApp,
      home: BlocProvider<StationsBloc>(
        create: (context) =>
            StationsBloc(repository: _repository)..add(StationsRefresh()),
        child: StationsPage(),
      ),
    );
  }
}

class FondoGrad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(gradient: gradienteConfiguracionFondo),
    );
  }
}

class FondoImagen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: double.infinity,
          child: Image(
            image: AssetImage(fondoImg),
            fit: BoxFit.cover,
          ),
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.black.withOpacity(0.15),
        ),
      ],
    );
  }
}

///
class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    print('onEvent $event');
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print('onTransition $transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {
    print('onError $error');
    super.onError(bloc, error, stackTrace);
  }
}

///

/// Generic class for states.
abstract class StationsState extends Equatable {
  ///
  const StationsState();

  @override
  List<Object> get props => [];
}

/// State for loading.
class StationsLoading extends StationsState {
  ///
  const StationsLoading();
}

/// Loaded stations state with additional info.
class StationsLoaded extends StationsState {
  /// List of loaded stations.
  final List<Station> stations;

  /// Currently selected station.
  final Station selectedStation;

  /// Currently playback status: playing, buffering, etc.
  final PlaybackStatus playbackStatus;

  /// Flag for currently selected station.
  bool get hasSelectedStation => null != selectedStation;

  /// Requires list of [stations].
  /// Default [playbackStatus] is [PlaybackStatus.buffering].
  const StationsLoaded({
    @required this.stations,
    this.playbackStatus = PlaybackStatus.buffering,
    this.selectedStation,
  });

  @override
  List<Object> get props => [stations, selectedStation, playbackStatus];

  @override
  String toString() => 'StationsLoaded('
      'selectedStation: $selectedStation, '
      'stations: $stations,'
      'playbackStatus: $playbackStatus)';
}

/// State for errors.
class StationsError extends StationsState {
  /// Error what cause this state.
  final Exception error;

  /// Requires [error].
  const StationsError({@required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'StationsError(error: $error)';
}

/// Playback status.
enum PlaybackStatus {
  /// Playing.
  playing,

  /// Paused.
  paused,

  /// Buffering.
  buffering,

  /// Error.
  error,
}

///
class StationsBloc extends Bloc<StationsEvent, StationsState> {
  final StationRepository _repository;
  final _player = AudioPlayer();

  bool _isPendingPlay = false;
  List<Station> _stations = [];
  Station _selectedStation;
  PlaybackStatus _playbackStatus = PlaybackStatus.buffering;
  StreamSubscription<FullAudioPlaybackState> _streamSubscription;

  /// Requires [repository].
  StationsBloc({@required StationRepository repository})
      : assert(null != repository),
        _repository = repository;

  @override
  StationsState get initialState => StationsLoading();

  @override
  Stream<StationsState> mapEventToState(StationsEvent event) async* {
    if (event is StationsRefresh) {
      yield* _fetchStations();
    } else if (event is StationsSelect) {
      yield* _changeStation(event);
    } else if (event is PlaybackStatusUpdate) {
      yield* _updatePlaybackStatus(event.status);
    } else if (event is StationsTogglePlayback) {
      yield* _togglePlaybackStatus();
    }
  }

  Stream<StationsState> _fetchStations() async* {
    try {
      _stations = await _repository.listStations();
      yield _createLoadedState();
    } on Exception catch (e) {
      yield StationsError(error: e);
    }
  }

  Stream<StationsState> _changeStation(StationsSelect event) async* {
    if (_selectedStation == event.selectedStation) return;

    // await _gracefullyStopPlayer();
    _gracefullyStopPlayer();

    _selectedStation = event.selectedStation;
    _playbackStatus = PlaybackStatus.buffering;
    yield _createLoadedState();

    _subscribeToStream();

    _isPendingPlay = true;
    await _player.setUrl(event.selectedStation.streamUrl);
    // .catchError((e) => print('Error! No Internet Connection!'));
  }

  StationsLoaded _createLoadedState() {
    return StationsLoaded(
      stations: _stations,
      selectedStation: _selectedStation,
      playbackStatus: _playbackStatus,
    );
  }

  void _subscribeToStream() {
    if (null == _streamSubscription) {
      _streamSubscription = _player.fullPlaybackStateStream.listen((event) {
        final isBuffering = event.buffering == true;
        final isPaused = [
          AudioPlaybackState.paused,
          AudioPlaybackState.stopped,
        ].contains(event.state);

        if (event.state == AudioPlaybackState.connecting || isBuffering) {
          add(PlaybackStatusUpdate(status: PlaybackStatus.buffering));
        } else if (event.state == AudioPlaybackState.playing) {
          _isPendingPlay = false;
          add(PlaybackStatusUpdate(status: PlaybackStatus.playing));
        } else if (isPaused) {
          add(PlaybackStatusUpdate(status: PlaybackStatus.paused));
          if (_isPendingPlay) {
            _resumePlay();
          }
        }
      }, onError: (_) {
        _isPendingPlay = false;
        add(PlaybackStatusUpdate(status: PlaybackStatus.error));
      });
    }
  }

  Stream<StationsState> _updatePlaybackStatus(PlaybackStatus status) async* {
    if (_playbackStatus == status) return;

    _playbackStatus = status;
    yield _createLoadedState();
  }

  Stream<StationsState> _togglePlaybackStatus() async* {
    if (_playbackStatus == PlaybackStatus.paused) {
      _playbackStatus = PlaybackStatus.playing;
      _player.play();
      yield _createLoadedState();
    } else if (_playbackStatus == PlaybackStatus.playing) {
      _playbackStatus = PlaybackStatus.paused;
      await _player.pause();
      yield _createLoadedState();
    }
  }

  @override
  Future<void> close() async {
    // await _disposePlayer();
    _disposePlayer();
    return super.close();
  }

  void _disposePlayer() async {
    await _streamSubscription?.cancel();
    _streamSubscription = null;
    // await _gracefullyStopPlayer();
    _gracefullyStopPlayer();
    await _player.dispose();
  }

  void _gracefullyStopPlayer() async {
    try {
      await _player.stop();
    } on Exception catch (_) {}
  }

  void _resumePlay() {
    _isPendingPlay = false;
    _playbackStatus = PlaybackStatus.playing;
    _player.play();
    add(PlaybackStatusUpdate(status: PlaybackStatus.playing));
  }
}

///

/// Generic class for all events.
abstract class StationsEvent extends Equatable {
  ///
  const StationsEvent();

  @override
  List<Object> get props => [];
}

/// Reloads current stations.
class StationsRefresh extends StationsEvent {
  ///
  const StationsRefresh();
}

/// Triggered when User select station.
class StationsSelect extends StationsEvent {
  /// Selected station.
  final Station selectedStation;

  /// Requires [selectedStation].
  const StationsSelect({@required this.selectedStation});

  @override
  List<Object> get props => [selectedStation];

  @override
  String toString() => 'StationsPlay(station: $selectedStation)';
}

/// Updates playback status.
/// It's needed for internal updates for example: buffering -> playing.
class PlaybackStatusUpdate extends StationsEvent {
  /// New status.
  final PlaybackStatus status;

  /// Requires [status].
  const PlaybackStatusUpdate({@required this.status});

  @override
  List<Object> get props => [status];

  @override
  String toString() => 'PlaybackStatusUpdate(status: $status)';
}

class StationsTogglePlayback extends StationsEvent {
  ///
  const StationsTogglePlayback();
}

//////////////////////////  W  I  D  G  E  T  S  ///////////////
/// PLAYER BAR

/// Widget showing currently playing station.
class PlayerBar extends StatelessWidget {
  /// Currently selected station.
  final Station currentStation;

  /// Current playback status: playing, buffering.
  final PlaybackStatus playbackStatus;

  /// Requires [currentStation], [playbackStatus].
  const PlayerBar({
    Key key,
    @required this.currentStation,
    @required this.playbackStatus,
  })  : assert(null != currentStation),
        assert(null != playbackStatus),
        super(key: key);

  Widget get _playbackWidget {
    switch (playbackStatus) {
      case PlaybackStatus.playing:
        return Icon(Icons.pause, color: Colors.white, size: 48.0);
      case PlaybackStatus.paused:
        return Icon(Icons.play_arrow, color: Colors.white, size: 48.0);
      case PlaybackStatus.error:
        return Icon(Icons.error, color: Colors.red, size: 48.0);
      case PlaybackStatus.buffering:
        return SizedBox(
          width: 48.0,
          height: 48.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircularProgressIndicator(backgroundColor: Colors.white),
          ),
        );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = currentStation.logoUrl;
    final stationName = currentStation.name;

    return Container(
      height: 120.0,
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(color: colorBarReproduccion),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(imageUrl),
                backgroundColor: colorFondoCirculoBarra,
                radius: 45.0,
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(
                  stationName,
                  textDirection: TextDirection.ltr,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              TextButton(
                onPressed: () => BlocProvider.of<StationsBloc>(context)
                    .add(StationsTogglePlayback()),
                child: _playbackWidget,
              )
            ],
          ),
          // SizedBox(height: 50.0),
        ],
      ),
    );
  }
}

///  STATION ITEM
/// Widget for single item
class StationItem extends StatelessWidget {
  /// Station
  final Station station;

  /// Requires [station] to show.
  const StationItem({Key key, @required this.station}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 8.0, bottom: 8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(
                  station.logoUrl,
                ),
                backgroundColor: colorFondoCirculoBarra,
                radius: 40.0,
              ),
              const SizedBox(width: 16.0),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(station.name,
                        overflow: TextOverflow.ellipsis, style: estiloFuente),
                    const SizedBox(height: 4.0),
                    Text(
                      station.genre.join(', '),
                      overflow: TextOverflow.ellipsis,
                      style: estiloFuenteSubtitulo,
                    )
                  ],
                ),
              ),
            ],
          ),
          Divider(
            color: colorBarReproduccion,
          )
        ],
      ),
    );
  }
}

class Station extends Equatable {
  final String name;
  final String streamUrl;
  final String logoUrl;
  final List<String> genre;

  ///
  const Station({
    this.name,
    this.streamUrl,
    this.logoUrl,
    this.genre,
  });

  static Station fromJson(dynamic json) {
    return Station(
      name: json['name'] as String ?? '',
      streamUrl: json['streamUrl'] as String ?? '',
      logoUrl: json['logoUrl'] as String ?? '',
      genre: (json['genre'] as Map<String, dynamic>).keys.toList(),
    );
  }

  @override
  List<Object> get props => [name, streamUrl, logoUrl, genre];

  @override
  String toString() => 'Station(name: $name)';
}

class StationRepository {
  final ApiClient _apiClient;

  /// Creates repo. Requires [apiClient].
  StationRepository({@required ApiClient apiClient})
      : assert(null != apiClient),
        _apiClient = apiClient;

  /// Returns list of stations.
  Future<List<Station>> listStations() {
    return _apiClient.listStations();
  }
}

///

///

/// API HTTP Client.
class ApiClient {
  final http.Client _httpClient;
  final _baseUrl = urlBaseDatos;

  /// Requires [httpClient].
  ApiClient({@required http.Client httpClient})
      : assert(null != httpClient),
        _httpClient = httpClient;

  Future<List<Station>> listStations() async {
    final url = '$_baseUrl/Stations.json';
    final response = await _httpClient.get(url);
    if (response.statusCode != 200) {
      throw Exception('Can\'t fetch stations.');
    }

    try {
      final body = utf8.decode(response.bodyBytes);
      final items = json.decode(body) as Map<String, dynamic>;
      return items.entries.map((item) => Station.fromJson(item.value)).toList();
    } on Exception catch (_) {
      throw Exception('Can\'t parse response.');
    }
  }
}

_launchURL() async {
  if (await canLaunch(urlPoliticas)) {
    await launch(urlPoliticas);
  } else {
    throw 'Could not launch $urlPoliticas';
  }
}

_launchURLCalificar() async {
  if (await canLaunch(urlCalificar)) {
    await launch(urlCalificar);
  } else {
    throw 'Could not launch $urlPoliticas';
  }
}

///

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String strInput = "";
  final textControllerInput = TextEditingController();
  final textControllerResult = TextEditingController();

  @override
  void initState() {
    super.initState();
    textControllerInput.addListener(() {});
    textControllerResult.addListener(() {});
  }

  @override
  void dispose() {
    textControllerInput.dispose();
    textControllerResult.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Container(
                  width: double.infinity,
                  height: 80.0,
                  // alignment: Alignment.topRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GradientButton(
                        child: Text(
                          'Back',
                          style: TextStyle(fontSize: 35.0),
                        ),
                        increaseWidthBy: 40.0,
                        increaseHeightBy: 10.0,
                        callback: () => Navigator.pop(context),
                        gradient: Gradients.rainbowBlue,
                      ),
                    ],
                  )),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: new TextField(
                      decoration: new InputDecoration.collapsed(
                          hintText: "0",
                          hintStyle: GoogleFonts.robotoMono(
                              textStyle: TextStyle(
                            fontSize: 30,
                            fontFamily: 'RobotoMono',
                          ))),
                      style: GoogleFonts.robotoMono(
                          textStyle: TextStyle(
                        fontSize: 30,
                        fontFamily: 'RobotoMono',
                      )),
                      textAlign: TextAlign.right,
                      controller: textControllerInput,
                      onTap: () =>
                          FocusScope.of(context).requestFocus(new FocusNode()),
                    )),
                new Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      decoration: new InputDecoration.collapsed(
                          hintText: "Result",
                          // fillColor: Colors.deepPurpleAccent,
                          hintStyle: GoogleFonts.robotoMono(
                              textStyle: TextStyle(
                            fontFamily: 'RobotoMono',
                          ))),
                      textInputAction: TextInputAction.none,
                      keyboardType: TextInputType.number,
                      style: GoogleFonts.robotoMono(
                          textStyle: TextStyle(
                              fontSize: 32,
                              fontFamily: 'RobotoMono',
                              fontWeight: FontWeight.bold)),
                      textAlign: TextAlign.right,
                      controller: textControllerResult,
                      onTap: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                      },
                    )),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    btnAC(
                      'AC',
                      const Color(0xFFF5F7F9),
                    ),
                    btnClear(),
                    btn(
                      '%',
                      const Color(0xFFF5F7F9),
                    ),
                    btn(
                      '/',
                      const Color(0xFFF5F7F9),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    btn('7', Colors.white),
                    btn('8', Colors.white),
                    btn('9', Colors.white),
                    btn(
                      '*',
                      const Color(0xFFF5F7F9),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    btn('4', Colors.white),
                    btn('5', Colors.white),
                    btn('6', Colors.white),
                    btn(
                      '-',
                      const Color(0xFFF5F7F9),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    btn('1', Colors.white),
                    btn('2', Colors.white),
                    btn('3', Colors.white),
                    btn('+', const Color(0xFFF5F7F9)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    btn('0', Colors.white),
                    btn('.', Colors.white),
                    btnEqual('='),
                  ],
                ),
                SizedBox(
                  height: 45.0,
                )
              ],
            ),
          ],
        ));
  }

  Widget btn(btntext, Color btnColor) {
    return Container(
        padding: EdgeInsets.only(bottom: 10.0),
        child: TextButton(
          onPressed: () {
            setState(() {
              textControllerInput.text = textControllerInput.text + btntext;
            });
          },
          style: TextButton.styleFrom(
            shape: CircleBorder(),
            padding: EdgeInsets.all(18.0),
            primary: Colors.black,
            backgroundColor: btnColor,
            onSurface: Colors.pink,
          ),
          child: Text(
            btntext,
            style: GoogleFonts.robotoMono(
                textStyle: TextStyle(
              fontSize: 28,
              fontFamily: 'RobotoMono',
              color: Colors.black,
            )),
          ),
        ));
  }

  Widget btnClear() {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: TextButton(
        onPressed: () {
          textControllerInput.text = (textControllerInput.text.length > 0)
              ? (textControllerInput.text
                  .substring(0, textControllerInput.text.length - 1))
              : "";
        },
        style: TextButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(18.0),
          primary: Colors.black,
          backgroundColor: Color(0xFFF5F7F9),
          onSurface: Colors.pink,
        ),
        child: Icon(Icons.backspace, size: 35, color: Colors.blueGrey),
      ),
    );
  }

  Widget btnAC(btntext, Color btnColor) {
    return Container(
      padding: EdgeInsets.only(bottom: 10.0),
      child: TextButton(
        child: Text(
          btntext,
          style: TextStyle(
              fontSize: 28.0, color: Colors.black, fontFamily: 'RobotoMono'),
        ),
        onPressed: () {
          setState(() {
            textControllerInput.text = "";
            textControllerResult.text = "";
          });
        },
        style: TextButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(18.0),
          primary: Colors.black,
          backgroundColor: btnColor,
          onSurface: Colors.pink,
        ),
      ),
    );
  }

  Widget btnEqual(btnText) {
    return GradientButton(
      child: Text(
        btnText,
        style: TextStyle(fontSize: 35.0),
      ),
      increaseWidthBy: 40.0,
      increaseHeightBy: 10.0,
      callback: () {
        Parser p = new Parser();
        ContextModel cm = new ContextModel();
        Expression exp = p.parse(textControllerInput.text);
        setState(() {
          textControllerResult.text =
              exp.evaluate(EvaluationType.REAL, cm).toString();
        });
      },
      gradient: Gradients.rainbowBlue,
    );
  }
}

//////////////// G

class JuegoTicTac extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: colorTemaTicTac,
      ),
      home: TicTacToe(),
    );
  }
}

class TicTacToe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 100.0,
                  height: 100.0,
                  child: Cross(),
                ),
                SizedBox(
                  width: 110.0,
                  height: 110.0,
                  child: Circle(),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: 110.0,
                  height: 110.0,
                  child: Circle(),
                ),
                SizedBox(
                  width: 100.0,
                  height: 100.0,
                  child: Cross(),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                    text: 'Tic ',
                    style: TextStyle(
                      color: crossColor,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: 'Tac ',
                    style: TextStyle(
                      color: circleColor,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(
                    text: 'Toe',
                    style: TextStyle(
                      color: crossColor,
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0),
              child: ButtonTheme(
                minWidth: MediaQuery.of(context).size.width * 0.8,
                height: 60.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0)),
                child: ElevatedButton(
                  child: Text(
                    'Single Player',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SinglePlayerGame(
                        difficulty: GameDifficulty.Easy,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ButtonTheme(
                minWidth: MediaQuery.of(context).size.width * 0.8,
                height: 60.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0)),
                child: ElevatedButton(
                  child: Text(
                    'Multi Player',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TwoPlayerGame())),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ButtonTheme(
                minWidth: MediaQuery.of(context).size.width * 0.8,
                height: 60.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.0)),
                child: ElevatedButton(
                  child: Text(
                    'Back',
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                  onPressed: () =>
                      Navigator.of(context, rootNavigator: true).pop(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/////////////////////////////////

class Circle extends StatefulWidget {
  @override
  _CircleState createState() => _CircleState();
}

class _CircleState extends State<Circle> with SingleTickerProviderStateMixin {
  double _fraction = 0.0;
  Animation<double> _animation;
  AnimationController _controller;
  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);

    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {
          _fraction = _animation.value;
        });
      });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: AspectRatio(
          aspectRatio: 1.0,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: CustomPaint(
              painter: CirclePainter(fraction: _fraction),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class CirclePainter extends CustomPainter {
  final double fraction;
  var _circlePaint;

  CirclePainter({this.fraction}) {
    _circlePaint = Paint()
      ..color = circleColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12.0
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var rect = Offset(0.0, 0.0) & size;

    canvas.drawArc(rect, -pi / 2, pi * 2 * fraction, false, _circlePaint);
  }

  @override
  bool shouldRepaint(CirclePainter oldDelegate) {
    return oldDelegate.fraction != fraction;
  }
}

////////////////////////////////////

class Cross extends StatefulWidget {
  @override
  _CrossState createState() => _CrossState();
}

class _CrossState extends State<Cross> with SingleTickerProviderStateMixin {
  double _fraction = 0.0;
  Animation<double> _animation;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);

    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {
          _fraction = _animation.value;
        });
      });

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: AspectRatio(
          aspectRatio: 1.0,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: CustomPaint(
              painter: CrossPainter(fraction: _fraction),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class CrossPainter extends CustomPainter {
  final double fraction;
  var _crossPaint;

  CrossPainter({this.fraction}) {
    _crossPaint = Paint()
      ..color = crossColor
      ..strokeWidth = 12.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    double leftLineFraction, rightLineFraction;

    if (fraction < .5) {
      leftLineFraction = fraction / .5;
      rightLineFraction = 0.0;
    } else {
      leftLineFraction = 1.0;
      rightLineFraction = (fraction - .5) / .5;
    }

    canvas.drawLine(
        Offset(0.0, 0.0),
        Offset(size.width * leftLineFraction, size.height * leftLineFraction),
        _crossPaint);

    if (fraction >= .5) {
      canvas.drawLine(
          Offset(size.width, 0.0),
          Offset(size.width - size.width * rightLineFraction,
              size.height * rightLineFraction),
          _crossPaint);
    }
  }

  @override
  bool shouldRepaint(CrossPainter oldDelegate) {
    return oldDelegate.fraction != fraction;
  }
}

//////////////////////////

class Equal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: CustomPaint(
            painter: EqualPainter(),
          ),
        ),
      ),
    );
  }
}

class EqualPainter extends CustomPainter {
  static double strokeWidth = 12.0;
  var _paint = Paint()
    ..color = accentColor
    ..strokeWidth = strokeWidth
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round;

  @override
  void paint(Canvas canvas, Size size) {
    var dy = (size.height - 2 * strokeWidth) / 3;
    canvas.drawLine(Offset(0.0, dy), Offset(size.width, dy), _paint);
    canvas.drawLine(Offset(0.0, 2 * dy + strokeWidth),
        Offset(size.width, 2 * dy + strokeWidth), _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

/////////////////

enum GameState { Blank, X, O }

class SinglePlayerGame extends StatefulWidget {
  final GameDifficulty difficulty;

  SinglePlayerGame({this.difficulty});

  @override
  _SinglePlayerGameState createState() => _SinglePlayerGameState();
}

class _SinglePlayerGameState extends State<SinglePlayerGame>
    with TickerProviderStateMixin {
  var activePlayer = GameState.X;
  var winner = GameState.Blank;
  var boardState = List<List<GameState>>.generate(
      3, (i) => List<GameState>.generate(3, (j) => GameState.Blank));

  Animation<double> _boardAnimation;
  AnimationController _boardController;
  double _boardOpacity = 1.0;
  bool _showWinnerDisplay = false;
  int _moveCount = 0;
  int _xWins = 0;
  int _oWins = 0;
  int _draws = 0;
  var ai;

  @override
  void initState() {
    _boardController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    _boardAnimation = Tween(begin: 1.0, end: 0.0).animate(_boardController)
      ..addListener(() {
        setState(() {
          _boardOpacity = _boardAnimation.value;
        });
      });
    initAI();
    super.initState();
  }

  initAI() {
    switch (widget.difficulty) {
      case GameDifficulty.Easy:
        {
          ai = EasyAI();
          break;
        }
      case GameDifficulty.Medium:
        {
          break;
        }
      case GameDifficulty.Hard:
        {
          break;
        }
    }
  }

  @override
  void dispose() {
    _boardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              scoreBoard,
              Stack(
                children: <Widget>[
                  board,
                  winnerDisplay,
                ],
              ),
              bottomBar,
            ],
          )),
    );
  }

  Widget get scoreBoard => Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            xScore,
            drawScore,
            oScore,
          ],
        ),
      );

  Widget get winnerDisplay => Positioned(
        top: 0,
        bottom: 0,
        left: 0,
        right: 0,
        child: Visibility(
          visible: _showWinnerDisplay,
          child: Opacity(
            opacity: 1.0 - _boardOpacity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (winner == GameState.X)
                  SizedBox(
                    width: 80.0,
                    height: 80.0,
                    child: Cross(),
                  ),
                if (winner == GameState.O)
                  SizedBox(
                    width: 80.0,
                    height: 80.0,
                    child: Circle(),
                  ),
                Text(
                  (winner == GameState.Blank) ? "It's a draw!" : 'win!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: accentColor,
                    fontSize: 56.0,
                  ),
                ),
                if (winner != GameState.Blank)
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Image.asset(
                      'assets/ic_party.png',
                      width: 80.0,
                      height: 80.0,
                    ),
                  ),
              ],
            ),
          ),
        ),
      );

  Widget get xScore => Column(
        children: <Widget>[
          SizedBox(
            width: 80.0,
            height: 80.0,
            child: Cross(),
          ),
          Text(
            '$_xWins wins',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: crossColor,
              fontSize: 20.0,
            ),
          ),
        ],
      );

  Widget get oScore => Column(
        children: <Widget>[
          SizedBox(
            width: 80.0,
            height: 80.0,
            child: Circle(),
          ),
          Text(
            '$_oWins wins',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: circleColor,
                fontSize: 20.0),
          )
        ],
      );

  Widget get drawScore => Column(
        children: <Widget>[
          SizedBox(
            width: 80.0,
            height: 80.0,
            child: Equal(),
          ),
          Text(
            '$_draws draws',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: accentColor,
                fontSize: 20.0),
          )
        ],
      );

  Widget get board => Opacity(
        opacity: _boardOpacity,
        child: Padding(
          padding: const EdgeInsets.only(left: 32.0, right: 32.0),
          child: AspectRatio(
            aspectRatio: 1.0,
            child: Container(
              color: Colors.grey[300],
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                ),
                itemCount: 9,
                itemBuilder: (context, index) {
                  int row = index ~/ 3;
                  int col = index % 3;
                  return gameButton(row, col);
                },
              ),
            ),
          ),
        ),
      );

  Widget get bottomBar => Padding(
        padding: const EdgeInsets.only(bottom: 82.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FloatingActionButton(
              heroTag: 'back',
              child: Icon(Icons.arrow_back),
              backgroundColor: accentColor,
              mini: true,
              onPressed: () => Navigator.pop(context),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                border: Border.all(color: Colors.grey[300]),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.difficulty
                      .toString()
                      .substring(widget.difficulty.toString().indexOf('.') + 1),
                  style: TextStyle(
                    fontSize: 14.0,
                    color: accentColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            FloatingActionButton(
              heroTag: 'reset',
              child: Icon(Icons.cached),
              backgroundColor: accentColor,
              mini: true,
              onPressed: () => reset(),
            ),
          ],
        ),
      );

  Widget gameButton(int row, int col) {
    return GestureDetector(
      onTap: (boardState[row][col] == GameState.Blank &&
              winner == GameState.Blank &&
              activePlayer == GameState.X)
          ? () => onGameButtonTap(row, col)
          : null,
      child: Container(
        color: Colors.white,
        child: Center(
          child: gamePiece(row, col),
        ),
      ),
    );
  }

  onGameButtonTap(row, col) {
    _moveCount++;
    boardState[row][col] = activePlayer;
    checkWinningCondition(row, col, activePlayer);
    toggleActivePlayer();
    setState(() {});
  }

  void toggleActivePlayer() {
    if (activePlayer == GameState.X) {
      activePlayer = GameState.O;
      playAI();
    } else
      activePlayer = GameState.X;
  }

  playAI() {
    var move = ai.getMove(boardState, 0);
    var row = move[0];
    var col = move[1];
    onGameButtonTap(row, col);
  }

  gamePiece(int row, int col) {
    if (boardState[row][col] == GameState.X)
      return Cross();
    else if (boardState[row][col] == GameState.O)
      return Circle();
    else
      return null;
  }

  void reset() {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        boardState[i][j] = GameState.Blank;
      }
    }
    activePlayer = GameState.X;
    winner = GameState.Blank;
    _moveCount = 0;
    setState(() {
      _showWinnerDisplay = false;
    });
    _boardController.reverse();
  }

  void checkWinningCondition(int row, int col, GameState gameState) {
    //check col condition
    for (int i = 0; i < 3; i++) {
      if (boardState[row][i] != gameState) break;
      if (i == 2) {
        setWinner(gameState);
        return;
      }
    }

    //Check row condition
    for (int i = 0; i < 3; i++) {
      if (boardState[i][col] != gameState) break;
      if (i == 2) {
        setWinner(gameState);
        return;
      }
    }

    //check diagonal
    if (row == col) {
      for (int i = 0; i < 3; i++) {
        if (boardState[i][i] != gameState) break;
        if (i == 2) {
          setWinner(gameState);
          return;
        }
      }
    }

    // check anti-diagonal
    if (row + col == 2) {
      for (int i = 0; i < 3; i++) {
        if (boardState[i][2 - i] != gameState) break;
        if (i == 2) {
          setWinner(gameState);
          return;
        }
      }
    }

    //checkDraw
    if (_moveCount == 9) {
      print('Draw');
      setWinner(GameState.Blank);
      return;
    }
  }

  void setWinner(GameState gameState) {
    print('$gameState wins');
    winner = gameState;
    switch (gameState) {
      case GameState.Blank:
        {
          _draws++;
          break;
        }
      case GameState.X:
        {
          _xWins++;
          break;
        }
      case GameState.O:
        {
          _oWins++;
          break;
        }
    }
    toggleBoardOpacity();
  }

  void toggleBoardOpacity() {
    if (_boardOpacity == 0.0) {
      setState(() {
        _showWinnerDisplay = false;
      });
      _boardController.reverse();
    } else if (_boardOpacity == 1.0) {
      _boardController.forward();
      setState(() {
        _showWinnerDisplay = true;
      });
    }
  }
}

class TwoPlayerGame extends StatefulWidget {
  @override
  _TwoPlayerGameState createState() => _TwoPlayerGameState();
}

class _TwoPlayerGameState extends State<TwoPlayerGame>
    with TickerProviderStateMixin {
  var activePlayer = GameState.X;
  var winner = GameState.Blank;
  var boardState = List<List<GameState>>.generate(
      3, (i) => List<GameState>.generate(3, (j) => GameState.Blank));

  Animation<double> _boardAnimation;
  AnimationController _boardController;
  double _boardOpacity = 1.0;
  bool _showWinnerDisplay = false;
  int _moveCount = 0;
  int _xWins = 0;
  int _oWins = 0;
  int _draws = 0;

  @override
  void initState() {
    _boardController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );

    _boardAnimation = Tween(begin: 1.0, end: 0.0).animate(_boardController)
      ..addListener(() {
        setState(() {
          _boardOpacity = _boardAnimation.value;
        });
      });
    super.initState();
  }

  @override
  void dispose() {
    _boardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              scoreBoard,
              Stack(
                children: <Widget>[
                  board,
                  winnerDisplay,
                ],
              ),
              bottomBar,
            ],
          )),
    );
  }

  Widget get scoreBoard => Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            xScore,
            drawScore,
            oScore,
          ],
        ),
      );

  Widget get winnerDisplay => Positioned(
        top: 0,
        bottom: 0,
        left: 0,
        right: 0,
        child: Visibility(
          visible: _showWinnerDisplay,
          child: Opacity(
            opacity: 1.0 - _boardOpacity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (winner == GameState.X)
                  SizedBox(
                    width: 80.0,
                    height: 80.0,
                    child: Cross(),
                  ),
                if (winner == GameState.O)
                  SizedBox(
                    width: 80.0,
                    height: 80.0,
                    child: Circle(),
                  ),
                Text(
                  (winner == GameState.Blank) ? "It's a draw!" : 'win!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: accentColor,
                    fontSize: 56.0,
                  ),
                ),
                if (winner != GameState.Blank)
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Image.asset(
                      'assets/ic_party.png',
                      width: 80.0,
                      height: 80.0,
                    ),
                  ),
              ],
            ),
          ),
        ),
      );

  Widget get xScore => Column(
        children: <Widget>[
          SizedBox(
            width: 80.0,
            height: 80.0,
            child: Cross(),
          ),
          Text(
            '$_xWins wins',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: crossColor,
              fontSize: 20.0,
            ),
          ),
        ],
      );

  Widget get oScore => Column(
        children: <Widget>[
          SizedBox(
            width: 80.0,
            height: 80.0,
            child: Circle(),
          ),
          Text(
            '$_oWins wins',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: circleColor,
                fontSize: 20.0),
          )
        ],
      );

  Widget get drawScore => Column(
        children: <Widget>[
          SizedBox(
            width: 80.0,
            height: 80.0,
            child: Equal(),
          ),
          Text(
            '$_draws draws',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: accentColor,
                fontSize: 20.0),
          )
        ],
      );

  Widget get board => Opacity(
        opacity: _boardOpacity,
        child: Padding(
          padding: const EdgeInsets.only(left: 32.0, right: 32.0),
          child: AspectRatio(
            aspectRatio: 1.0,
            child: Container(
              color: Colors.grey[300],
              child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 1.0,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0,
                ),
                itemCount: 9,
                itemBuilder: (context, index) {
                  int row = index ~/ 3;
                  int col = index % 3;
                  return gameButton(row, col);
                },
              ),
            ),
          ),
        ),
      );

  Widget get bottomBar => Padding(
        padding: const EdgeInsets.only(bottom: 82.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FloatingActionButton(
              heroTag: 'back',
              child: Icon(Icons.arrow_back),
              backgroundColor: accentColor,
              mini: true,
              onPressed: () => Navigator.pop(context),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                border: Border.all(color: Colors.grey[300]),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '2 Players',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: accentColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            FloatingActionButton(
              heroTag: 'reset',
              child: Icon(Icons.cached),
              backgroundColor: accentColor,
              mini: true,
              onPressed: () => reset(),
            ),
          ],
        ),
      );

  Widget gameButton(int row, int col) {
    return GestureDetector(
      onTap:
          (boardState[row][col] == GameState.Blank && winner == GameState.Blank)
              ? () {
                  _moveCount++;
                  boardState[row][col] = activePlayer;
                  checkWinningCondition(row, col, activePlayer);
                  toggleActivePlayer();
                  setState(() {});
                }
              : null,
      child: Container(
        color: Colors.white,
        child: Center(
          child: gamePiece(row, col),
        ),
      ),
    );
  }

  void toggleActivePlayer() {
    if (activePlayer == GameState.X)
      activePlayer = GameState.O;
    else
      activePlayer = GameState.X;
  }

  gamePiece(int row, int col) {
    if (boardState[row][col] == GameState.X)
      return Cross();
    else if (boardState[row][col] == GameState.O)
      return Circle();
    else
      return null;
  }

  void reset() {
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        boardState[i][j] = GameState.Blank;
      }
    }
    activePlayer = GameState.X;
    winner = GameState.Blank;
    _moveCount = 0;
    setState(() {
      _showWinnerDisplay = false;
    });
    _boardController.reverse();
  }

  void checkWinningCondition(int row, int col, GameState gameState) {
    //check col condition
    for (int i = 0; i < 3; i++) {
      if (boardState[row][i] != gameState) break;
      if (i == 2) {
        setWinner(gameState);
        return;
      }
    }

    //Check row condition
    for (int i = 0; i < 3; i++) {
      if (boardState[i][col] != gameState) break;
      if (i == 2) {
        setWinner(gameState);
        return;
      }
    }

    //check diagonal
    if (row == col) {
      for (int i = 0; i < 3; i++) {
        if (boardState[i][i] != gameState) break;
        if (i == 2) {
          setWinner(gameState);
          return;
        }
      }
    }

    // check anti-diagonal
    if (row + col == 2) {
      for (int i = 0; i < 3; i++) {
        if (boardState[i][2 - i] != gameState) break;
        if (i == 2) {
          setWinner(gameState);
          return;
        }
      }
    }

    //checkDraw
    if (_moveCount == 9) {
      print('Draw');
      setWinner(GameState.Blank);
      return;
    }
  }

  void setWinner(GameState gameState) {
    print('$gameState wins');
    winner = gameState;
    switch (gameState) {
      case GameState.Blank:
        {
          _draws++;
          break;
        }
      case GameState.X:
        {
          _xWins++;
          break;
        }
      case GameState.O:
        {
          _oWins++;
          break;
        }
    }
    toggleBoardOpacity();
  }

  void toggleBoardOpacity() {
    if (_boardOpacity == 0.0) {
      setState(() {
        _showWinnerDisplay = false;
      });
      _boardController.reverse();
    } else if (_boardOpacity == 1.0) {
      _boardController.forward();
      setState(() {
        _showWinnerDisplay = true;
      });
    }
  }
}

//////////ai

enum GameDifficulty { Easy, Medium, Hard }

abstract class AI {
  List<int> getMove(List<List<GameState>> board, int turns);

  List<List<int>> getEmptyCells(List<List<GameState>> board) {
    List<List<int>> emptyCells = <List<int>>[];
    for (int i = 0; i < 3; i++) {
      for (int j = 0; j < 3; j++) {
        if (board[i][j] == GameState.Blank) {
          emptyCells.add([i, j]);
        }
      }
    }
    return emptyCells;
  }
}

/////////////
class EasyAI extends AI {
  @override
  List<int> getMove(List<List<GameState>> board, int turns) {
    var emptyCells = getEmptyCells(board);
    print(emptyCells);
    return emptyCells[0];
  }
}

class BannerAdWidget extends StatefulWidget {
  BannerAdWidget(this.size);

  final AdSize size;

  @override
  State<StatefulWidget> createState() => BannerAdState();
}

class BannerAdState extends State<BannerAdWidget> {
  BannerAd _bannerAd;
  final Completer<BannerAd> bannerCompleter = Completer<BannerAd>();

  @override
  void initState() {
    super.initState();
    _bannerAd = BannerAd(
      adUnitId: adBanner,
      request: AdRequest(),
      size: widget.size,
      listener: AdListener(
        onAdLoaded: (Ad ad) {
          print('$BannerAd loaded.');
          bannerCompleter.complete(ad as BannerAd);
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$BannerAd failedToLoad: $error');
          bannerCompleter.completeError(null);
        },
        onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
        onApplicationExit: (Ad ad) => print('$BannerAd onApplicationExit.'),
      ),
    );
    Future<void>.delayed(Duration(seconds: 1), () => _bannerAd?.load());
  }

  @override
  void dispose() {
    super.dispose();
    _bannerAd?.dispose();
    _bannerAd = null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BannerAd>(
      future: bannerCompleter.future,
      builder: (BuildContext context, AsyncSnapshot<BannerAd> snapshot) {
        Widget child;

        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            child = Container();
            break;
          case ConnectionState.done:
            if (snapshot.hasData) {
              child = AdWidget(ad: _bannerAd);
            } else {
              child = Text('Error loading $BannerAd');
            }
        }

        return Container(
          width: _bannerAd.size.width.toDouble(),
          height: _bannerAd.size.height.toDouble(),
          child: child,
          color: Colors.blueGrey,
        );
      },
    );
  }
}
