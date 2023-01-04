Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26A365CBB8
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jan 2023 03:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238718AbjADCCz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Jan 2023 21:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233382AbjADCCy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 Jan 2023 21:02:54 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9607A167EF
        for <linux-nfs@vger.kernel.org>; Tue,  3 Jan 2023 18:02:53 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id w203so5237901pfc.12
        for <linux-nfs@vger.kernel.org>; Tue, 03 Jan 2023 18:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GkoBotA++mba22it49pEKlG5/xaGLFTN6mS8c3GXrk8=;
        b=Kyho25EPYhkBdtiHuRv9RrTBbrANq0Nj1pFwFylZCaBeyExXLGzqxxl14tzvw9f5UT
         FvTuAVodoGZOP+kxwakycBQZD09CJ3bAsWId+L5IywIHltOqyJpYOcKV7gG9irHRWlHw
         vWl7/sVEH6M957hsz0GiI2UVF7ExCi+LZOBSBGvBm1TseV4DrPL5u/I6hBwdcLE3FTwe
         3pvXPe/p2WuQ0lr2m5MVheUOcKMY8Rvsr0cRt4+qQrZAzRR32nQDZK8sl8Co/PfdZ8JN
         oMgt1bUTPfGDJGJuln6gxIthdSIgBibiIEHVm0hBUOBZrQ63KLOqjiJo6zXAXOmFWC9X
         ZzgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GkoBotA++mba22it49pEKlG5/xaGLFTN6mS8c3GXrk8=;
        b=2GZRwUmPJLsssSn7unQ7+c7ddAOX09NdhGXIUwK2KZpmSILTXIfkmKCfAGyW+wdEJB
         G0nA9mUprOqFN00LUg9OL4gPALWa3lGsVUl5T67vhpf8TwZMq7CJh8xPkdAaEwfLUjRE
         VzwWt56+KLBKTg+pPdiErMjlNKhBiFDKDOsoNNZrGex07twF0pAYMSdUpV2L0pBfZckh
         ZXWUA8B29fyvFCQapRmxjpxWWCNIUQJwAAt8r2vSIzb2peF7k7O9pSzZJLR4lG5gNFKh
         dl+GXpQkch5RJqXTWEEx/zq+R2THCf2OqrI69NWla6xTEp6o5l3mqHVrlQKC6s7QnJRM
         7BMA==
X-Gm-Message-State: AFqh2kpJjUR88nBDqeO3bk5hA6dCh0MGl2LoQPZ9eKRLezm7lCM5rCJG
        ZlyXn65Myy8O2kNR7lFaxCbJy/ibxDsjf9Y9YM4=
X-Google-Smtp-Source: AMrXdXs0iYRYTVtOS5Iu/ePmurnXNXDadG3I0tEbOkSqf1fHXI1WF7LGG1PAKTIal2VlyKWhsNPZDe8YI7hwLogMgyk=
X-Received: by 2002:a65:6d17:0:b0:48b:acbd:7357 with SMTP id
 bf23-20020a656d17000000b0048bacbd7357mr1871872pgb.331.1672797772914; Tue, 03
 Jan 2023 18:02:52 -0800 (PST)
