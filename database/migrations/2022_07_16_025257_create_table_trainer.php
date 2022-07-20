<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateTableTrainer extends Migration
{
    public function up()
    {
        if (!Schema::hasTable('trainer')) {
            Schema::create('trainer', function (Blueprint $table) {
                $table->increments('id');
                $table->string('name');
                $table->string('email');
                $table->string('password');
                $table->unsignedInteger('role_id');
                $table->boolean('vip');
                $table->integer('level');
                $table->integer('exp');
                $table->integer('money');
                $table->integer('coins');
                $table->foreign('role_id')->references('id')->on('trainer_roles');
            });
        }
    }

    public function down()
    {
        if (Schema::hasTable('trainer')) {
            Schema::dropIfExists('trainer');
        }
    }
}
