<?php

namespace X\Commands;

use Artisan as LaravelArtisan;
use Psy\Command\Command;
use Psy\Input\CodeArgument;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;

class Artisan extends Command
{
    protected function configure()
    {
        $this->setName('artisan')
            ->setAliases(['a'])
            ->setDescription('run artisan commands')
            ->setDefinition([
                new CodeArgument('target', CodeArgument::OPTIONAL, 'actual command to run'),
            ]);
    }

    protected function execute(InputInterface $input, OutputInterface $output)
    {
        $target = $input->getArgument('target');

        $cmd = $target;
        if (empty($target)) {
            $cmd = 'list';
        }

        LaravelArtisan::call($cmd);
        $output->writeln(LaravelArtisan::output());

        return 0;
    }
}
