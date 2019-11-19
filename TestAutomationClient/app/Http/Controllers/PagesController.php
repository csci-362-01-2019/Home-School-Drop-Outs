<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\TestCase;

class PagesController extends Controller
{
    public function index() {
        return view('welcome');
    }

    public function dashboard() {
        $testCases = TestCase::all();
        return view('pages.dashboard', compact('testCases'));
    }
}
