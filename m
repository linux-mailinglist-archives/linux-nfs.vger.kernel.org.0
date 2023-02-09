Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E4C690F5E
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Feb 2023 18:41:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjBIRlC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Thu, 9 Feb 2023 12:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjBIRlB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Feb 2023 12:41:01 -0500
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC7DD53D
        for <linux-nfs@vger.kernel.org>; Thu,  9 Feb 2023 09:40:59 -0800 (PST)
Received: by mail-qt1-f182.google.com with SMTP id g8so2782134qtq.13
        for <linux-nfs@vger.kernel.org>; Thu, 09 Feb 2023 09:40:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HqNN4HiWpJNrjUwLltLzhoO16BAiBnNWaCgUbWqV63Q=;
        b=X0hkCK8mHsc6raYYVt2WZ51f7WPIC3fslVfMMez3+J1eG5U/TuJAyZn7OJ7Qu/PiyO
         fdKN3mxZmossgcclvbkVN0rD6mAdCSnySrtrDpmhRuSoJPn3Lt9bo3RhJmYR3nE0Shyg
         yyvTiE2yRRals4iDsAYbxecN9aX5dF68nkNxU2gT0DPuRtERIsA9Y/JTvIWgaFgHHTd3
         PFZZVn3kPjAhZ3l78wXQoi6acW6azlZ7SSnmfV8fF3svdCqTPa7S712BGRi9YEU+p1Yq
         i7nO+aROsOLPZFCfrbQG9zvTgoj4iWZlT6+hXVATYDzsqx0NkBCBYbVHHpuyvtgQgjxe
         b/9w==
X-Gm-Message-State: AO0yUKU9ryREcQ13VG7Vd0/LFFpfqn6n14hJmn+kfw0LNqIUXKf3rlsc
        lT2OgGzrphtWOXthkpRxRA==
X-Google-Smtp-Source: AK7set/Rvi6a0ZNNLZOOzx8lpnKJtLjqG5TGS04YXT2JvrKEhlTERI3dXTjNjy93p6WAMwIVGj424A==
X-Received: by 2002:a05:622a:11c2:b0:3a8:fdf:8ff8 with SMTP id n2-20020a05622a11c200b003a80fdf8ff8mr20151307qtk.36.1675964458729;
        Thu, 09 Feb 2023 09:40:58 -0800 (PST)
Received: from [192.168.75.138] (c-68-32-72-208.hsd1.mi.comcast.net. [68.32.72.208])
        by smtp.gmail.com with ESMTPSA id l63-20020a378942000000b0071d3e432c9bsm1810994qkd.28.2023.02.09.09.40.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 09:40:58 -0800 (PST)
Message-ID: <4d60636f62df4f5c200666ed2d1a5f2414c18e1f.camel@kernel.org>
Subject: Re: [Linux-cachefs] [PATCH v10 0/6] Convert NFS with fscache to the
 netfs API
From:   Trond Myklebust <trondmy@kernel.org>
To:     David Wysochanski <dwysocha@redhat.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        David Howells <dhowells@redhat.com>
Cc:     linux-nfs@vger.kernel.org, linux-cachefs@redhat.com,
        Benjamin Maynard <benmaynard@google.com>
Date:   Thu, 09 Feb 2023 12:40:57 -0500
In-Reply-To: <CALF+zOk7ryO7GV7LYWjRa1b+C6fA5J=-=zshd+vE-FxewBNg=A@mail.gmail.com>
References: <20221103161637.1725471-1-dwysocha@redhat.com>
         <CALF+zOk7ryO7GV7LYWjRa1b+C6fA5J=-=zshd+vE-FxewBNg=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
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

