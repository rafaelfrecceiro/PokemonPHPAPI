<?php

use Illuminate\Support\Facades\Schema;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Database\Migrations\Migration;

class InsertTrainerAdmin extends Migration
{
    public function up()
    {
        if (!Schema::hasColumn('trainer', 'username')) {
            Schema::table('trainer', function (Blueprint $table) {
                $table->string('username');
            });
        }

        $trainers = [
            ['name' => 'Admin', 'username' => 'Admin', 'email' => 'admin@pokemon.com.br', 'password' => 'admin', 'role_id' => 3, 'vip' => true, 'level' => 1, 'exp' => 0, 'money' => 0, 'coins' => 0],
            ['name' => 'AdminPlayer', 'username' => 'AdminPlayer' ,'email' => 'adminPlayer@pokemon.com.br', 'password' => 'admin', 'role_id' => 1, 'vip' => false, 'level' => 1, 'exp' => 0, 'money' => 0, 'coins' => 0],
            ['name' => 'AdminPlayerVIP', 'username' => 'AdminPlayerVIP' , 'email' => 'adminPlayerVIP@pokemon.com.br', 'password' => 'admin', 'role_id' => 2, 'vip' => true, 'level' => 1, 'exp' => 0, 'money' => 0, 'coins' => 0],
        ];

        DB::table('trainer')->insert($trainers);
    }

    public function down()
    {
        if (Schema::hasColumn('trainer', 'username')) {
            Schema::table('trainer', function (Blueprint $table) {
                $table->dropColumn('username');
            });
        }

        DB::table('trainer')->where('username', 'Admin')->delete();
        DB::table('trainer')->where('username', 'AdminPlayer')->delete();
        DB::table('trainer')->where('username', 'AdminPlayerVIP')->delete();
    }
}
