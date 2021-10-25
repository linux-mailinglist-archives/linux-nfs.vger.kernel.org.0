Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D549439EFE
	for <lists+linux-nfs@lfdr.de>; Mon, 25 Oct 2021 21:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbhJYTLk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 25 Oct 2021 15:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbhJYTLj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 25 Oct 2021 15:11:39 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A92C061745
        for <linux-nfs@vger.kernel.org>; Mon, 25 Oct 2021 12:09:17 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id m63so28540353ybf.7
        for <linux-nfs@vger.kernel.org>; Mon, 25 Oct 2021 12:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FRUj1NQw8G1TG/TmVGHX3Tcu1YMVM8XZJHy9FLidP3k=;
        b=QTCeXOhTbNgYDFdgBs2fT6mq3Ztu6bNirNisVcmeeipuYdEYQTacgXdefTMH0LcfLB
         JGp4lQ00g3KO+LKDkIaV93GD13HGNNTnQ+eI+n4870FJKPIrGZVwaQKfyOKQR06NgB6m
         r7Go3fr9NVfokLuV3VBCGVD+esxtRsl/2D2twMq+BcZcEgHit7u4rJRatDaWzddajH3G
         34GnSAKjM8bEVUDRBfPi14tIM5fZke/9cmRLxqEfS1pVN5Gdnt98Kk9PBEfHL8kU2u47
         3uQ0pPJJcj3WL8uiAdXpmEsDn02Oo73lCTzv0Vrj7lBGjUTR9mdltvPNxMaqLsCGrZKZ
         y4gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FRUj1NQw8G1TG/TmVGHX3Tcu1YMVM8XZJHy9FLidP3k=;
        b=vB37g1l1K95oj03U66khfBalmYGmtNSz/IXMrpzr1ssvB5bolAllQfphTAAKr0BKXb
         o5qg+utmDtFDP3fL8nFoFVz5trCE5IAJrx5WGyZE3UQ1HtUtPd5UnnrOyMukI5bL1tsG
         TghHObHIJlnGm96wa4qH57hx6qinVi2Q5KOF9PztlwZ6t9vVjcaf/Wk4qvhhVW0TPnv9
         4Fo6tNvRU6Bj6q6+9KzqONOM+e6/sT5k1JXYmDfQWzXg69ihx+5Da200IRyWEFhyYz4H
         /+qqTbvnBbt0qBl0aIhiJ1kGwglZFvPy6ro7gWPDEFCuOLvfZTv7cJeYFrcIhRKf2/nT
         q1/g==
X-Gm-Message-State: AOAM532UbKuHguTlMXUtj95z6T75s/FppAcbImZzq27hL8I/k0rwZW3Q
        eIWA/poYuUrrjdrnj10HjSlcwoD+ZHlzA3BoIoQ=
X-Google-Smtp-Source: ABdhPJzqUmEvXTSYAEwKmdyZT01tmp/oQ2PQYHAD1/lDOl50TS80dn7dx4UcvCan1N4KNu0vpJ1AZGo72RVTS87hRiE=
X-Received: by 2002:a25:32c9:: with SMTP id y192mr19632758yby.9.1635188956342;
 Mon, 25 Oct 2021 12:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <20211022205606.66392-1-Anna.Schumaker@Netapp.com> <D9989B3E-1B6B-40CE-A7B4-B65DE249CFCB@oracle.com>
