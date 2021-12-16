Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3BE24780D6
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Dec 2021 00:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229848AbhLPXwO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Dec 2021 18:52:14 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:56274 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbhLPXwO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Dec 2021 18:52:14 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 23A2C1F37E;
        Thu, 16 Dec 2021 23:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639698733; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=BrMW3JyWaNdMJ0Haf3gWky2KOkmwQPIMXLocO6ojo8o=;
        b=DfXO/ARWHnOSgkR04rVeYWiJ00Np51WduldO55NRZGcnXX65SMlD74kOss6zNofHODwDgA
        9lvaiLCv9vqHR8B9coVRJmVsJV4hrpsvFAI+ZRD8oySU+GPGwFbk2Sfi3fjxe611RZX2sy
        JJ58RW5XYx5L6c36qlay8m26Fik9QZg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639698733;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=BrMW3JyWaNdMJ0Haf3gWky2KOkmwQPIMXLocO6ojo8o=;
        b=6hWDofoY++geU4rja8Ev6OXOahSMjRP23VYgJmDPJZuctOB7qpBjTDQv6xmt0cSPnEqJjA
        nJp1F5+SG8xxooBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F1B5113EFD;
        Thu, 16 Dec 2021 23:52:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XNGLKSnRu2EvWwAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 16 Dec 2021 23:52:09 +0000
Subject: [PATCH 00/18 V2] Repair SWAP-over-NFS
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Cc:     linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 17 Dec 2021 10:48:22 +1100
Message-ID: <163969801519.20885.3977673503103544412.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

swap-over-NFS currently has a variety of problems.

swap writes call generic_write_checks(), which always fails on a swap
file, so it completely fails.
Even without this, various deadlocks are possible - largely due to
improvements in NFS memory allocation (using NOFS instead of ATOMIC)
which weren't tested against swap-out.

NFS is the only filesystem that has supported fs-based swap IO, and it
hasn't worked for several releases, so now is a convenient time to clean
up the swap-via-filesystem interfaces - we cannot break anything !

So the first few patches here clean up and improve various parts of the
swap-via-filesystem code.  ->activate_swap() is given a cleaner
interface, a new ->swap_rw is introduced instead of burdening
->direct_IO, etc.

Current swap-to-filesystem code only ever submits single-page reads and
writes.  These patches change that to allow multi-page IO when adjacent
requests are submitted.  Writes are also changed to be async rather than
sync.  This substantially speeds up write throughput for swap-over-NFS.

Some of the NFS patches can land independently of the MM patches.  A few
require the MM patches to land first.

Thanks,
NeilBrown


---

NeilBrown (18):
      Structural cleanup for filesystem-based swap
      MM: create new mm/swap.h header file.
      MM: use ->swap_rw for reads from SWP_FS_OPS swap-space
      MM: perform async writes to SWP_FS_OPS swap-space
      MM: reclaim mustn't enter FS for SWP_FS_OPS swap-space
      MM: submit multipage reads for SWP_FS_OPS swap-space
      MM: submit multipage write for SWP_FS_OPS swap-space
      MM: Add AS_CAN_DIO mapping flag
      NFS: rename nfs_direct_IO and use as ->swap_rw
      NFS: swap IO handling is slightly different for O_DIRECT IO
      SUNRPC/call_alloc: async tasks mustn't block waiting for memory
      SUNRPC/auth: async tasks mustn't block waiting for memory
      SUNRPC/xprt: async tasks mustn't block waiting for memory
      SUNRPC: remove scheduling boost for "SWAPPER" tasks.
      NFS: discard NFS_RPC_SWAPFLAGS and RPC_TASK_ROOTCREDS
      SUNRPC: improve 'swap' handling: scheduling and PF_MEMALLOC
      NFSv4: keep state manager thread active if swap is enabled
      NFS: swap-out must always use STABLE writes.


 drivers/block/loop.c            |   4 +-
 fs/fcntl.c                      |   5 +-
 fs/inode.c                      |   3 +
 fs/nfs/direct.c                 |  56 ++++++----
 fs/nfs/file.c                   |  25 +++--
 fs/nfs/inode.c                  |   1 +
 fs/nfs/nfs4_fs.h                |   1 +
 fs/nfs/nfs4proc.c               |  20 ++++
 fs/nfs/nfs4state.c              |  39 ++++++-
 fs/nfs/read.c                   |   4 -
 fs/nfs/write.c                  |   2 +
 fs/open.c                       |   2 +-
 fs/overlayfs/file.c             |  10 +-
 include/linux/fs.h              |   2 +-
 include/linux/nfs_fs.h          |  11 +-
 include/linux/nfs_xdr.h         |   2 +
 include/linux/pagemap.h         |   3 +-
 include/linux/sunrpc/auth.h     |   1 +
 include/linux/sunrpc/sched.h    |   1 -
 include/linux/swap.h            | 121 --------------------
 include/linux/writeback.h       |   7 ++
 include/trace/events/sunrpc.h   |   1 -
 mm/madvise.c                    |   9 +-
 mm/memory.c                     |   3 +-
 mm/mincore.c                    |   1 +
 mm/page_alloc.c                 |   1 +
 mm/page_io.c                    | 189 ++++++++++++++++++++++++++------
 mm/shmem.c                      |   1 +
 mm/swap.h                       | 140 +++++++++++++++++++++++
 mm/swap_state.c                 |  32 ++++--
 mm/swapfile.c                   |   6 +
 mm/util.c                       |   1 +
 mm/vmscan.c                     |  31 +++++-
 net/sunrpc/auth.c               |   8 +-
 net/sunrpc/auth_gss/auth_gss.c  |   6 +-
 net/sunrpc/auth_unix.c          |  10 +-
 net/sunrpc/clnt.c               |   7 +-
 net/sunrpc/sched.c              |  29 +++--
 net/sunrpc/xprt.c               |  19 ++--
 net/sunrpc/xprtrdma/transport.c |  10 +-
 net/sunrpc/xprtsock.c           |   8 ++
 41 files changed, 558 insertions(+), 274 deletions(-)
 create mode 100644 mm/swap.h

--
Signature

