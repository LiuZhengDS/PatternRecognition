%********************************************************%
% Keyword: my_rep()
% Author: Zheng Liu, Sharon Grundmann, Yan Zhu
% Data: 2019, 11th January
% Description:
% This is for doing datapreprocessing.
% end of note
%********************************************************%

function [a] = my_rep(m)
Img = data2im(m); 
Lgth = length(m);
Labels = getlabels(m);
% resize the image (image operation)
Img_Oprt = im_box([],0,1)*im_resize([],[32 32])*im_box([],1,0);
Img_Oprt = Img * Img_Oprt;
ImgProcessed = [];
for i = 1: Lgth    
    % reference MATLAB official guidence to use extractHOGFeatures
    % ww2.mathworks.cn/help/vision/examples/digit-classification-using-hog-features.html
    Hog(i,:) = extractHOGFeatures(Img_Oprt{i},'CellSize',[8 8]);
    ImgDouble_Hog{i} = im2double(Hog(i,:));
    ImgVector_Hog{i} = ImgDouble_Hog{i};
    ImgProcessed_Hog(i,:) = ImgVector_Hog{i}'
    ImgDouble_Pixel{i} = im2double(Img_Oprt{i});
    ImgVector_Pixel{i} = ImgDouble_Pixel{i}(:);
    ImgProcessed_Pixel(:,i) = squeeze(ImgVector_Pixel{i});
    ImgProcessed(i,:) = cat(2,ImgProcessed_Hog(i,:), ImgProcessed_Pixel(:,i)')
end
DataProcessed = prdataset(ImgProcessed,Labels);
a = DataProcessed;
end