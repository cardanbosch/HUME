function varargout = sleepStatsDBReport_sqlite(varargin)
% SLEEPSTATSDBREPORT_SQLITE MATLAB code for sleepStatsDBReport_sqlite.fig
%%   Copyright (c) 2016 Jared M. Saletin, PhD and Stephanie M. Greer, PhD
%
%   This file is part of H�m�.
%   
%   H�m� is free software: you can redistribute it and/or modify it
%   under the terms of the GNU General Public License as published by the
%   Free Software Foundation, either version 3 of the License, or (at your
%   option) any later version.
% 
%   H�m� is distributed in the hope that it will be useful, but
%   WITHOUT ANY WARRANTY; without even the implied warranty of
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
%   General Public License for more details.
% 
%   You should have received a copy of the GNU General Public License along
%   with H�m�.  If not, see <http://www.gnu.org/licenses/>.
%
%   H�m� is intended for research purposes only. Any commercial or medical
%   use of this software is prohibited. The authors accept no
%   responsibility for its use in this manner.
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help sleepStatsDBReport_sqlite

% Last Modified by GUIDE v2.5 09-Jul-2020 13:05:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @sleepStatsDBReport_sqlite_OpeningFcn, ...
    'gui_OutputFcn',  @sleepStatsDBReport_sqlite_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before sleepStatsDBReport_sqlite is made visible.
function sleepStatsDBReport_sqlite_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to sleepStatsDBReport_sqlite (see VARARGIN)

% Choose default command line output for sleepStatsDBReport_sqlite
handles.output = hObject;

if size(varargin, 2) == 2
    
    handles.conn = varargin{1};
    
    studiesOnRecord = fetch(handles.conn,['SELECT DISTINCT idStudy.study FROM EDFInfo JOIN idStudy ON EDFInfo.id = idStudy.id JOIN scoredInfo ON scoredInfo.EDFname = EDFInfo.EDFname']);
    if  strmatch(class(studiesOnRecord),'table')
        studiesOnRecord = table2cell(studiesOnRecord);
    end
    
    set(handles.studyList,'String',studiesOnRecord);
    
    %     idsOnRecord = fetch(handles.conn, ['SELECT DISTINCT EDFInfo.id FROM scoredInfo JOIN EDFInfo ON scoredInfo.EDFname = EDFInfo.EDFname;']);
    %     set(handles.idList, 'String', [idsOnRecord{:}]);
    
end

% Populate Study List
humepath = which('hume');
reportpath = dir(fullfile(fileparts(humepath), 'coreFunctions/sqlReports'));
reports = {reportpath.name}';

for i = 3:length(reports)
    handles.reportFuncs{i-2} = reports{i}(1:end-2);
    repName{i-2} = eval(handles.reportFuncs{i-2});
end
set(handles.templates,'String',repName);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes sleepStatsDBReport_sqlite wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = sleepStatsDBReport_sqlite_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in idList.
function idList_Callback(hObject, eventdata, handles)
% hObject    handle to idList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns idList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from idList


