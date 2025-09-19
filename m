Return-Path: <linux-nfs+bounces-14603-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B760B8A025
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Sep 2025 16:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD90F3A721C
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Sep 2025 14:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300273148B5;
	Fri, 19 Sep 2025 14:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uKLj4gNA"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5D724DCEB
	for <linux-nfs@vger.kernel.org>; Fri, 19 Sep 2025 14:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758292601; cv=none; b=Yv7brPZb00Ma2m4DABDMN5uq/1uFUkX3LWisg2qLkP2fr9iUlwKkkueND9bgfAMUlEZITcg9xGQTRkwd9YR1DnVmWexD9xGGCzS1eMIQ9YQWDySgP8+3/K0/Lo+Fbui6XFkv7jLLm/PHyGKBV8LkKxmevgU8F9QCheEZHKuYQjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758292601; c=relaxed/simple;
	bh=jnbACsfBtViZtANSO3TiKCsCwaJygn656PIeAamneRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sc2gDCgxbL7SoG7yJLHP7Rbl2p61KfOktYpGI2Obe297ycdz1EKOG8voZ37vcSFt2twXp4osUPI8rFpGz5MOxVWDz3m8ZrjqlXeZogoXnh6pbaDZoCWr6B/ZviVptqOwXYriSvhH2z8Pqp0H/m4f5gxn8QGsaai1+JYZhoIdSV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uKLj4gNA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B8BC4CEF0;
	Fri, 19 Sep 2025 14:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758292600;
	bh=jnbACsfBtViZtANSO3TiKCsCwaJygn656PIeAamneRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uKLj4gNAe0cEmifE/ZG42xyRumbL9n4wu6Ytx4P51A7oRYhJYXKZKs86UwW3TRvxv
	 9Aj+Tc1JQrwqVoEoYoV0ET46MLNHqGA/XbmV5wyAhX1s1MzH19vCu/3cEOIiTUO8QN
	 ADqogDe3GT/ups5hYLhvuCrxRIRYIlJGVH4JhRmWZ66WZ6ObhTRUIuxTEmXVo4S7M5
	 Y4oSw6idvnKJX7PGLga+HPWDM/XSMVtksLBr1Alce1Fjg7oqBM9Qo5vvuFxRXPIZv0
	 zQ+brYRKrcOHQRsFj+ejpkzw/613NdRO6zCRohZkk+7bizOzAVRjHCYTTAGHQs9CLd
	 oM8BzkvzCyi2Q==
From: Mike Snitzer <snitzer@kernel.org>
To: Anna Schumaker <anna@kernel.org>
Cc: Trond Myklebust <trond.myklebust@hammerspace.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH v11 6/7] nfs/localio: add tracepoints for misaligned DIO READ and WRITE support
Date: Fri, 19 Sep 2025 10:36:30 -0400
Message-ID: <20250919143631.44851-7-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250919143631.44851-1-snitzer@kernel.org>
References: <20250919143631.44851-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add nfs_local_dio_class and use it to create nfs_local_dio_read,
nfs_local_dio_write and nfs_local_dio_misaligned trace events.

These trace events show how NFS LOCALIO splits a given misaligned
IO into a mix of misaligned head and/or tail extents and a DIO-aligned
middle extent.  The misaligned head and/or tail extents are issued
using buffered IO and the DIO-aligned middle is issued using O_DIRECT.

This combination of trace events is useful for LOCALIO DIO READs:

  echo 1 > /sys/kernel/tracing/events/nfs/nfs_local_dio_read/enable
  echo 1 > /sys/kernel/tracing/events/nfs/nfs_local_dio_misaligned/enable
  echo 1 > /sys/kernel/tracing/events/nfs/nfs_initiate_read/enable
  echo 1 > /sys/kernel/tracing/events/nfs/nfs_readpage_done/enable
  echo 1 > /sys/kernel/tracing/events/xfs/xfs_file_direct_read/enable

