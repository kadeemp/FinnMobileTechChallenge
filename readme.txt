
Solution Description: This project demonstrates knowledge of various Swift structures and usage of third party frameworks. If you clone this repo and run the program, you will be presented with various Ads pulled from a remote JSON link.  The button in the top right corner is used to toggle between saved ads and all ads. The user can select ads to save or un-save them. If you open the app without network connection, only the saved ads will be presented.

I'm generally happy with how I structured my code. I also think that this layout works well for displaying Ads.

I decided to work on networking before anything else. I should have kept networking more simple so I could have more time working with the data. This would have allowed me to make better UX.

A list of things I had in mind for this project given more time include:

-Only loading a certain amount of ad objects at a time. At the moment, the app gets the json, parses all of it into objects, and loads all of the objects as you scroll. Instead I would load around 30 objects at a time and use the collection viewWillDisplay method to load more ad objects as you near the bottom of the current set of ads. 
-Add a launch screen with an activity indicator or progress bar that will dissolve once the ads have finished loading
-A similar solution would be to have a collection view of "Fake cells" with content outlines and an activity indicator where the image would be. This gives the user some assurance that something is being loaded rather than having to stare at a blue screen. 

- implement a split-viewController with a list of checkable options that change the content shown in the main feed. For example, show only ads based in Oslo 
-I wanted to place the description of the ads in a scroll view since they tend to be long enough to cut off. 
-I would implement a detail view controller that allows you to see a better view of the image, see more details about the ad that aren't included in the collection view, and the ability to save from the detail view instead of the collection view 
-After implementing the detailViewController, I would also implement 3D Touch so the user can also access it through that method. 
-If the user clicks on the saved Ads toggle without saving any ads for the first time, I would have a view with a dialog box explaining what that button is for and how to make use of it. 
