function [nq,nf,nr] = queueEnqueue(queue,front,rear,data)

    nq = queue;
    nq(rear) = data;
    nr = rear + 1;

end