data {
  int<lower=0> N;
  int<lower=0> N_trt;
  int<lower=0> N_week;
  int<lower=0> trt_ind[N];
  int<lower=0> week_ind[N];
  vector[N] y;
}

parameters {
  real mu[N_trt, N_week];
  real<lower=0> sigma[N_trt, N_week];
}

model {
  for (i in 1:N_trt) {
    for (j in 1:N_week) {
      mu[i, j] ~ normal(0, 1);
      sigma[i, j] ~ exponential(10);
    }
  }
  for (i in 1:N) {
    y[i] ~ normal(mu[trt_ind[i], week_ind[i]], sigma[trt_ind[i], week_ind[i]]);
  }
}

generated quantities {
  real mu_diff[N_week];
  for ( i in 1:N_week ) {
    mu_diff[i] = mu[2, i] - mu[1, i];
  }
}
