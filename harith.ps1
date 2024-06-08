param (
    [string]$action,
    [string]$project_name,
    [string]$commit_message
)

if (-not $action) {
    Write-Host "Usage: harith <action> [project_name] [commit_message]"
    Write-Host "Available actions: push, pull"
    exit 1
}

if ($action -eq "push") {
    if (-not $project_name -or -not $commit_message) {
        Write-Host "Usage: harith push {project_name} {commit_message}"
        exit 1
    }

    # Run Git commands for push
    git add -A
    git commit -m $commit_message
    git push

    # Run Docker commands for push
    docker build -t $project_name .
    docker tag $project_name "anuragpsarmah/$project_name"
    docker push "anuragpsarmah/$project_name"
}
elseif ($action -eq "pull") {
    # Run Git commands for pull
    git pull

    # Run Docker commands for pull
    docker build -t $project_name .
    docker tag $project_name "anuragpsarmah/$project_name"
    docker push "anuragpsarmah/$project_name"
}
else {
    Write-Host "Invalid action. Available actions: push, pull"
    exit 1
}
