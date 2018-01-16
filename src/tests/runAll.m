%% Runs all tests
results = runtests();
resultsTabulated = table(results);

%% Show failed and slower tests at the bottom
resultsTabulated = sortrows(resultsTabulated, {'Passed', 'Duration'}, {'descend', 'ascend'});
disp(resultsTabulated);