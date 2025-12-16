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

1. Download **ImageMagick** from [https://imagemagick.org](https://imagemagick.org)
2. During installation:

   * Check **"Install legacy utilities (convert)"**
   * Check **"Add application directory to your system PATH"**
3. Restart **Command Prompt** or **PowerShell**
4. Verify installation:

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


