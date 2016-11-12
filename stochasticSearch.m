function [ x ] = stochasticSearch( sMin,sMax,noOfSamples,radius,nRRI,nRLC,maxItr,files )
%STOCHASTICSEARCH Program to implement the stochastic serach algorithm
%   Eg:-stochasticSearch( [-20;-20],[20;20],100,4,4,1,1,[1;2],1,1,5 )
    DEBUG = 1;

    im_sizex = 640; im_sizey=640;
    population=generatePopulation(sMin,sMax,noOfSamples );
    bestPointOfAGen=zeros(length(sMax),maxItr);
    bestCostOfAGen=zeros(1,maxItr);
 
    A = uint8(zeros(im_sizex, im_sizey,length(files)));
    for i = 1:length(files)
        A(:,:,i) = imread(char(files(i)));
    end
        

    for itr=1:1:maxItr
        if DEBUG
            disp('stochasticSearch: Calling evalcost on parent population')
        end
        cost = evalCost( population,A );
        assignedProbability  = evalProbability( cost );
        cardinalityNewPopRW  = evalCardinality( assignedProbability,noOfSamples );
        newPopRW = genPopRW(population, cardinalityNewPopRW,radius,sMin,sMax );
        if DEBUG
            disp('stochasticSearch: Calling evalcost on child population')
        end
        newPopRWCost=evalCost( newPopRW,A );
        newPopRRI = genPopRRI(sMin,sMax, nRRI );
        if DEBUG
            disp('stochasticSearch: Calling evalcost on RRI population')
        end
        newPopRRICost=evalCost( newPopRRI,A );
        newPopRLC = genPopRLC(population,sMin,sMax, nRLC );
        if DEBUG
            disp('stochasticSearch: Calling evalcost on RLC population')
        end
        newPopRLCCost=evalCost( newPopRLC,A );
        combinedCost=[cost,newPopRWCost,newPopRRICost,newPopRLCCost];
        combinedPopulation=[population,newPopRW,newPopRRI,newPopRLC];
        nextGenPopulation = nextGenSelection( combinedCost,combinedPopulation,noOfSamples );
        if DEBUG
            disp('stochasticSearch: Best population selected')
        end
        bestCostOfAGen(itr)=combinedCost(1);
        bestPointOfAGen(:,itr)=nextGenPopulation(:,1);  %best point in each iteration
        population=nextGenPopulation;
        
    end
    x=bestPointOfAGen;
    
    if DEBUG
        disp('stochasticSearch: Finished search')
    end
end













