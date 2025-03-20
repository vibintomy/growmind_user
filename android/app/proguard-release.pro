# Keep all classes in the Razorpay package
-keep class com.razorpay.** { *; }
-dontwarn com.razorpay.**

# Ensure ProGuard annotations are not removed
-keep class proguard.annotation.Keep { *; }
-keep class proguard.annotation.KeepClassMembers { *; }
-keep @interface proguard.annotation.**

# Suppress warnings (paste the new rules here)
-dontwarn proguard.annotation.Keep
-dontwarn proguard.annotation.KeepClassMembers
