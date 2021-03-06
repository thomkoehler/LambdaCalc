
#include <iostream>
#include <memory>

#include "Expr.h"
#include "LambdaCalcGrammar.h"

using namespace std;
using namespace lambdacalc;


int main()
{
	auto var = make_shared<EVar>("name");
	auto lam = make_shared<ELam>(string("l"), static_pointer_cast<Expr>(var));
	cout << *lam << std::endl;
    return 0;
}

