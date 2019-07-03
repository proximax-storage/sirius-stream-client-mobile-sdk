DJINNI_SRC_DIR="deps/djinni/support-lib"
DJINNI_DEST_DIR="djinni-src"

mkdir -p $DJINNI_DEST_DIR
for file in $DJINNI_SRC_DIR/*; do
	if [[ $file == *.hpp ]]; then
		echo "Copying file from DJINNI dir: ${file}"
		cp -f $file "${DJINNI_DEST_DIR}"
	fi
done

DJINNI_OBJC_DIR="${DJINNI_DEST_DIR}/objc"
DJINNI_JAVA_DIR="${DJINNI_DEST_DIR}/java"
DJINNI_JNI_DIR="${DJINNI_DEST_DIR}/jni"

mkdir -p $DJINNI_OBJC_DIR
echo "Copying files to OBJC dir..."
# cp -rf "${DJINNI_SRC_DIR}/objc" "${DJINNI_DEST_DIR}"
find "${DJINNI_SRC_DIR}/objc" -type f -name '*' -exec cp -f '{}' "${DJINNI_OBJC_DIR}" ';'
find "${DJINNI_OBJC_DIR}" -type f -print0 | xargs -0 sed -i '' 's/"\.\.\/proxy_cache_impl\.hpp"/<proxy_cache_impl\.hpp>/g'
find "${DJINNI_OBJC_DIR}" -type f -print0 | xargs -0 sed -i '' 's/"\.\.\/proxy_cache_interface\.hpp"/<proxy_cache_interface\.hpp>/g'

mkdir -p $DJINNI_JAVA_DIR
echo "Copying files to JAVA dir..."
cp -rf "${DJINNI_SRC_DIR}/java" "${DJINNI_DEST_DIR}"
# find "${DJINNI_SRC_DIR}/java" -type f -name '*' -exec cp -f '{}' "${DJINNI_JAVA_DIR}" ';'

mkdir -p $DJINNI_JNI_DIR
echo "Copying files to JNI dir..."
cp -rf "${DJINNI_SRC_DIR}/jni" "${DJINNI_DEST_DIR}"
# find "${DJINNI_SRC_DIR}/jni" -type f -name '*' -exec cp -f '{}' "${DJINNI_JNI_DIR}" ';'
