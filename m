Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2186B32EEC0
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Mar 2021 16:25:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbhCEPZX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 5 Mar 2021 10:25:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43297 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230093AbhCEPZM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 5 Mar 2021 10:25:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614957910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sLgHBultVa9HhLMiVd2HPN9CEzQ4svGMz7PKaob5d58=;
        b=dMwSj5UoUN9tb/+T4utN0fAAxGWtHS3riU3KZlpojmhG3NEYKMgZInsgoyxn6nrmhCXg0g
        fWnX+ksTFQFfQD9j4cxU4IlHQ5HUFtfscTSkFCIA5NKUNOTjMhBqO45Xv9Q5S2yVofHNeD
        K5z1WQ4/IiAPKV2H7+1MESa9ZhriQ/Q=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-GTclY1IuP62PeOugEBPysw-1; Fri, 05 Mar 2021 10:25:09 -0500
X-MC-Unique: GTclY1IuP62PeOugEBPysw-1
Received: by mail-il1-f198.google.com with SMTP id b4so1956650ilj.10
        for <linux-nfs@vger.kernel.org>; Fri, 05 Mar 2021 07:25:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sLgHBultVa9HhLMiVd2HPN9CEzQ4svGMz7PKaob5d58=;
        b=me9CJis9SF9HflnxvBza14gQvJ1uE/K8mC98xPuuyQ9anoWJMhi/YcWqpW66GaU36P
         LhGnYurfzyM48EwxHHH4rskWLsy8bo7ahJS3gtq2M6VVzLD9xkNlSiKggZk5ocYK0pb2
         RHTCDJJrV1AcjGJ8qyIAbPiUDNqN/pe1u9XMWuX8e20r5X4N3fNShfLRHJlvF/E0vOK2
         ArMSSb/6gii9ayav6nlxKS2xtjQaZus77KbPOpzCy+k8K+W5AiQXmpxdv5B/ZSCY/jK/
         J6mDxqFvUst+C5GW8cK6F/2WlvmF3HvIDINc6BfrqOukWCdjOh7TKqNjkkL2gflQONS/
         fAYw==
X-Gm-Message-State: AOAM53221/I0p7ymsgltP4ID0lfFpX5YpvurXQTVGAeVQTaIoj3jejg5
        KlD9AfJWtHfo1/D0cB13V9IB21fQECurgkmBCNRz6HTXyoXu/YFsG8DyuKZVPCcAxZQPPHtAEfc
        c9oaPKa6tmGDWPngVmVammMHYc+p5E8CcOizC
X-Received: by 2002:a05:6e02:184d:: with SMTP id b13mr9228700ilv.263.1614957908653;
        Fri, 05 Mar 2021 07:25:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzFtfRd7o+7J4n8GlHwSqmdYfZDPfUIYUEgDZbQgZeImMAik+2LZ3bs+NU0cba+Iqk6YESY951lfzo8kX28OC8=
X-Received: by 2002:a05:6e02:184d:: with SMTP id b13mr9228672ilv.263.1614957908329;
 Fri, 05 Mar 2021 07:25:08 -0800 (PST)
MIME-Version: 1.0
References: <20210303153307.3147-1-rbergant@redhat.com> <FBBBDFDD-6819-450C-879D-0B11B917BD10@oracle.com>
 <9e98d684c6ecdbb0395beb66a0bc694c4ca870c8.camel@hammerspace.com>
 <CACWnjLw9KQ+-d2otHQ_-vx34Up1A-EiY=2phQOwUu8S-ZExyhw@mail.gmail.com> <20954E17-8391-4C91-8C05-A55F9797FC67@redhat.com>
In-Reply-To: <20954E17-8391-4C91-8C05-A55F9797FC67@redhat.com>
From:   Roberto Bergantinos Corpas <rbergant@redhat.com>
Date:   Fri, 5 Mar 2021 16:24:56 +0100
Message-ID: <CACWnjLyF4+kuNFY7ixiTv_o3T16+_0XPgEDno14eQCqh3NuDPQ@mail.gmail.com>
Subject: Re: [PATCH] pNFS: make DS availability problems visible in log
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        anna.schumaker@netapp.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Ben

  Yes you're right always some intervention is required but I guess
something on logs is a bit more exposed to log scan/monitoring tools
from the start,
and in general quicker to notice. I understand patch is way too chatty though.

  But  in the event of i.e. a mount, and no DS is available and we
