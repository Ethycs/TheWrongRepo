# flutter_dev

author: Cezary Żelisko

## About
The repository contains a workspace adapted to the development of applications using the Flutter framework. The workspace with all necessary dependencies is organized in a Docker container.

It uses the _Remote Development_ extension from the Visual Studio Code that allows you to open any folder in the container and work with it in the IDE that is installed on the host machine.

## Installation
* install Docker, Visual Studio Code and Remote Development extension by going through those steps in the [_Getting started_](https://code.visualstudio.com/docs/remote/containers#_getting-started) section,
* clone this repository (before this make sure that you have _git_ installed on your machine),
* create a directory `workspace` inside the cloned repository folder,
* open Visual Studio Code and click on the green icon in the bottom left corner of the window,
* from the popup menu choose: `Remote-Containers: Open Folder in Container...`,
* from the opened dialog navigate to the cloned repository, i.e. _flutter_dev_,
* now you have to wait until the building process is finished. It can take a couple of minutes. You can follow it step by step by clicking _details_ in the dialog that appears in the bottom right corner of the window.

You can check whether everything is set up correctly by opening new terminal window (`Terminal -> New Terminal` from the window menu) and typing: `flutter doctor`. You should see the output with checkmarks next to the first two options (Flutter SDK and Android SDK). Android Studio will be marked with `!` but it is ok - it won't be necessary. Last option refers to the connected devices and may be either checked or not depending on whether you have connected an Android device to your computer before.

## Application development
After successful installation you are able to start developing application. In order to do that you have to:
* open Visual Studio Code and click on the green icon in the bottom left corner of the window,
* from the popup menu choose: `Remote-Containers: Open Folder in Container...`,
* from the opened dialog navigate to the cloned repository, i.e. _flutter_dev_,
* open new terminal window (`Terminal -> New Terminal` from the window menu) and type: `flutter create <app_name>`,
* after the app is created click: `File -> Open Folder...` then navigate to the directory where app's files are stored and confirm you choice by clicking `OK`,
* Visual Studio Code will prepare a container for you,
* after the container is created you can launch your app by clicking `Debug -> Run Without Debugging`. Note: in order to launch an app you have to connect your Android device to the computer. If you have more than one device connected to your computer you will be prompted to select desired one.

Next time you want to open the folder for the app development you can select it from the _containers_ section of the _Remote Explorer_ left side menu.



## What's Going on Here

VSCode opens the dev container as a separate environment

I need to find shortest path to deploying the Flutter as as a web server

` flutter build web` produces web native artifacts in `/build/web` these are in turn paired with 

Azure Active Directory (Azure AD) is Microsoft’s cloud-based identity and access management service, which helps your employees sign in and access resources.

Azure App Service provides built-in authentication and authorization capabilities (sometimes referred to as "Easy Auth"), so you can sign in users and access data by writing minimal or no code in your web app, RESTful API, and mobile back end, and also [Azure Functions](https://docs.microsoft.com/en-us/azure/azure-functions/functions-overview). This article describes how App Service helps simplify authentication and authorization for your app.

| Provider                                                     | Sign-in endpoint   | How-To guidance                                              |
| :----------------------------------------------------------- | :----------------- | :----------------------------------------------------------- |
| [Microsoft Identity Platform](https://docs.microsoft.com/en-us/azure/active-directory/fundamentals/active-directory-whatis) | `/.auth/login/aad` | [App Service Microsoft Identity Platform login](https://docs.microsoft.com/en-us/azure/app-service/configure-authentication-provider-aad) |