In-Reply-To: <D9989B3E-1B6B-40CE-A7B4-B65DE249CFCB@oracle.com>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Mon, 25 Oct 2021 15:09:00 -0400
Message-ID: <CAFX2JfndX_w54Yf1ntDq_rpK-M5stXRpEzEO6apqSom_vsQCGg@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] Add a tool for using the new sysfs files
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Steve Dickson <steved@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Oct 23, 2021 at 11:50 AM Chuck Lever III <chuck.lever@oracle.com> wrote:
>
>
>
> > On Oct 22, 2021, at 4:55 PM, schumaker.anna@gmail.com wrote:
> >
> > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> >
> > These patches implement a tool that can be used to read and write the
> > sysfs files, with subcommands!
> >
> > The following subcommands are implemented:
> >       rpcsys rpc-client
> >       rpcsys xprt
> >       rpcsys xprt set
> >       rpcsys xprt-switch
> >       rpcsys xprt-switch set
> >
> > So you can print out information about every xprt-switch with:
> >       anna@client ~ % rpcsys xprt-switch
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
> >       anna@client ~ % rpcsys xprt
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
> >       anna@client ~ % sudo rpcsys xprt --id 4
> >       xprt 4: tcp, 192.168.111.188, port 2049, state <CONNECTED,BOUND>
> >               Source: 192.168.111.222, port 726, Requests: 2
> >               Congestion: cur 0, win 256, Slots: min 2, max 65536
> >               Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
> >       anna@client ~ % sudo rpcsys xprt set --id 4 --dstaddr server2.nowheycreamery.com
> >       xprt 4: tcp, 192.168.111.186, port 2049, state <CONNECTED,BOUND>
> >               Source: 192.168.111.222, port 726, Requests: 2
> >               Congestion: cur 0, win 256, Slots: min 2, max 65536
> >               Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
> >
> > Or for changing the dstaddr of all xprts attached to a switch:
> >       anna@client % rpcsys xprt-switch --id 3
> >       switch 3: num_xprts 4, num_active 4, queue_len 0
> >               xprt 3: tcp, 192.168.111.188 [main]
> >               xprt 4: tcp, 192.168.111.188
> >               xprt 5: tcp, 192.168.111.188
> >               xprt 6: tcp, 192.168.111.188
> >       anna@client % sudo rpcsys xprt-switch set --id 4 --dstaddr server2.nowheycreamery.vm
> >       switch 3: num_xprts 4, num_active 4, queue_len 0
> >               xprt 2: tcp, 192.168.111.186 [main]
> >               xprt 3: tcp, 192.168.111.186
> >               xprt 5: tcp, 192.168.111.186
> >               xprt 6: tcp, 192.168.111.186
> >
> >
> > I renamed the tool to "rpcsys" after the discussion at the bakeathon. I
> > think this is at least a better name, but if anybody has other ideas
> > please let me know!
> >
> > Thoughts?
>
> Anna, very nice!
>
> How about naming it "rpcctl" to follow the pattern of:

Good suggestion! I can go with that.

>
>  systemctl
>  resolvectl
>  hostnamectl
>
>
> > Anna
> >
> > Anna Schumaker (9):
> >  rpcsys: Add a rpcsys.py tool
> >  rpcsys: Add a command for printing xprt switch information
> >  rpcsys: Add a command for printing individual xprts
> >  rpcsys: Add a command for printing rpc-client information
> >  rpcsys: Add a command for changing xprt dstaddr
> >  rpcsys: Add a command for changing xprt-switch dstaddrs
> >  rpcsys: Add a command for changing xprt state
> >  rpcsys: Add a man page
> >  rpcsys: Add installation to the Makefile
> >
> > .gitignore               |   2 +
> > configure.ac             |   1 +
> > tools/Makefile.am        |   2 +-
> > tools/rpcsys/Makefile.am |  20 ++++++++
> > tools/rpcsys/client.py   |  27 +++++++++++
> > tools/rpcsys/rpcsys      |   5 ++
> > tools/rpcsys/rpcsys.man  |  88 ++++++++++++++++++++++++++++++++++
> > tools/rpcsys/rpcsys.py   |  23 +++++++++
> > tools/rpcsys/switch.py   |  51 ++++++++++++++++++++
> > tools/rpcsys/sysfs.py    |  29 +++++++++++
> > tools/rpcsys/xprt.py     | 101 +++++++++++++++++++++++++++++++++++++++
> > 11 files changed, 348 insertions(+), 1 deletion(-)
> > create mode 100644 tools/rpcsys/Makefile.am
> > create mode 100644 tools/rpcsys/client.py
> > create mode 100644 tools/rpcsys/rpcsys
> > create mode 100644 tools/rpcsys/rpcsys.man
> > create mode 100755 tools/rpcsys/rpcsys.py
> > create mode 100644 tools/rpcsys/switch.py
> > create mode 100644 tools/rpcsys/sysfs.py
> > create mode 100644 tools/rpcsys/xprt.py
> >
> > --
> > 2.33.1
> >
>
> --
> Chuck Lever
>
>
>
