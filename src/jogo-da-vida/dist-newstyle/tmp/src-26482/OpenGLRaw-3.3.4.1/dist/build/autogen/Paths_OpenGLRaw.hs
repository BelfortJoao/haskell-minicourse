{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
{-# OPTIONS_GHC -w #-}
module Paths_OpenGLRaw (
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
version = Version [3,3,4,1] []

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir `joinFileName` name)

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath



bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath
bindir     = "/home/joao/.cabal/store/ghc-9.2.8/OpenGLRaw-3.3.4.1-f0eb32d0268f8c440aadf30a9d63bfc8974b37cccdce5876bcd0ab07dff27dad/bin"
libdir     = "/home/joao/.cabal/store/ghc-9.2.8/OpenGLRaw-3.3.4.1-f0eb32d0268f8c440aadf30a9d63bfc8974b37cccdce5876bcd0ab07dff27dad/lib"
dynlibdir  = "/home/joao/.cabal/store/ghc-9.2.8/OpenGLRaw-3.3.4.1-f0eb32d0268f8c440aadf30a9d63bfc8974b37cccdce5876bcd0ab07dff27dad/lib"
datadir    = "/home/joao/.cabal/store/ghc-9.2.8/OpenGLRaw-3.3.4.1-f0eb32d0268f8c440aadf30a9d63bfc8974b37cccdce5876bcd0ab07dff27dad/share"
libexecdir = "/home/joao/.cabal/store/ghc-9.2.8/OpenGLRaw-3.3.4.1-f0eb32d0268f8c440aadf30a9d63bfc8974b37cccdce5876bcd0ab07dff27dad/libexec"
sysconfdir = "/home/joao/.cabal/store/ghc-9.2.8/OpenGLRaw-3.3.4.1-f0eb32d0268f8c440aadf30a9d63bfc8974b37cccdce5876bcd0ab07dff27dad/etc"

getBinDir     = catchIO (getEnv "OpenGLRaw_bindir")     (\_ -> return bindir)
getLibDir     = catchIO (getEnv "OpenGLRaw_libdir")     (\_ -> return libdir)
getDynLibDir  = catchIO (getEnv "OpenGLRaw_dynlibdir")  (\_ -> return dynlibdir)
getDataDir    = catchIO (getEnv "OpenGLRaw_datadir")    (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "OpenGLRaw_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "OpenGLRaw_sysconfdir") (\_ -> return sysconfdir)




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
