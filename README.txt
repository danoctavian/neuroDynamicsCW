Question 1:

To generate all plots for question 1 (a, b, and c) run Question1.m for a desired probability
eg. "Question1(0.1)"

Plots for question 1a (matrix connectivity)

figures/question1/connectivity00.fig
figures/question1/connectivity01.fig
figures/question1/connectivity02.fig
figures/question1/connectivity03.fig
figures/question1/connectivity04.fig
figures/question1/connectivity05.fig

Plots for question 1 b, c (raster plot of firings and mean firing rate)

figures/question1/raster_plot_mean_firing_probability_0.fig
figures/question1/raster_plot_mean_firing_probability_0.1.fig
figures/question1/raster_plot_mean_firing_probability_0.2.fig
figures/question1/raster_plot_mean_firing_probability_0.3.fig
figures/question1/raster_plot_mean_firing_probability_0.4.fig
figures/question1/raster_plot_mean_firing_probability_0.5.fig

Question 2:

To generate the plot for question 2 run Question2.m
This will run a modular network constructed with a random probability between 0 and 0.5 for 60 seconds
and repeat this procedure 20 times. Then, for each run, the neural complexity of the network is calculated
and plotted. 

We actually took two approaches to this, one where the probabilities are selected randomly between 0 and 0.5
and the other approach where the probabilities are linearly distributed between 0 and 0.5.

Plot for question 2:

figures/question2/complexity_random.fig (random probabilities)
figures/question2/complexity_linear.fig (linearly distributed probabilities)