% --- Executes during object creation, after setting all properties.
function idList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to idList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in studyList.
function studyList_Callback(hObject, eventdata, handles)
% hObject    handle to studyList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns studyList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from studyList
studyList = hObject.String(hObject.Value);
if ~isempty(studyList)
    conditionsOnRecord = fetch(handles.conn,['SELECT DISTINCT EDFInfo.condition FROM scoredInfo JOIN EDFInfo ON scoredInfo.EDFname = EDFInfo.EDFname  JOIN idStudy ON EDFInfo.id = idStudy.id WHERE idStudy.study IN (', strjoin(strcat('''',studyList,''''),', '), ');']);
    if strcmp(class(conditionsOnRecord), 'table')
        conditionsOnRecord = table2cell(conditionsOnRecord);
    end
else
    conditionsOnRecord = '';
    set(handles.allConds', 'Value', 0);
    allConds_Callback(handles.allConds,[],handles);
end
set(handles.condList, 'String', conditionsOnRecord);
condList_Callback(handles.condList,[],handles);
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function studyList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to studyList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in condList.
function condList_Callback(hObject, eventdata, handles)
% hObject    handle to condList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns condList contents as cell array
%        contents{get(hObject,'Value')} returns selected item from condList
if ~isempty(hObject.String)
    condList = hObject.String(hObject.Value);
    if ~isempty(condList)
        studyList = handles.studyList.String(handles.studyList.Value);
        idsOnRecord = fetch(handles.conn,['SELECT DISTINCT idStudy.id FROM scoredInfo JOIN EDFInfo ON scoredInfo.EDFname = EDFInfo.EDFname  JOIN idStudy ON EDFInfo.id = idStudy.id WHERE idStudy.study IN (', strjoin(strcat('''',studyList,''''),', '), ') AND EDFInfo.Condition IN (', strjoin(strcat('''',condList,''''),', '), ') ;']);
        if strmatch(class(idsOnRecord),'table')
            idsOnRecord = table2cell(idsOnRecord);
        end
    else
        idsOnRecord = '';
        set(handles.allIDs', 'Value', 0);
        allIDs_Callback(handles.allConds,[],handles);
    end
else
    idsOnRecord = '';
    set(handles.allIDs', 'Value', 0);
    allIDs_Callback(handles.allConds,[],handles);
end
format short e
for i = 1:length(idsOnRecord)
    idsOnRecord{i} = num2str(idsOnRecord{i});
end
set(handles.idList, 'String', idsOnRecord);
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function condList_CreateFcn(hObject, eventdata, handles)
% hObject    handle to condList (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in makeReport.
function makeReport_Callback(hObject, eventdata, handles)
% hObject    handle to makeReport (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get List of Records Needed
studyList = handles.studyList.String(handles.studyList.Value);
condList = handles.condList.String(handles.condList.Value);
idList = handles.idList.String(handles.idList.Value);

if ~isempty(studyList) & ~isempty(condList) & ~isempty(idList)
    recordList = fetch(handles.conn, ['SELECT record FROM scoredInfo ', ...
        'JOIN EDFInfo ', ...
        'ON EDFInfo.EDFName = scoredInfo.EDFName ', ...
        'JOIN idStudy ', ...
        'ON idStudy.id = EDFInfo.id ', ...
        'WHERE idStudy.id IN (',strjoin(strcat('''',idList,''''),', '), ') ', ...
        'AND EDFInfo.condition IN (',strjoin(strcat('''',condList,''''),', '), ') ', ...
        'AND idStudy.study IN (',strjoin(strcat('''',studyList,''''),', '), ') ', ....
        'AND scoredInfo.finalScores = ',num2str(handles.finalOnly.Value),';']);
    
    if strcmp(class(recordList), 'table') 
        recordList = table2cell(recordList);
    end
    
    reportType = 1;
    eval(['[reportName, statistics] = ',handles.reportFuncs{handles.templates.Value},'(recordList);']);
    assignin('base','ReportTable', statistics)
    
    if handles.saveFile.Value == 1
        try
        [saveName,savePath] = uiputfile({'*.csv', 'Comma Separated Value file (*.csv)';'.xlsx', 'Excel 2007 and later (*.xlsx)';'.xls', 'Excel 2003 and earlier (*.xls)'}, 'Save report table as');
        if isa(statistics, 'cell')
            statistics = cell2table(statistics);
        end
        writetable(statistics,[savePath,'/',saveName])
        catch
        end
    end
else
    msgbox('Please make study, condition, and ID selections.');
end



% --- Executes on button press in allStudies.
function allStudies_Callback(hObject, eventdata, handles)
% hObject    handle to allStudies (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of allStudies
if get(hObject, 'Value') == 1
    
    % Select All
    set(handles.studyList, 'Value', [1:1:size(handles.studyList.String,1)]);
    studyList_Callback(handles.studyList, [], handles);
    
elseif get(hObject, 'Value') == 0
    
    % Unselect All
    set(handles.studyList,'Value',[]);
    studyList_Callback(handles.studyList, [], handles);
end
guidata(hObject,handles)

% --- Executes on button press in allConds.
function allConds_Callback(hObject, eventdata, handles)
% hObject    handle to allConds (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of allConds
if get(hObject, 'Value') == 1
    
    % Select All
    set(handles.condList, 'Value', [1:1:size(handles.condList.String,1)]);
    condList_Callback(handles.condList, [], handles);
    
elseif get(hObject, 'Value') == 0
    
    % Unselect All
    set(handles.condList,'Value',[]);
    condList_Callback(handles.condList, [], handles);
end
guidata(hObject,handles)

% --- Executes on button press in allIDs.
function allIDs_Callback(hObject, eventdata, handles)
% hObject    handle to allIDs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of allIDs
if get(hObject, 'Value') == 1
    
    % Select All
    set(handles.idList, 'Value', [1:1:size(handles.idList.String,1)]);
    
elseif get(hObject, 'Value') == 0
    
    % Unselect All
    set(handles.idList,'value',[]);
end
guidata(hObject,handles)


% --- Executes on button press in finalOnly.
function finalOnly_Callback(hObject, eventdata, handles)
% hObject    handle to finalOnly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of finalOnly

function updateIDs(condList)
% Updates Condition List

% hObject    handle to finalOnly (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% handles    structure with handles and user data (see GUIDATA)

studyList = handles.studyList.String(handles.studyList.Value);
if ~isempty(studyList)
    conditionsOnRecord = fetch(handles.conn,['SELECT DISTINCT EDFInfo.condition FROM scoredInfo JOIN EDFInfo ON scoredInfo.EDFname = EDFInfo.EDFname  JOIN idStudy ON EDFInfo.id = idStudy.id WHERE idStudy.study IN (', strjoin(strcat('''',studyList,''''),', '), ');']);
else
    conditionsOnRecord = '';
end
set(handles.condList, 'String', conditionsOnRecord);
guidata(gcf, handles);


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in saveFile.
function saveFile_Callback(hObject, eventdata, handles)
% hObject    handle to saveFile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of saveFile


% --- Executes on selection change in templates.
function templates_Callback(hObject, eventdata, handles)
% hObject    handle to templates (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns templates contents as cell array
%        contents{get(hObject,'Value')} returns selected item from templates


% --- Executes during object creation, after setting all properties.
function templates_CreateFcn(hObject, eventdata, handles)
% hObject    handle to templates (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
