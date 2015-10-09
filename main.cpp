#include <iostream>
#include <string>
#include <boost/variant.hpp>
#include <functional>


template<typename TResult, typename... TArgs>
class TailRec
{
public:
	using inner_t = std::function<boost::variant<TResult, boost::recursive_wrapper<TailRec<TResult>>>(TArgs...)>;

	TailRec(inner_t _f) : f(_f) {}
	boost::variant<TResult, TailRec<TResult>> operator()(TArgs... args) const
	{
		return f(args...);
	}
private:
	inner_t f;
};

template<typename TResult, typename... TArgs>
using TailRec_t = std::function<std::function<boost::variant<TResult, TailRec<TResult>>(TArgs...)>(TailRec<TResult, TArgs...>)>;


template<typename TResult, typename... TArgs>
class TailRecursiveYCombinator
{
public:
	std::function<TResult(TArgs...)> operator()(TailRec_t<TResult, TArgs...> f)
	{
		return [f](TArgs... args) -> TResult {
			auto rec = [&f](auto& r) -> std::function<boost::variant<TResult, TailRec<TResult>>(TArgs...)> {
				return [&f, &r](auto... _args) -> boost::variant<TResult, TailRec<TResult>> {
					return TailRec<TResult>(std::function<boost::variant<TResult, TailRec<TResult>>()>([&f, &r, _args...] { return (f(TailRec<TResult, TArgs...>(r(r))))(_args...); }));
				};
			};
			auto _f = rec(rec);
			auto r = _f(args...);
			while (r.which() == 1)
			{
				r = (boost::get<TailRec<TResult>>(r))();
			}
			return boost::get<TResult>(r);
		};
	}
};

int factorial(int n, int r)
{
	return n<2 ? r : factorial(n - 1, n*r + 1);
}

int factorial2(int n)
{
	return n<2 ? 1 : n*factorial2(n - 1) + 1;
}

int main()
{
	auto g = TailRecursiveYCombinator<int, int, int>();
	auto h = [](TailRec<int, int, int> fact) {
		return [=](int n, int r) {
			return n < 2 ? r : fact(n - 1, n*r + 1);

		};
	};

	const int N = 1000000;

	std::function<int(int, int)> Factorial2 = g(h);
	std::cout << Factorial2(N, 1) << std::endl;
	//std::cout << factorial(N, 1) << std::endl;
	//std::cout << factorial2(N) << std::endl;

}
