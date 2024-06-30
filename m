Return-Path: <linux-nfs+bounces-4430-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12B3091D2C1
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Jun 2024 18:38:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35C031C20975
	for <lists+linux-nfs@lfdr.de>; Sun, 30 Jun 2024 16:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39010155CA9;
	Sun, 30 Jun 2024 16:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LXX1HUv+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15201155C82
	for <linux-nfs@vger.kernel.org>; Sun, 30 Jun 2024 16:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719765482; cv=none; b=AkDUlnHnJx146d/ndzMjPNXqW48NoKviDtABE+sbb6ltBU3tPjWhN8bdZ8iifG93Fj1FJIsFiqk3hFh7Yx9qjO9k0ZW9ByAVCzXBqBdb/beJpxfI4qh9t6UXnLYXYoyFeTPXuJTVOPkvO7Vfwf4XO/6uOouN6+pFXWToeUloHrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719765482; c=relaxed/simple;
	bh=cwQtXOcvcmta6o3Zx3HlDmA1LzTfSvDKDysGuKXML+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HmpPe8gk65r1pZGl1IKb3cYqWiT+K2qvFdkRVhKzplq7nlS4b6giQwFUuxFB7fM0BbgnfbLThI3j7e7w4cDJhaJKKUjP3qgytb2mlCBuWLxdKJTQr15JNIArxlKTqvZHquVxty9PbPWhEyiTR69oguHV8817j7fxX9XdKEfGjqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LXX1HUv+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B57D6C2BD10;
	Sun, 30 Jun 2024 16:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719765481;
	bh=cwQtXOcvcmta6o3Zx3HlDmA1LzTfSvDKDysGuKXML+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LXX1HUv+c+52pKi2PhcpZ0uAms4STZGTGRQLCzTh8XVEg+pHQ+1Ma7V5jRalCxyyd
	 uA6hn5tJFr3fOifRH78J2qp/qIB+HgTF8W7MG+krUGBCgLLPq/FDJJ9o01gQB0NPBQ
	 FxEs7RlwIE8bb2FZFi//pcIIZrqhhIGmnbkiQJSIhE8cxvUH3kpHQc2FQUC3jJnGUo
	 EwjobEZHn/gnfXp6PF4hsGXwrIndujktznHDnuVQ937sJdZBaSyeqU4N29fDg0Lcwu
	 NJpi8EZKqUdQg7WSBJcnbjJthA+qPaYaHi9SLsh9xU1DHOJPKexkOJ2VbBa0DJA9k0
	 5Na8D6u7d/YdQ==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v10 14/19] nfs: fix nfs_localio_vfs_getattr() to properly support v4
Date: Sun, 30 Jun 2024 12:37:36 -0400
Message-ID: <20240630163741.48753-15-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240630163741.48753-1-snitzer@kernel.org>
References: <20240630163741.48753-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is nfs-localio code which blurs the boundary between server and
client...

The change_attr is used by NFS to detect if a file might have changed.
This code is used to get the attributes after a write request.  NFS
uses a GETATTR request to the server at other times.  The change_attr
should be consistent between the two else comparisons will be
meaningless.

So nfs_localio_vfs_getattr() should use the same change_attr as the
one that would be used if the NFS GETATTR request were made.  For
NFSv3, that is nfs_timespec_to_change_attr() as was already
implemented.  For NFSv4 it is something different (as implemented in
this commit).

Message-Id: <171918165963.14261.959545364150864599@noble.neil.brown.name>
Suggested-by: NeilBrown <neil@brown.name>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/localio.c | 48 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 39 insertions(+), 9 deletions(-)

diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 0f7d6d55087b..fe96f05ba8ca 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -364,21 +364,47 @@ nfs_set_local_verifier(struct inode *inode,
 	verf->committed = how;
 }
 
+/* Factored out from fs/nfsd/vfs.h:fh_getattr() */
+static int __vfs_getattr(struct path *p, struct kstat *stat, int version)
+{
+	u32 request_mask = STATX_BASIC_STATS;
+
+	if (version == 4)
+		request_mask |= (STATX_BTIME | STATX_CHANGE_COOKIE);
+	return vfs_getattr(p, stat, request_mask, AT_STATX_SYNC_AS_STAT);
+}
+
+/*
+ * Copied from fs/nfsd/nfsfh.c:nfsd4_change_attribute(),
+ * FIXME: factor out to common code.
+ */
+static u64 __nfsd4_change_attribute(const struct kstat *stat,
+				    const struct inode *inode)
+{
+	u64 chattr;
+
+	if (stat->result_mask & STATX_CHANGE_COOKIE) {
+		chattr = stat->change_cookie;
+		if (S_ISREG(inode->i_mode) &&
+		    !(stat->attributes & STATX_ATTR_CHANGE_MONOTONIC)) {
+			chattr += (u64)stat->ctime.tv_sec << 30;
+			chattr += stat->ctime.tv_nsec;
+		}
+	} else {
+		chattr = time_to_chattr(&stat->ctime);
+	}
+	return chattr;
+}
+
 static void nfs_local_vfs_getattr(struct nfs_local_kiocb *iocb)
 {
 	struct kstat stat;
 	struct file *filp = iocb->kiocb.ki_filp;
 	struct nfs_pgio_header *hdr = iocb->hdr;
 	struct nfs_fattr *fattr = hdr->res.fattr;
+	int version = NFS_PROTO(hdr->inode)->version;
 
-	if (unlikely(!fattr) || vfs_getattr(&filp->f_path, &stat,
-					    STATX_INO |
-					    STATX_ATIME |
-					    STATX_MTIME |
-					    STATX_CTIME |
-					    STATX_SIZE |
-					    STATX_BLOCKS,
-					    AT_STATX_SYNC_AS_STAT))
+	if (unlikely(!fattr) || __vfs_getattr(&filp->f_path, &stat, version))
 		return;
 
 	fattr->valid = (NFS_ATTR_FATTR_FILEID |
@@ -394,7 +420,11 @@ static void nfs_local_vfs_getattr(struct nfs_local_kiocb *iocb)
 	fattr->atime = stat.atime;
 	fattr->mtime = stat.mtime;
 	fattr->ctime = stat.ctime;
-	fattr->change_attr = nfs_timespec_to_change_attr(&fattr->ctime);
+	if (version == 4) {
+		fattr->change_attr =
+			__nfsd4_change_attribute(&stat, file_inode(filp));
+	} else
+		fattr->change_attr = nfs_timespec_to_change_attr(&fattr->ctime);
 	fattr->du.nfs3.used = stat.blocks << 9;
 }
 
-- 
2.44.0


