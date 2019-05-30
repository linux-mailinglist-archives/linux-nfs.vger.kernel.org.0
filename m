Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 80C383027F
	for <lists+linux-nfs@lfdr.de>; Thu, 30 May 2019 20:59:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfE3S7j (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 May 2019 14:59:39 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:36360 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726031AbfE3S7j (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 30 May 2019 14:59:39 -0400
Received: by mail-vs1-f68.google.com with SMTP id l20so5109974vsp.3
        for <linux-nfs@vger.kernel.org>; Thu, 30 May 2019 11:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pXncGW6v401sKfYcflnoSRq7muunvQwmVLcVMPzbe+0=;
        b=WeyElnWia/yk1MCkOxhVjLOElNkxwhzXJ/orj+49quspmlqlWG7KTGN4p0NFvNsqkR
         Nnw/yWElvJaf1rRJVreWAnKgSYMTp1nm26qKFx9s+bVRgsTHhyPqf8S0LcOVZgjYBLgG
         bQ6/VZCQsS1SLig/TIT+1FS7i9B+Cs8Lh+ZbEAGhCFTpKzqHGpaWk/H4QveBYCkQl/UD
         pA52Z8zNwx22r/NxfYwF6dwAFvKM20h/RobfwsD9wrHcDrxf4uNwXM9qmmdF38me/vXm
         VCHv2bqSkgYT0MZcogShhmPn/ds+y+TtH3fpcuq7X9jcOSFFRkWH4f9P5Kln0uf24ERu
         LQZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pXncGW6v401sKfYcflnoSRq7muunvQwmVLcVMPzbe+0=;
        b=Kevi+wE2U0XGN/ABg4n5GBUvgmCgCdgs7+N+SuLAUwhMF88F32Pchw8aPlN/JPucsi
         feCkxD4qM4eGb6Jo1K8S87B2xLSog6LSlvqPOOj+PFqjTMWCyQmZuKXyb3qe2PRhRxUi
         M6DgcjLimtTPYpoaxsZ9vQ4iFDG1QbvPwftZFDNLcuJcP+f+IQDsRjY2pGLs9vDhShbo
         zJ55GElcpGurwUggiaPWm8+ZG8i/mo5PMuNqAMcD3xDKP5TG85ho0N/jsC73OVvhMPXd
         8/Fd495nPANi+TOvY3umWHU1ZtP/tPOf1rwlBn1SpUL6hk5WrTcaMQd9evwxU4IdbtXV
         rrpQ==
X-Gm-Message-State: APjAAAU0Fb3cZVRDqXK1W7/rwMSbqJQYmr5CG4Lrr32ZuMLDHPAIEf5b
        BsspfJBQHR+1MAq3T9BohPFRTMI2Vs5x4Lt4wZnflQ==
X-Google-Smtp-Source: APXvYqwKya2dhw0KU9FSKYVL44VzA460BGw2aR2BZZ4gmlseJsLQoGiG3oo5Ic2BBOvmILHqxY/uV+Q9SmakbRXGbEc=
X-Received: by 2002:a67:de99:: with SMTP id r25mr2973085vsk.215.1559242777861;
 Thu, 30 May 2019 11:59:37 -0700 (PDT)
MIME-Version: 1.0
References: <155917564898.3988.6096672032831115016.stgit@noble.brown> <001DED71-0E0D-46B1-BA34-84E6ACCBB79F@oracle.com>
In-Reply-To: <001DED71-0E0D-46B1-BA34-84E6ACCBB79F@oracle.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 30 May 2019 14:59:26 -0400
Message-ID: <CAN-5tyG7-EK8ds1GGLubZGBQMtx2wwkzoPH=YxuaOH0v+shteg@mail.gmail.com>
Subject: Re: [PATCH 0/9] Multiple network connections for a single NFS mount.
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     NeilBrown <neilb@suse.com>,
        Anna Schumaker <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, May 30, 2019 at 1:57 PM Chuck Lever <chuck.lever@oracle.com> wrote:
>
> Hi Neil-
>
> Thanks for chasing this a little further.
>
>
> > On May 29, 2019, at 8:41 PM, NeilBrown <neilb@suse.com> wrote:
> >
> > This patch set is based on the patches in the multipath_tcp branch of
> > git://git.linux-nfs.org/projects/trondmy/nfs-2.6.git
> >
> > I'd like to add my voice to those supporting this work and wanting to
> > see it land.
> > We have had customers/partners wanting this sort of functionality for
> > years.  In SLES releases prior to SLE15, we've provide a
> > "nosharetransport" mount option, so that several filesystem could be
> > mounted from the same server and each would get its own TCP
> > connection.
>
> Is it well understood why splitting up the TCP connections result
> in better performance?

It has been historical that NFS can not fill up a highspeed pipe.
There have been studies that shown a negative interactions between VM
dirty page flushing and TCP window behavior that lead to bad
performance (VM flushes too aggressively which creates TCP congestion
so window closes which then makes the VM to stop flushing and so the
system oscilates between bad states and always underperforms ). But
that a side, there might be different server implementations that
would perform better when multiple connections are used.

I forget the details but there used to be (might still be) Data
transfer storage challenges at conferences to see who can transfer the
largest amount of data faster. They all have shown that to accomplish
that you need to have multiple TCP connections.

But to answer: no I don't think it's "well understood" why splitting
TCP connection performs better.

> > In SLE15 we are using this 'nconnect' feature, which is much nicer.
> >
> > Partners have assured us that it improves total throughput,
> > particularly with bonded networks, but we haven't had any concrete
> > data until Olga Kornievskaia provided some concrete test data - thanks
> > Olga!
> >
> > My understanding, as I explain in one of the patches, is that parallel
> > hardware is normally utilized by distributing flows, rather than
> > packets.  This avoid out-of-order deliver of packets in a flow.
> > So multiple flows are needed to utilizes parallel hardware.
>
> Indeed.
>
> However I think one of the problems is what happens in simpler scenarios.
> We had reports that using nconnect > 1 on virtual clients made things
> go slower. It's not always wise to establish multiple connections
> between the same two IP addresses. It depends on the hardware on each
> end, and the network conditions.
>
>
> > An earlier version of this patch set was posted in April 2017 and
> > Chuck raised two issues:
> > 1/ mountstats only reports on one xprt per mount
> > 2/ session establishment needs to happen on a single xprt, as you
> >    cannot bind other xprts to the session until the session is
> >    established.
> > I've added patches to address these, and also to add the extra xprts
> > to the debugfs info.
> >
> > I've also re-arrange the patches a bit, merged two, and remove the
> > restriction to TCP and NFSV4.x,x>=1.  Discussions seemed to suggest
> > these restrictions were not needed, I can see no need.
>
> RDMA could certainly benefit for exactly the reason you describe above.
>
>
> > There is a bug with the load balancing code from Trond's tree.
> > While an xprt is attached to a client, the queuelen is incremented.
> > Some requests (particularly BIND_CONN_TO_SESSION) pass in an xprt,
> > and the queuelen was not incremented in this case, but it was
> > decremented.  This causes it to go 'negative' and havoc results.
> >
> > I wonder if the last three patches (*Allow multiple connection*) could
> > be merged into a single patch.
> >
> > I haven't given much thought to automatically determining the optimal
> > number of connections, but I doubt it can be done transparently with
> > any reliability.
>
> A Solaris client can open up to 8 connections to a server, but there
> are always some scenarios where the heuristic creates too many
> connections and becomes a performance issue.

That's great that a solaris client can have many multiple connections,
let's not leave the linux client behind then :-) Given your knowledge
in this case, do you have words of wisdom/lessons learned that could
help with it?

> We also have concerns about running the client out of privileged port
> space.
>
> The problem with nconnect is that it can work well, but it can also be
> a very easy way to shoot yourself in the foot.

It's an optional feature so I'd argue that if you've chosen to use it,
then don't complain about the consequences.

> I also share the concerns about dealing properly with retransmission
> and NFSv4 sessions.
>
>
> > When adding a connection improves throughput, then
> > it was almost certainly a good thing to do. When adding a connection
> > doesn't improve throughput, the implications are less obvious.
> > My feeling is that a protocol enhancement where the serve suggests an
> > upper limit and the client increases toward that limit when it notices
> > xmit backlog, would be about the best we could do.  But we would need
> > a lot more experience with the functionality first.
>
> What about situations where the network capabilities between server and
> client change? Problem is that neither endpoint can detect that; TCP
> usually just deals with it.
>
> Related Work:
>
> We now have protocol (more like conventions) for clients to discover
> when a server has additional endpoints so that it can establish
> connections to each of them.

Yes I totally agree we need solution for when there are multiple
endpoints. And we need a solution that's being proposed here which is
to establish multiple connections to the same endpoint.

> https://datatracker.ietf.org/doc/rfc8587/
>
> and
>
> https://datatracker.ietf.org/doc/draft-ietf-nfsv4-rfc5661-msns-update/
>
> Boiled down, the client uses fs_locations and trunking detection to
> figure out when two IP addresses are the same server instance.
>
> This facility can also be used to establish a connection over a
> different path if network connectivity is lost.
>
> There has also been some exploration of MP-TCP. The magic happens
> under the transport socket in the network layer, and the RPC client
> is not involved.
>
>
> > Comments most welcome.  I'd love to see this, or something similar,
> > merged.
> >
> > Thanks,
> > NeilBrown
> >
> > ---
> >
> > NeilBrown (4):
> >      NFS: send state management on a single connection.
> >      SUNRPC: enhance rpc_clnt_show_stats() to report on all xprts.
> >      SUNRPC: add links for all client xprts to debugfs
> >
> > Trond Myklebust (5):
> >      SUNRPC: Add basic load balancing to the transport switch
> >      SUNRPC: Allow creation of RPC clients with multiple connections
> >      NFS: Add a mount option to specify number of TCP connections to use
> >      NFSv4: Allow multiple connections to NFSv4.x servers
> >      pNFS: Allow multiple connections to the DS
> >      NFS: Allow multiple connections to a NFSv2 or NFSv3 server
> >
> >
> > fs/nfs/client.c                      |    3 +
> > fs/nfs/internal.h                    |    2 +
> > fs/nfs/nfs3client.c                  |    1
> > fs/nfs/nfs4client.c                  |   13 ++++-
> > fs/nfs/nfs4proc.c                    |   22 +++++---
> > fs/nfs/super.c                       |   12 ++++
> > include/linux/nfs_fs_sb.h            |    1
> > include/linux/sunrpc/clnt.h          |    1
> > include/linux/sunrpc/sched.h         |    1
> > include/linux/sunrpc/xprt.h          |    1
> > include/linux/sunrpc/xprtmultipath.h |    2 +
> > net/sunrpc/clnt.c                    |   98 ++++++++++++++++++++++++++++++++--
> > net/sunrpc/debugfs.c                 |   46 ++++++++++------
> > net/sunrpc/sched.c                   |    3 +
> > net/sunrpc/stats.c                   |   15 +++--
> > net/sunrpc/sunrpc.h                  |    3 +
> > net/sunrpc/xprtmultipath.c           |   23 +++++++-
> > 17 files changed, 204 insertions(+), 43 deletions(-)
> >
> > --
> > Signature
> >
>
> --
> Chuck Lever
>
>
>
