<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class CreateTableTrainerRoles extends Migration
{
    public function up()
    {
        if (!Schema::hasTable('trainer_roles')) {
            Schema::create('trainer_roles', function (Blueprint $table) {
                $table->increments('id');
                $table->string('name');
            });

            $roles = [
                ['name' => 'Player'],
                ['name' => 'VIP'],
                ['name' => 'Admin']
            ];

            DB::table('trainer_roles')->insert($roles);
        }
    }

    public function down()
    {
        if (Schema::hasTable('trainer_roles')) {
            Schema::dropIfExists('trainer_roles');
        }
    }
}
