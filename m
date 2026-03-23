Return-Path: <linux-nfs+bounces-20325-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +H1qLh3owGl6OQQAu9opvQ
	(envelope-from <linux-nfs+bounces-20325-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Mar 2026 08:13:33 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC482ED5A3
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Mar 2026 08:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B25A30580AC
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Mar 2026 07:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A438935C1A9;
	Mon, 23 Mar 2026 07:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EBhNuuuj"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE093164B4;
	Mon, 23 Mar 2026 07:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774249706; cv=none; b=slce4T9N9h7ckwqzDL204B75sZeoQQcLCUwDq9+UE0VAhcpTwonBWCQ0VwUKwD+mtVz9zLU3FC61UxnSBCJ6cbUjpkaZrmTEVGpGmAZKUGbxT7R4ycAdJxPJJZXSL0M4S8urw8AuEcJbF+6TvO/JjO9C3l0hNRHXcnqfjA9iQ7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774249706; c=relaxed/simple;
	bh=b5H6rGg7KTDY88xyeoYwaPykyXe8L7fhpxqV5pnIvV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tN8ntnG5Qc7e0pSgG3oS/U23qFQ57tN+9YmYIbXjTW+rfhno5KbEOxBlSZWMbaZSiJVqvBUDbPXrsPJT9tgf2yjZzQi90njt9FM5scjW0oFjXsSyEKIDfPEYCbDBw0OJUXrKTG2JKUhx8Rk+x9PzxUVvtqBam/OhODQF5S+gTmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EBhNuuuj; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=2p71K9zD5jK+uztJJdRlOmmEO5Wzpgg6K0aep2V2aq8=; b=EBhNuuujCRUxVyw8dqPiD/ONAi
	paLcwWGDUCuUsdSsfPVLp3I46w1T1ygOstlztevOAQu2d23lEn6EBSu6y+RnY5eNIgVA+IE/wuJ7Z
	Iu5R1kTNnJFOWpbnsu5ELUm8pc+VJd2JeYNl+o2EcSLV3QOu1Yzfe6DXfnFERCjyMHSQwlXXfMTXT
	gnoQQZoAx27LW2l2mqR2Udkyh9SsKWejRRpBbkE8WXgy9+D+8fO8tzv2hVsjVBKub4RTXN4iQ2Qy6
	6BWBZ0RdYokJOjiJN9i0moonQqyRt91LShUnUnBHbyp80a+/kkwKQ867V6FSaIMcWh/2U+r+R4eW5
	ah4BWnnA==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4ZOh-0000000GAPD-1fQe;
	Mon, 23 Mar 2026 07:08:23 +0000
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
Subject: [PATCH 7/7] xfs: support layout-based block device access on the RT device
Date: Mon, 23 Mar 2026 08:07:23 +0100
Message-ID: <20260323070746.2940140-8-hch@lst.de>
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
	TAGGED_FROM(0.00)[bounces-20325-lists,linux-nfs=lfdr.de];
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
X-Rspamd-Queue-Id: 2BC482ED5A3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement the devid_to_bdev method so that device index one can be
used for the RT device, and allow block-style layouts on the
conventional RT device.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_pnfs.c | 52 ++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 40 insertions(+), 12 deletions(-)

diff --git a/fs/xfs/xfs_pnfs.c b/fs/xfs/xfs_pnfs.c
index 7ef5a3f522f6..4302df26bfc2 100644
--- a/fs/xfs/xfs_pnfs.c
+++ b/fs/xfs/xfs_pnfs.c
@@ -46,17 +46,50 @@ xfs_break_leased_layouts(
 	return error;
 }
 
+/*
+ * Check what layouts we support for direct block device access.
+ */
 static expfs_block_layouts_t
 xfs_fs_layouts_supported(
 	struct super_block	*sb)
 {
-	expfs_block_layouts_t	supported = EXPFS_BLOCK_IN_BAND_ID;
+	struct xfs_mount	*mp = XFS_M(sb);
+	expfs_block_layouts_t	supported = 0;
 
-	if (exportfs_bdev_supports_out_of_band_id(sb->s_bdev))
+	/*
+	 * We don't have a good way to identify a specific RT device.  And
+	 * there's really no point in trying hard just for the deprecated
+	 * block layout support.
+	 */
+	if (!xfs_has_realtime(mp))
+		supported |= EXPFS_BLOCK_IN_BAND_ID;
+
+	if (exportfs_bdev_supports_out_of_band_id(sb->s_bdev) ||
+	    (mp->m_rtdev_targp &&
+	     exportfs_bdev_supports_out_of_band_id(mp->m_rtdev_targp->bt_bdev)))
 		supported |= EXPFS_BLOCK_OUT_OF_BAND_ID;
 	return supported;
 }
 
+static struct block_device *
+xfs_fs_devid_to_bdev(
+	struct super_block	*sb,
+	u32			dev_idx)
+{
+	struct xfs_mount	*mp = XFS_M(sb);
+
+	switch (dev_idx) {
+	case 0:
+		return sb->s_bdev;
+	case 1:
+		if (mp->m_rtdev_targp && mp->m_rtdev_targp->bt_bdev)
+			return mp->m_rtdev_targp->bt_bdev;
+		fallthrough;
+	default:
+		return ERR_PTR(-EINVAL);
+	}
+}
+
 /*
  * Get a unique ID including its location so that the client can identify
  * the exported device.
@@ -141,20 +174,14 @@ xfs_fs_map_blocks(
 		return -EIO;
 
 	*dev_idx = 0;
-
-	/*
-	 * We can't export inodes residing on the realtime device.  The realtime
-	 * device doesn't have a UUID to identify it, so the client has no way
-	 * to find it.
-	 */
 	if (XFS_IS_REALTIME_INODE(ip))
-		return -ENXIO;
+		*dev_idx = 1;
 
 	/*
-	 * The pNFS block layout spec actually supports reflink like
-	 * functionality, but the Linux pNFS server doesn't implement it yet.
+	 * The pNFS block layout spec supports out of place writes, but the
+	 * Linux pNFS server doesn't implement it yet.
 	 */
-	if (xfs_is_reflink_inode(ip))
+	if (xfs_is_cow_inode(ip))
 		return -ENXIO;
 
 	/*
@@ -351,6 +378,7 @@ xfs_fs_commit_blocks(
 
 struct exportfs_block_ops xfs_export_block_ops = {
 	.layouts_supported	= xfs_fs_layouts_supported,
+	.devid_to_bdev		= xfs_fs_devid_to_bdev,
 	.get_uuid		= xfs_fs_get_uuid,
 	.map_blocks		= xfs_fs_map_blocks,
 	.commit_blocks		= xfs_fs_commit_blocks,
-- 
2.47.3