On Thu, 2023-02-09 at 09:57 -0500, David Wysochanski wrote:
> On Thu, Nov 3, 2022 at 12:16 PM Dave Wysochanski
> <dwysocha@redhat.com> wrote:
> > 
> > This v10 patchset addresses at least some of Trond's latest
> > concerns.
> > Some of the feedback like the unlock_page() wrapper function in
> > nfs_read_completion() I don't know how to address without an
> > ifdef.  Other feedback I'm not quite sure about splitting out
> > netfs bits or what you would like to see.  Trond I do not want to
> > in any way ignore or miss any of your feedback so please elaborate
> > as needed.
> > 
> > This patchset converts NFS with fscache non-direct READ IO paths to
> > use the netfs API with a non-invasive approach.  The existing NFS
> > pgio
> > layer does not need extensive changes, and is the best way so far
> > I've
> > found to address Trond's concerns about modifying the IO path [1]
> > as
> > well as only enabling netfs when fscache is configured and enabled
> > [2].
> > I have not attempted performance comparisions to address Chuck
> > Lever's concern [3] because we are not converting the non-fscache
> > enabled NFS IO paths to netfs.
> > 
> > The patchset is based on 6.1-rc3 and has been pushed to github at:
> > https://github.com/DaveWysochanskiRH/kernel/commits/nfs-fscache-netfs
> > https://github.com/DaveWysochanskiRH/kernel/commit/bff09aa979010f38a11a6f92451e85d04d850715
> > 
> > Changes since v9 [7]
> > ====================
> > PATCH1: Rename nfs_pageio_add_page to nfs_read_add_page (Trond)
> > PATCH3: Remove a few #ifdef's and replace with wrappers (Trond) [8]
> > PATCH6: RFC patch to reduce increase in nfs_inode memory footprint
> > when netfs is configured but not enabled (Trond) [9]
> > 
> > Testing
> > =======
> > I did not do much testing on this as the changes to patches 1 and 3
> > are cosmetic.  Patch #6 is RFC patch and may change, so if that is
> > added it may need more testing.
> > 
> > Known issues
> > ============
> > 1. Unit test setting rsize < readahead does not properly read from
> > fscache but re-reads data from the NFS server
> > * This will be fixed with another linux-cachefs [4] patch to
> > resolve
> > "Stop read optimisation when folio removed from pagecache"
> > * Daire Byrne also verified the patch fixes his issue as well
> > 
> > 2. "Cache volume key already in use" after xfstest runs
> > * xfstests (hammerspace with vers=4.2,fsc) shows the following on
> > the
> > console after some tests:
> > "NFS: Cache volume key already in use
> > (nfs,4.1,2,c50,cfe0100a,3,,,8000,100000,100000,bb8,ea60,7530,ea60,1
> > )"
> > * This may be fixed with another patch [5] that is in progress
> > 
> > 3. Daire Byrne reported a NULL pointer oops at
> > cachefiles_prepare_write+0x28/0x90
> > * harder to reproduce/debug but under investigation [6]
> > * only reproduced on RHEL7.9 based NFS re-export server using
> > fscache with upstream kernel plus
> > the previous patches
> > * Debug in progress, first pass at where the problem is indicates a
> > race
> > between fscache cookie LRU and use_cookie; looking at cookie state
> > machine [10]
> > 
> > [58710.346376] BUG: kernel NULL pointer dereference, address:
> > 0000000000000008
> > [58710.371212] CPU: 12 PID: 9134 Comm: kworker/u129:0 Tainted: G
> > E      6.0.0-2.dneg.x86_64 #1
> > ...
> > [58710.389995] Workqueue: events_unbound
> > netfs_rreq_write_to_cache_work [netfs]
> > [58710.397188] RIP: 0010:cachefiles_prepare_write+0x28/0x90
> > [cachefiles]
> > ...
> > [58710.500316] Call Trace:
> > [58710.502894]  <TASK>
> > [58710.505126]  netfs_rreq_write_to_cache_work+0x11c/0x320 [netfs]
> > [58710.511201]  process_one_work+0x217/0x3e0
> > [58710.515358]  worker_thread+0x4a/0x3b0
> > [58710.519152]  ? process_one_work+0x3e0/0x3e0
> > [58710.523467]  kthread+0xd6/0x100
> > [58710.526740]  ? kthread_complete_and_exit+0x20/0x20
> > [58710.531659]  ret_from_fork+0x1f/0x30
> > 
> > 
> > 
> > References
> > ==========
> > [1]
> > https://lore.kernel.org/linux-nfs/9cfd5bc3cfc6abc2d3316b0387222e708d67f595.camel@hammerspace.com/
> > [2]
> > https://lore.kernel.org/linux-nfs/da9200f1bded9b8b078a7aef227fd6b92eb028fb.camel@hammerspace.com/
> > [3] https://marc.info/?l=linux-nfs&m=160597917525083&w=4
> > [4]
> > https://www.mail-archive.com/linux-cachefs@redhat.com/msg03043.html
> > [5] https://marc.info/?l=linux-nfs&m=165962662200679&w=4
> > [6]
> > https://listman.redhat.com/archives/linux-cachefs/2022-September/007183.html
> > [7] https://marc.info/?l=linux-nfs&m=166600357429305&w=4
> > [8] https://marc.info/?l=linux-nfs&m=166697599503342&w=4
> > [9] https://marc.info/?l=linux-nfs&m=166717208305834&w=4
> > [10]
> > https://listman.redhat.com/archives/linux-cachefs/2022-October/007259.html
> > 
> > Dave Wysochanski (5):
> >   NFS: Rename readpage_async_filler to nfs_pageio_add_page
> >   NFS: Configure support for netfs when NFS fscache is configured
> >   NFS: Convert buffered read paths to use netfs when fscache is
> > enabled
> >   NFS: Remove all NFSIOS_FSCACHE counters due to conversion to
> > netfs API
> >   NFS: Remove fscache specific trace points and NFS_INO_FSCACHE bit
> > 
> >  fs/nfs/Kconfig             |   1 +
> >  fs/nfs/delegation.c        |   2 +-
> >  fs/nfs/dir.c               |   2 +-
> >  fs/nfs/fscache.c           | 242 ++++++++++++++++++++++-----------
> > ----
> >  fs/nfs/fscache.h           | 111 +++++++++++------
> >  fs/nfs/inode.c             |   8 +-
> >  fs/nfs/internal.h          |  11 +-
> >  fs/nfs/iostat.h            |  17 ---
> >  fs/nfs/nfstrace.h          |  91 --------------
> >  fs/nfs/pagelist.c          |  12 ++
> >  fs/nfs/pnfs.c              |  12 +-
> >  fs/nfs/read.c              | 110 +++++++++--------
> >  fs/nfs/super.c             |  11 --
> >  fs/nfs/write.c             |   2 +-
> >  include/linux/nfs_fs.h     |  35 ++++--
> >  include/linux/nfs_iostat.h |  12 --
> >  include/linux/nfs_page.h   |   3 +
> >  include/linux/nfs_xdr.h    |   3 +
> >  18 files changed, 335 insertions(+), 350 deletions(-)
> > 
> > --
> > 2.31.1
> > 
> > *** BLURB HERE ***
> > 
> > Dave Wysochanski (6):
> >   NFS: Rename readpage_async_filler to nfs_read_add_page
> >   NFS: Configure support for netfs when NFS fscache is configured
> >   NFS: Convert buffered read paths to use netfs when fscache is
> > enabled
> >   NFS: Remove all NFSIOS_FSCACHE counters due to conversion to
> > netfs API
> >   NFS: Remove fscache specific trace points and NFS_INO_FSCACHE bit
> >   netfs: Change netfs_inode_init to allocate memory to allow opt-in
> > 
> >  fs/9p/cache.c              |   2 +-
> >  fs/9p/vfs_inode.c          |  17 ++-
> >  fs/afs/dynroot.c           |   7 +-
> >  fs/afs/inode.c             |  14 +--
> >  fs/afs/internal.h          |   2 +-
> >  fs/afs/super.c             |   7 ++
> >  fs/afs/write.c             |   2 +-
> >  fs/ceph/inode.c            |   6 +-
> >  fs/netfs/buffered_read.c   |  16 +--
> >  fs/netfs/internal.h        |   2 +-
> >  fs/netfs/objects.c         |   2 +-
> >  fs/nfs/Kconfig             |   1 +
> >  fs/nfs/delegation.c        |   2 +-
> >  fs/nfs/dir.c               |   2 +-
> >  fs/nfs/fscache.c           | 242 ++++++++++++++++++++++-----------
> > ----
> >  fs/nfs/fscache.h           | 136 +++++++++++++++------
> >  fs/nfs/inode.c             |  15 ++-
> >  fs/nfs/internal.h          |  11 +-
> >  fs/nfs/iostat.h            |  17 ---
> >  fs/nfs/nfstrace.h          |  91 --------------
> >  fs/nfs/pagelist.c          |   4 +
> >  fs/nfs/pnfs.c              |  12 +-
> >  fs/nfs/read.c              | 110 +++++++++--------
> >  fs/nfs/super.c             |  11 --
> >  fs/nfs/write.c             |   2 +-
> >  include/linux/netfs.h      |  41 +++++--
> >  include/linux/nfs_fs.h     |  35 ++++--
> >  include/linux/nfs_iostat.h |  12 --
> >  include/linux/nfs_page.h   |   3 +
> >  include/linux/nfs_xdr.h    |   3 +
> >  30 files changed, 428 insertions(+), 399 deletions(-)
> > 
> > --
> > 2.31.1
> > 
> > --
> > Linux-cachefs mailing list
> > Linux-cachefs@redhat.com
> > https://listman.redhat.com/mailman/listinfo/linux-cachefs
> > 
> 
> Trond, David H, Ben, Daire, others,
> 
> I am not sure about the next steps.
> 
> I did not see any responses to this v10 posting, other than dhowells
> did not like the overhead that patch 6 added to other filesystems
> using netfs.  I'm not sure if that's a full NACK on that patch but it
> sounded like it to me.
> Trond is it ok if I drop patch 6?
> 

If you drop patch 6, then we need another way to get rid of the
ugliness introduced by netfs_inode. I don't want to add those wrappers
in order to access the inode in 'struct nfs_inode'.

One solution might be an anonymous union. i.e.
struct nfs_inode {
....
	union {
		struct inode vfs_inode;
#ifdef CONFIG_NFS_FSCACHE
		struct netfs_inode netfs_inode;
#endif
	};
};


...and then move the wretched xattr_cache field to reside above that
union.

-- 
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com


