introduction
football leagues repo created for Technivance company task.
It was a good challenge and I enjoyed it.here I will explain the app structure and what I made for the first time, What I Know and don't use it before and what I use usually.
1 - App structure:
the app structure contains four components Network,SQLManagers, Extensions, app modules, resources.
1.1 - Network :
contain Two layer NetworkManager which responsible for call moya layer and parse the JSON response to model using codable  and APIService which contain moya layer.
1.2- SQLManagers:
contains five classes the DatabaseManager which is the base layer for other SQL classes manage them and provide API for all SQL requests except imagSQL class contain its own API.
1.3- Extensions:
contains extension for UIImageView to add func loadImage() to load image from local data first and in not found make a network request to download image and cache it in the local database and set the image for UIimageView
1.4- AppModules:
there are three modules in app LeaguesModule, TeamsModule, Team/Matches module each one of them has:
storyboard file which contains UIViewController for Module
ViewController class which contain the UI Logic like show loading, show data, show error.
ViewModel Class which responsible for request data and update view with it. 
Repository Class which responsible for providing the data for viewModel from remote API or from local data.
Response model Class is the model that represent the data.
Assembler Class which response fro register Dependancies and resolve it.
Coordinator Class which responsible for the navigation logic initiate views and provide data if needed then navigate to it using func start(). 
ViewCells is the tableView cell for tableView and provides data to view with func configure().
1.5 resources: 
which contains the plist, assets, LaunchScreen, ApplicationAssembly which contains extension for SwinjectStoryboard to assembler all module when app start opening.
3 - Things that  first time to use 
In this task, I used MVVM-C pattern which it was the first time use it, SQLite I used it but before for one table without relation between tables and Rx which I start learning it from short time. 
4-problems I faced it while I do it:
The bigger one for me is the API responses and match it with the UI for each module, most of the responses are empty and other restricted and the mapping it to UI has confused me.
5- notes:
I used SQLite To store the data that I need not all response data. 
I use one table called Images for all image I need in the app which URL is the key. 
In teams module, I have to get the ID of the league to fetch the teams, So I passed this ID to team Coordinator and the Coordinator notify the viewModel to start binding with this ID.
The repository switch on network response closure and emit events base on the response returns this observable to ViewModel to bind on it.
For every success response data, the old that are deleted from SQL and new data Insert except image table with always store data "I know that is not good for a long time and need to empty it frequency" 
