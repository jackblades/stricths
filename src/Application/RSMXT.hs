

module Application.RSMXT where

import Class.Functor
import Class.Applicative
import Class.Monad

import Data.Either
import Data.Tuple

f $ x = f x
infixr 0 $

f . g = \x -> f (g x)
infixr 9 .

-- MTL
newtype RSMXT e s m x a
    = RSMXT { runRSMXT :: e -> s -> m (Either x (Tup2 s a)) }

instance Monad m => Functor (RSMXT e s m x) where
    map f x = RSMXT $ \ e s ->
        runRSMXT x e s >>= \case
            Left x -> return $ Left x
            Right (Tup2 s' a) -> return $ Right (Tup2 s' (f a))

instance Monad m => Applicative (RSMXT e s m x) where
    -- pure :: a -> f a
    pure a =
        RSMXT $ \e s -> pure $ Right (Tup2 s a)

    -- (<*>) :: f (a -> b) -> f a -> f b
    f <*> a = RSMXT $ \e s -> do
        runRSMXT f e s >>= \case
            Left  x -> return $ Left x
            Right (Tup2 s' f') -> runRSMXT (map f' a) e s'

instance Monad m => Monad (RSMXT e s m x) where
    ma >>= f = RSMXT $ \e s -> do
        runRSMXT ma e s >>= \case
            Left  x -> return $ Left x
            Right (Tup2 s' a) -> runRSMXT (f a) e s'

-- instance Monad m => MonadState s (RSMXT e s m x) where
--     get = RSMXT $ \_ s -> return $ Right (s, s)
--     put s = RSMXT $ \_ _ -> return $ Right (s, ())

-- instance Monad m => MonadReader e (RSMXT e s m x) where
--     ask = RSMXT $ \e s -> return $ Right (s, e)

--     -- local :: (r -> r) -> m a -> m a
--     local f ma = RSMXT $ \e s -> runRSMXT ma (f e) s

-- class Monad m => MonadException x m | m -> x where
--     throw :: x -> m a
--     catch :: m a -> (x -> m a) -> m a

-- instance Monad m => MonadException x (RSMXT e s m x) where
--     throw x = RSMXT $ \_ _ -> return $ Left x
--     catch ma f = RSMXT $ \e s ->  -- TODO
--         runRSMXT ma e s >>= \case
--             Left x -> return $ Left x
--             Right a -> return $ Right a

-- instance MonadIO m => MonadIO (RSMXT e s m x) where
--     -- liftIO :: IO a -> m a
--     liftIO io = RSMXT $ \_ s -> liftIO $ fmap (Right . (,) s) io

-- -- test :: RSMXT (Int, Int) Int IO Int Int
-- -- test :: Monad m => RSMXT Int (Int, Int) m Int Int
-- test :: (MonadState Int m, MonadReader e m, MonadException Int m) => m Int
-- test = do
--     x <- get
--     y <- ask
--     throw (3 :: Int) `Metal.catch` \y -> put 10
--         -- pPrint y
--     return x⏎

