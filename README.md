# cc-novnc

## Overview

Welcome to cc-novnc, your remote control for the ultimate Cookie Empire experience! Picture having your very own cookie utopia accessible from anywhere on this blue planet. With cc-novnc, you can indulge in the sweet delights of Cookie Clicker through your web browser, and here's the best part: your empire keeps baking those delectable cookies even when you're not actively connected! However, occasionally, the game might crash or hang and you'll have to restart it manually. But don't worry, it's a piece of cake!

## What You'll Need

### Things to Have:

- A Steam account.
- Cookie Clicker from Steam (costs less than 5 EUR on average).
- A server with Docker/Docker Compose installed and decent specs.

### Before You Start

1. **Get the Files:** Download the necessary files from the repository.
2. **Steam Account:** If you don't have one, create a Steam account.
3. **Get Cookie Clicker:** Purchase Cookie Clicker from the Steam Store (support the developers by buying it legally don't be a pirate arrr).
4. **Prepare Your Server:** Make sure Docker is installed on your server.

## Steps to Install Cookie Clicker

1. **Download Cookie Clicker:** Get Cookie Clicker from your Steam account to your computer.
2. **Find Steam Folder:** Locate where Steam is installed on your computer.
3. **Find Cookie Clicker Directory:** Look for the folder where Cookie Clicker is installed.
4. **Locate the 'app' Folder:** Inside the Cookie Clicker directory, find the 'app' folder.
5. **Move 'app' Folder:** Copy the 'app' folder and paste it into the folder you got from the repository.
6. **Make a Change:** Open a file named 'start.js' and remove the two slashes in front of `app.disableHardwareAcceleration();`.
7. **Edit 'package.json':** Replace the contents of 'package.json' with the provided text.

```json
{
  "name": "cookie-electron",
  "version": "1.0.0",
  "author": {
    "name": "Orteil",
    "email": "Orteil@example.com"
  },
  "homepage": "https://store.steampowered.com/app/1454400/Cookie_Clicker/",
  "description": "Cookie Clicker standalone",
  "main": "start.js",
  "license": "ISC",
  "dependencies": {
    "adm-zip": "^0.5.9",
    "steamapi": "^2.1.1"
  },
  "scripts": {
    "build": "electron-builder build"
  },
  "devDependencies": {
    "electron": "^11.2.3",
    "electron-builder": "^22.9.1"
  },
  "build": {
    "appId": "com.cookie.electron",
    "productName": "CookieClicker",
    "linux": {
      "target": "AppImage",
      "icon": "src/icon.png"
    }
  }
}
```

## Installing the Docker Container

1. **Customize 'docker-compose.yml':** Edit the 'docker-compose.yml' file as needed.
2. **Run a Command:** Use the command `docker-compose up -d`.
3. **Wait:** Grab a cup of tea and wait for the container to build.

## How to Play

### Playing Cookie Clicker

1. **Access noVNC:** Open your web browser and enter your server's IP address followed by port 8080 (or the one you specified in 'docker-compose.yml').
2. **Connect:** Click the 'Connect' button.
3. **Click Away:** Start playing Cookie Clicker!

## Issues and Solutions

If you encounter any problems or bugs:

- Visit [GitHub](https://github.com/staninna/cc-novnc/issues/new) to report issues.
- Known issue: If the game crashes or hangs when the browser window is large, make it smaller and close the game using the 'X' at the top right; then, the game will restart automatically after a minute or so.

## Licensing

This project is licensed under the MIT License. For more details, check the [LICENSE](LICENSE) file.

## Legal Disclaimer

I will not provide a pre-build container becuase it contains a copy of Cookie Clicker, which is a commercial product. You must purchase Cookie Clicker from Steam and follow the steps in this guide to build the container yourself. I am not responsible for any legal issues (if any) that may arise from using this project. Please use it at your own risk.
