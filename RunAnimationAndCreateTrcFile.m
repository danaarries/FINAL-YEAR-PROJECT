function data = RunAnimationAndCreateTrcFile(file,type,osim_model)

% This function will create the appropriate files to run an OpenSim
% simulation sequence for MU walking data - use example model and data in
% Models\MU2392

clc

if nargin<3
% change this path to path where model and model files exist
osim_path = 'C:\Users\dkarr\OneDrive\Desktop\EEE4022S\Implementation\';
% define the model name - the task files etc must start with the same name
model = 'MU2392';
else [osim_path, model, ~] = fileparts(osim_model);
    osim_path = [osim_path '\'];
end

if nargin < 2
    type = 'dynamic';
end

if nargin < 1
    [fname, pname] = uigetfile('*.c3d', 'Select C3D file');
else
    if isempty(fileparts(file))
        pname = cd;
        pname = [pname '/'];
        fname = file;
    else [pname, name, ext] = fileparts(file);
        pname = [pname '/'];
        fname = [name ext];
    end
end

if strfind(lower(fname),'static')
    type = 'static';
else type = 'dynamic';
end
    
cd (pname);

% load the c3d file using BTK
data = btk_loadc3d([pname, fname], 10);

% IMPORTANT: A STATIC TRIAL MUST FIRST BE ANALYSED AND THIS FILENAME MUST
% CONTAIN THE STRING 'static' or 'cal'. IF THIS FILE EXISTS AND IS SELECTED
% THE STATIC TRIAL IS ANALYSED TO SCALE THE MODEL (ELSE STATEMENT BELOW).
% IF A DYNAMIC TRIAL IS SELECTED THE SCALED MODEL MUST ALREADY EXIST SO THE
% MODEL CAN RUN CORRECTLY (IF STATEMENT BELOW).
if strcmp(type,'dynamic')
    
    %find when feet are on each forceplate and define the trial events as
    %the first foot contact and the final foot contact
    E = [];
    for i = 1:length(data.fp_data.GRF_data)
        clear a
        a = find(data.fp_data.GRF_data(i).F(:,3) > 0.01*max(data.fp_data.GRF_data(i).F(:,3)));
        if ~isempty(a)
            P = round((a(1)*data.marker_data.Info.frequency/data.fp_data.Info(i).frequency)):round((a(end)*data.marker_data.Info.frequency/data.fp_data.Info(i).frequency));
            E(1) = min([min(E) P(1)]);
            E(2) = max([max(E) P(end)]);
        end
    end     
    
    % define start and end frame from the events to write the appropriate TRC
    % and MOT files for the OpenSim simulations
    data.Start_Frame = E(1)+20;
    data.End_Frame = E(2)-20;

    % now do conversions to TRC files using btk_c3d2trc
    data = btk_c3d2trc(data,'on');    % change to 'off' to turn animation off
end
