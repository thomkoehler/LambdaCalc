
#include "Expr.h"

using namespace lambdacalc;

Expr::~Expr()
{

}

EVar::EVar(const std::string &name) : _name(name)
{

}

void EVar::print(std::ostream &os) const
{
	os << "EVar " << _name;
}

ELam::ELam(const std::string &name, std::shared_ptr<Expr> expr) : _name(name), _expr(expr)
{

}

void ELam::print(std::ostream &os) const
{
	os << "ELam " << _name << " (" << *_expr << ")";
}

EApp::EApp(std::shared_ptr<Expr> left, std::shared_ptr<Expr> right) 
	: _left(left), _right(right)
{

}

void EApp::print(std::ostream &os) const
{
	os << "EApp (" << *_left << ") (" << *_right << ")";
}