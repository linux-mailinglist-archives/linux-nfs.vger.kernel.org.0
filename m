Return-Path: <linux-nfs+bounces-4551-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 331A7924393
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 18:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E38E7288E68
	for <lists+linux-nfs@lfdr.de>; Tue,  2 Jul 2024 16:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAC31BD4ED;
	Tue,  2 Jul 2024 16:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q4H+PrUe"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579761BD4E0
	for <linux-nfs@vger.kernel.org>; Tue,  2 Jul 2024 16:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719937731; cv=none; b=Mfi9IzENh0QAOCzszyZ1fwFsDVM6xKqQjQxPX1mn7Q11L2fl8Yn5ZAyTIqKZ9iVW9GiWUifDRiklNwtmME1tIhrBwEYMSKhrpbdt++1EGW02YpE3UtHcZd6eS3Z0Zy+Q2RKTNBnazWClvoITu3FS0Zz+a7quV4ZXiN9hQ7z5fZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719937731; c=relaxed/simple;
	bh=Nt4iC4MSfqSAMRuKNai5XcS9wozsD6bh941k2aAHLqM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bjeLtzlg/itUPIy6usFYajGQPfRZ5PBh/sQ6ZCX/jBxVNZoi/qXwnkCBJkk7WrXlkfyyrh6qhYbs2GnfQEDU3DMMqhus1l4KlMadj0blXNX6euC9Wzy9KGCXMsJDLJxsJwkh7+sY+2n5uZGPQwKE6AQaqaSpalWJmML8HFiJu/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q4H+PrUe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08489C4AF0C;
	Tue,  2 Jul 2024 16:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719937731;
	bh=Nt4iC4MSfqSAMRuKNai5XcS9wozsD6bh941k2aAHLqM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q4H+PrUehUofSYVNzRrEMYVWOw6IvdY6e96IUi21s8IHtVku78lg2NHWf0nc9I+c4
	 kAXS7yKeUbpz4Y3nEFr563yOg5DRJ9svWol6/wXGzGf3qINuJh+H1sYfQ3xd8jMTHd
	 uxPilgz+vS+gKUNyrud4o2k9jCqBcJcfk4p6xTlwNkI3W6TeQUenGJQOx4KSgARgXv
	 ABMXJtdOBr5vnYwbD5bwOGyYBQMjG30JGZqZNxeerBxBRKdV9YElR7hOFfT+LCSOFR
	 YtcCSAKSvf3q/kxNJz8Mb2ba1X7xUnNMp0dxOUgeT7WI1b59Iztcum840RJVT3x8/u
	 kHWrN4CrXMNYg==
From: Mike Snitzer <snitzer@kernel.org>
To: linux-nfs@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	Anna Schumaker <anna@kernel.org>,
	Trond Myklebust <trondmy@hammerspace.com>,
	NeilBrown <neilb@suse.de>,
	snitzer@hammerspace.com
Subject: [PATCH v11 14/20] nfs: fix nfs_localio_vfs_getattr() to properly support v4
Date: Tue,  2 Jul 2024 12:28:25 -0400
Message-ID: <20240702162831.91604-15-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240702162831.91604-1-snitzer@kernel.org>
References: <20240702162831.91604-1-snitzer@kernel.org>
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
index 5fd286e92df4..efa01d732206 100644
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


