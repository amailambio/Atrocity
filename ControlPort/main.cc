#include "ControlPortTCP.hh"

#include <iostream>
#include <thread>
#include <csignal>

void close_app(int s) {
    exit(0);
}

int main()
{
    ControlPortTCP control;

    std::thread::id this_id = std::this_thread::get_id();
    std::cout << "thread " << this_id << " running...\n";

    std::signal(SIGINT, close_app);

    control.createListenerThread();

    return 0;
}
