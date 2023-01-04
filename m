Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5EE265D7E2
	for <lists+linux-nfs@lfdr.de>; Wed,  4 Jan 2023 17:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjADQH4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Wed, 4 Jan 2023 11:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235168AbjADQHy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 4 Jan 2023 11:07:54 -0500
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517101901F
        for <linux-nfs@vger.kernel.org>; Wed,  4 Jan 2023 08:07:53 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-4b718cab0e4so31500817b3.9
        for <linux-nfs@vger.kernel.org>; Wed, 04 Jan 2023 08:07:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nxhubtM6Un6izoAsW+rQoFGbZ2X4uy8n9+hOtW7lziE=;
        b=29HS04Dy3PDuXdiznxVJZxreC1AHJeHy0dBRphWGzTG1bl01iaUL9bi/TU1D9FrnBJ
         ZyCPQtkcqkY7iEzKujwW3qbb9hwGBbPMdzYPucE2YVm/eo5OOPY2aGQ+2QLDa3FxEkdl
         PxFmiN56el5tN2p8LvQFAffC7YdxgKI19VgHnCgVOgERzNK/e4f06bFN9yu3y2GomOmW
         S30Gi2Rh45BfaJUaEv2Ky9rbUDQMdzSbyxsKuAodFscNAMTkNXmgQFjP1joSD++LLh0Q
         uY7NYZsMrWMLG7q7szhLdgBgM3F2nvk4ooUDo/rAs8mwvbmHhfekGByL63ue9+IQ7Zqx
         GM+Q==
X-Gm-Message-State: AFqh2kq5I9Wcdbdy3R329Ni80cKIJJ5XM2O/tLd5EN9OJ7EN9vNn0tpE
        Ay8y7Z9PvXocP0Flm8icdUk4xoySNg==
X-Google-Smtp-Source: AMrXdXtUXt1ZL3ybpeXFjsG1UCeKYWKFCg4ffLcMaUmKdcs/XWyo6xv+iDVo1+Tc6ssn63YiBJlQUw==
X-Received: by 2002:a05:7500:5d0a:b0:ea:b210:8f66 with SMTP id fi10-20020a0575005d0a00b000eab2108f66mr2185254gab.20.1672848472217;
        Wed, 04 Jan 2023 08:07:52 -0800 (PST)
Received: from [192.168.75.138] (c-68-32-72-208.hsd1.mi.comcast.net. [68.32.72.208])
        by smtp.gmail.com with ESMTPSA id y1-20020a37f601000000b006fa2b1c3c1esm23719396qkj.58.2023.01.04.08.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jan 2023 08:07:51 -0800 (PST)
