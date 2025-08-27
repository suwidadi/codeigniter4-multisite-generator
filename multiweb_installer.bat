@echo off
SETLOCAL ENABLEDELAYEDEXPANSION

REM ===============================
REM Usage: setup_site.bat sitename
REM Example: setup_site.bat site1
REM ===============================

if "%~1"=="" (
    echo Please provide a site name.
    echo Example: setup_site.bat site1
    exit /b 1
)

set SITENAME=%~1

echo Creating structure for %SITENAME% ...

REM Create directories
mkdir %SITENAME%\app
mkdir %SITENAME%\public
mkdir %SITENAME%\writable

for %%D in (cache debugbar logs sessions uploads) do (
    mkdir %SITENAME%\writable\%%D
    echo ^Directory access is forbidden. > %SITENAME%\writable\%%D\index.html
)
echo ^Directory access is forbidden. > %SITENAME%\writable\index.html
(
echo ^<IfModule authz_core_module^>
echo     Require all denied
echo ^</IfModule^>
echo ^<IfModule ^^!authz_core_module^>
echo     Deny from all
echo ^</IfModule^>
) > %SITENAME%\writable\.htaccess

REM Copy "app" folder contents
xcopy /E /I /Y vendor\codeigniter4\framework\app\* %SITENAME%\app\

REM Copy index.php
copy /Y vendor\codeigniter4\framework\public\index.php %SITENAME%\public\

REM Copy .env
copy /Y vendor\codeigniter4\framework\env %SITENAME%\.env

powershell -Command "(Get-Content %SITENAME%\.env) -replace '# CI_ENVIRONMENT = production','CI_ENVIRONMENT = development' | Set-Content %SITENAME%\.env"

REM Copy spark file
copy /Y vendor\codeigniter4\framework\spark %SITENAME%\spark

powershell -Command "(Get-Content %SITENAME%\app\Config\Paths.php) -replace 'public string \$systemDirectory\s+=\s+.*;', 'public string $systemDirectory = __DIR__ . ''/../../../vendor/codeigniter4/framework/system'';' | Set-Content %SITENAME%\app\Config\Paths.php"

powershell -Command "(Get-Content %SITENAME%\app\Controllers\Home.php) -replace 'return view\(''welcome_message''\);', 'return view(''%SITENAME%'');' | Set-Content %SITENAME%\app\Controllers\Home.php"

echo %SITENAME% > %SITENAME%\app\Views\%SITENAME%.php

echo.
echo Site "%SITENAME%" setup completed!
exit