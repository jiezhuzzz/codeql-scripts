/**
 * @name call chain
 * @kind path-problem
 * @problem.severity warning
 * @id cpp/call-chain
 */

 import cpp

 // string getFullFunctionName(Function f) {
 //     result = f.getFile().toString() + "@" + f.getName()
 // }
 
 predicate isCaller(Function f) { f.getName() = "LLVMFuzzerTestOneInput" }
 
 predicate isCallee(Function f) { f.getName() = "paf_read_header" }
 
 query predicate edges(Function f1, Function f2) { f1.calls(f2) }
 
 from Function caller, Function callee, Function intermediate
 where
   isCaller(caller) and
   isCallee(callee) and
   edges(caller, intermediate) and
   edges+(intermediate, callee)
 select caller, intermediate, callee, "call-chain"
 