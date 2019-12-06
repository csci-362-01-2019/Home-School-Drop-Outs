@extends('layouts.app')
@section('content')

<div class="container">
      <div class="py-5 text-center">
        <img class="d-block mx-auto mb-4" src="https://i.ibb.co/qY8phyH/moodle-logo.png" alt="" width="72" height="72">
        <h2>Create a Test Case</h2>
        <p class="lead">Test cases can be created for any method that has been added to the testing framework. To create a test case, enter a test case id, the name of the method, the requirement being tested, which component your testing, the input, and expect output. Then you're all set!</p>
      </div>
        </div>
        <div class="col-md-8 order-md-1" style = "width: 50%; margin: 0 auto;">
          <h4 class="mb-3">Create a Test Case</h4>

          <form method="post" action="{{ route('testCase.store') }}">
          @csrf
            <div class="row">
              <div class="col-md-6 mb-3">
                <label for="firstName">Test Case Id Number</label>
                <input type="number" class="form-control" name="id" placeholder="#" value="" required>
              </div>
              <div class="col-md-6 mb-3">
                <label for="lastName">Method Name</label>
                <input type="text" class="form-control" name="method" placeholder="" value="" required>
              </div>
            </div>
            <div class="mb-3">

            <div class="mb-3">
              <label>Requirement<span class="text-muted"></label>
              <input class="form-control" name="requirement" placeholder="The method takes in a string and ...">
            </div>

            <div class="mb-3">
              <label for="address">Component</label>
              <input type="text" class="form-control" name="component" placeholder="projects/moodle/grade/grading/<component>" required>
            </div>

            <div class="mb-3">
              <label>Input <span class="text-muted"></label>
              <input type="text" class="form-control" name="input" placeholder="Hello, World, 20, etc.">
            </div>

            <div class="mb-3">
              <label>Expected Output <span class="text-muted"></label>
              <input type="text" class="form-control" name="expected" placeholder="Array ( [0] => Hello, [1] => World! )">
            </div>
            <hr class="mb-4">
            <button class="btn btn-primary btn-lg btn-block" type="submit">Create Test Case</button>
          </form>

        </div>
      </div>

      <footer class="my-5 pt-5 text-muted text-center text-small">
        <p class="mb-1">Created By</p>
        <ul class="list-inline">
          <li class="list-inline-item"><a href="#">Alex Laughlin</a></li>
          <li class="list-inline-item"><a href="#">Andrew Nesbett</a></li>
          <li class="list-inline-item"><a href="#">Chandler Long</a></li>
        </ul>
      </footer>
    </div>
    
@endsection