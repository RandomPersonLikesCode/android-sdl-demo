# SPDX-License-Identifier: MIT

PROC="8"

#

MIN_SDK_VERSION="31"
SDK_VERSION="34"
NDK_VERSION="29.0.14206865"

LIB_ARCH="arm64-v8a"
COMPILE_ARCH="aarch64"

LIB_NAME="main"

PACKAGE="com/rplc/sdl_demo"

#

SDK_PATH="$ANDROID_HOME/platforms/android-$SDK_VERSION/android.jar"
NDK_PATH="$ANDROID_NDK_HOME/$NDK_VERSION"

#

AAPT2="aapt2"
JAVAC="javac"
D8="d8"
ZIP="zip"
ZIPALIGN="zipalign"
APKSIGNER="apksigner"

SZ="7z"

#

BUILD="./.build"
CACHE="./.cache"
COPY_DEST="/sdcard/Download"
LIB_DIR="$BUILD/lib/$LIB_ARCH"
RES="./res"

C_SRC="../src/jni"
C_SRC_N="./src/jni"
C_INCL="$C_SRC/third_party/include"

C_LIB="$C_SRC_N/third_party/lib"

JAVA_DIR="./src/java"
JAVA_SRC="$JAVA_DIR/$PACKAGE"
JAVA_LIBS="$JAVA_DIR/third_party"
JAVA_CLASS="$CACHE/**/*.class"

JAVA_SDL3="$JAVA_LIBS/SDL3/SDL3.jar"

#

MANIFEST="./AndroidManifest.xml"
FLATS="$BUILD/*.flat"

LIB="$LIB_DIR/lib$LIB_NAME.so"

APK_UNSIGNED="$BUILD/app-unsigned.apk"
APK_ALIGNED="$BUILD/app-aligned.apk"
APK_SIGNED="$BUILD/app-signed.apk"

SDL3_L="$C_LIB/SDL3/$LIB_ARCH"
SDL3="$SDL3_L/libSDL3.so"

APK_Z="app-unsigned.apk"
LIB_Z="lib"

#

AAPT2_CF="compile -o $BUILD --dir $RES"
AAPT2_LF="link -I $SDK_PATH --manifest $MANIFEST -o $APK_UNSIGNED $FLATS"

JAVA_SRC_F="--release 17 -cp "$SDK_PATH:$JAVA_SDL3" -d $CACHE"

D8_F="--min-api $MIN_SDK_VERSION --lib $SDK_PATH --output $BUILD $JAVA_CLASS $JAVA_SDL3"

SZ_F="-y x"

ZIP_F="-0 -ur $APK_Z $LIB_Z ./*.dex"
ZIPALIGN_F="-v 4 $APK_UNSIGNED $APK_ALIGNED"

APKSIGNER_F="sign --ks $KS --ks-key-alias $KS_ALIAS --ks-pass pass:$KS_PASS --out $APK_SIGNED $APK_ALIGNED"

#

CLANG="$NDK_PATH/toolchains/llvm/prebuilt/linux-x86_64/bin/$COMPILE_ARCH-linux-android$SDK_VERSION-clang"

CLANG_CSTD="c99"
CLANG_W="-Wall -Wextra -Wpedantic"
CLANG_O="-O0 -g3 -fno-omit-frame-pointer"

CLANG_COF="-std=$CLANG_CSTD $CLANG_W $CLANG_O -isystem $C_INCL -fcolor-diagnostics -c -fPIC"
CLANG_COF_L="$CLANG_O -isystem $C_INCL -c -fPIC"
CLANG_CFF="-shared"
CLANG_CLF="-L$SDL3_L -lSDL3 -landroid -llog -lEGL -lGLESv3"

#

JAVA_SRC_FILES="$CACHE/java_src_files.txt"

C_SRC_FILES=(
  "main.c"
)

C_SRC_LIBS=()
