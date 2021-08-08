Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0CF63E3C50
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Aug 2021 21:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbhHHTAm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Aug 2021 15:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbhHHTAm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Aug 2021 15:00:42 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D8FC061760
        for <linux-nfs@vger.kernel.org>; Sun,  8 Aug 2021 12:00:21 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id f13so21165193edq.13
        for <linux-nfs@vger.kernel.org>; Sun, 08 Aug 2021 12:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rtz9EDxkUvrvQJz/PXSjblyuB4TRik9lbi8mRwJxa2Q=;
        b=l9XFRb2suZxNhfcmj1lcJrdqcJ4aPgqNSr/aecs52z5MA+phbbZHoICWeR0YeGL0G0
         swA5p8vQ7hF2oQX8ZauA/Ncxr5ToSU0dhTiz9u9EwX9Ru0Oq4gvaLLvsdFRl53a30h86
         5NDirO/NfM5N8ix8yb4bIpiwtJmO3wAtDDioAjKmWfGVLlNUUr8rlOGsgwYe0XSl8Dpl
         ezpPeJdnVspY/JcvHoAlSMB2MmZVnr0AWuyCxedekQ+bStst+Z/yh+Zp9mchBsv9h/oi
         TYwOI8KH+/Nt4mHj17/VYrTWbLEQAi/AlqWeG2L2ONxiA//HETmu6AKZtsk2e9MWywEG
         Qb9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rtz9EDxkUvrvQJz/PXSjblyuB4TRik9lbi8mRwJxa2Q=;
        b=gtPagPI9xa/8+JbG/MrjFXFdt7jRfUyM0iGV1yLQ7c4RXP4a4AXHGQygULMGabZyv6
         6EdMHxK0pqjIRfwiYNx84Bdl31tMrOEXteSviThhy/vbSN6RuBSGpgX3kjM3m24BZT8W
         idL0ajqH1IpQi054TdGLYGh5rZ6nnFXBT3FgRQ451+/0E1RvKxUCJ+4wq/QAQmqCrY0g
         4huNt0ZRvDixQmIulqg3FJ8EvqYt8CG+QsM8hSvKMtZ+YK+TszLyjBn6W2Ho/HGSWsf3
         UjHebPcEOOT/NGbUDXRaykwJYWlOHrqWgTB8rlYjkBhj6W9mWb6jhnT5MuCgAT96pS2k
         ldSA==
X-Gm-Message-State: AOAM531hkH18k8fmE9adQbXkbOBtL/VKGjwMLW0oETqZdI9ZpJLBalkp
        RklqqY+obanGnG8xTTihwlq8inRcqagsO0o6P2U=
X-Google-Smtp-Source: ABdhPJx9M25HbFQXFdThPLulD8nVCPYjZEHegYiK2BMSkJtyWoJXKkoOaQiapFCAQIn21uC07MjS/BPXsxberYrtFvs=
X-Received: by 2002:a05:6402:1458:: with SMTP id d24mr25496624edx.281.1628449220333;
 Sun, 08 Aug 2021 12:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210806201739.472806-1-Anna.Schumaker@Netapp.com> <50f2d601-70ce-81ec-11f1-1bdc5ae526c6@redhat.com>
In-Reply-To: <50f2d601-70ce-81ec-11f1-1bdc5ae526c6@redhat.com>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Sun, 8 Aug 2021 15:00:04 -0400
Message-ID: <CAFX2Jfk2N=5ifEuwKXJbW2vLFPnmaA7TLgMUoNte_uJxPjSU6w@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] Add a tool for using the new sysfs files
To:     Steve Dickson <steved@redhat.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Steve,

