/// The test below was moved over from our_meals 
/// 
/// This is a good test but as it's currently setup we need plugins to setup
/// an app then check if the result matches expectations
/// 
/// TODO: Try to do this test in percepts without the plugins and if it's not 
/// possible consider making a new package that depends on percepts and plugins
/// whose purpose is to test the core percepts functionality

// void main() {
//   testWidgets('StreamOfConsciousness only builds when state changes',
//       (tester) async {
//     // Setup objects under test & test doubles
//     var appState = ExampleAppState.initial;
//     var beliefSystem = RecordingBeliefSystem(state: appState);

//     Locator.add<BeliefSystem<ExampleAppState>>(beliefSystem);

//     int i = 0;
//     final widget = MaterialApp(
//         home: StreamOfConsciousness<ExampleAppState, SignedInState>(
//             transformer: (state) {
//       var signedIn = (state as dynamic).identity.userAuthState.signedIn as SignedInState;
//       return signedIn;
//     }, builder: (context, signedInState) {
//       var output = 'builds: ${i++}, $signedInState';
//       return Text(output);
//     }));

//     await tester.pumpWidget(widget);

//     expect(find.text('builds: 0, SignedInState.checking'), findsOneWidget);

//     beliefSystem.land(const PushRoute<ExampleAppState>(SignInPageState()));
//     await tester.pump();

//     expect(find.text('builds: 1, SignedInState.checking'), findsOneWidget);

//     beliefSystem.land(const PushRoute<ExampleAppState>(HomePageState()));
//     await tester.pump();

//     expect(find.text('builds: 1, reports: 1'), findsOneWidget);

//     beliefSystem.land(const PushRoute<ExampleAppState>(HomePageState()));
//     // notes on why we add a duration are below
//     await tester.pump(const Duration(microseconds: 1));
//     expect(find.text('builds: 2, reports: 2'), findsOneWidget);
//   });
// }
