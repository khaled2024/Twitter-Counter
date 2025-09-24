# 🐦 Twitter Counter App  

## 📌 Overview  
This project was developed as part of the **Mobile Assessment Task**.  
The app allows users to:  

- ✍️ Type and count characters with respect to **Twitter character limit rules** (URLs, emojis, etc.).  
- 🔑 Authenticate with **Twitter (OAuth 1.0a User Context)**.  
- 📤 Post tweets directly to their own account after authorization.  

---

## ✨ Features  
- 🧮 **Twitter Character Counter**: Counts characters according to Twitter rules (URLs = 23 chars, emojis may count as 2, etc.).  
- 👤 **User Authentication**: Users log in via Twitter OAuth.  
- 🚀 **Tweet Posting**: After authorization, users can publish tweets directly to their account.  
- 🎨 **UI/UX**: Simple, clean, and responsive interface with toast messages and activity indicator.  
- 🧩 **MVVM Architecture**: Business logic separated in a ViewModel layer.  

---

## 🛠️ Tech Stack  
- **Language**: Swift (UIKit)  
- **Architecture**: MVVM  
- **OAuth Library**: [OAuthSwift](https://github.com/OAuthSwift/OAuthSwift)  
- **UI**: Storyboards + AutoLayout  

---

## 🚀 How It Works  
1. **On app launch**  
   - If saved tokens exist → Navigate directly to **Home Screen**.  
   - If no tokens → Navigate to **Login Screen**.  

2. **Login**  
   - User authorizes the app via Twitter OAuth.  
   - Tokens (`oauthToken` & `oauthTokenSecret`) are stored securely in `UserDefaults`.  

3. **Post Tweet**  
   - Type a message in the text box.  
   - Character counter updates live.  
   - Press **Post** → Tweet will be published to the authorized account.  

---

## 📸 Screenshots  
  <img width="200" height="500" alt="Simulator Screenshot - iPhone 15 Pro - 2025-09-24 at 23 20 11" src="https://github.com/user-attachments/assets/66c5d0c0-b240-462c-964f-3d173865a6d7" />
<img width="200" height="500" alt="Simulator Screenshot - iPhone 15 Pro - 2025-09-24 at 23 20 24" src="https://github.com/user-attachments/assets/4f4bcdf0-17f0-461d-bf4c-8721f8293804" />


---

## ⚠️ Limitations  
- Twitter **Basic API plan** allows only **17 tweets per 24 hours per App**.  
- Twitter blocks **duplicate tweets** with the same content.  

---

## ▶️ How to Run  
Clone this repo:  

```bash
git clone https://github.com/yourusername/twitter-counter-app.git
cd twitter-counter-app
