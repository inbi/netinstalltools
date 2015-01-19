@echo off
for /f %%f in (niserverlist.txt) do ping %%f

:quitbatch