Return-Path: <linux-nfs+bounces-21069-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMt6Osxi6mmrygIAu9opvQ
	(envelope-from <linux-nfs+bounces-21069-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 20:19:56 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D610456057
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 20:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 655BA3076C83
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Apr 2026 18:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5DC437DE9B;
	Thu, 23 Apr 2026 18:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+os3zlY"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777DD1F099C
	for <linux-nfs@vger.kernel.org>; Thu, 23 Apr 2026 18:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776968343; cv=none; b=uB9nj6X6fMjIIi1pfjv0HAI3C0s54+wfvkbJmqHSQljjdAliL5zYZvorquyoAhytW5ZGz8hVmtUE1M1ID/zo3OGL6KH03LggPOTW3h6SJrSl74TbwZr4l7mm2vztBYHkStIrC9RcZ41K6UCk+YMqkhU8wuYXWQ+SVurd4TT5RV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776968343; c=relaxed/simple;
	bh=qJsDy4dcoP+jh17EKAWUoVKw1aSlTAJrnDPVpv/2REI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dEaQ40/eLNlm6B8cA4lsS6x33pwxVfQ5xK89V4RNQPeNM08kn9R60QovrJHNHbwv3teMHIy3T3ljT7PNbxLHXFLo9SiLClA2WVmCmogk08he+j9kOA3PYQoWz0ywq+H4LTVJMRiN7p7ysUaveoeXDaoGIpQWlPjVTWaLbfrRVro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+os3zlY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1F5C2BCB2;
	Thu, 23 Apr 2026 18:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776968342;
	bh=qJsDy4dcoP+jh17EKAWUoVKw1aSlTAJrnDPVpv/2REI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f+os3zlYR1kDGzKfZoAMogj057piLOE3MJohPu6Rx2F5QSdJ8aiTVo6gHSX+GvYtM
	 J2+xgkPdiXwPUO9nHhKOpWWWFydhl5z/NkAtp6hnUZggHLGuzyKqL8zWZEAj6heds6
	 e6L6/86mkDqFtFhtJguyZklUSE7c8bV/K0mrdQc0n3FsGOdEii7JYaLktVTpWw59K0
	 YJu06CxNznJ/Po0HoAldGhvYb4agdZrUwqNbzScIyZuB0SIFb+jmdnhMof1AJKsTK1
	 4jj/DELMqfRpqK2CMKseTYVStRAmJ9T0IZ+AMQOEtbNnAl/OlfCs8TiiGpHeTutNNC
	 ziz4HdRg4NifQ==
From: Chuck Lever <cel@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: NeilBrown <neilb@ownmail.net>,
	Jeff Layton <jlayton@kernel.org>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <dai.ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	<linux-nfs@vger.kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v3 3/4] exportfs: don't pass struct iattr to ->commit_blocks
Date: Thu, 23 Apr 2026 14:18:53 -0400
Message-ID: <20260423181854.743150-4-cel@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423181854.743150-1-cel@kernel.org>
References: <20260423181854.743150-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com,vger.kernel.org,lst.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21069-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 3D610456057
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Christoph Hellwig <hch@lst.de>

