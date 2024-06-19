Return-Path: <linux-nfs+bounces-4079-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F084990F54A
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 19:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7636A1F217A1
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2024 17:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3656154C16;
	Wed, 19 Jun 2024 17:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gF12xJt+"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB201E87B
	for <linux-nfs@vger.kernel.org>; Wed, 19 Jun 2024 17:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718818805; cv=none; b=G4GMd8rLAAv6ahAz4KjX6wvdcp8HnQytdH+a/6hdAdszqrIqSZFthuG1aMQEcZ7d9vuM2BPXqXN8WFMgKLQiUVnPkcsKx1EKcivaGqkFfNx6ZAkhQB8t7EyGATSyFwe6IgbIKmX5vjLdUxh03KSpKwEItU+TELeyscSM07IZRUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718818805; c=relaxed/simple;
	bh=Kct/wd8r1HaJT4Rkwjc2aXykFnAqUtzCO0o/F62p/W4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OdhomG4FpfdwngrtGmgKFpMITCn0KlXYjX+sGNxhOjaZuuOvQScPmuy1BQ/SrxzRfPjVAhjfE0TnxoyhJelzmMKGqxMQfLk6kUIFkKp5EsnRamK7XjCu5fxsoay7jfnP74f4Z3LgNSgsayUjqFo75KjiHP6AGEjY6XE+ZKJXAH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gF12xJt+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0774BC32786;
	Wed, 19 Jun 2024 17:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718818805;
	bh=Kct/wd8r1HaJT4Rkwjc2aXykFnAqUtzCO0o/F62p/W4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gF12xJt+7Zww/VKxPC0TSx1ubUCLY+UVnVJf7qz+/J8T92Infi3ZQ3xb1+0FoE7EI
	 /0Eo9L+JO0jhDn/LMs+BwLA8dF0xVIwJfCVwqmT6pnBhHboq5+/pZyFymH8VDeIKa0
	 lIWxPSLp6tMO0pzUTOzT3UqPntl4UTC/JtedCow0GdiBHaZsmzU2LOF64wAd60sLG7
	 CHgnFVd6F8BahYIyDVrZUXSRHEUg4dYhM1tqb+ueTLJf8p3vOIsRbyasTRz5pawRi8
	 wiTk163A3pv1pRwgj2boazK1wLkvJLNt4AMcbZ2iUQ1Z5ZRw+v5aRooLe6Tj28YTyy
	 ETdlB486E/xuw==
From: cel@kernel.org
To: <linux-nfs@vger.kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Chuck Lever <chuck.lever@oracle.com>
Subject: [RFC PATCH 1/4] nfs/blocklayout: SCSI layout trace points for reservation key reg/unreg
Date: Wed, 19 Jun 2024 13:39:31 -0400
Message-ID: <20240619173929.177818-7-cel@kernel.org>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240619173929.177818-6-cel@kernel.org>
References: <20240619173929.177818-6-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6090; i=chuck.lever@oracle.com; h=from:subject; bh=IA+LOlwZoh9GveC01VQSVy969wWvp+xX60t7Vq8LkNc=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBmcxfXQjOqO3x2PG1cQ931au3KKXNX5De4+/3Sg hNC9Mlw5CSJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCZnMX1wAKCRAzarMzb2Z/ l2NREACNMnqIFrGmmTFKqn8dhISN3ry/1bbBSk6y6v10PDd90U59dj0Ptrigvdyc83NFnDqYCO2 xb+Yw7U5s1oOFRWJjTkwOE964xFpTP85FJGtDpNMo8J6VV/I8F0r24VN3RdlnNCbF6GDh04aoU5 JKsSOtSlUk8pNOBK8kljHIih14hiLLWVQOil7XfZQ8mnPGlJL8NVVEovh+KqzDRRLI5gjYhJHsB N7pvlgkEaQF4ipnstKcjV5BYydSO6E2xQ4yWWbAoB2miwvrPiHP03kJN25rQwge2cS5HMWYw9GB bAlIGLrd6chbrgpOwpZfHsazCs7aNk86I5pxlapQOj0D+AYKcxADHWy4a94OK+K1L/Jhd8kqWzN vg6zcNeACP0+WrABusToVhUzrV65CJjOc6FsH2xjue/PF3pPUWwJRkBRmLjs+QYyaw4GetIj0Ky fkEFQxuXgi8buaVDfqnBxJPPHSZ3vg56fLwVEcu43ROXig/QkSqoM8PLlW38tlivhLsGnF1NBsG Sy4rxy/rGdhktbUtEhSh9qQdfmf4W4y0POlWplWNZrHW2nz4AZ2erXVsO3E1Bk87shMQR7XqvqK XhHsk2YzxhdJg4HPSUPxbHzrNJzz6Tw8G65akLknR/7c3Gd8AryP+cz24uoWzADKsGwDzodn/4Q PBzRrp2xNo4VVaQ==
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

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/blocklayout/dev.c | 33 +++++++++++----------
 fs/nfs/nfs4trace.c       |  5 ++++
 fs/nfs/nfs4trace.h       | 62 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 85 insertions(+), 15 deletions(-)

diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
index 519c310c745d..b3828e5ee079 100644
--- a/fs/nfs/blocklayout/dev.c
+++ b/fs/nfs/blocklayout/dev.c
@@ -10,6 +10,7 @@
 #include <linux/pr.h>
 
 #include "blocklayout.h"
+#include "../nfs4trace.h"
 
 #define NFSDBG_FACILITY		NFSDBG_PNFS_LD
 
