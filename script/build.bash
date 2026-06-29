# SPDX-License-Identifier: MIT

shopt -s globstar
set -e

source script/config.bash

#

if [[ -v CLEAN ]]; then
  echo "Cleaning build artifacts..."
  rm -rf $BUILD $CACHE
  echo "Done"
  exit 0
fi

if [[ ! -v KS ]]; then
  echo "Keystore file is not set"
  exit 1
elif [[ ! -f "$KS" ]]; then
  echo "Keystore \"$KS\" file does not exist"
  exit 1
fi

if [[ ! -v KS_ALIAS ]]; then
  echo "Keystore alias is not set"
  exit 1
fi

if [[ ! -v KS_PASS ]]; then
  echo "Keystore password is not set"
  exit 1
fi

rm -rf $BUILD
mkdir -p $BUILD $CACHE $LIB_DIR

#

if [[ -v EXTRACT_LIBS ]]; then
  echo "Extracting SDL3 library..."
  $SZ $SZ_F $C_LIB/SDL3/libSDL3.7z -o$C_LIB/SDL3/
else
  echo "Libraries are not extracted"
fi

echo "Compiling resources..."
$AAPT2 $AAPT2_CF

echo "Linking resources..."
$AAPT2 $AAPT2_LF

if [[ -v COMPILE_JAVA ]]; then
  echo "Compiling Java sources..."
  find $JAVA_SRC -name "*.java" > $JAVA_SRC_FILES
  $JAVAC $JAVA_SRC_F @$JAVA_SRC_FILES

  echo "Converting Java classes..."
  $D8 $D8_F
else
  echo "Java sources are not compiled and converted to dex"
fi

if [[ -v COMPILE_C ]]; then
  echo "Compiling C sources..."
  cd $CACHE
  printf "$C_SRC/%s\n" "${C_SRC_FILES[@]}" | parallel -j $PROC $CLANG $CLANG_COF {}
  cd $OLDPWD

  echo "Linking C objects..."
  $CLANG $CLANG_CFF -o $LIB $CACHE/*.o $CLANG_CLF

  echo "Copying SDL3 shared library..."
  cp $SDL3 $LIB_DIR
else
  echo "C sources were not compiled and linked"
  echo "SDL3 library were not copied"
fi

echo "Zipping libraries and dex..."
cd $CACHE
$ZIP $ZIP_F
cd $OLDPWD

echo "Aligning APK..."
$ZIPALIGN $ZIPALIGN_F

echo "Signing APK..."
$APKSIGNER $APKSIGNER_F

if [[ -v COPY ]]; then
  echo "Copying APK to $COPY_DEST..."
  cp $APK_SIGNED $COPY_DEST
fi

echo "Done"
