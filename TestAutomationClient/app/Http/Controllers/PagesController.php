<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Storage;
use App\TestCase;

class PagesController extends Controller
{

    /**
     * Create a new controller instance.
     *
     * @return void
     */
    public function __construct()
    {
        $this->middleware('auth');
    }

    public function index() {

        

        return view('welcome');
    }

    public function dashboard() {
        $testCases = TestCase::all();
        return view('pages.dashboard', compact('testCases'));
    }

        /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        return view('pages.create');
    }

    public function edit()
    {

        return view('pages.edit');
    }


    public function store(Request $request)
    {
        
        //Create Test Case
        $case = new TestCase;
        $case->id = $request->input('id');
        $case->requirement = $request->input('requirement');
        $case->component = $request->input('component');
        $case->method = $request->input('method');
        $case->input = $request->input('input');
        $case->expected = $request->input('expected');


        $testCaseName=$case->method . "Client" . $case->id;
        $objs = json_decode($case,true);
        Storage::disk('local')->append("/test_case_exports/'$testCaseName'.txt", $case->id);
        Storage::disk('local')->append("/test_case_exports/'$testCaseName'.txt", $case->requirement);
        Storage::disk('local')->append("/test_case_exports/'$testCaseName'.txt", $case->component);
        Storage::disk('local')->append("/test_case_exports/'$testCaseName'.txt", $case->method);
        Storage::disk('local')->append("/test_case_exports/'$testCaseName'.txt", $case->input);
        Storage::disk('local')->append("/test_case_exports/'$testCaseName'.txt", $case->expected);
        return view('pages.testCase');
                
    }

    public function update(Request $request)
    {
        //Create Test Case
        $case = new Method;
        $case->id = $request->input('id');
        $case->description = $request->input('description');
        $case->name = $request->input('name');
        $case->location = $request->input('location');
        $case->length = $request->input('length');


        $methodCaseName=$case->method . "Client" . $case->id;
        $objs = json_decode($case,true);
        Storage::disk('local')->append("/method_exports/'$methodCaseName'.txt", $case->id);
        Storage::disk('local')->append("/method_exports/'$methodCaseName'.txt", $case->description);
        Storage::disk('local')->append("/method_exports/'$methodCaseName'.txt", $case->name);
        Storage::disk('local')->append("/method_exports/'$methodCaseName'.txt", $case->location);
        Storage::disk('local')->append("/method_exports/'$methodCaseName'.txt", $case->length);
    }
}
