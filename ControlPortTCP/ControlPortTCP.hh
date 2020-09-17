#ifndef CONTROLPORTTCP_HH
#define CONTROLPORTTCP_HH

#include <unistd.h>
#include <stdio.h>
#include <sys/socket.h>
#include <stdlib.h>
#include <netinet/in.h>
#include <string.h>
#include <thread>

class ControlPortTCP
{
public:
    ControlPortTCP();
    virtual ~ControlPortTCP();

    void createListenerThread();
    void listenControlPort();

private:
    int port, sockfd, clientfd;
    struct sockaddr_in serverAddress;
    struct sockaddr_in clientAddress;

    std::thread thread_id;
    bool isControlPortThreadRunning;

    int setupTCP();

};

#endif // CONTROLPORTTCP_HH
