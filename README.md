# stricths

- The main goal is to build a base with the `Strict` pragma to allow for strict programs



# Issues
- Lazy literal notation with inbuilt classes
    - List notation `[1,2,3]` and the `(:)` function are both lazy and _cannot_ be overridden
    - Tuple notation `(1,'c',"hello")` and the `(,)` function are both lazy and _cannot_ be overridden

    - There are different classes for these in this base, but they must be consciously used
    - It's easy to use these by _accident_, fortunately pervasive strictness should alleviate some of it

- Figure out how to autoderive the new Functor etc classes
    - ?
- `do` notation requires `GHC.Base.Monad`
    - can be fixed with translation
- typeclasses (and any type annotations also probably) need strictness annotations in the type
    - NOT THE CASE


# Modules
- ML style modules should exists, but typeclasses / instances should be global
    - maybe only instances should be global

