Return-Path: <linux-nfs+bounces-4306-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAD291721E
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jun 2024 22:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 640622889EF
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jun 2024 20:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3645817E46D;
	Tue, 25 Jun 2024 20:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FoANmJrB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1175917E465
	for <linux-nfs@vger.kernel.org>; Tue, 25 Jun 2024 20:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719345741; cv=none; b=GnEoxZ+x7tzEKwAcRjMu1VQfqD/Yze1j2kekORwoZO4dvw1vm44wSCUNYk9Sjw8bMGOeQYM8eLQi7WVmRVjd0t9bxCBnSroaWg6RpHfNn29DinlPkAXcc/TBMGjze/qirpJouctJ3KlktTwE07X2nsKcyWto5HHssFosqbV6ZVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719345741; c=relaxed/simple;
	bh=EAaIHlUIwTFb5CHbZWEXJEdyeqA+wEA0ROyhdt1uI5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uVJ8uVOaPjVSqXK/5s0mGMbEOtqBsztwUtFHIrc8ZRwukZc9gfUXsTqtFWhr9KqcU+4B7+oJ5GMb9z0xwewiFyIxueAd/y/XFjN0KKEE2sHB2CGsTHgT4+m56Kjwx1356Io0t6GlWzpArLMrCO2eoawEI9+h+NNlkHhbUna8yvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FoANmJrB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40962C32782;
	Tue, 25 Jun 2024 20:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719345740;
	bh=EAaIHlUIwTFb5CHbZWEXJEdyeqA+wEA0ROyhdt1uI5o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FoANmJrBBJI9LlYnPZv0OJfmoych7WZ+MLw08QmnEHVT8NC2v+nARMiDSLGpUwJAL
	 CSIpDy2Eg9x0bz01IPE4jfr8b6jC7hgtI2tyLB+o0eFnsaH5y1aq1XpK0snWDdJJL8
	 xBcBBqId/wC/RLTNzTQHrO7IM1eeQkhnmx9pcUBxUG1c1FMCOanUh9ZlqEXfzlTqzj
	 8XO0k5gi5u05T5ZGSFMuJQpOEL/zRTYiIFinZHFyMq8dG49PWIwyikEhBl8F/5RTc+
	 p6NXHehtRjhtTBvPFKdrs6GjkogW6SYJ+r5TNPQkoGAs6Iq8Ydt1Kbw+a0viu//Mhp
	 UuQVW1oRiqQgA==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>,
	Benjamin Coddington <bcodding@redhat.com>
Subject: [PATCH v3 3/3] nfs/blocklayout: SCSI layout trace points for reservation key reg/unreg
Date: Tue, 25 Jun 2024 16:02:08 -0400
Message-ID: <20240625200204.276770-8-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240625200204.276770-5-cel@kernel.org>
References: <20240625200204.276770-5-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7234; i=chuck.lever@oracle.com; h=from:subject; bh=sNUeZwjSUztiv1v3e0awYykOAMbyowzM4UaXe2ccEiM=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBmeyJCVkGHYIei9dCcAjdMTxp4Is0cf4SPAFV66 lR5YEJF5uKJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZnsiQgAKCRAzarMzb2Z/ lwCwD/4lj1qGK6YOKs9v4EoTnbRWVP8rD7lip+ka6sa5NCKNnAlEJxiTimWs+Q0knfroQKIx8jB l9MyC79LBixtj5yzwoHi5VT3thSVmi+xsIp+I+aMZKbcUsQS/JRTvDzvOyFYoGTW6NsVYbZxuRH XovuQBHGOyD+Vz2VN+Q8fZAj9vQ2szZb6ENgkgtGBdr4t8twWprlMCT+BrKd2YV5fPr0KNXlmdC /nzX0o2wE0fzbUqJkDsUxRsTr4j5pys8yxQ+ycVf10aKGDT07zWdG3lL8sX+pU9hGa0RhLXBydS 1x65SurfaisbPjnVnuEkaUFxgVFQJTwX+VcC19L7WRGlgDbWlHX0q7qFrnYu/NvNfh3+PkKRUrd MbK0BZLfDMFmQEVHWiVt0k/dLZIzLrjN1Cpt7cu21I9erkpQeqVkQYtFKvywNnwww9BcFmGV11y FTjs6Q9BGZH7BM7IseztZ5J3EtqDCDQuACF64YFLnENVvPYllwmL16GNBcRFFz+m8TZ7B/VF45k lzqMFccyuAa5PQSx2J4JmBIt0oUP8cZ3Y+wjziAblsY7LpOOi/uBiwGty82d3WZ1oYIxzjMH2IU 9yU8Tydc1Z1UUpdxI45A0w/r9998m9pt7zbMYIm0J2DrL2naw4XiT3VVKJKVZsqmMeVj/R/bvj1 7U8rJ4O0flJVjhA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

