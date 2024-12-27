/**
 * @name CallGraph
 * @kind problem
 * @problem.severity warning
 * @id cpp/call-graph
 */

import cpp

predicate isAnOperator(Function f) { f.getName().matches("operator%") }

string getFullFunctionName(Function f) {
  result = f.getBlock().getFile().toString() + "@" + f.getQualifiedName()
}

from FunctionCall call, Function caller, Function callee
where
  call.getTarget() = callee and
  call.getEnclosingFunction() = caller and
  not isAnOperator(callee) and
  not isAnOperator(caller)
select getFullFunctionName(callee), getFullFunctionName(caller)
