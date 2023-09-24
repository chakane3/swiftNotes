import Cocoa

/*

    Performing Asynchronous operations
 
 Asynchronous code can be suspended and resumed later. Imagine a busy highway; theres card going in and out the highway even though they dont fully drive the length of the highway. Parallel code can be run at the same time. A computer with 4 cores can run 4 pieces of code at the same time. Code which uses asynchronous and parallel operations will suspend code waiting on an external system. It will allow us to run multiple operations at a time. In swift, concurrency is the combination of asynchronous and parallel code.
 
 Note: When working with java/concurrency you need to know about managing threads. But in swift you dont interact with them directly. Its also possible to write concurrent code without using swift's language support.
 
    Defining and Calling Async functions
 
 An async method can be suspended while its partway through an execution. Synchronous methods will run to completion before another method is called. The most common usecsse for async functions would be making API calls.
 
*/

// Here is what an async function would look like
func listPhotos(inGallery name: String) async -> [String] {
    let result = ["network call response"]
    return result
    
}

/*

When calling a method like this the execution of the method will suspend until it returns. We wrtie "await" in from of the call to mark the suspension point. When inside the async method, the flow of execution is suspended ONLY when another async method is called. We have full control of where the code may pause to wait for something.
 
*/

// 1. code execution will run up to the await, it calls listPHotos and suspends execution while it waits for the return
// 2. While suspended, other concurrent code in will run
let photoNames = await listPhotos(inGallery: "What")

// 3. After listPhotos returns , the code contnues execution starting here. It assigns the value that was returned to photoNames.
// 4. Here we also dont see an await, so theres no suspension points
let sortedNames = photoNames.sorted()
let name = sortedNames[0]

// This next awaitwill pause execution again until we get a return, thus freeing up space for other code to run.
//let photo = await downloadPhoto(named: name)
//show(photo)

/*

We know that await will mark the suspension of code execution. This can be also be seen as yielding the thread because Swift suspends the execution of code on the current thread and runs some other code on the thead instead. Theres only certain places your program can call async function:
        1. Code in the body of an async function or property.
        2. Code in the static main() method of a structure, class, or enum marked with @main
        3. Code in an unstructured child task
 
 Code in between suspension points runs sequentially, without the possibility of interruptionfrom other concurrent code. For example this code moves a picture from one gallery to another.
 
*/

//let firstPhoto = await listPhotos(inGallery: "Hi")
//add(firstPhoto, toGallery: "road trip:")
// here, firstPhoto is temporarily in both galleries
//remove(firstPhoto, fromGallery: "summer")

/*
 
 
*/



