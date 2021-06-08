Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73AFA39FC23
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Jun 2021 18:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbhFHQO2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Jun 2021 12:14:28 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:39550 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232056AbhFHQOJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Jun 2021 12:14:09 -0400
Received: by mail-ed1-f54.google.com with SMTP id dj8so25178375edb.6
        for <linux-nfs@vger.kernel.org>; Tue, 08 Jun 2021 09:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kI/kb9I9qmAqQ2Y+Z2MUVgZfNi4OW4X30xsFwwUs66A=;
        b=TnoDv4QBWv+51q9p6M8HJVwaDCLcxqK5X8prSjHg4j7EPeS9INibTbgmGHKUrext42
         tySkyoswnbsfGDzE7GPyKC/hCI1xZ/jdRXorml5yMg8kmkHE++OvqIRKtbNDgGkCFLuw
         36fRC6qZIJWHkh13ePfpoGWvPejPyyskjCdwEzoGjW0DfBYcpcyxElCJHfEyAiZ+JVly
         Oj+R7c1pyCIV1HgPXz2JSTe4MVTFumgNQIZJ4NORZXLoyfB2dndmAj7ByXtknk5WT0nC
         yn9DiSgGBMrucB7PZeEf1qx/xUYjOt83pPbsjvskou48RLQJLJ0IqKY+YhNsL5lc5QyY
         rBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kI/kb9I9qmAqQ2Y+Z2MUVgZfNi4OW4X30xsFwwUs66A=;
        b=NEMxPUJbO+e8TXpVGHOfz5PDmyUAmfo6EWIPXm1yeQsMiy8jSfRxDf7j0SzmMdjs/M
         EiOYrJhnnWiYxGGYLoynv0q5roSF5EtkCjXyr2jeoartOA7nPobIhfCGndZPekjKlP9J
         V3qKpTsexexwb2TFrjNSByLU5G2ImdtY9WpVBj7QdZZOrocXNpSX1GH3o8V+r+phl3Mj
         GajBo1yMyOhHvciousXUC3yXkii8Z9BrgAyQX3PpboryPLi+e/hMkRlPg8wN4RI6qWiM
         AdmME/4b2IkVqzJSrThuyETZEqr9eVbnpuv2axaVIKEp549AAhXqtoUVcC0MCdG2a4Qg
         xceg==
X-Gm-Message-State: AOAM532d7gdoxuYg8fgTHyDOA5Wksmxvcwi5yUrM9febO4qfmDS2A1G1
        NUYV3tDQhwIvWK5dWhvwYFTy7YjrtFlumf1I8Nx47P6Q
X-Google-Smtp-Source: ABdhPJwWtmKSzExzOk5RnjiskQf3y1lLsvm2bZ8dPOYlx+QJ/yjEvPxJLzdIoeuxSrAxG44Py9G4Bd8OGJqVerGBopc=
X-Received: by 2002:aa7:d555:: with SMTP id u21mr18255400edr.84.1623168664542;
 Tue, 08 Jun 2021 09:11:04 -0700 (PDT)
MIME-Version: 1.0
References: <CO1PR05MB810163D3FD8705AFF519F0B4B72D9@CO1PR05MB8101.namprd05.prod.outlook.com>
 <CAN-5tyGgWx6F2s=t+0UAJJZEAEfNnv+Sq8eeBbnQYocKOOK8Jg@mail.gmail.com>
 <6ae47edc-2d47-df9a-515a-be327a20131d@RedHat.com> <CO1PR05MB8101FD5E77B386A75786FF41B7299@CO1PR05MB8101.namprd05.prod.outlook.com>
 <CAN-5tyFVGexM_6RrkjJPfUPT5T4Z7OGk41gSKeQcoi9cLYb=eA@mail.gmail.com>
 <CO1PR05MB8101B1BB8D1CAA7EE642D8CEB7299@CO1PR05MB8101.namprd05.prod.outlook.com>
 <CAN-5tyEp+4_tiaqxuF7LoLUPt+OFn-C_dmeVVf-2Lse2RXvhqA@mail.gmail.com>
 <43b719c36652cdaf110a50c84154fca54498e772.camel@hammerspace.com>
 <CAN-5tyFUsdHOs05DZw4teb3hGRQ5P+5MqUuE5wEwiP4Ki07cfQ@mail.gmail.com> <CO1PR05MB810120D887411CCDA786A849B7379@CO1PR05MB8101.namprd05.prod.outlook.com>
In-Reply-To: <CO1PR05MB810120D887411CCDA786A849B7379@CO1PR05MB8101.namprd05.prod.outlook.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 8 Jun 2021 12:10:53 -0400
Message-ID: <CAN-5tyHh8zzy5Jokevp8DOqMHsiGDMuSQXX+PyG9s+PraQ8Y2w@mail.gmail.com>
Subject: Re: NFSv4: Mounting NFS server which is down, blocks all other NFS
 mounts on same machine