This combination of trace events is useful for LOCALIO DIO WRITEs:

  echo 1 > /sys/kernel/tracing/events/nfs/nfs_local_dio_write/enable
  echo 1 > /sys/kernel/tracing/events/nfs/nfs_local_dio_misaligned/enable
  echo 1 > /sys/kernel/tracing/events/nfs/nfs_initiate_write/enable
  echo 1 > /sys/kernel/tracing/events/nfs/nfs_writeback_done/enable
  echo 1 > /sys/kernel/tracing/events/xfs/xfs_file_direct_write/enable

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/internal.h | 10 +++++++
 fs/nfs/localio.c  | 19 ++++++-------
 fs/nfs/nfs2xdr.c  |  2 +-
 fs/nfs/nfs3xdr.c  |  2 +-
 fs/nfs/nfstrace.h | 70 +++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 90 insertions(+), 13 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index d44233cfd7949..3d380c45b5ef3 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -456,6 +456,16 @@ extern int nfs_wait_bit_killable(struct wait_bit_key *key, int mode);
 
 #if IS_ENABLED(CONFIG_NFS_LOCALIO)
 /* localio.c */
+struct nfs_local_dio {
+	u32 mem_align;
+	u32 offset_align;
+	loff_t middle_offset;
+	loff_t end_offset;
+	ssize_t	start_len;	/* Length for misaligned first extent */
+	ssize_t	middle_len;	/* Length for DIO-aligned middle extent */
+	ssize_t	end_len;	/* Length for misaligned last extent */
+};
+
 extern void nfs_local_probe_async(struct nfs_client *);
 extern void nfs_local_probe_async_work(struct work_struct *);
 extern struct nfsd_file *nfs_local_open_fh(struct nfs_client *,
diff --git a/fs/nfs/localio.c b/fs/nfs/localio.c
index 8978e1ad4bc94..b575f0e6c7c8e 100644
--- a/fs/nfs/localio.c
+++ b/fs/nfs/localio.c
@@ -322,16 +322,6 @@ nfs_local_iocb_alloc(struct nfs_pgio_header *hdr,
 	return iocb;
 }
 
-struct nfs_local_dio {
-	u32 mem_align;
-	u32 offset_align;
-	loff_t middle_offset;
-	loff_t end_offset;
-	ssize_t	start_len;	/* Length for misaligned first extent */
-	ssize_t	middle_len;	/* Length for DIO-aligned middle extent */
-	ssize_t	end_len;	/* Length for misaligned last extent */
-};
-
 static bool
 nfs_is_local_dio_possible(struct nfs_local_kiocb *iocb, int rw,
 			  size_t len, struct nfs_local_dio *local_dio)
@@ -367,6 +357,10 @@ nfs_is_local_dio_possible(struct nfs_local_kiocb *iocb, int rw,
 	local_dio->middle_len = middle_end - start_end;
 	local_dio->end_len = orig_end - middle_end;
 
+	if (rw == ITER_DEST)
+		trace_nfs_local_dio_read(hdr->inode, offset, len, local_dio);
+	else
+		trace_nfs_local_dio_write(hdr->inode, offset, len, local_dio);
 	return true;
 }
 
@@ -446,8 +440,11 @@ nfs_local_iters_setup_dio(struct nfs_local_kiocb *iocb, int rw,
 		nfs_iov_iter_aligned_bvec(&iters[n_iters],
 			local_dio->mem_align-1, local_dio->offset_align-1);
 
-	if (unlikely(!iocb->iter_is_dio_aligned[n_iters]))
+	if (unlikely(!iocb->iter_is_dio_aligned[n_iters])) {
+		trace_nfs_local_dio_misaligned(iocb->hdr->inode,
+			iocb->hdr->args.offset, len, local_dio);
 		return 0; /* no DIO-aligned IO possible */
+	}
 	++n_iters;
 
 	iocb->n_iters = n_iters;
diff --git a/fs/nfs/nfs2xdr.c b/fs/nfs/nfs2xdr.c
index 6e75c6c2d2347..9eff091585181 100644
--- a/fs/nfs/nfs2xdr.c
+++ b/fs/nfs/nfs2xdr.c
@@ -23,8 +23,8 @@
 #include <linux/nfs2.h>
 #include <linux/nfs_fs.h>
 #include <linux/nfs_common.h>
-#include "nfstrace.h"
 #include "internal.h"
+#include "nfstrace.h"
 
 #define NFSDBG_FACILITY		NFSDBG_XDR
 
diff --git a/fs/nfs/nfs3xdr.c b/fs/nfs/nfs3xdr.c
index 4ae01c10b7e28..e17d729084125 100644
--- a/fs/nfs/nfs3xdr.c
+++ b/fs/nfs/nfs3xdr.c
@@ -23,8 +23,8 @@
 #include <linux/nfsacl.h>
 #include <linux/nfs_common.h>
 
-#include "nfstrace.h"
 #include "internal.h"
+#include "nfstrace.h"
 
 #define NFSDBG_FACILITY		NFSDBG_XDR
 
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index d5949da8c2e5d..132c1b87fa3eb 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -1599,6 +1599,76 @@ DEFINE_NFS_DIRECT_REQ_EVENT(nfs_direct_write_completion);
 DEFINE_NFS_DIRECT_REQ_EVENT(nfs_direct_write_schedule_iovec);
 DEFINE_NFS_DIRECT_REQ_EVENT(nfs_direct_write_reschedule_io);
 
+#if IS_ENABLED(CONFIG_NFS_LOCALIO)
+
+DECLARE_EVENT_CLASS(nfs_local_dio_class,
+	TP_PROTO(
+		const struct inode *inode,
+		loff_t offset,
+		ssize_t count,
+		const struct nfs_local_dio *local_dio
+	),
+	TP_ARGS(inode, offset, count, local_dio),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(u64, fileid)
+		__field(u32, fhandle)
+		__field(loff_t, offset)
+		__field(ssize_t, count)
+		__field(u32, mem_align)
+		__field(u32, offset_align)
+		__field(loff_t, start)
+		__field(ssize_t, start_len)
+		__field(loff_t, middle)
+		__field(ssize_t, middle_len)
+		__field(loff_t, end)
+		__field(ssize_t, end_len)
+	),
+	TP_fast_assign(
+		const struct nfs_inode *nfsi = NFS_I(inode);
+		const struct nfs_fh *fh = &nfsi->fh;
+
+		__entry->dev = inode->i_sb->s_dev;
+		__entry->fileid = nfsi->fileid;
+		__entry->fhandle = nfs_fhandle_hash(fh);
+		__entry->offset = offset;
+		__entry->count = count;
+		__entry->mem_align = local_dio->mem_align;
+		__entry->offset_align = local_dio->offset_align;
+		__entry->start = offset;
+		__entry->start_len = local_dio->start_len;
+		__entry->middle = local_dio->middle_offset;
+		__entry->middle_len = local_dio->middle_len;
+		__entry->end = local_dio->end_offset;
+		__entry->end_len = local_dio->end_len;
+	),
+	TP_printk("fileid=%02x:%02x:%llu fhandle=0x%08x "
+		  "offset=%lld count=%zd "
+		  "mem_align=%u offset_align=%u "
+		  "start=%llu+%zd middle=%llu+%zd end=%llu+%zd",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  (unsigned long long)__entry->fileid,
+		  __entry->fhandle, __entry->offset, __entry->count,
+		  __entry->mem_align, __entry->offset_align,
+		  __entry->start, __entry->start_len,
+		  __entry->middle, __entry->middle_len,
+		  __entry->end, __entry->end_len)
+)
+
+#define DEFINE_NFS_LOCAL_DIO_EVENT(name)		\
+DEFINE_EVENT(nfs_local_dio_class, nfs_local_dio_##name,	\
+	TP_PROTO(const struct inode *inode,		\
+		 loff_t offset,				\
+		 ssize_t count,				\
+		 const struct nfs_local_dio *local_dio),\
+	TP_ARGS(inode, offset, count, local_dio))
+
+DEFINE_NFS_LOCAL_DIO_EVENT(read);
+DEFINE_NFS_LOCAL_DIO_EVENT(write);
+DEFINE_NFS_LOCAL_DIO_EVENT(misaligned);
+
+#endif /* CONFIG_NFS_LOCALIO */
+
 TRACE_EVENT(nfs_fh_to_dentry,
 		TP_PROTO(
 			const struct super_block *sb,
-- 
2.44.0


