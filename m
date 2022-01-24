Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7551F4977C3
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jan 2022 04:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235345AbiAXDuL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 23 Jan 2022 22:50:11 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:46824 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235150AbiAXDuK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 23 Jan 2022 22:50:10 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F14711F380;
        Mon, 24 Jan 2022 03:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642996208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=FYLGS1PTqJRpqgka1auwglvUY+5X6emkkkTz1OsVE0s=;
        b=KHTxxWejAOBFxzA1CNlxQjTN2iX4o/sZFfa45ydqZ1JLfwFms/xzzcwDI6ofU6ju565acI
        QmhYpAZDMf7BA/Jmmc5tBtfmnGHOzpuDDinasbHiltflGlTXTCHECADMzAD5F4PV0uI/Yg
        vXTItN9q+NI2VtvK8HhIGE9UtG5xMt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642996208;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=FYLGS1PTqJRpqgka1auwglvUY+5X6emkkkTz1OsVE0s=;
        b=HpOa16A1q2wb+IIVCXcmuChBJ4c4JP/us0FYuOnsqYwbvjxutS2fcW6oJTQqdGIyWzU96j
        NydOaVCJg/bZKRBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F119E1331A;
        Mon, 24 Jan 2022 03:50:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AyZIKu0h7mGKRAAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 24 Jan 2022 03:50:05 +0000
Subject: [PATCH 00/23 V3] Repair SWAP-over_NFS
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
Date:   Mon, 24 Jan 2022 14:48:32 +1100
Message-ID: <164299573337.26253.7538614611220034049.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This version of the series addresses the review comments received,
particularly from Christof.
Thanks to all for review and testing.

The patch adding mm/swap.h got a minor conflict when I rebaesd on
5.17-rc1, suggestion that it could easily get more conflicts in the
future.  It might be good if it could land before 5.17 comes out, to
avoid (some of) those conflicts.

I think (Though haven't checked) that all the NFS patch patches
except
      NFS: rename nfs_direct_IO and use as ->swap_rw
      NFS: swap IO handling is slightly different for O_DIRECT IO
can land independently of the MM patches, and can be moved to the
end of the series.  Maybe they could be held until after 5.18-rc1 if we
agree to proceed with these in the next merge window.

Intro from previous series is below.
Thanks,
NeilBrown

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

---

NeilBrown (23):
      MM: create new mm/swap.h header file.
      MM: extend block-plugging to cover all swap reads with read-ahead
      MM: drop swap_set_page_dirty
      MM: move responsibility for setting SWP_FS_OPS to ->swap_activate
      MM: reclaim mustn't enter FS for SWP_FS_OPS swap-space
      MM: introduce ->swap_rw and use it for reads from SWP_FS_OPS swap-space
      MM: perform async writes to SWP_FS_OPS swap-space using ->swap_rw
      DOC: update documentation for swap_activate and swap_rw
      MM: submit multipage reads for SWP_FS_OPS swap-space
      MM: submit multipage write for SWP_FS_OPS swap-space
      VFS: Add FMODE_CAN_ODIRECT file flag
      NFS: remove IS_SWAPFILE hack
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
      SUNRPC: lock against ->sock changing during sysfs read


 Documentation/filesystems/locking.rst |  18 ++-
 Documentation/filesystems/vfs.rst     |  17 ++-
 drivers/block/loop.c                  |   4 +-
 fs/cifs/file.c                        |   7 +-
 fs/fcntl.c                            |   9 +-
 fs/nfs/direct.c                       |  56 ++++---
 fs/nfs/file.c                         |  39 +++--
 fs/nfs/nfs4_fs.h                      |   1 +
 fs/nfs/nfs4proc.c                     |  20 +++
 fs/nfs/nfs4state.c                    |  39 ++++-
 fs/nfs/read.c                         |   4 -
 fs/nfs/write.c                        |   2 +
 fs/open.c                             |   9 +-
 fs/overlayfs/file.c                   |  13 +-
 include/linux/fs.h                    |   4 +
 include/linux/nfs_fs.h                |  11 +-
 include/linux/nfs_xdr.h               |   2 +
 include/linux/sunrpc/auth.h           |   1 +
 include/linux/sunrpc/sched.h          |   1 -
 include/linux/swap.h                  |   7 +-
 include/linux/writeback.h             |   7 +
 include/trace/events/sunrpc.h         |   1 -
 mm/madvise.c                          |   8 +-
 mm/memory.c                           |   2 +-
 mm/page_io.c                          | 210 ++++++++++++++++++++------
 mm/swap.h                             |  26 +++-
 mm/swap_state.c                       |  33 ++--
 mm/swapfile.c                         |  13 +-
 mm/vmscan.c                           |  38 +++--
 net/sunrpc/auth.c                     |   8 +-
 net/sunrpc/auth_gss/auth_gss.c        |   6 +-
 net/sunrpc/auth_unix.c                |  10 +-
 net/sunrpc/clnt.c                     |   7 +-
 net/sunrpc/sched.c                    |  29 ++--
 net/sunrpc/sysfs.c                    |   5 +-
 net/sunrpc/xprt.c                     |  19 +--
 net/sunrpc/xprtrdma/transport.c       |  10 +-
 net/sunrpc/xprtsock.c                 |  15 +-
 38 files changed, 505 insertions(+), 206 deletions(-)

--
Signature

