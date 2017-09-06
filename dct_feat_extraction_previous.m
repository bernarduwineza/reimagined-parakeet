clc; close all; clear all;
%% create image id, then access image followed by mask
% s=rgbFiles(k).name
% % image_Id=strrep(s,'_rgb.png','')
% % t1=strcat(image_Id,'_rgb.png')
% % t2=strcat(image_Id,'_mask.png')
%  I=imread(strcat(currentDir,t1));
%  I_mask=imread(strcat(currentDir,t2));
%%

tic 

L=1024;     %Image dimensions
n=8;        %Stride 

currentDir = '/home/buwienza/KittiSeg/DATA/data_road/training/image_2';      %Define the current directory being used
%rgbFiles = fullfile(currentDir, '*_rgb.png');   %Define the pattern of rgb files in the directory
%maskFiles = ;  %Pattern of mask files 
rgbFiles = dir(fullfile(currentDir, '*.png')); % List of rgb images in the directory
%maskFiles = dir(fullfile(currentDir, '*_mask.png')); % Masks

%mkdir('dresden_ftrs');      %Directory in which to save features
N = 2; %length(rgbFiles);
F=zeros(L,L,4); 

 feat = zeros (N, 1024, 1024, 4); 
 %mask = zeros (N, 1024, 1024);
 
 

 for k = 1: N %length(pngFiles)    
    disp(sprintf('dct features is extracting for image nb..%d',k))
    I_rgb = imread(strcat(currentDir,'/',rgbFiles(k).name));
%     I=imread('C:\File Transfer\WorkStation\Joshua Tree\The-Arch-Rock.jpg');

    %I_mask = imread (fullFileName_mask);

    I_rgb=imresize(I_rgb, [L L]);       %Resize the image
    I1=I_rgb;
    I_gray=rgb2gray(I_rgb);

%     F=zeros(L,L,4);     

    D=zeros(size(I_gray));
    
    M=size(I_gray,1)/n;
    for i=1:M 
        for j=1:M
            D(((i-1)*n+1):((i-1)*n+n),((j-1)*n+1):((j-1)*n+n)) = dct2(I_gray(((i-1)*n+1):((i-1)*n+n),((j-1)*n+1):((j-1)*n+n)));
        end
    end
    
         F(:,:,1:3)=(I1);       %Make first three channels RGB values of the image
         F(:,:,4)=D;            % Make the fourth channel DCT features 
         
%          feat = zeros (10, 1024, 1024, 4);
%          mask = zeros (10, 1024, 1024);
%          
         feat (k,:,:,:) = F;
         %mask (k,:,:) = I_mask; 
     
%         [folderName, name, ~] = fileparts(fullFileName);

       

end 

disp ('Feature extraction complete.'); 
save('features.mat','feat');
   
toc
