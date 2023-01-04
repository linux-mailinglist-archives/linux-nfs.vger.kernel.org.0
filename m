Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A1865CB13
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jan 2023 01:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238610AbjADAqh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Tue, 3 Jan 2023 19:46:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238921AbjADAq3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 3 Jan 2023 19:46:29 -0500
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C64C56
        for <linux-nfs@vger.kernel.org>; Tue,  3 Jan 2023 16:46:28 -0800 (PST)
Received: by mail-qt1-f178.google.com with SMTP id s9so26135687qtx.6
        for <linux-nfs@vger.kernel.org>; Tue, 03 Jan 2023 16:46:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F9ogT1kReD5ZOnOfZooeqasNV4jfCbWdyFGDvK95BII=;
        b=ilggdf/mFVdr7WzesGORgSb1FSFt/mrHRMNzAn9NVJ4CDn9d9hsSrGTmHMIufdngio
         TM30WfWyuahHuHQ/QeAZHqecBigrQkAR7t5GsUDIvWqDk3E5h3FqOTaxIUKqlRqoUUdl
         UXtLRz7qo7Y+AYmfNUhn/dF+KMI/5ttqP2MaOFmHk2u3WZREnCXjvpNNYcSN03ThixIH
         R/6dU3LNo25gTlOsvTEVsjXWxV23O315JKFpzP1ryXKbxzjo+hbSFOy02RqDdDSH/vSQ
         nhH6Ipj/R3PBgxedAZWZLEB9utooES0gHqvmyu1MVRuPiBLlWWf4I7Nyy2iO5SxbA4Kg
         C88g==
X-Gm-Message-State: AFqh2krTRcQcxXqCjzIeFq5W577BMY/z2+gjZdJgdqMGCh2Kpo2XnAy6
        kOc4D9MvrxRt6EViADKKww==
X-Google-Smtp-Source: AMrXdXuEdfXff76FRDICOnG9VJBHq9OVJiM85+AuNW7sxHs6fgSQsry1VJugmKhRaVHOC+sGMcv77w==
X-Received: by 2002:a05:622a:4116:b0:3a8:1ba:b8ab with SMTP id cc22-20020a05622a411600b003a801bab8abmr72516398qtb.6.1672793187232;
        Tue, 03 Jan 2023 16:46:27 -0800 (PST)
Received: from [192.168.75.138] (c-68-32-72-208.hsd1.mi.comcast.net. [68.32.72.208])
        by smtp.gmail.com with ESMTPSA id p18-20020ac87412000000b003a4c3c4d2d4sm19562983qtq.49.2023.01.03.16.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 16:46:26 -0800 (PST)
