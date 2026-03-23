Return-Path: <linux-nfs+bounces-20324-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEhoJPnnwGl6OQQAu9opvQ
	(envelope-from <linux-nfs+bounces-20324-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Mar 2026 08:12:57 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A5662ED58D
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Mar 2026 08:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F19E9305541D
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Mar 2026 07:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AF035C1A9;
	Mon, 23 Mar 2026 07:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kY+e48ZA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10ED035C19B;
	Mon, 23 Mar 2026 07:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774249702; cv=none; b=lhDmzczFrmfQwOoPMSvqn40QPekancfcCnl2Re27ULCd8YaN7Wgn6hLHISteXJLbjxjvhu2EhUZTxuziVPz15bV5SC2SP7HDP5lICvrvsRh48HgKGxtGFjECZhyEVwlixbbOgfPJK5cIDFAcWCW2QNPzvnZmON9qwNoC0SspY7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774249702; c=relaxed/simple;
	bh=n5xKGw8WD2zj/khCewepaQK7VioflZwjkTjh7eJ+T8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bPrVZ1ZIdZCkk3NZ1ijA0KxCLWL1hTxYLkqFSRrntYkqk/ReXu2PAEqxNhpzsQo3BT+agunIzfNY8P2dOU5hcKLqkt0f551oVtIFP7a3ao/89eZKfJogqaEhyTtJ7PhFkVN3gGhx+6uJV5n09vL0QTb4rKIaHKnr/nRj1MGex4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kY+e48ZA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=tVV8E7wtjx/XpOUTolRjebeXMWZfB4BxOVquG75PLaY=; b=kY+e48ZAzRJHKuElYUhrwf1AkV
	R1/CXu9bEKkoQN5Ibtw6988+As4aaXUaEa+rLUW2XXuVqLbIjVHBnpVAdBZx/gnAaFQ7+/UuQH2YJ
	AolstvoMlqHwUI2eh0h4rLx4hbAZ40VbbFiP6xPoSyopg9wfsuYh7wzMkA9nFpQb2WcfjlhLD3Vbr
	P/fff7pui2AFNBPs2CjpmDhpSjh9L+v5fVOuGsaLoe/Mz0Op9u1QyZ8GldN6WpxKT7A6QbkKGCbUu
	DMqjFDw3rsq6byiYuUvUlBA+kjgEI/K8XKMYcLy6pc1QwG0Kz2I9opRDTKqlDAsC2usksXoJ1pNrf
	UmxE+2CA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4ZOd-0000000GAOe-17LK;
	Mon, 23 Mar 2026 07:08:19 +0000
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>
Cc: NeilBrown <neil@brown.name>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Carlos Maiolino <cem@kernel.org>,
	linux-nfs@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 6/7] exportfs: return a device index from ->map_blocks
Date: Mon, 23 Mar 2026 08:07:22 +0100
Message-ID: <20260323070746.2940140-7-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260323070746.2940140-1-hch@lst.de>
References: <20260323070746.2940140-1-hch@lst.de>
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
	TAGGED_FROM(0.00)[bounces-20324-lists,linux-nfs=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lst.de:email,lst.de:mid]
X-Rspamd-Queue-Id: 0A5662ED58D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Allow file systems to return a device index from ->map_block that
indicates which device the layout is placed on.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfsd/blocklayout.c          | 7 +++++--
 fs/xfs/xfs_pnfs.c              | 3 +++
 include/linux/exportfs_block.h | 2 +-
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index fb13f86f8eb5..636ccefe1959 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -30,10 +30,12 @@ nfsd4_block_map_extent(struct inode *inode, const struct svc_fh *fhp,
 	struct super_block *sb = inode->i_sb;
 	struct iomap iomap;
 	u32 device_generation = 0;
+	u32 dev_idx = 0;
 	int error;
 
 	error = sb->s_export_op->block_ops->map_blocks(inode, offset, length,
-			&iomap, iomode != IOMODE_READ, &device_generation);
+			&iomap, iomode != IOMODE_READ, &dev_idx,
+			&device_generation);
 	if (error) {
 		if (error == -ENXIO)
 			return nfserr_layoutunavailable;
@@ -75,7 +77,8 @@ nfsd4_block_map_extent(struct inode *inode, const struct svc_fh *fhp,
 		return nfserr_layoutunavailable;
 	}
 
-	error = nfsd4_set_deviceid(&bex->vol_id, fhp, 0, device_generation);
+	error = nfsd4_set_deviceid(&bex->vol_id, fhp, dev_idx,
+			device_generation);
 	if (error)
 		return nfserrno(error);
 
diff --git a/fs/xfs/xfs_pnfs.c b/fs/xfs/xfs_pnfs.c
index acefa0b99f53..7ef5a3f522f6 100644
--- a/fs/xfs/xfs_pnfs.c
+++ b/fs/xfs/xfs_pnfs.c
@@ -123,6 +123,7 @@ xfs_fs_map_blocks(
 	u64			length,
 	struct iomap		*iomap,
 	bool			write,
+	u32			*dev_idx,
 	u32			*device_generation)
 {
 	struct xfs_inode	*ip = XFS_I(inode);
@@ -139,6 +140,8 @@ xfs_fs_map_blocks(
 	if (xfs_is_shutdown(mp))
 		return -EIO;
 
+	*dev_idx = 0;
+
 	/*
 	 * We can't export inodes residing on the realtime device.  The realtime
 	 * device doesn't have a UUID to identify it, so the client has no way
diff --git a/include/linux/exportfs_block.h b/include/linux/exportfs_block.h
index a3f4054784e3..ec2f846c6b08 100644
--- a/include/linux/exportfs_block.h
+++ b/include/linux/exportfs_block.h
@@ -52,7 +52,7 @@ struct exportfs_block_ops {
 	 * If @write is %true, also allocate the blocks for the range if needed.
 	 */
 	int (*map_blocks)(struct inode *inode, loff_t offset, u64 len,
-			struct iomap *iomap, bool write,
+			struct iomap *iomap, bool write, u32 *dev_idx,
 			u32 *device_generation);
 
 	/*
-- 
2.47.3


