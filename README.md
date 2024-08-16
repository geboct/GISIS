# gsis

A mobile app for Ghana Immigration Service Information Service
Functional Requirements
1. User Authentication
   Login: Allow users to log in with a username/email and password.
   Registration: Allow new users to register by providing necessary details like username, email, and password.
   Password Recovery: Provide a way for users to recover their password via email.
2. User Profiles
   View Profile: Users should be able to view their profile information.
   Edit Profile: Users should be able to update their profile details, such as personal information and contact details.
3. Document Management
   Upload Documents: Users should be able to upload documents required for their immigration process.
   View Documents: Users should be able to view the uploaded documents.
   Delete Documents: Users should be able to delete any uploaded documents.
4. Status Tracking
   View Application Status: Users should be able to see the current status of their immigration applications.
   Status History: Users should be able to view the history of status changes for their applications.
5. Notifications
   Push Notifications: Send notifications to users for status updates or important alerts.
   In-App Notifications: Display notifications within the app for user actions and updates.
6. Search Functionality
   Search Information: Allow users to search for specific information within the app, such as articles or FAQs related to immigration services.
7. Support/Help Desk
   Contact Support: Provide a way for users to contact support for help with their immigration process.
   FAQs: Provide a list of frequently asked questions for users to browse.



   Detailed Breakdown
1. User Authentication
   Login:

Input: Email/Username and Password.
Process: Verify credentials with the backend.
Output: Success or error message.
Registration:

Input: Username, Email, Password, and possibly other personal details.
Process: Create a new user in the database.
Output: Success message and possibly auto-login.
Password Recovery:

Input: Email.
Process: Send a password reset link to the provided email.
Output: Email sent confirmation message.
2. User Profiles
   View Profile:
   Display: Personal details such as name, email, contact information, and immigration status.
   Edit Profile:
   Input: Editable fields for personal details.
   Process: Update the user information in the database.
   Output: Success or error message.
3. Document Management
   Upload Documents:

Input: Document files (PDF, images, etc.).
Process: Store the document in cloud storage and save the metadata in the database.
Output: Success or error message.
View Documents:

Display: List of uploaded documents with options to view each.
Delete Documents:

Process: Remove the document from storage and delete metadata from the database.
Output: Success or error message.
4. Status Tracking
   View Application Status:
   Display: Current status of the application with relevant details.
   Status History:
   Display: Historical data of all status changes.
5. Notifications
   Push Notifications:

Trigger: Status updates or important alerts.
Display: Notification on the user’s device.
In-App Notifications:

Display: Notifications within the app interface for user actions and updates.
6. Search Functionality
   Search Information:
   Input: Search query.
   Process: Search the database for matching information.
   Output: List of search results.
7. Support/Help Desk
   Contact Support:

Input: User query or issue.
Process: Send the query to support staff.
Output: Confirmation of query submission.
FAQs:

Display: List of frequently asked questions and answers.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
