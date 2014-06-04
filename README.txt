***AppTm4l***

Description:
AppTm4l is a tool for sharing, capturing and editing the image of any USB camera. Although it is intented to be used with microscope cameras (the name stands for App TeleMicroscopy For Linux), any USB camera can be used.

The application provides a simple web server that allows clients to view a real-time streaming of the video and control some basic features of the camera (brightness, gamma, exposure, etc). The web server contains an embedded flash player that accepts a video streaming via RTMP protocol.

The video streaming parameters can be modified from the AppTm4l gui. There is a control panel that allows users to select the desired USB camera, modify the streaming parameters (resolution, frames per second, quality, bitrate, group of pictures, web server port), modify the camera settings and activate basic HTTP authentication for the web server.

The application also allows to take remote and local captures of the image, and provide some basic tools for locally editing the image thanks to ImageJ software.

All software used in this application is open-source and is compatible with GNU GPLv3 license.


Installation:
The installation of AppTm4l is explained in INSTALL.txt. It is required to install some programs before executing the application. There are two ways to install them: automatically (by running a script) or manually.


Execution:
AppTm4l is executed by running the script AppTm4l.sh. If you want to use a privileged port for the web server (like default http 80), you must execute the script as superuser.

$ sudo ./AppTm4l.sh


Components:

- ImageJ: The applicataion is based on ImageJ (vesion 1.49a), with just a few modifications. This program is compressed in the executable jar file "ij.jar".

- macros/AppTm4l.ijm: This file is a ImageJ macro. This macro is passed as an execution parameter to ImageJ.

- plugins/ActionBar/AppTm4l_toolbar.txt: This file describes the toolbar for AppTm4l. It is called from the macro AppTm4l.ijm.

- plugins/telemicroscopy_plugin.jar: This jar file contains all the classes related to the microscope video: capture, streaming, web server, etc.

- web: This directory contains the flash player.

- AppTm4l.properties: Configuration file of AppTm4l.

- crtmperserver.lua: Configuration file of crtmpserver.

- crtmpserver-patch: Patches required for compiling crtmpserver on Odroid-U3.

