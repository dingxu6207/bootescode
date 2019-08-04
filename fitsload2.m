function [header,data] = fitsload2(name,irecreq)
% FITSLOAD2 Loads some images (data and header) in FITS format.
% 
% This is a version of "fitsload" that I modified to read the 
% TRMM VIRS FITS-format fire files.  Todd Mitchell, September 2003.
%
%  The original script was by Peter Rydesäter (Peter.Rydesater@ite.mh.se).
%  ftp://ftp.mathworks.com/pub/contrib/v5/image/fits_toolbox/
%
%   [header, im] = fitsload2(name, irecreq )
% 
% Arguments:
% name              File name
% irecreq           (Optional) data record number to read.  Default is 1.
%                   A FITS format file consists of "header and data units"
%                   (HDUs) which can consist of both a header and data.
%                   For the TRMM VIRS data, the first HDU (irecreq=1)
%                   is metadata, and contains no data that you can map.
%                   The subsequent TRMM VIRS HDUs are metadata and mappable
%                   digital values.
%
% Return values:
% header            Header
% im                An image.  Blanks have been replace with NaN.
%                   The image is returned as a row vector.  Information
%                   in the header will tell you the number of latitude
%                   longitude points in a map, usually NAXIS1 and NAXIS2.
%                   It's a little confusing.  Read a header to figure it out.
%                   The header may also include scaling and units information.
%
%
%*****************************************************************************
  
  header={};
  data=[];
  
  if nargin==1; irecreq=1; end

  [fid] = fopen(name,'r','ieee-be');
  if (fid == -1),
    disp('Can´t find/open fits file.');
    return;
  end
  
% ---------------------------------------------------------------------------
% The following reading the header and reading the data sequence is repeated.

for irecord = 1: irecreq
disp( sprintf( 'Record %d', irecord ) );

  i=1;
  reststr='';
  header='';
  while feof(fid)==0,
    %Do not read if their is new line in existing buffert.
    s =[reststr,char(fread(fid,[1 80-length(reststr)],'uchar'))];
    if strncmp(s,'END ',4) == 1,
      fseek(fid,2880-mod(ftell(fid),2880),0);
      % To start of next 2880 block.
      break;
    end
    if strncmp(s,[char(10),'END',char(10)],5) == 1,
      fseek(fid,-(80-5),0);
      % To start of next 2880 block.
      break;
    end
    [s,reststr]=strtok(s,char(10));
    [a,b]=strtok(s,'=');
    header=strvcat(header,sprintf('%-8s=%s',deblank(a),deblank(b([2:end]))));
    i=i+1;
  end
  
  header=strvcat(header,blanks(80));
  header=header(1:end-1,:);
  
% The default is that the first record is just metadata, and no mappable 
% data.

if irecord>1   % Process the mappable-data.

% For the TRMM VIRS data, the extension name is the variable name.
temp = strmatch('EXTNAME',header(1:end-1,1:7),'exact');
if irecord==irecreq
header(temp,:)   
end

% Figure out the dimensions of the mappable-data.
if ~isempty(strmatch('NAXIS1',header(1:end-1,1:6),'exact'))
temp = strmatch('NAXIS1',header(1:end-1,1:6),'exact');
nx=str2num(header(temp,28:30));
end
if ~isempty(strmatch('NAXIS2',header(1:end-1,1:6),'exact'))
temp = strmatch('NAXIS2',header(1:end-1,1:6),'exact');
ny=str2num(header(temp,28:30));
else
ny = 1;
end
% disp( sprintf( 'nx, ny: %d %d', nx, ny ) );

% If it exists, figure out the missing value flag.
if ~isempty(strmatch('BLANK',header(1:end-1,1:5),'exact'))
temp = strmatch('BLANK',header(1:end-1,1:5),'exact');
blank=str2num(header(temp,28:30));
% disp( sprintf( '%d is missing value.  Set to NaN.', blank ) );
end

% Determine the variable type (integer, float, precision, ...)
temp = strmatch('BITPIX',header(1:end-1,1:6),'exact');
% header(temp,:)
bitpix=str2num(header(temp,28:30));
% disp( sprintf( 'bitpix is %d', bitpix ) );

  switch bitpix
  case 8,   datatype='uchar';
  case 16,  datatype='int16';
  case 32,  datatype='int32';
  case 64,  datatype='int64';          % Not exists in standard!!??
  case -32, datatype='float32';
  case -64, datatype='float64';
  end
  
  datatypesize=abs(bitpix)/8;

  data=fread(fid,nx*ny,datatype);
  data(data==blank) = NaN;

end  % End of process the mappable-data section.
end

  fclose(fid);
  return;



