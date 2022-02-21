
function MLE_SetRandomSeed (RandomSeed);

%----------------------------------

rand('state',RandomSeed);   %%% Seed for uniform random distribution
randn('state',RandomSeed);  %%% Seed for normal random distribution

%----------------------------------
