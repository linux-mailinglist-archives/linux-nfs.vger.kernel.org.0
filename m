Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EFF93FF591
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Sep 2021 23:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346837AbhIBVYD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 Sep 2021 17:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245379AbhIBVYD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 2 Sep 2021 17:24:03 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7CF5C061757;
        Thu,  2 Sep 2021 14:23:04 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id e133so6548118ybh.0;
        Thu, 02 Sep 2021 14:23:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=zmBnzxt5az53PWzyBjyzzZ6eImh8XiKaVO1rT3DwOVw=;
        b=VozxJVtvq3a+y77ptWAs1qKFkZ1AqRCajVVqTc9nVTtXMdJPdCknUlK1ligYCVbimW
         nLUyAizulJPR4rTpSWUqF/P/OyAiDgLB6n8+i5zHx/zRBbaBM94ZVwHa1+7tWFEMeoAk
         4NNX0u46s6abj1Ey/T+6x/+d/UncL44HXp9nD4OiqkZnQo+jHDhPqMuYms1QBlbN2Sak
         ZllwL0ksbigkoVycx0F0urGL6jGHQB9l325mw6HjbXZs2mLcFTKq/+x69TGFrmSQBT9Z
         DBxu/36GA6Thtu3nOWKbPNpUBM3fjHKmfaRfQ7Vq0m4VqUdoz5LVu6ZMt19+o3TdLAg5
         KXkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=zmBnzxt5az53PWzyBjyzzZ6eImh8XiKaVO1rT3DwOVw=;
        b=DfLoZ19hc64DcqMEMsnqIVp4BsepFxr1uR3CivYQxjJWfg84yrGY9TCRAtrmbyaJ65
         01uic77lrRe1ACuVBC9GKMWyoJzSOQQcZ3wdd3uv9hMxyDO4qZBE7gTtw3+5AAPfNVNX
         bOMz+SLkBk3wAkg5JePoV3V75PHyY9FdQfUMK6zDka8rI1wBu8ozHZ+dXo+f1ptVrJA/
         N8B90ZsLBcg034EPt4rqrWp5a30pQZSkDuBcnU5hYBUAM1Pdu1ovGhNOpEVWguV59lWG
         uiN7FYWZ7ERLRBc9x/74FFjLbJY85Atg0MByvUmhEWxtc1Dg5YZwuCVZukfFVnbj1pCq
         pB1A==
X-Gm-Message-State: AOAM532KfnVyycP+FEqqGZKb8Sra8fV2C3EXsIXaQ7vJdpZywzCYaFRM
        uXnugSHp7BvO03+7kOxCJIRxTLrNiZo7leV3KuSwc0M20kI=
X-Google-Smtp-Source: ABdhPJzoAjsrKtfHtro26D/T4mMNaXu8FfjMh6gH2bROwf0ZE9FZSI8E3/mFZYu7bQtky+9z7wJsU65GtkdikYi11Gg=
X-Received: by 2002:a25:4f55:: with SMTP id d82mr519739ybb.365.1630617782599;
 Thu, 02 Sep 2021 14:23:02 -0700 (PDT)
MIME-Version: 1.0
From:   Anna Schumaker <schumaker.anna@gmail.com>
Date:   Thu, 2 Sep 2021 17:22:47 -0400
Message-ID: <CAFX2JfkOaSFppXPn+o=nwyzFZLWxyHX4_rFEBeJx=fA_G7_6ZA@mail.gmail.com>
Subject: [GIT PULL] Please Pull NFS Client Updates for Linux 5.15
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus,

The following changes since commit 36a21d51725af2ce0700c6ebcb6b9594aac658a6:

  Linux 5.14-rc5 (2021-08-08 13:49:31 -0700)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-5.15-1

for you to fetch changes up to 8cfb9015280d49f9d92d5b0f88cedf5f0856c0fd:

  NFS: Always provide aligned buffers to the RPC read layers
(2021-08-30 13:21:38 -0400)

