Return-Path: <linux-nfs+bounces-17689-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F075D0AAB7
	for <lists+linux-nfs@lfdr.de>; Fri, 09 Jan 2026 15:39:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0A9E73024395
	for <lists+linux-nfs@lfdr.de>; Fri,  9 Jan 2026 14:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8099320A24;
	Fri,  9 Jan 2026 14:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amVNr8lG"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940E33612C9;
	Fri,  9 Jan 2026 14:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767969589; cv=none; b=OtQszX+lgYstMvTvuQhAOVlRiokyqNkdXo03WFptLmuD7fTveLpSgznT9+6UkwaIYsmlcVo/oH59ALovp1MA20GdcMIoKnSKeamYLcU5vRbiqYpTkwjuIyNJFbPj5Xsx44XWYzy1IncSuEH40G5g3k49A1RzMdVkjIDHjZfSWCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767969589; c=relaxed/simple;
	bh=3sUYO1HzHEf3AEZFzlxtUwdPTVV43qUc0Arab9+0VqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u2iqqdHAdVjPfeVlP0z0JLUtjaeupbD45YG7ZtXD5joqvzqR6XGTj4cgmI9sKz6ZCn08FK9KC2q1ySZfTdWgwB++6AGMuvrL1BTjR27CrO0AFBzkw598IvlYRSK/tjMvfs0XeHHRp38CJBTa0QqG4zgk0fNDPXm3agJ7ncxvZuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amVNr8lG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0AD6C19421;
	Fri,  9 Jan 2026 14:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767969589;
	bh=3sUYO1HzHEf3AEZFzlxtUwdPTVV43qUc0Arab9+0VqU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=amVNr8lGFOhqEb4XM8BgfCBmZMHqaVpE5AOsWoVwi6OjmttcY+qoaJ1/f2Acey+LY
	 7qtBURjf2tN5SGUi6yUJT9J8ZfgwKdXIC5J4Ks5piV5IQts7NMFvAt7E3Tb/StKWvq
	 3iNLdQSB01kyrvgobEaPuCqAxekSomrSO5Ac2f4OpNCI4ua0lNVx9nS/vwg+rHHbuN
	 9UmRM8+1BJe9ZHn0BemFLB05v+zRJUU28S9BisvqTPyE68jyJdV4Swm86nqtAMB5J1
	 IueDvnr6gV/fo1znnI+WM4Z5R3lCtom6LeueRKUlHZSuUAtz5CGIbFxsa8ppWpL/Yp
	 8O+9IV129tzww==
From: Chuck Lever <cel@kernel.org>
To: <stable@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	<linux-nfs@vger.kernel.org>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH 6.6.y v3 1/4] nfsd: convert to new timestamp accessors
Date: Fri,  9 Jan 2026 09:39:43 -0500
Message-ID: <20260109143946.4173043-2-cel@kernel.org>
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
[ cel: d68886bae76a has already been applied ]
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/blocklayout.c | 3 ++-
 fs/nfsd/nfs3proc.c    | 4 ++--
 fs/nfsd/nfs4proc.c    | 8 ++++----
 fs/nfsd/nfsctl.c      | 2 +-
 fs/nfsd/vfs.c         | 2 +-
 5 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index 59f119cce3dc..b6b4e389a901 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -117,11 +117,12 @@ static __be32
 nfsd4_block_commit_blocks(struct inode *inode, struct nfsd4_layoutcommit *lcp,
 		struct iomap *iomaps, int nr_iomaps)
 {
+	struct timespec64 mtime = inode_get_mtime(inode);
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


