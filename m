Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE3B2BC0C4
	for <lists+linux-nfs@lfdr.de>; Sat, 21 Nov 2020 18:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgKURCh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 21 Nov 2020 12:02:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43634 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726476AbgKURCg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 21 Nov 2020 12:02:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605978154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hKxB2AdK4Y+8BKLr54nAD1KLu+7AIkEHOfuhlTwS1w0=;
        b=YlRuYs1nrs9ZoOW8vyp5x2k1/tGv1kWRGfSiNboVFnm36lKPZBA+G9I3MECCcmEmIrh546
        vNcV3+nsJcQE7ZGcVhlgXPJn0dXuw9RCF/uODom81EFtH7GRHtLqj5qmcpcaLGNkW7AIc1
        r5s32m+85rTCY2Jb2Ln3pC+UZwEgzjM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-569-PZeh3SdqOt-ug24EyKrtVQ-1; Sat, 21 Nov 2020 12:02:30 -0500
X-MC-Unique: PZeh3SdqOt-ug24EyKrtVQ-1
Received: by mail-ed1-f71.google.com with SMTP id g25so158408edu.21
        for <linux-nfs@vger.kernel.org>; Sat, 21 Nov 2020 09:02:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hKxB2AdK4Y+8BKLr54nAD1KLu+7AIkEHOfuhlTwS1w0=;
        b=LbnB8xJxNU9zaWGfs0tlzrUB6CMIiSiwcY7PXyStBQrJydovRCaLivpFnSIZej3afX
         7MJkGhrDZlKJ0Ht9bP7v0cQoJrgLyJMHcidHhwZ6ZMvdCTGqVZsZJ0oLxpnp8WPqpUzp
         oIgDlGwoliMkohTazbRexCM048ElKt0ABIW0NGj7nTYtxg47l8xZnlefNFgN7IffEvVY
         pTyHxQzQTw70r8+qbRN60uz4Y8cN3Cu91By6J09PdRahVJGzcD/qWfQj1FiKkGDJK+Mt
         bzCQx+KRFCbmqB/tzXBIzBrbUBrJDTNOQYskYbLwlnaEWQ2Vk/3jV+9CFovE1q0NpLH9
         f72Q==
X-Gm-Message-State: AOAM532I9VC6iRXQd05zRg+U4QWWH2jvRLeKWvNYfiA7zq+GOKrLAxpm
        GqFl+9WhnRbZbDzos16RjtcO4VDlshqeYfFW1bHj2GnSYn4jEnNi5YlrXBGgzxy3GvarCoGeO1h
        fRTcDIHvTIyV6SKYxeM6d7qSlJzNxfkQAtCEl
X-Received: by 2002:aa7:d2c4:: with SMTP id k4mr22175867edr.367.1605978149382;
        Sat, 21 Nov 2020 09:02:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwWYrXfqB9jQmUGZa4449LkDCm6t6yCL0uLCSNng05XmblGfK45fLsp/yoU221E9pYsJ/4XPeGQUrNvVoV+9Vs=
X-Received: by 2002:aa7:d2c4:: with SMTP id k4mr22175841edr.367.1605978149111;
 Sat, 21 Nov 2020 09:02:29 -0800 (PST)
MIME-Version: 1.0
References: <1605965348-24468-1-git-send-email-dwysocha@redhat.com> <017D0771-4BA1-4A97-A077-6222B8CF1B57@oracle.com>
In-Reply-To: <017D0771-4BA1-4A97-A077-6222B8CF1B57@oracle.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Sat, 21 Nov 2020 12:01:52 -0500
Message-ID: <CALF+zOmTSqJycjadduibk2sA-iqB3_FdtAX8zGtx4Qn1hXNCKA@mail.gmail.com>
Subject: Re: [PATCH v1 0/13] Convert NFS to new netfs and fscache APIs
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Sat, Nov 21, 2020 at 11:14 AM Chuck Lever <chuck.lever@oracle.com> wrote:
>
> Hi Dave-
>
> > On Nov 21, 2020, at 8:29 AM, Dave Wysochanski <dwysocha@redhat.com> wrote:
> >
> > These patches update the NFS client to use the new netfs and fscache
> > APIs and are at:
> > https://github.com/DaveWysochanskiRH/kernel.git
> > https://github.com/DaveWysochanskiRH/kernel/commit/94e9633d98a5542ea384b1095290ac6f915fc917
> > https://github.com/DaveWysochanskiRH/kernel/releases/tag/fscache-iter-nfs-20201120
> >
> > The patches are based on David Howells fscache-iter tree at
> > https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-iter
> >
> > The first 6 patches refactor some of the NFS read code to facilitate
> > re-use, the next 6 patches do the conversion to the new API, and the
> > last patch is a somewhat awkward fix for a problem seen in final
> > testing.
> >
> > Per David Howell's recent post, note that the new fscache API is
> > divided into two separate APIs, a 'netfs' API and an 'fscache' API.
> > The netfs API was done to help simplify the IO paths of network
> > filesystems, and can be called even when fscache is disabled, thus
> > simplifing both readpage and readahead implementations.  However,
> > for now these NFS conversion patches only call the netfs API when
> > fscache is enabled, similar to the existing NFS code.
> >
> > Trond and Anna, I would appreciate your guidance on this patchset.
> > At least I would like your feedback regarding the direction
> > you would like these patches to go, in particular, the following
> > items:
> >
> > 1. Whether you are ok with using the netfs API unconditionally even
> > when fscache is disabled, or prefer this "least invasive to NFS"
> > approach.  Note the unconditional use of the netfs API is the
> > recommended approach per David's post and the AFS and CEPH
> > implementations, but I was unsure if you would accept this
> > approach or would prefer to minimize changes to NFS.  Note if
> > we keep the current approach to minimize NFS changes, we will
> > have to address some problems with page unlocking such as with
> > patch 13 in the series.
> >
> > 2. Whether to keep the NFS fscache implementation as "read only"
> > or if we add write through support.  Today we only enable fscache
> > when a file is open read-only and disable / invalidate when a file
> > is open for write.
> >
> > Still TODO
> > 1. Address known issues (lockdep, page unlocking), depending on
> > what is decided as far as implementation direction
> >  a) nfs_issue_op: takes rcu_read_lock but may calls nfs_page_alloc()
> >  with GFP_KERNEL which may sleep (dhowells noted this in a review)
> >  b) nfs_refresh_inode() takes inode->i_lock but may call
> >  __fscache_invalidate() which may sleep (found with lockdep)
> > 2. Fixup NFS fscache stats (NFSIOS_FSCACHE_*)
> > * Compare with netfs stats and determine if still needed
> > 3. Cleanup dfprintks and/or convert to tracepoints
> > 4. Further tests (see "Not tested yet")
>
> Can you say whether your approach has any performance impact?
No I cannot.

