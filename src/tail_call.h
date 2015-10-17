#pragma once
#ifndef TailCallCpp_TailCall_H
#define TailCallCpp_TailCall_H
#include <boost/variant.hpp>
#include <functional>
#include <memory>
#include <utility>

namespace TailCallCpp
{
  namespace details
  {
    template<typename T>
    class TailRecursive_wrapper;

    template<typename TResult, typename... TArgs>
    class TailRecursive_wrapper<TResult(TArgs...)>
    {
    public:
      using type = std::function<boost::variant<TResult, boost::recursive_wrapper<TailRecursive_wrapper<TResult()>>>(TArgs...)>;

      TailRecursive_wrapper(type _f) : f(_f) {}
      boost::variant<TResult, TailRecursive_wrapper<TResult()>> operator()(TArgs... args) const
      {
        return f(args...);
      }
    private:
      type f;
    };

    template<typename T>
    using TailRecursiveDefinition = std::function<typename TailRecursive_wrapper<T>::type(TailRecursive_wrapper<T> const&)>;

    template<typename T>
    class TailRecursiveYCombinator;

    template<typename TResult, typename... TArgs>
    class TailRecursiveYCombinator<TResult(TArgs...)>
    {
    public:
      static std::function<TResult(TArgs...)> create(TailRecursiveDefinition<TResult(TArgs...)> const& f)
      {
        return [f](TArgs... args) -> TResult {
          auto rec = [&f](auto& r) -> typename TailRecursive_wrapper<TResult(TArgs...)>::type {
            return [&f, &r](auto... _args) -> boost::variant<TResult, TailRecursive_wrapper<TResult()>> {
              return TailRecursive_wrapper<TResult()>([&f, &r, _args...]{ return (f(r(r)))(_args...); });
            };
          };
          auto _f = rec(rec);
          auto r = _f(args...);
          while (r.which() == 1)
          {
            r = (boost::get<TailRecursive_wrapper<TResult()>>(r))();
          }
          return boost::get<TResult>(r);
        };
      }
    };
  }

  template<typename T>
  class RecWrapper;

  template<typename TResult, typename... TArgs>
  class RecWrapper<TResult(TArgs...)>
  {
  public:
    template<typename S>
    RecWrapper(S&& _f) : f(details::TailRecursiveYCombinator<TResult(TArgs...)>::create(
      [_f](details::TailRecursive_wrapper<TResult(TArgs...)> const& rec) { return _f(rec); })) {}

    TResult operator()(TArgs... args) const
    {
      return f(args...);
    }

  private:
    std::function<TResult(TArgs...)> f;
  };

  template<typename F>
  class GenericRecWrapper
  {
  public:
    GenericRecWrapper(F const& _f) : f(_f) {}
    GenericRecWrapper(F&& _f) : f(std::move(_f)) {}

    template<typename T>
    RecWrapper<T> GetImpl() const
    {
      return RecWrapper<T>(f);
    }

    template<typename TResult, typename... TArgs>
    TResult call(TArgs... args) const
    {
      return (GetImpl<TResult(TArgs...)>())(args...);
    }

    template<typename TReturn>
    auto GetImplWithReturnType() const
    {
      return [this](auto... args) { return call<TReturn, decltype(args)...> (args...); };
    }

  private:
    F f;
  };


  template<typename F>
  GenericRecWrapper<F> make_GenericRecWrapper(F&& f)
  {
    return GenericRecWrapper<F>(std::forward<F>(f));
  }
}

#endif // TailCallCpp_TailCall_H
