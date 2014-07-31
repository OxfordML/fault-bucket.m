load sampling_period_fault.mat

hold on; plot(x,yn,'g'); plot(x,yf); hold off

good_data = ~isnan(yf);
yf = yf(good_data);
x = x(good_data);
xg = x;

params.training_window = 1:1000;

[x, y, xstars, predictive_means, predictive_variances, fault_post, ...
    mean_fault_sd, mean_norm_sd, hyper]   = fault_bucket(x, yf, params);

make_gp_plot(xstars, predictive_means, sqrt(predictive_variances), ...
 x, y, (1 - fault_post), ...
 [min(x) max(x) min(y) max(y)], 7, 'x', 'y', 'NorthWest', 45)

save sampling_period_fault_bucket.mat

hold on

plot(xg,yn(good_data),'-.r')