To:     Michael Wakabayashi <mwakabayashi@vmware.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "SteveD@redhat.com" <SteveD@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jun 8, 2021 at 5:16 AM Michael Wakabayashi
<mwakabayashi@vmware.com> wrote:
>
> Hi Olga,
>
> > > You say that it's taken offline. If it's offline there shouldn't be
> > > anything listening on port 2049. I was only able to reproduce the
> > > problem when a client is able to send a SYN to the server and not
> > > getting a reply back. If the server is offline, there will always be a
> > > reply back (RST or something of the sorts). Client tries a bit but it
> > > never gets stuck in the rpc_execute() state because it would get a
> > > reply from the TCP layer. Your stack is where  there is no TCP reply
> > > from the server.
>
> > I'm actually claiming their infrastructure is broken. He says the
> > server is down. If that's the case, the TCP layer will time out fast
> > and it will not visibly block other mounts. However, if the server is
> > unresponsive, that's what the provided stack shows, then the TCP
> > timeout is much larger. I'm saying the server should truly be
> > unreachable and not unresponsive.
>
> I don't think the infrastructure is broken.
> The behavior we're seeing seems to be correct (explained below).
>
> > If the server is offline, there will always be a reply back
> > (RST or something of the sorts).
>
> > He says the server is down. If that's the case, the TCP layer will
> > time out fast
>
> I believe these two statements are incorrect. Let me explain.
>
> If the server is offline (for example physically unplugged from power)
> then this unplugged server cannot reply. It's a brick.
> CPU, memory, disk and NIC all have zero power.  There's no operating
> system running, the dead server won't see the TCP request packet
> and cannot reply so the following cannot be true:
> > If the server is offline, there will always be a reply back
>
>
> Here's what's happening at the TCP layer:
> I took a TCP packet capture (see attached nfsv4.pcap file) and can see the
> NFS client(10.162.132.231) attempting a 3-way TCP handshake with the

Sending a SYN will only happen during the time that client had a valid
ARP entry in its cache from a previous connection. As soon as the ARP
cache is invalidated/updated and there is no value address to resolve
the 'bad' mount would be time out faster (that's when all the other
mounts would be unblocked but the hanging mount would take longer to
retry a number of times).

> powered-off/offline server(2.2.2.2).  The client sends a TCP SYN to
> the NFS server.  But the NFS server is powered off, so the NFS client
> times out waiting for the TCP SYN-ACK reply.  On timeout, the NFS client
> will retransmit the TCP SYN packet, and eventually time out again
> waiting for the SYN-ACK reply.  This process repeats itself until TCP
> retransmits are exhausted.  Eventually the NFS client mount command
> gives up (after 3 minutes) and exits.
>
> During this 3 minute period every other NFS mount command on the host where
> the NFS client is running is blocked; this effectively caused a
> denial of service attack since no other user was able to NFS mount anything,
> including perfectly valid NFS mounts.
> To make matters worse, after the mount command exited, the workload would
> retry the powered off mount command again extending the duration of the
> inadvertent denial of service.
>
> > He says the server is down. If that's the case, the TCP layer will
> > time out fast
>
> As described above, the 3-way TCP handshake timeout is relatively slow and
> the mount command takes 3 minutes to exit.
>
> I believe you're thinking of the case when the NFS server is powered-on,
> but has no Linux process listening on NFS port 2049. In this case
> the NFS server --will-- reply  quickly (within milliseconds) with a
> TCP RST/Reset packet and the NFS client will quickly exit the mount process
> with an error code.
>
> > There are valid protocol reasons why the NFSv4 client has to check
> > whether or not the new mount is really talking to the same server but
> > over a different IP addresses.
>
> Hi Trond,
>
> I ran the following script:
>     #!/bin/sh -x
>     mount -o vers=4 -v -v -v 2.2.2.2:/fake_path /tmp/mnt.dead &
>     echo PID_OF_DEAD_BG_MOUNT=$!
>     sleep 5 # give time for the first mount to execute in the background
>     mount -o vers=4 -v -v -v 10.188.76.67:/git /tmp/mnt.alive
> on Ubuntu 21.04, MacOS 11.1 and FreeBSD 11.4.
>
> The undesirable blocking behavior only appeared on Ubuntu.
> MacOs and FreeBSD executed the script fine meaning the 10.188.76.67:/git
> NFS share immediately and successfully mounted without blocking.
>
> On Ubuntu, a user runs "mount <unreachable-ip-address>:<fake-path>"
> which blocks mounts for every other user on the system, this is undesirable.
> Our virtual machines basically crashed because we had several hundred
> to several thousand blocked mount processes preventing workloads from
> making progress.
>
> We'd prefer the mount behavior of the MacOS or FreeBSD implementations,
> even if it's less secure, since at least it's not taking down
> our servers with an unintentional DoS attack.
>
> Is there any chance of looking at the FreeBSD mount implementation and seeing
> if it is correct, and if so, have the Linux mount command emulate this behavior?
>
> Thanks, Mike
>
> p.s.
> I've attached the following 4 files which were generated on Ubuntu 21.04:
>   1. mount_hang.sh: script running mount test
>   2. mount_hang.sh.log: output of mount_hang.sh
>   3. trace_pipe.txt: output of: cat /sys/kernel/debug/tracing/trace_pipe > trace_pipe.txt
>                         with events/sunrpc/enable set to 1
>                              events/nfs4/enable   set to 1
>   4. nfsv4.pcap: output of "tcpdump -v -v -v -v  -s 0 -w /tmp/nfsv4.pcap port 2049"
>
> The test procedure was:
> - run mount_hang.sh on the Ubunut 21.04 VM
> - after seeing the second mount command execute
> - wait about 5 seconds
> - press control-C to exit the mount_hang.sh script.
