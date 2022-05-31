Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67650539896
	for <lists+linux-nfs@lfdr.de>; Tue, 31 May 2022 23:21:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345458AbiEaVVA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 31 May 2022 17:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239528AbiEaVU7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 31 May 2022 17:20:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2C07035C
        for <linux-nfs@vger.kernel.org>; Tue, 31 May 2022 14:20:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68C60B81609
        for <linux-nfs@vger.kernel.org>; Tue, 31 May 2022 21:20:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB6EC385A9;
        Tue, 31 May 2022 21:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654032055;
        bh=twXElHXi8XCSqm6s8BF0BREOXsJr/3LFr7j7jHO4GoM=;
        h=From:To:Cc:Subject:Date:From;
        b=TcJR90Q+n3J4PUjZMwFZWemAcOz9vGyxwXlY3QUeOOkLDPHHJsc62XOPMSqI/jeyw
         DSzVVvzB9myI1uj0G3GZ1gYQoX/g0Pt300DRx1+tdngvJ8lN5AETkMkAJW4CqmfXA8
         ID3X89LCxt0Wr2Kgw7SC4bbXkkeVJncuQOvcBMaOBMVn/1YUxFDLMLuZLaW78kXFc2
         fzhQpjOOPMSLvamXsMVdOntgii+aE1mZIqhbeQsBXqhaj5euNIdRcpcc+viMAbB8HY
         iAlx+Cz/MH+sIsPFdxcm3jhvqOuXj9BJ5Vaeb4BIikT45nZUvodw5DCfni6i29u6jn
         omCshzQeoxf5w==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, torvalds@linux-foundation.org
Cc:     anna@kernel.org
Subject: [GIT PULL] Please Pull NFS Client Updates for Linux 5.19
Date:   Tue, 31 May 2022 17:20:53 -0400
Message-Id: <20220531212053.144805-1-anna@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Linus,

The following changes since commit 42226c989789d8da4af1de0c31070c96726d990c:

  Linux 5.18-rc7 (2022-05-15 18:08:58 -0700)

are available in the Git repository at:

  git://git.linux-nfs.org/projects/anna/linux-nfs.git tags/nfs-for-5.19-1

for you to fetch changes up to 118f09eda21d392e1eeb9f8a4bee044958cccf20:

  NFSv4.1 mark qualified async operations as MOVEABLE tasks (2022-05-31 17:09:30 -0400)

----------------------------------------------------------------
NFS Client Updates for Linux 5.18

- New Features:
  - Add support for 'dacl' and 'sacl' attributes

- Bugfixes and Cleanups:
  - Fixes for reporting mapping errors
  - Fixes for memory allocation errors
  - Improve warning message when locks are lost
  - Update documentation for the nfs4_unique_id parameter
  - Add an explanation of NFSv4 client identifiers
  - Ensure the i_size attribute is written to the fscache storage
  - Fix freeing uninitialized nfs4_labels
  - Better handling when xprtrdma bc_serv is NULL
  - Marke qualified async operations as MOVEABLE tasks

Thanks,
Anna

----------------------------------------------------------------
Benjamin Coddington (1):
      NFSv4: Fix free of uninitialized nfs4_label on referral lookup.

Chuck Lever (1):
      Documentation: Add an explanation of NFSv4 client identifiers

Dave Wysochanski (1):
      NFS: Pass i_size to fscache_unuse_cookie() when a file is released

Kinglong Mee (1):
      xprtrdma: treat all calls not a bcall when bc_serv is NULL

NeilBrown (2):
      NFS: Improve warning message when locks are lost.
      NFS: update documentation for the nfs4_unique_id parameter

Olga Kornievskaia (1):
      NFSv4.1 mark qualified async operations as MOVEABLE tasks

Trond Myklebust (13):
      NFS: Do not report EINTR/ERESTARTSYS as mapping errors
      NFS: fsync() should report filesystem errors over EINTR/ERESTARTSYS
      NFS: Don't report ENOSPC write errors twice
      NFS: Do not report flush errors in nfs_write_end()
      NFS: Don't report errors from nfs_pageio_complete() more than once
      NFS: Memory allocation failures are not server fatal errors
      NFSv4/pNFS: Do not fail I/O when we fail to allocate the pNFS layout
      NFS: Further fixes to the writeback error handling
      pNFS/files: Fall back to I/O through the MDS on non-fatal layout errors
      NFSv4: Don't hold the layoutget locks across multiple RPC calls
      NFSv4: Specify the type of ACL to cache
      NFSv4: Add encoders/decoders for the NFSv4.1 dacl and sacl attributes
      NFSv4.1: Enable access to the NFSv4.1 'dacl' and 'sacl' attributes

 Documentation/admin-guide/nfs/nfs-client.rst       |  15 +-
 .../filesystems/nfs/client-identifier.rst          | 216 +++++++++++++++++++++
 Documentation/filesystems/nfs/index.rst            |   2 +
 fs/nfs/file.c                                      |  50 ++---
 fs/nfs/filelayout/filelayout.c                     |   7 +-
 fs/nfs/fscache.c                                   |   7 +-
 fs/nfs/internal.h                                  |   1 +
 fs/nfs/nfs4namespace.c                             |   9 +-
 fs/nfs/nfs4proc.c                                  | 182 +++++++++++++----
 fs/nfs/nfs4state.c                                 |  29 ++-
 fs/nfs/nfs4xdr.c                                   |  97 +++++----
 fs/nfs/pagelist.c                                  |   3 +
 fs/nfs/pnfs.c                                      |   2 +
 fs/nfs/unlink.c                                    |   8 +
 fs/nfs/write.c                                     |  54 +++---
 include/linux/nfs4.h                               |   2 +
 include/linux/nfs_fs_sb.h                          |   1 +
 include/linux/nfs_xdr.h                            |  12 +-
 net/sunrpc/xprtrdma/rpc_rdma.c                     |   5 +
 19 files changed, 547 insertions(+), 155 deletions(-)
 create mode 100644 Documentation/filesystems/nfs/client-identifier.rst
