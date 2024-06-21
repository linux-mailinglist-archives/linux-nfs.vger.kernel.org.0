Return-Path: <linux-nfs+bounces-4219-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B7CB912B44
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jun 2024 18:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE7841C2259C
	for <lists+linux-nfs@lfdr.de>; Fri, 21 Jun 2024 16:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C7D15FA8E;
	Fri, 21 Jun 2024 16:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJ3ZaC/Z"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FD0757F8
	for <linux-nfs@vger.kernel.org>; Fri, 21 Jun 2024 16:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718986969; cv=none; b=WIqxX+5xYdfLB/MA+0tNaPrxmV8kDwLFVCl81HoElSfQ0YiJuTwWEHC1AlLya9OLIj6YSM6uON/yEvED018j+lhwiG5kwatG0uWMQTmGKNVcFYjMemVEAmA8SEap8Kr2JC/q2LjqKnbdaapdiobnxhleN8lHjf98cRVLbSQuOuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718986969; c=relaxed/simple;
	bh=3AyN7eBGp/n6ypHxMBe6DgNA5mGNClFo9oRXpD8FlGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NBdSvoT9vrz1X19PCE3retSOz7P13lhPHzdfoHJzPTFsaXHKmcbwVrSHK4y/65vPrhOTRyrgab1QK6n7ePrVqjUCL1IbkcKAtvTubPP2QXQh0Fqx588+fFbzhaM0NNajmBw6j9XiOnRt/a2n9ROEUITLXB5KIz0xbIPWFNJfb4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJ3ZaC/Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C77C2BBFC;
	Fri, 21 Jun 2024 16:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718986969;
	bh=3AyN7eBGp/n6ypHxMBe6DgNA5mGNClFo9oRXpD8FlGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iJ3ZaC/ZXuiYKcwZszKAwQ8mFeNj5BIxMVf0S1KQGzzyFZPMvJaPjoyqYlkNYfej4
	 1QqsUPcX/1sqfXKBkAoIzDfWlWM3XH+O7QfmOdlkR6UanSzPbtvydvy4Inp86h65u3
	 MdNIYkTf8AMLbairpM0jkIRg4/fjRTz9YVhvIq+xGzszt44L2MWlPkuz3ObEqysxtL
	 Br8uHttdLfCShE5IzGbwnlBMHl9BQ50e6us3Xg45fk7A7gKIfGqmTYFVkpMVpjzSXH
	 jv1988cnBrR2HGsgs1ny/zXQvMyXZc8Gsn64a6BMVXzipOIfnaCtG8mfxagsX/aZzR
	 f60goZjOKx8yA==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [PATCH v2 4/4] nfs/blocklayout: SCSI layout trace points for reservation key reg/unreg
Date: Fri, 21 Jun 2024 12:22:32 -0400
Message-ID: <20240621162227.215412-10-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240621162227.215412-6-cel@kernel.org>
References: <20240621162227.215412-6-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7677; i=chuck.lever@oracle.com; h=from:subject; bh=NlKYBrxzhnWHDbaYiUYQu2l0Pz3FH1hQafDBlBBUiGY=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBmdajJW5zBQ1H0pr6CmxN0ujkGVzAdx5BkbUkZs DrPvMeWwpaJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZnWoyQAKCRAzarMzb2Z/ l2RDD/4vQHoyNxuncMPRbY+uuvavSeOs4d2liNP3VkmOKOB8yuP40cKve0ohGRyXOoQgeR6n5WV VeIVx7Ml3UVKe/dN2htf9etvqR/KzPFyL57Q/UBBbqG9bAVRl22jH5++78/sQxlnF6+GF4GVOtN XCDMZxlQL0AaSEdWwMYVPzyPBA345CS2hqHBkMoK52ZwvDrjUc4VMkcNJQHzQ/j+lx86+PpLZ10 zjCnr23MXvte9vbV9/Z9QK1N3BE+P25YIT0NeGgBDL8fSeZhVlZVUhVW3eyqEMM34hOXKfIN/iB ZHEZ0L5mOVXnot1UH/e058S+OcKDD+TGp1cyppOG6PdPKYiNQnuNOsX13UyrrMQ0vjTc43CNUlQ fiOhg8a2yDJSoepHBRfPgNjk5rrB7wsb1/kzXe4+ytH6eZXYoter8qyRXYneVnPiX0BydcyOxb1 WE81kdFCvTnR3i5Z0dkRhkWipNBNQR5QhGZ9yAKOWxE2SM82DRYJc/JWwvgWNkz6kvWRatlhccN WgEPe4GH6YcN+zkLncKqj+uv0338D2A7TP+OkyBDj7bZEooN6Uf80WjNEFjuvwzc1nlyFO/oWGS 1L9q+DtdjjsDaL8tdKysLhL6kwYeY4BuOJtik2AuATUw476+3ZKqgwNVfxI9TsmFAg1+NiiDSfd KWtWJVy82lhe9VQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

