# Bowling exercise: Strike!
```
Background :-

Strike!	is a bowling club. They	need  help to keep score automatically on competitions and avoid human errors	from the judges.

On competitions	there are 10 frames. In	each frame the	player	has	the opportunity	to try to take down	the	pins twice	and	there are 10 pins on the	start of each try.
The	rules	are	the	following:
- If the player	knocks	down less than 10 pins during 2	tries on the same frame, his/her score is the sum of the pins they’ve knock down in the 2 attempts.
- If the player	knocks down	all	the	10 pins	during 2 tries on the same frame (spare), his/her score is the sum of the pins knocked down on the spare(10), plus the number of pins knocked down in the next try.  Example: try 1(spare): 3|7,try	2: 3|4, score try	1:	13,	score try 2: 7,	total: 20
- If the player	knocks	down all 10	pins on	the	first try(strike),his/her score is the sum of pins knocked down on the strike(10) plus the number of pins knocked	down on	the	next 2 tries.
  Example: try 1(strike):	10|/, try 2: 3|4, score	try	1: 17, score try 2:	7, total:	24

```
### Prerequisites
```
Make sure that you have installed ruby 2.2.3 & rails 5.0.2
```
### Installation
```
rvm install ruby-2.2.3
rvm gemset create rails-5
rvm gemset use rails-5
bundle install
```
## Running the tests

In order to run automated rspec test cases, go to application root directory and execute below command in console,
```
rspec .
```
## Deployment
Deployed this application on heroku :-  [BowlingExercise](https://bowling-exercise.herokuapp.com/)
## Authors

* **Ramprabu Narayanasamy** - *Initial work* - [Ramprabu](https://github.com/ramprabhu-idexcel)

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details

## Acknowledgments

* Hat tip to anyone who's code was used
* Inspiration
* etc