# Flutter
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.app.** { *; }

# Firebase Core
-keep class com.google.firebase.** { *; }
-keep interface com.google.firebase.** { *; }

# Firebase Firestore
-keep class com.google.firebase.firestore.** { *; }
-keep interface com.google.firebase.firestore.** { *; }

# Firebase Messaging
-keep class com.google.firebase.messaging.** { *; }

# Firebase Crashlytics
-keep class com.google.firebase.crashlytics.** { *; }

# Hive
-keep class com.hive.** { *; }

# AndroidX Lifecycle
-keep class androidx.lifecycle.** { *; }
-keep interface androidx.lifecycle.** { *; }

# Google Play Services
-keep class com.google.android.gms.** { *; }
-keep interface com.google.android.gms.** { *; }

# Protobuf
-keep class com.google.protobuf.** { *; }

# Keep model classes with Hive @HiveType
-keepclasseswithmembers class * {
  @com.hive.TypeAdapter <fields>;
}

# Keep enum values
-keepclasseswithmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}
