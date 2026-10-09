<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use App\Models\Experience;

class ExperienceSeeder extends Seeder
{
    public function run(): void
    {
        Experience::create([
            'position' => 'Web Developer',
            'company' => 'PT Teknologi Indonesia',
            'description' => 'Mengembangkan dan memelihara aplikasi berbasis web.',
            'start_year' => 2018,
            'end_year' => 2021,
        ]);

        Experience::create([
            'position' => 'Senior Web Developer',
            'company' => 'CV Digital Nusantara',
            'description' => 'Mengembangkan aplikasi web dan melakukan pemeliharaan sistem.',
            'start_year' => 2021,
            'end_year' => null,
        ]);
    }
}
