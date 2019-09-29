N = prmemory(128000000);
%%
% feature extraction and get extraction mapping %
Pca_Coeff_Snr_1 = pcam(Trn_Data_1_Raw, 0.95);
Pca_Coeff_Snr_2 = pcam(Trn_Data_2_Raw, 0.99);
% extract training data %
Trn_1_extracted = Trn_Data_1_Raw * Pca_Coeff_Snr_1;
Trn_2_extracted = Trn_Data_2_Raw * Pca_Coeff_Snr_2;
% extract testing data
Tst_1_extracted = Tst_Data_1_Raw * Pca_Coeff_Snr_1;
Tst_2_extracted = Tst_Data_2_Raw * Pca_Coeff_Snr_2;
%%
% for big data size
featnum_1 = [1:size(Trn_1_extracted, 2)];
mf_1 = max(featnum_1);
[Sel_Mapping_Eval_1, r_Eval_1] = featself(Trn_1_extracted,'eucl-m', mf_1);
featnum_1 = [1:size(Trn_1_extracted, 2)];
mf_1 = max(featnum_1);
Trn_1_Eval = Trn_1_extracted * Sel_Mapping_Eval_1;
Tst_1_Eval = Tst_1_extracted * Sel_Mapping_Eval_1;
e_1_1 = clevalf(Trn_1_Eval,ldc,featnum_1,[],1,Tst_1_Eval);
e_1_2 = clevalf(Trn_1_Eval,qdc,featnum_1,[],1,Tst_1_Eval);
e_1_3 = clevalf(Trn_1_Eval,fisherc,featnum_1,[],1,Tst_1_Eval);
e_1_4 = clevalf(Trn_1_Eval, parzenc,featnum_1,[],1,Tst_1_Eval);
e_1_5 = clevalf(Trn_1_Eval, nmc,featnum_1,[],1,Tst_1_Eval);
e_1_6 = clevalf(Trn_1_Eval,knnc,featnum_1,[],1,Tst_1_Eval);
%%
% to illustrate errors for the classifiers mentioned above on scenario 1
figure('Name','Feature Curve on large data size','NumberTitle','off');
plot(1:mf_1, e_1_1.error(1:mf_1), 'linewidth', 1);
hold on;
plot(1:mf_1, e_1_2.error(1:mf_1), 'linewidth', 1);
hold on;
plot(1:mf_1, e_1_3.error(1:mf_1), 'linewidth', 1);
hold on;
plot(1:mf_1, e_1_3.error(1:mf_1), 'linewidth', 1);
hold on;
plot(1:mf_1, e_1_4.error(1:mf_1), 'linewidth', 1);
hold on;
plot(1:mf_1, e_1_5.error(1:mf_1), 'linewidth', 1);
hold on;
plot(1:mf_1, e_1_6.error(1:mf_1), 'linewidth', 1);
legend({'ldc', 'qdc', 'fisherc', 'parzenc', 'nmc', 'knnc'});
% for small data size
%%
featnum_2 = [1:size(Trn_2_extracted, 2)];
mf_2 = max(featnum_2);
[Sel_Mapping_Eval_2, r_Eval_2] = featself(Trn_2_extracted,'eucl-m', mf_2);
Trn_2_Eval = Trn_2_extracted * Sel_Mapping_Eval_2;
Tst_2_Eval = Tst_2_extracted * Sel_Mapping_Eval_2;
e_2_1 = clevalf(Trn_2_Eval, ldc,  featnum_2, [], 1, Tst_2_Eval);
e_2_2 = clevalf(Trn_2_Eval, qdc, featnum_2, [], 1, Tst_2_Eval);
e_2_3 = clevalf(Trn_2_Eval, fisherc, featnum_2, [], 1, Tst_2_Eval);
e_2_4 = clevalf(Trn_2_Eval, parzenc, featnum_2, [], 1, Tst_2_Eval);
e_2_5 = clevalf(Trn_2_Eval, nmc, featnum_2, [], 1, Tst_2_Eval);
e_2_6 = clevalf(Trn_2_Eval, knnc, featnum_2, [], 1, Tst_2_Eval);
%%
% to illustrate errors for the classifiers mentioned above on scenario 2
figure('Name','Feature Curve on small data size','NumberTitle','off');
plot(1:mf_2, e_2_1.error(1:mf_2), 'linewidth', 1);
hold on;
plot(1:mf_2, e_2_2.error(1:mf_2), 'linewidth', 1);
hold on;
plot(1:mf_2, e_2_3.error(1:mf_2), 'linewidth', 1);
hold on;
plot(1:mf_2, e_2_4.error(1:mf_2), 'linewidth', 1);
hold on;
plot(1:mf_2, e_2_5.error(1:mf_2), 'linewidth', 1);
hold on;
plot(1:mf_2, e_2_6.error(1:mf_2), 'linewidth', 1);
hold on;
legend({'ldc', 'qdc', 'fisherc', 'parzenc', 'nmc', 'knnc'});
%%
% After reaching feature curve, I obtained the optimal range of features,
% decide to use optm_1=30 and optm_2=30 for scenario 1 and 2 respectively
optm_1 = 50; % with knnc and parzenc
optm_2 = 55; % with knnc, parzenc and ldc
% feature selection
[Sel_Mapping_1, r_1] = Trn_1_extracted * featself('eucl-m', optm_1);
[Sel_Mapping_2, r_2] = Trn_2_extracted * featself('eucl-m', optm_2);
% these are the final training data
Trn_Data_1 = Trn_1_extracted * Sel_Mapping_1;
Trn_Data_2 = Trn_2_extracted * Sel_Mapping_2;
Tst_Data_1 = Tst_1_extracted * Sel_Mapping_1;
Tst_Data_2 = Tst_2_extracted * Sel_Mapping_2;