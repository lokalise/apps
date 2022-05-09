<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\RequestStack;
use Symfony\Component\HttpFoundation\Session\SessionInterface;
use Symfony\Contracts\HttpClient\HttpClientInterface;

abstract class OAuthAuthenticatedController extends AbstractController
{
    protected SessionInterface $session;
    protected HttpClientInterface $client;

    public function __construct(RequestStack $requestStack, HttpClientInterface $client) {
        $this->session = $requestStack->getSession();
        $this->client = $client->withOptions([
            'auth_bearer' => $this->session->get('lokalise.oauth.token', 'no-token')
        ]);
    }

    protected function checkToken(): bool
    {
        return !empty($this->session->get('lokalise.oauth.token', null));
    }

    protected function checkProjectId(): bool
    {
        return !empty($this->session->get('lokalise.oauth.project_id', null));
    }
}
