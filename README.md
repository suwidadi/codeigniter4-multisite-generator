# 🚀 CodeIgniter 4 Multi-Site Setup (Windows)

This project provides a **ready-made batch script** to install **CodeIgniter 4 Core** with Composer and set up a new site instance under a `websites/` directory.

---

## 📂 Project Structure

After running the script, you’ll get something like this:

```
websites/
  ├── vendor                  # Core CodeIgniter 4 (installed via Composer)
  └── site1/                  # Your site folder (custom name)
      ├── app/                # Application folder copied from CI4 core
      ├── public/             # Public web root (with index.php)
      ├── writable/           # Writable directories
      │   ├── cache/
      │   │   ├── index.php
      │   │   └── .htaccess
      │   ├── debugbar/
      │   │   ├── index.php
      │   │   └── .htaccess
      │   ├── logs/
      │   │   ├── index.php
      │   │   └── .htaccess
      │   ├── sessions/
      │   │   ├── index.php
      │   │   └── .htaccess
      │   └── uploads/
      │       ├── index.php
      │       └── .htaccess
      ├── .env                # Environment config
      └── spark               # Spark CLI
```

---

## ⚡ Features

* Installs or updates CodeIgniter 4 core (`websites`) via Composer
* Creates new site structure under `websites\%SITENAME%`
* Copies `app/`, `index.php`, `.env`, and `spark`
* Updates `Paths.php` with the correct `$systemDirectory`
* Creates `writable/` directories with `index.php` and `.htaccess` for security

---

## 🛠️ Installation

### 1. Requirements

* Windows 10/11
* [Composer](https://getcomposer.org/) installed and available in PATH
* PHP installed and available in PATH

### 2. Run the Script

1. clone git@github.com:suwidadi/codeigniter4-multisite-generator.git websites
2. cd website
3. composer install

```
composer install
```

4. run multiweb_installer.bat sitename

```bat
multiweb_installer.bat sitename
```

---

## ▶️ Running the Site

From inside your new site folder:

```bat
cd websites\sitename
php spark serve --host=127.0.0.1 --port=8081
```

Or map a **custom host** in your `hosts` file:

```
127.0.0.1 sitename.local
```

Then run:

```bat
php spark serve --host=sitename.local --port=8081
```

---

## 📜 Notes

* The script automatically ensures `Paths.php` points to the correct `system/` directory inside `ci4-core`.
* `writable/` directories are secured with `.htaccess` and `index.php` placeholders.
* Multiple sites can be created by re-running the script with a different `%SITENAME%`.

---

## ✅ Example

```bat
multiweb_installer.bat sitename
```

Output:

```
Installing CodeIgniter 4 Core...
Creating sitename\...
Copying app structure...
Configuring Paths.php...
Creating writable directories...
Setup completed for site1
```

Your new CI4 app is ready at:
➡️ `http://sitename.local:8081/`

---
