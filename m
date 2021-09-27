Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57B7341956F
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Sep 2021 15:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234623AbhI0Nxp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Sep 2021 09:53:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:43296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234622AbhI0Nxp (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 27 Sep 2021 09:53:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 607DD6023B;
        Mon, 27 Sep 2021 13:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632750727;
        bh=YL0blw3zE7Mfch8mfcHCoJOFNU9xZcO6uiLy3oBbhVo=;
        h=From:To:Cc:Subject:Date:From;
        b=esXuG57ylp6qfjNrLT+dsTCV4T3p5S1NZPAfF6Y5ChxAozJSZlnuJn8QR3PtjSBab
         Wu2pSBG/CKN/tFRynsHIBTf4BlMhV+iNZxvwbOfuUzwS1dorJ+yjyb/zmY8PqoeOiD
         dT5Pl6MdfZlICiuV5y1SmFGl5+xGsKWawMDHhNcSp6t39mcSFT3AJwMx0Tnc+oRmoZ
         WqoCmYl3EsNEHp03swmowZ43INEBiixAF0M6o7us7H7TdHqUEi+btscquLp66qjaZ+
         QeW5HqycWKnpUaZmrhq1VKrup3qs/64bS8lMvXKLGjE7QrMtruA5KFFF4gtrxhZBdd
         bh+Af9ybIJleA==
From:   trondmy@kernel.org
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     Anna Schumaker <Anna.Schumaker@netapp.com>,
        linux-nfs@vger.kernel.org
Subject: [PATCH v2] NFS: Default change_attr_type to NFS4_CHANGE_TYPE_IS_UNDEFINED
Date:   Mon, 27 Sep 2021 09:52:06 -0400
Message-Id: <20210927135206.4455-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Both NFSv3 and NFSv2 generate their change attribute from the ctime
value that was supplied by the server. However the problem is that there
are plenty of servers out there with ctime resolutions of 1ms or worse.
In a modern performance system, this is insufficient when trying to
decide which is the most recent set of attributes when, for instance, a
READ or GETATTR call races with a WRITE or SETATTR.

For this reason, let's revert to labelling the NFSv2/v3 change
attributes as NFS4_CHANGE_TYPE_IS_UNDEFINED. This will ensure we protect
against such races.

Fixes: 7b24dacf0840 ("NFS: Another inode revalidation improvement")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/inode.c   | 4 +++-
 fs/nfs/nfs3xdr.c | 2 +-
 fs/nfs/proc.c    | 2 +-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 4f45281c47cf..0f092ccb0ca1 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -1777,8 +1777,10 @@ static int nfs_inode_finish_partial_attr_update(const struct nfs_fattr *fattr,
 		NFS_INO_INVALID_BLOCKS | NFS_INO_INVALID_OTHER |
 		NFS_INO_INVALID_NLINK;
 	unsigned long cache_validity = NFS_I(inode)->cache_validity;
+	enum nfs4_change_attr_type ctype = NFS_SERVER(inode)->change_attr_type;
 
-	if (!(cache_validity & NFS_INO_INVALID_CHANGE) &&
+	if (ctype != NFS4_CHANGE_TYPE_IS_UNDEFINED &&
+	    !(cache_validity & NFS_INO_INVALID_CHANGE) &&
 	    (cache_validity & check_valid) != 0 &&
 	    (fattr->valid & NFS_ATTR_FATTR_CHANGE) != 0 &&
 	    nfs_inode_attrs_cmp_monotonic(fattr, inode) == 0)
diff --git a/fs/nfs/nfs3xdr.c b/fs/nfs/nfs3xdr.c
index e6eca1d7481b..9274c9c5efea 100644
--- a/fs/nfs/nfs3xdr.c
+++ b/fs/nfs/nfs3xdr.c
@@ -2227,7 +2227,7 @@ static int decode_fsinfo3resok(struct xdr_stream *xdr,
 
 	/* ignore properties */
 	result->lease_time = 0;
-	result->change_attr_type = NFS4_CHANGE_TYPE_IS_TIME_METADATA;
+	result->change_attr_type = NFS4_CHANGE_TYPE_IS_UNDEFINED;
 	return 0;
 }
 
diff --git a/fs/nfs/proc.c b/fs/nfs/proc.c
index ea19dbf12301..ecc4e717808c 100644
--- a/fs/nfs/proc.c
+++ b/fs/nfs/proc.c
@@ -91,7 +91,7 @@ nfs_proc_get_root(struct nfs_server *server, struct nfs_fh *fhandle,
 	info->dtpref = fsinfo.tsize;
 	info->maxfilesize = 0x7FFFFFFF;
 	info->lease_time = 0;
-	info->change_attr_type = NFS4_CHANGE_TYPE_IS_TIME_METADATA;
+	info->change_attr_type = NFS4_CHANGE_TYPE_IS_UNDEFINED;
 	return 0;
 }
 
-- 
2.31.1

