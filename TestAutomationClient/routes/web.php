<?php

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', 'PagesController@index');


Route::get('dashboard', 'PagesController@dashboard');


Route::get('/insert', function(){
	$json = file_get_contents("../storage/app/template.json");
	$objs = json_decode($json,true);
	foreach ($objs as $obj)  {
		foreach ($obj as $key => $value) {
			$insertArr[str_slug($key,'_')] = $value;
		}
		DB::table('test_cases')->insert($insertArr);
	}
	dd("Finished adding data in examples table");
});


Route::get('/create', 'PagesController@create');

Auth::routes();

Route::get('/home', 'HomeController@index')->name('home');

Auth::routes();

Route::get('/home', 'HomeController@index')->name('home');

Route::resource('testCase', 'PagesController');