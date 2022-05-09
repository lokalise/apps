<?php

namespace App\Controller;

use Lokalise\LokaliseApiClient;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\Finder\Finder;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Translation\Reader\TranslationReaderInterface;
use Symfony\Contracts\Translation\TranslatorInterface;

class DebugController extends AbstractController
{
    #[Route('/debug', name: 'deb')]
    public function debug(): Response
    {
        return new Response(var_export($_SERVER));
    }
}
