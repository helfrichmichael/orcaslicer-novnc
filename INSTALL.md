# Cookie Clicker NoVNC Installation

## Assumptions

- You will use a remote server

## Requirements

- Steam Account
- Cookie Clicker Steam Version (less than 5 EUR) [Cookie Clicker on Steam](https://store.steampowered.com/app/1454400/Cookie_Clicker/)
- server with Docker Installed

## Pre-Installation Steps

1. Clone the repository containing the necessary files.
2. Create or use an existing Steam account.
3. Purchase Cookie Clicker on Steam. (Please do not pirate the game support the developer)
4. Install Docker on your server.

## Cookie Clicker Installation

1. Download Cookie Clicker from your Steam account to your local machine.
2. Navigate to the Steam installation folder.
3. Locate the directory where Cookie Clicker is installed.
4. Access the path: `/resources`.
5. Copy the `app` folder to your server.
6. Paste the `app` folder into the cloned repository's directory alongside the 'docker-compose.yml' file.
7. Uncomment this line `// app.disableHardwareAcceleration();//unfortunately breaks steam overlay` in `start.js`
7. Modify the `package.json` the the next:

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

## Docker Container Installation

1. Open the 'docker-compose.yml' file.
2. Update the save folder path to match the location within the cloned repository.
3. Execute the command: `docker-compose up -d`.
