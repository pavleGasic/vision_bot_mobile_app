// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'control_adapter.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ControlAdapter)
final controlAdapterProvider = ControlAdapterFamily._();

final class ControlAdapterProvider
    extends $NotifierProvider<ControlAdapter, ControlState> {
  ControlAdapterProvider._({
    required ControlAdapterFamily super.from,
    required GlobalKey<State<StatefulWidget>>? super.argument,
  }) : super(
         retry: null,
         name: r'controlAdapterProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$controlAdapterHash();

  @override
  String toString() {
    return r'controlAdapterProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ControlAdapter create() => ControlAdapter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ControlState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ControlState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is ControlAdapterProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$controlAdapterHash() => r'e6996b0e84047ddf5c145bb434e3336ca27f8343';

final class ControlAdapterFamily extends $Family
    with
        $ClassFamilyOverride<
          ControlAdapter,
          ControlState,
          ControlState,
          ControlState,
          GlobalKey<State<StatefulWidget>>?
        > {
  ControlAdapterFamily._()
    : super(
        retry: null,
        name: r'controlAdapterProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ControlAdapterProvider call([GlobalKey<State<StatefulWidget>>? familyKey]) =>
      ControlAdapterProvider._(argument: familyKey, from: this);

  @override
  String toString() => r'controlAdapterProvider';
}

abstract class _$ControlAdapter extends $Notifier<ControlState> {
  late final _$args = ref.$arg as GlobalKey<State<StatefulWidget>>?;
  GlobalKey<State<StatefulWidget>>? get familyKey => _$args;

  ControlState build([GlobalKey<State<StatefulWidget>>? familyKey]);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<ControlState, ControlState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ControlState, ControlState>,
              ControlState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
