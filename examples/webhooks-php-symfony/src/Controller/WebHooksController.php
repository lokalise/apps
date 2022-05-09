<?php

namespace App\Controller;

use Psr\Log\LoggerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Session\SessionInterface;
use Symfony\Component\Routing\Annotation\Route;

class WebHooksController extends AbstractController
{
    #[Route('/', name: 'app_hooks_home')]
    public function index(SessionInterface $session): Response
    {
        return $this->render('web_hooks/index.html.twig');
    }

    #[Route('/registerHook', name: 'app_hooks_register', methods: ['POST'])]
    public function registerWebhook(SessionInterface $session, Request $request): Response
    {
        $projectId = $request->request->get('projectId', null);

        if (empty($projectId)) {
            $this->addFlash('notice', 'Please enter a project id');
            return $this->redirect($this->generateUrl('app_hooks_home'));
        }

        $client = new \Lokalise\LokaliseApiClient($this->getParameter('lokalise.api_token'));

        $client->webhooks->create(
            $projectId,
            [
                'url' => 'https://50e1-90-133-221-110.eu.ngrok.io/triggerHook',
                'events' => [
                    'project.key.added',
                ],
            ]
        );


        $this->addFlash('notice', 'Hook registered');

        return $this->redirect($this->generateUrl('app_hooks_home'));
    }

    #[Route('/triggerHook', name: 'app_hooks_trigger', methods: ['POST'])]
    public function triggerHook(Request $request): Response
    {
        $data = json_decode($request->getContent(), true, 5, JSON_THROW_ON_ERROR);
        $event = $data['event'] ?? null;

        if ($event === 'project.key.added') {
            $keyId = $data['key']['id'] ?? null;
            $projectId = $data['project']['id'] ?? null;

            if ($projectId && $keyId) {
                $client = new \Lokalise\LokaliseApiClient($this->getParameter('lokalise.api_token'));
                $client->comments->create($projectId, $keyId, [
                    'comments' => [
                        [
                            'comment' => 'Hi, please check if this key complies with our guidelines!',
                        ],
                    ]
                ]);
                $client->keys->update($projectId, $keyId, [
                    'is_hidden' => true
                ]);
            }
        }

        return new Response('ok');
    }
}
