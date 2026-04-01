Return-Path: <linux-nfs+bounces-20590-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGRCLkI2zWlwawYAu9opvQ
	(envelope-from <linux-nfs+bounces-20590-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Apr 2026 17:14:10 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1482737CCE4
	for <lists+linux-nfs@lfdr.de>; Wed, 01 Apr 2026 17:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDE57313FD01
	for <lists+linux-nfs@lfdr.de>; Wed,  1 Apr 2026 14:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3DE477984;
	Wed,  1 Apr 2026 14:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lkCk4yl1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB19E472760;
	Wed,  1 Apr 2026 14:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775054481; cv=none; b=TZQ8+z3BvJ4mvMze4H7GOZtPA7MV407EqSLEV2rtaTO+qiQf1Gh4vkuW+QzoFjk6tLYoiiacALvuQibB0tGSe+k7OU+ClZ2ktU4t6zFZmu3JZ4PViwGBs7wJ0WC2b4Co1KE6PYC2gQOStelTdH/uJR5VflKC8NYWFms/UacTm4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775054481; c=relaxed/simple;
	bh=DEDr9g9NC6YdCbwo1X94tI35ESUf4XdEA8kbosqdhdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ROm0/tXF8zbPpDAUmcrlSRqQcIclwRyTZQUYyrvvD2u+PZF4uA8WVP3Tm8RNoK5HPVhvoWT1qWgPib8N3YeQEJ/MhgOxeuiZcH2j73v+h4UooVXxzxU14lxQcEyHkXZUHheRskcc3Du7oifOLhxvlo8RwUYxxk2fX35OSwPkM0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lkCk4yl1; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=lGvDwNG6F18HPvD3stZnPzi/fPaXOu9Px1JJ5IA28hM=; b=lkCk4yl17GOzehqWkBxDQRbysA
	/DAgPBRaivbsb8kyXnTmTn1OC1y5i6sfsgpEO5K5kzCiAJcwtDBdeXQDmqfAoAccQQIam6DIe8q1d
	qqpv7rVA3N64lFQXwwWaZsg904saEXR1utshZHEvWixJaVPmYe0TipWQSTAeqW3U9LCY1sqNBtl0x
	tOhF+t0SEr4+vc/Hm9/MsIFr3kaJoWKfdptFNyIK3EFEpWC9lr/1kuYQL8X4I/h4r5Alb0gwdaR+D
	aRYtc4gjrdQPqOHHbHU1bFMvtyApMN1NyumrYvNPjF8v4CTA4cxVdtXy8SjsUS3LRnJIlArJv6ea9
	amR3wVbw==;
Received: from [2a02:1210:321a:af00:3fa:89ae:5c22:a910] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7wkw-0000000FWIl-0WJg;
	Wed, 01 Apr 2026 14:41:18 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>
Cc: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 3/4] exportfs: don't pass struct iattr to ->commit_blocks
Date: Wed,  1 Apr 2026 16:40:24 +0200
Message-ID: <20260401144059.160746-4-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260401144059.160746-1-hch@lst.de>
References: <20260401144059.160746-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20590-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:dkim,lst.de:email,lst.de:mid]
X-Rspamd-Queue-Id: 1482737CCE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The only thing ->commit_blocks really needs is the new size, with a magic
-1 placeholder 0 for "do not change the size" because it only ever
extends the size.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jeff Layton <jlayton@kernel.org
---
 fs/nfsd/blocklayout.c          | 12 ++----------
 fs/xfs/xfs_pnfs.c              | 19 ++++++++++---------
 include/linux/exportfs_block.h |  3 +--
 3 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index 3cc3b47361e2..23c0e4d0ff34 100644
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
2.47.3


