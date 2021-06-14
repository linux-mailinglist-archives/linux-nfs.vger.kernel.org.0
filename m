Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8903A6842
	for <lists+linux-nfs@lfdr.de>; Mon, 14 Jun 2021 15:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbhFNNpw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 14 Jun 2021 09:45:52 -0400
Received: from mail-ed1-f51.google.com ([209.85.208.51]:34484 "EHLO
        mail-ed1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232966AbhFNNpw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 14 Jun 2021 09:45:52 -0400
Received: by mail-ed1-f51.google.com with SMTP id cb9so46622940edb.1
        for <linux-nfs@vger.kernel.org>; Mon, 14 Jun 2021 06:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ete0CyVkIgi0Smi+1q6ULfZrJox4QqZt12nqqDMPOEw=;
        b=jKY4jdekpvUxCUql7kYWmIyJnJm1AkKcRvUmXrCQonWZhC1Mqm4X4yWRwGeQ0pwuSj
         +2mLPHNWzYKwR50IIzGJO7NFLNe+pzST+HHauCWLYbn1GRQp6ug8chGNMkGPoHOsBKAh
         TaUgPY7GdqPVd7o6Sc40Dwn7lkNrVs9IKMuCIsZDBTXeuFJ1p/W2L8I3hnT2F6yFgh+/
         IG7bEfEsVhUAcSIigCCA9bDT1ZOL0PmzNdfYypjapUOlPZI6/5ztA+yEllZWv6/RnJu1
         uwQG+GRxdcGpyms7Av1trU79zfkYNZhrGjS/MudoI0pDt8LtTuQ0TtRbHVKGzIFkSzUx
         lcDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ete0CyVkIgi0Smi+1q6ULfZrJox4QqZt12nqqDMPOEw=;
        b=BxorNRRiTqFMQq1BNrYGzYF9CHgOGI5rFuzM8xc6MmfuyavJgEc/vC/3uTALuAb6nN
         5t/BOG7O3b6Qlaz6ht1exWiEDBdoE9Aue2Rklcx0RObmh4bHvjECtD1nwnSpQDrH4ucu
         vMQIsRWgQWYnyr1z72JVm86y4KjHddWJ9u1vEOtzY2FWjo4ZywgNMGqVSfELYeJ/jv2M
         yfQhw1q43SEBVw3ZhENoxlx3XDR4ss4KJCoxrypuB65jO7QygC4YWKewJCF5txKga5X+
         xrnBJuzS+kXjHl9IZ3vjV6/RQosQx//nXCZMrveQYkaVOPJCy/fB9QWQON18TmnIeMB3
         HQEw==
X-Gm-Message-State: AOAM5329RZ6UtbYOPTzrvKn7Hzz0aloW3TybdWtocSvoXyzEqMTfFltW
        z3ctxrCXN3s7uhW1wzRi/aVCPNeOq3xBPXCMXMx/YcX+
X-Google-Smtp-Source: ABdhPJz4kCyD4ynxonoN0sVFXgz395JY9oppBtMqpi83KY6lkx5+C+wtuH/V0HiE+6xhG2IkwgzxI6wUef+TyFOlAIA=
X-Received: by 2002:aa7:d344:: with SMTP id m4mr17401659edr.281.1623678169048;
 Mon, 14 Jun 2021 06:42:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210608174657.603256-1-Anna.Schumaker@Netapp.com> <5814a22e-d8d5-a811-4424-48e3b5cb88c5@redhat.com>
In-Reply-To: <5814a22e-d8d5-a811-4424-48e3b5cb88c5@redhat.com>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Mon, 14 Jun 2021 09:42:33 -0400
Message-ID: <CAFX2JfndwPdeHaGTNzAgEwOKKiFK+ky-Uwd=8ySfJb--AktYGQ@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] Add a tool for using the new sysfs files
To:     Steve Dickson <steved@redhat.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Steve,