divert I/O to MDS, i don't think its a bad idea notify
that scenario on logs, at least once, can give user a hint some part
of the pNFS infrastructure went away. That was my original point, but
since life
goes on through MDS maybe is not worth a more alarming log message, i
can go just for tracepoints.

rgds
roberto

On Fri, Mar 5, 2021 at 2:42 PM Benjamin Coddington <bcodding@redhat.com> wrote:
>
> There's always going to be some sort of user intervention, even if the
> intervention is to read the system's logs.  What does the solution to
> notice DS problems ideally look like to the user?  Instead of "check the
> logs for DS problems", couldn't you replace that with "run this script
> to check for DS problems"?
>
> Ben
>
> On 5 Mar 2021, at 7:29, Roberto Bergantinos Corpas wrote:
>
> > Trond, Chuck
> >
> > thanks for feedback. I understand the point
> >
> > Sure we can turn those printks into tracepoints, done. However
> > original point was flag somehow DS issues
> > outside debug, i.e. user intervention. What about just a pr_warn_once
> > just for the case when at _nfs4_pnfs_v4_ds_connect
> > we could not reach any DS ?
> >
> > On Thu, Mar 4, 2021 at 9:35 PM Trond Myklebust
> > <trondmy@hammerspace.com> wrote:
> >>
> >> On Thu, 2021-03-04 at 20:20 +0000, Chuck Lever wrote:
> >>> Hello Roberto!
> >>>
> >>>> On Mar 3, 2021, at 10:33 AM, Roberto Bergantinos Corpas <
> >>>> rbergant@redhat.com> wrote:
> >>>>
> >>>> Would be interesting to promote DS availability logging outside
> >>>> debug
> >>>> so that we are more aware that I/O is diverted to MDS and some part
> >>>> of the infraestructure failed.
> >>>>
> >>>> Also added logging for failed DS connection attempts.
> >>>
> >>> Given that this enables remote system behavior to generate
> >>> kernel log traffic that can fill the local root partition,
> >>> I'd like to see either:
> >>>
> >>> - the explicit use of rate limiting, or
> >>>
> >>> - these dprintks replaced with tracepoints
> >>
> >> I cannot accept a pr_warn(), even a rate limited one, for a timeout
> >> error or for a connection error in the data path. Those are just too
> >> nasty to deal with in a syslog.
> >>
> >> Tracepoints would be acceptable.
> >>
> >>>
> >>>
> >>>> Signed-off-by: Roberto Bergantinos Corpas <rbergant@redhat.com>
> >>>> ---
> >>>> fs/nfs/filelayout/filelayout.c         | 4 ++--
> >>>> fs/nfs/flexfilelayout/flexfilelayout.c | 6 +++---
> >>>> fs/nfs/pnfs_nfs.c                      | 6 +++++-
> >>>> 3 files changed, 10 insertions(+), 6 deletions(-)
> >>>>
> >>>> diff --git a/fs/nfs/filelayout/filelayout.c
> >>>> b/fs/nfs/filelayout/filelayout.c
> >>>> index 7f5aa0403e16..fef2d31a501a 100644
> >>>> --- a/fs/nfs/filelayout/filelayout.c
> >>>> +++ b/fs/nfs/filelayout/filelayout.c
> >>>> @@ -181,7 +181,7 @@ static int filelayout_async_handle_error(struct
> >>>> rpc_task *task,
> >>>>         case -EIO:
> >>>>         case -ETIMEDOUT:
> >>>>         case -EPIPE:
> >>>> -               dprintk("%s DS connection error %d\n", __func__,
> >>>> +               pr_warn("%s DS connection error %d\n", __func__,
> >>>>                         task->tk_status);
> >>>>                 nfs4_mark_deviceid_unavailable(devid);
> >>>>                 pnfs_error_mark_layout_for_return(inode, lseg);
> >>>> @@ -190,7 +190,7 @@ static int filelayout_async_handle_error(struct
> >>>> rpc_task *task,
> >>>>                 fallthrough;
> >>>>         default:
> >>>> reset:
> >>>> -               dprintk("%s Retry through MDS. Error %d\n",
> >>>> __func__,
> >>>> +               pr_warn("%s Retry through MDS. Error %d\n",
> >>>> __func__,
> >>>>                         task->tk_status);
> >>>>                 return -NFS4ERR_RESET_TO_MDS;
> >>>>         }
> >>>> diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c
> >>>> b/fs/nfs/flexfilelayout/flexfilelayout.c
> >>>> index a163533446fa..7150d94e80e6 100644
> >>>> --- a/fs/nfs/flexfilelayout/flexfilelayout.c
> >>>> +++ b/fs/nfs/flexfilelayout/flexfilelayout.c
> >>>> @@ -1129,7 +1129,7 @@ static int
> >>>> ff_layout_async_handle_error_v4(struct rpc_task *task,
> >>>>         case -EIO:
> >>>>         case -ETIMEDOUT:
> >>>>         case -EPIPE:
> >>>> -               dprintk("%s DS connection error %d\n", __func__,
> >>>> +               pr_warn("%s DS connection error %d\n", __func__,
> >>>>                         task->tk_status);
> >>>>                 nfs4_delete_deviceid(devid->ld, devid->nfs_client,
> >>>>                                 &devid->deviceid);
> >>>> @@ -1139,7 +1139,7 @@ static int
> >>>> ff_layout_async_handle_error_v4(struct rpc_task *task,
> >>>>                 if (ff_layout_avoid_mds_available_ds(lseg))
> >>>>                         return -NFS4ERR_RESET_TO_PNFS;
> >>>> reset:
> >>>> -               dprintk("%s Retry through MDS. Error %d\n",
> >>>> __func__,
> >>>> +               pr_warn("%s Retry through MDS. Error %d\n",
> >>>> __func__,
> >>>>                         task->tk_status);
> >>>>                 return -NFS4ERR_RESET_TO_MDS;
> >>>>         }
> >>>> @@ -1167,7 +1167,7 @@ static int
> >>>> ff_layout_async_handle_error_v3(struct rpc_task *task,
> >>>>                 nfs_inc_stats(lseg->pls_layout->plh_inode,
> >>>> NFSIOS_DELAY);
> >>>>                 goto out_retry;
> >>>>         default:
> >>>> -               dprintk("%s DS connection error %d\n", __func__,
> >>>> +               pr_warn("%s DS connection error %d\n", __func__,
> >>>>                         task->tk_status);
> >>>>                 nfs4_delete_deviceid(devid->ld, devid->nfs_client,
> >>>>                                 &devid->deviceid);
> >>>> diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
> >>>> index 679767ac258d..322661a48348 100644
> >>>> --- a/fs/nfs/pnfs_nfs.c
> >>>> +++ b/fs/nfs/pnfs_nfs.c
> >>>> @@ -934,8 +934,11 @@ static int _nfs4_pnfs_v4_ds_connect(struct
> >>>> nfs_server *mds_srv,
> >>>>                                                 (struct sockaddr
> >>>> *)&da->da_addr,
> >>>>                                                 da->da_addrlen,
> >>>> IPPROTO_TCP,
> >>>>                                                 timeo, retrans,
> >>>> minor_version);
> >>>> -                       if (IS_ERR(clp))
> >>>> +                       if (IS_ERR(clp)) {
> >>>> +                               pr_warn("%s: DS: %s unable to
> >>>> connect with address %s, error: %ld\n",
> >>>> +                                       __func__, ds->ds_remotestr,
> >>>> da->da_remotestr, PTR_ERR(clp));
> >>>>                                 continue;
> >>>> +                       }
> >>>>
> >>>>                         status = nfs4_init_ds_session(clp,
> >>>>                                         mds_srv->nfs_client-
> >>>>> cl_lease_time);
> >>>> @@ -949,6 +952,7 @@ static int _nfs4_pnfs_v4_ds_connect(struct
> >>>> nfs_server *mds_srv,
> >>>>         }
> >>>>
> >>>>         if (IS_ERR(clp)) {
> >>>> +               pr_warn("%s: no DS available\n", __func__);
> >>>>                 status = PTR_ERR(clp);
> >>>>                 goto out;
> >>>>         }
> >>>> --
> >>>> 2.21.0
> >>>>
> >>>
> >>> --
> >>> Chuck Lever
> >>>
> >>>
> >>>
> >>
> >> --
> >> Trond Myklebust
> >> Linux NFS client maintainer, Hammerspace
> >> trond.myklebust@hammerspace.com
> >>
> >>
>

