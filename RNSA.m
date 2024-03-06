function [out,SD,D,rd] = RNSA(S,A,Ag,target,rs,ra,Tdmax,itr)

    D = [];
    rd = [];
    tOut = [];
    Result = [];

    for i = 1 : itr
            %% //... training ... 
            tic;
            if i > 1
                [D,rd,timeOfAbGeneration,cntr_detector] = RNSA_train(S,A,D,rd,Tdmax,rs,ra,cntr_detector,i);      
            else
                cntr_detector = 1;
                [D,rd,timeOfAbGeneration,cntr_detector] = RNSA_train(S,A,[],[],Tdmax,rs,ra,cntr_detector,i);      
            end
        toc;  
            disp(['Elapsed time of Antibody Generation For  ',num2str(i),' th Step is --->>    ',num2str(sum(timeOfAbGeneration)),'   Seconds.']);
            SD = S;
        
        %% //... Testing ... 
         tic;
             [out] = RNSA_test(SD,A,D,Ag,rs,ra,rd);
             disp('... Test Elapsed Time ...');
         toc;  
         
         tOut(size(tOut,1) + 1:size(tOut,1) + Tdmax - 1,1) = timeOfAbGeneration(cntr_detector - Tdmax + 1 : cntr_detector - 1);
         Result(size(Result,1) + 1:size(Result,1) + size(out,2),1) = out;
      

            %% plotting ...
            figure;
            plotroc(transpose(target),out);
            figure;
            plotconfusion(transpose(target),out);

    end
end