import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:itime_frontend/data/share_api.dart';
import 'package:itime_frontend/models/get_table_members_model.dart';
import 'package:itime_frontend/models/get_table_share_model.dart';
import 'package:itime_frontend/models/table_member_model.dart';
import 'package:itime_frontend/res.dart';

part 'share_event.dart';

part 'share_state.dart';

class ShareBloc extends Bloc<ShareEvent, ShareState> {
  ShareBloc() : super(ShareState());

  @override
  Stream<ShareState> mapEventToState(
    ShareEvent event,
  ) async* {
    if (event is LoadShare) yield* _mapLoadShareToState(event);
  }

  Stream<ShareState> _mapLoadShareToState(LoadShare event) async* {
    try {
      yield state.copyWith(load: LoadShareStatus.loading);

      GetTableShareModel shareResponse = await ShareApi()
          .getTimetableShare(tableId: event.tableId, readOnly: true);
      yield state.copyWith(
        shareId: shareResponse.data.shareId,
      );

      GetTableMembersModel memberResponse =
          await ShareApi().getTimetableMembers(tableId: event.tableId);
      yield state.copyWith(
        members: memberResponse.data,
        load: LoadShareStatus.success,
      );
    } catch (e) {
      addError(e);
      yield state.copyWith(load: LoadShareStatus.failure);
    }
  }
}
