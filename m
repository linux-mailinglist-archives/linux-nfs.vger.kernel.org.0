Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 538CA32E902
	for <lists+linux-nfs@lfdr.de>; Fri,  5 Mar 2021 13:30:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhCEMaD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 5 Mar 2021 07:30:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25809 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232167AbhCEM3h (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 5 Mar 2021 07:29:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614947377;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=3me+kHJ4EUp6jI+IW7CF3IW6oO1xGLNjnHgRPxMQliM=;
        b=OlmVgCfbv+benPaKZw3YUM6hW3mGMyPtEkr8+uMyRqKr0zhxZnl0nrMCxPGTaWhvNTUqg0
        UHJAGM8gS4NZQdeEod/4sDbrcu+2NyTuA1aeaRHVoyMp3r/O3rJ8MLDEey5tY7o5SQntQW
        RQP1SrEB+XeN9b2UURx0YnyFEP8wvIE=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-slZikFVcOD6rxrnrMTRbVQ-1; Fri, 05 Mar 2021 07:29:35 -0500
X-MC-Unique: slZikFVcOD6rxrnrMTRbVQ-1
Received: by mail-il1-f197.google.com with SMTP id k5so1487352ilu.0
        for <linux-nfs@vger.kernel.org>; Fri, 05 Mar 2021 04:29:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3me+kHJ4EUp6jI+IW7CF3IW6oO1xGLNjnHgRPxMQliM=;
        b=jBdSEqDHf1s67POpzJonc318CI9z4viNuWW9+lcinQZbdEkf4CiSM8vKWUHkjLxVUC
         n9YZOqdr52Hlx1gFPuYs076NZT/Pv1F7Q6ltP8Bd+1o7RW16hPJZUULGpd8yZEfhc1rw
         M5qxfgQgP4neHcAANLYpzv6r36p+l+l9PrploK1rGq3+piMNN4pGX86LEa7qBD8fm7r1
         /czqVkNYG+Eiq/v8niWLk3eRjC5nFBoSU/g7uRm33OKDcMh2ehV/4dCVSo2KAkDvHLWo
         2cMqfRwnVDYjwussIcMXZFvEFo9lrby61UxQ3wTjWLFtbSz45JHqXhwEAcD5Sd7p8evC
         YzGg==
X-Gm-Message-State: AOAM533uaPCarUE5gyuiQqYzFtcv1XN8bbAPvmI4pMsb0grgWbGmKfr/
        19szZ6yvn2v/qKd3+4OAvsZfPY/gs7b4etZJe+EocWPA5Yl3vmeDHfszli/XoXf8H8QWUwWqnzP
        JKkHeZkpUicgjLE4dAvsc4YLqWSfVxOi1+LTL
X-Received: by 2002:a5d:9418:: with SMTP id v24mr7960653ion.61.1614947374981;
        Fri, 05 Mar 2021 04:29:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJznhO03vi5Y4moPK0xkbpUgk2/OHuDNJ7KG2eSLDGGCpuB9DAV84UuJXsTtMAPXdLGKxKzBrDo1SmM8Xg5EwL4=
X-Received: by 2002:a5d:9418:: with SMTP id v24mr7960632ion.61.1614947374695;
 Fri, 05 Mar 2021 04:29:34 -0800 (PST)
MIME-Version: 1.0
References: <20210303153307.3147-1-rbergant@redhat.com> <FBBBDFDD-6819-450C-879D-0B11B917BD10@oracle.com>
 <9e98d684c6ecdbb0395beb66a0bc694c4ca870c8.camel@hammerspace.com>
In-Reply-To: <9e98d684c6ecdbb0395beb66a0bc694c4ca870c8.camel@hammerspace.com>
From:   Roberto Bergantinos Corpas <rbergant@redhat.com>
Date:   Fri, 5 Mar 2021 13:29:21 +0100
Message-ID: <CACWnjLw9KQ+-d2otHQ_-vx34Up1A-EiY=2phQOwUu8S-ZExyhw@mail.gmail.com>
Subject: Re: [PATCH] pNFS: make DS availability problems visible in log
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Trond, Chuck

thanks for feedback. I understand the point

Sure we can turn those printks into tracepoints, done. However
original point was flag somehow DS issues
outside debug, i.e. user intervention. What about just a pr_warn_once
just for the case when at _nfs4_pnfs_v4_ds_connect
we could not reach any DS ?

On Thu, Mar 4, 2021 at 9:35 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Thu, 2021-03-04 at 20:20 +0000, Chuck Lever wrote:
> > Hello Roberto!
> >
> > > On Mar 3, 2021, at 10:33 AM, Roberto Bergantinos Corpas <
> > > rbergant@redhat.com> wrote:
> > >
> > > Would be interesting to promote DS availability logging outside
> > > debug
> > > so that we are more aware that I/O is diverted to MDS and some part
> > > of the infraestructure failed.
> > >
> > > Also added logging for failed DS connection attempts.
> >
> > Given that this enables remote system behavior to generate
> > kernel log traffic that can fill the local root partition,
> > I'd like to see either:
> >
> > - the explicit use of rate limiting, or
> >
> > - these dprintks replaced with tracepoints
>
> I cannot accept a pr_warn(), even a rate limited one, for a timeout
> error or for a connection error in the data path. Those are just too
> nasty to deal with in a syslog.
>
> Tracepoints would be acceptable.
>
> >
> >
> > > Signed-off-by: Roberto Bergantinos Corpas <rbergant@redhat.com>
> > > ---
> > > fs/nfs/filelayout/filelayout.c         | 4 ++--
> > > fs/nfs/flexfilelayout/flexfilelayout.c | 6 +++---
> > > fs/nfs/pnfs_nfs.c                      | 6 +++++-
> > > 3 files changed, 10 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/fs/nfs/filelayout/filelayout.c
> > > b/fs/nfs/filelayout/filelayout.c
> > > index 7f5aa0403e16..fef2d31a501a 100644
> > > --- a/fs/nfs/filelayout/filelayout.c
> > > +++ b/fs/nfs/filelayout/filelayout.c
> > > @@ -181,7 +181,7 @@ static int filelayout_async_handle_error(struct
> > > rpc_task *task,
> > >         case -EIO:
> > >         case -ETIMEDOUT:
> > >         case -EPIPE:
> > > -               dprintk("%s DS connection error %d\n", __func__,
> > > +               pr_warn("%s DS connection error %d\n", __func__,
> > >                         task->tk_status);
> > >                 nfs4_mark_deviceid_unavailable(devid);
> > >                 pnfs_error_mark_layout_for_return(inode, lseg);
> > > @@ -190,7 +190,7 @@ static int filelayout_async_handle_error(struct
> > > rpc_task *task,
> > >                 fallthrough;
> > >         default:
> > > reset:
> > > -               dprintk("%s Retry through MDS. Error %d\n",
> > > __func__,
> > > +               pr_warn("%s Retry through MDS. Error %d\n",
> > > __func__,
> > >                         task->tk_status);
> > >                 return -NFS4ERR_RESET_TO_MDS;
> > >         }
> > > diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c
> > > b/fs/nfs/flexfilelayout/flexfilelayout.c
> > > index a163533446fa..7150d94e80e6 100644
> > > --- a/fs/nfs/flexfilelayout/flexfilelayout.c
> > > +++ b/fs/nfs/flexfilelayout/flexfilelayout.c
> > > @@ -1129,7 +1129,7 @@ static int
> > > ff_layout_async_handle_error_v4(struct rpc_task *task,
> > >         case -EIO:
> > >         case -ETIMEDOUT:
> > >         case -EPIPE:
> > > -               dprintk("%s DS connection error %d\n", __func__,
> > > +               pr_warn("%s DS connection error %d\n", __func__,
> > >                         task->tk_status);
> > >                 nfs4_delete_deviceid(devid->ld, devid->nfs_client,
> > >                                 &devid->deviceid);
> > > @@ -1139,7 +1139,7 @@ static int
> > > ff_layout_async_handle_error_v4(struct rpc_task *task,
> > >                 if (ff_layout_avoid_mds_available_ds(lseg))
> > >                         return -NFS4ERR_RESET_TO_PNFS;
> > > reset:
> > > -               dprintk("%s Retry through MDS. Error %d\n",
> > > __func__,
> > > +               pr_warn("%s Retry through MDS. Error %d\n",
> > > __func__,
> > >                         task->tk_status);
> > >                 return -NFS4ERR_RESET_TO_MDS;
> > >         }
> > > @@ -1167,7 +1167,7 @@ static int
> > > ff_layout_async_handle_error_v3(struct rpc_task *task,
> > >                 nfs_inc_stats(lseg->pls_layout->plh_inode,
> > > NFSIOS_DELAY);
> > >                 goto out_retry;
> > >         default:
> > > -               dprintk("%s DS connection error %d\n", __func__,
> > > +               pr_warn("%s DS connection error %d\n", __func__,
> > >                         task->tk_status);
> > >                 nfs4_delete_deviceid(devid->ld, devid->nfs_client,
> > >                                 &devid->deviceid);
> > > diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
> > > index 679767ac258d..322661a48348 100644
> > > --- a/fs/nfs/pnfs_nfs.c
> > > +++ b/fs/nfs/pnfs_nfs.c
> > > @@ -934,8 +934,11 @@ static int _nfs4_pnfs_v4_ds_connect(struct
> > > nfs_server *mds_srv,
> > >                                                 (struct sockaddr
> > > *)&da->da_addr,
> > >                                                 da->da_addrlen,
> > > IPPROTO_TCP,
> > >                                                 timeo, retrans,
> > > minor_version);
> > > -                       if (IS_ERR(clp))
> > > +                       if (IS_ERR(clp)) {
> > > +                               pr_warn("%s: DS: %s unable to
> > > connect with address %s, error: %ld\n",
> > > +                                       __func__, ds->ds_remotestr,
> > > da->da_remotestr, PTR_ERR(clp));
> > >                                 continue;
> > > +                       }
> > >
> > >                         status = nfs4_init_ds_session(clp,
> > >                                         mds_srv->nfs_client-
> > > >cl_lease_time);
> > > @@ -949,6 +952,7 @@ static int _nfs4_pnfs_v4_ds_connect(struct
> > > nfs_server *mds_srv,
> > >         }
> > >
> > >         if (IS_ERR(clp)) {
> > > +               pr_warn("%s: no DS available\n", __func__);
> > >                 status = PTR_ERR(clp);
> > >                 goto out;
> > >         }
> > > --
> > > 2.21.0
> > >
> >
> > --
> > Chuck Lever
> >
> >
> >
>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>

