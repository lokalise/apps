<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Session\SessionInterface;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Routing\Generator\UrlGeneratorInterface;
use Symfony\Contracts\HttpClient\HttpClientInterface;

class OAuthController extends AbstractController
{
    #[Route('/oauth', name: 'oauth_home')]
    public function index(SessionInterface $session): Response
    {
        return $this->render('o_auth/index.html.twig',[
            'lokaliseToken' => $session->get('lokalise.oauth.token', null),
            'lokaliseRefreshToken' => $session->get('lokalise.oauth.refresh_token', null),
            'lokaliseProjectId' => $session->get('lokalise.oauth.project_id', null),
        ]);
    }


    #[Route('/oauth/authenticate', name: 'oauth_authenticate')]
    public function authenticate(SessionInterface $session): Response
    {
        // Generate a new state and store it for lookup later
        $state = uniqid('lok.oauth', true);
        $session->set('lokalise.oauth.state', $state);

        $redirectUri = $this->generateUrl('oauth_callback');

        // Build the redirect URL and redirect the user to that
        $params = [
            'client_id' => $this->getParameter('lokalise.oauth.client_id'),
            'scope' => implode(' ', $this->getParameter('lokalise.oauth.scopes')),
            'redirect_uri' => $this->generateUrl('oauth_callback', [], UrlGeneratorInterface::ABSOLUTE_URL),
            'state' => $state,
        ];

        $authUrl = $this->getParameter('lokalise.oauth.endpoint') . 'auth?' . http_build_query($params);

        return $this->redirect($authUrl);
    }


    #[Route('/oauth/callback', name: 'oauth_callback')]
    public function callback(SessionInterface $session, Request $request, HttpClientInterface $client): Response
    {
        $code = $request->get('code', null);

        // Check the integrity of the request
        if (empty($code) || $session->get('lokalise.oauth.state', 'state1') !== $request->get('state', 'state2') ) {
            return $this->redirect($this->generateUrl('oauth_home'));
        }

        // Get the tokens based on the code returned
        $params = [
            'grant_type' => 'authorization_code',
            'code' => $code,
            'client_id' => $this->getParameter('lokalise.oauth.client_id'),
            'client_secret' => $this->getParameter('lokalise.oauth.client_secret'),
        ];

        $response = $client->request('POST', $this->getParameter('lokalise.oauth.endpoint') . 'token', [
            'json' => $params
        ]);

        // Store the token data in session
        $responseData = $response->toArray();
        $session->set('lokalise.oauth.token', $responseData['access_token'] ?? null);
        $session->set('lokalise.oauth.refresh_token', $responseData['refresh_token'] ?? null);
        $session->set('lokalise.oauth.project_id', null);

        return $this->redirect($this->generateUrl('oauth_home'));
    }

    #[Route('/oauth/logout', name: 'oauth_logout')]
    public function logout(SessionInterface $session): Response
    {
        $session->set('lokalise.oauth.token', null);
        $session->set('lokalise.oauth.refresh_token', null);
        $session->set('lokalise.oauth.project_id', null);

        return $this->redirect($this->generateUrl('oauth_home'));
    }
}
