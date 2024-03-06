function [status] = NSA_nonSelf(Cand,d,r) 
%     
%          for i = 1 : size(d,1)
%                if pdist2(d(i,:),Cand) > r(i)
%                   status = 0;
%                else
%                    % death (not matured) ...
%                    status = 1;
%                    break;
%                end
%           end

%% Ckeing for Representation ...
              for i = 1 : size(d,1)
                   if pdist2(d(i,5:6),Cand(1,5:6)) > r(i)   
                       status = 0;
                   else 
%                          death (not matured) ...
                        status = 1;
                        break;
                   end
              end
end
