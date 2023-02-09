Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6037690C4F
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Feb 2023 15:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjBIO7S (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Feb 2023 09:59:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjBIO7R (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Feb 2023 09:59:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDF610AA0
        for <linux-nfs@vger.kernel.org>; Thu,  9 Feb 2023 06:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675954709;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=M+Hn8xZygT9no9fpTt3S5jCK2p1FSMh8HQBhcvNZD6Q=;
        b=Wt2eXJds2iwUDo+TAkbGuZ/5XU8aQXIfGX/kJ37ci5P8vsIGx01K+JiQaRJ1Uot8f0tH+3
        rXA7kGxaQIi1I4+x366b22dtlhd+DLCK+VAkd1JjNWaPhChZPWg1+1dejktw/eFyUhZXtq
        EZPfcawhxSP9tODPju8k6gTn/mWWCuc=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-512-bj1KJ14FNe2RUwS5QK-Sog-1; Thu, 09 Feb 2023 09:58:28 -0500
X-MC-Unique: bj1KJ14FNe2RUwS5QK-Sog-1
Received: by mail-pf1-f200.google.com with SMTP id by5-20020a056a00400500b005a8158ee7d6so1156123pfb.6
        for <linux-nfs@vger.kernel.org>; Thu, 09 Feb 2023 06:58:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M+Hn8xZygT9no9fpTt3S5jCK2p1FSMh8HQBhcvNZD6Q=;
        b=Enw0BR1B673C1hI10jFwbRrTjLccI/8JlpAVxSZmhoXZsrmBS3c3Qh+hdmVsIGNODG
         M8ISV3/hjYRb6aXi5iQT7CtCdr1f44y9lACjvZUobR42VbyOKjFD2vJSgXATk04Tj8Y2
         wBVGBoniQCwvSb1IdPMmV6WFkLgLI36NY4V4kVMyX44w8/CF0Mpb6lb+W2fF8/Li21Yt
         NsLWWcB58g2GUsUQ6jG9QK8zWZFTppW0s639k9e790PpZB/M4WzC7bAWi2fPhg2fye1+
         qJiAogK1BZNSYAye6Oy6OMLSiX1A2nXRwbeJZsXy14tWqJP7P+9zUOjMF6J1Otxndpxn
         Scyw==
X-Gm-Message-State: AO0yUKUxCcwx3dAVEHj3gOkSjR7q5OVwboWJWbjYPyE56AWkQEffqHsW
        HG7qQMcBvqMIf3lpbVrZ52We7aU1CvkQ7TvJjCjxEBT7tLNTQB5x2EF1yaISwS+PVcN9k27tg/S
        uxk8UrfGpWpWZJIp2wQYHFYB8DjK/a8kTOGiB
X-Received: by 2002:a17:90a:6807:b0:230:905b:582d with SMTP id p7-20020a17090a680700b00230905b582dmr1905563pjj.3.1675954707538;
        Thu, 09 Feb 2023 06:58:27 -0800 (PST)
X-Google-Smtp-Source: AK7set9XXmlWhj2iAyPUVopuoGNuCAj4ne+TsHapcSeaLD7umYhLgCc24+fqbCal0N23Mn5R4UtN4hk68QfUH3FNBtA=
X-Received: by 2002:a17:90a:6807:b0:230:905b:582d with SMTP id
 p7-20020a17090a680700b00230905b582dmr1905556pjj.3.1675954707124; Thu, 09 Feb
 2023 06:58:27 -0800 (PST)
MIME-Version: 1.0
References: <20221103161637.1725471-1-dwysocha@redhat.com>
In-Reply-To: <20221103161637.1725471-1-dwysocha@redhat.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Thu, 9 Feb 2023 09:57:50 -0500
Message-ID: <CALF+zOk7ryO7GV7LYWjRa1b+C6fA5J=-=zshd+vE-FxewBNg=A@mail.gmail.com>
Subject: Re: [Linux-cachefs] [PATCH v10 0/6] Convert NFS with fscache to the
 netfs API
To:     Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        David Howells <dhowells@redhat.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com,
        Benjamin Maynard <benmaynard@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Nov 3, 2022 at 12:16 PM Dave Wysochanski <dwysocha@redhat.com> wrote:
>
> This v10 patchset addresses at least some of Trond's latest concerns.
> Some of the feedback like the unlock_page() wrapper function in
> nfs_read_completion() I don't know how to address without an
> ifdef.  Other feedback I'm not quite sure about splitting out
> netfs bits or what you would like to see.  Trond I do not want to
> in any way ignore or miss any of your feedback so please elaborate
> as needed.
>
> This patchset converts NFS with fscache non-direct READ IO paths to
> use the netfs API with a non-invasive approach.  The existing NFS pgio
> layer does not need extensive changes, and is the best way so far I've
> found to address Trond's concerns about modifying the IO path [1] as
> well as only enabling netfs when fscache is configured and enabled [2].
> I have not attempted performance comparisions to address Chuck
> Lever's concern [3] because we are not converting the non-fscache
> enabled NFS IO paths to netfs.
>
> The patchset is based on 6.1-rc3 and has been pushed to github at:
> https://github.com/DaveWysochanskiRH/kernel/commits/nfs-fscache-netfs
> https://github.com/DaveWysochanskiRH/kernel/commit/bff09aa979010f38a11a6f92451e85d04d850715
>
> Changes since v9 [7]
> ====================
> PATCH1: Rename nfs_pageio_add_page to nfs_read_add_page (Trond)
> PATCH3: Remove a few #ifdef's and replace with wrappers (Trond) [8]
> PATCH6: RFC patch to reduce increase in nfs_inode memory footprint
> when netfs is configured but not enabled (Trond) [9]
>
> Testing
> =======
> I did not do much testing on this as the changes to patches 1 and 3
> are cosmetic.  Patch #6 is RFC patch and may change, so if that is
> added it may need more testing.
>
> Known issues
> ============
> 1. Unit test setting rsize < readahead does not properly read from
> fscache but re-reads data from the NFS server
> * This will be fixed with another linux-cachefs [4] patch to resolve
> "Stop read optimisation when folio removed from pagecache"
> * Daire Byrne also verified the patch fixes his issue as well
>
> 2. "Cache volume key already in use" after xfstest runs
> * xfstests (hammerspace with vers=4.2,fsc) shows the following on the
> console after some tests:
> "NFS: Cache volume key already in use (nfs,4.1,2,c50,cfe0100a,3,,,8000,100000,100000,bb8,ea60,7530,ea60,1)"
> * This may be fixed with another patch [5] that is in progress
>
> 3. Daire Byrne reported a NULL pointer oops at cachefiles_prepare_write+0x28/0x90
> * harder to reproduce/debug but under investigation [6]
> * only reproduced on RHEL7.9 based NFS re-export server using fscache with upstream kernel plus
> the previous patches
> * Debug in progress, first pass at where the problem is indicates a race
> between fscache cookie LRU and use_cookie; looking at cookie state machine [10]
>
> [58710.346376] BUG: kernel NULL pointer dereference, address: 0000000000000008
> [58710.371212] CPU: 12 PID: 9134 Comm: kworker/u129:0 Tainted: G E      6.0.0-2.dneg.x86_64 #1
> ...
> [58710.389995] Workqueue: events_unbound netfs_rreq_write_to_cache_work [netfs]
> [58710.397188] RIP: 0010:cachefiles_prepare_write+0x28/0x90 [cachefiles]
> ...
> [58710.500316] Call Trace:
> [58710.502894]  <TASK>
> [58710.505126]  netfs_rreq_write_to_cache_work+0x11c/0x320 [netfs]
> [58710.511201]  process_one_work+0x217/0x3e0
> [58710.515358]  worker_thread+0x4a/0x3b0
> [58710.519152]  ? process_one_work+0x3e0/0x3e0
> [58710.523467]  kthread+0xd6/0x100
> [58710.526740]  ? kthread_complete_and_exit+0x20/0x20
> [58710.531659]  ret_from_fork+0x1f/0x30
>
>
>
> References
> ==========
> [1] https://lore.kernel.org/linux-nfs/9cfd5bc3cfc6abc2d3316b0387222e708d67f595.camel@hammerspace.com/
> [2] https://lore.kernel.org/linux-nfs/da9200f1bded9b8b078a7aef227fd6b92eb028fb.camel@hammerspace.com/
> [3] https://marc.info/?l=linux-nfs&m=160597917525083&w=4
> [4] https://www.mail-archive.com/linux-cachefs@redhat.com/msg03043.html
> [5] https://marc.info/?l=linux-nfs&m=165962662200679&w=4
> [6] https://listman.redhat.com/archives/linux-cachefs/2022-September/007183.html
> [7] https://marc.info/?l=linux-nfs&m=166600357429305&w=4
> [8] https://marc.info/?l=linux-nfs&m=166697599503342&w=4
> [9] https://marc.info/?l=linux-nfs&m=166717208305834&w=4
> [10] https://listman.redhat.com/archives/linux-cachefs/2022-October/007259.html
>
> Dave Wysochanski (5):
>   NFS: Rename readpage_async_filler to nfs_pageio_add_page
>   NFS: Configure support for netfs when NFS fscache is configured
>   NFS: Convert buffered read paths to use netfs when fscache is enabled
>   NFS: Remove all NFSIOS_FSCACHE counters due to conversion to netfs API
>   NFS: Remove fscache specific trace points and NFS_INO_FSCACHE bit
>
>  fs/nfs/Kconfig             |   1 +
>  fs/nfs/delegation.c        |   2 +-
>  fs/nfs/dir.c               |   2 +-
>  fs/nfs/fscache.c           | 242 ++++++++++++++++++++++---------------
>  fs/nfs/fscache.h           | 111 +++++++++++------
>  fs/nfs/inode.c             |   8 +-
>  fs/nfs/internal.h          |  11 +-
>  fs/nfs/iostat.h            |  17 ---
>  fs/nfs/nfstrace.h          |  91 --------------
>  fs/nfs/pagelist.c          |  12 ++
>  fs/nfs/pnfs.c              |  12 +-
>  fs/nfs/read.c              | 110 +++++++++--------
>  fs/nfs/super.c             |  11 --
>  fs/nfs/write.c             |   2 +-
>  include/linux/nfs_fs.h     |  35 ++++--
>  include/linux/nfs_iostat.h |  12 --
>  include/linux/nfs_page.h   |   3 +
>  include/linux/nfs_xdr.h    |   3 +
>  18 files changed, 335 insertions(+), 350 deletions(-)
>
> --
> 2.31.1
>
> *** BLURB HERE ***
>
> Dave Wysochanski (6):
>   NFS: Rename readpage_async_filler to nfs_read_add_page
>   NFS: Configure support for netfs when NFS fscache is configured
>   NFS: Convert buffered read paths to use netfs when fscache is enabled
>   NFS: Remove all NFSIOS_FSCACHE counters due to conversion to netfs API
>   NFS: Remove fscache specific trace points and NFS_INO_FSCACHE bit
>   netfs: Change netfs_inode_init to allocate memory to allow opt-in
>
>  fs/9p/cache.c              |   2 +-
>  fs/9p/vfs_inode.c          |  17 ++-
>  fs/afs/dynroot.c           |   7 +-
>  fs/afs/inode.c             |  14 +--
>  fs/afs/internal.h          |   2 +-
>  fs/afs/super.c             |   7 ++
>  fs/afs/write.c             |   2 +-
>  fs/ceph/inode.c            |   6 +-
>  fs/netfs/buffered_read.c   |  16 +--
>  fs/netfs/internal.h        |   2 +-
>  fs/netfs/objects.c         |   2 +-
>  fs/nfs/Kconfig             |   1 +
>  fs/nfs/delegation.c        |   2 +-
>  fs/nfs/dir.c               |   2 +-
>  fs/nfs/fscache.c           | 242 ++++++++++++++++++++++---------------
>  fs/nfs/fscache.h           | 136 +++++++++++++++------
>  fs/nfs/inode.c             |  15 ++-
>  fs/nfs/internal.h          |  11 +-
>  fs/nfs/iostat.h            |  17 ---
>  fs/nfs/nfstrace.h          |  91 --------------
>  fs/nfs/pagelist.c          |   4 +
>  fs/nfs/pnfs.c              |  12 +-
>  fs/nfs/read.c              | 110 +++++++++--------
>  fs/nfs/super.c             |  11 --
>  fs/nfs/write.c             |   2 +-
>  include/linux/netfs.h      |  41 +++++--
>  include/linux/nfs_fs.h     |  35 ++++--
>  include/linux/nfs_iostat.h |  12 --
>  include/linux/nfs_page.h   |   3 +
>  include/linux/nfs_xdr.h    |   3 +
>  30 files changed, 428 insertions(+), 399 deletions(-)
>
> --
> 2.31.1
>
> --
> Linux-cachefs mailing list
> Linux-cachefs@redhat.com
> https://listman.redhat.com/mailman/listinfo/linux-cachefs
>

Trond, David H, Ben, Daire, others,

I am not sure about the next steps.

I did not see any responses to this v10 posting, other than dhowells
did not like the overhead that patch 6 added to other filesystems
using netfs.  I'm not sure if that's a full NACK on that patch but it
sounded like it to me.
Trond is it ok if I drop patch 6?

Beyond patch 6, Trond, I could post a rebased v11 but I am not sure it
is acceptable to you the way it is and I don't want to do that if
there's changes you want.
From your responses on v9, one issue seems to be that you do not like
the wrapping the NFS requests inside netfs requests for example.
But I do not know another approach other than bypassing pgio layer
completely which as far as I understand creates a whole new set of
issues to be solved.
Possibly you have another approach in mind or see the need for other
refactoring or patches that should be done that would make this set
more acceptable?
I am not sure if you have other concerns on this v10.  If steps can be
outlined a little better I can work on them.
As it is now I'm not sure whether this needs a rebase and a v11
posting, or a rethinking of the approach.

Regarding the known issues, as far as I know issues #1 and #2 are
still outstanding.
I know issue #3 is fixed with
b5b52de3214a fscache: Fix oops due to race with cookie_lru and use_cookie

