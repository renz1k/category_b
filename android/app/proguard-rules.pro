# ============== Flutter & Dart ==============
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.app.** { *; }
-keep class com.google.dart.** { *; }

# ============== Google Play Core (optional for split install) ==============
-keep class com.google.android.play.core.** { *; }
-dontwarn com.google.android.play.core.**

# ============== Firebase ==============
-keep class com.google.firebase.** { *; }
-keep interface com.google.firebase.** { *; }
-keep class com.google.firebase.auth.** { *; }
-keep class com.google.firebase.firestore.** { *; }
-keep interface com.google.firebase.firestore.** { *; }
-keep class com.google.firebase.messaging.** { *; }
-keep class com.google.firebase.crashlytics.** { *; }
-keep class com.google.firebase.analytics.** { *; }
-dontwarn com.google.firebase.**

# ============== Hive (Local Database) ==============
-keep class com.hive.** { *; }
-keep class hive.** { *; }
-keepclasseswithmembers class * {
  @com.hive.TypeAdapter <fields>;
}

# ============== AndroidX & Lifecycle ==============
-keep class androidx.** { *; }
-keep interface androidx.** { *; }
-keep class androidx.lifecycle.** { *; }
-keep interface androidx.lifecycle.** { *; }

# ============== Google Play Services ==============
-keep class com.google.android.gms.** { *; }
-keep interface com.google.android.gms.** { *; }
-dontwarn com.google.android.gms.**

# ============== Protobuf ==============
-keep class com.google.protobuf.** { *; }
-keepclassmembers class com.google.protobuf.** {
  <methods>;
}

# ============== Kotlin ==============
-keep class kotlin.** { *; }
-keep interface kotlin.** { *; }
-keepclassmembers class kotlin.Metadata {
  public <methods>;
}
-dontwarn kotlin.**

# ============== Serialization & Reflection ==============
-keepclassmembers class * {
  @com.google.gson.annotations.SerializedName <fields>;
}

# ============== Native Methods ==============
-keepclasseswithmembers class * {
  native <methods>;
}

# ============== Enum Classes ==============
-keepclasseswithmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

# ============== Applications & Services ==============
-keep public class * extends android.app.Activity
-keep public class * extends android.app.Service
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.content.ContentProvider
-keep public class * extends android.app.backup.BackupAgentHelper
-keep public class * extends android.preference.Preference

# ============== View Constructors (for inflation) ==============
-keepclasseswithmembers class * {
    public <init>(android.content.Context, android.util.AttributeSet);
}

# ============== Parcelable ==============
-keep class * implements android.os.Parcelable {
    public static final android.os.Parcelable$Creator *;
}

# ============== R Classes ==============
-keepclassmembers class **.R$* {
    public static <fields>;
}

# ============== JSON Processing ==============
-keepclassmembers class * {
    @com.google.gson.annotations.Expose *;
}

# ============== AndroidX Window Manager ==============
-keep class androidx.window.** { *; }

# ============== Suppress Warnings ==============
-dontwarn sun.misc.Unsafe
-dontwarn com.google.common.**
-dontwarn java.lang.invoke.StringConcatFactory
