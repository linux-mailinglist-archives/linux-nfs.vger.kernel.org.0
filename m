Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB9B34814E
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Mar 2021 20:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237827AbhCXTOF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 24 Mar 2021 15:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237780AbhCXTNk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 24 Mar 2021 15:13:40 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B538BC061763
        for <linux-nfs@vger.kernel.org>; Wed, 24 Mar 2021 12:13:39 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id w18so28969948edc.0
        for <linux-nfs@vger.kernel.org>; Wed, 24 Mar 2021 12:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yF/3oodP5mcZeEg5lov39BAjF51VxTS29RsilfBT+yY=;
        b=LtT0klWRumdBx7/tpM5UoFN8U1uXk5qKXY1OwNt/FzvlLoCewms7kRqZBmUvaYPU/d
         6EsklVM0lCpdegziQfUGVCG6R+DRUrD3r5mppCen16Z+qrFGEuIMxXEWNAHXvC73AFp7
         rJktcq7tNZwyVtYcTL0RoX3wXo4TrtXkH1hfJ5RnuJmBIJm1+nZKBJIaZyiovW3sERFh
         4lRglbIArIud+Vcq+9HMEJBev2pJz7+unkXjuIVeqIhrIWA5Ap9ATKXdjyZAEj2dFsEW
         zMrYRjfi+61aVApILcTMHPro4h6TcS2y8gizEhegUz/4C9aViJEgeW47hZ/+uUc1XCmf
         NVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yF/3oodP5mcZeEg5lov39BAjF51VxTS29RsilfBT+yY=;
        b=QMdJjz9eYEURpsfGQ/GwxI5osdiBqIqnX8T1PWEIeNJ6YhKUkzBYYyxNVLIl3+FSws
         gXPcicLjL9mojogn2LabVei7i3miwJden/5LtYIn5DISP7jPrgW7OZlLoga/uXK5mVdr
         6CaJ47RO8z75F7V6kScMkFLsrVESjJnpzLIm0eLCpODrCMaHjeDtiKzXjR0Zp8KIQ4X5
         b8i558E47MSs1KgTkcRI6Mr87H9yi1JvOYJfAgav+lb7YDbepIQEj8cHFWxx9wN0qL/e
         In544TnZsSK+U/hiZZrF8dvhHF/XXB7zmWbvs/Ql629IlS89i2aAMy/hOI08hL3A4eXp
         ecMQ==
X-Gm-Message-State: AOAM530s3bjAPRQtaC7goQ8gGLd5J7wQT2/UelL9anJNrWVv3206fI+o
        FmiY10IqV658krqjqZBqm8y5wDM252ZXEByLbgs=
X-Google-Smtp-Source: ABdhPJyOWwhYyaX7nfNaRwVuS6JhUVA49ySfjmy5CQoBFE7IkNnvUyxp8sZbr4mBePRfXVtZsU9GN6EFHV01n9ODgeg=
X-Received: by 2002:a05:6402:9:: with SMTP id d9mr5122805edu.67.1616613218257;
 Wed, 24 Mar 2021 12:13:38 -0700 (PDT)
MIME-Version: 1.0
References: <SG2P153MB0361F4B85684C232E63C04749E679@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <SG2P153MB0361F4B85684C232E63C04749E679@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Wed, 24 Mar 2021 15:13:27 -0400
Message-ID: <CAN-5tyFLha3Wvy6m12S=9m+Yu0pg5wtEn_+4=aadXzECwBzoWA@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] SUNRPC: Create sysfs files for changing IP address
To:     Nagendra Tomar <Nagendra.Tomar@microsoft.com>
Cc:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Tomar,

SUNRPC layer only deals with resolved addresses not dns names (on
purpose). DNS resolution code that does exists at the NFS layer is for
referrals/migration -- an event that happens at a point in time and
doesn't repeat (but it does implement a simple caching strategy). At
the SUNRPC layer, a connection can be dropped and re-established
numerous times and thus, to require DNS resolution on each attempt
will interfere with performance because a DNS resolution requires an
upcall into the userland (implementing DNS caching at the SUNRPC layer
is a non-starter probably, since policy based features should be in
userland).

