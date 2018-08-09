library mvp;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' show State, StatefulWidget;

abstract class IPresenter<V> {
  @protected
  V view;

  @protected
  V get() => this.view;
}

abstract class IView {}

abstract class Presenter<V extends IView> extends IPresenter<V> {
  @mustCallSuper
  @protected
  void onBindView(V view) {
    this.view ??= view;
  }

  @mustCallSuper
  @protected
  void unBindView() {
    this.view = null;
  }
}

abstract class MVPState<P extends Presenter<IView>, T extends StatefulWidget>
    extends State<T> implements IView {
  P presenter;

  @mustCallSuper
  MVPState(P presenter) : assert(presenter != null) {
    this.presenter ??= presenter;
    this.presenter.onBindView(this);
  }

  @override
  @mustCallSuper
  void dispose() {
    this.presenter.unBindView();
    super.dispose();
  }
}