On Sun, Aug 8, 2021 at 12:30 PM Steve Dickson <steved@redhat.com> wrote:
>
> Hey Anna,
>
> On 8/6/21 4:17 PM, schumaker.anna@gmail.com wrote:
> > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> >
> > These patches implement a tool that can be used to read and write the
> > sysfs files, with subcommands! They do need my extra patches to add in
> > srcaddr and dst_port to the xprt_info file. Let me know if I need to
> > resend adding support for kernels both with and without these patches.
> >
> > The following subcommands are implemented:
> >       nfs-sysfs.py rpc-client
> >       nfs-sysfs.py xprt
> >       nfs-sysfs.py xprt set
> >       nfs-sysfs.py xprt-switch
> >       nfs-sysfs.py xprt-switch set
> >
> > So you can print out information about every xprt-switch with:
> >       anna@client ~ % nfs-sysfs xprt-switch
> >       switch 0: num_xprts 1, num_active 1, queue_len 0
> >               xprt 0: local, /var/run/gssproxy.sock [main]
> >       switch 1: num_xprts 1, num_active 1, queue_len 0
> >               xprt 1: local, /var/run/rpcbind.sock [main]
> >       switch 2: num_xprts 1, num_active 1, queue_len 0
> >               xprt 2: tcp, 192.168.111.1 [main]
> >       switch 3: num_xprts 4, num_active 4, queue_len 0
> >               xprt 3: tcp, 192.168.111.188 [main]
> >               xprt 4: tcp, 192.168.111.188
> >               xprt 5: tcp, 192.168.111.188
> >               xprt 6: tcp, 192.168.111.188
> >
> > And information about each xprt:
> >       anna@client ~ % nfs-sysfs xprt
> >       xprt 0: local, /var/run/gssproxy.sock, port 0, state <MAIN,CONNECTED,BOUND>
> >               Source: (einval), port 0, Requests: 2
> >               Congestion: cur 0, win 256, Slots: min 2, max 65536
> >               Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
> >       xprt 1: local, /var/run/rpcbind.sock, port 0, state <MAIN,CONNECTED,BOUND>
> >               Source: (einval), port 0, Requests: 2
> >               Congestion: cur 0, win 256, Slots: min 2, max 65536
> >               Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
> >       xprt 2: tcp, 192.168.111.1, port 2049, state <MAIN,CONNECTED,BOUND>
> >               Source: 192.168.111.222, port 959, Requests: 2
> >               Congestion: cur 0, win 256, Slots: min 2, max 65536
> >               Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
> >       xprt 3: tcp, 192.168.111.188, port 2049, state <MAIN,CONNECTED,BOUND>
> >               Source: 192.168.111.222, port 921, Requests: 2
> >               Congestion: cur 0, win 256, Slots: min 2, max 65536
> >               Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
> >       xprt 4: tcp, 192.168.111.188, port 2049, state <CONNECTED,BOUND>
> >               Source: 192.168.111.222, port 726, Requests: 2
> >               Congestion: cur 0, win 256, Slots: min 2, max 65536
> >               Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
> >       xprt 5: tcp, 192.168.111.188, port 2049, state <CONNECTED,BOUND>
> >               Source: 192.168.111.222, port 671, Requests: 2
> >               Congestion: cur 0, win 256, Slots: min 2, max 65536
> >               Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
> >       xprt 6: tcp, 192.168.111.188, port 2049, state <CONNECTED,BOUND>
> >               Source: 192.168.111.222, port 934, Requests: 2
> >               Congestion: cur 0, win 256, Slots: min 2, max 65536
> >               Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
> >
> > You can use the `set` subcommand to change the dstaddr of individual xprts:
> >       anna@client ~ % sudo nfs-sysfs xprt --id 4
> >       xprt 4: tcp, 192.168.111.188, port 2049, state <CONNECTED,BOUND>
> >               Source: 192.168.111.222, port 726, Requests: 2
> >               Congestion: cur 0, win 256, Slots: min 2, max 65536
> >               Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
> >       anna@client ~ % sudo nfs-sysfs xprt set --id 4 --dstaddr server2.nowheycreamery.com
> >       xprt 4: tcp, 192.168.111.186, port 2049, state <CONNECTED,BOUND>
> >               Source: 192.168.111.222, port 726, Requests: 2
> >               Congestion: cur 0, win 256, Slots: min 2, max 65536
> >               Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
> >
> > Or for changing the dstaddr of all xprts attached to a switch:
> >       anna@client % ./nfs-sysfs.py xprt-switch --id 3
> >       switch 3: num_xprts 4, num_active 4, queue_len 0
> >               xprt 3: tcp, 192.168.111.188 [main]
> >               xprt 4: tcp, 192.168.111.188
> >               xprt 5: tcp, 192.168.111.188
> >               xprt 6: tcp, 192.168.111.188
> >       anna@client % sudo ./nfs-sysfs.py xprt-switch set --id 4 --dstaddr server2.nowheycreamery.vm
> >       switch 3: num_xprts 4, num_active 4, queue_len 0
> >               xprt 2: tcp, 192.168.111.186 [main]
> >               xprt 3: tcp, 192.168.111.186
> >               xprt 5: tcp, 192.168.111.186
> >               xprt 6: tcp, 192.168.111.186
> >
> >
> > What does everybody think? Is there any thing I should change about the
> > user input or output lines? How about other subcommands that should be
> > added with the initial submission?
> I have not play around with this new tool.. but I will! Looking
> forward to it... But... and I should have mention this in v1
> my apologies.
>
> The rest of the NFS tools do not have have "nfs-" as the
> prefix only an "nfs"... As with nfs-iostat, I'll me more that
> will to take the patch with the '-' char, but I would
> prefer the  man page and the installed script be call nfssysfs,
> just to say with the current naming conventions.

