function [mature_detectors,mature_Draduis,tim,cntr_detector] = RNSA_train(S,A,mature_detectors,mature_Draduis,Tdmax,rs,ra,cntr_detector,step)
        
        % S is Self Train Samples with normal state, Also S set is actually the training Set in generating non-seld mature detectors.
        % Each sample in S has a Constant raduis , rS.
        % D (Detectors set) has antibodies with reaction of detecting non-self samples so as to try to cover all non-self space as well as possible. 
        
    %% produced by Ehsan Farzadnia ar MUT, Tehran, 2018/04/24. 

    tic;
        n = size(S,2);  
        % n is the problem dimension
        
   if step > 1
   else
        
        %% plotting ...
           
            for i = 1 : size(S,1)
                pltCircles(rs,S(i,5),S(i,6));
                disp(['Self_Sample Generation number ---->>    ', num2str(i)]);
                   pause(0.01);
                hold on;
            end
            for i = 1 : size(A,1)
                pltCircles(ra,A(i,5),A(i,6));
                disp(['Self_AnomalySample Generation number ---->>    ', num2str(i)]);
                   pause(0.01);
                hold on;
            end
        
            toc;
            plot(S(:,5),S(:,6),'.');
            hold on;
            plot(A(:,5),A(:,6),'.');
            hold on

        %% detector candidate, randomely generating ... for cover non-self region
        % Continuous uniform random numbers

        disp('Starting ...');
        Candidate_detector_pool = try_feasiblity_of_generated_detector(n,Tdmax);
        % Uniformly Random Unmatured Antibody generation
        [mature_detectors(cntr_detector,:),Candidate_detector_pool,mature_Draduis(cntr_detector,:)] = NSA_Self(Candidate_detector_pool,0,S,A,rs,ra,0,Tdmax,n);
        % remove candidate detectors are inside in new mature detector...
        Candidate_detector_pool = Candidate_detector_pool(pdist2(Candidate_detector_pool,mature_detectors(cntr_detector,:)) > mature_Draduis(cntr_detector,:),:);

            pltCircles(mature_Draduis(cntr_detector,:),mature_detectors(cntr_detector,5),mature_detectors(cntr_detector,6));
        cntr_detector = cntr_detector + 1;
   end

        if step > 1
            stpGen = 1; 
            disp(' Training ...');
            Candidate_detector_pool = try_feasiblity_of_generated_detector(n,Tdmax);
        else
            stpGen = size(mature_detectors,1);
        end
            while(stpGen < Tdmax)
                tic;
                % Tdmax Condition
                % Uniformly Random Unmatured Antibody generation

                [mature_detectors(cntr_detector,:),Candidate_detector_pool,mature_Draduis(cntr_detector,:)] = NSA_Self(Candidate_detector_pool,mature_detectors,S,A,rs,ra,mature_Draduis,Tdmax,n);
                [status] = NSA_nonSelf(mature_detectors(cntr_detector,:),mature_detectors(1:cntr_detector-1,:),mature_Draduis(1:cntr_detector-1));
                if status == 1
                    
                    % death Unmatured detector, So regenerate another Uniformly random and add to the pool...
                    Candidate_detector_pool(size(Candidate_detector_pool,1) + 1,:) = unifrnd(0,1,1,n);
                elseif status == 0
                    
                    % mature, So calculating its raduis
%                     if min(pdist2(mature_detectors(cntr_detector,:),mature_detectors(1:cntr_detector-1,:))) < mature_Draduis(cntr_detector)
%                         mature_Draduis(cntr_detector) = min(pdist2(mature_detectors(cntr_detector,:),mature_detectors(1:cntr_detector-1,:)));
% 
% 
%                     else
%                     end

                    %% For Representation Checking ...
                    if min(pdist2(mature_detectors(cntr_detector,5:6),mature_detectors(1:cntr_detector-1,5:6))) < mature_Draduis(cntr_detector)
                        mature_Draduis(cntr_detector) = min(pdist2(mature_detectors(cntr_detector,5:6),mature_detectors(1:cntr_detector-1,5:6)));
                    else
                    end
                    pltCircles(mature_Draduis(cntr_detector,:),mature_detectors(cntr_detector,5),mature_detectors(cntr_detector,6));

                    disp(['non-Self_Antibody    ',  num2str(size(mature_detectors,1))]);
                    pause(0.01);
                    Candidate_detector_pool = Candidate_detector_pool(pdist2(Candidate_detector_pool,mature_detectors(cntr_detector,:)) > mature_Draduis(cntr_detector,:),:);
                    cntr_detector = cntr_detector + 1;
                    stpGen = stpGen + 1;
                end


                        disp([num2str(size(mature_detectors,1)),'   run   ',num2str(toc),'     Seconds.']);
                tim(size(mature_detectors,1),1) = toc;

            end
end
