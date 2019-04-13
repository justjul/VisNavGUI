function Spk = LoadSpk(Spkfilepath, sampleTimes, zerocorrection, Channels, clusterId)
load(Spkfilepath,'TempChans');
if ~iscell(TempChans)
    TempChans = {TempChans};
end
if nargin < 4
    Channels = 
end
%would be nice to also have the cluster properties saved in that file

%Selecting the requested cells as indicated by channel
icell = 0;
for iprobe = 1:numel(TempChans)
    if ~isnan(sum(Channels{iprobe}))
        for ichan = 1:length(TempChans{iprobe})
            if ismember(TempChans(ichan).ichan,Channels{iprobe})
                icell = icell + 1;
                Spk.spikeIDs{icell} = TempChans(ichan).id;
                Spk.chanIDs{icell} = TempChans(ichan).ichan;
                Spk.ProbeIDs{icell} = iprobe;
                Spk.spikeTimes{icell} = TempChans(ichan).spiketimes - zerocorrection;
                Spk.spikeTimes{icell}(Spk.spikeTimes{icell}<0) = [];
            end
        end
    end
end
samplerate = mean(diff(sampleTimes));
Spk.spikeTrain = zeros(length(sampleTimes), numel(Spk.spikeTimes));
for icell = 1:numel(Spk.spikeTimes)
    Spk.spikeTrain(:,icell) = histcounts(Spk.spikeTimes{icell},sampleTimes+samplerate/2);
end
Spk.mua = sum(Spk.spikeTrain,2);
end