@@ -24,14 +25,17 @@ bl_free_device(struct pnfs_block_dev *dev)
 		kfree(dev->children);
 	} else {
 		if (dev->pr_registered) {
-			const struct pr_ops *ops =
-				file_bdev(dev->bdev_file)->bd_disk->fops->pr_ops;
+			struct block_device *bdev = file_bdev(dev->bdev_file);
+			const struct pr_ops *ops = bdev->bd_disk->fops->pr_ops;
 			int error;
 
-			error = ops->pr_register(file_bdev(dev->bdev_file),
-				dev->pr_key, 0, false);
+			error = ops->pr_register(bdev, dev->pr_key, 0, false);
 			if (error)
-				pr_err("failed to unregister PR key.\n");
+				trace_bl_pr_key_unreg_err(bdev->bd_disk->disk_name,
+							  dev->pr_key, error);
+			else
+				trace_bl_pr_key_unreg(bdev->bd_disk->disk_name,
+						      dev->pr_key);
 		}
 
 		if (dev->bdev_file)
@@ -327,8 +331,9 @@ bl_parse_scsi(struct nfs_server *server, struct pnfs_block_dev *d,
 		struct pnfs_block_volume *volumes, int idx, gfp_t gfp_mask)
 {
 	struct pnfs_block_volume *v = &volumes[idx];
-	struct file *bdev_file;
+	struct block_device *bdev;
 	const struct pr_ops *ops;
+	struct file *bdev_file;
 	int error;
 
 	if (!bl_validate_designator(v))
@@ -346,8 +351,9 @@ bl_parse_scsi(struct nfs_server *server, struct pnfs_block_dev *d,
 	if (IS_ERR(bdev_file))
 		return PTR_ERR(bdev_file);
 	d->bdev_file = bdev_file;
+	bdev = file_bdev(bdev_file);
 
-	d->len = bdev_nr_bytes(file_bdev(d->bdev_file));
+	d->len = bdev_nr_bytes(bdev);
 	d->map = bl_map_simple;
 	d->pr_key = v->scsi.pr_key;
 
@@ -356,23 +362,20 @@ bl_parse_scsi(struct nfs_server *server, struct pnfs_block_dev *d,
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
 
-	error = ops->pr_register(file_bdev(d->bdev_file), 0, d->pr_key, true);
+	error = ops->pr_register(bdev, 0, d->pr_key, true);
 	if (error) {
-		pr_err("pNFS: failed to register key for block device %s.",
-				file_bdev(d->bdev_file)->bd_disk->disk_name);
+		trace_bl_pr_key_reg_err(bdev->bd_disk->disk_name, d->pr_key, error);
 		goto out_blkdev_put;
 	}
+	trace_bl_pr_key_reg(bdev->bd_disk->disk_name, d->pr_key);
 
 	d->pr_registered = true;
 	return 0;
diff --git a/fs/nfs/nfs4trace.c b/fs/nfs/nfs4trace.c
index d22c6670f770..74eff35fbc90 100644
--- a/fs/nfs/nfs4trace.c
+++ b/fs/nfs/nfs4trace.c
@@ -29,5 +29,10 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(ff_layout_read_error);
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
index 4de8780a7c48..2af75b8e018d 100644
--- a/fs/nfs/nfs4trace.h
+++ b/fs/nfs/nfs4trace.h
@@ -2153,6 +2153,68 @@ TRACE_EVENT(ff_layout_commit_error,
 		)
 );
 
+DECLARE_EVENT_CLASS(pnfs_bl_pr_key_class,
+	TP_PROTO(
+		const char *name,
+		u64 key
+	),
+	TP_ARGS(name, key),
+	TP_STRUCT__entry(
+		__string(name, name)
+		__field(u64, key)
+	),
+	TP_fast_assign(
+		__assign_str(name);
+		__entry->key = key;
+	),
+	TP_printk("device=%s key=0x%llx",
+		__get_str(name), __entry->key
+	)
+);
+
+#define DEFINE_NFS4_BLOCK_PRKEY_EVENT(name) \
+	DEFINE_EVENT(pnfs_bl_pr_key_class, name, \
+		TP_PROTO( \
+			const char *name, \
+			u64 key \
+		), \
+		TP_ARGS(name, key))
+DEFINE_NFS4_BLOCK_PRKEY_EVENT(bl_pr_key_reg);
+DEFINE_NFS4_BLOCK_PRKEY_EVENT(bl_pr_key_unreg);
+
+DECLARE_EVENT_CLASS(pnfs_bl_pr_key_err_class,
+	TP_PROTO(
+		const char *name,
+		u64 key,
+		int error
+	),
+	TP_ARGS(name, key, error),
+	TP_STRUCT__entry(
+		__string(name, name)
+		__field(u64, key)
+		__field(int, error)
+	),
+	TP_fast_assign(
+		__assign_str(name);
+		__entry->key = key;
+		__entry->error = error;
+	),
+	TP_printk("device=%s key=0x%llx error=%d",
+		__get_str(name), __entry->key, __entry->error
+	)
+);
+
+#define DEFINE_NFS4_BLOCK_PRKEY_ERR_EVENT(name) \
+	DEFINE_EVENT(pnfs_bl_pr_key_err_class, name, \
+		TP_PROTO( \
+			const char *name, \
+			u64 key, \
+			int error \
+		), \
+		TP_ARGS(name, key, error))
+DEFINE_NFS4_BLOCK_PRKEY_ERR_EVENT(bl_pr_key_reg_err);
+DEFINE_NFS4_BLOCK_PRKEY_ERR_EVENT(bl_pr_key_unreg_err);
+
 #ifdef CONFIG_NFS_V4_2
 TRACE_DEFINE_ENUM(NFS4_CONTENT_DATA);
 TRACE_DEFINE_ENUM(NFS4_CONTENT_HOLE);
-- 
2.45.1


