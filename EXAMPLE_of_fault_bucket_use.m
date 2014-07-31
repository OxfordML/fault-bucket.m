clear;
clf;

% generate some data
N = 500; % number of data
xn = (1:N)'; % input variables e.g. time
yn = sin(xn/10) + sqrt(xn/10); % true, latent, signal
y = yn + normrnd(zeros(N, 1), 0.04 * ones(N, 1)); % noisy observations
% introduce some faults
y(round(38/50*N)) = yn(round(38/50*N)) + 1;
y(round(40/50*N)) = yn(round(40/50*N)) - 1;
y(round(47/50*N)) = yn(round(47/50*N)) - 1;


% define length of time-series window
params.window_length = 200;

% number of time-steps to lookahead
params.lookahead = 1;

% the prior probability that a given observation will be faulty
params.fault_prior = 0.1;


% x, y
%     x and y are the observations used in testing: note that the first portion
%     of data is reserved for training, and hence are not tested on.
% xstars
%     x values predicted for
% predictive_means, predictive_variances
%      predictions for y
% fault_post
%      posterior of faultiness
% mean_fault_sd
%      posterior for the fault standard deviation
% mean_norm_sd
%      posterior for the normal standard deviation

% invoke fault bucket.
[...
    x, y, ...
    xstars, ...
    predictive_means, predictive_variances, ...
    fault_post, ...
    mean_fault_sd, ...
    mean_norm_sd ...
] = fault_bucket(xn, y, params);

% plot predictions

gp_plot(xstars, predictive_means, sqrt(predictive_variances), x, y)


% plot ground truth
hold on; plot(xn,yn,'-.r');
