
@extends('layouts.app')
@section('content')

<div style="margin: 0 auto; width: 50%; margin-top: 175px;"class="jumbotron">
<h1>Test Case Added</h1>
<p class="lead">Please return to the terminal and run the client testing framework. After testing is complete, go to the dashborad to see your changes.</p>
<a class="btn btn-lg btn-primary" href="{{ action('PagesController@dashboard') }}" role="button">Go to Dashboard &raquo;</a>
</div>

@endsection