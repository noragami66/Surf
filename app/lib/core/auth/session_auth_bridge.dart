/// Notifies the UI when auth session is dropped (UC-6 E1).
class SessionAuthBridge {
  void Function()? onSessionExpired;

  void notifySessionExpired() => onSessionExpired?.call();
}
