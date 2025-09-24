## Twitter Counter App
##📌 Overview

This project was developed as part of the Mobile Assessment Task.
The app allows users to:

Type and count characters with respect to Twitter character limit rules (URLs, emojis, etc.).

Authenticate with Twitter (OAuth 1.0a User Context).

Post tweets directly to their own account after authorization.

##✨ Features

Twitter Character Counter: Counts characters according to Twitter rules (URLs = 23 chars, emojis may count as 2, etc.).

User Authentication: Users log in via Twitter OAuth.

Tweet Posting: After authorization, users can publish tweets directly to their account.

UI/UX: Simple, clean, and responsive interface with toast messages and activity indicator.

MVVM Architecture: Business logic separated in a ViewModel layer.

🛠️ Tech Stack

Language: Swift (UIKit)

Architecture: MVVM

OAuth Library: OAuthSwift

UI: Storyboards + AutoLayout

🚀 How It Works

On app launch:

If saved tokens exist → Navigate directly to Home Screen.

If no tokens → Navigate to Login Screen.

Login:

User authorizes the app via Twitter OAuth.

Tokens (oauthToken & oauthTokenSecret) are stored securely in UserDefaults.

Post Tweet:

Type a message in the text box.

Character counter updates live.

Press Post → Tweet will be published to the authorized account.

📸 Screenshots

(Add your simulator screenshots here for Login, Home, Posting Tweet, Character Counter, etc.)

⚠️ Limitations

Twitter Basic API plan allows 17 tweets per 24 hours per App.

Twitter blocks duplicate tweets with the same content.

▶️ How to Run

Clone this repo:

git clone https://github.com/yourusername/twitter-counter-app.git
cd twitter-counter-app


Open Twitter Counter.xcodeproj in Xcode.

Add your Twitter API Key, Secret, and Callback URL in TwitterClient.swift.

Run the app on a simulator or device.

🙋 Author

Developed by [Khaled Hussien Khalifa]

Email: [anakhaled209@gmail.com]

LinkedIn: [https://www.linkedin.com/in/khaled-hussien-a961391a6/]
