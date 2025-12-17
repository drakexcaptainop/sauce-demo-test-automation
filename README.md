# SauceDemo Smoke Test

This project is a Cucumber smoke test suite in Ruby for the [saucedemo.com](https://www.saucedemo.com) web page. It verifies the basic functionality of the site by interacting with buttons, forms, and page elements.

---

## Requirements

* **Ruby** >= 3.0
* **Bundler** (run `gem install bundler` if not already installed)
* **ImageMagick** (required by `mini_magick` ruby package, which will be used for some tests)

---

## Installing ImageMagick Dependency

### Windows

1. Download **ImageMagick** from [https://imagemagick.org/downloads.php](https://imagemagick.org/script/download.php)
   or download latest-version directly using [https://imagemagick.org/archive/binaries/ImageMagick-7.1.2-11-Q16-HDRI-x64-dll.exe)](https://imagemagick.org/archive/binaries/ImageMagick-7.1.2-11-Q16-HDRI-x64-dll.exe)
3. During installation:

   * Check **"Install legacy utilities (convert)"**
   * Check **"Add application directory to your system PATH"**
4. Restart **Command Prompt** or **PowerShell**
5. Verify installation:

```powershell
magick -version
```

---

### macOS

```bash
brew install imagemagick
```

---

### Ubuntu / Debian

```bash
sudo apt update
sudo apt install imagemagick
```

---

## Installing Ruby Gems

All Ruby dependencies are managed by Bundler. The `Gemfile` and `Gemfile.lock` ensure reproducible versions.

1. Open a terminal (Windows: PowerShell / Command Prompt, macOS/Linux: Terminal)
2. Navigate to the project folder
3. Run:

```bash
bundle install
```

This will install:

* `mini_magick` — for decoding images and accessing pixel data if needed (wrapper for `ImageMagick`)

---

## Running Tests

Run all the Cucumber tests inside parent folder of `features` folder with:

```bash
cucumber features
```


