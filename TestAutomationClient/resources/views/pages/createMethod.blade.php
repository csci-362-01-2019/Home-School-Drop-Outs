@extends('layouts.app')
@section('content')

<div class="container">
      <div class="py-5 text-center">
        <img class="d-block mx-auto mb-4" src="https://i.ibb.co/qY8phyH/moodle-logo.png" alt="" width="72" height="72">
        <h2>Add a Method</h2>
        <p class="lead">Methods can be added to the testing framework. To add a new method, enter a method id, the method description, the method being tested, the name of the component, and the number of lines of code in the method. Then you're all set!</p>
      </div>
        </div>
        <div class="col-md-8 order-md-1" style = "width: 50%; margin: 0 auto;">
          <h4 class="mb-3">Create a Test Case</h4>

          <form method="post" action="{{ route('testCase.update') }}">
          @csrf
            <div class="row">
              <div class="col-md-6 mb-3">
                <label for="firstName">Method Id Number</label>
                <input type="number" class="form-control" name="id" placeholder="#" value="" required>
              </div>
              <div class="col-md-6 mb-3">
                <label for="lastName">Method Description</label>
                <input type="text" class="form-control" name="description" placeholder="The method takes in..." value="" required>
              </div>
            </div>
            <div class="mb-3">

            <div class="mb-3">
              <label>Method Name<span class="text-muted"></label>
              <input class="form-control" name="name" placeholder="myMethodName">
            </div>

            <div class="mb-3">
              <label for="address">Component Location</label>
              <input type="text" class="form-control" name="component" placeholder="projects/moodle/grade/grading/<component>" required>
            </div>

            <div class="mb-3">
              <label>Number of Lines in Method<span class="text-muted"></label>
              <input type="number" class="form-control" name="input" placeholder="#">
            </div>
            <hr class="mb-4">
            <button class="btn btn-primary btn-lg btn-block" type="submit">Add Method</button>
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