# History, Bang and FC

See history of run commands

```
history
```

Bang {!}
To run the Nth command. 

``` !N ```


FC command

The fc command also displays the command in the history.
``` fc -l 10 ```
displays the 10th command run onwards

``` fc -l 10 20 ``` 
displays the 10th to the 20th commands run


The history, bang, and fc commands can save you from having to repeatedly retype very long
commands

To clear history, eg when you accidentally type in your password in the shell prompt 
```history -c```