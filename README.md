# flutter-databse-helper
An integration of a sql database that works for flutter projects which uses a general implementation of the package `sqflite`.
It uses also two other packages to help provide the application string to the app's folder.
More on the dependencies in [dependencies]

## How to use it
1. Download the DatabaseHelper.dart file;
2. Place it in your project's lib folder;
3. Call an instance of it wherever you want to use it:
  ```dart
  DatabaseHelper.instance.AddObject(
    // Here pass an object of the object type that you use, as I used Object, I'm going to pass an
    Object
  );
  ```
  
##  Dependencies 
This project uses some external packages to work.
External packages used:
1. [sqflite]
2. [path_provider]

Install them from [pub.dev] or just use:
  ```terminal
  $ flutter pub get sqflite
  $ flutter pub get path_provider
  ```
[dependencies]: https://github.com/SirioRigel/flutter-databse-helper/edit/main/README.md#dependencies
[sqflite]: https://pub.dev/packages/sqflite
[path_provider]: https://pub.dev/packages/path_provider
[pub.dev]: https://pub.dev
