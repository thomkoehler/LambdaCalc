#pragma once

#include <string>
#include <iostream>
#include <memory>

namespace lambdacalc
{

	class Expr
	{
	public:
		virtual ~Expr();
		virtual void print(std::ostream &) const = 0;
		friend std::ostream &operator<<(std::ostream &os, const Expr &expr)
		{
			expr.print(os);
			return os;
		}
	};


	class EVar : public Expr
	{
	public:
		explicit EVar(const std::string &name);
		virtual void print(std::ostream &) const;

	private:
		std::string _name;
	};

	class ELam : public Expr
	{
	public:
		explicit ELam(const std::string &name, std::shared_ptr<Expr> expr);
		virtual void print(std::ostream &os) const;

	private:
		std::string _name;
		std::shared_ptr<Expr> _expr;
	};

	class EApp : public Expr
	{
	public:
		explicit EApp(std::shared_ptr<Expr> left, std::shared_ptr<Expr> right);
		virtual void print(std::ostream &os) const;

	private:
		std::shared_ptr<Expr> _left;
		std::shared_ptr<Expr> _right;
	};
}