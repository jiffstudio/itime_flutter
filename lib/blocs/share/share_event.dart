part of 'share_bloc.dart';

abstract class ShareEvent extends Equatable {
  const ShareEvent();
}

class LoadShare extends ShareEvent{
  final String tableId;
  const LoadShare ({required this.tableId});
  @override
  List<Object?> get props => [tableId];
}
