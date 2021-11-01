<?php

namespace X\Commands;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Str;
use Psy\Command\Command;
use Psy\Input\CodeArgument;
use Symfony\Component\Console\Helper\Table;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use X\Tinker;

class Models extends Command
{
    protected function configure()
    {
        $this->setName('models')
            ->setAliases(['m'])
            ->setDescription('List all models')
            ->setDefinition([
                new CodeArgument('filter', CodeArgument::OPTIONAL, 'show only models matching this string'),
            ]);
    }

    protected function execute(InputInterface $input, OutputInterface $output)
    {
        $filter = $input->getArgument('filter');

        $table = new Table($output);
        $table->setHeaders(['Namespace', 'Model']);

        $classes = Tinker::getSubclasses(Model::class);
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
