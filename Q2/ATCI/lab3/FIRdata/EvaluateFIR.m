error = 0;
for i = 1:5
   results = load(['Results_fold' num2str(i)]);
   error = error + results.error;
end

error_avg = error / 5;