No problem! Changing the name of the tool should be easy enough. I'm
not committed to the name either, so if anybody has a better name in
mind please let me know!


Anna
>
> steved.
>
> >
> > Thanks,
> > Anna
> >
> >
> > Anna Schumaker (9):
> >    nfs-sysfs: Add an nfs-sysfs.py tool
> >    nfs-sysfs.py: Add a command for printing xprt switch information
> >    nfs-sysfs.py: Add a command for printing individual xprts
> >    nfs-sysfs.py: Add a command for printing rpc-client information
> >    nfs-sysfs.py: Add a command for changing xprt dstaddr
> >    nfs-sysfs.py: Add a command for changing xprt-switch dstaddrs
> >    nfs-sysfs.py: Add a command for changing xprt state
> >    nfs-sysfs: Add a man page
> >    nfs-sysfs: Add installation to the Makefile
> >
> >   .gitignore                    |   2 +
> >   configure.ac                  |   1 +
> >   tools/Makefile.am             |   2 +-
> >   tools/nfs-sysfs/Makefile.am   |  20 +++++++
> >   tools/nfs-sysfs/client.py     |  27 +++++++++
> >   tools/nfs-sysfs/nfs-sysfs     |   5 ++
> >   tools/nfs-sysfs/nfs-sysfs.man |  88 +++++++++++++++++++++++++++++
> >   tools/nfs-sysfs/nfs-sysfs.py  |  23 ++++++++
> >   tools/nfs-sysfs/switch.py     |  51 +++++++++++++++++
> >   tools/nfs-sysfs/sysfs.py      |  28 ++++++++++
> >   tools/nfs-sysfs/xprt.py       | 101 ++++++++++++++++++++++++++++++++++
> >   11 files changed, 347 insertions(+), 1 deletion(-)
> >   create mode 100644 tools/nfs-sysfs/Makefile.am
> >   create mode 100644 tools/nfs-sysfs/client.py
> >   create mode 100644 tools/nfs-sysfs/nfs-sysfs
> >   create mode 100644 tools/nfs-sysfs/nfs-sysfs.man
> >   create mode 100755 tools/nfs-sysfs/nfs-sysfs.py
> >   create mode 100644 tools/nfs-sysfs/switch.py
> >   create mode 100644 tools/nfs-sysfs/sysfs.py
> >   create mode 100644 tools/nfs-sysfs/xprt.py
> >
>
