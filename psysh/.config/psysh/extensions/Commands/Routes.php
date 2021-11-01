<?php

namespace X\Commands;

use Illuminate\Support\Facades\Route;
use Illuminate\Support\Arr;
use Illuminate\Support\Str;
use Psy\Command\Command;
use Psy\Input\CodeArgument;
use Symfony\Component\Console\Helper\Table;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use X\Tinker;

class Routes extends Command
{
    protected function configure()
    {
        $this->setName('routes')
            ->setAliases(['r'])
            ->setDescription('List all routes')
            ->setDefinition([
                new CodeArgument('filter', CodeArgument::OPTIONAL, 'show only routes with uri matching this string'),
            ]);
    }

    protected function execute(InputInterface $input, OutputInterface $output)
    {
        $table = new Table($output);
        $table->setHeaders(['URI', 'Method', 'Middleware', 'Action']);

        $filter = $input->getArgument('filter');

        collect(Route::getRoutes()->getRoutes())
            ->sortBy('uri')
            ->each(function ($r) use ($table, $filter) {
                $uri = Str::of($r->uri);
                if (Str::of($filter)->trim()->isNotEmpty && !$uri->contains($filter)) {
                    return;
                }

                $action = Arr::has($r->action, 'controller')
                    ? Str::of($r->action['controller'])->afterLast('\\')
                        ->replaceLast('@', ' @ <info>')->finish('</info>')
                    : '<comment>closure</comment>';

                $middleware = Arr::has($r->action, 'middleware')
                    ? Str::of(collect($r->action['middleware'])->implode(' '))->limit(20)
                    : '';

                $table->addRow([
                    $uri->replaceMatches('/{.*?}/', function ($match) {
                        return "<info>{$match[0]}</info>";
                    }),
                    Str::of(collect($r->methods)->reject("HEAD")->implode(' '))->limit(10),
                    $middleware,
                    $action,
                ]);
            });

        $table->render();

        return 0;
    }
}
