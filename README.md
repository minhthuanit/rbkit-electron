Rbkit-Electron
==============

This is an experimental project to test out the following combination:

* Electron for packaging the app
* ReactJS(in coffeescript + JSX)
* Bootstrap (react-bootstrap) for UI components and grid layout
* Jade for markup (not for JSX)
* SCSS for stylesheets
* Native node modules to read and parse data from rbkit-server (if need be).


Getting started
===============
Prerequisite : Node.js v0.12.7

```
npm install
# Add ./node_modules/electron-prebuilt/dist/Electron.app/Contents/MacOS to $PATH
./node_modules/.bin/gulp
```

ProTip: Use `direnv` to add Electron to $PATH:

```
PATH_add ./node_modules/electron-prebuilt/dist/Electron.app/Contents/MacOS
```
