Return-Path: <linux-nfs+bounces-20544-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oH/OIATsy2l6MgYAu9opvQ
	(envelope-from <linux-nfs+bounces-20544-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 17:45:08 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EDE36C006
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 17:45:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E7AAE30D3475
	for <lists+linux-nfs@lfdr.de>; Tue, 31 Mar 2026 15:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19CBC41B342;
	Tue, 31 Mar 2026 15:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OIToFyA+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F335C41C30B;
	Tue, 31 Mar 2026 15:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774971269; cv=none; b=WO/DTB+O1htlB64kf4kIJy8b+56ls3+2AV+9jpzPcNm/wbeARMkyPWyssRx/KPeGBbpWXKptTcbAhmH0xhA+zma0gwPQaB8vuVMi+Tv4axWJAKNHExDa9vjbvuINYEAHLLjIwauLN6kGY+vTuaZJWzk5302r5jguZ/J5xth+5tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774971269; c=relaxed/simple;
	bh=ubtEARcTv8NPL1QHLw+4ppawLvDPTyZ7TY44V8ggXhw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HbJ9UvAnfJxXhEKVVWEra9kj0ksIaqQG8OqxrBrVTpRdJisy9NfufJ0vJoim9dV98T9GNIiD8mWsshNfeEn/+FpbDvd8Lmy7h+J9Smd+wSBIsTZWWnOx8hLTpihoDqaB6WB5Ztdx9Eb9FFfDxsVtV6xbnLR3aMOnYsm0S0RbNSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OIToFyA+; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=3fOLTBqmQhTKGoF0PRenULE+YMq87+n5ewg5vYFLufE=; b=OIToFyA+JbmQUejymMfTfpnEIf
	bEHTAYzk1rgZzVSFZVdITC72W+ejB7FChotNpQCCALzyOsKAB+Zec/V+DGVcpEdNIyXBjejImy+h4
	8cmkbRSmyAvj5YTlx9wnLV7liaXvWzvgXlOlX4d2MrfktJU6OByF2JYS2ML6nYaPLcJpyuvMo4TML
	iFZbm3fRFvCxiTujgcu5wbVREc7CjMrOhZx0bfbPSbUkMsJnCz6nxM3xck5wbo2qcvTrOh7zGxp+u
	XTUWpK/5GNkMVfDFZp0IibMNuEmCRo81q92ImqCNfxOvKSB1kiWmRE5+eT8r+/hwrUTag5DUzKM5b
	pA60pa6g==;
Received: from [2a02:1210:321a:af00:3fa:89ae:5c22:a910] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w7b6j-0000000DBrS-0yGB;
	Tue, 31 Mar 2026 15:34:21 +0000
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
Date: Tue, 31 Mar 2026 17:33:28 +0200
Message-ID: <20260331153406.4049290-4-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260331153406.4049290-1-hch@lst.de>
References: <20260331153406.4049290-1-hch@lst.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20544-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lst.de:email,lst.de:mid]
X-Rspamd-Queue-Id: 35EDE36C006
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The only thing ->commit_blocks really needs is the new size, with a magic
-1 placeholder 0 for "do not change the size" because it only ever
extends the size.

Signed-off-by: Christoph Hellwig <hch@lst.de>
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
index a52978f6fb76..fee782a3edbe 100644
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


