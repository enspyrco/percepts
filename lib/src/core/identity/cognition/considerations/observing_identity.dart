import 'dart:async';

import 'package:abstractions/identity.dart';
import 'package:error_correction_in_perception/error_correction_in_perception.dart';
import 'package:json_utils/json_utils.dart';
import 'package:locator_for_perception/locator_for_perception.dart';
import 'package:types_for_auth/types_for_auth.dart';
import 'package:abstractions/beliefs.dart';

import '../../default_user_auth_state.dart';
import '../../utils/on_provider_auth_state_change.dart';
import '../conclusions/identity_updated.dart';

StreamSubscription<UserAuthState>? _subscription;

class ObservingIdentity<T extends CoreBeliefs, S extends IdentitySubsystem>
    extends Consideration<T> {
  const ObservingIdentity();

  @override
  Future<void> consider(BeliefSystem<T> beliefSystem) async {
    S service = locate<S>();

    _subscription?.cancel();

    _subscription = service.onAuthStateChange.listen(
      (UserAuthState user) {
        /// Currently [IdentityUpdated] takes a [DefaultUserAuthState] so we
        /// create one from the [UserAuthState] object
        final defaultUserAuthState = DefaultUserAuthState(
            uid: user.uid,
            displayName: user.displayName,
            photoURL: user.photoURL,
            signedIn: user.signedIn);
        beliefSystem
            .conclude(IdentityUpdated<T>(userAuthState: defaultUserAuthState));

        /// Start any cognitions that were added to [OnAuthStateChange].
        final onProviderAuthStateChange =
            locate<OnProviderAuthStateChange<T>>();
        onProviderAuthStateChange.runAll(user.signedIn, beliefSystem);
      },
      onError: (Object error, StackTrace trace) => beliefSystem.conclude(
        CreateFeedback(error, trace),
      ),
    );
  }

  @override
  JsonMap toJson() => {
        'name_': 'ObservingIdentity',
        'state_': <String, dynamic>{},
      };
}
