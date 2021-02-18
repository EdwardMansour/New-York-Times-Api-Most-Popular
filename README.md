# ny_times

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

This app is using New York Times API to fetch some data into UI

to get this app into your project open your IDE go to the terminal and type clone +Repo-URL when the download is done make another command called 'flutter run' to run your project If you need to test performance and UI I'm using tool called DevOps in visual studio code.

### Unit test

You can run the unit test by using "flutter test test/Unit_test/unit_test.dart" or go to file => test/Unit_test/unit_test.dart and tap to word 'Run' above the main class.

### widget test

You can run the widget test by using "flutter test test/widget_test.dart" or go to file => test/widget_test.dart and tap to word 'Run' above the main class.


## MVC architecture

In order to arrange your code and to make it easier to implement other code we divide the project into 3 differents section:

### Model

The Model contains all the classes that I want to store execute and fetch, with repositories and services that I get the response back by a new reserved object.

### View

The View is where I found the interface that I want to figure out, here we set objects into UI.

### Controller

And finally, the controller is the middleware between models and view, moreover, it controls views and fetches into the last our models, here it names provider.

and we have 2 additional folders one for images and named "assets" other for the "core" of my project that contains global and static functions or variables.


Please if you have questions don't hesitate to contact me.


N.B : you have to choose the master branch


Edward Mansour
