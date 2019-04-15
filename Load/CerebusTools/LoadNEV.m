function [tt,ww] = LoadNEV(animal, iseries, iexp)
%%

global DIRS

filename = fullfile( DIRS.Cerebus,animal,sprintf('u%03d_%03d.nev',iseries,iexp) );

fid = fopen(filename, 'r', 'ieee-le');
if fid == -1, 
    r = -1; % ----------------------- ??
    return;
end;

fseek(fid, 12, 'bof');
index.offset = fread(fid, 1, 'uint32');
index.packetlen = fread(fid, 1, 'uint32');

fseek(fid,index.offset+4,'bof');  %% because we are not reading timestamps
[ii,totnspikes] = fread(fid,inf,'uint16=>uint8',index.packetlen-2);

fseek(fid,index.offset,'bof');
tt = fread(fid,totnspikes,'uint32=>double',index.packetlen-4);  %% timestamp

% Do this only if you need the waveforms (takes a long time and lots of memory)
% ww = zeros(totnspikes,48,'int16');
% for isample = 1:48
%     fseek(fid,index.offset+6+2*(isample-1),'bof');
%     ww(:,isample) = fread(fid,totnspikes,'int16',index.packetlen-2);
% end
    
p = ProtocolLoad(animal,iseries,iexp);

SyncTimes = tt(ii==0)/30;

nrepeats = floor( length(SyncTimes)/2 / p.nstim );

TT1 = zeros(p.nstim,nrepeats);
TT2 = zeros(p.nstim,nrepeats);
for istim = 1:p.nstim
    for irepeat = 1:nrepeats
        ipres = p.seqnums(istim,irepeat);
        TT1(istim,irepeat) = SyncTimes(2*ipres-1);
        TT2(istim,irepeat) = SyncTimes(2*ipres+0);
    end
end

ne = max(ii);

SpikeTimes = cell(ne,1); % here it would make sense to go into stimuli and repeats
for ie = 1:ne
    TheseTimes = tt(ii==ie)/30;
    SpikeTimes{ie} = cell(p.nstim, nrepeats);
    for istim = 1:p.nstim
        for irepeat = 1:nrepeats
            SpikeTimes{ie}{istim,irepeat} = TheseTimes( TheseTimes>TT1(istim,irepeat) & TheseTimes<=TT2(istim,irepeat) );
        end
    end
end

%% Save the 'unit' structures

stimdurs = TT2 - TT1;

for ie = 1:ne
    unit = struct('animal', animal, 'ichan', ie+1000, 'icell', 999,'iseries', iseries,'iexp', iexp,...
        'stimdurs',stimdurs,'timestamp','','prototype',[],'neighborhood',[],'spiketimes',{SpikeTimes{ie}},...
        'datatype','spiketimes'); 
    UnitSave(unit,DIRS.spikes);
end

chanlist = chans+1000;




% % % sanity checks 
% 
% SpikeTimes = cell(ne,1); % here it would make sense to go into stimuli and repeats
% for ie = 1:ne
%     SpikeTimes{ie} = tt(ii==ie)/30;
% end
% 
% % nevopen(fullfile( DIRS.Cerebus,animal,sprintf('u%03d_%03d.nev',iseries,iexp)));
% % ie = 10;
% % [tt2, ww2] = nevwaves(ie);
% tt2 = tt2/30;
% 
% length(tt2)
% length(SpikeTimes{ie})
% 
% figure; plot( tt2, SpikeTimes{ie} )
% 
% e_ii = find(ii==ie);
% figure; 
% subplot(2,1,1);
% plot( ww(e_ii(1),:) );
% subplot(2,1,2);
% plot(ww2(:,1))





