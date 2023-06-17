import 'package:flutter/material.dart';
import 'CameraCode.dart';

void main() => runApp(const OverlayApp());

class OverlayApp extends StatelessWidget {
  const OverlayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: OverlayExample(),
    );
  }
}

class OverlayExample extends StatefulWidget {
  const OverlayExample({super.key});

  @override
  State<OverlayExample> createState() => _OverlayExampleState();
}

class _OverlayExampleState extends State<OverlayExample> {
  OverlayEntry? overlayEntry;
  int currentPageIndex = 0;

  void createHighlightOverlay() {
    // Remove the existing OverlayEntry.
    removeHighlightOverlay();

    assert(overlayEntry == null);

    overlayEntry = OverlayEntry(
      // Create a new OverlayEntry.
      builder: (BuildContext context) {
        // Align is used to position the highlight overlay
        // relative to the NavigationBar destination.
        return SafeArea(
          child: Align(
            alignment: Alignment.center,
            heightFactor: 1.0,
            child: DefaultTextStyle(
              style: const TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 14.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text('Tap here for'),
                  Builder(builder: (BuildContext context) {
                    switch (currentPageIndex) {
                      case 0:
                        return Column(
                          children: const <Widget>[
                            Text(
                              'Explore page',
                              style: TextStyle(
                                color: Colors.red,
                              ),
                            ),
                            Icon(Icons.arrow_downward, color: Colors.red),
                          ],
                        );
                      case 1:
                        return Column(
                          children: const <Widget>[
                            Text(
                              'Commute page',
                              style: TextStyle(
                                color: Colors.green,
                              ),
                            ),
                            Icon(Icons.arrow_downward, color: Colors.green),
                          ],
                        );
                      case 2:
                        return Column(
                          children: const <Widget>[
                            Text(
                              'Saved page',
                              style: TextStyle(
                                color: Colors.orange,
                              ),
                            ),
                            Icon(Icons.arrow_downward, color: Colors.orange),
                          ],
                        );
                      default:
                        return const Text('No page selected.');
                    }
                  }),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    height: 80.0,
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            width: 4.0,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );

    // Add the OverlayEntry to the Overlay.
    Overlay.of(context, debugRequiredFor: widget).insert(overlayEntry!);
  }

  // Remove the OverlayEntry.
  void removeHighlightOverlay() {
    overlayEntry?.remove();
    overlayEntry = null;
  }

  @override
  void dispose() {
    // Make sure to remove OverlayEntry when the widget is disposed.
    removeHighlightOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: NavigationBar(
      //   selectedIndex: currentPageIndex,
      //   destinations: const <NavigationDestination>[
      //     NavigationDestination(
      //       icon: Icon(Icons.explore),
      //       label: 'Explore',
      //     ),
      //     NavigationDestination(
      //       icon: Icon(Icons.commute),
      //       label: 'Commute',
      //     ),
      //     NavigationDestination(
      //       selectedIcon: Icon(Icons.bookmark),
      //       icon: Icon(Icons.bookmark_border),
      //       label: 'Saved',
      //     ),
      //   ],
      // ),
      body: CameraApp()

    );
  }
}
