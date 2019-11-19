@extends('layouts.app')
@section('content')
          <h2 style = "margin-left: 15px">Current Tests</h2>
          <div class="table-responsive">
            <table class="table table-striped table-sm">
              <thead>
                <tr>
                  <th>Requirement<th>
                  <th>Id & Date</th>
                  <th>Component</th>
                  <th>Method</th>
                  <th>Input</th>
                  <th>Expected</th>
                  <th>Result</th>
                  <th>Status</th>   
                </tr>
              </thead>
              <tbody>
                @if(count($testCases) > 0)
                    @foreach($testCases as $testCase)
                      <tr>
                        <td>{{$testCase->requirement}}</td>
                        <td> </td>
                        <td>{{$testCase->test_case_id}} {{$testCase->created_at}}</td>
                        <td>{{$testCase->component}}</td>
                        <td>{{$testCase->method}}</td>
                        <td>{{$testCase->input}}</td>
                        <td>{{$testCase->expected}}</td>
                        <td>{{$testCase->result}}</td>
                        <td>{{$testCase->outcome}}</td>
                      </tr>
                    @endforeach
                @endif
              </tbody>
            </table>
          </div>
        </main>
      </div>
    </div>
@endsection