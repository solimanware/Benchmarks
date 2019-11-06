

**Cross-platform Apps Out-performing Native Apps**

#### Keyword list:

Cross-platform, Hybrid, Native, Ionic, Java, Kotlin, Cordova, JavaScript, Angular, Typescript, Chrome, v8 engine, chromium, webkit, safari, Android, iOS.

  

#### Abstract:

  
No doubt that cross-platform apps means faster development time as you build once and ship to many, however Native apps have every possible feature the platform provider has given to developer, for JAVA apps JVM is used to convert the JAVA code into the Java bytecode and ensure that the code will run smoothly on every platform that is shipped on while using the JDK, for Hybrid apps - let’s take ionic for example - it uses JavaScript with the awesome V8 engine in a web view to run the app with cordova plugins to communicate with the very native device features that isn’t provided by the (browser) chrome for android for most of the time recently.

  

#### Introduction:

So we have here two engines here to compare: The JVM and V8 let’s start comparing for two basic points:  

1- Parsing(JSON)

2- Default Search Algorithm

For the V8:

V8 team is [working really hard on optimising the performance](http://v8.dev/) of their parsing techniques, 

if parsing for Android is important, it’s the lifeblood for the web.  

[JSON parsing](https://v8docs.nodesource.com/node-0.12/da/d6f/classv8_1_1_j_s_o_n.html) is faster in JavaScript because of the limited grammar compared to Objects

  

#### Materials and methods:

We will start our benchmark using both platforms we compare on, the JavaScript and Kotlin code, let’s start:

The json file we will test over (it's 15MB in size):  
[http://dawaey.com/api/v3/eg/drugs.json  
](http://dawaey.com/api/v3/eg/drugs.json)

Here’s the [code](https://github.com/microsmsm/Benchmarks/blob/master/JSON-Parse-JS/app.js) snippet we will use

![](https://lh4.googleusercontent.com/wrut7ox77f4uT457Id9jLFs-FZrPsJX6e3Qd9SCZp04HKa_IhHoKrU9y664KEnNcHbE7GyScOVfwBY2HnEp9lTV71vEtzarYNxt5aoJN8hNSFYsw53FN41Ca7A4zGQ1r7yVl5zk2)

## On my machine i5 with 8gb ram:
###  Node (12.13.0)
50ms to parse the file
### Chrome (78.0.3904.70)
45ms to parse the file

## On Samsung A50 Exynos 7 Octa 9610 Chipset
### Chrome for android (77.0.3865.92)
Let’s test parsing using chrome…

It takes 155ms to do parsing.

![](https://lh3.googleusercontent.com/fgrKyjpoPBAoboA-3vJbFREq2dih2SY9xJO7dZnF2kha9uYOWTYlw2pXvn3VX8zGhh7ZwfZxW2arXWxW5hLBhM3dLVDSa43JHjEmr57_ZouJAp4Ve69FYLUQckgDoIIzVn_D-TOi)


### Kotlin Android (with sperate thread)
But while using kotlin parser ([kotlinx.serialization](https://github.com/Kotlin/kotlinx.serialization)) 
gives us 
400ms.

![](https://lh4.googleusercontent.com/yMV61kqegCIkcITqMUcCBdlH71ee1qee6O6OkaaOsJrjFjVzSRloq-WzilMaokSQfhN54XPLlPyV2dPzZ-YBcNNfb8t1-JVLtiw_CKPVJgRsxxqdTZeRtz54QYPgTE-N4MS4Bv5f)



#### SO: is JavaScript faster up to 3 times? 
Yes and the answer is the implementation of parsing techniques and here’s the answer that the native language shouldn't be faster all the times, and it’s up to the code implementation.

#####   
Here’s the secrets for the JavaScript engines for parsing:

[https://gist.github.com/abhi-bit/09d0010e20d8acbbc6de2a136fdabffc](https://gist.github.com/abhi-bit/09d0010e20d8acbbc6de2a136fdabffc)

[https://chromium.googlesource.com/v8/v8/+/refs/heads/5.8.288/src/json-parser.h](https://chromium.googlesource.com/v8/v8/+/refs/heads/5.8.288/src/json-parser.h)

[http://trac.webkit.org/browser/trunk/JavaScriptCore/runtime/JSONObject.cpp?rev=56189](http://trac.webkit.org/browser/trunk/JavaScriptCore/runtime/JSONObject.cpp?rev=56189)

  
  
  

####    Results:

##### On the “Samsung Exynos 7 Octa 9610 Chipset”

JSON Serialization:  
Native Kotlin : 400 ms  
JavaScript Chrome: 150 ms  
  

  
JSON Search:  
Native (JVM) (?): 12 ms  
Ionic (JavaScript) (Merge Sort): 5 ms  
Flutter (Dart Engine) (?): 3 ms
