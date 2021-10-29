# MovieApp

### Shopback Assignment Submission:
Daniel Wong Yong Shen

## Introduction:
MovieApp is written in Swift 5. It is designed for iOS Devices.

It is structured around the MVVM pattern and utilises RxSwift for data passing. It utilises the Storyboard for its user interface.

## Screenshots
Please see the screenshots folder for screenshots.

## Feature List
### Home Screen
- [x] Ordered by release date
- [ ] Pull to refresh
- [ ] Load when scrolled to bottom
- [x] Each movie to include: Poster image, title, popularity

### Detail Screen
- [x] Movie detail with: Synopsis, genres, language, duration
- [x] Book the movie 

## Installation Instructions:
1. Ensure Xcode and CocoaPods are installed
2. Run `pod install` in the MovieApp folder
3. Launch the *.xcworkspace file, hit build and run

## Design and Implementation Details:
The architectural design adopted for this program is the Model-View-ViewModel pattern (MVVM).

There are 4 primary groups within the program:

1. Views
This contains the storyboard, subclasses that define and control the behaviour of UI elements, and extensions for UI classes.

2. Models
This contains the models for the application, as well as several constants.

3. ViewModels
This contains the ViewModels for the application, which pre-process the data and perform the necessary logic before handing the data over to the views.

4. ViewControllers
This contains the View Controllers that define the behaviour of elements in the storyboard.

### Movies View
The main screen of the application, the MoviesView, utilises a `UICollectionView` to display the movies. Each movie is displayed using a reusable `UICollectionViewCell` with the identifier `MovieCell`. A prototype of the cell can be seen within the storyboard.

To populate the Movies View, the `UICollectionView` is bound to a `PublishSubject` with RxSwift. This `PublishSubject` is then bound to an equivalent item in the `MoviesViewModel`. This allows for the automatic generation and population of each MovieCell upon receiving data from the TMDb API call. 

This is all performed within the `MoviesViewController`, which is the `ViewController` where `UICollectionView` resides. At application opening, it uses the `viewDidLoad` method to set up the abovementioned bindings, and instruct `MoviesViewModel` to retrieve the movies from the API endpoint.

It also implements  `UICollectionViewDelegate`, which defines the action to be performed upon tapping a movie. 
Additionally, it also implements `UICollectionViewDelegateFlowLayout` and determines the size of each element within the `UICollectionView`.

### Movie Details View
The Movie Details View is structured similarly to the Movies View. 

The `MovieDetailsViewController` sets up a subscription to the movie element within the `MovieDetailsViewModel`, and publishes any changes broadcast to it to the view. It also redirects the user to buy tickets when requested.

### Retrieving movies
The retrieval of movies is done in `MoviesViewModel`. A `URLSession dataTask` is used to perform the query. It is then decoded with JSONDecoder, and broadcasted with a `PublishSubscribe` object. 

For the ease of decoding the JSON, all models are designed to conform to the `Codable` protocol.


## Testing
### Unit Tests
No unit tests were written due to a constraint on time.
However, if more time was available, I would test the following:

1. Test `MoviesViewModel` subscription in `MoviesViewController` with `RxTest`
2. Test `MovieDetailsViewModel` subscription in `MovieDetailsViewController` with `RxTest`
3. Test the computed properties within the Models

### Integration Tests:
No code-based integration tests were written due to a constraint on time.
However, the following integration tests can be performed manually:

1. Launch application -> User should see list of movies
2. Scroll through list of movies -> All movies should have an image, title and rating
3. Click on any movie -> User should be redirected to a movie details screen displaying the image of the movie, its title, rating, synposis, language, runtime, and a button to buy tickets
4. Click on buy tickets -> User should be redirected to Safari to buy tickets

## Reflections
This assignment was both a refreshing and frustrating experience for me. Despite having never used RxSwift before, and RxSwift being optional for the application, I decided to take on the challenge and utilise it in the implementation.

I was also unfamiliar with the MVVM design pattern. As someone whose strength is not UI design, the graphical interface provided by the Storyboard helps me visualise what a user interface will look like when implementing it. As such, most of my time in Swift has been spent with the MVC pattern. It took some reading up for me to understand what the MVVM pattern entailed.

In hindsight, would I do this again, I would not have used RxSwift given the time constrait as I spent much of my time trying to troubleshoot it. While the binding to a `UICollectionView` greatly simplified the process of generating `MovieCells`, my unfamiliarity with it meant that I was getting unexpected behaviour from it. 

However, having learned about it over the past few days, I certainly think that the potential for RxSwift is great. Had I had more time, I would certainly have chosen to work with it (and learn enough to get around those unexpected moments). The reactive programming paradigm makes much sense for applications like these, where streams of data compose reusable UI elements. 

Unfortunately, there is also quite some amount of duplicate code within the application. Most notably, the MovieDetails model shares all the properties of the Movie model, and both MovieDetails and Movie share the same code for querying the TMDb API, apart from a few minor differences. I did this in a rush to complete these features, but given more time, I would have avoided doing so entirely.

The application does not handle any errors at this point either. As someone who considers error handling as a crucial part of any application, I would have set this up properly with more time.

The ViewModels are also setup now to perform all the logic - including the querying and processing of data from the TMDb API. While in an application as this, it looks manageable, it would have been good (and needful in larger applications) to separate out the network request layer into a new file altogether, ensuring that the role of the ViewModel is not confused any further.

I regret not being able to complete the assignment in its entirety, but would rather give it my best shot than giving up the submission. I am, however, deeply grateful for the opportunity to attempt it - as someone who has not used Swift extensively for almost a year, writing it again has served as a good revision, and more importantly, reminded me of why I consider developing iOS applications the most enjoyable.
