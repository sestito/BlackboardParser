function mfinfo = mfileread(file)
%MFINFO = MFILEREAD(filename);
%
% MFILEREAD reads an m-file and returns its code and comment part
%
% More specifically, it returns a struct MFINFO with the fields
% FILENAME  .. name of m-file
% LINECOUNT .. the number of non-empty lines in the m-file
% TEXT .. compact representation of whole text line by line, excluding empty lines
% CODE .. compact representation of code only
% COMMENT .. compact representation of comments only

% Comments are identified as the part of text after the first %-character which is not part of string
%
% (c) 19-12-2010, Mathias Benedek


code = '';
comm = '';
mtext = '';
linecount = 0;

fid = fopen(file);
while 1
    tline = fgets(fid);

    if ~ischar(tline),   break,   end
    tline = strtrim(tline);

    % DJW: ignore lines that should be unique per student anyway
    if contains(tline, {'name', 'id', 'email'})
        continue
    end

    if ~isempty(tline)
        linecount = linecount+1;
        mtext = [mtext, tline, char(13)];

        % Find first percent sign that is not part of string
        pcts_idx = strfind(tline,'%');
        if pcts_idx

            comm_idx = length(tline);
            for ii = pcts_idx
                c_idx = strfind(tline(1:ii),'''');
                if mod(length(c_idx),2) == 0  % even number of ' -characters
                    comm_idx = ii;
                    break;
                end
            end

            % Divide line into code and comment part
            if comm_idx > 1
                code = [code, strtrim(tline(1:comm_idx-1)), char(13)];
            end
            if comm_idx < length(tline);
                comm = [comm, strtrim(tline(comm_idx+1:end)), char(13)];
            end
        else
            code = [code, tline, char(13)];
        end

    end

end
fclose(fid);

mfinfo.filename = file;
mfinfo.linecount = linecount;
mfinfo.text = strtrim(mtext);     %sttrim here removes final newline
mfinfo.code = strtrim(code);
mfinfo.comment = strtrim(comm);

