function doppSignals=doppSigEqn(RadarX,RadarY,RadarZ,theta,wavelength,coOrdinates,insertedPoints,t)

RightUpperLeg=[3,4,16,17,18]; % 0.05623413
LeftUpperLeg=[1,2,5,6,7];     % 0.05623413

RightLowerLeg=[19,20,21,22]; % 0.0316227
LeftLowerLeg=[8,9,10,11];    % 0.0316227

RightFoot=[23,24,25,26];     % 0.01
LeftFoot=[12,13,14,15];      % 0.01

UpperLeftArm=[31,32,33,34,37];   % 0.1
UpperRightArm=[42,43,44,45,48];  % 0.1

LowerLeftArm=[35,36,38,39,40,41];  % 0.05623413
LowerRightArm=[46,47,49,50,51,52]; % 0.05623413

Head=[27,30];   % 0.1
Torso=[28,29];  % 1

BodyParts={[RightUpperLeg],[LeftUpperLeg],[RightLowerLeg],[LeftLowerLeg],[RightFoot],[LeftFoot],[UpperLeftArm],[UpperRightArm],[LowerLeftArm],[LowerRightArm],[Head],[Torso]};
Amplitude=[0.05623413,0.05623413,0.0316227,0.0316227,0.01,0.01,0.1,0.1,0.05623413,0.05623413,0.1,1];

m=1;
test =coOrdinates(:,[m,m+1,m+2]);
tester=test(:,1);
tester=insertPoints(tester,insertedPoints);
doppSigLen=length(tester);

doppSignals=zeros(doppSigLen,1);

dopp=zeros(doppSigLen,1);

numBodyParts=length(BodyParts);

for i=1:numBodyParts
    part=BodyParts{i};
  for w=1:length(part)  
      j=3*((part(w)-1))+1;
      joint =coOrdinates(:,[j,j+1,j+2]);
      x=joint(:,1);
      y=joint(:,2);
      z=joint(:,3);

      x=insertPoints(x, insertedPoints);
      y=insertPoints(y, insertedPoints);
      z=insertPoints(z, insertedPoints);

%Create array for input to spectrograms
    
    for k= 1:length(x)
        R=sqrt((x(k)-RadarX)^2)+((y(k)-RadarY)^2)+((z(k)-RadarZ)^2); % Range from radar to scatter point at every instance in time with radar at (0,0,0)
        dopp(k,1)=((exp(1i*(theta-((4*pi/wavelength)*(R))))))+ dopp(k,1); % R=R0-mvT
    end
      dopp=(Amplitude(i))*dopp;
  end
    doppSignals=dopp+doppSignals;
    dopp=zeros(length(x),1);
end

end 


