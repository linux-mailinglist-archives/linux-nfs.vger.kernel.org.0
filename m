Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83484AB472
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Feb 2022 07:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235312AbiBGGPR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Feb 2022 01:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241071AbiBGEqs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 6 Feb 2022 23:46:48 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAE7C043181;
        Sun,  6 Feb 2022 20:46:46 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4B1AF1F37E;
        Mon,  7 Feb 2022 04:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644209205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=U9N4d6jiSLUN/jgU8wn+Vx5a7YFyPHoCVjyVTiQLtWo=;
        b=D7ClHLlXCPAnUMq8dOvwwwrzmaScoUlfNpLlP8S3SYnqtpIWp1GvKY3L1IQPtBoYiEW6PM
        5jAqcWOlkakD4qjbhUmLX8EmVIZNMZy/zOHGAxZ6J6qNuD/7jguzu128xBC84FZvC0zsQH
        +mKe4lXZ0OsN3471M8Q8Vw/8Kn08LD0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644209205;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=U9N4d6jiSLUN/jgU8wn+Vx5a7YFyPHoCVjyVTiQLtWo=;
        b=hHkMCaHK8KlVEpuDXQEX/KtsCHk/EHsmxCbe8b1mwiiu69NFUbbVVBGfHAulbMf7Mtoe17
        /WLUrlTVBvFxEqDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2F0291330E;
        Mon,  7 Feb 2022 04:46:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id L37WNTGkAGL/NAAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 07 Feb 2022 04:46:41 +0000
Subject: [PATCH 00/21 V4] Repair SWAP-over_NFS
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Hemment <markhemm@googlemail.com>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Cc:     linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 07 Feb 2022 15:46:00 +1100
Message-ID: <164420889455.29374.17958998143835612560.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This 4th version of the series address review comment, particularly
tidying up "NFS: swap IO handling is slightly different for O_DIRECT IO"
and collect reviewed-by etc.

I've also move 3 NFS patches which depend on the MM patches to the end
in case they helps maintainers land the patches in a consistent order.
Those three patches might go through the NFS free after the next merge
window.

Original intro follows.
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

---

NeilBrown (21):
 MM - in merge winow
      MM: create new mm/swap.h header file.
      MM: drop swap_set_page_dirty
      MM: move responsibility for setting SWP_FS_OPS to ->swap_activate
      MM: reclaim mustn't enter FS for SWP_FS_OPS swap-space
      MM: introduce ->swap_rw and use it for reads from SWP_FS_OPS swap-space
      MM: perform async writes to SWP_FS_OPS swap-space using ->swap_rw
      DOC: update documentation for swap_activate and swap_rw
      MM: submit multipage reads for SWP_FS_OPS swap-space
      MM: submit multipage write for SWP_FS_OPS swap-space
      VFS: Add FMODE_CAN_ODIRECT file flag

 NFS - in merge window
      NFS: remove IS_SWAPFILE hack
      SUNRPC/call_alloc: async tasks mustn't block waiting for memory
      SUNRPC/auth: async tasks mustn't block waiting for memory
      SUNRPC/xprt: async tasks mustn't block waiting for memory
      SUNRPC: remove scheduling boost for "SWAPPER" tasks.
      NFS: discard NFS_RPC_SWAPFLAGS and RPC_TASK_ROOTCREDS
      SUNRPC: improve 'swap' handling: scheduling and PF_MEMALLOC
      NFSv4: keep state manager thread active if swap is enabled

 NFS - after merge window
      NFS: rename nfs_direct_IO and use as ->swap_rw
      NFS: swap IO handling is slightly different for O_DIRECT IO
      NFS: swap-out must always use STABLE writes.


 Documentation/filesystems/locking.rst |  18 +-
 Documentation/filesystems/vfs.rst     |  17 +-
 drivers/block/loop.c                  |   4 +-
 fs/cifs/file.c                        |   7 +-
 fs/fcntl.c                            |   9 +-
 fs/nfs/direct.c                       |  67 +++++---
 fs/nfs/file.c                         |  39 +++--
 fs/nfs/nfs4_fs.h                      |   1 +
 fs/nfs/nfs4proc.c                     |  20 +++
 fs/nfs/nfs4state.c                    |  39 ++++-
 fs/nfs/read.c                         |   4 -
 fs/nfs/write.c                        |   2 +
 fs/open.c                             |   9 +-
 fs/overlayfs/file.c                   |  13 +-
 include/linux/fs.h                    |   4 +
 include/linux/nfs_fs.h                |  15 +-
 include/linux/nfs_xdr.h               |   2 +
 include/linux/sunrpc/auth.h           |   1 +
 include/linux/sunrpc/sched.h          |   1 -
 include/linux/swap.h                  |   7 +-
 include/linux/writeback.h             |   7 +
 include/trace/events/sunrpc.h         |   1 -
 mm/madvise.c                          |   8 +-
 mm/memory.c                           |   2 +-
 mm/page_io.c                          | 237 +++++++++++++++++++-------
 mm/swap.h                             |  30 +++-
 mm/swap_state.c                       |  22 ++-
 mm/swapfile.c                         |  13 +-
 mm/vmscan.c                           |  38 +++--
 net/sunrpc/auth.c                     |   8 +-
 net/sunrpc/auth_gss/auth_gss.c        |   6 +-
 net/sunrpc/auth_unix.c                |  10 +-
 net/sunrpc/clnt.c                     |   7 +-
 net/sunrpc/sched.c                    |  29 ++--
 net/sunrpc/xprt.c                     |  19 +--
 net/sunrpc/xprtrdma/transport.c       |  10 +-
 net/sunrpc/xprtsock.c                 |   8 +
 37 files changed, 519 insertions(+), 215 deletions(-)

--
Signature