An administrator cannot take action on these messages, but the
reported errors might be helpful for troubleshooting. Transition
them to trace points so these events appear in the trace log and
can be easily lined up with other traced NFS client operations.

Examples:

   append_writer-6147  [000]    80.247393: bl_pr_key_reg:        device=sdb key=0x666dcdabf29514fe
   append_writer-6147  [000]    80.247842: bl_pr_key_unreg:      device=sdb key=0x666dcdabf29514fe

     umount.nfs4-6172  [002]    84.950409: bl_pr_key_unreg_err:  device=sdb key=0x666dcdabf29514fe error=24

Christoph points out that:
> ... Note that the disk_name isn't really what
> we'd want to trace anyway, as it misses the partition information.
> The normal way to print the device name is the %pg printk specifier,
> but I'm not sure how to correctly use that for tracing which wants
> a string in the entry for binary tracing.

The trace points copy the pr_info() that they are replacing, and
show only the parent device name and not the partition. I'm still
looking into how to record both parts of the device name.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/blocklayout/dev.c | 30 +++++++-------
 fs/nfs/nfs4trace.c       |  7 ++++
 fs/nfs/nfs4trace.h       | 88 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 111 insertions(+), 14 deletions(-)

diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
index 568f685dee4b..6c5d290ca81d 100644
--- a/fs/nfs/blocklayout/dev.c
+++ b/fs/nfs/blocklayout/dev.c
@@ -10,6 +10,7 @@
 #include <linux/pr.h>
 
 #include "blocklayout.h"
+#include "../nfs4trace.h"
 
 #define NFSDBG_FACILITY		NFSDBG_PNFS_LD
 
@@ -26,12 +27,14 @@ bl_free_device(struct pnfs_block_dev *dev)
 		if (test_and_clear_bit(PNFS_BDEV_REGISTERED, &dev->flags)) {
 			struct block_device *bdev = file_bdev(dev->bdev_file);
 			const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
-			int error;
+			int status;
 
-			error = ops->pr_register(file_bdev(dev->bdev_file),
-				dev->pr_key, 0, false);
-			if (error)
-				pr_err("failed to unregister PR key.\n");
+			status = ops->pr_register(bdev, dev->pr_key, 0, false);
+			if (status)
+				trace_bl_pr_key_unreg_err(bdev, dev->pr_key,
+							  status);
+			else
+				trace_bl_pr_key_unreg(bdev, dev->pr_key);
 		}
 
 		if (dev->bdev_file)
@@ -243,10 +246,10 @@ static bool bl_pr_register_scsi(struct pnfs_block_dev *dev)
 
 	status = ops->pr_register(bdev, 0, dev->pr_key, true);
 	if (status) {
-		pr_err("pNFS: failed to register key for block device %s.",
-		       bdev->bd_disk->disk_name);
+		trace_bl_pr_key_reg_err(bdev, dev->pr_key, status);
 		return false;
 	}
