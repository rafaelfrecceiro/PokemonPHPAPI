<?php

namespace App\Http\Controllers;

use App\Pokemon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class PokemonController extends Controller
{
    public function getPokemonsByTrainerId(Request $request, $id)
    {
        return response()->json(Pokemon::where('trainer_id', $id)->get());
    }
}
