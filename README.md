**StartAsRoot** - running X-applications via pkexec

Designed to run an X-application via psexec. This is useful if you need to distribute applications in non-rpm packages. There is no need to write rules and additional executable files.

- The application to be launched must be located in the same StartAsRoot directory (or StartAsRoot + SrartAsRoot.ini in the catalog of your project)
- The name of the application to start is written in Start As Root.in
- Before starting, the intercepted User Name is written to the 'StartAsRoot.ini' file. It can be used by the developer in the future

Made and tested in Mageia Linux-6/7/8.
