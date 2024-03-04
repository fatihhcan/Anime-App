# Anime App

**Project Summary:** It is a mobile application that contains details of animes.

## Video



https://github.com/fatihhcan/Anime-App/assets/45641833/f489180f-c838-48f1-ba4b-146fe43f87d0



## Subject:

- **BLoC/Cubit** was used for State Management.

- **Get It** was used for dependencies injected.

- **Dio** was used for API requests.

- **Screen Util** adapting screen and font size.

- **Firebase Crashlytics** package was used for the crash test.

- **Widget Test** and **Unit Test**  a widget test and a unit test example were created.

- Local **method channels** were used to call service requests. (fetchAnimeList).
  
- Pagination has been performed.
  
- Flutter version **3.7.12** was used.(FVM-Flutter Version Management).



## Flutter Packages Available in the Project:

**flutter_screenutil:** A flutter plugin for adapting screen and font size.Guaranteed to look good on different models.

**bloc:** A predictable state management library that helps implement the BLoC (Business Logic Component) design pattern.

**flutter_bloc:** Flutter Widgets that make it easy to implement the BLoC (Business Logic Component) design pattern. Built to be used with the bloc state management package.

**build_runner:** A build system for Dart code generation and modular compilation.

**json_annotation:** Classes and helper functions that support JSON code generation via the `json_serializable` package.

**json_serializable:** Automatically generate code for converting to and from JSON by annotating Dart classes.

**build_runner:** A build system for Dart code generation and modular compilation.

**get_it:** Simple direct Service Locator that allows to decouple the interface from a concrete implementation and to access the concrete implementation from everywhere in your App

**flutter_dotenv:** Easily configure any flutter application with global variables using a `.env` file.

**equatable:** Easy and Fast internationalizing and localization your Flutter Apps, this package simplify the internationalizing process.

**google_fonts:** A package to include fonts from fonts.google.com in your Flutter app.

**dio:** A powerful HTTP networking package, supports Interceptors, Aborting and canceling a request, Custom adapters, Transformers, etc.

**firebase_core:** Flutter plugin for Firebase Core, enabling connecting to multiple Firebase apps.

**firebase_crashlytics:** Flutter plugin for Firebase Crashlytics. It reports uncaught errors to the Firebase console.

## Base

**Base Cubit:**
```dart
 mixin BaseCubit {
  BuildContext? context;
  DioManager dioManager = DioManager.instance;
  NavigationService navigation = NavigationService.instance;
  AppStateManager appStateManager = AppStateManager.instance;
  LocalDatabaseManager localDatabaseManager = LocalDatabaseManager.instance;
  void setContext(BuildContext context);
  void init();
}
```

**Base Model:**
```dart
  abstract class BaseModel<T> {
  int? localId;

  BaseModel({
    this.localId,
  });

  Map<String, dynamic> toJson();
  T fromJson(Map<String, dynamic> json);
}
```

**Base View:**
```dart
class BaseView<T extends Cubit> extends StatefulWidget {
  final T cubit;
  final Function(T model) onCubitReady;
  final Function(T value) onPageBuilder;
  final Function(T model)? onDispose;
  final bool isSingleton;
  const BaseView({
    Key? key,
    required this.cubit,
    required this.onCubitReady,
    required this.onPageBuilder,
    this.onDispose,
    this.isSingleton = false,
  }) : super(key: key);

  @override
  _BaseViewState<T> createState() => _BaseViewState<T>();
}

class _BaseViewState<T extends Cubit> extends State<BaseView<T>> {
  late T cubit;
  @override
  void initState() {
    cubit = widget.cubit;
    widget.onCubitReady(cubit);
    super.initState();
  }

  @override
  void dispose() {
    if (widget.onDispose != null) widget.onDispose!(cubit);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isSingleton
        ? BlocProvider.value(
            value: widget.cubit,
            child: widget.onPageBuilder(cubit) as Widget,
          )
        : BlocProvider(
            create: (context) => widget.cubit,
            child: widget.onPageBuilder(cubit) as Widget,
          );
  }
}

```

## Method Channels (fetchAnimeList)
**Main Activity:**
```kotlin
class MainActivity : FlutterActivity() {
    private val CHANNEL = "animeListChannel"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "fetchAnimeList") {
                GlobalScope.launch(Dispatchers.Default) {
                    try {
                        val response = fetchAnimeListFromServer()
                        result.success(response)
                    } catch (e: Exception) {
                        result.error("FETCH_ERROR", "Error fetching anime list", null)
                    }
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun fetchAnimeListFromServer(): String {
        val url = URL("https://api.jikan.moe/v4/top/anime")
        val connection: HttpURLConnection = url.openConnection() as HttpURLConnection
        try {
            val reader = BufferedReader(InputStreamReader(connection.inputStream))
            val response = StringBuilder()
            var line: String?

            while (reader.readLine().also { line = it } != null) {
                response.append(line)
            }
            return response.toString()
        } finally {
            connection.disconnect()
        }
    }
}
```

