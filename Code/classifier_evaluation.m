%********************************************************%
% Keyword: 1. classifier combination test
% Author: Zheng Liu, Sharon Grundmann, Yan Zhu
% Data: 2019, 12th January
% Description:
% This is for doing classifier combanation test.
% The classfier feature is evaluated in feature_evaluation.m.
% Pick out three of best classifiers for both Scenario 1 and Scenario 2\
% Do combanition based on them within maxc, minc, meanc, prodc and votec
% Print out the error rate graph and decide which is the best
% end of note
%********************************************************%

%% We pick parzenc and knnc based on feature curve
W_1 = [parzenc knnc];
c_max_1 = W_1 * maxc;
c_min_1 = W_1 * minc;
c_mean_1 = W_1 * meanc;
c_prod_1 = W_1 * prodc;
c_median_1 = W_1 * medianc;
c_vote_1 = W_1 * votec;
%% test each combanation result for scenario 1
error_1_max = Tst_Data_1 * c_max_1(Trn_Data_1) * testc;
error_1_min = Tst_Data_1 * c_min_1(Trn_Data_1) * testc;
error_1_mean = Tst_Data_1 * c_mean_1(Trn_Data_1) * testc;
error_1_prod = Tst_Data_1 * c_prod_1(Trn_Data_1) * testc;
error_1_median = Tst_Data_1 * c_median_1(Trn_Data_1) * testc;
error_1_vote = Tst_Data_1 * c_vote_1(Trn_Data_1) * testc;
%% We pick parzenc and knnc based on feature curve
W_2 = [knnc ldc parzenc]; %parzenc fisherc 
c_max_2 = W_2 * maxc;
c_min_2 = W_2 * minc;
c_mean_2 = W_2 * meanc;
c_prod_2 = W_2 * prodc;
c_median_2 = W_2 * medianc;
c_vote_2 = W_2 * votec;
%% test each combanation result for scenario 2
error_2_max = Tst_Data_2 * c_max_2(Trn_Data_2) * testc;
error_2_min = Tst_Data_2 * c_min_2(Trn_Data_2) * testc;
error_2_mean = Tst_Data_2 * c_mean_2(Trn_Data_2) * testc;
error_2_prod = Tst_Data_2 * c_prod_2(Trn_Data_2) * testc;
error_2_median = Tst_Data_2 * c_median_2(Trn_Data_2) * testc;
error_2_vote = Tst_Data_2 * c_vote_2(Trn_Data_2) * testc;
%% 
error_nist_vote_1 = nist_eval('my_rep', Pca_Coeff_Snr_1 * Sel_Mapping_1 * c_vote_1(Trn_Data_1), 10);
error_nist_prod_1 = nist_eval('my_rep', Pca_Coeff_Snr_1 * Sel_Mapping_1 * c_prod_1(Trn_Data_1), 10);
error_nist_max_1 = nist_eval('my_rep', Pca_Coeff_Snr_1 * Sel_Mapping_1 * c_max_1(Trn_Data_1), 10);
error_nist_min_1 = nist_eval('my_rep', Pca_Coeff_Snr_1 * Sel_Mapping_1 * c_min_1(Trn_Data_1), 10);
error_nist_mean_1 = nist_eval('my_rep', Pca_Coeff_Snr_1 * Sel_Mapping_1 * c_mean_1(Trn_Data_1), 10);
error_nist_median_1 = nist_eval('my_rep', Pca_Coeff_Snr_1 * Sel_Mapping_1 * c_median_1(Trn_Data_1), 10);
%%
error_nist_vote_2 = nist_eval('my_rep', Pca_Coeff_Snr_2 * Sel_Mapping_2 * c_vote_2(Trn_Data_2), 10);
error_nist_prod_2 = nist_eval('my_rep', Pca_Coeff_Snr_2 * Sel_Mapping_2 * c_prod_2(Trn_Data_2), 10);
error_nist_max_2 = nist_eval('my_rep', Pca_Coeff_Snr_2 * Sel_Mapping_2 * c_max_2(Trn_Data_2), 10);
error_nist_min_2 = nist_eval('my_rep', Pca_Coeff_Snr_2 * Sel_Mapping_2 * c_min_2(Trn_Data_2), 10);
error_nist_mean_2 = nist_eval('my_rep', Pca_Coeff_Snr_2 * Sel_Mapping_2 * c_mean_2(Trn_Data_2), 10);
error_nist_median_2 = nist_eval('my_rep', Pca_Coeff_Snr_2 * Sel_Mapping_2 * c_median_2(Trn_Data_2), 10);