On Mon, Jun 14, 2021 at 9:16 AM Steve Dickson <steved@redhat.com> wrote:
>
>
>
> On 6/8/21 1:46 PM, schumaker.anna@gmail.com wrote:
> > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> >
> > These patches implement a tool that can be used to read and write the
> > sysfs files, with subcommands! They need Olga's most recent patches to
> > run.
> >
> > The following subcommands are implemented:
> >    nfs-sysfs.py rpc-client
> >    nfs-sysfs.py xprt
> >    nfs-sysfs.py xprt set
> >    nfs-sysfs.py xprt-switch
> >    nfs-sysfs.py xprt-switch set
> >
> > So you can print out information about every xprt-switch with:
> >       anna@client % ./nfs-sysfs.py xprt-switch
> >       switch 0: num_xprts 1, num_active 1, queue_len 0
> >               xprt 0: local, /var/run/gssproxy.sock
> >       switch 1: num_xprts 1, num_active 1, queue_len 0
> >               xprt 1: local, /var/run/rpcbind.sock
> >       switch 2: num_xprts 4, num_active 4, queue_len 0
> >               xprt 2: tcp, 192.168.111.188
> >               xprt 3: tcp, 192.168.111.188
> >               xprt 5: tcp, 192.168.111.188
> >               xprt 6: tcp, 192.168.111.188
> >       switch 3: num_xprts 1, num_active 1, queue_len 0
> >               xprt 7: tcp, 192.168.111.1
> >       switch 4: num_xprts 1, num_active 1, queue_len 0
> >               xprt 4: tcp, 192.168.111.188
> >
> > And information about each xprt:
> >       anna@client % ./nfs-sysfs.py xprt
> >       xprt 0: local, /var/run/gssproxy.sock, state <CONNECTED,BOUND>, num_reqs 2
> >               cur_cong 0, cong_win 256, min_num_slots 2, max_num_slots 65536
> >               binding_q_len 0, sending_q_len 0, pending_q_len 0, backlog_q_len 0
> >       xprt 1: local, /var/run/rpcbind.sock, state <CONNECTED,BOUND>, num_reqs 2
> >               cur_cong 0, cong_win 256, min_num_slots 2, max_num_slots 65536
> >               binding_q_len 0, sending_q_len 0, pending_q_len 0, backlog_q_len 0
> >       xprt 2: tcp, 192.168.111.188, state <CONNECTED,BOUND>, num_reqs 2
> >               cur_cong 0, cong_win 256, min_num_slots 2, max_num_slots 65536
> >               binding_q_len 0, sending_q_len 0, pending_q_len 0, backlog_q_len 0
> >       xprt 3: tcp, 192.168.111.188, state <CONNECTED,BOUND>, num_reqs 2
> >               cur_cong 0, cong_win 256, min_num_slots 2, max_num_slots 65536
> >               binding_q_len 0, sending_q_len 0, pending_q_len 0, backlog_q_len 0
> >       xprt 4: tcp, 192.168.111.188, state <BOUND>, num_reqs 2
> >               cur_cong 0, cong_win 256, min_num_slots 2, max_num_slots 65536
> >               binding_q_len 0, sending_q_len 0, pending_q_len 0, backlog_q_len 0
> >       xprt 5: tcp, 192.168.111.188, state <CONNECTED,BOUND>, num_reqs 2
> >               cur_cong 0, cong_win 256, min_num_slots 2, max_num_slots 65536
> >               binding_q_len 0, sending_q_len 0, pending_q_len 0, backlog_q_len 0
> >       xprt 6: tcp, 192.168.111.188, state <CONNECTED,BOUND>, num_reqs 2
> >               cur_cong 0, cong_win 256, min_num_slots 2, max_num_slots 65536
> >               binding_q_len 0, sending_q_len 0, pending_q_len 0, backlog_q_len 0
> >       xprt 7: tcp, 192.168.111.1, state <CONNECTED,BOUND>, num_reqs 2
> >               cur_cong 0, cong_win 256, min_num_slots 2, max_num_slots 65536
> >               binding_q_len 0, sending_q_len 0, pending_q_len 0, backlog_q_len 0
> >
> > You can use the `set` subcommand to change the dstaddr of individual xprts:
> >       anna@client % ./nfs-sysfs.py xprt --id 2
> >       xprt 2: tcp, 192.168.111.188, state <CONNECTED,BOUND>, num_reqs 2
> >               cur_cong 0, cong_win 256, min_num_slots 2, max_num_slots 65536
> >               binding_q_len 0, sending_q_len 0, pending_q_len 0, backlog_q_len 0
> >       anna@client % sudo ./nfs-sysfs.py xprt set --id 2 --dstaddr server2.nowheycreamery.vm
> >       xprt 2: tcp, 192.168.111.186, state <CONNECTED,BOUND>, num_reqs 2
> >               cur_cong 0, cong_win 256, min_num_slots 2, max_num_slots 65536
> >               binding_q_len 0, sending_q_len 0, pending_q_len 0, backlog_q_len 0
> >
> > Or for changing the dstaddr of all xprts attached to a switch:
> >       anna@client % ./nfs-sysfs.py xprt-switch --id 2
> >       switch 2: num_xprts 4, num_active 4, queue_len 0
> >               xprt 2: tcp, 192.168.111.188
> >               xprt 3: tcp, 192.168.111.188
> >               xprt 5: tcp, 192.168.111.188
> >               xprt 6: tcp, 192.168.111.188
> >       anna@client % sudo ./nfs-sysfs.py xprt-switch set --id 2 --dstaddr server2.nowheycreamery.vm
> >       switch 2: num_xprts 4, num_active 4, queue_len 0
> >               xprt 2: tcp, 192.168.111.186
> >               xprt 3: tcp, 192.168.111.186
> >               xprt 5: tcp, 192.168.111.186
> >               xprt 6: tcp, 192.168.111.186
> >
> >
> > I'm sure this needs lots of polish before it's ready for inclusion,
> > along with needing a Makefile so it can be installed (I've just been
> > running it out of the nfs-utils/tools/nfs-sysfs/ directory). But it's
> > still a start, and I wanted to post it before going on New Baby Leave
> > Part 2 (June 12 - July 11).
> >
> > What does everybody think?
> The first thing that popped in my was is where is the man page,
> but this being a developers tool, maybe one is not needed?? (ala pynfs).
> Although if its going to be installed from nfs-utils, it would
> be nice to have a man page.

