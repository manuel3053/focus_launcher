class AppSwitch<T1, T2>{
  final T1 app;
  final T2 toggled;

  AppSwitch(this.app, this.toggled);
/*
  factory AppSwitch.fromJson(Map<String, dynamic> json) => AppSwitch(
    app: json['app'],
    toggled: json['toggled']
  );*/
}