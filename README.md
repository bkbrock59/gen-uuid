# RPGLE - Generate UUID
The program GEN_UUID generates a version 4 UUID using the IBM i MI command GENUUID. Here are the two resources I used to build the program. 

https://www.ibm.com/docs/en/i/7.5?topic=instructions-generate-universal-unique-identifier-genuuid 

https://www.ibm.com/support/pages/generate-uuid-rpg-genuuid-mi


In the end, the procedure converts the UUID into a human-readable string in the format: 
```
xxxxxxxx-xxxx-Mxxx-Nxxx-xxxxxxxxxxxx
```

where M is the UUID version field. Example UUID:
```
d63f7b40-a9b5-47ab-a415-ea0c6435e3dc
```

* This program is meant to run in debug mode so you can see how it works. I coded the sub-procedure as a function to make it easier to use. I placed it in a service program that can be accessed from any other program.