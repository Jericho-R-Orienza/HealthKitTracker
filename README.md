# HealthTracker App

The HealthTracker app is designed to interact with Apple's HealthKit to fetch and display fitness data such as steps taken by the user today. It demonstrates how to request authorization from HealthKit, access step count data, and present this information within a SwiftUI-based iOS app. This goal of this app is to educate myself on this topic before moving on a bigger one.

## Features
- Requests HealthKit authorization to access step data.
- Fetches today's steps count.
- Displays the step count in a user-friendly interface.


## Requirements

- iOS 14.0+
- Xcode 12.0+
- Swift 5.3+

## Setup

To run this project, follow these steps:

- Clone the Repository: Clone this project to your local machine.
- Open the Project: Open the .xcodeproj file in Xcode.
- Enable HealthKit: Ensure HealthKit is enabled in your project's capabilities.
- Configure Bundle Identifier and Team: Set your own Bundle Identifier and select your Development Team in project settings.
- Run on a Real Device: Due to HealthKit's limitations, you must run this app on a real device. Connect your device, and make sure it is up to date.
Select it as the run target, and run the app. **Alternativly**: you can run the simulator on Xcode and mock data on the Health app before opening the HealthTracker app.
You would want to add data for steps, calories, and any other workout. Make sure that the data added are for the correct time stamp i.e. today, weekly, monthly. 

## Usage

Upon launching the app, you will be prompted to authorize access to your health data. After granting permission, the app will fetch and display the number of steps you've taken today.

## Contributing

Feel free to fork this project and submit pull requests with improvements or open issues if you encounter any problems.
