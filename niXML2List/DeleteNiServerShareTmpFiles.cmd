@echo off
for /f %%f in (niservershares.txt) do del %%fni*.tmp /q

:quitbatch
