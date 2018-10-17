+++
title = "Development Norm"
weight = 4
chapter = true
+++

## Development Concept

 - Write codes with heart. Pursue clean, simplified and extremely elegant codes. Agree with concepts in &lt;Refactoring: Improving the Design of Existing Code&gt; and &lt;Clean Code: A Handbook of Agile Software Craftsmanship&gt;.

## Code Submitting Norms

 - Make sure all the test cases are passed.
 - Make sure the test coverage rate is not lower than the dev branch.
 - Make sure to check codes with Checkstyle. codes that violate check rules should have special reasons. Find checkstyle template from `sharding-sphere/src/resources/sharding_checks.xml`, please use checkstyle `8.8` to run the rules.
 - Make sure `mvn clean install` can be compiled and tested successfully.
 - Delete codes out of use in time.

## Coding Norm
 
 - Use linux line separators.
 - Keep indents (including blank lines) consistent with the previous one.
 - No meaningless blank lines.
 - Use English in all the logs and java docs.
 - Include Javadoc, todo and fixme only in the comments.
 - Use meaningful variable names. Return values are named with `result`; Variables in the loop structure are named with `each`; Replace `each` with `entry` in map.
 - Name property files with camel-case and lowercase first letters.
 - Have constants on the left and variable on the right in conditional expressions.
 - Make nested loop structures a new method.
 - Use guard clauses in priority.
 - Minimize the access permission for classes and methods.
 - Private method should be just next to the method in which it is used; writing private methods should be in the same as the appearance order of private methods.
 - No null parameters or return values.
 - Split codes that need to add notes with it into small methods, which are explained with method names.
 - Replace constructors, getters, setter methods and log variable with lombok in priority.
 - Be familiar with codes already had, to keep consistent with the style and use.
 - Highly reusable, no duplicated codes or configurations.

## Unit Test Norm

 - Test codes and production codes should follow the same kind of coding norms.
 - Without particular reasons, test cases should be fully covered.
 - Environment preparation codes should be separate from test codes.
 - Only those that relate to junit `Assert`, hamcrest `CoreMatchers` and `Mockito` can use static import.
 - For single parameter asserts, `assertTrue`, `assertFalse`, `assertNull` and `assertNotNull` should be used.
 - For multiple parameter asserts, `assertThat` should be used.
 - For accurate asserts, try not to use `not`, `containsString` to make assertions.
 - Actual values of test cases should be named `actualXXX`, expected values `expectedXXX`.