Return-Path: <linux-nfs+bounces-17417-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF94CF0518
	for <lists+linux-nfs@lfdr.de>; Sat, 03 Jan 2026 20:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C3183013968
	for <lists+linux-nfs@lfdr.de>; Sat,  3 Jan 2026 19:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9932E1F4613;
	Sat,  3 Jan 2026 19:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXyNmrwX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F322263F5F;
	Sat,  3 Jan 2026 19:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767469151; cv=none; b=V/CanR1ZFIbYZ9cW0sG3mNEC7qej/WkOT9KHJjAaJPRTqx8c5jGhAKTVRUeOoS1U8UH7xXoJx9IqIV5xi7pq7O8SJInIakYQtohss/++hPplESEfSpAxk/lbuiaI0zydwjxtMKxuYEKhwMXPUNcIhip3oldXEjTBZbRevQ08cGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767469151; c=relaxed/simple;
	bh=WOO8q2xOBwBcNmQra9IlAu6M7CBmrCbHAjP4EKjQwq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YpEJ6Sk+TNwMlY4aD4wn79sMFR/vhiUQNEA+fZzH+66Jpsya7eqrCNdQbuBVJEtv/OaFxge2bxTIxH9PVWzL7UBPD9rprUHYKS8t4161Hww6PpRcEb3qCPcAnYupe9ZRGXNeoetKP/4QXYjOB+ivxzuUczmGJJ36nNgxafNOfQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXyNmrwX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77668C19424;
	Sat,  3 Jan 2026 19:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767469150;
	bh=WOO8q2xOBwBcNmQra9IlAu6M7CBmrCbHAjP4EKjQwq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qXyNmrwXG8GYBzNNtR2a/HISRZe9JhJac1EOoOdr4bBrl6Hi/fkSgkYgIYPIA52hz
	 g7EEdpRgzL5BMdcsQCDtcdtarFastauN3pCvc8VJj1fKtwVfpJ0HRpjNIfwi2zVLTj
	 G7qHFWi6ki80ZrSj8NElA6GI/dEovju6nt8sUzRAugMrHnjt1WtFJkVXb1G0ThhA+P
	 oqnJTN6/FLh4UO611jamqhe/40zOj55byAFP0nbNZ+uxJnTIUdVL8xxh+9R35piFLn
	 oNLu8OuBgCCvzskC6NQbY0K4Rbvr2ETYNcjk1R7R2yW/fDYwCv6z1NoTPfZyyHoopn
	 XyI0ugXDYippg==
From: Chuck Lever <cel@kernel.org>
To: <stable@vger.kernel.org>
Cc: <linux-nfs@vger.kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH 6.6.y 1/4] nfsd: convert to new timestamp accessors
Date: Sat,  3 Jan 2026 14:38:51 -0500
Message-ID: <20260103193854.2954342-2-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260103193854.2954342-1-cel@kernel.org>
References: <20260103193854.2954342-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 335a7be84b526861f3deb4fdd5d5c2a48cf1feef ]

[ cel: adjust to the 6.6.y version of fs/nfsd/blocklayout.c ]
Stable-dep-of: 24d92de9186e ("nfsd: Fix NFSv3 atomicity bugs in nfsd_setattr()")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs3proc.c | 4 ++--
 fs/nfsd/nfs4proc.c | 8 ++++----
 fs/nfsd/nfsctl.c   | 2 +-
 fs/nfsd/vfs.c      | 2 +-
 4 files changed, 8 insertions(+), 8 deletions(-)

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