An administrator cannot take action on these messages, but the
reported errors might be helpful for troubleshooting. Transition
them to trace points so these events appear in the trace log and
can be easily lined up with other traced NFS client operations.

Examples:

   append_writer-6147  [000]    80.247393: bl_pr_key_reg:        dev=8,0 (sda) key=0x6675bfcf59112e98
   append_writer-6147  [000]    80.247842: bl_pr_key_unreg:      dev=8,0 (sda) key=0x6675bfcf59112e98

     umount.nfs4-6172  [002]    84.950409: bl_pr_key_unreg_err:  dev=8,0 (sda) key=0x6675bfcf59112e98 status=RESERVATION_CONFLICT

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/blocklayout/dev.c | 26 +++++++-----
 fs/nfs/nfs4trace.c       |  7 ++++
 fs/nfs/nfs4trace.h       | 88 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 110 insertions(+), 11 deletions(-)

diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
index ebd268f81419..87f47e6e7181 100644
--- a/fs/nfs/blocklayout/dev.c
+++ b/fs/nfs/blocklayout/dev.c
@@ -10,6 +10,7 @@
 #include <linux/pr.h>
 
 #include "blocklayout.h"
+#include "../nfs4trace.h"
 
 #define NFSDBG_FACILITY		NFSDBG_PNFS_LD
 
@@ -17,12 +18,16 @@ static void bl_unregister_scsi(struct pnfs_block_dev *dev)
 {
 	struct block_device *bdev = file_bdev(dev->bdev_file);
 	const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
+	int status;
 
 	if (!test_and_clear_bit(PNFS_BDEV_REGISTERED, &dev->flags))
 		return;
 
-	if (ops->pr_register(bdev, dev->pr_key, 0, false))
-		pr_err("failed to unregister PR key.\n");
+	status = ops->pr_register(bdev, dev->pr_key, 0, false);
+	if (status)
+		trace_bl_pr_key_unreg_err(bdev, dev->pr_key, status);
+	else
+		trace_bl_pr_key_unreg(bdev, dev->pr_key);
 }
 
 static bool bl_register_scsi(struct pnfs_block_dev *dev)
@@ -36,10 +41,10 @@ static bool bl_register_scsi(struct pnfs_block_dev *dev)
 
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
 
@@ -382,8 +387,9 @@ bl_parse_scsi(struct nfs_server *server, struct pnfs_block_dev *d,
 		struct pnfs_block_volume *volumes, int idx, gfp_t gfp_mask)
 {
 	struct pnfs_block_volume *v = &volumes[idx];
-	struct file *bdev_file;
+	struct block_device *bdev;
 	const struct pr_ops *ops;
+	struct file *bdev_file;
 	int error;
 
 	if (!bl_validate_designator(v))
@@ -404,8 +410,9 @@ bl_parse_scsi(struct nfs_server *server, struct pnfs_block_dev *d,
 		return PTR_ERR(bdev_file);
 	}
 	d->bdev_file = bdev_file;
+	bdev = file_bdev(bdev_file);
 
-	d->len = bdev_nr_bytes(file_bdev(d->bdev_file));
+	d->len = bdev_nr_bytes(bdev);
 	d->map = bl_map_simple;
 	d->pr_key = v->scsi.pr_key;
 
@@ -414,13 +421,10 @@ bl_parse_scsi(struct nfs_server *server, struct pnfs_block_dev *d,
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
index 4de8780a7c48..22c973316f0b 100644
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