MIME-Version: 1.0
References: <167279203612.13974.15063003557908413815@noble.neil.brown.name> <7a98c3e70bae70c44418ce8ac4b84f387b4ff850.camel@kernel.org>
In-Reply-To: <7a98c3e70bae70c44418ce8ac4b84f387b4ff850.camel@kernel.org>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 3 Jan 2023 21:02:41 -0500
Message-ID: <CAN-5tyEBce3ZcXt9fxN9qPStRSSb=H-3v2ZFUovJRCs3CZXgXw@mail.gmail.com>
Subject: Re: [PATCH] NFS: Handle missing attributes in OPEN reply
To:     Trond Myklebust <trondmy@kernel.org>
Cc:     NeilBrown <neilb@suse.de>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Jan 3, 2023 at 7:46 PM Trond Myklebust <trondmy@kernel.org> wrote:
>
> On Wed, 2023-01-04 at 11:27 +1100, NeilBrown wrote:
> >
> > If a NFSv4 OPEN reply reports that the file was successfully opened
> > but
> > the subsequent GETATTR fails, Linux-NFS will attempt a stand-alone
> > GETATTR request.  If that also fails, handling of the reply is
> > aborted
> > with error -EAGAIN and the open is attempted again from the start.
> >
> > This leaves the server with an active state (because the OPEN
> > operation
> > succeeded) which the client doesn't know about.  If the open-owner
> > (local user) did not have the file already open, this has minimal
> > consequences for the client and only causes the server to spend
> > resources on an open state that will never be used or explicitly
> > closed.
> >
> > If the open-owner DID already have the file open, then it will hold a
> > reference to the open-state for that file, but the seq-id in the
> > state-id will now be out-of-sync with the server.  The server will
> > have
> > incremented the seq-id, but the client will not have noticed.  So
> > when
> > the client next attempts to access the file using that state (READ,
> > WRITE, SETATTR), the attempt will fail with NFS4ERR_OLD_STATEID.
> >
> > The Linux-client assumes this error is due to a race and simply
> > retries
> > on the basis that the local state-id information should have been
> > updated by another thread.  This basis is invalid in this case and
> > the
> > result is an infinite loop attempting IO and getting OLD_STATEID.
> >
> > This has been observed with a NetApp Filer as the server (ONTAP 9.8
> > p5,
> > using NFSv4.0).  The client is creating, writing, and unlinking a
> > particular file from multiple clients (.bash_history).  If a new OPEN
> > from one client races with a REMOVE from another client while the
> > first
> > client already has the file open, the Filer can report success for
> > the
> > OPEN op, but NFS4ERR_STALE for the ACCESS or GETATTR ops in the OPEN
> > request.  This gets the seq-id out-of-sync and a subsequent write to
> > the
> > other open on the first client causes the infinite loop to occur.
> >
> > The reason that the client returns -EAGAIN is that it needs to find
> > the
> > inode so it can find the associated state to update the seq-id, but
> > the
> > inode lookup requires the file-id which is provided in the GETATTR
> > reply.  Without the file-id normal inode lookup cannot be used.
> >
> > This patch changes the lookup so that when the file-id is not
> > available
> > the list of states owned by the open-owner is examined to find the
> > state
> > with the correct state-id (ignoring the seq-id part of the state-id).
> > If this is found it is used just as when a normal inode lookup finds
> > an
> > inode.  If it isn't found, -EAGAIN is returned as before.
> >
> > This bug can be demonstrated by modifying the Linux NFS server as
> > follows:
> >
> > 1/ The second time a file is opened, unlink it.  This simulates
> >    a race with another client, without needing to have a race:
> >
> >     --- a/fs/nfsd/nfs4proc.c
> >     +++ b/fs/nfsd/nfs4proc.c
> >     @@ -594,6 +594,12 @@ nfsd4_open(struct svc_rqst *rqstp, struct
> > nfsd4_compound_state *cstate,
> >         if (reclaim && !status)
> >                 nn->somebody_reclaimed = true;
> >      out:
> >     +   if (!status && open->op_stateid.si_generation > 1) {
> >     +           printk("Opening gen %d\n", (int)open-
> > >op_stateid.si_generation);
> >     +           vfs_unlink(mnt_user_ns(resfh->fh_export-
> > >ex_path.mnt),
> >     +                      resfh->fh_dentry->d_parent->d_inode,
> >     +                      resfh->fh_dentry, NULL);
> >     +   }
> >         if (open->op_filp) {
> >                 fput(open->op_filp);
> >                 open->op_filp = NULL;
> >
> > 2/ When a GETATTR op is attempted on an unlinked file, return ESTALE
> >
> >     @@ -852,6 +858,11 @@ nfsd4_getattr(struct svc_rqst *rqstp, struct
> > nfsd4_compound_state *cstate,
> >         if (status)
> >                 return status;
> >
> >     +   if (cstate->current_fh.fh_dentry->d_inode->i_nlink == 0) {
> >     +           printk("Return Estale for unlinked file\n");
> >     +           return nfserr_stale;
> >     +   }
> >     +
> >         if (getattr->ga_bmval[1] & NFSD_WRITEONLY_ATTRS_WORD1)
> >                 return nfserr_inval;
> >
> > Then mount the filesystem and
> >
> >   Thread 1            Thread 2
> >   open a file
> >                       open the same file (will fail)
> >   write to that file
> >
> > I use this shell fragment, using 'sleep' for synchronisation.
> > The use of /bin/echo ensures the write is flushed when /bin/echo
> > closes
> > the fd on exit.
> >
> >     (
> >         /bin/echo hello
> >         sleep 3
> >         /bin/echo there
> >     ) > /import/A/afile &
> >     sleep 3
> >     cat /import/A/afile
> >
> > Probably when the OPEN succeeds, the GETATTR fails, and we don't
> > already
> > have the state open, we should explicitly close the state.  Leaving
> > it
> > open could cause problems if, for example, the server revoked it and
> > signalled the client that there was a revoked state.  The client
> > would
> > not be able to find the state that needed to be relinquished.  I
> > haven't
> > attempted to implement this.
>
>
> If the server starts to reply NFS4ERR_STALE to GETATTR requests, why do
> we care about stateid values?

It is acceptable for the server to return ESTALE to the GETATTR after
the processing the open (due to a REMOVE that comes in) and that open
generating a valid stateid which client should care about when there
are pre-existing opens. The server will keep the state of an existing
opens valid even if the file is removed. Which is what's happening,
the previous open is being used for IO but the stateid is updated on
the server but not on the client.

> Just mark the inode as stale and drop it
> on the floor.

Why would that be correct? Any pre-existing opens should continue
operating, thus the inode can't be marked stale. We don't do it now
(silly rename allows preexisting IO to continue).

> If the server tries to declare the state as revoked, then it is clearly
> borken, so let NetApp fix their own bug.

The server does not declare the state revoked. The open succeeded and
its state's seqid was updated but the client is using an old stateid.
Server isn't at fault here.

>
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
