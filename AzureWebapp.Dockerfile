FROM ubuntu:18.04

# Prerequisites
RUN apt update && apt install -y curl git unzip xz-utils zip libglu1-mesa openjdk-11-jdk wget

# Setup new user
RUN useradd -ms /bin/bash developer
USER developer
WORKDIR /home/developer

# Prepare Android directories and system variables
RUN mkdir -p Android/Sdk/cmdline-tools
ENV ANDROID_SDK_ROOT /home/developer/Android/Sdk
RUN mkdir -p .android && touch .android/repositories.cfg

# Setup Android SDK
RUN wget -O sdk-tools.zip https://dl.google.com/android/repository/commandlinetools-linux-6858069_latest.zip
RUN unzip sdk-tools.zip && rm sdk-tools.zip
RUN mv cmdline-tools Android/Sdk/cmdline-tools/latest
RUN cd Android/Sdk/cmdline-tools/latest/bin && yes | ./sdkmanager --licenses
RUN cd Android/Sdk/cmdline-tools/latest/bin && ./sdkmanager "build-tools;29.0.2" "patcher;v4" "platform-tools" "platforms;android-29" "sources;android-29"

# Download Flutter SDK
RUN git clone https://github.com/flutter/flutter.git
ENV PATH "$PATH:/home/developer/flutter/bin:/$ANDROID_SDK_ROOT/platform-tools"

# Run basic check to download Dark SDK
RUN flutter doctor
