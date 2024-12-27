Return-Path: <linux-nfs+bounces-8809-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECD69FD7A3
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Dec 2024 21:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54DFC188438B
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Dec 2024 20:14:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD5121F866D;
	Fri, 27 Dec 2024 20:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="javRAta7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A774313DBB1
	for <linux-nfs@vger.kernel.org>; Fri, 27 Dec 2024 20:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735330438; cv=none; b=U1gWMrlBX6t+6QrKrGcVONnqgY+hBJa6qHkoVxq+CndnuExV5EKx5ryptj1iofRgT1SkgqEuX2tloo1lZdD5xaIu9rwtKVljDDofn2GImIIkbSz4tBFkb/VKGHmSbbReZgXlXY0gB39Zve+eYs3pGPeelouF/RvXrKviT0n5tzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735330438; c=relaxed/simple;
	bh=tjw1GCGAVu5wW0IMdqpm0K1JEgTRq01nQcBYHPHHutM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=h4xNHgtrcfAHYy9B/qeuXCWIA0vFW7NVXXqiPNIN/je6nKXUGKtJwLJHBjI1kYF1ti3CM+146qhaw7EfS3iQ2YNzjPBJ6APi6aEhgR9wIBVaHhyGYumhtuGmAJsvNi7Ds7LLfNMDTUo4pGuqEkLRw4l5jQ2rCh7mcKowVsc/a68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=javRAta7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19D39C4CED2;
	Fri, 27 Dec 2024 20:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735330438;
	bh=tjw1GCGAVu5wW0IMdqpm0K1JEgTRq01nQcBYHPHHutM=;
	h=From:To:Cc:Subject:Date:From;
	b=javRAta7CEoRFZJNUabmutW1c72rg3WKh3KsJ57mlv1XYT4zrrXfxIs6Z+Lf4g1Jv
	 Aqz2i8jgiXJZJCjEGZPzEyEJboqwc0ouVgmtRqwhOxDdwWFFcBndcgt+C1mdqZoJcY
	 lfEQt3bIw63wUPN/3/lEE/0NzjYbZfcQ3Pk57lgadiSn71feNboi/UkZ+GB9fASznD
	 Lf3XmeGGqABI9maQ6llGAbrNkwLsFrQvTc1K5Lz04AnfFR4k7ANrVVooskJXm4X8cF
	 dybQeBbT3GQ+KYYY3rToy+eyUwsZBzKpcybDOGKOv/XaL7cS05SXD9fGPB0lTSOUNJ
	 LvqIIBwhTwVKw==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>
Subject: [PATCH] nfs: fix incorrect error handling in LOCALIO
Date: Fri, 27 Dec 2024 15:13:56 -0500
Message-ID: <20241227201356.3074-1-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nfs4_stat_to_errno() expects a NFSv4 error code as an argument and
returns a POSIX errno.

The problem is LOCALIO is passing nfs4_stat_to_errno() the POSIX errno
return values from filp->f_op->read_iter(), filp->f_op->write_iter()
and vfs_fsync_range().

So the POSIX errno that nfs_local_pgio_done() and
nfs_local_commit_done() are passing to nfs4_stat_to_errno() are
failing to match any NFSv4 error code, which results in
nfs4_stat_to_errno() defaulting ot returning -EREMOTEIO. This causes
assertions in upper layers due to -EREMOTEIO not being a valid NFSv4
error code.

Fix this by updating nfs_local_pgio_done() and nfs_local_commit_done()
to use the new errno_to_nfs4_stat() to map a POSIX errno to an NFSv4
error code.

Fixes: 70ba381e1a431 ("nfs: add LOCALIO support")
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/localio.c           |  4 ++--
 fs/nfs_common/common.c     | 19 +++++++++++++++++++
 include/linux/nfs_common.h |  2 ++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 1eee5aac2884..047f4197c53d 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -388,7 +388,7 @@ nfs_local_pgio_done(struct nfs_pgio_header *hdr, long status)
 		hdr->res.op_status = NFS4_OK;
 		hdr->task.tk_status = 0;
 	} else {
-		hdr->res.op_status = nfs4_stat_to_errno(status);
+		hdr->res.op_status = errno_to_nfs4_stat(status);
 		hdr->task.tk_status = status;
 	}
 }
@@ -786,7 +786,7 @@ nfs_local_commit_done(struct nfs_commit_data *data, int status)
 		data->task.tk_status = 0;
 	} else {
 		nfs_reset_boot_verifier(data->inode);
-		data->res.op_status = nfs4_stat_to_errno(status);
+		data->res.op_status = errno_to_nfs4_stat(status);
 		data->task.tk_status = status;
 	}
 }
diff --git a/fs/nfs_common/common.c b/fs/nfs_common/common.c
index 34a115176f97..a84f258f0131 100644
--- a/fs/nfs_common/common.c
+++ b/fs/nfs_common/common.c
@@ -132,3 +132,22 @@ int nfs4_stat_to_errno(int stat)
 	return -stat;
 }
 EXPORT_SYMBOL_GPL(nfs4_stat_to_errno);
+
+/*
+ * Convert an errno to an NFS error code.
+ */
+__u32 errno_to_nfs4_stat(int errno)
+{
+	int i;
+	for (i = 0; i < ARRAY_SIZE(nfs4_errtbl); i++) {
+		if (nfs4_errtbl[i].errno == errno)
+			return nfs4_errtbl[i].stat;
+	}
+	/* If we cannot translate the error, the recovery routines should
+	 * handle it.
+	 * Note: remaining NFSv4 error codes have values > 10000, so should
+	 * not conflict with native Linux error codes.
+	 */
+	return NFS4ERR_SERVERFAULT;
+}
+EXPORT_SYMBOL_GPL(errno_to_nfs4_stat);
diff --git a/include/linux/nfs_common.h b/include/linux/nfs_common.h
index 5fc02df88252..2bc35f85af15 100644
--- a/include/linux/nfs_common.h
+++ b/include/linux/nfs_common.h
@@ -14,4 +14,6 @@
 int nfs_stat_to_errno(enum nfs_stat status);
 int nfs4_stat_to_errno(int stat);
 
+__u32 errno_to_nfs4_stat(int errno);
+
 #endif /* _LINUX_NFS_COMMON_H */
-- 
2.44.0


