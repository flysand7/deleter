# History deleter

This utility deletes all URL's containing "pornhub.com" from browser history. It only works with Google Chrome on windows. It can theorhetically work on linux but you'll have to build sqlite3 from source (I have the scripts in my [sqlite3](https://github.com/flysand7/odin-sqlite3) repo) and change the path to the path where chrome/chromium stores its browser history. This information can be found online

## Usage

1. Close google chrome
2. Run history-deleter.exe
3. Open google chrome (if you need it)

You can also set up cron task to do this automatically but I personally wouldn't because the database would fail to commit changes to the filesystem when it's opened by chrome, and most likely your browser is opened at all times.
