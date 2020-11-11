function SpecPlot=mySpectrogram(signal,overlap,win,nfft,fs,Length,dBrange) 

signal=signal(:);
winL=length(win); 
signal = [signal;zeros(winL-length(signal),1)];
winLodd = mod(winL,2); 
winLo2 = (winL-winLodd)/2;
window = win(:); % Make sure it's a column
hop = winL-overlap;

sigL = length(signal);
numBlocks = 1+ceil(length(signal)/hop);
numFrames=numBlocks;
Y=zeros(nfft,numFrames);
pads = zeros(nfft-winL,1); 
ySection = zeros(winL,1);
toffset = 0 - winLo2; % input time offset = half a frame- can change later 

for n=1:numFrames
  if toffset<0
    ySection(1:toffset+winL) = signal(1:toffset+winL); 
  else
    if toffset+winL > sigL
      ySection = [signal(toffset+1:sigL);zeros(toffset+winL-sigL,1)];
    else
      ySection = signal(toffset+1:toffset+winL); 
    end
  end
  winBlock = window .* ySection; 
  paddedBlock = [winBlock(winLo2+1:winL);pads;winBlock(1:winLo2)]; 
  Y(:,n) = fftshift(fft(paddedBlock,nfft));
  toffset = toffset + hop; 
end

SpecPlot=Y;
SpecPlot=10*log(abs(SpecPlot));
% Normalising 
Max_SpecPlot = max(max(SpecPlot)); 
bnds=[(Max_SpecPlot-dBrange),Max_SpecPlot];
ts=1/fs;
N = Length*fs;
t = (0:1:(N-1))*ts; 
f = (-floor(nfft/2):ceil(nfft/2)-1)*fs/nfft; 
imagesc(t,f,SpecPlot);
axis('xy');
colormap(jet(256));
caxis(bnds);
colorbar;
xlabel('Time (sec)');
ylabel('Freq (Hz)');
title('Spectrogram of Signal');

end

