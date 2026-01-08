Return-Path: <linux-nfs+bounces-17661-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 220AAD05C9B
	for <lists+linux-nfs@lfdr.de>; Thu, 08 Jan 2026 20:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAE803006F48
	for <lists+linux-nfs@lfdr.de>; Thu,  8 Jan 2026 19:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E1231A810;
	Thu,  8 Jan 2026 19:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F0HsHnz/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62EC3148B2;
	Thu,  8 Jan 2026 19:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767899406; cv=none; b=NvMItYdgDEnVSSPULGW9+U9HkK3b2a7UVG95f55KeoR6T48V+HNke3m+egNw5l9ML3muJ6WaIW5cQsv+bMFxXRqcsVh6M7UP3rGYbO+KWEepugbFBIWYl9XMsCdRvPNNgzc0ISjbTSNgAQVhWKyytjdFPpNGm9eumcH5Gcuf9GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767899406; c=relaxed/simple;
	bh=YggfagTQHW4M5TASmJKUhH8PBVd94WDkB++kMSYFZ3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I+LCePm/4ylCFtotkweh0QW1kkqubzQhte4no2gb2xNz6E4sf8BetslUUQIJOzQNT4k+IQp9B0zY2h3qJumPjw5n5N2kflHGdvAA4ES+8Uu/Szik6Tte1Yj5mO3/Ie2/jdx+FV784uhgZZYpOr4j1eQnOrRltFwM9nUVgfdhUt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F0HsHnz/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19702C116D0;
	Thu,  8 Jan 2026 19:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767899406;
	bh=YggfagTQHW4M5TASmJKUhH8PBVd94WDkB++kMSYFZ3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F0HsHnz/NngTnRT8lS2pKPV6TmeYaHeGliRQnw6fl4n92EUwjC70dhKDSFkfc+JeQ
	 3fu6TsWj4kM0G7/+WIvPiQb/ASmD1+zJR1+sZm/wOgzVZHQHeEHbd3VUzJStU3TZ2R
	 3gDhHAlCzCyl0rcizZVzhSi846UIj3rhlJHeJqbxOmZ7s3S5zA8KtBjWDn+wbxpLMW
	 UPyvGl0GAXHeYoKsVAYCd1V13AI5/GTcNN0LAATk5gNUPN8pDqLs7ycyvC2/Op+WGq
	 JLt0h0Kf4iIjqm6d1knCjqb6+BDZVSMrRjhiZcfYbYuVsyqkgcwrmjeLhgqwsescAm
	 7aTEPctPgcTmQ==
From: Chuck Lever <cel@kernel.org>
To: <stable@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	<linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 6.6.y v2 1/4] nfsd: convert to new timestamp accessors
Date: Thu,  8 Jan 2026 14:09:59 -0500
Message-ID: <20260108191002.4071603-2-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <2025122941-civic-revered-b250@gregkh>
References: <2025122941-civic-revered-b250@gregkh>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 11fec9b9fb04fd1b3330a3b91ab9dcfa81ad5ad3 ]

Convert to using the new inode timestamp accessor functions.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Link: https://lore.kernel.org/r/20231004185347.80880-50-jlayton@kernel.org
Stable-dep-of: 24d92de9186e ("nfsd: Fix NFSv3 atomicity bugs in nfsd_setattr()")
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/nfsd/blocklayout.c | 4 +++-
 fs/nfsd/nfs3proc.c    | 4 ++--
 fs/nfsd/nfs4proc.c    | 8 ++++----
 fs/nfsd/nfsctl.c      | 2 +-
 fs/nfsd/vfs.c         | 2 +-
 5 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index 59f119cce3dc..db4b67523934 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -117,11 +117,13 @@ static __be32
 nfsd4_block_commit_blocks(struct inode *inode, struct nfsd4_layoutcommit *lcp,
 		struct iomap *iomaps, int nr_iomaps)
 {
+	struct timespec64 mtime = inode_get_mtime(inode);
+	loff_t new_size = lcp->lc_last_wr + 1;
 	struct iattr iattr = { .ia_valid = 0 };
 	int error;
 
 	if (lcp->lc_mtime.tv_nsec == UTIME_NOW ||
-	    timespec64_compare(&lcp->lc_mtime, &inode->i_mtime) < 0)
+	    timespec64_compare(&lcp->lc_mtime, &mtime) < 0)
 		lcp->lc_mtime = current_time(inode);
 	iattr.ia_valid |= ATTR_ATIME | ATTR_CTIME | ATTR_MTIME;
 	iattr.ia_atime = iattr.ia_ctime = iattr.ia_mtime = lcp->lc_mtime;
diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
index 268ef57751c4..666bad8182e5 100644
--- a/fs/nfsd/nfs3proc.c
+++ b/fs/nfsd/nfs3proc.c
@@ -294,8 +294,8 @@ nfsd3_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			status = nfserr_exist;
 			break;
 		case NFS3_CREATE_EXCLUSIVE:
-			if (d_inode(child)->i_mtime.tv_sec == v_mtime &&
-			    d_inode(child)->i_atime.tv_sec == v_atime &&
+			if (inode_get_mtime_sec(d_inode(child)) == v_mtime &&
+			    inode_get_atime_sec(d_inode(child)) == v_atime &&
 			    d_inode(child)->i_size == 0) {
 				break;
 			}
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 886c09267544..37b918e4a53d 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -322,8 +322,8 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			status = nfserr_exist;
 			break;
 		case NFS4_CREATE_EXCLUSIVE:
-			if (d_inode(child)->i_mtime.tv_sec == v_mtime &&
-			    d_inode(child)->i_atime.tv_sec == v_atime &&
+			if (inode_get_mtime_sec(d_inode(child)) == v_mtime &&
+			    inode_get_atime_sec(d_inode(child)) == v_atime &&
 			    d_inode(child)->i_size == 0) {
 				open->op_created = true;
 				break;		/* subtle */
@@ -331,8 +331,8 @@ nfsd4_create_file(struct svc_rqst *rqstp, struct svc_fh *fhp,
 			status = nfserr_exist;
 			break;
 		case NFS4_CREATE_EXCLUSIVE4_1:
-			if (d_inode(child)->i_mtime.tv_sec == v_mtime &&
-			    d_inode(child)->i_atime.tv_sec == v_atime &&
+			if (inode_get_mtime_sec(d_inode(child)) == v_mtime &&
+			    inode_get_atime_sec(d_inode(child)) == v_atime &&
 			    d_inode(child)->i_size == 0) {
 				open->op_created = true;
 				goto set_attr;	/* subtle */
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 887035b74467..81e0b4726567 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1140,7 +1140,7 @@ static struct inode *nfsd_get_inode(struct super_block *sb, umode_t mode)
 	/* Following advice from simple_fill_super documentation: */
 	inode->i_ino = iunique(sb, NFSD_MaxReserved);
 	inode->i_mode = mode;
-	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 	switch (mode & S_IFMT) {
 	case S_IFDIR:
 		inode->i_fop = &simple_dir_operations;
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 5ee7149ceaa5..1faf65147223 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -521,7 +521,7 @@ nfsd_setattr(struct svc_rqst *rqstp, struct svc_fh *fhp,
 
 	nfsd_sanitize_attrs(inode, iap);
 
-	if (check_guard && guardtime != inode_get_ctime(inode).tv_sec)
+	if (check_guard && guardtime != inode_get_ctime_sec(inode))
 		return nfserr_notsync;
 
 	/*
-- 
2.52.0


