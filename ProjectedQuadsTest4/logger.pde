Boolean PRINT_DEBUG = true; // true to print debug logs, else false

// use this logger to print detailed debug info to the console.
// Set PRINT_DEBUG to false to not print so much info.
public void log(String message){
  if (PRINT_DEBUG){
    print(message);
  }else{
    return;
  }
}
