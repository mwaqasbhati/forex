import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fxtm/dio/dio_service.dart';
import 'package:fxtm/models/forex_symbol.dart';
import 'package:fxtm/provider/forex_symbol_provider.dart';
import 'package:fxtm/repositories/forex_repository.dart';
import 'package:fxtm/services/finnhub_service.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

// Generate mocks
@GenerateNiceMocks([
  MockSpec<ForexRepository>(),
  MockSpec<FinnhubService>(),
  MockSpec<Dio>(),
])
import 'forex_test.mocks.dart';

void main() {
  group('ForexSymbol Provider Tests', () {
    late ProviderContainer container;
    late MockForexRepository mockRepository;

    setUp(() {
      mockRepository = MockForexRepository();
      container = ProviderContainer(
        overrides: [
          forexRepoProvider.overrideWithValue(mockRepository),
        ],
      );
    });

    tearDown(() {
      container.dispose();
    });

    test('should fetch forex pairs successfully', () async {
      // Arrange
      final expectedSymbols = [
        const ForexSymbol(
          description: 'EUR/USD',
          displaySymbol: 'EUR/USD',
          symbol: 'OANDA:EUR_USD',
        ),
      ];
      
      when(mockRepository.getForexPairs())
          .thenAnswer((_) async => expectedSymbols);

      // Act
      final result = await container.read(forexSymbolProvider.future);

      // Assert
      expect(result, equals(expectedSymbols));
      verify(mockRepository.getForexPairs()).called(1);
    });

    test('should throw exception when fetch fails', () async {
      // Arrange
      when(mockRepository.getForexPairs())
          .thenThrow(Exception('Network error'));

      // Act & Assert
      expect(
        () => container.read(forexSymbolProvider.future),
        throwsException,
      );
    });

    test('should maintain state with keepAlive', () async {
      // Arrange
      final expectedSymbols = [
        const ForexSymbol(
          description: 'EUR/USD',
          displaySymbol: 'EUR/USD',
          symbol: 'OANDA:EUR_USD',
        ),
      ];
      
      when(mockRepository.getForexPairs())
          .thenAnswer((_) async => expectedSymbols);

      // Act
      final result1 = await container.read(forexSymbolProvider.future);
      final result2 = await container.read(forexSymbolProvider.future);

      // Assert
      expect(result1, equals(result2));
      verify(mockRepository.getForexPairs()).called(1); // Should only call once due to keepAlive
    });
  });

  group('ForexRepository Tests', () {
    late ProviderContainer container;
    late MockFinnhubService mockService;
    late ForexRepository repository;

    setUp(() {
      mockService = MockFinnhubService();
      container = ProviderContainer(
        overrides: [
          forexServiceProvider.overrideWithValue(mockService),
        ],
      );
      repository = ForexRepository(mockService);
    });

    tearDown(() {
      container.dispose();
    });

    test('should fetch forex pairs from service', () async {
      // Arrange
      final expectedSymbols = [
        const ForexSymbol(
          description: 'EUR/USD',
          displaySymbol: 'EUR/USD',
          symbol: 'OANDA:EUR_USD',
        ),
      ];
      
      when(mockService.fetchForexPairs())
          .thenAnswer((_) async => expectedSymbols);

      // Act
      final result = await repository.getForexPairs();

      // Assert
      expect(result, equals(expectedSymbols));
      verify(mockService.fetchForexPairs()).called(1);
    });

    test('should propagate errors from service', () {
      // Arrange
      when(mockService.fetchForexPairs())
          .thenThrow(Exception('Service error'));

      // Act & Assert
      expect(
        () => repository.getForexPairs(),
        throwsException,
      );
    });
  });

  group('FinnhubService Tests', () {
    late ProviderContainer container;
    late MockDio mockDio;
    late FinnhubService service;

    setUp(() {
      mockDio = MockDio();
      container = ProviderContainer(
        overrides: [
          diosServiceProvider.overrideWithValue(mockDio),
        ],
      );
      service = FinnhubServiceImpl(mockDio);
    });

    tearDown(() {
      container.dispose();
    });

    test('should fetch and parse forex pairs successfully', () async {
      // Arrange
      final mockResponse = Response(
        data: [
          {
            'description': 'EUR/USD',
            'displaySymbol': 'EUR/USD',
            'symbol': 'OANDA:EUR_USD',
          },
        ],
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      );

      when(mockDio.get(any)).thenAnswer((_) async => mockResponse);

      // Act
      final result = await service.fetchForexPairs();

      // Assert
      expect(result.length, equals(1));
      expect(result.first.symbol, equals('OANDA:EUR_USD'));
      expect(result.first.description, equals('EUR/USD'));
      expect(result.first.displaySymbol, equals('EUR/USD'));
      
      // Then: Verify that Dio was called with the expected URL
    //verify(() => mockDio.get(argThat(contains('/forex/symbol')))).called(1);
    //verify(() => mockDio.get(argThat(contains('token=')))).called(1);
    });

    test('should throw exception on non-200 response', () async {
      // Arrange
      final mockResponse = Response(
        data: {'error': 'Invalid API key'},
        statusCode: 401,
        requestOptions: RequestOptions(path: ''),
      );

      when(mockDio.get(any)).thenAnswer((_) async => mockResponse);

      // Act & Assert
      expect(
        () => service.fetchForexPairs(),
        throwsException,
      );
    });

    test('should throw exception on malformed response data', () async {
      // Arrange
      final mockResponse = Response(
        data: [
          {
            'invalid': 'data',
            // Missing required fields
          },
        ],
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      );

      when(mockDio.get(any)).thenAnswer((_) async => mockResponse);

      // Act & Assert
      expect(
        () => service.fetchForexPairs(),
        throwsException,
      );
    });

    test('should take only first 5 items from response', () async {
      // Arrange
      final mockResponse = Response(
        data: List.generate(10, (i) => {
          'description': 'EUR/USD$i',
          'displaySymbol': 'EUR/USD$i',
          'symbol': 'OANDA:EUR_USD$i',
        }),
        statusCode: 200,
        requestOptions: RequestOptions(path: ''),
      );

      when(mockDio.get(any)).thenAnswer((_) async => mockResponse);

      // Act
      final result = await service.fetchForexPairs();

      // Assert
      expect(result.length, equals(5));
    });
  });

  group('ForexSymbol Model Tests', () {
    test('should create ForexSymbol from json', () {
      // Arrange
      final json = {
        'description': 'EUR/USD',
        'displaySymbol': 'EUR/USD',
        'symbol': 'OANDA:EUR_USD',
      };

      // Act
      final symbol = ForexSymbol.fromJson(json);

      // Assert
      expect(symbol.description, equals('EUR/USD'));
      expect(symbol.displaySymbol, equals('EUR/USD'));
      expect(symbol.symbol, equals('OANDA:EUR_USD'));
    });

    test('should throw when required fields are missing', () {
      // Arrange
      final json = {
        'description': 'EUR/USD',
        // Missing displaySymbol and symbol
      };

      // Act & Assert
      expect(
        () => ForexSymbol.fromJson(json),
        throwsA(isA<TypeError>()),
      );
    });
  });
}
