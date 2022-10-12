Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B885FCC39
	for <lists+linux-nfs@lfdr.de>; Wed, 12 Oct 2022 22:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbiJLUmE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 12 Oct 2022 16:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiJLUln (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 12 Oct 2022 16:41:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F20010451E
        for <linux-nfs@vger.kernel.org>; Wed, 12 Oct 2022 13:41:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24AB1B81BD6
        for <linux-nfs@vger.kernel.org>; Wed, 12 Oct 2022 20:40:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85460C43470;
        Wed, 12 Oct 2022 20:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665607232;
        bh=EKZtu62Ww0Aq8Nk0cclgzrrmRTjg/Luh/ZFBMuqyNSg=;
        h=From:To:Cc:Subject:Date:From;
        b=KPsUlhrak3q72HEhd3bQ6R73hxKX2ugLnBYti18yU7M8IGYGuRyn9BKNSbgOdj21M
         EsfJIdNCNp/qSdL730TTKxlc+223lVxXdVYfrigQeo1JlZAEE3tgXvdqorNlk+GEWM
         NpchJCH+racISCxYPk9SS0ybDv05SX1qprpYQ0VwgTikWf0DvF8lv1JxaWR7b/z6dK
         qtps3AoxdqQPtu8JvLNxYV0Q6IYgOUYfIsqZoWsO3QmfM25nzih4jNSlPOOB3ogXz7
         yZDBXvkdJkHnSz1PRjD07az3ufq6hSH23lB2b/Cd13NZPv+bB+Hsk/dZm+on1hiBh+
         9wBjrb8jJYP1A==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, torvalds@linux-foundation.org
Cc:     anna@kernel.org
Subject: [GIT PULL] Please Pull NFS Client Updates for Linux 6.1
Date:   Wed, 12 Oct 2022 16:40:31 -0400
Message-Id: <20221012204031.657633-1-anna@kernel.org>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus,

The following changes since commit f76349cf41451c5c42a99f18a9163377e4b364ff:

  Linux 6.0-rc7 (2022-09-25 14:01:02 -0700)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.1-1

for you to fetch changes up to b739a5bd9d9f18cc69dced8db128ef7206e000cd:

  NFSv4/flexfiles: Cancel I/O if the layout is recalled or revoked (2022-10-06 09:52:09 -0400)

----------------------------------------------------------------
NFS Client Updates for Linux 6.1

- New Features:
  - Add NFSv4.2 xattr tracepoints
  - Replace xprtiod WQ in rpcrdma
  - Flexfiles cancels I/O on layout recall or revoke

- Bugfixes and Cleanups:
  - Directly use ida_alloc() / ida_free()
  - Don't open-code max_t()
  - Prefer using strscpy over strlcpy
  - Remove unused forward declarations
  - Always return layout states on flexfiles layout return
  - Have LISTXATTR treat NFS4ERR_NOXATTR as an empty reply instead of error
  - Allow more xprtrdma memory allocations to fail without triggering a reclaim
  - Various other xprtrdma clean ups
  - Fix rpc_killall_tasks() races

Thanks,
Anna

----------------------------------------------------------------
Anna Schumaker (4):
      NFSv4.2: Add special handling for LISTXATTR receiving NFS4ERR_NOXATTR
      NFSv4.2: Move TRACE_DEFINE_ENUM(NFS4_CONTENT_*) under CONFIG_NFS_V4_2
      NFSv4.2: Add tracepoints for getxattr, setxattr, and removexattr
      NFSv4.2: Add a tracepoint for listxattr

Bo Liu (2):
      SUNRPC: Directly use ida_alloc()/free()
      NFSv4: Directly use ida_alloc()/free()

Chuck Lever (8):
      SUNRPC: Replace the use of the xprtiod WQ in rpcrdma
      svcrdma: Clean up RPCRDMA_DEF_GFP
      xprtrdma: Clean up synopsis of rpcrdma_req_create()
      xprtrdma: Clean up synopsis of rpcrdma_regbuf_alloc()
      xprtrdma: MR-related memory allocation should be allowed to fail
      xprtrdma: Memory allocation should be allowed to fail during connect
      xprtrdma: Prevent memory allocations from driving a reclaim
      xprtrdma: Fix uninitialized variable

Gaosheng Cui (2):
      NFSv4: remove nfs4_renewd_prepare_shutdown() declaration
      nfs: remove nfs_wait_atomic_killable() and nfs_write_prepare() declaration

Jiangshan Yi (1):
      fs/nfs/pnfs_nfs.c: fix spelling typo and syntax error in comment

Lukas Bulwahn (1):
      NFS: clean up a needless assignment in nfs_file_write()

Trond Myklebust (5):
      NFSv4/pNFS: Always return layout stats on layout return for flexfiles
      SUNRPC: Fix races with rpc_killall_tasks()
      SUNRPC: Add a helper to allow pNFS drivers to selectively cancel RPC calls
      SUNRPC: Add API to force the client to disconnect
      NFSv4/flexfiles: Cancel I/O if the layout is recalled or revoked

Wolfram Sang (2):
      SUNRPC: move from strlcpy with unused retval to strscpy
      NFS: move from strlcpy with unused retval to strscpy

Ziyang Xuan (1):
      SUNRPC: use max_t() to simplify open code

yuzhe (1):
      nfs: remove unnecessary (void*) conversions.

 fs/nfs/file.c                              |   6 +-
 fs/nfs/flexfilelayout/flexfilelayout.c     | 109 ++++++++++++++++++++++++++---
 fs/nfs/inode.c                             |   6 +-
 fs/nfs/internal.h                          |   2 -
 fs/nfs/nfs42proc.c                         |   4 ++
 fs/nfs/nfs42xattr.c                        |   2 +-
 fs/nfs/nfs42xdr.c                          |   8 +++
 fs/nfs/nfs4_fs.h                           |   1 -
 fs/nfs/nfs4client.c                        |   2 +-
 fs/nfs/nfs4idmap.c                         |   2 +-
 fs/nfs/nfs4proc.c                          |   4 +-
 fs/nfs/nfs4state.c                         |  10 ++-
 fs/nfs/nfs4trace.h                         |  50 ++++++++++++-
 fs/nfs/nfsroot.c                           |   2 +-
 fs/nfs/pnfs.c                              |   9 ++-
 fs/nfs/pnfs.h                              |   9 +++
 fs/nfs/pnfs_nfs.c                          |   4 +-
 include/linux/sunrpc/clnt.h                |   1 +
 include/linux/sunrpc/sched.h               |   6 ++
 net/sunrpc/clnt.c                          |  61 ++++++++++++++--
 net/sunrpc/sched.c                         |  51 ++++++++++----
 net/sunrpc/xprt.c                          |   9 +--
 net/sunrpc/xprtmultipath.c                 |   4 +-
 net/sunrpc/xprtrdma/backchannel.c          |   2 +-
 net/sunrpc/xprtrdma/frwr_ops.c             |  20 +++---
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c |   4 +-
 net/sunrpc/xprtrdma/transport.c            |   3 +-
 net/sunrpc/xprtrdma/verbs.c                |  52 +++++++-------
 net/sunrpc/xprtrdma/xprt_rdma.h            |  10 ++-
 net/sunrpc/xprtsock.c                      |   5 +-
 30 files changed, 342 insertions(+), 116 deletions(-)