> In particular, what comparative benchmarks have been run?
>
No comparisons so far, but note the last bullet - "performance".

Are you wondering about performance with/without fscache for this
series, or the old vs new fscache, or something else?


>
> > Checks run
> > 1. checkpatch: PASS*
> >  * a few warnings, mostly trivial fixups, some unrelated to this set
> > 2. kernel builds with each patch: PASS
> >  * each patch in series built cleanly which ensure bisection
> >
> > Tests run
> > 1. Custom NFS+fscache unit tests for basic operation: PASS*
> >  * no oops or data corruptions
> >  * Some op counts are a bit off but these are mostly due
> >    to statistics not implemented properly (NFSIOS_FSCACHE_*)
> > 2. cthon04: PASS (test options "-b -g -s -l", fsc,vers=3,4.0,4.1,4.2,sec=sys)
> > * No failures or oopses for any version or test options
> > 3. iozone tests (fsc,vers=3,4.0,4.1,4.2,sec=sys): PASS
> > * No failures or oopses
> > 4. kernel build (fsc,vers=3,4.1,4.2): PASS*
> >  * all builds finish without errors or data corruption
> >  * one lockdep "scheduling while atomic" fired with NFS41 and
> >    was due to one an fscache invalidation code path (known issue 'b' above)
> > 5. xfstests/generic (fsc,vers=4.2, nofsc,vers=4.2): PASS*
> >   * generic/013 (pass but triggers i_lock lockdep warning known issue 'a' above)
> >   * NOTE: The following tests failed with errors, but they
> >     also fail on vanilla 5.10-rc4 so are not related to this
> >     patchset
> >     * generic/074 (lockep invalid wait context - nfs_free_request())
> >     * generic/538 (short read)
> >     * generic/551 (pread: Unknown error 524, Data verification fail)
> >     * generic/568 (ERROR: File grew from 4096 B to 8192 B when writing to the fallocated range)
> >
> > Not tested yet:
> > * error injections (for example, connection disruptions, server errors during IO, etc)
> > * pNFS
> > * many process mixed read/write on same file
> > * performance
> > Dave Wysochanski (13):
> >  NFS: Clean up nfs_readpage() and nfs_readpages()
> >  NFS: In nfs_readpage() only increment NFSIOS_READPAGES when read
> >    succeeds
> >  NFS: Refactor nfs_readpage() and nfs_readpage_async() to use
> >    nfs_readdesc
> >  NFS: Call readpage_async_filler() from nfs_readpage_async()
> >  NFS: Add nfs_pageio_complete_read() and remove nfs_readpage_async()
> >  NFS: Allow internal use of read structs and functions
> >  NFS: Convert fscache_acquire_cookie and fscache_relinquish_cookie
> >  NFS: Convert fscache_enable_cookie and fscache_disable_cookie
> >  NFS: Convert fscache invalidation and update aux_data and i_size
> >  NFS: Convert to the netfs API and nfs_readpage to use netfs_readpage
> >  NFS: Convert readpage to readahead and use netfs_readahead for fscache
> >  NFS: Allow NFS use of new fscache API in build
> >  NFS: Ensure proper page unlocking when reads fail with retryable
> >    errors
> >
> > fs/nfs/Kconfig             |   2 +-
> > fs/nfs/direct.c            |   2 +
> > fs/nfs/file.c              |  22 ++--
> > fs/nfs/fscache-index.c     |  94 --------------
> > fs/nfs/fscache.c           | 315 ++++++++++++++++++++-------------------------
> > fs/nfs/fscache.h           | 132 +++++++------------
> > fs/nfs/inode.c             |   4 +-
> > fs/nfs/internal.h          |   8 ++
> > fs/nfs/nfs4proc.c          |   2 +-
> > fs/nfs/pagelist.c          |   2 +
> > fs/nfs/read.c              | 248 ++++++++++++++++-------------------
> > fs/nfs/write.c             |   3 +-
> > include/linux/nfs_fs.h     |   5 +-
> > include/linux/nfs_iostat.h |   2 +-
> > include/linux/nfs_page.h   |   1 +
> > include/linux/nfs_xdr.h    |   1 +
> > 16 files changed, 339 insertions(+), 504 deletions(-)
> >
> > --
> > 1.8.3.1
> >
>
> --
> Chuck Lever
>
>
>