Message-ID: <7a98c3e70bae70c44418ce8ac4b84f387b4ff850.camel@kernel.org>
Subject: Re: [PATCH] NFS: Handle missing attributes in OPEN reply
From:   Trond Myklebust <trondmy@kernel.org>
To:     NeilBrown <neilb@suse.de>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     Olga Kornievskaia <aglo@umich.edu>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Tue, 03 Jan 2023 19:46:25 -0500
In-Reply-To: <167279203612.13974.15063003557908413815@noble.neil.brown.name>
References: <167279203612.13974.15063003557908413815@noble.neil.brown.name>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2023-01-04 at 11:27 +1100, NeilBrown wrote:
> 
> If a NFSv4 OPEN reply reports that the file was successfully opened
> but
> the subsequent GETATTR fails, Linux-NFS will attempt a stand-alone
> GETATTR request.  If that also fails, handling of the reply is
> aborted
> with error -EAGAIN and the open is attempted again from the start.
> 
> This leaves the server with an active state (because the OPEN
> operation
> succeeded) which the client doesn't know about.  If the open-owner
> (local user) did not have the file already open, this has minimal
> consequences for the client and only causes the server to spend
> resources on an open state that will never be used or explicitly
> closed.
> 
> If the open-owner DID already have the file open, then it will hold a
> reference to the open-state for that file, but the seq-id in the
> state-id will now be out-of-sync with the server.  The server will
> have
> incremented the seq-id, but the client will not have noticed.  So
> when
> the client next attempts to access the file using that state (READ,
> WRITE, SETATTR), the attempt will fail with NFS4ERR_OLD_STATEID.
> 
> The Linux-client assumes this error is due to a race and simply
> retries
> on the basis that the local state-id information should have been
> updated by another thread.  This basis is invalid in this case and
> the
> result is an infinite loop attempting IO and getting OLD_STATEID.
> 
> This has been observed with a NetApp Filer as the server (ONTAP 9.8
> p5,
> using NFSv4.0).  The client is creating, writing, and unlinking a
> particular file from multiple clients (.bash_history).  If a new OPEN
> from one client races with a REMOVE from another client while the
> first
> client already has the file open, the Filer can report success for
> the
> OPEN op, but NFS4ERR_STALE for the ACCESS or GETATTR ops in the OPEN
> request.  This gets the seq-id out-of-sync and a subsequent write to
> the
> other open on the first client causes the infinite loop to occur.
> 
> The reason that the client returns -EAGAIN is that it needs to find
> the
> inode so it can find the associated state to update the seq-id, but
> the
> inode lookup requires the file-id which is provided in the GETATTR
> reply.  Without the file-id normal inode lookup cannot be used.
> 
> This patch changes the lookup so that when the file-id is not
> available
> the list of states owned by the open-owner is examined to find the
> state
> with the correct state-id (ignoring the seq-id part of the state-id).
> If this is found it is used just as when a normal inode lookup finds
> an
> inode.  If it isn't found, -EAGAIN is returned as before.
> 
> This bug can be demonstrated by modifying the Linux NFS server as
> follows:
> 
> 1/ The second time a file is opened, unlink it.  This simulates
>    a race with another client, without needing to have a race:
> 
>     --- a/fs/nfsd/nfs4proc.c
>     +++ b/fs/nfsd/nfs4proc.c
>     @@ -594,6 +594,12 @@ nfsd4_open(struct svc_rqst *rqstp, struct
> nfsd4_compound_state *cstate,
>         if (reclaim && !status)
>                 nn->somebody_reclaimed = true;
>      out:
>     +   if (!status && open->op_stateid.si_generation > 1) {
>     +           printk("Opening gen %d\n", (int)open-
> >op_stateid.si_generation);
>     +           vfs_unlink(mnt_user_ns(resfh->fh_export-
> >ex_path.mnt),
>     +                      resfh->fh_dentry->d_parent->d_inode,
>     +                      resfh->fh_dentry, NULL);
>     +   }
>         if (open->op_filp) {
>                 fput(open->op_filp);
>                 open->op_filp = NULL;
> 
> 2/ When a GETATTR op is attempted on an unlinked file, return ESTALE
> 
>     @@ -852,6 +858,11 @@ nfsd4_getattr(struct svc_rqst *rqstp, struct
> nfsd4_compound_state *cstate,
>         if (status)
>                 return status;
> 
>     +   if (cstate->current_fh.fh_dentry->d_inode->i_nlink == 0) {
>     +           printk("Return Estale for unlinked file\n");
>     +           return nfserr_stale;
>     +   }
>     +
>         if (getattr->ga_bmval[1] & NFSD_WRITEONLY_ATTRS_WORD1)
>                 return nfserr_inval;
> 
> Then mount the filesystem and
> 
>   Thread 1            Thread 2
>   open a file
>                       open the same file (will fail)
>   write to that file
> 
> I use this shell fragment, using 'sleep' for synchronisation.
> The use of /bin/echo ensures the write is flushed when /bin/echo
> closes
> the fd on exit.
> 
>     (
>         /bin/echo hello
>         sleep 3
>         /bin/echo there
>     ) > /import/A/afile &
>     sleep 3
>     cat /import/A/afile
> 
> Probably when the OPEN succeeds, the GETATTR fails, and we don't
> already
> have the state open, we should explicitly close the state.  Leaving
> it
> open could cause problems if, for example, the server revoked it and
> signalled the client that there was a revoked state.  The client
> would
> not be able to find the state that needed to be relinquished.  I
> haven't
> attempted to implement this.


If the server starts to reply NFS4ERR_STALE to GETATTR requests, why do
we care about stateid values? Just mark the inode as stale and drop it
on the floor.

If the server tries to declare the state as revoked, then it is clearly
borken, so let NetApp fix their own bug.

-- 
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com


