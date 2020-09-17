#include "ControlPortTCP.hh"

#include <iostream>

/**
 * @brief ControlPortTCP::ControlPortTCP
 */
ControlPortTCP::ControlPortTCP(): isControlPortThreadRunning(false),
    port(8190)
{

}

/**
 * @brief ControlPortTCP::~ControlPortTCP
 */
ControlPortTCP::~ControlPortTCP() {
    isControlPortThreadRunning = false;

    if ( thread_id.joinable() ) {
        thread_id.join();
    }

}

/**
 * @brief ControlPortTCP::createListenerThread
 */
void ControlPortTCP::createListenerThread() {

    if ( !isControlPortThreadRunning ) {

        thread_id = std::thread{&ControlPortTCP::listenControlPort, this};

        isControlPortThreadRunning = true;
    }

}

/**
 * @brief ControlPortTCP::listenControlPort
 */
void ControlPortTCP::listenControlPort()
{
    std::thread::id this_id = std::this_thread::get_id();

    std::cout << "thread " << this_id << " running...\n";

    std::this_thread::sleep_for(std::chrono::seconds(1));


    if ( 0 == setupTCP() ) {
        while (1) {

        }
    } else {

    }

}

/**
 * @brief ControlPortTCP::setupTCP
 * @return
 */
int ControlPortTCP::setupTCP()
{
    int opt = 1;

    int valread;
    char buffer[1024] = {0};

    // Creating socket file descriptor
    if ((sockfd = socket(AF_INET, SOCK_STREAM, 0)) == 0)
    {
        std::cerr << "fail to create socket" << std::endl;
        return -1;
    }

    // Initialize server address to zero
    memset(&serverAddress,0,sizeof(serverAddress));

    // Forcefully attaching socket to the port 8080
    if (setsockopt( sockfd, SOL_SOCKET, SO_REUSEADDR | SO_REUSEPORT,
                    &opt, sizeof(opt)))
    {
        std::cerr << "setsockopt error" << std::endl;
        return -1;
    }

    serverAddress.sin_family      = AF_INET;
    serverAddress.sin_addr.s_addr = htonl(INADDR_ANY);
    serverAddress.sin_port        = htons(port);

    if((::bind(sockfd,(struct sockaddr *)&serverAddress, sizeof(serverAddress))) < 0){
        std::cerr << "Bind error" << std::endl;
        return -1;
    }

    if ( listen(sockfd,5) < 0 ) {
        std::cerr << "Listen error" << std::endl;
        return -1;
    }

    if (( clientfd = accept(sockfd, (struct sockaddr *)&clientAddress,
                            (socklen_t*)&clientAddress))<0 )
    {
        perror("accept");
        exit(EXIT_FAILURE);
    }
    valread = read( clientfd , buffer, 1024);
    printf("%s\n",buffer );

    std::thread::id this_id = std::this_thread::get_id();
    std::cout << "thread " << this_id << " running...\n";


    return 0;
}
