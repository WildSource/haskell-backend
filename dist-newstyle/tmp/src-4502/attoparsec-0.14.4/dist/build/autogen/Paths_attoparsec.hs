{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
#if __GLASGOW_HASKELL__ >= 810
{-# OPTIONS_GHC -Wno-prepositive-qualified-module #-}
#endif
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_attoparsec (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where


import qualified Control.Exception as Exception
import qualified Data.List as List
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude


#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,14,4] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath




bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "/home/dydx/.cabal/store/ghc-9.10.1-69c3/attoparsec-0.14.4-30a04a9bd81406f52e08a40cdbdb56594ba0dc977e988bf74040779950aafb26/bin"
libdir     = "/home/dydx/.cabal/store/ghc-9.10.1-69c3/attoparsec-0.14.4-30a04a9bd81406f52e08a40cdbdb56594ba0dc977e988bf74040779950aafb26/lib"
dynlibdir  = "/home/dydx/.cabal/store/ghc-9.10.1-69c3/attoparsec-0.14.4-30a04a9bd81406f52e08a40cdbdb56594ba0dc977e988bf74040779950aafb26/lib"
datadir    = "/home/dydx/.cabal/store/ghc-9.10.1-69c3/attoparsec-0.14.4-30a04a9bd81406f52e08a40cdbdb56594ba0dc977e988bf74040779950aafb26/share"
libexecdir = "/home/dydx/.cabal/store/ghc-9.10.1-69c3/attoparsec-0.14.4-30a04a9bd81406f52e08a40cdbdb56594ba0dc977e988bf74040779950aafb26/libexec"
sysconfdir = "/home/dydx/.cabal/store/ghc-9.10.1-69c3/attoparsec-0.14.4-30a04a9bd81406f52e08a40cdbdb56594ba0dc977e988bf74040779950aafb26/etc"

getBinDir     = catchIO (getEnv "attoparsec_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "attoparsec_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "attoparsec_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "attoparsec_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "attoparsec_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "attoparsec_sysconfdir") (\_ -> return sysconfdir)



joinFileName :: String -> String -> FilePath
joinFileName ""  fname = fname
joinFileName "." fname = fname
joinFileName dir ""    = dir
joinFileName dir fname
  | isPathSeparator (List.last dir) = dir ++ fname
  | otherwise                       = dir ++ pathSeparator : fname

pathSeparator :: Char
pathSeparator = '/'

isPathSeparator :: Char -> Bool
isPathSeparator c = c == '/'
