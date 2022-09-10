#!/sbin/sh
#
# This file is part of The BiTGApps Project

# ADDOND_VERSION=3

if [ -z "$backuptool_ab" ]; then
  SYS="$S"
  TMP=/tmp
else
  SYS="/postinstall/system"
  TMP="/postinstall/tmp"
fi

. /tmp/backuptool.functions

list_files() {
cat <<EOF
priv-app/Velvet/Velvet.apk
priv-app/Velvet/lib/arm/libagsa_renderer_jni.so
priv-app/Velvet/lib/arm/libandroid_cobalt_core_wrapper.so
priv-app/Velvet/lib/arm/libandroid_latency_measurement.so
priv-app/Velvet/lib/arm/libarcore_sdk_c.so
priv-app/Velvet/lib/arm/libarcore_sdk_jni.so
priv-app/Velvet/lib/arm/libbarhopper.so
priv-app/Velvet/lib/arm/libcortex_native_jni.so
priv-app/Velvet/lib/arm/libcronet.106.0.5228.2.so
priv-app/Velvet/lib/arm/libelements.so
priv-app/Velvet/lib/arm/libfilterframework_jni.so
priv-app/Velvet/lib/arm/libframesequence.so
priv-app/Velvet/lib/arm/libgeller_jni_lib.so
priv-app/Velvet/lib/arm/libgmutlsjni.so
priv-app/Velvet/lib/arm/libgoogle_speech_jni.so
priv-app/Velvet/lib/arm/libgoogle_speech_micro_jni.so
priv-app/Velvet/lib/arm/liblens_vision.so
priv-app/Velvet/lib/arm/libmappedcountercacheversionjni.so
priv-app/Velvet/lib/arm/libnative_crash_handler_jni.so
priv-app/Velvet/lib/arm/libnativecrashreporter.so
priv-app/Velvet/lib/arm/liboffline_actions_jni.so
priv-app/Velvet/lib/arm/libogg_opus_encoder.so
priv-app/Velvet/lib/arm/libopuscodec.so
priv-app/Velvet/lib/arm/libsbcdecoder_jni.so
priv-app/Velvet/lib/arm/libsoda_jni_no_terse.so
priv-app/Velvet/lib/arm/libsuggest_jni.so
priv-app/Velvet/lib/arm/libvcdiffjni.so
etc/permissions/velvet.xml
EOF
}

case "$1" in
  backup)
    list_files | while read FILE DUMMY; do
      backup_file $S/"$FILE"
    done
  ;;
  restore)
    list_files | while read FILE REPLACEMENT; do
      R=""
      [ -n "$REPLACEMENT" ] && R="$S/$REPLACEMENT"
      [ -f "$C/$S/$FILE" ] && restore_file $S/"$FILE" "$R"
    done
    for i in $(list_files); do
      chown root:root "$SYS/$i" 2>/dev/null
      chmod 644 "$SYS/$i" 2>/dev/null
      chmod 755 "$(dirname "$SYS/$i")" 2>/dev/null
    done
  ;;
esac
