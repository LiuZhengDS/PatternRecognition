%********************************************************%
% Keyword: 1. Scenario 1 test 2. Scenario 2 test
% Author: Zheng Liu, Sharon Grundmann, Yan Zhu
% Data: 2019, 12th January
% Description:
% This is for doing scenario 1 and 2 testing.
% The classfier are trained in classifier_evaluation.m.
% load 'Group30.mat' for checking!!!
% running 5000 objects is time consuming!!!
% end of note
%********************************************************%

%%
% This file is for scenario 1 and scenario 2 test %
% It include
addpath('prdatasets');
addpath('coursedata');
addpath('prtools'); 
% Code below is for original data access.
% !!! for checking our result, do not run those part, it is time consuming
% but load our obtained 'Group_30.mat' result
% it contains every variable related with our code
load('Group30.mat');

%%
% set target objects from 0-9
num_min = 0;
num_max = 9;
% set 800 training objects per class for scenario 1
n_1_min = 1;
n_1_max = 1000;
n_1_distance = 2;
% set 10 training objects per class for scenario 2
n_2_min = 1;
n_2_max = 10;
n_2_distance = 100;
% set 200 testing objects per class for both scenario 1 and scenario 2
% take 1000 objects per class as training set, and
% take the other 20 objects per class as test set
Snr_1_Input = prnist([num_min: num_max], [n_1_min:n_1_distance:n_1_max]);
Snr_2_Input = prnist([num_min: num_max], [n_2_min: n_2_max]);
% use my_rep() function % 
% preprocess training and testing data for both scenario %
Snr_1_Data = my_rep(Snr_1_Input);
Snr_2_Data = my_rep(Snr_2_Input);
% traning set and testing set split %
[Trn_Data_1_Raw, Tst_Data_1_Raw] = gendat(Snr_1_Data, 0.8);
[Trn_Data_2_Raw, Tst_Data_2_Raw] = gendat(Snr_2_Data, 0.8);










