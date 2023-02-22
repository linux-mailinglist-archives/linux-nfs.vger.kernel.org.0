Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58AF69FE82
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Feb 2023 23:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233030AbjBVW2P (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Feb 2023 17:28:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbjBVW2O (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Feb 2023 17:28:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C7E525B
        for <linux-nfs@vger.kernel.org>; Wed, 22 Feb 2023 14:27:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 94713615B8
        for <linux-nfs@vger.kernel.org>; Wed, 22 Feb 2023 22:27:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBFDBC433D2;
        Wed, 22 Feb 2023 22:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677104874;
        bh=uZ8QfZnSDS/SrmQQDPl3zoHaAMOkZS7cCYm3A2hWStM=;
        h=From:To:Cc:Subject:Date:From;
        b=XCkSaotyKf3KV5nbvK2Am/GLt9U4hDvXdK5A6gO6w/a2PfckFf5EpD2IdKvfj3bbk
         TX2L5u8DxbBJRobiIH3lox1WXxisoasTkvywMPJvYTkILrf78w0oj03dJvrVuNxomD
         y82zMi0Klu02MqImi/uHtjaTxZaVnRQ/VApYtLfVJxjJfWihy+XK08/9EM3+8WkOw2
         r1HbRifm9bnTQ7n/0/ALi0EHbuecJJKlTbWAYaW4yooom+XUB7B9BAtBjxS9kqOIW1
         mvpRSQqd3uN2gmwVG6Lbc+1Pue/HIugkWywd9LjqEYDF46bal/8PDzgkSioD2fxCXK
         g8vuuXkHwPKXw==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, torvalds@linux-foundation.org
Cc:     anna@kernel.org
Subject: [GIT PULL] Please Pull NFS Client Updates for Linux 6.3
Date:   Wed, 22 Feb 2023 17:27:52 -0500
Message-Id: <20230222222752.1838386-1-anna@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The following changes since commit ceaa837f96adb69c0df0397937cd74991d5d821a:

  Linux 6.2-rc8 (2023-02-12 14:10:17 -0800)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-6.3-1

for you to fetch changes up to 1683ed16ff1a51705f58e8083ed93a7428a543f2:

  fs/nfs: Replace kmap_atomic() with kmap_local_page() in dir.c (2023-02-15 11:16:14 -0500)

----------------------------------------------------------------
Stephen Rothwell did identify a merge conflict with the mm-stable tree.
His notification email included a patch to fix it up:
https://lore.kernel.org/linux-nfs/20230216140514.631bcca1@canb.auug.org.au

New Features:
  * Convert the read and write paths to use folios

Bugfixes and Cleanups:
  * Fix tracepoint state manager flag printing
  * Fix disabling swap files
  * Fix NFSv4 client identifier sysfs path in the documentation
  * Don't clear NFS_CAP_COPY if server returns NFS4ERR_OFFLOAD_DENIED
  * Treat GETDEVICEINFO errors as a layout failure
  * Replace kmap_atomic() calls with kmap_local_page()
  * Constify sunrpc sysfs kobj_type structures

Thanks,
Anna
----------------------------------------------------------------
Benjamin Coddington (1):
      nfs4trace: fix state manager flag printing

Dave Wysochanski (1):
      Documentation: Fix sysfs path for the NFSv4 client identifier

Fabio M. De Francesco (1):
      fs/nfs: Replace kmap_atomic() with kmap_local_page() in dir.c

NeilBrown (1):
      NFS: fix disabling of swap

Olga Kornievskaia (1):
      pNFS/filelayout: treat GETDEVICEINFO errors as layout failure

Thomas Weißschuh (1):
      SUNRPC: make kobj_type structures constant

Tigran Mkrtchyan (1):
      nfs42: do not fail with EIO if ssc returns NFS4ERR_OFFLOAD_DENIED

Trond Myklebust (18):
      NFS: Fix for xfstests generic/208
      NFS: Add basic functionality for tracking folios in struct nfs_page
      NFS: Support folios in nfs_generic_pgio()
      NFS: Fix nfs_coalesce_size() to work with folios
      NFS: Add a helper to convert a struct nfs_page into an inode
      NFS: Convert the remaining pagelist helper functions to support folios
      NFS: Add a helper nfs_wb_folio()
      NFS: Convert buffered reads to use folios
      NFS: Convert the function nfs_wb_page() to use folios
      NFS: Convert buffered writes to use folios
      NFS: Remove unused function nfs_wb_page()
      NFS: Convert nfs_write_begin/end to use folios
      NFS: Fix up nfs_vm_page_mkwrite() for folios
      NFS: Clean up O_DIRECT request allocation
      NFS: fix up nfs_release_folio() to try to release the page
      NFS: Enable tracing of nfs_invalidate_folio() and nfs_launder_folio()
      NFS: Improve tracing of nfs_wb_folio()
      NFS: Remove unnecessary check in nfs_read_folio()

 .../filesystems/nfs/client-identifier.rst          |   4 +-
 fs/nfs/dir.c                                       |  28 +-
 fs/nfs/direct.c                                    |  12 +-
 fs/nfs/file.c                                      | 124 ++++---
 fs/nfs/filelayout/filelayout.c                     |   2 +
 fs/nfs/internal.h                                  |  38 ++-
 fs/nfs/nfs42proc.c                                 |   3 +-
 fs/nfs/nfs4proc.c                                  |   4 +-
 fs/nfs/nfs4trace.h                                 |  42 +--
 fs/nfs/nfstrace.h                                  |  58 +++-
 fs/nfs/pagelist.c                                  | 217 +++++++++---
 fs/nfs/pnfs.c                                      |   2 +-
 fs/nfs/pnfs.h                                      |  10 +-
 fs/nfs/pnfs_nfs.c                                  |  18 +-
 fs/nfs/read.c                                      |  94 +++--
 fs/nfs/write.c                                     | 380 +++++++++++----------
 include/linux/nfs_fs.h                             |   7 +-
 include/linux/nfs_page.h                           |  79 ++++-
 net/sunrpc/clnt.c                                  |   2 +
 net/sunrpc/sysfs.c                                 |   8 +-
 20 files changed, 698 insertions(+), 434 deletions(-)
