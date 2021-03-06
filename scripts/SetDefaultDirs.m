% SetDefaultDirs sets the default directories
% 
% 2013-09-24 Matteo Carandini
% 2013-10-10 AS: line 44 & 47, corrected the variable name

% Did I screw up anything? If so, please see the older version at
% \\zserver.ioo.ucl.ac.uk\Code\Archive\Spikes\Spikes 2013-09-24
% and let me know... Thanks 
% Matteo

% At some point we may want to use IP addresses to determine if we are at
% Rockefeller or at Bath Street. If the former, we should probably use
% zcloneX instead of zserverX. A method to determine IP address is:
% address = java.net.InetAddress.getLocalHost 
% IPaddress = char(address.getHostAddress)

global DIRS serverName serverName server3Name

if isunix 
    
    serverName    = '/mnt/zserver';
    
    DIRS.Temp      = '/tmp';
else   
    
    serverName     = '\\zserver.cortexlab.net';
%     serverName     = '\\zclone.cortexlab.net';
    
    if isdir('D:\Temp')
        DIRS.Temp       = 'D:\Temp'; 
    else
        DIRS.Temp       = 'C:\Windows\Temp'; 
    end
    
end

if ~isdir(fullfile(serverName,'Data'))
    fprintf('Make sure directory %s is accessible!\n',fullfile(serverName,'Data'));
end

DIRS.data           = fullfile(serverName,'Data','trodes');
DIRS.spikes         = fullfile(serverName,'Data','Spikes');
DIRS.camera         = fullfile(serverName,'Data','Intrinsic');
DIRS.Intrinsic      = fullfile(serverName,'Data','Intrinsic');
DIRS.EyeCamera      = fullfile(serverName,'Data','EyeCamera'); 
DIRS.EyeTrack       = fullfile(serverName,'Data','EyeTrack');
DIRS.xfiles         = fullfile(serverName,'Data','xfiles');
DIRS.michigan       = fullfile(serverName,'Data','michigan');
DIRS.Cerebus        = fullfile(serverName,'Data','Cerebus');
DIRS.stimInfo       = fullfile(serverName,'Data','stimInfo');
DIRS.behavior       = fullfile(serverName,'Data','behavior');
DIRS.mouselogs      = fullfile(serverName,'Data','logs','mouse','behavior');
DIRS.multichanspikes= fullfile(serverName,'Data','multichanspikes');
DIRS.ball           = fullfile(serverName,'Data','ball');
DIRS.Stacks         = fullfile(serverName,'Data','Stacks');
DIRS.expInfo        = fullfile(serverName,'Data','expInfo');
DIRS.data2p        = fullfile(serverName,'Lab','Share','jul_mik');