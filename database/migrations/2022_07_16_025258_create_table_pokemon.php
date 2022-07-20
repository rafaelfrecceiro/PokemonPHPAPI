<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateTablePokemon extends Migration
{
    public function up()
    {
        if (!Schema::hasTable('pokemon')) {
            Schema::create('pokemon', function (Blueprint $table) {
                $table->increments('id');
                $table->string('name');
                $table->integer('attack');
                $table->integer('defense');
                $table->integer('speed');
                $table->integer('hp');
                $table->integer('level');
                $table->integer('exp');
                $table->integer('hash');
                $table->unsignedInteger('trainer_id');
                $table->foreign('trainer_id')->references('id')->on('trainer');
            });
        }
    }

    public function down()
    {
        if (Schema::hasTable('pokemon')) {
            Schema::dropIfExists('pokemon');
        }
    }
}
