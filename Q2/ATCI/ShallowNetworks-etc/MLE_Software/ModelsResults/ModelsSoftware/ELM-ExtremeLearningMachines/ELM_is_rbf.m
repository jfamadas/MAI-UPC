
function is_rbf = ELM_is_rbf(ActivationFunction)

fun = lower(ActivationFunction);
is_rbf = 0;
if strcmp(fun,'gau') || strcmp(fun,'gaussian')
  is_rbf = 1;
end;
return;
