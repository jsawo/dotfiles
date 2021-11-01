<?php

namespace X\Commands;

use Illuminate\Routing\Controller;
use Illuminate\Support\Str;
use Psy\Command\Command;
use Psy\Input\CodeArgument;
use Symfony\Component\Console\Helper\Table;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use X\Tinker;

class Controllers extends Command
{
    protected function configure()
    {
        $this->setName('controllers')
            ->setAliases(['c'])
            ->setDescription('List all controllers')
            ->setDefinition([
                new CodeArgument('filter', CodeArgument::OPTIONAL, 'show only controllers matching this string'),
            ]);
    }

    protected function execute(InputInterface $input, OutputInterface $output)
    {
        $filter = $input->getArgument('filter');

        $table = new Table($output);
        $table->setHeaders(['Namespace', 'Controller']);

        $classes = Tinker::getSubclasses(Controller::class);
        foreach ($classes as $class) {
            if (Str::of($filter)->trim()->isNotEmpty
                && !Str::of($class)->lower()->contains(strtolower($filter))) {
                continue;
            }

            $table->addRow([
                Str::of($class)->beforeLast('\\'),
                Str::of($class)->afterLast('\\'),
            ]);
        }

        $table->render();

        return 0;
    }
}
