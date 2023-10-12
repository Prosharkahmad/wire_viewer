import 'package:wire_viewer/form_event/form_submission_status.dart';

class HomeState {
  final FormSubmissionStatus formStatus;

  const HomeState({
    this.formStatus = const InitialFormStatus(),
  });

  HomeState copyWith({
    FormSubmissionStatus? formStatus,
  }) {
    return HomeState(
      formStatus: formStatus ?? this.formStatus,
    );
  }

  @override
  List<Object?> get props => [formStatus];
}
