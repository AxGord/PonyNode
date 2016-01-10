haxe -debug -lib continuation -cp src -lib pony -php C:\data\WeSer\www -main Main -D analyzer --each
rmdir C:\data\WeSer\www\Defaults /s /q
rmdir C:\data\WeSer\www\Home /s /q
xcopy bin\Defaults C:\data\WeSer\www\Defaults\ /e
xcopy bin\Home C:\data\WeSer\www\Home\ /e
pause