You mention that you are interested in using the "same" server only
changing the IP. DNS failover is no way an authority in "sameness" of
the server. NFSv4.x have definitions of what it means to call 2
servers the same. When doing an IP change via a SUNRPC layer, we are
relying on the fact that an administrator will be pointing it to the
"same" server.

Given that a failover is an "event", an administrator can do a DNS
query and then use the provided IP to supply into the sysfs to direct
the IO to the new server IP. Maybe the sysfs interface can support
receiving a DNS name and doing a DNS lookup then (but that probably
should be an addition onto these patches not in the initial version)?


On Fri, Mar 19, 2021 at 9:27 PM Nagendra Tomar
<Nagendra.Tomar@microsoft.com> wrote:
>
> Hi Anna,
>      We have a similar but slightly different requirement.
> You change allows a user to force a xprt's remote address to anything, allowing
> it to connect to a different address than what it originally had.
> The original server/xprt address starts as the one that userspace mount program
> provides, possibly after resolving the servername used in the mount command.
>
> Our requirement is that that server name remains same but its address changes,
> aka, DNS failover.
> Such cases (which I believe are more common) can be handled fully automatically,
> by resolving the server name before every xprt reconnect. CIFS does this.
> NFS also has fs/nfs/dns_resolve.c which we can use to do the name resolution,
> though it's currently not being used for this specific use.
>
> Did you have a similar requirement in mind, and/or did you consider the above?
> Would like to know your thoughts.
>
> Thanks,
> Tomar
>
> -----Original Message-----
> From: Anna Schumaker <schumakeranna@gmail.com> On Behalf Of schumaker.anna@gmail.com
> Sent: 13 March 2021 02:48
> To: linux-nfs@vger.kernel.org
> Cc: Anna.Schumaker@Netapp.com
> Subject: [PATCH v3 0/5] SUNRPC: Create sysfs files for changing IP address
>
> From: Anna Schumaker <Anna.Schumaker@Netapp.com>
>
> It's possible for an NFS server to go down but come back up with a
> different IP address. These patches provide a way for administrators to
> handle this issue by providing a new IP address for xprt sockets to
> connect to.
>
> Chuck has suggested some ideas for future work that could also use this
> interface, such as:
> - srcaddr: To move between network devices on the client
> - type: "tcp", "rdma", "local"
> - bound: 0 for autobind, or the result of the most recent rpcbind query
> - connected: either true or false
> - last: read-only timestamp of the last operation to use the transport
> - device: A symlink to the physical network device
>
> Changes in v3:
> - Rename functions and objects to make future expansion easier
> - Put files under /sys/kernel/sunrpc/client/ instead of
>   /sys/kernel/sunrpc/net/, again for future expansions
> - Clean up use of WARN_ON_ONCE() in xs_connect()
> - Fix up locking, reference counting, and RCU usage
> - Unconditionally create files so userspace tools don't need to guess
>   what is supported (We return an error message now instead)
>
> Changes in v2:
> - Put files under /sys/kernel/sunrpc/ instead of /sys/net/sunrpc/
> - Rename file from "address" to "dstaddr"
>
> Thoughts?
> Anna
>
>
> Anna Schumaker (5):
>   sunrpc: Create a sunrpc directory under /sys/kernel/
>   sunrpc: Create a client/ subdirectory in the sunrpc sysfs
>   sunrpc: Create per-rpc_clnt sysfs kobjects
>   sunrpc: Prepare xs_connect() for taking NULL tasks
>   sunrpc: Create a per-rpc_clnt file for managing the destination IP
>     address
>
>  include/linux/sunrpc/clnt.h |   1 +
>  net/sunrpc/Makefile         |   2 +-
>  net/sunrpc/clnt.c           |   5 +
>  net/sunrpc/sunrpc_syms.c    |   8 ++
>  net/sunrpc/sysfs.c          | 191 ++++++++++++++++++++++++++++++++++++
>  net/sunrpc/sysfs.h          |  20 ++++
>  net/sunrpc/xprtsock.c       |   2 +-
>  7 files changed, 227 insertions(+), 2 deletions(-)
>  create mode 100644 net/sunrpc/sysfs.c
>  create mode 100644 net/sunrpc/sysfs.h
>
> --
> 2.29.2
>
>
