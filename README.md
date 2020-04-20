# Audopod

This is a working in progress project. The general idea is to learn flutter with a real world application - a podcast generator that user can just write markdown posts, the app will generate audios automatically upon publishing.

## Backend

A GRPC rust server, providing all the functionalities.

To start, go to autopod_server and execute:

```bash
cargo run
```

## Frontend

A flutter App that user could compose in MacOS (unfortunately the MacOS build has problems so far), read the docs and listen to the playback in iphone/android.

To start, go to autopod_client and execute:

```bash
flutter run
```

## Slides

Slides for this project is generated with [marp](https://marp.app). Make sure you have marp installed and then you can run:

```bash
$ cd docs
$ make
```
