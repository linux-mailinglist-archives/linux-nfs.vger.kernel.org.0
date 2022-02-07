Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA9B4AC54F
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Feb 2022 17:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240035AbiBGQSJ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Feb 2022 11:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391843AbiBGQEN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Feb 2022 11:04:13 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BAEC0401D3
        for <linux-nfs@vger.kernel.org>; Mon,  7 Feb 2022 08:04:06 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id c19so10934255wrb.10
        for <linux-nfs@vger.kernel.org>; Mon, 07 Feb 2022 08:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k+mMdNnm7HKFTIrUj1nOK8+X6pCXXVXHw2qYRbBr0ns=;
        b=aYA6DM+K1Tui7yR3L3sI6xyVc7mtnVJ1xUcKnoyKYOrjnahOIj93lum+eXnubZ6LoX
         aA8+AFYjVUJHwNPWZglrDX1OyqtQqxI9laeroTnf4jLEyfPgs5hXzJj3k6AtJbbQyk6G
         A6M5nv4iYAFdSClItnoUb27mXP4aaql5en2yNrtkuE7KCGeiG4utABA1suD7YKomF+HS
         +2Y/0O8AWT0+tTOnWMi3LxX+Ug1NNmYu/lDpVwff0f2U21UZyj0OVKL4qgJp7CB6cM7H
         Uiq+MsPhu40qG+k5U0N/rAfhgR2NZz4NcCaPV4nj7kD+TfIjhFNjOyFT0WE6sbPeojJq
         p1vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k+mMdNnm7HKFTIrUj1nOK8+X6pCXXVXHw2qYRbBr0ns=;
        b=Ops4Uv6mQRLBk4hO7Zf+s+xBINNF7Kq2T/B+LtoiOYh+6zxj7As2gvurdb57uvtlj7
         l6UzGHXTUigTVTZDfe6NtfR25jIkv8yOzlldKW09VJa9dYKOpwZpdWYCt0HaLJina1Ge
         eSfjBsgRYFZaa/3o3ERbG+TWlMZU11HekF8xzjcdFLYMsEfVb3ksAQaouhcLWNQPbn6h
         UIx1N7Fy3Fh3Txu21r5RPnksyqjdPCnU2WwCFxZE25KjeAco6lVUnPnD67zAy3BLbpXP
         6+RR4ravfK7O7MtR8KT525E0SWOgt7El2wQD5c7yPe3extvjXEU3Abp5Tw5UTSpq50KX
         dgUw==
X-Gm-Message-State: AOAM533CYf+j7sG9wO84bsS/c3BIYc7JaWhJp1c5fD/uE8UNESkH83jt
        K8FnyhbxFfZ3jDe0U72ugV/vzkbHDZg2C6o8kiKZg6tjRO8=
X-Google-Smtp-Source: ABdhPJxxiAY38tVEwaR9B1kkdTJSumoXdsVv9qk3scK2iBxb+GCagRFjEoDmtwC36ndD/Jir60XFkx4vJuUb+Ege3RY=
X-Received: by 2002:a05:6000:3cf:: with SMTP id b15mr147758wrg.82.1644249845320;
 Mon, 07 Feb 2022 08:04:05 -0800 (PST)
MIME-Version: 1.0
References: <CA+-cMpFmMr8FQKODmR5JAB8rZhzptZ_KPX5DasLM_sbvbko+GA@mail.gmail.com>
 <CA+-cMpHHeK1zSMTQiYtd5GuL2UVp8n-BY228aeUUrQq5KCOc2A@mail.gmail.com>
In-Reply-To: <CA+-cMpHHeK1zSMTQiYtd5GuL2UVp8n-BY228aeUUrQq5KCOc2A@mail.gmail.com>
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Mon, 7 Feb 2022 11:03:48 -0500
Message-ID: <CAFX2Jfk4QquitkteegAXBfF0HMM0cGiCgLJPfdhESPBuDswrbw@mail.gmail.com>
Subject: Re: Testing Results - Add a tool for using the new sysfs files - rpcctl
To:     Rahul Rathore <rrathore@redhat.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Schumaker Anna <Anna.Schumaker@netapp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Rahul,

Thanks for testing!

On Sat, Feb 5, 2022 at 7:19 AM Rahul Rathore <rrathore@redhat.com> wrote:
>
> Hello Ana,
>
> I have done some more testing.
>
> Kindly look into it.
>
> Setup
>
> NFS Server IP:192.168.122.127
> NFS Client IP:192.168.122.125
>
>
> 1- Transport Viewing
>
> # ss
> Netid     State      Recv-Q     Send-Q                             Local
> Address:Port                 Peer Address:Port       Process
> tcp       ESTAB        0          0
> 192.168.122.125:872                192.168.122.127:nfs
>
>
> [root@rrathore-upstream-sysfs nfs-utils]# ./tools/rpcctl/rpcctl.py xprt
> xprt 1: tcp, 192.168.122.127, port 0, state <CONNECTED,BOUND>, main
> Source: (enoent), port 872, Requests: 2
> Congestion: cur 0, win 256, Slots: min 2, max 65536
> Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
>
>
>
> Here port 0 is seen for Remote which is wrong. It should be nfs(2049).

