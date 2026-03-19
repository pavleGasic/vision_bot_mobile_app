// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_adapter.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HomeAdapter)
final homeAdapterProvider = HomeAdapterFamily._();

final class HomeAdapterProvider
    extends $NotifierProvider<HomeAdapter, HomeState> {
  HomeAdapterProvider._({
    required HomeAdapterFamily super.from,
    required GlobalKey<State<StatefulWidget>>? super.argument,
  }) : super(
         retry: null,
         name: r'homeAdapterProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$homeAdapterHash();

  @override
  String toString() {
    return r'homeAdapterProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  HomeAdapter create() => HomeAdapter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(HomeState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<HomeState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is HomeAdapterProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$homeAdapterHash() => r'229e1e7b88efa4e063c7cf89a7c7c75660693d61';

final class HomeAdapterFamily extends $Family
    with
        $ClassFamilyOverride<
          HomeAdapter,
          HomeState,
          HomeState,
          HomeState,
          GlobalKey<State<StatefulWidget>>?
        > {
  HomeAdapterFamily._()
    : super(
        retry: null,
        name: r'homeAdapterProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  HomeAdapterProvider call([GlobalKey<State<StatefulWidget>>? familyKey]) =>
      HomeAdapterProvider._(argument: familyKey, from: this);

  @override
  String toString() => r'homeAdapterProvider';
}

abstract class _$HomeAdapter extends $Notifier<HomeState> {
  late final _$args = ref.$arg as GlobalKey<State<StatefulWidget>>?;
  GlobalKey<State<StatefulWidget>>? get familyKey => _$args;

  HomeState build([GlobalKey<State<StatefulWidget>>? familyKey]);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<HomeState, HomeState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<HomeState, HomeState>,
              HomeState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
