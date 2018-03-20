
Solution Description: This project demonstrates knowledge of various Swift structures and usage of third party frameworks. If you clone this repo and run the program, you will be presented with various Ads pulled from a remote JSON link. The app has two sections. One is a main feed of advertisements and the other is a feed of ads that the  user has saved. Only the main feed is functional as Core Data has not been completely implemented yet. 

I'm generally happy with how I structured my code. I also think that this layout works well for displaying Ads.

I decided to work on networking before I worked on UI and that led to not much UI being created hurting the overall user experience. 

A list of things I had in mind for this project given more time include:
-Finishing implementing core data
-Only loading a certain amount of ad objects at a time. At the moment, the app gets the json, parses all of it into objects, and loads all of the objects as you scroll. Instead I would load around 30 objects at a time and use the collection viewWillDisplay method to load more ad objects as you near the bottom of the current set of ads. 
-Add a launch screen with an activity indicator or progress bar that will dissolve once the ads have finished loading
-A similar solution would be to have a collection view of content outlines with an activity indicator where the image would be. This gives the user some assurance that something is being loaded rather than having to stare at a blue screen. 
-Add a navigation bar and with that a settings button that takes a user to a view where the user can toggle certain settings including showing only favorites or sorting based on different data.
-A similar solution would be to implement a split-viewController with a list of checkable options that change the content shown in the main feed. 
-I wanted to place the description of the ads in a scroll view since they tend to be long enough to cut off. 
-I would implement a detail view controller that allows you to see a better view of the image and potentially more details about the ad that aren't included in the collection view. 
-After implementing the detailViewController, I would also implement 3D Touch so the user can also access it through that method. 
-If the user clicks on the saved Ads tab without saving any ads, I would have a view with a dialog box explaining what that section is for and how to make use of it. 