Message-ID: <3946ae52c562b218eb2589fd191771248cd10cdf.camel@kernel.org>
Subject: Re: [PATCH] NFS: Handle missing attributes in OPEN reply
From:   Trond Myklebust <trondmy@kernel.org>
To:     Olga Kornievskaia <aglo@umich.edu>
Cc:     NeilBrown <neilb@suse.de>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Wed, 04 Jan 2023 11:07:50 -0500
In-Reply-To: <CAN-5tyENHTYFy-VG6sQpxmyL=Euwy_xvtJfQ2eL5+6CzGm3WBw@mail.gmail.com>
References: <167279203612.13974.15063003557908413815@noble.neil.brown.name>
         <7a98c3e70bae70c44418ce8ac4b84f387b4ff850.camel@kernel.org>
         <CAN-5tyEBce3ZcXt9fxN9qPStRSSb=H-3v2ZFUovJRCs3CZXgXw@mail.gmail.com>
         <5bc72c828aac19cf2f01ff57014d0dcdb35dba2c.camel@kernel.org>
         <CAN-5tyENHTYFy-VG6sQpxmyL=Euwy_xvtJfQ2eL5+6CzGm3WBw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.2 (3.46.2-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2023-01-04 at 10:09 -0500, Olga Kornievskaia wrote:
> On Tue, Jan 3, 2023 at 9:17 PM Trond Myklebust <trondmy@kernel.org>
> wrote:
> > 
> > On Tue, 2023-01-03 at 21:02 -0500, Olga Kornievskaia wrote:
> > > On Tue, Jan 3, 2023 at 7:46 PM Trond Myklebust
> > > <trondmy@kernel.org>
> > > wrote:
> > > > 
> > > > On Wed, 2023-01-04 at 11:27 +1100, NeilBrown wrote:
> > > > > 
> > > > > If a NFSv4 OPEN reply reports that the file was successfully
> > > > > opened
> > > > > but
> > > > > the subsequent GETATTR fails, Linux-NFS will attempt a stand-
> > > > > alone
> > > > > GETATTR request.  If that also fails, handling of the reply
> > > > > is
> > > > > aborted
> > > > > with error -EAGAIN and the open is attempted again from the
> > > > > start.
> > > > > 
> > > > > This leaves the server with an active state (because the OPEN
> > > > > operation
> > > > > succeeded) which the client doesn't know about.  If the open-
> > > > > owner
> > > > > (local user) did not have the file already open, this has
> > > > > minimal
> > > > > consequences for the client and only causes the server to
> > > > > spend
> > > > > resources on an open state that will never be used or
> > > > > explicitly
> > > > > closed.
> > > > > 
> > > > > If the open-owner DID already have the file open, then it
> > > > > will
> > > > > hold a
> > > > > reference to the open-state for that file, but the seq-id in
> > > > > the
> > > > > state-id will now be out-of-sync with the server.  The server
> > > > > will
> > > > > have
> > > > > incremented the seq-id, but the client will not have
> > > > > noticed.  So
> > > > > when
> > > > > the client next attempts to access the file using that state
> > > > > (READ,
> > > > > WRITE, SETATTR), the attempt will fail with
> > > > > NFS4ERR_OLD_STATEID.
> > > > > 
> > > > > The Linux-client assumes this error is due to a race and
> > > > > simply
> > > > > retries
> > > > > on the basis that the local state-id information should have
> > > > > been
> > > > > updated by another thread.  This basis is invalid in this
> > > > > case
> > > > > and
> > > > > the
> > > > > result is an infinite loop attempting IO and getting
> > > > > OLD_STATEID.
> > > > > 
> > > > > This has been observed with a NetApp Filer as the server
> > > > > (ONTAP
> > > > > 9.8
> > > > > p5,
> > > > > using NFSv4.0).  The client is creating, writing, and
> > > > > unlinking a
> > > > > particular file from multiple clients (.bash_history).  If a
> > > > > new
> > > > > OPEN
> > > > > from one client races with a REMOVE from another client while
> > > > > the
> > > > > first
> > > > > client already has the file open, the Filer can report
> > > > > success
> > > > > for
> > > > > the
> > > > > OPEN op, but NFS4ERR_STALE for the ACCESS or GETATTR ops in
> > > > > the
> > > > > OPEN
> > > > > request.  This gets the seq-id out-of-sync and a subsequent
> > > > > write
> > > > > to
> > > > > the
> > > > > other open on the first client causes the infinite loop to
> > > > > occur.
> > > > > 
> > > > > The reason that the client returns -EAGAIN is that it needs
> > > > > to
> > > > > find
> > > > > the
> > > > > inode so it can find the associated state to update the seq-
> > > > > id,
> > > > > but
> > > > > the
> > > > > inode lookup requires the file-id which is provided in the
> > > > > GETATTR
> > > > > reply.  Without the file-id normal inode lookup cannot be
> > > > > used.
> > > > > 
> > > > > This patch changes the lookup so that when the file-id is not
> > > > > available
> > > > > the list of states owned by the open-owner is examined to
> > > > > find
> > > > > the
> > > > > state
> > > > > with the correct state-id (ignoring the seq-id part of the
> > > > > state-
> > > > > id).
> > > > > If this is found it is used just as when a normal inode
> > > > > lookup
> > > > > finds
> > > > > an
> > > > > inode.  If it isn't found, -EAGAIN is returned as before.
> > > > > 
> > > > > This bug can be demonstrated by modifying the Linux NFS
> > > > > server as
> > > > > follows:
> > > > > 
> > > > > 1/ The second time a file is opened, unlink it.  This
> > > > > simulates
> > > > >    a race with another client, without needing to have a
> > > > > race:
> > > > > 
> > > > >     --- a/fs/nfsd/nfs4proc.c
> > > > >     +++ b/fs/nfsd/nfs4proc.c
> > > > >     @@ -594,6 +594,12 @@ nfsd4_open(struct svc_rqst *rqstp,
> > > > > struct
> > > > > nfsd4_compound_state *cstate,
> > > > >         if (reclaim && !status)
> > > > >                 nn->somebody_reclaimed = true;
> > > > >      out:
> > > > >     +   if (!status && open->op_stateid.si_generation > 1) {
> > > > >     +           printk("Opening gen %d\n", (int)open-
> > > > > > op_stateid.si_generation);
> > > > >     +           vfs_unlink(mnt_user_ns(resfh->fh_export-
> > > > > > ex_path.mnt),
> > > > >     +                      resfh->fh_dentry->d_parent-
> > > > > >d_inode,
> > > > >     +                      resfh->fh_dentry, NULL);
> > > > >     +   }
> > > > >         if (open->op_filp) {
> > > > >                 fput(open->op_filp);
> > > > >                 open->op_filp = NULL;
> > > > > 
> > > > > 2/ When a GETATTR op is attempted on an unlinked file, return
> > > > > ESTALE
> > > > > 
> > > > >     @@ -852,6 +858,11 @@ nfsd4_getattr(struct svc_rqst
> > > > > *rqstp,
> > > > > struct
> > > > > nfsd4_compound_state *cstate,
> > > > >         if (status)
> > > > >                 return status;
> > > > > 
> > > > >     +   if (cstate->current_fh.fh_dentry->d_inode->i_nlink ==
> > > > > 0)
> > > > > {
> > > > >     +           printk("Return Estale for unlinked file\n");
> > > > >     +           return nfserr_stale;
> > > > >     +   }
> > > > >     +
> > > > >         if (getattr->ga_bmval[1] &
> > > > > NFSD_WRITEONLY_ATTRS_WORD1)
> > > > >                 return nfserr_inval;
> > > > > 
> > > > > Then mount the filesystem and
> > > > > 
> > > > >   Thread 1            Thread 2
> > > > >   open a file
> > > > >                       open the same file (will fail)
> > > > >   write to that file
> > > > > 
> > > > > I use this shell fragment, using 'sleep' for synchronisation.
> > > > > The use of /bin/echo ensures the write is flushed when
> > > > > /bin/echo
> > > > > closes
> > > > > the fd on exit.
> > > > > 
> > > > >     (
> > > > >         /bin/echo hello
> > > > >         sleep 3
> > > > >         /bin/echo there
> > > > >     ) > /import/A/afile &
> > > > >     sleep 3
> > > > >     cat /import/A/afile
> > > > > 
> > > > > Probably when the OPEN succeeds, the GETATTR fails, and we
> > > > > don't
> > > > > already
> > > > > have the state open, we should explicitly close the state.
> > > > > Leaving
> > > > > it
> > > > > open could cause problems if, for example, the server revoked
> > > > > it
> > > > > and
> > > > > signalled the client that there was a revoked state.  The
> > > > > client
> > > > > would
> > > > > not be able to find the state that needed to be
> > > > > relinquished.  I
> > > > > haven't
> > > > > attempted to implement this.
> > > > 
> > > > 
> > > > If the server starts to reply NFS4ERR_STALE to GETATTR
> > > > requests,
> > > > why do
> > > > we care about stateid values?
> > > 
> > > It is acceptable for the server to return ESTALE to the GETATTR
> > > after
> > > the processing the open (due to a REMOVE that comes in) and that
> > > open
> > > generating a valid stateid which client should care about when
> > > there
> > > are pre-existing opens. The server will keep the state of an
> > > existing
> > > opens valid even if the file is removed. Which is what's
> > > happening,
> > > the previous open is being used for IO but the stateid is updated
> > > on
> > > the server but not on the client.
> > > 
> > > > Just mark the inode as stale and drop it
> > > > on the floor.
> > > 
> > > Why would that be correct? Any pre-existing opens should continue
> > > operating, thus the inode can't be marked stale. We don't do it
> > > now
> > > (silly rename allows preexisting IO to continue).
> > > 
> > > > If the server tries to declare the state as revoked, then it is
> > > > clearly
> > > > borken, so let NetApp fix their own bug.
> > > 
> > > The server does not declare the state revoked. The open succeeded
> > > and
> > > its state's seqid was updated but the client is using an old
> > > stateid.
> > > Server isn't at fault here.
> > 
> > If the client can't send a GETATTR, then it can't revalidate
> > attributes, do I/O, and it can't even close the file. So we're not
> > going to waste time and effort trying to support this, whether or
> > not
> > NetApp thinks it is a good idea.
> 
> That makes sense but I think the server should fail PUTFHs in the
> compounds after the REMOVE was processed, not the other (GETATTR,
> WRITE) operations, right?
> 
> 

In theory, the server is free to reply NFS4_OK to PUTFH, and then
NFS4ERR_STALE to the GETATTR, because a COMPOUND is not atomic w.r.t.
execution of the individual operations. i.e. if the file is deleted by
some other RPC call between the execution of the PUTFH and the GETATTR
in the COMPOUND, then this situation can happen.

However, my point is that once the server starts handing out
NFS4ERR_STALE errors, then the client can assume that the filehandle
being used is bad, because under RFC5661, Section 4.2.2, the server
MUST return NFS4ERR_STALE if it is presented with that filehandle
again.
IOW: the client should just toss the file associated with that
filehandle out of its inode caches, and forget any state associated
with that filehandle, because all future attempts to use it MUST result
in NFS4ERR_STALE.

-- 
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com