+	trace_bl_pr_key_reg(bdev, dev->pr_key);
 	return true;
 }
 
@@ -351,8 +354,9 @@ bl_parse_scsi(struct nfs_server *server, struct pnfs_block_dev *d,
 		struct pnfs_block_volume *volumes, int idx, gfp_t gfp_mask)
 {
 	struct pnfs_block_volume *v = &volumes[idx];
-	struct file *bdev_file;
+	struct block_device *bdev;
 	const struct pr_ops *ops;
+	struct file *bdev_file;
 	int error;
 
 	if (!bl_validate_designator(v))
@@ -373,8 +377,9 @@ bl_parse_scsi(struct nfs_server *server, struct pnfs_block_dev *d,
 		return PTR_ERR(bdev_file);
 	}
 	d->bdev_file = bdev_file;
+	bdev = file_bdev(bdev_file);
 
-	d->len = bdev_nr_bytes(file_bdev(d->bdev_file));
+	d->len = bdev_nr_bytes(bdev);
 	d->map = bl_map_simple;
 	d->pr_key = v->scsi.pr_key;
 
@@ -383,13 +388,10 @@ bl_parse_scsi(struct nfs_server *server, struct pnfs_block_dev *d,
 		goto out_blkdev_put;
 	}
 
-	pr_info("pNFS: using block device %s (reservation key 0x%llx)\n",
-		file_bdev(d->bdev_file)->bd_disk->disk_name, d->pr_key);
-
-	ops = file_bdev(d->bdev_file)->bd_disk->fops->pr_ops;
+	ops = bdev->bd_disk->fops->pr_ops;
 	if (!ops) {
 		pr_err("pNFS: block device %s does not support reservations.",
-				file_bdev(d->bdev_file)->bd_disk->disk_name);
+				bdev->bd_disk->disk_name);
 		error = -EINVAL;
 		goto out_blkdev_put;
 	}
diff --git a/fs/nfs/nfs4trace.c b/fs/nfs/nfs4trace.c
index d22c6670f770..389941ccc9c9 100644
--- a/fs/nfs/nfs4trace.c
+++ b/fs/nfs/nfs4trace.c
@@ -2,6 +2,8 @@
 /*
  * Copyright (c) 2013 Trond Myklebust <Trond.Myklebust@netapp.com>
  */
+#include <uapi/linux/pr.h>
+#include <linux/blkdev.h>
 #include <linux/nfs_fs.h>
 #include "nfs4_fs.h"
 #include "internal.h"
@@ -29,5 +31,10 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(ff_layout_read_error);
 EXPORT_TRACEPOINT_SYMBOL_GPL(ff_layout_write_error);
 EXPORT_TRACEPOINT_SYMBOL_GPL(ff_layout_commit_error);
 
+EXPORT_TRACEPOINT_SYMBOL_GPL(bl_pr_key_reg);
+EXPORT_TRACEPOINT_SYMBOL_GPL(bl_pr_key_reg_err);
+EXPORT_TRACEPOINT_SYMBOL_GPL(bl_pr_key_unreg);
+EXPORT_TRACEPOINT_SYMBOL_GPL(bl_pr_key_unreg_err);
+
 EXPORT_TRACEPOINT_SYMBOL_GPL(fl_getdevinfo);
 #endif
diff --git a/fs/nfs/nfs4trace.h b/fs/nfs/nfs4trace.h
index 4de8780a7c48..f2090a491fcb 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -2153,6 +2153,94 @@ TRACE_EVENT(ff_layout_commit_error,
 		)
 );
 
