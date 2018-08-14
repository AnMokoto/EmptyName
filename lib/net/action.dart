library net.action;


/// REQUEST - RESPONSE FINISH .
typedef void onComplete();

/// REQUEST FAILURE . ALSE SEE [Exception]
typedef void onError(Exception e);

/// REQUEST SUCCESS . ALSE SEE [IModel]
typedef void onNext<T>(T t);

abstract class IOnAction<T> {
  /// 数据请求成功后的数据

  void OnNext(T t) {}

  /// 请求失败

  void OnError(Exception e) {}

  /// 请求完成

  void OnComplete() {}
}




class OnAction<T> implements IOnAction<T> {
  onNext next;
  onError error;

  onComplete c;

  factory OnAction.onNext(onNext next) {
    return OnAction.onError(next, (e) {});
  }

  factory OnAction.onError(onNext next, onError error) {
    return OnAction.onComplete(next, error, () {});
  }

  factory OnAction.onComplete(onNext next, onError error, onComplete complete) {
    return new OnAction(next, error, complete);
  }

  factory OnAction.action(onNext next) {
    return OnAction.onError(next, (e) {});
  }

  OnAction(onNext next, onError error, onComplete complete) {
    this.next = next;
    this.error = error;
    this.c = complete;
  }

  @override
  void OnNext(T t) {
    print("onNext");
    this.next(t);
  }

  @override
  void OnError(Exception e) {
    print("onError");
    this.error(e);
  }

  @override
  void OnComplete() {
    print("onComplete");
    this.c();
  }
}