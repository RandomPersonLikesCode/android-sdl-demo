# SDL3 Demo (Built On-Device Using Termux)
## HELP

With the upcoming Google's policy regarding Android
developer verification, open source Android projects
is in danger, so please spread this information to
everyone including fellow Android developers and don't
forget to send a link to [KeepAndroidOpen](https://keepandroidopen.org)!

## About

This just a demo using C and Java, and also SDL3 to build Android Games,
This project is also tested on-device using Termux to build.

## Build Command

To build, make sure to have a keystore file using `keytool`, then run this:

```sh
KS=<keystore_file> KS_ALIAS=<keystore_alias> KS_PASS=<keystore_password> SETUP_LIBS= COMPILE_JAVA= COMPILE_C= COPY= bash script/build.bash
```

To just clean build artifacts, run:

```sh
CLEAN= bash script/build.bash
```

# License

This project is licensed under MIT license (see `LICENSE`), this project
also uses third-party libraries, license copy for each third-party libraries can
be found in each subdirectory inside `third_party/` folder.