Can I ask what kernel you are running? This was a kernel-side issue
that was fixed in v5.15 with this patch:

commit 5d46dd04cb68771f77ba66dbf6fd323a4a2ce00d
Author: Anna Schumaker <Anna.Schumaker@Netapp.com>
Date:   Tue Jul 20 16:04:42 2021 -0400

    sunrpc: Fix return value of get_srcport()

    Since bc1c56e9bbe9 transport->srcport may by unset, causing
    get_srcport() to return 0 when called. Fix this by querying the port
    from the underlying socket instead of the transport.

    Fixes: bc1c56e9bbe9 (SUNRPC: prevent port reuse on transports
which don't request it)
    Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>

>
> And I guess the name is also wrong. it should not  be enoent. It should be
> ens3.

enoent in this case means the file it was trying to read doesn't
exist. Probably you need this patch (also in v5.15):

commit e44773daf851dc2755144355723c1c305e7246a1
Author: Anna Schumaker <Anna.Schumaker@Netapp.com>
Date:   Thu Jul 29 16:45:23 2021 -0400

    SUNRPC: Add srcaddr as a file in sysfs

    I don't support changing it right now, but it could be useful
    information for clients with multiple network cards.

    Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>

>
>
> 2- I made the NIC down on the Server. And can see call traces as in the
> attached image. (taken from console so can't paste here)

I think this was the same bug that was fixed with this patch (which
went into v5.15-rc3):

commit 17f09d3f619a7ad2d2b021b4e5246f08225b1b0f
Author: Anna Schumaker <Anna.Schumaker@Netapp.com>
Date:   Thu Oct 28 15:17:41 2021 -0400

    SUNRPC: Check if the xprt is connected before handling sysfs reads

    xprts don't immediately reconnect when changing the "dstaddr" property,
    instead this gets handled the next time an operation uses the transport.
    This could lead to NULL pointer dereferences when trying to read sysfs
    files between the disconnect and reconnect operations. Fix this by
    returning an error if the xprt is not connected.

    Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
    Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>

>
> 3- By client I understand RPC Client and if I tune the value of
> tcp_slot_table_entries I should see an increase in number of RPC Client as
> I would increase parallel connection of RPC Clients.

I don't remember offhand how using the tcp_slot_table_entries works
for increasing RPC clients, so there might be some other trigger
you're missing. Try using the nconnect=N mount option instead, since
extra connections are set up at mount time.

>
> # ./tools/rpcctl/rpcctl.py client
> client 0: switch 0, xprts 1, active 1, queue 0
> xprt 1: tcp, 192.168.122.127 [main]
> client 3: switch 0, xprts 1, active 1, queue 0
> xprt 1: tcp, 192.168.122.127 [main]
> # sysctl -a | grep tcp_slot_table_entries
> sunrpc.tcp_slot_table_entries = 2
>
> [root@rrathore-upstream-sysfs nfs-utils]# sysctl -w
> sunrpc.tcp_slot_table_entries=8
> sunrpc.tcp_slot_table_entries = 8
> [root@rrathore-upstream-sysfs nfs-utils]#
> [root@rrathore-upstream-sysfs nfs-utils]# sysctl -a | grep
> tcp_slot_table_entries
> sunrpc.tcp_slot_table_entries = 8
> [root@rrathore-upstream-sysfs nfs-utils]#
> [root@rrathore-upstream-sysfs nfs-utils]# ./tools/rpcctl/rpcctl.py client
> <----------------------- Change in value of tcp_slot_table_entries doesn't
> seem to have an effect
> client 0: switch 0, xprts 1, active 1, queue 0
> xprt 1: tcp, 192.168.122.127 [main]
> client 3: switch 0, xprts 1, active 1, queue 0
> xprt 1: tcp, 192.168.122.127 [main]
>
> Later I started nfs and used this server as an NFS Server, then I could see
> an increase in number.
>
> # ./tools/rpcctl/rpcctl.py client
> client 0: switch 0, xprts 1, active 1, queue 0
> xprt 1: tcp, 192.168.122.127 [main]
> client 1: switch 1, xprts 1, active 1, queue 0
> xprt 0: local, /var/run/rpcbind.sock [main]
> client 2: switch 1, xprts 1, active 1, queue 0
> xprt 0: local, /var/run/rpcbind.sock [main]
> client 3: switch 0, xprts 1, active 1, queue 0
> xprt 1: tcp, 192.168.122.127 [main]
> client 4: switch 2, xprts 1, active 1, queue 0
> xprt 2: local, /var/run/gssproxy.sock [main]
> client 5: switch 3, xprts 1, active 1, queue 0
> xprt 3: tcp, 192.168.122.29 [main]
>
>
> 4- I am not sure if I am making a mistake or if it's the error due to which
> value is not getting set.
>
> [root@rrathore-upstream-sysfs nfs-utils]# ./tools/rpcctl/rpcctl.py xprt
> xprt 0: local, /var/run/rpcbind.sock, port 0, state <CONNECTED,BOUND>, main
> Source: (enoent), port 0, Requests: 8
> Congestion: cur 0, win 256, Slots: min 8, max 65536
> Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
> xprt 1: tcp, 192.168.122.127, port 0, state <CONNECTED,BOUND>, main
> Source: (enoent), port 813, Requests: 2
> Congestion: cur 0, win 256, Slots: min 2, max 65536
> Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
> xprt 2: local, /var/run/gssproxy.sock, port 0, state <CONNECTED,BOUND>, main
> Source: (enoent), port 0, Requests: 8
> Congestion: cur 0, win 256, Slots: min 8, max 65536
> Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
> xprt 3: tcp, 192.168.122.29, port 0, state <CONNECTED,BOUND>, main
> Source: (enoent), port 0, Requests: 8
> Congestion: cur 0, win 256, Slots: min 8, max 8
> Queues: binding 0, sending 0, pending 0, backlog 0, tasks 0
>
> *None of the operation work*
>
> [root@rrathore-upstream-sysfs nfs-utils]# ./tools/rpcctl/rpcctl.py xprt set
> -h
> usage: rpcctl.py xprt set [-h] --id ID [--dstaddr dstaddr] [--offline]
> [--online] [--remove]
>
> options:
>   -h, --help         show this help message and exit
>   --id ID            Id of a specific xprt to modify
>   --dstaddr dstaddr  New dstaddr to set
>   --offline          Set an xprt offline
>   --online           Set an offline xprt back online
>   --remove           Remove an xprt
> [root@rrathore-upstream-sysfs nfs-utils]#
> [root@rrathore-upstream-sysfs nfs-utils]#
> [root@rrathore-upstream-sysfs nfs-utils]# ./tools/rpcctl/rpcctl.py xprt set
> --id 3 --offline
> [Errno 22] Invalid argument
> [root@rrathore-upstream-sysfs nfs-utils]#
> [root@rrathore-upstream-sysfs nfs-utils]# ./tools/rpcctl/rpcctl.py xprt set
> --id 3 192.168.122.29 --offline
> usage: rpcctl.py [-h] {client,switch,xprt} ...
> rpcctl.py: error: unrecognized arguments: 192.168.122.29
> [root@rrathore-upstream-sysfs nfs-utils]#
> [root@rrathore-upstream-sysfs nfs-utils]# ./tools/rpcctl/rpcctl.py xprt set
> --id 3 --dstaddr 192.168.122.29 --offline
> [Errno 95] Operation not supported
> [root@rrathore-upstream-sysfs nfs-utils]#
> [root@rrathore-upstream-sysfs nfs-utils]# ./tools/rpcctl/rpcctl.py xprt set
> --id 3 --dstaddr 192.168.122.29 --online
> [Errno 95] Operation not supported
> [root@rrathore-upstream-sysfs nfs-utils]#
> [root@rrathore-upstream-sysfs nfs-utils]# ./tools/rpcctl/rpcctl.py xprt set
> --id 3 --dstaddr 192.168.122.29 --remove
> [Errno 95] Operation not supported
> [root@rrathore-upstream-sysfs nfs-utils]#
> [root@rrathore-upstream-sysfs nfs-utils]# ./tools/rpcctl/rpcctl.py xprt set
> --id 1 --dstaddr 192.168.122.127 --offline
> [Errno 22] Invalid argument
> [root@rrathore-upstream-sysfs nfs-utils]#
> [root@rrathore-upstream-sysfs nfs-utils]# ./tools/rpcctl/rpcctl.py xprt set
> --id 1 --offline
> [Errno 22] Invalid argument

The commands themselves look okay. Can you update to a kernel that has
the other fixes and let me know if it's still a problem?

Thanks,
Anna

>
>
> 5-* And it's similar If I do with switch*
>
> [root@rrathore-upstream-sysfs nfs-utils]# ./tools/rpcctl/rpcctl.py switch
> switch 0: xprts 1, active 1, queue 0
> xprt 1: tcp, 192.168.122.127 [main]
> switch 1: xprts 1, active 1, queue 0
> xprt 0: local, /var/run/rpcbind.sock [main]
> switch 2: xprts 1, active 1, queue 0
> xprt 2: local, /var/run/gssproxy.sock [main]
> switch 3: xprts 1, active 1, queue 0
> xprt 3: tcp, 192.168.122.29 [main]
>
> [root@rrathore-upstream-sysfs nfs-utils]# ./tools/rpcctl/rpcctl.py switch
> set --id 3 --dstaddr 192.168.122.30
> [Errno 95] Operation not supported
> [root@rrathore-upstream-sysfs nfs-utils]#
> [root@rrathore-upstream-sysfs nfs-utils]# ./tools/rpcctl/rpcctl.py switch
> set --id 3 --dstaddr 192.168.122.29
> [Errno 95] Operation not supported
>
> Regards,
> Rahul
