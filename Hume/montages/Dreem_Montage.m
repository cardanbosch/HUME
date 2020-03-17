function handles = sleep_Montage(handles)
%%    Auto-generated H�m� Scoring Montage
%  Montage Generated from File: b0dc3892-c312-4ac2-a420-7f6c5685078f.edf
%  Montage Generated on Date: 25-Nov-2019

%%    Copyright (c) 2015 Jared M. Saletin, PhD and Stephanie M. Greer, PhD
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
%   H�m� is intended for research purposes only. Any commerical or medical
%   use of this software is prohibited. The authors accept no
%   responsibility for its use in this manner.
%%
% channels to hide
handles.hideChans = {};
%electrode names that should be ploted.
handles.electrodes = flipud({'CH1 FP1-M1';'CH2 FP2-M2';'CH3 FP2-FP1';'CH4 FP1-FPZ';});
%colors for each electrode. The order and length must match the electrode list
handles.colors = flipud({[1  0  0];[1  0  0];[1  0  0];[1  0  0];});
%scale for each electrode. The order and length must match the electrode list
handles.scale = flipud({'150';'150';'150';'150';});
% channels to add scale lines to
handles.scaleChans = {'CH1 FP1-M1' 'CH2 FP2-M2' };
% voltage to place scales
handles.bigGridMat{1,1} = 'CH1 FP1-M1';
handles.bigGridMat{1,2}{1,1} = '-75';
handles.bigGridMat{1,2}{1,2} = [0 5.000000e-01 0];
handles.bigGridMat{1,2}{2,1} = '-37.5';
handles.bigGridMat{1,2}{2,2} = [0 5.000000e-01 0];
handles.bigGridMat{1,2}{3,1} = '0';
handles.bigGridMat{1,2}{3,2} = [0 5.000000e-01 0];
handles.bigGridMat{1,2}{4,1} = '37.5';
handles.bigGridMat{1,2}{4,2} = [0 5.000000e-01 0];
handles.bigGridMat{1,2}{5,1} = '75';
handles.bigGridMat{1,2}{5,2} = [0 5.000000e-01 0];
handles.bigGridMat{2,1} = 'CH2 FP2-M2';
handles.bigGridMat{2,2}{1,1} = '-75';
handles.bigGridMat{2,2}{1,2} = [0 5.000000e-01 0];
handles.bigGridMat{2,2}{2,1} = '-37.5';
handles.bigGridMat{2,2}{2,2} = [0 5.000000e-01 0];
handles.bigGridMat{2,2}{3,1} = '0';
handles.bigGridMat{2,2}{3,2} = [0 5.000000e-01 0];
handles.bigGridMat{2,2}{4,1} = '37.5';
handles.bigGridMat{2,2}{4,2} = [0 5.000000e-01 0];
handles.bigGridMat{2,2}{5,1} = '75';
handles.bigGridMat{2,2}{5,2} = [0 5.000000e-01 0];
