# ThinkingFaces
Collection of animated spinners and bouncers for iOS. Thanks very much for looking at this repo. Hopefully these classes can form the starting point to your own custom activity indicator, or 'thinking face.'  

## Contributing 👏
Contributions always welcome. If you have a new idea for a fun spinner or bouncer, or see something that could be improved, please open a PR.

## Usage 🌟
Playgrounds built with Xcode 9.3 🛠
All components are a single class, and come packaged within a playground. Tweak any parameters or timing curves you'd like, and then copy the code out into your own project. All of the classes come with built-in accessors for timing, tint, and other params.

## Component Summary 📚

### SquareForce ◾️
Kinetic bouncing ball. Customizable via `tintColor` and `circleDiameter`

<img src="https://raw.githubusercontent.com/zmcartor/thinkingfaces/master/gifs/square.gif" width="200">


### StickySpinner 🐛

Inspired by Google, this spinner stretches and adjusts it's thickness for a more organic feel. Customizable via `tintColor` , `thickness` and `rotationTime`

<img src="https://raw.githubusercontent.com/zmcartor/thinkingfaces/master/gifs/sticky.gif" width="200">


### FlowerSpinner 🌸
Much like the system default `UIActivitySpinner`. Customizable via `speed`, `numberOfCircles` and `tintColor`

<img src="https://raw.githubusercontent.com/zmcartor/thinkingfaces/master/gifs/flower1.gif" width="200">

Adding many circles can create a more interesting shape.

<img src="https://raw.githubusercontent.com/zmcartor/thinkingfaces/master/gifs/flower2.gif" width="200">


### SolarSpinner 🚀🌎
A plinky animated solarsystem. The sizes of all planets, colors and spacing is all parameterizable. `spacing` and `masses` all take a tuple of three `Ints`. `bodyColors` accepts a tuple of `UIColor`. Use this as a starting point and hack the code to add more than 3 planets.

<img src="https://raw.githubusercontent.com/zmcartor/thinkingfaces/master/gifs/solar.gif" width="200">


### Shoestrap 👞
Inspired from the ubiquitous 'Bootstrap' styled spinner. Customizable via `tintColor`, `thickness`, `rotationTime`, `trackColor`

A very thin track tinted blue:

<img src="https://raw.githubusercontent.com/zmcartor/thinkingfaces/master/gifs/shoestrap1.gif" width="200">

Or a very thick track

<img src="https://raw.githubusercontent.com/zmcartor/thinkingfaces/master/gifs/shoestrap2.gif" width="200">

### Ringo 💗
Pulsing ring animation customizable via `tintColor`, `speed`, and `entropy`. A higher entropy will make the pulse animation looks like a telescoping gradient.

The blue gif has a high entropy. Notice the pulse feels like it's 'buzzing'

<img src="https://raw.githubusercontent.com/zmcartor/thinkingfaces/master/gifs/ringo.gif" width="200">


The red gif has a lower entropy.

<img src="https://raw.githubusercontent.com/zmcartor/thinkingfaces/master/gifs/ringo2.gif" width="200">




