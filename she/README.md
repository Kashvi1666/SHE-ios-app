#  notes

next implementation: 
- core data 
- store avatar and name inputs for reuse in content view 
- make sure avatar view & first view only open on first time 
- connect avatar to game view (on avatar click)
- design game view 

ux blueprint: 



this is what i want to do: the first view opens up and takes you to the avatarview (but only if this is the first time you have ever opened the app and have not already made one) , once the user enters their name and avatar settings (skin and eye color selections) that information is saved to be reused in other views and the done button takes you to the contentview (there is no back button option afterwards, and everytime you reopen the app now, it will instead take you from the first view to the contentview directly) and i don't want to make any new files for this, only edits to the existing avatarview and contentview files!! this is the flow i want to implement: The app starts with a splash screen or first view.
A button is pressed and does one of the following: If the user has not created an avatar before, they're taken to the AvatarView to create one, if not the button directs to contentview.
The user's entered name and avatar settings in AvatarView are saved.
After that, the user is taken to ContentView, and the app directly opens to ContentView on subsequent launches.
