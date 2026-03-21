// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'camera_adapter.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CameraAdapter)
final cameraAdapterProvider = CameraAdapterFamily._();

final class CameraAdapterProvider
    extends $NotifierProvider<CameraAdapter, CameraState> {
  CameraAdapterProvider._({
    required CameraAdapterFamily super.from,
    required GlobalKey<State<StatefulWidget>>? super.argument,
  }) : super(
         retry: null,
         name: r'cameraAdapterProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$cameraAdapterHash();

  @override
  String toString() {
    return r'cameraAdapterProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  CameraAdapter create() => CameraAdapter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CameraState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CameraState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is CameraAdapterProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$cameraAdapterHash() => r'0edf334ae08149e8b83c7906f16e4abea3820d9f';

final class CameraAdapterFamily extends $Family
    with
        $ClassFamilyOverride<
          CameraAdapter,
          CameraState,
          CameraState,
          CameraState,
          GlobalKey<State<StatefulWidget>>?
        > {
  CameraAdapterFamily._()
    : super(
        retry: null,
        name: r'cameraAdapterProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CameraAdapterProvider call([GlobalKey<State<StatefulWidget>>? familyKey]) =>
      CameraAdapterProvider._(argument: familyKey, from: this);

  @override
  String toString() => r'cameraAdapterProvider';
}

abstract class _$CameraAdapter extends $Notifier<CameraState> {
  late final _$args = ref.$arg as GlobalKey<State<StatefulWidget>>?;
  GlobalKey<State<StatefulWidget>>? get familyKey => _$args;

  CameraState build([GlobalKey<State<StatefulWidget>>? familyKey]);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<CameraState, CameraState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<CameraState, CameraState>,
              CameraState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
