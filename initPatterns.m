%%%%%%%%%%%%%%% Begin initPatterns.m %%%%%%%%%%%%%% 
% Copy and paste this section of the code into an m-file called initPatterns.m 
% that will load in the training patterns and test patterns. 
% The input training patterns represent input from 28 users for our 12 movies.  
% Each row below is one training pattern consisting of one user’s ratings, but in the
% last line we transpose the matrix  so that now each column is one training pattern.
% The final element of each training pattern is a ‘1’ representing the bias units’ output. 
trainingPatterns = ...
[1 1 1 0 0 0 0 0 0 1 0 0   1; ...
 1 1 1 0 0 0 1 0 0 0 0 0   1; ...
 1 1 0 1 0 0 0 0 0 0 0 0   1; ...
 0 1 1 0 1 0 0 0 0 0 0 0   1; ...
 1 1 1 0 0 0 0 0 0 0 1 0   1; ...
 1 0 1 0 0 1 0 0 1 0 0 1   1; ...
 1 1 1 0 0 0 0 1 0 0 0 0   1; ...
 1 0 0 1 1 1 0 0 0 0 0 0   1; ...
 0 0 1 1 0 1 0 0 0 0 0 0   1; ...
 0 0 0 1 1 0 1 0 0 0 0 0   1; ...
 0 0 0 0 1 1 0 0 1 0 0 1   1; ...
 0 1 0 1 1 1 0 1 0 0 1 0   1; ...
 0 0 0 0 1 1 0 0 0 1 0 0   1; ...
 0 1 0 1 1 0 0 1 0 0 0 0   1; ...
 0 0 0 1 0 0 1 1 1 0 0 0   1; ...
 0 0 0 0 0 0 1 0 1 0 0 1   1; ...
 0 1 0 0 0 0 1 1 0 0 0 0   1; ...
 0 0 0 0 1 0 0 1 1 0 0 0   1; ...
 0 0 0 0 0 0 1 1 1 0 1 0   1; ...
 0 0 0 0 0 0 1 0 1 0 0 0   1; ...
 0 0 1 0 0 0 1 1 0 0 0 0   1; ...
 0 0 0 0 1 0 0 0 0 1 1 1   1; ...
 0 1 0 0 0 0 1 0 0 1 0 1   1; ...
 0 0 0 1 0 0 0 0 0 1 1 0   1; ...
 1 0 0 0 0 0 0 0 0 0 1 1   1; ...
 0 0 0 0 0 1 0 0 1 1 1 1   1; ...
 0 0 1 0 0 0 0 0 0 1 0 1   1; ...
 0 0 0 0 0 0 0 1 0 1 1 0   1; ...
]';

testInputPatterns  = [...
 1 1 1 0 0 0 0 0 0 0 0 0 1;...
 0 0 0 1 1 1 0 0 0 0 0 0 1;...
 0 0 0 0 0 0 1 1 1 0 0 0 1;...
 0 0 0 0 0 0 0 0 0 1 1 1 1]';

testHiddenPatterns  = [...
 1 0 0 0 1;...
 0 1 0 0 1;...
 0 0 1 0 1;...
 0 0 0 1 1];

%%%%%%%%%%%%%%% end initPatterns.m %%%%%%%%%%%%%%%%%%%%
