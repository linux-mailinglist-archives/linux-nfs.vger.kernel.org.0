Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E220534936D
	for <lists+linux-nfs@lfdr.de>; Thu, 25 Mar 2021 14:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbhCYN4m (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 25 Mar 2021 09:56:42 -0400
Received: from mail-ej1-f50.google.com ([209.85.218.50]:36672 "EHLO
        mail-ej1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbhCYN4a (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 25 Mar 2021 09:56:30 -0400
Received: by mail-ej1-f50.google.com with SMTP id a7so3076902ejs.3
        for <linux-nfs@vger.kernel.org>; Thu, 25 Mar 2021 06:56:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/WK4XVZImg8PaUOqDOiOsutrzjvWC2GM4VIB1SbfQyg=;
        b=Sptzegc/4+Ri/aR3EMXkpnfjcolw9Sds6SebMKO9cHCKNYPJJU30sgI0odv4B1YpRH
         4bXOR+jMVURiQL3qFW7bKsEo0CK9sG8fg1f5PNi5AHY46YJnOWje5asDNtwWZD1F41lu
         MgSzyzsZlWH5jvuxATV61SA2uvp2cobGY1PwmuflLKLsaCSeEa105vJO2qghsnMBxNBN
         esjWEFIC+XgYp8SjeHZxuXyGJQHpaqTObrB8u0/WLkaWLPGx3ISNotWxZOFiOwIii/gd
         +qRxOtkTD7dniDxbQ5mpSuTBnkCk+4Uxxgtnt+NhB0Ne4gKp9/YDzV1Sz2Hn7mTygqMB
         s5OA==
X-Gm-Message-State: AOAM530okPS0WWT9zTuxIkUmHoiq0difLkKfJGUjMK5vWCZ5U2sPbkMm
        XdAiEkVbV+dSnpjawDgd8qpRof/6mJzWXQToS8i+RlOG
X-Google-Smtp-Source: ABdhPJzbCmiuHXHD/9lScpdgGnOgf14LkHXyGl1r68RJ2sHtyDQ7J3nYs/5wV9GCbRhe9LxTn6nFBD/G6/E0K6vrW8o=
X-Received: by 2002:a17:906:b1d4:: with SMTP id bv20mr9698092ejb.46.1616680588929;
 Thu, 25 Mar 2021 06:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <SG2P153MB0361F4B85684C232E63C04749E679@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
 <CAN-5tyFLha3Wvy6m12S=9m+Yu0pg5wtEn_+4=aadXzECwBzoWA@mail.gmail.com> <SG2P153MB0361BA94D52E1123DEE7E1EC9E629@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
In-Reply-To: <SG2P153MB0361BA94D52E1123DEE7E1EC9E629@SG2P153MB0361.APCP153.PROD.OUTLOOK.COM>
From:   Anna Schumaker <anna.schumaker@netapp.com>
Date:   Thu, 25 Mar 2021 09:56:12 -0400
Message-ID: <CAFX2JfkH2c0jXHQnKezfcCFs9rwNVhnTtg+8pOtTZbLyKU7VBw@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [PATCH v3 0/5] SUNRPC: Create sysfs files for
 changing IP address
To:     Nagendra Tomar <Nagendra.Tomar@microsoft.com>
Cc:     Olga Kornievskaia <aglo@umich.edu>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Tomar,

Sorry for not chiming in earlier, as Olga said: I'm on leave (and will
be for several more weeks) after my wife and I had a baby.

On Thu, Mar 25, 2021 at 1:11 AM Nagendra Tomar
<Nagendra.Tomar@microsoft.com> wrote:
>
> > From: Olga Kornievskaia <aglo@umich.edu>
> > Sent: 25 March 2021 00:43
> >
> > Hi Tomar,
>
> Hi Olga,
>      Thanks for your comments!
>
> >
> > SUNRPC layer only deals with resolved addresses not dns names (on
> > purpose). DNS resolution code that does exists at the NFS layer is for
> > referrals/migration -- an event that happens at a point in time and
> > doesn't repeat (but it does implement a simple caching strategy). At
> > the SUNRPC layer, a connection can be dropped and re-established
> > numerous times and thus, to require DNS resolution on each attempt
> > will interfere with performance because a DNS resolution requires an
> > upcall into the userland (implementing DNS caching at the SUNRPC layer
> > is a non-starter probably, since policy based features should be in
> > userland).
>
> A SUNRPC reconnect is not a fastpath operation. Usually, it's done after
> 1+ consecutive RPC timeouts which would easily be at least 10's
> of seconds to few minutes. Having a DNS resolution which might take
> additional few 10/100's msecs doesn't look like too much extra work IMHO,
> given that one of the reasons for server not responding on the old address
> could well be because it has moved to a new address (Zone/Geo failovers
> being more likely with cloud based NFS servers).
> Also, if user does not have a server that uses DNS failover, she can
> simply provide the IP at the time of mount (IP:/share vs Hostname:/share),
> and that can act as a hint for the rpc layer to not do resolution on reconnect.
>
> >
> > You mention that you are interested in using the "same" server only
> > changing the IP. DNS failover is no way an authority in "sameness" of
> > the server. NFSv4.x have definitions of what it means to call 2
> > servers the same. When doing an IP change via a SUNRPC layer, we are
> > relying on the fact that an administrator will be pointing it to the
> > "same" server.
>
> I don't think we are depending on the admin setting "same" server.
> I mean we just take the IP on face value and go about our usual RPC state
> machine. If the IP happens to point to a different server it will eventually
> hit auth failure (for reasonable auth policies) and then we will try to re-setup
> auth and fail if we cannot, so admin setting wrong IP cannot break the security
> provided by the RPC layer (which is a good thing).
> The same should simply work for IP obtained from DNS resolution.
>
> >
> > Given that a failover is an "event", an administrator can do a DNS
> > query and then use the provided IP to supply into the sysfs to direct
> > the IO to the new server IP. Maybe the sysfs interface can support
> > receiving a DNS name and doing a DNS lookup then (but that probably
> > should be an addition onto these patches not in the initial version)?
>
> I feel that auto DNS resolution just makes the process more smooth and
> intuitive. That's something which to me looks like a more common usage
> scenario. The write-ip-to-sysfs approach is definitely generic, but I would
> love if it solves the more common DNS failover usecase too.

I've been thinking of the write-to-sysfs approach as just the kernel
interface. I would expect there to be some future userspace tool built
on the sysfs files that is easier for admins to use. This future tool
could probably be coded to handle dns resolutions and write the result
to the sysfs file.

Thanks,
Anna

>
> >
> >
> > On Fri, Mar 19, 2021 at 9:27 PM Nagendra Tomar
> > <Nagendra.Tomar@microsoft.com> wrote:
> > >
> > > Hi Anna,
> > >      We have a similar but slightly different requirement.
> > > You change allows a user to force a xprt's remote address to anything,
> > allowing
> > > it to connect to a different address than what it originally had.
> > > The original server/xprt address starts as the one that userspace mount
> > program
> > > provides, possibly after resolving the servername used in the mount
> > command.
> > >
> > > Our requirement is that that server name remains same but its address
> > changes,
> > > aka, DNS failover.
> > > Such cases (which I believe are more common) can be handled fully
> > automatically,
> > > by resolving the server name before every xprt reconnect. CIFS does this.
> > > NFS also has fs/nfs/dns_resolve.c which we can use to do the name
> > resolution,
> > > though it's currently not being used for this specific use.
> > >
> > > Did you have a similar requirement in mind, and/or did you consider the
> > above?
> > > Would like to know your thoughts.
> > >
> > > Thanks,
> > > Tomar
> > >
> > > -----Original Message-----
> > > From: Anna Schumaker <schumakeranna@gmail.com> On Behalf Of
> > schumaker.anna@gmail.com
> > > Sent: 13 March 2021 02:48
> > > To: linux-nfs@vger.kernel.org
> > > Cc: Anna.Schumaker@Netapp.com
> > > Subject: [PATCH v3 0/5] SUNRPC: Create sysfs files for changing IP address
> > >
> > > From: Anna Schumaker <Anna.Schumaker@Netapp.com>
> > >
> > > It's possible for an NFS server to go down but come back up with a
> > > different IP address. These patches provide a way for administrators to
> > > handle this issue by providing a new IP address for xprt sockets to
> > > connect to.
> > >
> > > Chuck has suggested some ideas for future work that could also use this
> > > interface, such as:
> > > - srcaddr: To move between network devices on the client
> > > - type: "tcp", "rdma", "local"
> > > - bound: 0 for autobind, or the result of the most recent rpcbind query
> > > - connected: either true or false
> > > - last: read-only timestamp of the last operation to use the transport
> > > - device: A symlink to the physical network device
> > >
> > > Changes in v3:
> > > - Rename functions and objects to make future expansion easier
> > > - Put files under /sys/kernel/sunrpc/client/ instead of
> > >   /sys/kernel/sunrpc/net/, again for future expansions
> > > - Clean up use of WARN_ON_ONCE() in xs_connect()
> > > - Fix up locking, reference counting, and RCU usage
> > > - Unconditionally create files so userspace tools don't need to guess
> > >   what is supported (We return an error message now instead)
> > >
> > > Changes in v2:
> > > - Put files under /sys/kernel/sunrpc/ instead of /sys/net/sunrpc/
> > > - Rename file from "address" to "dstaddr"
> > >
> > > Thoughts?
> > > Anna
> > >
> > >
> > > Anna Schumaker (5):
> > >   sunrpc: Create a sunrpc directory under /sys/kernel/
> > >   sunrpc: Create a client/ subdirectory in the sunrpc sysfs
> > >   sunrpc: Create per-rpc_clnt sysfs kobjects
> > >   sunrpc: Prepare xs_connect() for taking NULL tasks
> > >   sunrpc: Create a per-rpc_clnt file for managing the destination IP
> > >     address
> > >
> > >  include/linux/sunrpc/clnt.h |   1 +
> > >  net/sunrpc/Makefile         |   2 +-
> > >  net/sunrpc/clnt.c           |   5 +
> > >  net/sunrpc/sunrpc_syms.c    |   8 ++
> > >  net/sunrpc/sysfs.c          | 191 ++++++++++++++++++++++++++++++++++++
> > >  net/sunrpc/sysfs.h          |  20 ++++
> > >  net/sunrpc/xprtsock.c       |   2 +-
> > >  7 files changed, 227 insertions(+), 2 deletions(-)
> > >  create mode 100644 net/sunrpc/sysfs.c
> > >  create mode 100644 net/sunrpc/sysfs.h
> > >
> > > --
> > > 2.29.2
> > >
> > >
