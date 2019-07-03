
# Add this global rule
-keepattributes Signature
-keepattributes *Annotation*
-keepattributes SourceFile,LineNumberTable

# General rules
# -----------------
-dontwarn com.sun.jna.*
-dontwarn java.awt.*

-assumenosideeffects class android.util.Log {
    public static boolean isLoggable(java.lang.String, int);
    public static int v(...);
    public static int i(...);
    public static int w(...);
    public static int d(...);
    public static int e(...);
}

-keep class org.webrtc.** { *; }
-keep class com.peerstream.psp.sdk.** { *; }
-keep class com.peerstream.psp.sdk.bridge.** { *; }

