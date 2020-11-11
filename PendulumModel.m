%% Pendulum/Swinging Hand Animation
clear all;
close all;

%defining time array
t=linspace(0,5,100);

% defining pendulum equations in each direction- refer to equations of
% motion code for derivation of equations- values have changed slightly-

y=0*t;
z=-cos((pi*cos((3*109^(1/2)*t)/10))/10)+1;
x=0.1*(5-t)+sin((pi*cos((3*109^(1/2)*t)/10))/10)+0.35;

for k= 1:length(t)
    % wipe slate clean so plot with blank figure
    clf
    %extract data at the current time
    t_k=t(k);
    x_k=x(k);
    y_k=y(k);
    z_k=z(k);
    
    %plot current location of scatter point
    plot3(x_k,y_k,z_k,'r*','Linewidth',3,'MarkerSize',11)
    hold on
    % plot location of radar at position (0,0,0)
    plot3(0,0,0,'bd','Linewidth',2,'MarkerSize',10)
    
    %plot entire pendulum curve
    hold on
    plot3(x,y,z,'k','LineWidth',2)
    
    %plot labels and give title
    grid on 
    xlabel('x')
    ylabel('y')
    zlabel('z')
    title(['Particle at t=',num2str(t_k),'seconds.'])
    view([30, 35])
    
    %force image to draw the plot at this point;
    drawnow
end


%% Generating Data but with enough data points to compute spectrogram
t=linspace(0,5,80); %gives PRI of 0.0025
y=0*t;
z=-cos((pi*cos((3*109^(1/2)*t)/10))/10)+1;
x=0.1*(5-t)+sin((pi*cos((3*109^(1/2)*t)/10))/10)+0.35; 
x=x(:);
y=y(:);
z=z(:);
x=insertPoints(x,30);
y=insertPoints(y,30);
z=insertPoints(z,30);


xlen=length(x);
ylen=length(y);
zlen=length(z);


M=zlen; 
dopp=zeros(M,1);
%Create array for input to spectrograms
for k= 1:zlen
    
 R=sqrt((x(k)^2)+(y(k)^2)+(z(k)^2)); % Range from radar to scatter point at every instance in time with radar at (0,0,0)
 theta=0; % assumption
 wavelength=0.045; % this wavelength ensures C band frequencies
 A=1; % assumption
 dopp(k,1)=A*exp(1i*( theta-((4*pi/wavelength)*(R))) ); % R=R0-mvT
 
end
pointsInBetween=length(dopp);
seconds=t(end);
T=seconds/pointsInBetween;
fs=1/T;  
figure;
mySpectrogram(dopp,180,hamming(200),512,fs,5,60);

% RvS - Expected Doppler: fd = 2*vel/wavelength
figure;
t=linspace(0,5,pointsInBetween);
plot(t(1:end-1),-2*diff(sqrt(x.^2+y.^2+z.^2))./diff(t)./wavelength,'b');
xlabel('Time [s]');
grid on;
ylabel('Doppler frequency [Hz]')


