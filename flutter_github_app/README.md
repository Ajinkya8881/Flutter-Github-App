# Flutter GitHub Repos

A simple Flutter app that connects to the GitHub API to display public repositories and their last commit information. This project demonstrates basic Flutter UI development and API integration.

## Features

- **Fetch Public Repositories**: Retrieves and displays a list of public repositories from the GitHub API.
- **Show Last Commit**: For each repository, shows the last commit message.

## Getting Started

### Prerequisites

- Flutter installed on your machine. Follow the [official Flutter installation guide](https://flutter.dev/docs/get-started/install) if needed.
- A working knowledge of Dart and Flutter.

### Installation

1. **Clone the Repository**

        git clone https://github.com/Ajinkya8881/flutter_github_app.git

2. **Navigate to the Project Directory**

        cd flutter_github_app

3. **Get the Dependencies**

      Make sure you have the required dependencies installed:

        flutter pub get

4. **Run the Application**

      Choose the target device (e.g., Windows, Chrome) and run the application:

        flutter run

**How It Works**

 Fetching Repositories: The app fetches public repositories from the GitHub API using the endpoint https://api.github.com/users/freeCodeCamp/repos.

 Displaying Data: Repositories are displayed in a scrollable ListView. Each item shows the repository name and description.

 Fetching Last Commits: After fetching the repositories, the app asynchronously retrieves the last commit message for each repository using the endpoint             https://api.github.com/repos/freeCodeCamp/{repo_name}/commits.

