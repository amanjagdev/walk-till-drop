# Walk Till Drop

## Getting Started

This project is a Simple FLutter app created for the purpose of counting your steps.
It is a basic app which shows your steps and calories burnt

## For Development Purpose

Install all dependencies and then run 



## To Build an .apk

From the command line:

- Enter ``` cd walk-till-drop ```
- Run ``` flutter build apk --split-per-abi ```
(The flutter build command defaults to --release.)
This command results in two APK files:

``` walk-till-drop/build/app/outputs/apk/release/app-armeabi-v7a-release.apk```
```walk-till-drop/build/app/outputs/apk/release/app-arm64-v8a-release.apk```

- Removing the --split-per-abi flag results in a fat APK that contains your code compiled for all the target ABIs. Such APKs are larger in   size than their split counterparts, causing the user to download native binaries that are not applicable to their device’s architecture.

