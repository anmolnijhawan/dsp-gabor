function [ newSample ] = boundCheck(newSample, sMin,sMax )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    size(newSample)
    size(sMin)
    newSample(newSample<sMin) = sMin(newSample<sMin);
    newSample(newSample>sMax) = sMax(newSample>sMax);

end

