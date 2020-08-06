function [LUT] = eventLUT

% EVENT LUT 
% [CODE]    LABEL
%%   Copyright (c) 2015 Jared M. Saletin, PhD and Stephanie M. Greer, PhD
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
%%
LUT = {
    '[0]'   'Artifact'
    '[1]'   'Movement Arousal'
    '[2]'   'Transient Arousal'
    '[3]'   'Microsleep'
    '[4]'   'Slow Eye Movement'
    '[5]'   'Rapid Eye Movement'
    '[6]'   'Sleep Spindle'
    '[7]'   'K Complex'
    '[8]'   'Technologist Intervention'
    '[9]'   'Respiratory Event' 
    '[A]'   'Apnea'
    '[B]'   'Hypopnea'
    '[C]'   'Obstructive'
    '[D]'   'Central'
    '[E]'   'Mixed'
    '[F]'   'SaO2 <90%'
    '[G]'   'SaO2 <80%'
    '[H]'   'PLM'
    };

end
