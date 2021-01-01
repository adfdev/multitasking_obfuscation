# multitasking_obfuscation

An utils flutter package for obfuscation your app when user go in multitasking mode

##### iOS screenshots

##### Android screenshots

## How use

With static funtion `setContent` of class `MutitaskingObfuscation` you can set all availables params every time you send this function.

Here is an example all available params:

```dart
MultitaskingObfuscation.setContent(
    pathImage: "assets/images/example.png" // @required,
    backgroundColor: Colors.red,
    contentPosition: ContentPosition.Center,
    imageSize: Size(120, 120),
)
```

`ContentPosition` is `enum` like follow:

```dart
enum ContentPosition {
  Center,
  Top,
  Bottom,
}
```

Every time you send `setContent` change will be available istantly. This is sound great for example create different graphics based on brightness.

## Importante notes

You can choice and change your params only on `iOS` because native code permit these edit. On `Android` you cannot edit nothing because system permit only to set black screen when app is multitasking mode. But you have to call `setContent` function however for activate that black screen.

***Every suggestion for implements, issue and other are welcome.***
