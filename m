Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E76D35F528
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Apr 2021 15:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbhDNNod (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Apr 2021 09:44:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:52140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1351581AbhDNNoQ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 14 Apr 2021 09:44:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0482461139
        for <linux-nfs@vger.kernel.org>; Wed, 14 Apr 2021 13:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618407835;
        bh=8u9ede9bFaEZRd5ODP+65yLjYeHMteIWLZ9blcdchOk=;
        h=From:To:Subject:Date:From;
        b=rJ9GaOKDJwNgEFt/1+3XcfNSuNsBXXsT24Rtn/IgHcJj5Wt04y1RIyGzBh8TZ5WcY
         FPZ6RZGraEng2lppSb47WbC4bLTGR7dnJW0YWmuwfRyWCWEUzr4O9FKwCHjykVQw8r
         j27tGJpNdF6ARZDPERWJy5u2o6sjs25DtEJUZtpsiRqKq1oY1/Lp1T0RY6FTOWIwyQ
         2P1NT0TD/6vU4WHNmqMFHskFRaGW1KTdmzFRRn7q38+x2z7ncfb2npUwQX7LIvdquj
         Uw7UZeUpQLShv6vDFJB89UNEknXLasmeErKM2RenAcYN5k3xIvmIc9mOXUqDWkMK77
         Bs8A/qY+Xk95A==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 00/26] Attribute revalidation updates
Date:   Wed, 14 Apr 2021 09:43:27 -0400
Message-Id: <20210414134353.11860-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The following updates try to simplify some of the attribute caching, and
further split out the attribute cache tracking. In particular, we want
to make use of the fact that NFSv4.x doesn't always need to retrieve all
the attributes to optimise the way we use the GETATTR call.

v2:
 - A number of changes to try to clean up the cache invalidation flags.
 - Fix a bug that was turning off revalidation for most attributes in
   nfs_getattr().
 - Fixes to allow us to reduce the set of attributes we request from the
   server when holding a delegation. In particular, try to reduce
   requests for OWNER and GROUP_OWNER, since those may result in
   expensive upcalls.

Trond Myklebust (26):
  NFS: Deal correctly with attribute generation counter overflow
  NFS: Fix up inode cache tracing
  NFS: Mask out unsupported attributes in nfs_getattr()
  NFS: NFS_INO_REVAL_PAGECACHE should mark the change attribute invalid
  NFS: Fix up revalidation of space used
  NFS: Don't revalidate attributes that are not being asked for
  NFS: Fix up statx() results
  NFS: nfs_setattr_update_inode() should clear the suid/sgid bits
  NFS: Add a cache validity flag argument to nfs_revalidate_inode()
  NFS: Replace use of NFS_INO_REVAL_PAGECACHE when checking cache
    validity
  NFS: Don't set NFS_INO_REVAL_PAGECACHE in the inode cache validity
  NFSv4: Fix nfs4_bitmap_copy_adjust()
  NFS: Separate tracking of file nlinks cache validity from the
    mode/uid/gid
  NFS: Separate tracking of file mode cache validity from the uid/gid
  NFS: Fix up handling of outstanding layoutcommit in nfs_update_inode()
  NFS: Remove a line of code that has no effect in nfs_update_inode()
  NFS: Simplify cache consistency in nfs_check_inode_attributes()
  NFSv4: Fix value of decode_fsinfo_maxsz
  NFSv4: Don't modify the change attribute cached in the inode
  NFSv4: Add support for the NFSv4.2 "change_attr_type" attribute
  NFS: Use information about the change attribute to optimise updates
  NFS: Another inode revalidation improvement
  NFSv4: nfs4_inc/dec_nlink_locked should also invalidate ctime
  NFSv4: link must update the inode nlink.
  NFS: Don't store NFS_INO_REVAL_FORCED
  NFS: Split attribute support out from the server capabilities

 fs/nfs/client.c           |  18 +-
 fs/nfs/delegation.c       |  21 +-
 fs/nfs/delegation.h       |   3 +-
 fs/nfs/dir.c              |   7 +-
 fs/nfs/export.c           |   6 +-
 fs/nfs/file.c             |   2 +-
 fs/nfs/inode.c            | 414 ++++++++++++++++++++++++--------------
 fs/nfs/nfs3acl.c          |   2 +-
 fs/nfs/nfs3xdr.c          |   1 +
 fs/nfs/nfs4proc.c         | 160 +++++++++------
 fs/nfs/nfs4xdr.c          |  43 +++-
 fs/nfs/nfstrace.h         |  11 +-
 fs/nfs/proc.c             |   1 +
 fs/nfs/write.c            |   7 +-
 include/linux/nfs4.h      |   9 +
 include/linux/nfs_fs.h    |   6 +-
 include/linux/nfs_fs_sb.h |  14 +-
 include/linux/nfs_xdr.h   |   2 +
 18 files changed, 478 insertions(+), 249 deletions(-)

-- 
2.30.2