Yeah, I was expecting to write a man page at some point before a
non-RFC submission, since commands and options might change after
hearing feedback from everyone.
>
> The second thing was I was thinking... it would be good if
> we could run this command on a kernel dump... to see what was
> going on when things crashed...

That would be useful, but I'm having trouble conceptualizing how that
would work since the contents of each file are generated by the kernel
when the files are read. If there is a way to do it, then the tool
could definitely be expanded to add it in!

>
> Nice work!

Thanks!
Anna
>
> steved.
>
> > Anna
> >
> >
> > Anna Schumaker (6):
> >    nfs-sysfs: Add an nfs-sysfs.py tool
> >    nfs-sysfs.py: Add a command for printing xprt switch information
> >    nfs-sysfs.py: Add a command for printing individual xprts
> >    nfs-sysfs.py: Add a command for printing rpc-client information
> >    nfs-sysfs.py: Add a command for changing xprt dstaddr
> >    nfs-sysfs.py: Add a command for changing xprt-switch dstaddrs
> >
> >   tools/nfs-sysfs/client.py    | 27 ++++++++++++++
> >   tools/nfs-sysfs/nfs-sysfs.py | 23 ++++++++++++
> >   tools/nfs-sysfs/switch.py    | 51 +++++++++++++++++++++++++++
> >   tools/nfs-sysfs/sysfs.py     | 28 +++++++++++++++
> >   tools/nfs-sysfs/xprt.py      | 68 ++++++++++++++++++++++++++++++++++++
> >   5 files changed, 197 insertions(+)
> >   create mode 100644 tools/nfs-sysfs/client.py
> >   create mode 100755 tools/nfs-sysfs/nfs-sysfs.py
> >   create mode 100644 tools/nfs-sysfs/switch.py
> >   create mode 100644 tools/nfs-sysfs/sysfs.py
> >   create mode 100644 tools/nfs-sysfs/xprt.py
> >
>
