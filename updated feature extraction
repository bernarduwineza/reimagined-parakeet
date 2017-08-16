clc; close all; clear all;

tic 

L=1024;     %Image dimensions
n=8;        %Stride length

currentDir = '/home/buwienza/vcFiler/dresden_spliced';      %Define the current directory being used
%rgbFiles = fullfile(currentDir, '*_rgb.png');   %Define the pattern of rgb files in the directory
%maskFiles = ;  %Pattern of mask files 
rgbFiles = dir(fullfile(currentDir, '*_rgb.png')); % List of rgb images in the directory
maskFiles = dir(fullfile(currentDir, '*_mask.png')); % Masks

mkdir('dresden_ftrs');      %Directory in which to save features

 for k = 1: 5 %length(pngFiles)

    
	baseFileName_rgb = rgbFiles(k).name;        %Obtain the individual names of the rgb files
	fullFileName_rgb = fullfile(currentDir, baseFileName_rgb);      %Construct the full file names of the rgb files
    
    baseFileName_mask = maskFiles(k).name;        %Obtain the individual names of the mask files
    fullFileName_mask = fullfile (currentDir, baseFileName_mask);  
    
    I_rgb = imread(fullFileName_rgb);
%     I=imread('C:\File Transfer\WorkStation\Joshua Tree\The-Arch-Rock.jpg');

    I_mask = imread (fullFileName_mask);

I_rgb=imresize(I_rgb, [L L]);       %Resize the image
    I1=I_rgb;
    I_rgb=rgb2gray(I_rgb);

    F=zeros(L,L,4);     

    D=zeros(size(I_rgb));
    
    M=size(I_rgb,1)/n;
    for i=1:M 
        for j=1:M
            D(((i-1)*n+1):((i-1)*n+n),((j-1)*n+1):((j-1)*n+n)) = dct2(I_rgb(((i-1)*n+1):((i-1)*n+n),((j-1)*n+1):((j-1)*n+n)));
        end
    end
    
         F(:,:,1:3)=(I1);       %Make first three channels RGB values of the image
         F(:,:,4)=D;            % Make the fourth channel DCT features 
         
         A = zeros (10, 1024, 1024, 4);
         A (k,:,:,:) = F;
     
%         [folderName, name, ~] = fileparts(fullFileName);

        [~,filename,ext] = fileparts(fullFileName_rgb);         %Get file names
        newFileName = sprintf ('%s_dct%s',filename,'mat');          %Generate new file name 
        destFileName = fullfile('/home/buwienza/vcFiler/dresden_ftrs', newFileName);
%         imwrite (F, destFileName);     %Write the extracted feature files to destiantion folder

    save (destFileName,'A', 'I_mask');    % Save Features and Ground Truth to an image
           
        
         
        
%     figure; imshow(I)
%     figure; imshow(D)

end 

disp ('Feature extraction complete.'); 

   
toc
