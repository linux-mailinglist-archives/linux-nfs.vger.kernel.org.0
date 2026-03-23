Return-Path: <linux-nfs+bounces-20323-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALqdNNPnwGl6OQQAu9opvQ
	(envelope-from <linux-nfs+bounces-20323-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Mar 2026 08:12:19 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA852ED56E
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Mar 2026 08:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF1363041BD2
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Mar 2026 07:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E5035C183;
	Mon, 23 Mar 2026 07:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="a/HXUHJf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EDD3164B4;
	Mon, 23 Mar 2026 07:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774249697; cv=none; b=pst6ND29GtBxYMf30iDcLoQYp7Ydya1wRZNHZcm9jhxTQASfGCwemuekW6Sz2LgUIzOQHcEPw3N9r7lO5HindzLP6G8AV3U+I7fzkBPxro4J47HWaNTDzeAAQDEnNfZsYoZfwIOS2W2t3QszF6kHZkdcg1VHUBWYVrk4bRTtENA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774249697; c=relaxed/simple;
	bh=VqTCC1Medgj+r27TQtKFXrTnVV4aByXyqGGhbALnEmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SVyOQB2efehz/zS+FUjqxf9qt7+5bWUK7spd7/vqRjtdY2LzCoBNcqacnTtE5giaJeIuiI3ok1FL+37DqFCXK/DCLgxaFnZmiXm0MYhivc8M2Zdk/Aj0iEKcLO9KMhGtpQMFBOJpvwM5LPhzQZH3v2Gt5Ru0GbhwCpU/M+DJ5pM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=a/HXUHJf; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=4APfKCzfPoDgo8c0s+ij1gGatRY9AAuMmL1NQQJYdRY=; b=a/HXUHJfvPsRdDs0tS3XA0lKAZ
	6jyXSOxW6SI3EIhYmtIplGl/SZa2YR8eBisAeGs3jjuW3QhRofvi3tiFkTaaN5wjqackqtCOB3QYs
	b5L8zb67wgSSMUcvw4OsaQmQ7tHZh7mIdgilTq2tf0k23iN5P8CEfn4444eIev4/puBn12CVrieLX
	ZFJmHkviQnz/2uS6QwYbaaX4Kw54D771H2nNWK/92ACNz/4CmJrq7I2HxjFP2NnbYmUIbtUJjvlUn
	EKXTOtGxlApyWf18+FeUSKz/GYEu3r2Yw8N7iqdCihzN4Maqw//+J99NUwhN1VgO8/vayfcDg5ph/
	cJPqogEQ==;
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4ZOY-0000000GANL-2tzm;
	Mon, 23 Mar 2026 07:08:15 +0000
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
Subject: [PATCH 5/7] nfsd/blocklayout: support GETDEVICEINFO for multiple devices
Date: Mon, 23 Mar 2026 08:07:21 +0100
Message-ID: <20260323070746.2940140-6-hch@lst.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20323-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[oracle.com,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[infradead.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 3CA852ED56E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a method to return the block_device for the given device index,
and use that in nfsd4_scsi_proc_getdeviceinfo to support multiple
devices for the SCSI layout.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfsd/blocklayout.c          | 41 +++++++++++++++++++++-------------
 include/linux/exportfs_block.h |  6 +++++
 2 files changed, 31 insertions(+), 16 deletions(-)

diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index 8ca8fd8f70cb..fb13f86f8eb5 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -303,15 +303,19 @@ nfsd4_block_get_unique_id(struct gendisk *disk, struct pnfs_block_volume *b)
 }
 
 static int
-nfsd4_block_get_device_info_scsi(struct super_block *sb,
-		struct nfs4_client *clp,
-		struct nfsd4_getdeviceinfo *gdp)
+nfsd4_block_get_device_info_scsi(struct block_device *bdev,
+		struct nfs4_client *clp, struct nfsd4_getdeviceinfo *gdp)
 {
 	struct pnfs_block_deviceaddr *dev;
 	struct pnfs_block_volume *b;
 	const struct pr_ops *ops;
 	int ret;
 
+	if (bdev_is_partition(bdev))
+		return -EINVAL;
+	if (!exportfs_bdev_supports_out_of_band_id(bdev))
+		return -EINVAL;
+
 	dev = kzalloc_flex(*dev, volumes, 1);
 	if (!dev)
 		return -ENOMEM;
@@ -323,30 +327,28 @@ nfsd4_block_get_device_info_scsi(struct super_block *sb,
 	b->type = PNFS_BLOCK_VOLUME_SCSI;
 	b->scsi.pr_key = nfsd4_scsi_pr_key(clp);
 
-	ret = nfsd4_block_get_unique_id(sb->s_bdev->bd_disk, b);
+	ret = nfsd4_block_get_unique_id(bdev->bd_disk, b);
 	if (ret < 0)
 		goto out_free_dev;
 
 	ret = -EINVAL;
-	ops = sb->s_bdev->bd_disk->fops->pr_ops;
+	ops = bdev->bd_disk->fops->pr_ops;
 	if (!ops) {
-		pr_err("pNFS: device %s does not support PRs.\n",
-			sb->s_id);
+		pr_err("pNFS: device %pg does not support persistent reservations.\n",
+			bdev);
 		goto out_free_dev;
 	}
 
-	ret = ops->pr_register(sb->s_bdev, 0, NFSD_MDS_PR_KEY, true);
+	ret = ops->pr_register(bdev, 0, NFSD_MDS_PR_KEY, true);
 	if (ret) {
-		pr_err("pNFS: failed to register key for device %s.\n",
-			sb->s_id);
+		pr_err("pNFS: failed to register key for device %pg.\n", bdev);
 		goto out_free_dev;
 	}
 
-	ret = ops->pr_reserve(sb->s_bdev, NFSD_MDS_PR_KEY,
+	ret = ops->pr_reserve(bdev, NFSD_MDS_PR_KEY,
 			PR_EXCLUSIVE_ACCESS_REG_ONLY, 0);
 	if (ret) {
-		pr_err("pNFS: failed to reserve device %s.\n",
-			sb->s_id);
+		pr_err("pNFS: failed to reserve device %pd.\n", bdev);
 		goto out_free_dev;
 	}
 
@@ -364,9 +366,16 @@ nfsd4_scsi_proc_getdeviceinfo(struct super_block *sb,
 		struct nfs4_client *clp,
 		struct nfsd4_getdeviceinfo *gdp)
 {
-	if (bdev_is_partition(sb->s_bdev))
-		return nfserr_inval;
-	return nfserrno(nfsd4_block_get_device_info_scsi(sb, clp, gdp));
+	struct block_device *bdev = sb->s_bdev;
+
+	if (sb->s_export_op->block_ops->devid_to_bdev) {
+		bdev = sb->s_export_op->block_ops->devid_to_bdev(sb,
+					gdp->gd_devid.dev_idx);
+		if (IS_ERR(bdev))
+			return nfserrno(PTR_ERR(bdev));
+	}
+
+	return nfserrno(nfsd4_block_get_device_info_scsi(bdev, clp, gdp));
 }
 static __be32
 nfsd4_scsi_proc_layoutcommit(struct inode *inode, struct svc_rqst *rqstp,
diff --git a/include/linux/exportfs_block.h b/include/linux/exportfs_block.h
index 8d5b0b0c5a82..a3f4054784e3 100644
--- a/include/linux/exportfs_block.h
+++ b/include/linux/exportfs_block.h
@@ -36,6 +36,12 @@ struct exportfs_block_ops {
 	 */
 	expfs_block_layouts_t (*layouts_supported)(struct super_block *sb);
 
+	/*
+	 * Map from an unsigned integer device index to a block device.
+	 */
+	struct block_device *(*devid_to_bdev)(struct super_block *sb,
+			u32 dev_idx);
+
 	/*
 	 * Get the in-band device unique signature exposed to clients.
 	 */
-- 
2.47.3