+DECLARE_EVENT_CLASS(pnfs_bl_pr_key_class,
+	TP_PROTO(
+		const struct block_device *bdev,
+		u64 key
+	),
+	TP_ARGS(bdev, key),
+	TP_STRUCT__entry(
+		__field(u64, key)
+		__field(dev_t, dev)
+		__string(device, bdev->bd_disk->disk_name)
+	),
+	TP_fast_assign(
+		__entry->key = key;
+		__entry->dev = bdev->bd_dev;   
+		__assign_str(device);
+	),
+	TP_printk("dev=%d,%d (%s) key=0x%016llx",
+		MAJOR(__entry->dev), MINOR(__entry->dev),
+		__get_str(device), __entry->key
+	)
+);
+
+#define DEFINE_NFS4_BLOCK_PRKEY_EVENT(name) \
+	DEFINE_EVENT(pnfs_bl_pr_key_class, name, \
+		TP_PROTO( \
+			const struct block_device *bdev, \
+			u64 key \
+		), \
+		TP_ARGS(bdev, key))
+DEFINE_NFS4_BLOCK_PRKEY_EVENT(bl_pr_key_reg);
+DEFINE_NFS4_BLOCK_PRKEY_EVENT(bl_pr_key_unreg);
+
+/*
+ * From uapi/linux/pr.h
+ */
+TRACE_DEFINE_ENUM(PR_STS_SUCCESS);
+TRACE_DEFINE_ENUM(PR_STS_IOERR);
+TRACE_DEFINE_ENUM(PR_STS_RESERVATION_CONFLICT);
+TRACE_DEFINE_ENUM(PR_STS_RETRY_PATH_FAILURE);
+TRACE_DEFINE_ENUM(PR_STS_PATH_FAST_FAILED);
+TRACE_DEFINE_ENUM(PR_STS_PATH_FAILED);
+
+#define show_pr_status(x) \
+	__print_symbolic(x, \
+		{ PR_STS_SUCCESS,		"SUCCESS" }, \
+		{ PR_STS_IOERR,			"IOERR" }, \
+		{ PR_STS_RESERVATION_CONFLICT,	"RESERVATION_CONFLICT" }, \
+		{ PR_STS_RETRY_PATH_FAILURE,	"RETRY_PATH_FAILURE" }, \
+		{ PR_STS_PATH_FAST_FAILED,	"PATH_FAST_FAILED" }, \
+		{ PR_STS_PATH_FAILED,		"PATH_FAILED" })
+
+DECLARE_EVENT_CLASS(pnfs_bl_pr_key_err_class,
+	TP_PROTO(
+		const struct block_device *bdev,
+		u64 key,
+		int status
+	),
+	TP_ARGS(bdev, key, status),
+	TP_STRUCT__entry(
+		__field(u64, key)
+		__field(dev_t, dev)
+		__field(unsigned long, status)
+		__string(device, bdev->bd_disk->disk_name)
+	),
+	TP_fast_assign(
+		__entry->key = key;
+		__entry->dev = bdev->bd_dev;   
+		__entry->status = status;
+		__assign_str(device);
+	),
+	TP_printk("dev=%d,%d (%s) key=0x%016llx status=%s",
+		MAJOR(__entry->dev), MINOR(__entry->dev),
+		__get_str(device), __entry->key,
+		show_pr_status(__entry->status)
+	)
+);
+
+#define DEFINE_NFS4_BLOCK_PRKEY_ERR_EVENT(name) \
+	DEFINE_EVENT(pnfs_bl_pr_key_err_class, name, \
+		TP_PROTO( \
+			const struct block_device *bdev, \
+			u64 key, \
+			int status \
+		), \
+		TP_ARGS(bdev, key, status))
+DEFINE_NFS4_BLOCK_PRKEY_ERR_EVENT(bl_pr_key_reg_err);
+DEFINE_NFS4_BLOCK_PRKEY_ERR_EVENT(bl_pr_key_unreg_err);
+
 #ifdef CONFIG_NFS_V4_2
 TRACE_DEFINE_ENUM(NFS4_CONTENT_DATA);
 TRACE_DEFINE_ENUM(NFS4_CONTENT_HOLE);
-- 
2.45.1


