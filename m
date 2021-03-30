Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4273634DCDB
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Mar 2021 02:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbhC3ATL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Mar 2021 20:19:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:50352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229628AbhC3ASk (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 29 Mar 2021 20:18:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 47CEF6192F
        for <linux-nfs@vger.kernel.org>; Tue, 30 Mar 2021 00:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617063518;
        bh=17Sdv0UHrHj1HQcB3o9ACYAI3AJuBdsIRa90SZWxKQ0=;
        h=From:To:Subject:Date:From;
        b=H6eRmQer24YNOHIVcPOwDMl/7qHRFoBTJlVO8Q1NbZo0qEGDrJveL1Uw4qL5Ifwl9
         JrMhsTd0IDWBMQF1Bw+zduWDQDocMZ0AAJQxhPVj106X9CLXlgE7Zbb4GuS71H5hMh
         TWfJC8kBYw2KL/fdf3cYdI/gyDhevkfAiytC64D+pdU87brHRehgNtuh3NU/s+qaqC
         uey6Jt5QJFmfHfZeU94II6YHYaNkyrovc3qAKh2o3AEFyXFL+aX/YNK+BRaG8euXbR
         85I/V7wO/BcWBUpFmzowXuXJjJcdDyt0X4L3Nor+47xb1dGT8V410JeiGHBB7K8mIM
         8hykGz760MP5w==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH 00/17] Attribute revalidation updates
Date:   Mon, 29 Mar 2021 20:18:18 -0400
Message-Id: <20210330001835.41914-1-trondmy@kernel.org>
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

Before this patch set, when I run xfstests, I see

NFSv3::   getattr: 444656, lookup: 144117, access: 112148
NFSv4.1:: getattr: 898027, lookup: 68847,  access: 14766, open: 111409
NFSv4.2:: getattr: 593422, lookup: 72488,  access: 16647, open: 113056

after application of the patch set:

NFSv3::   getattr: 399324, lookup: 142331, access: 112444
NFSv4.1:: getattr: 134778, lookup: 70673,  access: 15059, open: 112192
NFSv4.2:: getattr: 139080, lookup: 70722,  access: 16563, open: 113601

Note that these numbers are against a knfsd server that does not support
the "change_attr_type" attribute. I'd expect further improvements once
we re-introduce that server support.

Trond Myklebust (17):
  NFS: Deal correctly with attribute generation counter overflow
  NFS: Fix up inode cache tracing
  NFS: Mask out unsupported attributes in nfs_getattr()
  NFS: NFS_INO_REVAL_PAGECACHE should mark the change attribute invalid
  NFS: Fix up revalidation of space used
  NFS: Don't revalidate attributes that are not being asked for
  NFS: Fix up statx() results
  NFS: Add a cache validity flag argument to nfs_revalidate_inode()
  NFS: Replace use of NFS_INO_REVAL_PAGECACHE when checking cache
    validity
  NFS: Don't set NFS_INO_REVAL_PAGECACHE in the inode cache validity
  NFS: Separate tracking of file nlinks cache validity from the
    mode/uid/gid
  NFS: Fix up handling of outstanding layoutcommit in nfs_update_inode()
  NFS: Remove a line of code that has no effect in nfs_update_inode()
  NFS: Simplify cache consistency in nfs_check_inode_attributes()
  NFSv4: Fix value of decode_fsinfo_maxsz
  NFSv4: Add support for the NFSv4.2 "change_attr_type" attribute
  NFS: Use information about the change attribute to optimise updates

 fs/nfs/client.c           |   3 +
 fs/nfs/dir.c              |   4 +-
 fs/nfs/export.c           |   6 +-
 fs/nfs/file.c             |   2 +-
 fs/nfs/inode.c            | 246 +++++++++++++++++++++++++++-----------
 fs/nfs/nfs3acl.c          |   2 +-
 fs/nfs/nfs3xdr.c          |   1 +
 fs/nfs/nfs4proc.c         |  45 ++++---
 fs/nfs/nfs4xdr.c          |  43 ++++++-
 fs/nfs/nfstrace.h         |   9 +-
 fs/nfs/proc.c             |   1 +
 fs/nfs/write.c            |   2 +-
 include/linux/nfs4.h      |   9 ++
 include/linux/nfs_fs.h    |   4 +-
 include/linux/nfs_fs_sb.h |   3 +
 include/linux/nfs_xdr.h   |   2 +
 16 files changed, 283 insertions(+), 99 deletions(-)

-- 
2.30.2

