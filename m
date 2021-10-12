Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33AA542A3F0
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Oct 2021 14:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236307AbhJLMK5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 Oct 2021 08:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbhJLMK5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 Oct 2021 08:10:57 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DB2C061570;
        Tue, 12 Oct 2021 05:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=tMAeaqhAZCQX95qSfgnscJSXeihZM6Blo1FBRwBYCkY=; b=MwXZGnbq2MAcnflfNLflg01wHU
        3KEQ/5dUbtpr0DVY+rnySqI0xvqAJmiMbhZLpOYoeWFE0HxPWHSLFSVU+qemTge6GJtcbXW9CuPKK
        5VJYOWqYhLARj0aWRnoEFIcTbvcYV/nzHtSF9PW6ri4TWZZqPJaEv5BZcU8lSMDQh0YMysnJcIEK5
        UDhdyRIDNL0lmRtYz5NmuV1Z4+ji7znBKasoZVHXyeaC9IAZ6IFW2tKCpp/7YghcJ0D4jm2eR0TmL
        SO6Gx73f+tVFCd8dh4mkjwWjkg80CD0FsmtSbzRFd6s8ODO20XJoER5sPr+aVoaCU4lYDlIrM1aFG
        HqJ9qhpw==;
Received: from [2001:4bb8:199:73c5:f5ed:58c2:719f:d965] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maGZL-006TtY-AN; Tue, 12 Oct 2021 12:07:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH 3/7] nfsd/blocklayout: use ->get_unique_id instead of sending SCSI commands
Date:   Tue, 12 Oct 2021 14:04:41 +0200
Message-Id: <20211012120445.861860-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012120445.861860-1-hch@lst.de>
References: <20211012120445.861860-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Call the ->get_unique_id method to query the SCSI identifiers.  This can
use the cached VPD page in the sd driver instead of sending a command
on every LAYOUTGET.  It will also allow to support NVMe based volumes
if the draft for that ever takes off.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfsd/Kconfig       |   1 -
 fs/nfsd/blocklayout.c | 158 +++++++++++-------------------------------
 fs/nfsd/nfs4layouts.c |   5 +-
 3 files changed, 44 insertions(+), 120 deletions(-)

diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
index 6e9ea4ee0f737..3d1d17256a91c 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -109,7 +109,6 @@ config NFSD_SCSILAYOUT
 	depends on NFSD_V4 && BLOCK
 	select NFSD_PNFS
 	select EXPORTFS_BLOCK_OPS
-	select SCSI_COMMON
 	help
 	  This option enables support for the exporting pNFS SCSI layouts
 	  in the kernel's NFS server. The pNFS SCSI layout enables NFS
diff --git a/fs/nfsd/blocklayout.c b/fs/nfsd/blocklayout.c
index c99dee99a3c15..e5c0982a381de 100644
--- a/fs/nfsd/blocklayout.c
+++ b/fs/nfsd/blocklayout.c
@@ -9,9 +9,6 @@
 #include <linux/pr.h>
 
 #include <linux/nfsd/debug.h>
-#include <scsi/scsi_proto.h>
-#include <scsi/scsi_common.h>
-#include <scsi/scsi_request.h>
 
 #include "blocklayoutxdr.h"
 #include "pnfs.h"
