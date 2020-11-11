clear all;
close all;

[numJoints,coOrdinates,t]=readExcelFile('2014002_C5_02.xlsx');
RadarXDirec=0;
RadarYDirec=0;
RadarZDirec=0;
theta=0;
wavelength=0.045;
insertedPoints=40;

doppSignals=doppSigEqn(RadarXDirec,RadarYDirec,RadarZDirec,theta,wavelength,coOrdinates,insertedPoints,t);
pointsInBetween=length(doppSignals);
lengthTime=t(end);
T=lengthTime/pointsInBetween;
fs=1/T;
STFT_length=256;
overlap=158;
window=180;
dBcut=60;

doppSignals=doppSignals(:);
figure;
mySpectrogram(doppSignals,overlap,hamming(window),STFT_length,fs,lengthTime,dBcut);
