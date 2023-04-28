Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D016F1EF4
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Apr 2023 21:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346586AbjD1TxC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Apr 2023 15:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346531AbjD1TxB (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Apr 2023 15:53:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D552683
        for <linux-nfs@vger.kernel.org>; Fri, 28 Apr 2023 12:52:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28EE861AEF
        for <linux-nfs@vger.kernel.org>; Fri, 28 Apr 2023 19:52:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3989DC433EF;
        Fri, 28 Apr 2023 19:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682711578;
        bh=wTSX2bqtppzzJNQkZCsQDpY21XjdjPAOtvhH3UZQl9Q=;
        h=From:To:Cc:Subject:Date:From;
        b=el6SVf1dEe7CsbWPHGHbzsLOkbAOGMsBzgMO5zX2jZJ4Rb9fHbO5v90hXyzx9mqdm
         etQZFvSt05br6CSmxQuAg8MVTAug7EvwFHir4F9KFbYU9gKl3Ikw8W8uiyUO9QDRzg
         bEuAoYJB3ttR87p1TWfsppFG3xPo1nxRWYz9Zx4Y11HqrSOtBDLh5zjjD+zklPD94U
         5gFifst3Ot3OYaPBAl92+iZ/S66NUutmV8r/jJ0dV3no0YKP8waHQKEpzLU+i5Jovd
         t91AVax0ow7IQqN3J5lEI41sEmVtFK7uU9kNKt6bpsF5y/vdB3i9pcPg8ipqknp7bL
         2pGvONtvq7PXA==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, torvalds@linux-foundation.org
Cc:     anna@kernel.org
Subject: [GIT PULL] Please Pull NFS Client Updates for Linux 6.4
Date:   Fri, 28 Apr 2023 15:52:57 -0400
Message-Id: <20230428195257.234346-1-anna@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus,

The following changes since commit 09a9639e56c01c7a00d6c0ca63f4c7c41abe075d:

  Linux 6.3-rc6 (2023-04-09 11:15:57 -0700)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.4-1

for you to fetch changes up to fbd2a05f29a95d5b42b294bf47e55a711424965b:

  NFSv4.2: Rework scratch handling for READ_PLUS (2023-04-28 15:48:45 -0400)

----------------------------------------------------------------
NFS Client Updates for Linux 6.4

New Features:
  * Convert the readdir path to use folios
  * Convert the NFS fscache code to use netfs

Bugfixes and Cleanups:
  * Always send a RECLAIM_COMPLETE after establishing a lease
  * Simplify sysctl registrations and other cleanups
  * Handle out-of-order write replies on NFS v3
  * Have sunrpc call_bind_status use standard hard/soft task semantics
  * Other minor cleanups

Thanks,
Anna

----------------------------------------------------------------
Anna Schumaker (3):
      NFS: Convert the readdir array-of-pages into an array-of-folios
      NFS: Convert readdir page array functions to use a folio
      NFSv4.2: Rework scratch handling for READ_PLUS

Benjamin Coddington (1):
      NFS: Cleanup unused rpc_clnt variable

Dai Ngo (1):
      SUNRPC: remove the maximum number of retries in call_bind_status

Dave Wysochanski (5):
      NFS: Rename readpage_async_filler to nfs_read_add_folio
      NFS: Configure support for netfs when NFS fscache is configured
      NFS: Convert buffered read paths to use netfs when fscache is enabled
      NFS: Remove all NFSIOS_FSCACHE counters due to conversion to netfs API
      NFS: Remove fscache specific trace points and NFS_INO_FSCACHE bit

Luis Chamberlain (7):
      lockd: simplify two-level sysctl registration for nlm_sysctls
      nfs: simplify two-level sysctl registration for nfs4_cb_sysctls
      nfs: simplify two-level sysctl registration for nfs_cb_sysctls
      sunrpc: simplify one-level sysctl registration for xr_tunables_table
      sunrpc: simplify one-level sysctl registration for xs_tunables_table
      sunrpc: move sunrpc_table and proc routines above
      sunrpc: simplify one-level sysctl registration for debug_table

NeilBrown (1):
      NFSv3: handle out-of-order write replies.

Tom Rix (1):
      NFS: set varaiable nfs_netfs_debug_id storage-class-specifier to static

Trond Myklebust (1):
      NFSv4.1: Always send a RECLAIM_COMPLETE after establishing lease

 fs/lockd/svc.c                  |  20 +--
 fs/nfs/Kconfig                  |   1 +
 fs/nfs/dir.c                    | 300 ++++++++++++++++++++--------------------
 fs/nfs/fscache.c                | 238 ++++++++++++++++++-------------
 fs/nfs/fscache.h                | 131 ++++++++++++------
 fs/nfs/inode.c                  | 114 +++++++++++++--
 fs/nfs/internal.h               |   9 ++
 fs/nfs/iostat.h                 |  17 ---
 fs/nfs/nfs42xdr.c               |   4 +-
 fs/nfs/nfs4proc.c               |  17 ++-
 fs/nfs/nfs4state.c              |   8 +-
 fs/nfs/nfs4sysctl.c             |  21 +--
 fs/nfs/nfstrace.h               |  91 ------------
 fs/nfs/pagelist.c               |   4 +
 fs/nfs/read.c                   | 105 +++++++-------
 fs/nfs/super.c                  |  11 --
 fs/nfs/sysctl.c                 |  20 +--
 include/linux/nfs_fs.h          |  72 ++++++++--
 include/linux/nfs_iostat.h      |  12 --
 include/linux/nfs_page.h        |   3 +
 include/linux/nfs_xdr.h         |   4 +
 include/linux/sunrpc/sched.h    |   3 +-
 net/sunrpc/clnt.c               |   3 -
 net/sunrpc/sched.c              |   1 -
 net/sunrpc/sysctl.c             |  42 ++----
 net/sunrpc/xprtrdma/transport.c |  11 +-
 net/sunrpc/xprtsock.c           |  13 +-
 27 files changed, 652 insertions(+), 623 deletions(-)