@@ -211,109 +208,6 @@ const struct nfsd4_layout_ops bl_layout_ops = {
 #endif /* CONFIG_NFSD_BLOCKLAYOUT */
 
 #ifdef CONFIG_NFSD_SCSILAYOUT
-static int nfsd4_scsi_identify_device(struct block_device *bdev,
-		struct pnfs_block_volume *b)
-{
-	struct request_queue *q = bdev->bd_disk->queue;
-	struct request *rq;
-	struct scsi_request *req;
-	/*
-	 * The allocation length (passed in bytes 3 and 4 of the INQUIRY
-	 * command descriptor block) specifies the number of bytes that have
-	 * been allocated for the data-in buffer.
-	 * 252 is the highest one-byte value that is a multiple of 4.
-	 * 65532 is the highest two-byte value that is a multiple of 4.
-	 */
-	size_t bufflen = 252, maxlen = 65532, len, id_len;
-	u8 *buf, *d, type, assoc;
-	int retries = 1, error;
-
-	if (WARN_ON_ONCE(!blk_queue_scsi_passthrough(q)))
-		return -EINVAL;
-
-again:
-	buf = kzalloc(bufflen, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	rq = blk_get_request(q, REQ_OP_DRV_IN, 0);
-	if (IS_ERR(rq)) {
-		error = -ENOMEM;
-		goto out_free_buf;
-	}
-	req = scsi_req(rq);
-
-	error = blk_rq_map_kern(q, rq, buf, bufflen, GFP_KERNEL);
-	if (error)
-		goto out_put_request;
-
-	req->cmd[0] = INQUIRY;
-	req->cmd[1] = 1;
-	req->cmd[2] = 0x83;
-	req->cmd[3] = bufflen >> 8;
-	req->cmd[4] = bufflen & 0xff;
-	req->cmd_len = COMMAND_SIZE(INQUIRY);
-
-	blk_execute_rq(NULL, rq, 1);
-	if (req->result) {
-		pr_err("pNFS: INQUIRY 0x83 failed with: %x\n",
-			req->result);
-		error = -EIO;
-		goto out_put_request;
-	}
-
-	len = (buf[2] << 8) + buf[3] + 4;
-	if (len > bufflen) {
-		if (len <= maxlen && retries--) {
-			blk_put_request(rq);
-			kfree(buf);
-			bufflen = len;
-			goto again;
-		}
-		pr_err("pNFS: INQUIRY 0x83 response invalid (len = %zd)\n",
-			len);
-		goto out_put_request;
-	}
-
-	d = buf + 4;
-	for (d = buf + 4; d < buf + len; d += id_len + 4) {
-		id_len = d[3];
-		type = d[1] & 0xf;
-		assoc = (d[1] >> 4) & 0x3;
-
-		/*
-		 * We only care about a EUI-64 and NAA designator types
-		 * with LU association.
-		 */
-		if (assoc != 0x00)
-			continue;
-		if (type != 0x02 && type != 0x03)
-			continue;
-		if (id_len != 8 && id_len != 12 && id_len != 16)
-			continue;
-
-		b->scsi.code_set = PS_CODE_SET_BINARY;
-		b->scsi.designator_type = type == 0x02 ?
-			PS_DESIGNATOR_EUI64 : PS_DESIGNATOR_NAA;
-		b->scsi.designator_len = id_len;
-		memcpy(b->scsi.designator, d + 4, id_len);
-
-		/*
-		 * If we found a 8 or 12 byte descriptor continue on to
-		 * see if a 16 byte one is available.  If we find a
-		 * 16 byte descriptor we're done.
-		 */
-		if (id_len == 16)
-			break;
-	}
-
-out_put_request:
-	blk_put_request(rq);
-out_free_buf:
-	kfree(buf);
-	return error;
-}
-
 #define NFSD_MDS_PR_KEY		0x0100000000000000ULL
 
 /*
@@ -325,6 +219,31 @@ static u64 nfsd4_scsi_pr_key(struct nfs4_client *clp)
 	return ((u64)clp->cl_clientid.cl_boot << 32) | clp->cl_clientid.cl_id;
 }
 
+static const u8 designator_types[] = {
+	PS_DESIGNATOR_EUI64,
+	PS_DESIGNATOR_NAA,
+};
+
+static int
+nfsd4_block_get_unique_id(struct gendisk *disk, struct pnfs_block_volume *b)
+{
+	int ret, i;
+
+	for (i = 0; i < ARRAY_SIZE(designator_types); i++) {
+		u8 type = designator_types[i];
+
+		ret = disk->fops->get_unique_id(disk, b->scsi.designator, type);
+		if (ret > 0) {
+			b->scsi.code_set = PS_CODE_SET_BINARY;
+			b->scsi.designator_type = type;
+			b->scsi.designator_len = ret;
+			return 0;
+		}
+	}
+
+	return -EINVAL;
+}
+
 static int
 nfsd4_block_get_device_info_scsi(struct super_block *sb,
 		struct nfs4_client *clp,
@@ -333,7 +252,7 @@ nfsd4_block_get_device_info_scsi(struct super_block *sb,
 	struct pnfs_block_deviceaddr *dev;
 	struct pnfs_block_volume *b;
 	const struct pr_ops *ops;
-	int error;
+	int ret;
 
 	dev = kzalloc(sizeof(struct pnfs_block_deviceaddr) +
 		      sizeof(struct pnfs_block_volume), GFP_KERNEL);
@@ -347,33 +266,38 @@ nfsd4_block_get_device_info_scsi(struct super_block *sb,
 	b->type = PNFS_BLOCK_VOLUME_SCSI;
 	b->scsi.pr_key = nfsd4_scsi_pr_key(clp);
 
-	error = nfsd4_scsi_identify_device(sb->s_bdev, b);
-	if (error)
-		return error;
+	ret = nfsd4_block_get_unique_id(sb->s_bdev->bd_disk, b);
+	if (ret < 0)
+		goto out_free_dev;
 
+	ret = -EINVAL;
 	ops = sb->s_bdev->bd_disk->fops->pr_ops;
 	if (!ops) {
 		pr_err("pNFS: device %s does not support PRs.\n",
 			sb->s_id);
-		return -EINVAL;
+		goto out_free_dev;
 	}
 
-	error = ops->pr_register(sb->s_bdev, 0, NFSD_MDS_PR_KEY, true);
-	if (error) {
+	ret = ops->pr_register(sb->s_bdev, 0, NFSD_MDS_PR_KEY, true);
+	if (ret) {
 		pr_err("pNFS: failed to register key for device %s.\n",
 			sb->s_id);
-		return -EINVAL;
+		goto out_free_dev;
 	}
 
-	error = ops->pr_reserve(sb->s_bdev, NFSD_MDS_PR_KEY,
+	ret = ops->pr_reserve(sb->s_bdev, NFSD_MDS_PR_KEY,
 			PR_EXCLUSIVE_ACCESS_REG_ONLY, 0);
-	if (error) {
+	if (ret) {
 		pr_err("pNFS: failed to reserve device %s.\n",
 			sb->s_id);
-		return -EINVAL;
+		goto out_free_dev;
 	}
 
 	return 0;
+
+out_free_dev:
+	kfree(dev);
+	return ret;
 }
 
 static __be32
diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
index a97873f2d22b0..6d1b5bb051c56 100644
--- a/fs/nfsd/nfs4layouts.c
+++ b/fs/nfsd/nfs4layouts.c
@@ -145,8 +145,9 @@ void nfsd4_setup_layout_type(struct svc_export *exp)
 #ifdef CONFIG_NFSD_SCSILAYOUT
 	if (sb->s_export_op->map_blocks &&
 	    sb->s_export_op->commit_blocks &&
-	    sb->s_bdev && sb->s_bdev->bd_disk->fops->pr_ops &&
-		blk_queue_scsi_passthrough(sb->s_bdev->bd_disk->queue))
+	    sb->s_bdev &&
+	    sb->s_bdev->bd_disk->fops->pr_ops &&
+	    sb->s_bdev->bd_disk->fops->get_unique_id)
 		exp->ex_layout_types |= 1 << LAYOUT_SCSI;
 #endif
 }
-- 
2.30.2

