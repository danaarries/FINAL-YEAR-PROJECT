clear all;
close all;

%  Add the "Datasets" folder to the Path, with subfolders  
% -------------------------------------------------------
%load('2020-09-08_16-07-30-602_trkdata.mat'); % Running 1: see test_example_number ..., 28,29,30,31,32,33, ...                                                 
%load('2020-09-08_15-58-37-370_trkdata'); % Running 2: see test_example_number ..., 30, 34, 39, ...  
%load('2020-09-08_10-22-09-359_trkdata'); % Walking 1: see test_example_number, ... 20, 21,22, ...
%load('2020-09-08_10-26-28-217_trkdata'); % Walking 2
load('2020-09-08_10-20-00-430_trkdata'); % Richard suggestion

%Extract data from struct
test_example_number = 22 ;%Variable to choose the example in the dataset- 10, 11 ,14 ,18 ,22 or 26 for Richards Suggestion
fs=trkdata(test_example_number).PRF;%Sampling frequency
test_example=double(trkdata(test_example_number).trk_data_real)+double(1i*trkdata(test_example_number).trk_data_imag);%Example doppler signal
class=char(trkdata(test_example_number).class);%Example class
%Corrections of class names for heading on spectrogram
if(strcmp(class,'2_walking'))
    class='2\_walking'; 
end
if(strcmp(class,'sphere_swing'))
    class='sphere\_swing'; 
end

RdrReceivedSignal=test_example;

% Compute spectrogram on the RdrReceivedSignal variable 
% -----------------------------------------------------
STFT_length=200;
overlap=87;
window=100;
dBcut=50;
T=1/fs;
NumSamples=length(RdrReceivedSignal);
lengthTime=NumSamples*T;

load('highpass.mat');
RdrReceivedSignal=conv(RdrReceivedSignal,highpass,'same');
figure;
mySpectrogram(RdrReceivedSignal,overlap,hamming(window),STFT_length,fs,lengthTime,dBcut);
 

