Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC34E2A4A20
	for <lists+linux-nfs@lfdr.de>; Tue,  3 Nov 2020 16:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgKCPnl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 3 Nov 2020 10:43:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:39124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727923AbgKCPnl (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 3 Nov 2020 10:43:41 -0500
Received: from localhost.localdomain (c-68-36-133-222.hsd1.mi.comcast.net [68.36.133.222])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85FE220780
        for <linux-nfs@vger.kernel.org>; Tue,  3 Nov 2020 15:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604418220;
        bh=c8KKdfsDE4CVGjvzJXnEG5vKMgY5jRQHZrp9J307rbM=;
        h=From:To:Subject:Date:From;
        b=FXD+72Ixi+S9o4AiKNn2GU1m+s1O+uLi1nZUXg6MM9z/mgg3mh3oZcL+Gz8gUxFIy
         gjtGOwGG+QBOi+07Jd0D68RQnG+FgeVCdkAHq/k/SmCpChTjyHFJcmspCVU5SvOiSo
         CTcr2XYc1KDgagt17XIi2IJNMxlbxRobxveYsWok=
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 00/16] Readdir enhancements
Date:   Tue,  3 Nov 2020 10:33:13 -0500
Message-Id: <20201103153329.531942-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The following patch series performs a number of cleanups on the readdir
code.
It also adds support for 1MB readdir RPC calls on-the-wire, and modifies
the caching code to ensure that we cache the entire contents of that
1MB call (instead of discarding the data that doesn't fit into a single
page).

v2: Fix the handling of the NFSv3/v4 directory verifier

Trond Myklebust (16):
  NFS: Ensure contents of struct nfs_open_dir_context are consistent
  NFS: Clean up readdir struct nfs_cache_array
  NFS: Clean up nfs_readdir_page_filler()
  NFS: Clean up directory array handling
  NFS: Don't discard readdir results
  NFS: Remove unnecessary kmap in nfs_readdir_xdr_to_array()
  NFS: Replace kmap() with kmap_atomic() in nfs_readdir_search_array()
  NFS: Simplify struct nfs_cache_array_entry
  NFS: Support larger readdir buffers
  NFS: More readdir cleanups
  NFS: nfs_do_filldir() does not return a value
  NFS: Reduce readdir stack usage
  NFS: Cleanup to remove nfs_readdir_descriptor_t typedef
  NFS: Allow the NFS generic code to pass in a verifier to readdir
  NFS: Handle NFS4ERR_NOT_SAME and NFSERR_BADCOOKIE from readdir calls
  NFS: Improve handling of directory verifiers

 fs/nfs/client.c         |   4 +-
 fs/nfs/dir.c            | 609 ++++++++++++++++++++++++----------------
 fs/nfs/inode.c          |   7 -
 fs/nfs/internal.h       |   6 -
 fs/nfs/nfs3proc.c       |  35 ++-
 fs/nfs/nfs4proc.c       |  40 +--
 fs/nfs/proc.c           |  18 +-
 include/linux/nfs_fs.h  |   9 +-
 include/linux/nfs_xdr.h |  17 +-
 9 files changed, 439 insertions(+), 306 deletions(-)

-- 
2.28.0

