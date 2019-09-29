%********************************************************%
% Keyword: 1. live test
% *** this is the following file of image cut.m ***
% *** it is necessary to run image cut.m firstly ***
% Author: Zheng Liu
% Data: 2019, 13th January
% Description:
% This is for doing hand written picture testing.
% The classfier used for scenario 1 is used here.
% end of note
%********************************************************%
%%
Tst_Live = Tst_Live * Pca_Coeff_Snr_1 * Sel_Mapping_1;
%%

error_live_max = Tst_Live * c_max_1(Trn_Data_1) * testc;
error_live_min = Tst_Live * c_min_1(Trn_Data_1) * testc;
error_live_mean = Tst_Live * c_mean_1(Trn_Data_1) * testc;
error_live_prod = Tst_Live * c_prod_1(Trn_Data_1) * testc;
error_live_median = Tst_Live * c_median_1(Trn_Data_1) * testc;
error_live_vote = Tst_Live * c_vote_1(Trn_Data_1) * testc;