----------------------------------------------------------------
- New Features:
  - Better client responsiveness when server isn't replying
  - Use refcount_t in sunrpc rpc_client refcount tracking
  - Add srcaddr and dst_port to the sunrpc sysfs info files
  - Add basic support for connection sharing between servers with multiple NICs`

- Bugfixes and Cleanups:
  - Sunrpc tracepoint cleanups
  - Disconnect after ib_post_send() errors to avoid deadlocks
  - Fix for tearing down rpcrdma_reps
  - Fix a potential pNFS layoutget livelock loop
  - pNFS layout barrier fixes
  - Fix a potential memory corruption in rpc_wake_up_queued_task_set_status()
  - Fix reconnection locking
  - Fix return value of get_srcport()
  - Remove rpcrdma_post_sends()
  - Remove pNFS dead code
  - Remove copy size restriction for inter-server copies
  - Overhaul the NFS callback service
  - Clean up sunrpc TCP socket shutdowns
  - Always provide aligned buffers to RPC read layers

Thanks,
Anna
----------------------------------------------------------------

Anna Schumaker (3):
      sunrpc: Fix return value of get_srcport()
      SUNRPC: Add srcaddr as a file in sysfs
      SUNRPC: Add dst_port to the sysfs xprt info file

Chuck Lever (18):
      SUNRPC: Refactor rpc_ping()
      SUNRPC: Unset RPC_TASK_NO_RETRANS_TIMEOUT for NULL RPCs
      SUNRPC: Remove unneeded TRACE_DEFINE_ENUMs
      SUNRPC: Update trace flags
      SUNRPC: xprt_retransmit() displays the the NULL procedure incorrectly
      SUNRPC: Record timeout value in xprt_retransmit tracepoint
      xprtrdma: Disconnect after an ib_post_send() immediate error
      xprtrdma: Put rpcrdma_reps before waking the tear-down completion
      xprtrdma: Add xprtrdma_post_recvs_err() tracepoint
      xprtrdma: Add an xprtrdma_post_send_err tracepoint
      xprtrdma: Eliminate rpcrdma_post_sends()
      SUNRPC: Add svc_rqst::rq_auth_stat
      SUNRPC: Set rq_auth_stat in the pg_authenticate() callout
      SUNRPC: Eliminate the RQ_AUTHERR flag
      NFS: Add a private local dispatcher for NFSv4 callback operations
      NFS: Remove unused callback void decoder
      NFS: Extract the xdr_init_encode/decode() calls from decode_compound
      NFS: Clean up the synopsis of callback process_op()

Dai Ngo (1):
      NFSv4.2: remove restriction of copy size for inter-server copy.

Olga Kornievskaia (5):
      SUNRPC keep track of number of transports to unique addresses
      SUNRPC add xps_nunique_destaddr_xprts to xprt_switch_info in sysfs
      NFSv4 introduce max_connect mount options
      SUNRPC enforce creation of no more than max_connect xprts
      NFSv4.1 add network transport when session trunking is detected

Trond Myklebust (11):
      SUNRPC: Convert rpc_client refcount to use refcount_t
      NFSv4/pNFS: Fix a layoutget livelock loop
      NFSv4/pNFS: Remove dead code
      NFSv4/pNFS: Always allow update of a zero valued layout barrier
      NFSv4/pnfs: The layout barrier indicate a minimal value for the seqid
      SUNRPC: Fix potential memory corruption
      SUNRPC: Clean up scheduling of autoclose
      SUNRPC/xprtrdma: Fix reconnection locking
      SUNRPC: Simplify socket shutdown when not reusing TCP ports
      SUNRPC: Tweak TCP socket shutdown in the RPC client
      NFS: Always provide aligned buffers to the RPC read layers

Ye Bin (1):
      NFSv3: Delete duplicate judgement in nfs3_async_handle_jukebox

 fs/lockd/svc.c                       |  2 ++
 fs/nfs/callback.c                    |  4 ++++
 fs/nfs/callback_xdr.c                | 61
++++++++++++++++++++++++++++++++-----------------------------
 fs/nfs/client.c                      |  2 ++
 fs/nfs/fs_context.c                  |  7 +++++++
 fs/nfs/internal.h                    |  2 ++
 fs/nfs/nfs3proc.c                    |  3 +--
 fs/nfs/nfs4client.c                  | 41
+++++++++++++++++++++++++++++++++++++++--
 fs/nfs/nfs4file.c                    | 10 ++++------
 fs/nfs/pnfs.c                        | 20 ++++++++++----------
 fs/nfs/read.c                        |  8 ++++++--
 fs/nfs/super.c                       |  2 ++
 include/linux/nfs_fs.h               |  5 +++++
 include/linux/nfs_fs_sb.h            |  1 +
 include/linux/sunrpc/clnt.h          |  5 ++++-
 include/linux/sunrpc/svc.h           |  3 +--
 include/linux/sunrpc/svcauth.h       |  4 ++--
 include/linux/sunrpc/xprt.h          |  1 +
 include/linux/sunrpc/xprtmultipath.h |  1 +
 include/trace/events/rpcrdma.h       | 74
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
 include/trace/events/sunrpc.h        | 60
+++++++++++++++---------------------------------------------
 net/sunrpc/auth_gss/gss_rpc_upcall.c |  2 +-
 net/sunrpc/auth_gss/svcauth_gss.c    | 47
+++++++++++++++++++++++++----------------------
 net/sunrpc/clnt.c                    | 66
++++++++++++++++++++++++++++++++++++++++++++----------------------
 net/sunrpc/debugfs.c                 |  2 +-
 net/sunrpc/rpc_pipe.c                |  2 +-
 net/sunrpc/svc.c                     | 39
+++++++++++----------------------------
 net/sunrpc/svcauth.c                 |  8 ++++----
 net/sunrpc/svcauth_unix.c            | 18 +++++++++++-------
 net/sunrpc/sysfs.c                   | 36 +++++++++++++++++++++++++++++++++---
 net/sunrpc/xprt.c                    | 32 ++++++++++++++++++++------------
 net/sunrpc/xprtmultipath.c           |  1 +
 net/sunrpc/xprtrdma/backchannel.c    |  2 +-
 net/sunrpc/xprtrdma/frwr_ops.c       | 14 +++++++++++++-
 net/sunrpc/xprtrdma/transport.c      | 13 ++++++-------
 net/sunrpc/xprtrdma/verbs.c          | 28 +++++++---------------------
 net/sunrpc/xprtrdma/xprt_rdma.h      |  2 +-
 net/sunrpc/xprtsock.c                | 15 +++++++++++----
 38 files changed, 399 insertions(+), 244 deletions(-)
