function [Candidate,R,radius] = NSA_Self(R,D,S,A,rs,ra,rd,Tdmax,n)

        ext = 0;
        radius = [];
        Candidate = [];

 while(ext == 0)
            if size(R,1) == 0
                R = try_feasiblity_of_generated_detector(n,Tdmax);
               
            end
            for i = 1 : size(R,1)
                % Select a Candidate from R
                if D == 0
                    s = randperm(size(R,1));
                    Candidate = R(s(1),:);
                    R(s(1),:) = [];
                else
                    for j = 1 : size(R,1)
                        [v,inx] = min(pdist2(R(j,:),D));
                        if v > rd(inx) && min(pdist2(R(j,:),S)) > rs && min(pdist2(R(j,:),A)) > ra
                            Candidate = R(j,:);
                            R(j,:) = [];
                            break;
                        end
                    end
                    
                end
                if size(Candidate,1) == 1
                    if (min(pdist2(Candidate,S)) > rs) && (min(pdist2(Candidate,A)) > ra)
                        
                        %% For Representation
                        if (min(pdist2(Candidate(:,5:6),S(:,5:6))) > rs) && (min(pdist2(Candidate(:,5:6),A(:,5:6))) > ra)
                            
                            if min(pdist2(Candidate,S)) < min(pdist2(Candidate,A))
                                if min(pdist2(Candidate(:,5:6),S(:,5:6))) < min(pdist2(Candidate(:,5:6),A(:,5:6)))
                                    radius = min(pdist2(Candidate(:,5:6),S(:,5:6))) - rs;
                                    % A generated Unmatured Antibody
                                    %                                         radius = min(pdist2(Candidate,S)) - rs;
                                    ext = 1;
                                    break;
                                end
                            elseif min(pdist2(Candidate,S)) > min(pdist2(Candidate,A))
                                if min(pdist2(Candidate(:,5:6),S(:,5:6))) > min(pdist2(Candidate(:,5:6),A(:,5:6)))
                                    radius = min(pdist2(Candidate(:,5:6),A(:,5:6))) - ra;
                                    % A generated Unmatured Antibody
                                    %                                         radius = min(pdist2(Candidate,A)) - ra;
                                    ext = 1;
                                    break;
                                end
                            elseif min(pdist2(Candidate,S)) == min(pdist2(Candidate,A))
                                if min(pdist2(Candidate(:,5:6),S(:,5:6))) == min(pdist2(Candidate(:,5:6),A(:,5:6)))
                                    radius = min(pdist2(Candidate(:,5:6),S(:,5:6))) - rs;
                                    % A generated Unmatured Antibody
                                    %                                         radius = min(pdist2(Candidate,S)) - rs;
                                    ext = 1;
                                    break;
                                end
                            end
                        else
                            R = try_feasiblity_of_generated_detector(n,Tdmax);
                        end
                    end
                else
                end
            end
end