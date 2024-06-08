@echo off
REM Check if the correct number of arguments is provided
if "%~1"=="" (
    echo Usage: harith {action} [project_name] [commit_message]
    echo Available actions: push, pull
    exit /b 1
)

REM Assign arguments to variables
set action=%1
shift

if "%action%"=="push" (
    if "%~2"=="" (
        echo Usage: harith push {project_name} {commit_message}
        exit /b 1
    )
    set project_name=%1
    shift
    set commit_message=%*
) else if "%action%"=="pull" (
    set project_name=
    set commit_message=
) else (
    echo Invalid action. Available actions: push, pull
    exit /b 1
)

REM Run Git commands
git add -A
git commit -m "%commit_message%"
git push

REM Run Docker commands
docker build -t %project_name% .
docker tag %project_name% anuragpsarmah/%project_name%
docker push anuragpsarmah/%project_name%