**Anime List Service:**
```dart
  @override
  Future<List<AnimeListResponseModel>?> getAnimeList() async{
    try {
      final response = await _channel.invokeMethod('fetchAnimeList');
      Map<String, dynamic> jsonData = json.decode(response);
      List<dynamic> dataList= jsonData['data'];
      final result = ResponseParser<AnimeListResponseModel>(response: dataList).fromList<List<AnimeListResponseModel>>(model: AnimeListResponseModel());
      AppStateManager.instance.animeList = result ?? [];
      return result;
    } on DioError catch (e, stackTrace) {
      FirebaseCrashlytics.instance.recordError(e,stackTrace,fatal: false, printDetails: true);
      throw DioException.connectionError( requestOptions: e.requestOptions, reason: e.message!);
    }
  }

```

## Service
**Anime Detail Service:**
```dart
class AnimeDetailListService extends IAnimeDetailListService {
  AnimeDetailListService(super.client);

  @override
  Future<List<AnimeDetailResponseModel>?> getAnimeDetailList(int id) async {
    try {
      final response = await client.get('anime/$id/characters');
      final result = ResponseParser<AnimeDetailResponseModel>(response: response['data'])
          .fromList<List<AnimeDetailResponseModel>>(model: AnimeDetailResponseModel());
      AppStateManager.instance.animeDetailList = result ?? [];
      return result;
    } on DioError catch (e, stackTrace) {
      FirebaseCrashlytics.instance.recordError(e,stackTrace,fatal: false, printDetails: true);
      throw DioException.connectionError( requestOptions: e.requestOptions, reason: e.message!);
    }
  }
}
```

**Anime List Service:**
```dart
class AnimeListService extends IAnimeListService {
  AnimeListService(super.client);
  static const MethodChannel _channel = MethodChannel('animeListChannel');
  @override
  Future<List<AnimeListResponseModel>?> getAnimeList() async{
    try {
      final response = await _channel.invokeMethod('fetchAnimeList');
      Map<String, dynamic> jsonData = json.decode(response);
      List<dynamic> dataList= jsonData['data'];
      final result = ResponseParser<AnimeListResponseModel>(response: dataList).fromList<List<AnimeListResponseModel>>(model: AnimeListResponseModel());
      AppStateManager.instance.animeList = result ?? [];
      return result;
    } on DioError catch (e, stackTrace) {
      FirebaseCrashlytics.instance.recordError(e,stackTrace,fatal: false, printDetails: true);
      throw DioException.connectionError( requestOptions: e.requestOptions, reason: e.message!);
    }
  }
}
```
## BLoC/Cubit

**Anime List Cubit:**
```dart
part 'anime_list_state.dart';

class AnimeListCubit extends Cubit<AnimeListState> with BaseCubit {
  AnimeListCubit() : super(const AnimeListState());
  late AnimeListService animeListService;
  List<AnimeListResponseModel> animeList = [];
  @override
  void init() async {
    initServices();
    fetchAnimeList();
    loadItems();

  }
  void initServices() async {
    animeListService = AnimeListService(dioManager.AnimeClient);
  }
  @override
  void setContext(BuildContext context) {}

  void getAnimeLoading(bool loading) {
    emit(state.copyWith(isLoading: loading));
  }

  void fetchAnimeList() async {
    getAnimeLoading(true);
    animeList = (await animeListService.getAnimeList())!;

    emit(state.copyWith(animeList: animeList));
    getAnimeLoading(false);
  }

  void loadItems() {
    emit(state.copyWith(animeList: animeList
        .skip(state.currentPage * state.itemsPerPage)
        .take(state.itemsPerPage)
        .toList()));
  }

  void nextPage() {
    if ((state.currentPage + 1) * state.itemsPerPage <= state.animeList!.length) {
     emit(state.copyWith(currentPage: state.currentPage + 1));
      loadItems();
    }
  }

  void previousPage() {
    if (state.currentPage > 0) {
     emit(state.copyWith(currentPage: state.currentPage - 1));
      loadItems();
    }
  }
}

```

**Anime List State:**
```dart
part of 'anime_list_cubit.dart';

class AnimeListState extends Equatable {

  final List<AnimeListResponseModel>? animeList;
  final bool isLoading;
  final int currentPage;
  final int itemsPerPage;
  const AnimeListState({
    this.animeList,
    this.isLoading = false,
    this.currentPage = 0,
    this.itemsPerPage = 20
  });

  @override
  List<Object?> get props => [animeList, isLoading, currentPage, itemsPerPage];

  AnimeListState copyWith({
    List<AnimeListResponseModel>? animeList,
    bool? isLoading,
    int? currentPage,
    int? itemsPerPage,
  }) {
    return AnimeListState(
      animeList: animeList ?? this.animeList,
      isLoading: isLoading ?? this.isLoading,
      currentPage: currentPage ?? this.currentPage,
      itemsPerPage: itemsPerPage ?? this.itemsPerPage
    );
  }
}
  ```

  **Anime Detail Cubit:**
