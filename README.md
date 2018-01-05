# Food-Nutrition-iOS-App-ML-Libraries-and-ARKit-
<h1>Introduction</h1>
<h3>Description</h3>
Detecting food products using Apple’s Machine Learning libraries and showing the nutrition in Augmented Reality.



<h3>Specifications needed</h3>
Works in iOS version 11.1.
Xcode 9 and Swift 4 needed.

<h3>Components completed</h3>
Object Detection and AR display of the text is successfully completed.

<h3>Remaining Components</h3>
Work in progress with dataset with nutrition for every product.

<h3>Application Flow</h3>
1. It loads the ML libraries as the app starts <b>(Resnet50 ML module used).</b>
2. <b>ViewController</b> detects objects and asks if it has detected correctly.
   For now, the app detects an iPod as we are still to give in the dataset of the 
   nutrition with the products.
3. <b>SecondViewController</b> Shows the name of the product detected in <b>ViewController</b>
   using ARKit in Augmented Reality and further we will add dataset to this module so that 
   it can retrieve nutrition using this dataset and the name of the product passed by the <b>ViewController</b>
   
   
   <h1>Screenshots</h1>
   
   ![alt text](https://github.com/pranavpraikundalia/Food-Nutrition-iOS-App-ML-Libraries-and-ARKit-/blob/master/MLAR/IMG_9097.PNG)
   
   
   
   
   ![alt text](https://github.com/pranavpraikundalia/Food-Nutrition-iOS-App-ML-Libraries-and-ARKit-/blob/master/MLAR/IMG_9098.PNG)
