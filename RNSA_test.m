function [out] = RNSA_test(SD,A,D,t,rs,ra,rd)
        % rd is nearest Antibody raduis from Antigen t.
        % Alpha value is variable and it depends on user experience.
        % ....... Programmed by Ehsan Farzadnia/*

        %%  The testing stage of FtNSA (matching...)
        % Test incoming sample t (same as the Antigen) in expection of classification.

        %% Just for Representation ...
        hold on
        plot(t(:,5),t(:,6),'xr');
        i = 1;
        while(i <= size(t,1))
%             [minSD_Real,~] = min(pdist2(SD,t(i,:)));
%             [minA_Real,~] = min(pdist2(A,t(i,:)));
                    [minSD,~] = min(pdist2(SD(:,5:6),t(i,5:6)));     % For Representation
                    [minA,~] = min(pdist2(A(:,5:6),t(i,5:6)));     % For Representation
%             [minD_Real,indxD_Real] = min(pdist2(D,t(i,:)));
                    [minD,indxD] = min(pdist2(D(:,5:6),t(i,5:6)));         % For Representation

            %% // For Real ...
% 
%             if minSD_Real <= rs
%                     % //  Normal  //
%                     out(i) = 0;
%                     i = i + 1;
%                 elseif minA_Real <= ra
%                     % //  Known Abnormal (Signed Attack)  //
%                     out(i) = 1;
%                     i = i + 1;
%                 %%  If it is not covered by any self-detectors, we classify it as:
%             else
%                 if (minA_Real - ra) <= (minSD_Real - rs)
%                     % // New Abnormal (Unknown Attacks) 
%                     % // Determine raduis of t 
%                     rD = min(minD_Real,minA_Real);
%                     if (minA_Real - ra) >= rD
%                         % New Abnormal With raduis rD
%                         D(size(D,1) + 1,:) = t(i,:);
%                         rd(size(D,1) + 1) = rD;
%                     elseif (minA_Real - ra) < rD
%                         % New Abnormal with 
%                         D(size(D,1) + 1,:) = t(i,:);
%                         rd(size(D,1) + 1) = minA_Real - ra;
%                     end
%                     out(i) = 1; 
%                                     i = i + 1;
%                 else
%                     % // new behavior (new normal) 
%                     % // Determine raduis of t 
%                     rD = min(minD_Real,minSD_Real);
%                     if (minSD_Real - rs) >= rD
%                         % New Abnormal With raduis rD
%                         D(size(D,1) + 1,:) = t(i,:);
%                         rd(size(D,1) + 1) = rD;
%                     elseif (minSD_Real - rs) < rD
%                         % New Abnormal with 
%                         D(size(D,1) + 1,:) = t(i,:);
%                         rd(size(D,1) + 1) = minSD_Real - rs;
%                     end
%                     out(i) = 0;  
%                     i = i + 1;
%                 end
%             end
                
        %% // For Representation
        
                if minSD <= rs
                     % //  Normal  //
                        out(i) = 0;
                        i = i + 1;
                elseif minA <= ra
                    % //  Known Abnormal (Signed Attack)  //
                        out(i) = 1;
                        i = i + 1;
        
        %  If it is not covered by any self-detectors, we classify it as:
        
                else
                    if (minA - ra) <= (minSD - rs)
                        % // New Abnormal (Unknown Attacks) 
                        % // Determine raduis of t 
                        rD = min(minD,minA);
                        if (minA - ra) >= rD
                            % New Abnormal With raduis rD
                            D(size(D,1) + 1,:) = t(i,:);
                            rd(size(D,1) + 1) = rD;
                        elseif (minA - ra) < rD
                            % New Abnormal with 
                            D(size(D,1) + 1,:) = t(i,:);
                            rd(size(D,1) + 1) = minA - ra;
                        end
                        out(i) = 1;  
                        i = i + 1;
                    else
                      % // new behavior (new normal) 
                      % // Determine raduis of t 
                        rD = min(minD,minA);
                        if (minSD - rs) >= rD
                            % New Abnormal With raduis rD
                            D(size(D,1) + 1,:) = t(i,:);
                            rd(size(D,1) + 1) = rD;
                        elseif (minSD - rs) < rD
                            % New Abnormal with 
                            D(size(D,1) + 1,:) = t(i,:);
                            rd(size(D,1) + 1) = minSD - rs;
                        end
                        out(i) = 0;  
                        i = i + 1;
                    end
                end
       end
end
