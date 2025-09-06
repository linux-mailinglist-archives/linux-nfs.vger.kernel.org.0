Return-Path: <linux-nfs+bounces-14102-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A98B9B474E7
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Sep 2025 18:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7F76584A55
	for <lists+linux-nfs@lfdr.de>; Sat,  6 Sep 2025 16:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911F6257831;
	Sat,  6 Sep 2025 16:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TL9drtYw"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4BF2580CB
	for <linux-nfs@vger.kernel.org>; Sat,  6 Sep 2025 16:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757176941; cv=none; b=VLKz3HlthQon1I5DjW1Rbo/PoP57TBcDmXbSEx5LM1Smkus3qJpWF0DYp2scsqNUpwnL5/85oAFfr4REk+ferDdjR2wgqeFY8RDX5jQgAIZxDisYdipl+7a9IbG/vyFqtaaM8OacPUuoJovz1M6ipO+glvOCDUIU1GQLnNo+D1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757176941; c=relaxed/simple;
	bh=CMGXWG+sZhSmZsAqoDTFnyzeO7lsKn7E6kOWxA3FOvI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dewfRMxjHMmCzie4hJuxS6ssjwGOoHG8ar70GIbYHe2T3411pAPH3DZoeisLzPN0yLC2yNdDqdv4XqtVjlLdj+ijU9+q1liwYCsT9Bxjaymlc5sdnE0h0Rcte/nqRzD/8ZU+sA5sCxBsiUfppaH31QAfuf+Dtma4/19zNWiOkcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TL9drtYw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD3AEC4CEE7
	for <linux-nfs@vger.kernel.org>; Sat,  6 Sep 2025 16:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757176940;
	bh=CMGXWG+sZhSmZsAqoDTFnyzeO7lsKn7E6kOWxA3FOvI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TL9drtYw9e0iukls2QdPZmZQ3FWXd0Lv+kpNwQE6jpNWE4t/tWkYsUQNjgHurxjjc
	 jDPPqEpiZL9ov/CSDgNR2IukFyQmJmxTJfMX0jaQ6YGcx3IB5sRgmfQ8/ilc/FwVA4
	 /JIge5CvI/FprPWps6Hd8cDDrvZxnRioQUheWjHP6mP2bXWbrVY915LnehIMTa1agy
	 i4EWBMShDA4jPu/Mn8ce45KbSlGUDhtTZReBXwt6RYZ8QQZFVVutRGN1J8Sf79FgKT
	 cQdklaUG3kj2/QwBstXukIK/Y1Iogp5hshbfDRlq2YF6AOSJ8AKaGnuyYZDN33qiyd
	 bShk2VxLAf7Jg==
From: Trond Myklebust <trondmy@kernel.org>
To: linux-nfs@vger.kernel.org
Subject: [PATCH v2 3/8] NFS: Serialise O_DIRECT i/o and truncate()
Date: Sat,  6 Sep 2025 12:42:11 -0400
Message-ID: <aa8323e3e1b83094bb05100af030488a44276604.1757176392.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1757176392.git.trond.myklebust@hammerspace.com>
References: <cover.1757100278.git.trond.myklebust@hammerspace.com> <cover.1757176392.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Ensure that all O_DIRECT reads and writes are complete, and prevent the
initiation of new i/o until the setattr operation that will truncate the
file is complete.

Fixes: a5864c999de6 ("NFS: Do not serialise O_DIRECT reads and writes")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/inode.c    |  4 +++-
 fs/nfs/internal.h | 10 ++++++++++
 fs/nfs/io.c       | 13 ++-----------
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 0b141feacc52..49df9debb1a6 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -768,8 +768,10 @@ nfs_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 	trace_nfs_setattr_enter(inode);
 
 	/* Write all dirty data */
-	if (S_ISREG(inode->i_mode))
+	if (S_ISREG(inode->i_mode)) {
+		nfs_file_block_o_direct(NFS_I(inode));
 		nfs_sync_inode(inode);
+	}
 
 	fattr = nfs_alloc_fattr_with_label(NFS_SERVER(inode));
 	if (fattr == NULL) {
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 1433ae13dba0..c0a44f389f8f 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -532,6 +532,16 @@ static inline bool nfs_file_io_is_buffered(struct nfs_inode *nfsi)
 	return test_bit(NFS_INO_ODIRECT, &nfsi->flags) == 0;
 }
 
+/* Must be called with exclusively locked inode->i_rwsem */
+static inline void nfs_file_block_o_direct(struct nfs_inode *nfsi)
+{
+	if (test_bit(NFS_INO_ODIRECT, &nfsi->flags)) {
+		clear_bit(NFS_INO_ODIRECT, &nfsi->flags);
+		inode_dio_wait(&nfsi->vfs_inode);
+	}
+}
+
+
 /* namespace.c */
 #define NFS_PATH_CANONICAL 1
 extern char *nfs_path(char **p, struct dentry *dentry,
diff --git a/fs/nfs/io.c b/fs/nfs/io.c
index 3388faf2acb9..d275b0a250bf 100644
--- a/fs/nfs/io.c
+++ b/fs/nfs/io.c
@@ -14,15 +14,6 @@
 
 #include "internal.h"
 
-/* Call with exclusively locked inode->i_rwsem */
-static void nfs_block_o_direct(struct nfs_inode *nfsi, struct inode *inode)
-{
-	if (test_bit(NFS_INO_ODIRECT, &nfsi->flags)) {
-		clear_bit(NFS_INO_ODIRECT, &nfsi->flags);
-		inode_dio_wait(inode);
-	}
-}
-
 /**
  * nfs_start_io_read - declare the file is being used for buffered reads
  * @inode: file inode
@@ -57,7 +48,7 @@ nfs_start_io_read(struct inode *inode)
 	err = down_write_killable(&inode->i_rwsem);
 	if (err)
 		return err;
-	nfs_block_o_direct(nfsi, inode);
+	nfs_file_block_o_direct(nfsi);
 	downgrade_write(&inode->i_rwsem);
 
 	return 0;
@@ -90,7 +81,7 @@ nfs_start_io_write(struct inode *inode)
 
 	err = down_write_killable(&inode->i_rwsem);
 	if (!err)
-		nfs_block_o_direct(NFS_I(inode), inode);
+		nfs_file_block_o_direct(NFS_I(inode));
 	return err;
 }
 
-- 
2.51.0


