// filter function
var filter = function(a, f) {

  var a2 = Array();

  for (var i=0; i<a.length; i++) {
    if (f(a[i])) {
      a2.push(a[i]);
    }
  }

  return a2;
};

// test
 var isEven = function (x) {
   return x % 2 == 0;
 };

 console.log(filter([1, 2, 3, 4], isEven)); // => [2, 4] ````