The only thing ->commit_blocks really needs is the new size, with a magic
-1 placeholder 0 for "do not change the size" because it only ever
extends the size.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/blocklayout.c          | 12 ++----------
 fs/xfs/xfs_pnfs.c              | 19 ++++++++++---------
 include/linux/exportfs_block.h |  3 +--
 3 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index e612fcf8666a..5be7721c22c2 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -179,7 +179,6 @@ static __be32
 nfsd4_block_commit_blocks(struct inode *inode, struct nfsd4_layoutcommit *lcp,
 		struct iomap *iomaps, int nr_iomaps)
 {
-	struct iattr iattr = { .ia_valid = 0 };
 	int error;
 
 	/*
@@ -191,16 +190,9 @@ nfsd4_block_commit_blocks(struct inode *inode, struct nfsd4_layoutcommit *lcp,
 	 * timestamp is a "may" condition, and clients that want to force a
 	 * specific timestamp should send a separate SETATTR in the compound.
 	 */
-	iattr.ia_valid |= ATTR_ATIME | ATTR_CTIME | ATTR_MTIME;
-	iattr.ia_atime = iattr.ia_ctime = iattr.ia_mtime = current_time(inode);
-
-	if (lcp->lc_size_chg) {
-		iattr.ia_valid |= ATTR_SIZE;
-		iattr.ia_size = lcp->lc_newsize;
-	}
-
 	error = inode->i_sb->s_export_op->block_ops->commit_blocks(inode,
-			iomaps, nr_iomaps, &iattr);
+			iomaps, nr_iomaps,
+			lcp->lc_size_chg ? lcp->lc_newsize : 0);
 	kfree(iomaps);
 	return nfserrno(error);
 }
diff --git a/fs/xfs/xfs_pnfs.c b/fs/xfs/xfs_pnfs.c
index 12e083f1b9ba..7d689bb2efd9 100644
--- a/fs/xfs/xfs_pnfs.c
+++ b/fs/xfs/xfs_pnfs.c
@@ -257,23 +257,22 @@ xfs_fs_commit_blocks(
 	struct inode		*inode,
 	struct iomap		*maps,
 	int			nr_maps,
-	struct iattr		*iattr)
+	loff_t			new_size)
 {
 	struct xfs_inode	*ip = XFS_I(inode);
 	struct xfs_mount	*mp = ip->i_mount;
 	struct xfs_trans	*tp;
+	struct timespec64	now;
 	bool			update_isize = false;
 	int			error, i;
 	loff_t			size;
 
-	ASSERT(iattr->ia_valid & (ATTR_ATIME|ATTR_CTIME|ATTR_MTIME));
-
 	xfs_ilock(ip, XFS_IOLOCK_EXCL);
 
 	size = i_size_read(inode);
-	if ((iattr->ia_valid & ATTR_SIZE) && iattr->ia_size > size) {
+	if (new_size > size) {
 		update_isize = true;
-		size = iattr->ia_size;
+		size = new_size;
 	}
 
 	for (i = 0; i < nr_maps; i++) {
@@ -318,11 +317,13 @@ xfs_fs_commit_blocks(
 	xfs_trans_ijoin(tp, ip, XFS_ILOCK_EXCL);
 	xfs_trans_log_inode(tp, ip, XFS_ILOG_CORE);
 
-	ASSERT(!(iattr->ia_valid & (ATTR_UID | ATTR_GID)));
-	setattr_copy(&nop_mnt_idmap, inode, iattr);
+	now = inode_set_ctime_current(inode);
+	inode_set_atime_to_ts(inode, now);
+	inode_set_mtime_to_ts(inode, now);
+
 	if (update_isize) {
-		i_size_write(inode, iattr->ia_size);
-		ip->i_disk_size = iattr->ia_size;
+		i_size_write(inode, new_size);
+		ip->i_disk_size = new_size;
 	}
 
 	xfs_trans_set_sync(tp);
diff --git a/include/linux/exportfs_block.h b/include/linux/exportfs_block.h
index 1f52fea8e4dc..d1dec4689b14 100644
--- a/include/linux/exportfs_block.h
+++ b/include/linux/exportfs_block.h
@@ -9,7 +9,6 @@
 
 #include <linux/types.h>
 
-struct iattr;
 struct inode;
 struct iomap;
 struct super_block;
@@ -33,7 +32,7 @@ struct exportfs_block_ops {
 	 * the client.
 	 */
 	int (*commit_blocks)(struct inode *inode, struct iomap *iomaps,
-			int nr_iomaps, struct iattr *iattr);
+			int nr_iomaps, loff_t new_size);
 };
 
 #endif /* LINUX_EXPORTFS_BLOCK_H */
-- 
2.53.0