```dart
part 'anime_detail_state.dart';

class AnimeDetailCubit extends Cubit<AnimeDetailState> with BaseCubit {
  AnimeDetailCubit() : super(const AnimeDetailState());
  late AnimeDetailListService animeDetailListService;
  List<AnimeDetailResponseModel> animeDetailList = [];
  @override
  void init() async {
    initServices();

  }
  void initServices() async {
    animeDetailListService = AnimeDetailListService(dioManager.AnimeClient);
  }
  @override
  void setContext(BuildContext context) {}

  void getAnimeDetailLoading(bool loading) {
    emit(state.copyWith(isLoading: loading));
  }
  
  void fetchAnimeDetailList(int id) async {
    getAnimeDetailLoading(true);
    animeDetailList = (await animeDetailListService.getAnimeDetailList(id))!;
    emit(state.copyWith(animeDetailList: animeDetailList));
    getAnimeDetailLoading(false);
  }
  void navigate() async {
    await navigation.pop();
  }
}
  ```
  **Anime Detail State:**
```dart
part of 'anime_detail_cubit.dart';

class AnimeDetailState extends Equatable {

  final bool isLoading;
  final List<AnimeDetailResponseModel>? animeDetailList;
  const AnimeDetailState({
    this.isLoading = false,
    this.animeDetailList
  });

  @override
  List<Object?> get props => [ isLoading, animeDetailList];

  AnimeDetailState copyWith({
    bool? isLoading,
    List<AnimeDetailResponseModel>? animeDetailList
  }) {
    return AnimeDetailState(
      isLoading: isLoading ?? this.isLoading,
      animeDetailList: animeDetailList ?? this.animeDetailList
    );
  }
}
```
## Dependencies Injected
**Locator:**

```dart
final locator = GetIt.instance;

Future<void> init() async {
  locator.registerLazySingleton(() => AnimeListCubit());
  locator.registerLazySingleton(() => AnimeDetailCubit());
}
```
**Anime Detail View:**
```dart
Text('Example DI: ${locator<AnimeListCubit>().exampleDI() ?? ''}')
```

**Anime List Cubit:**
```dart
  String exampleDI() {
    return 'Example DI';
  }
```
  ## Tests
  **Unit Test:**
```dart
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  
  late AnimeListService animeListService;
  late AnimeDetailListService animeDetailListService;
  DioManager dioManager = DioManager.instance;
  List<AnimeListResponseModel> animeList = [];
  List<AnimeDetailResponseModel> animeDetailList = [];

  const MethodChannel channel = MethodChannel('animeListChannel');
  channel.setMockMethodCallHandler((MethodCall methodCall) async {
    if (methodCall.method == 'fetchAnimeList') {
      return '{"data": []}';
    }
    return null;
  });

  setUp(() async {
    animeListService = AnimeListService(dioManager.AnimeClient);
    animeDetailListService = AnimeDetailListService(dioManager.AnimeClient);
  });

  group('Call API', () {
    test('Fetch AnimeList', () async {
      animeList = (await animeListService.getAnimeList())!;
      expect(animeList, isNotNull);
      expect(animeList, isA<List<AnimeListResponseModel>>());
    });

    test('Fetch AnimeDetailList', () async {
      animeDetailList = (await animeDetailListService.getAnimeDetailList(52991))!;
      expect(animeDetailList, isNotNull);
      expect(animeDetailList, isA<List<AnimeDetailResponseModel>>());
    });
  });
}

  ```


  **Widget Test:**
```dart
void main() {
  testWidgets('AnimeListView Test', (WidgetTester tester) async {
    final AnimeListCubit animeListCubit = AnimeListCubit();
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: animeListCubit,
          child: const AnimeListView(),
        ),
      ),
    );

    expect(find.text(StringConstants.animeAppText), findsOneWidget);
    expect(find.byType(ListTile), findsWidgets);

    await tester.tap(find.text(StringConstants.nextPageText));
    await tester.pump();

    expect(find.byType(ListTile), findsWidgets);

    await tester.tap(find.text(StringConstants.previousPageText));
    await tester.pump();

    expect(find.byType(ListTile), findsWidgets);
  });
}


  ```
  # Folder Structure

```
anime_app
│   
└───lib
    │
    └───core
    │    │    
    │    └───base
    │    │
    │    └───cache
    │    │ 
    │    └───components
    │    │    
    │    └───constants
    │    │
    │    └───extensions
    │    │
    │    └───init
    │    │
    │    └───utility
    └───features
         └───anime_detail
         └───anime_list
```
