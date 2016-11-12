function [ x,y ] = stochasticSearch( sMin,sMax,noOfSamples,radius,nRRI,nRLC,maxItr,files )
%Program to implement the stochastic serach algorithm
%   Eg:-stochasticSearch( [-20;-20],[20;20],100,4,4,1,1,[1;2],1,1,5 )
    im_sizex = 640; im_sizey=640;
    population=generatePopulation(sMin,sMax,noOfSamples );
    bestPointOfAGen=zeros(length(sMax),maxItr);
    bestCostOfAGen=zeros(1,maxItr);
%     contourPlot( sMin,sMax,muX,muY,sigmaX,sigmaY,noOfSamples );
%     hold on;
    
%     h1=scatter(population(1,:),population(2,:));
%     title('Stochastic Search Algorithm');
%     pause(2);     
    A = uint8(zeros(im_sizex, im_sizey,length(files)));
    for i = 1:length(files)
        A(:,:,i) = imread(char(files(i)));
    end
        

    for itr=1:1:maxItr
        cost = evalCost( population,A );
        assignedProbability  = evalProbability( cost );
        cardinalityNewPopRW  = evalCardinality( assignedProbability,noOfSamples );
        newPopRW = genPopRW(population, cardinalityNewPopRW,radius,sMin,sMax );
        newPopRWCost=evalCost( newPopRW,A );
        newPopRRI = genPopRRI(sMin,sMax, nRRI );
        newPopRRICost=evalCost( newPopRRI,A );
        newPopRLC = genPopRLC(population,sMin,sMax, nRLC );
        newPopRLCCost=evalCost( newPopRLC,A );
        combinedCost=[cost,newPopRWCost,newPopRRICost,newPopRLCCost];
        combinedPopulation=[population,newPopRW,newPopRRI,newPopRLC];
        nextGenPopulation = nextGenSelection( combinedCost,combinedPopulation,noOfSamples );

        bestCostOfAGen(itr)=combinedCost(1);
        bestPointOfAGen(:,itr)=nextGenPopulation(:,1);  %best point in each iteration
        population=nextGenPopulation;
        
%         delete(h1);
%         h1=scatter(population(1,:),population(2,:));
%         pause(2);
    end
%     delete(h1);
    x=bestPointOfAGen(1,:);
    y=bestPointOfAGen(2,:);
    %h1=plot(x,y);           %plot the path of the best solution in each iteration
    
    %pause(2);
    %delete(h1);
    %scatter(x(1,maxItr),y(1,maxItr));   %Converged value
    %text(x(1,maxItr),y(1,maxItr),['(' num2str(x(1,maxItr)) ',' num2str(y(1,maxItr)) ')'])%Display the co-ordinates of the point in the graph
end













