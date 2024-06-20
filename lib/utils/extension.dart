import 'package:flutter/material.dart';
import 'package:flutter_desired_job/l10n/app_localizations.dart';
import 'package:flutter_desired_job/models/job_model.dart';
import 'package:flutter_desired_job/pages/seeker/widgets/recent_job_item.dart';
import 'package:flutter_desired_job/resources/dj_color.dart';
import 'package:intl/intl.dart';

extension DoubleExtension on double? {
  String toFormatDollar() {
    if (this == null) return '-:-';

    return '\$ $this';
  }
}

extension ContextExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

extension ExString on String? {
  String get toDateTime {
    try {
      return DateFormat('d/M/yyyy', 'en_US')
          .format(DateTime.parse(this ?? '').toLocal());
    } on FormatException {
      return '--:--';
    }
  }
}

extension ExJobStatus on JobStatus {
  Widget toStatusDisplay(BuildContext context) {
    switch (name) {
      case 'hidden':
        return StatusJob(title: context.l10n.hidden, color: DJColor.hD65745);
      case 'censoring':
        return StatusJob(title: context.l10n.censoring, color: DJColor.hEAC645);
      case 'almostOpen':
        return StatusJob(
            title: context.l10n.almostOpen, color: DJColor.hEAC645);
      case 'open':
        return StatusJob(title: context.l10n.open, color: DJColor.h26E543);
      default:
        return StatusJob(title: context.l10n.expired, color: DJColor.hD65745);
    }
  }
}
