Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58C5A1E6DF4
	for <lists+linux-nfs@lfdr.de>; Thu, 28 May 2020 23:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436702AbgE1Vni (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 28 May 2020 17:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436699AbgE1Vnd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 28 May 2020 17:43:33 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3E7EC08C5C6
        for <linux-nfs@vger.kernel.org>; Thu, 28 May 2020 14:43:31 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id g9so94758edr.8
        for <linux-nfs@vger.kernel.org>; Thu, 28 May 2020 14:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+5OU18pdWQmjRgZkwejw9Lhwr84rEvzIJq8OkCWgsbA=;
        b=keEUfliQkxzQykWNY5wFiYzHlUUMcrcFbG1CZAjHiULD6jsznwuVK/WG3qy8tnpT8a
         GVyI9hPUvjxxZGKVVKjUm9ZP7dJ/KYzz2Lp8jLjrqIHrD3hzWBBXllMq5krjb+s6mUed
         4IPrsu6DVkwS46tvZRvEiDLGRRObmSdcsDP2MD86q5RQ32hxG6DMk4X5cvwmh+0bObF0
         J9OAuoZ3IaRUNcRna8aAPpcFA/6JG6R4PkTMDyjW4Shx4iEMg0tup1Mt0QYCOtJr9nlo
         CE+kTSKT+U/8zifp+7CToqfxjAEQ+ckuW2tUQYlGqULdvjnugvLa8DRmAMA09Fr6IxWe
         k8RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+5OU18pdWQmjRgZkwejw9Lhwr84rEvzIJq8OkCWgsbA=;
        b=ZEjLv728rOIGixusVc47mav+aBYgBx+IveI+hztKsIln/hXzZG7WqdFQEvzwoBBGzq
         DQ+B4BOcvfuHr19fF5m8WiZ0qRNbgMnKte8aZan7qiPMa9Qe2MP/7RezuSfbhGmsvwrq
         tTF1im1BoScFVEgXBET7NTLdNSiKEADz6lOZBViJlqO/fvYKzpEukACkf3g9jAYqgtmY
         OIFQurGoOn6iQ42UiK7FjXY/M2i2J3Tc6WQUYh1G+DofKzMjnA7dIiCBocK9V5QDU/MO
         FqFN/cFn6t+X3It9QAxAyxNMim6wolv3yyKXJW5KUlu9uLZ2TG8OCwTri5m8u0RjzKnw
         A+oA==
X-Gm-Message-State: AOAM532DM3F0YqAmN556CNney0JWVPSfLQ5ck7Eb3Ro8KjTIUfbVW4sM
        Z0sWq1icg4lrh7IGArCL0whPOWf2b9Mx098sQh5qYE6K
X-Google-Smtp-Source: ABdhPJydNayN/i5EAbZ1K7Og4Z9HvEcd7O1OfMXbnPohUlYdVQIMJIKRtvdtONGaERgjij8bl7BYHocOQ5N9JxXSBHw=
X-Received: by 2002:aa7:d650:: with SMTP id v16mr5072023edr.267.1590702210482;
 Thu, 28 May 2020 14:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyE-hr2Fd1dKt=DUrVh-FJXzgGx5zhWr17SSbM1LOZ-pGQ@mail.gmail.com>
 <85234f9bde1c419e1a8d7e8a677e5d324325c56b.camel@hammerspace.com>
In-Reply-To: <85234f9bde1c419e1a8d7e8a677e5d324325c56b.camel@hammerspace.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 28 May 2020 17:43:19 -0400
Message-ID: <CAN-5tyHcExq5CqwrU3F4nRptt1=X917jzceUqLCTCUDYQsdsMA@mail.gmail.com>
Subject: Re: How to handle revocation of locking state
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, May 28, 2020 at 5:10 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> Hi Olga,
>
> On Thu, 2020-05-28 at 16:42 -0400, Olga Kornievskaia wrote:
> > Hi folks,
> >
> > Looking for recommendation on what the client is suppose to be doing
> > in the following situation. Client opens a file and has a byte-range
> > lock which returned a locking state. Client is acquiring another byte
> > range lock. It uses the returned locking stated for the 2nd lock.
> > Server returns ADMIN_REVOKED.
> >
> > Currently the client goes into an infinite loop of just resending the
> > same LOCK operation with
> > the same locking stateid.
> >
> > Is this a recoverable situation? The fact that the lock state was
> > revoked, should it be an automatic EIO since previous lock is lost
> > (so
> > why bother going forward)? Or should the client retry the lock but
> > send it with the open stateid?
> >
> > Thank you.
>
> I think the right behaviour should be to just call
> nfs_inode_find_state_and_recover(). In principle that will end up
> either recovering the lock (if the user set the nfs.recover_lost_locks
> kernel parameter to 'true') or marking it as a lost lock, using
> NFS_LOCK_LOST.

Why should acquiring of the 2nd lock depend on recovering the lock
who's stateid it was trying to use? I think the 1st stateid is lost
unrecoverable?

Right now what happens is code initiates recovery. open is sent. But
the retry of the 2nd lock has the INITIALIZED_LOCK set and so it takes
the bad lock stateid (how about instead letting it use the recovered
open stateid?). How about instead do the follow.

diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 2b7f6dc..7723bd7 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -147,6 +147,7 @@ struct nfs4_lock_state {
        struct nfs4_state *     ls_state;       /* Pointer to open state */
 #define NFS_LOCK_INITIALIZED 0
 #define NFS_LOCK_LOST        1
+#define NFS_LOCK_REVOKED     2
        unsigned long           ls_flags;
        struct nfs_seqid_counter        ls_seqid;
        nfs4_stateid            ls_stateid;
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 9056f3d..6769370 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6792,7 +6792,8 @@ static void nfs4_lock_prepare(struct rpc_task *task, void
        if (nfs_wait_on_sequence(data->arg.lock_seqid, task) != 0)
                goto out_wait;
        /* Do we need to do an open_to_lock_owner? */
-       if (!test_bit(NFS_LOCK_INITIALIZED, &data->lsp->ls_flags)) {
+       if (!test_bit(NFS_LOCK_INITIALIZED, &data->lsp->ls_flags) ||
+               test_and_clear_bit(NFS_LOCK_REVOKED, &data->lsp->ls_flags)) {
                if (nfs_wait_on_sequence(data->arg.open_seqid, task) != 0) {
                        goto out_release_lock_seqid;
                }

Alternatively I have also thought about clearing the
NFS_LOCK_INITIALIZED in the nfs4_handle_setlk_error(). It leads to the
1st lock being marked lost (and having a message in the log) and then
2nd lock can proceed.

diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 9056f3d..2c78464 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -6908,8 +6908,10 @@ static void nfs4_handle_setlk_error(struct
nfs_server *server, struct nfs4_lock_
        case -NFS4ERR_BAD_STATEID:
                lsp->ls_seqid.flags &= ~NFS_SEQID_CONFIRMED;
                if (new_lock_owner != 0 ||
-                  test_bit(NFS_LOCK_INITIALIZED, &lsp->ls_flags) != 0)
+                  test_bit(NFS_LOCK_INITIALIZED, &lsp->ls_flags) != 0) {
                        nfs4_schedule_stateid_recovery(server, lsp->ls_state);
+                       clear_bif(NFS_LOCK_INITIALIZED, &lsp->ls_flags);
+               }
                break;
        case -NFS4ERR_STALE_STATEID:
                lsp->ls_seqid.flags &= ~NFS_SEQID_CONFIRMED;

>
> Cheers
>   Trond
> --
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
>
>
