%********************************************************%
% Keyword: 1. image cut, 2. transfer into prdataset
% Author: Zheng Liu, Sharon Grundmann, Zhu Yan
% Data: 2019, 13th January, Yan Zhu
% Description:
% This is for doing hand written picture cut and preprocessing
% The first for loop: 
% read a 10-by-10 hand written digits picture 
% and cut them into 100 '.jpg' files 
% The second loop does the same thing as my_rep() 
% it does the preprocessing and tranfer pictures into prdataset 
% With the data processed here, 
% live_test.m gives the code to test the result 
% it is possible to run live tes_test.m only after running this
% end of note
%********************************************************%

%% read the file and make a folder to store the data
Img_Live = imread('digits.jpg');
mkdir digits
[x, y, z] = size(Img_Live); % obtain seize of 'digits.jpg'
% we use the very regular grid to write digits % 
% so each aixs can be splited ideally eqauly % 
x_unit = floor(x / 10);
y_unit = floor(y / 10);
figure('Name','Hand Written Digits','NumberTitle','off');
for i = 0:9
    for j = 0:9
    Img_Cut = Img_Live(1+j*x_unit:x_unit*(j+1), 1+i*y_unit:y_unit*(i+1),:);
    imshow(Img_Cut);
    str0 = 'digits/'; % set up the path of cut images
    str1 = strcat(num2str(j+i*10)); % name of the splited image
    str2 = '.jpg';
    save_path=[str0,str1,str2];
    imwrite(Img_Cut, save_path); % write images into the path
    end
end % end of generating splited image files

% generate image labels and tranfer them into prdataset%
Img_Split = dir(strcat('digits/','*.jpg'));
Leng_Files = length(Img_Split); % set the for loop size
Img_Split_Label=[]; % initialise label
Img_Processed =[]; % initialise processed prdataset
%%
for i = 1: Leng_Files
    Digits = strcat(num2str(i-1),'.jpg');
    Img_Ori = imread(strcat('digits/',Digits));
    % rgb2gray is to transfer 3D(x,y,z(RGB)) into 2D(x,y)
    Img_Gray = rgb2gray(Img_Ori); 
    Img_Binary = im2bw(Img_Gray); % Binarisation
    % tranfer into black background and white digit
    Img_Binary = ~Img_Binary;
    % make the digit wider to match
    BW2=imdilate(~Img_Gray,ones(3));
    Img_Binary = BW2;
    % transfer data from logical into double
    Img_Double = im2double(Img_Binary);
    Img_Double=imdilate(Img_Double,ones(3));
    imshow(Img_Double);
    % Same operation like my_rep() S1 and S2, 
    % resize the image
    %%
    ImgOprt = im_resize([],[34 34]);
    Img_Live_Oprt = Img_Double * ImgOprt;
    Img_Live_Oprt=imdilate(Img_Live_Oprt,ones(1));
    imshow(Img_Live_Oprt);
    Img_Double = Img_Live_Oprt;
    imshow(Img_Double);
    Hog(i,:) = extractHOGFeatures(Img_Double,'CellSize',[8 8]);
    ImgVector_Hog = double(Hog(i,:));
    ImgProcessed_Hog(i,:) = ImgVector_Hog;
    ImgDouble_Pixel = im2double(Img_Live_Oprt);
    ImgVector_Pixel = ImgDouble_Pixel(:);
    Img_Processed_Pixel(:,i) = squeeze(ImgVector_Pixel);
    Img_Processed(i,:) = cat(2,ImgProcessed_Hog(i,:), Img_Processed_Pixel(:,i)')
    Img_Split_Label = [Img_Split_Label;strcat('digit_',num2str(mod(i-1,10)))];
end
%% use prdataset to combine feature (pixel) vector with labels
Tst_Live = prdataset(Img_Processed, Img_Split_Label);







