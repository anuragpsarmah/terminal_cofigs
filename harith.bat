@echo off

REM Set the variables
set action=%1
set project_name=%2
set commit_message=%3

REM Check if no action is provided
if "%action%"=="" (
    echo Usage: harith <action> [project_name] [commit_message]
    echo Available actions: push, pull
    exit /b 1
)

REM Check the action and execute corresponding commands
if "%action%"=="push" (
    REM Check if project name and commit message are provided for push
    if "%project_name%"=="" (
        echo Usage: harith push {project_name} {commit_message}
        exit /b 1
    )
    if "%commit_message%"=="" (
        echo Usage: harith push {project_name} {commit_message}
        exit /b 1
    )

    REM Run Git commands for push
    git add -A
    git commit -m "%commit_message%"
    git push

    REM Run Docker commands for push
    docker build -t %project_name% .
    docker tag %project_name% "anuragpsarmah/%project_name%"
    docker push "anuragpsarmah/%project_name%"
)
if "%action%"=="pull" (
    REM Check if project name is provided for pull
    if "%project_name%"=="" (
        echo Usage: harith pull {project_name}
        exit /b 1
    )

    REM Run Git commands for pull
    git pull

    REM Run Docker commands for pull
    docker build -t %project_name% .
    docker tag %project_name% "anuragpsarmah/%project_name%"
    docker push "anuragpsarmah/%project_name%"
)
