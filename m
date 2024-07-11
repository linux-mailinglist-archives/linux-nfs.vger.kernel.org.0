Return-Path: <linux-nfs+bounces-4786-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEAC92E0A2
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 09:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1E3BB20F7C
	for <lists+linux-nfs@lfdr.de>; Thu, 11 Jul 2024 07:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD2383CC8;
	Thu, 11 Jul 2024 07:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ncqZsT/l"
X-Original-To: linux-nfs@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D09B3BBED
	for <linux-nfs@vger.kernel.org>; Thu, 11 Jul 2024 07:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720682230; cv=none; b=n2oazEaxFRdv71GFaVw6ySf7gVv2o3D/EpY10bSWtaRBPmzV2V+Z9G3sW+HrH7d3/3AiXDMW6VVaH4le22cDjWkUPDUQPhn1pTcU/02UUjUCL7CSbROoZftnVZhcxKyZQQgbOOQ3GssUFwjFa822NejrDAOyqtIlYUzeXc/ePgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720682230; c=relaxed/simple;
	bh=5nE0R4Mohkzdd8E/rUcww3ZyElGXjl20M1q1HQFxegc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=glA40/AkgSnFAWOpP61XmhVC/AA7Mnp5elXpk2OkBKpAjYBclgpiDb1baVsQLJ26Wh6TR41/kQQxLl2wtivHVZl5bpAxC0USwq9f6mcQh8266Qt/1JrsaT0MdviZ/cgomKFSgcEKZS02bk8n+NNEDTcxNDJ/yv+Iva34oXABF+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ncqZsT/l; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=UovDSEY4DWvNJN/jjp/wUPmVPbR6pyVi2zyhJofNI3I=; b=ncqZsT/lTr6PB0wLsB9oyMlhmt
	NhjEFzdM5TOhoF1e8C97AEtVgzjM6qKi+zUNieOHEAsH0GgBUHfXEjTRyDluzkYSKPhVupZE+5zcm
	B9QLVRn84btHK0i0Hl1Y5qjrAhJogPseeju3uGjIajuwlS9scjqXkGCvtBged7Nd8SXZe2Wxfn3tC
	dG6clt06hXTLStoOStrrVMK0UAv+81q/rMDkPxxyEOZ+gGevDSXXtIcyZFdDFEpQZi1SmJU0sx2vH
	vK5m7s7jk19uwblvpzt/y5VGWky91ur/OAfpL2VNWDkHUeFA/zMqkxBab+uNBGmfU+6Jd5BuJd2LP
	WNxY0+8w==;
Received: from 2a02-8389-2341-5b80-0976-dc3d-d348-fed7.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:976:dc3d:d348:fed7] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRo38-0000000Czey-1NbZ;
	Thu, 11 Jul 2024 07:17:06 +0000
From: Christoph Hellwig <hch@lst.de>
To: trondmy@kernel.org,
	anna@kernel.org
Cc: chuck.lever@oracle.com,
	linux-nfs@vger.kernel.org
Subject: [PATCH 1/2] nfs: pass explicit offset/count to trace events
Date: Thu, 11 Jul 2024 09:17:02 +0200
Message-ID: <20240711071703.65793-1-hch@lst.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

nfs_folio_length is unsafe to use without having the folio locked and a
check for a NULL ->f_mapping that protects against truncations and can
lead to kernel crashes.  E.g. when running xfstests generic/065 with
all nfs trace points enabled.

Follow the model of the XFS trace points and pass in an explіcit offset
and length.  This has the additional benefit that these values can
be more accurate as some of the users touch partial folio ranges.

Fixes: eb5654b3b89d ("NFS: Enable tracing of nfs_invalidate_folio() and nfs_launder_folio()")
Reported-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/file.c     |  5 +++--
 fs/nfs/nfstrace.h | 36 ++++++++++++++++++++----------------
 fs/nfs/read.c     |  8 +++++---
 fs/nfs/write.c    |  8 ++++----
 4 files changed, 32 insertions(+), 25 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 0e2f87120cb840..9aa2ab218c0ac5 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -436,7 +436,7 @@ static void nfs_invalidate_folio(struct folio *folio, size_t offset,
 	/* Cancel any unstarted writes on this page */
 	nfs_wb_folio_cancel(inode, folio);
 	folio_wait_private_2(folio); /* [DEPRECATED] */
-	trace_nfs_invalidate_folio(inode, folio);
+	trace_nfs_invalidate_folio(inode, folio_pos(folio) + offset, length);
 }
 
 /*
@@ -504,7 +504,8 @@ static int nfs_launder_folio(struct folio *folio)
 
 	folio_wait_private_2(folio); /* [DEPRECATED] */
 	ret = nfs_wb_folio(inode, folio);
-	trace_nfs_launder_folio_done(inode, folio, ret);
+	trace_nfs_launder_folio_done(inode, folio_pos(folio),
+			folio_size(folio), ret);
 	return ret;
 }
 
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 1e710654af1173..352fdaed407541 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -939,10 +939,11 @@ TRACE_EVENT(nfs_sillyrename_unlink,
 DECLARE_EVENT_CLASS(nfs_folio_event,
 		TP_PROTO(
 			const struct inode *inode,
-			struct folio *folio
+			loff_t offset,
+			size_t count
 		),
 
-		TP_ARGS(inode, folio),
+		TP_ARGS(inode, offset, count),
 
 		TP_STRUCT__entry(
 			__field(dev_t, dev)
@@ -950,7 +951,7 @@ DECLARE_EVENT_CLASS(nfs_folio_event,
 			__field(u64, fileid)
 			__field(u64, version)
 			__field(loff_t, offset)
-			__field(u32, count)
+			__field(size_t, count)
 		),
 
 		TP_fast_assign(
@@ -960,13 +961,13 @@ DECLARE_EVENT_CLASS(nfs_folio_event,
 			__entry->fileid = nfsi->fileid;
 			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
 			__entry->version = inode_peek_iversion_raw(inode);
-			__entry->offset = folio_file_pos(folio);
-			__entry->count = nfs_folio_length(folio);
+			__entry->offset = offset,
+			__entry->count = count;
 		),
 
 		TP_printk(
 			"fileid=%02x:%02x:%llu fhandle=0x%08x version=%llu "
-			"offset=%lld count=%u",
+			"offset=%lld count=%zu",
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle, __entry->version,
@@ -978,18 +979,20 @@ DECLARE_EVENT_CLASS(nfs_folio_event,
 	DEFINE_EVENT(nfs_folio_event, name, \
 			TP_PROTO( \
 				const struct inode *inode, \
-				struct folio *folio \
+				loff_t offset, \
+				size_t count \
 			), \
-			TP_ARGS(inode, folio))
+			TP_ARGS(inode, offset, count))
 
 DECLARE_EVENT_CLASS(nfs_folio_event_done,
 		TP_PROTO(
 			const struct inode *inode,
-			struct folio *folio,
+			loff_t offset,
+			size_t count,
 			int ret
 		),
 
-		TP_ARGS(inode, folio, ret),
+		TP_ARGS(inode, offset, count, ret),
 
 		TP_STRUCT__entry(
 			__field(dev_t, dev)
@@ -998,7 +1001,7 @@ DECLARE_EVENT_CLASS(nfs_folio_event_done,
 			__field(u64, fileid)
 			__field(u64, version)
 			__field(loff_t, offset)
-			__field(u32, count)
+			__field(size_t, count)
 		),
 
 		TP_fast_assign(
@@ -1008,14 +1011,14 @@ DECLARE_EVENT_CLASS(nfs_folio_event_done,
 			__entry->fileid = nfsi->fileid;
 			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
 			__entry->version = inode_peek_iversion_raw(inode);
-			__entry->offset = folio_file_pos(folio);
-			__entry->count = nfs_folio_length(folio);
+			__entry->offset = offset,
+			__entry->count = count,
 			__entry->ret = ret;
 		),
 
 		TP_printk(
 			"fileid=%02x:%02x:%llu fhandle=0x%08x version=%llu "
-			"offset=%lld count=%u ret=%d",
+			"offset=%lld count=%zu ret=%d",
 			MAJOR(__entry->dev), MINOR(__entry->dev),
 			(unsigned long long)__entry->fileid,
 			__entry->fhandle, __entry->version,
@@ -1027,10 +1030,11 @@ DECLARE_EVENT_CLASS(nfs_folio_event_done,
 	DEFINE_EVENT(nfs_folio_event_done, name, \
 			TP_PROTO( \
 				const struct inode *inode, \
-				struct folio *folio, \
+				loff_t offset, \
+				size_t count, \
 				int ret \
 			), \
-			TP_ARGS(inode, folio, ret))
+			TP_ARGS(inode, offset, count, ret))
 
 DEFINE_NFS_FOLIO_EVENT(nfs_aop_readpage);
 DEFINE_NFS_FOLIO_EVENT_DONE(nfs_aop_readpage_done);
diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index 036ede4875cab6..571a5d654cf547 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -333,13 +333,15 @@ int nfs_read_add_folio(struct nfs_pageio_descriptor *pgio,
 int nfs_read_folio(struct file *file, struct folio *folio)
 {
 	struct inode *inode = file_inode(file);
+	loff_t pos = folio_file_pos(folio);
+	size_t len = folio_size(folio);
 	struct nfs_pageio_descriptor pgio;
 	struct nfs_open_context *ctx;
 	int ret;
 
-	trace_nfs_aop_readpage(inode, folio);
+	trace_nfs_aop_readpage(inode, pos, len);
 	nfs_inc_stats(inode, NFSIOS_VFSREADPAGE);
-	task_io_account_read(folio_size(folio));
+	task_io_account_read(len);
 
 	/*
 	 * Try to flush any pending writes to the file..
@@ -383,7 +385,7 @@ int nfs_read_folio(struct file *file, struct folio *folio)
 out_put:
 	put_nfs_open_context(ctx);
 out:
-	trace_nfs_aop_readpage_done(inode, folio, ret);
+	trace_nfs_aop_readpage_done(inode, pos, len, ret);
 	return ret;
 out_unlock:
 	folio_unlock(folio);
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index acf2d942d78fe2..54eab063b67851 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -2064,16 +2064,16 @@ int nfs_wb_folio_cancel(struct inode *inode, struct folio *folio)
 int nfs_wb_folio(struct inode *inode, struct folio *folio)
 {
 	loff_t range_start = folio_file_pos(folio);
-	loff_t range_end = range_start + (loff_t)folio_size(folio) - 1;
+	size_t len = folio_size(folio);
 	struct writeback_control wbc = {
 		.sync_mode = WB_SYNC_ALL,
 		.nr_to_write = 0,
 		.range_start = range_start,
-		.range_end = range_end,
+		.range_end = range_start + len - 1,
 	};
 	int ret;
 
-	trace_nfs_writeback_folio(inode, folio);
+	trace_nfs_writeback_folio(inode, range_start, len);
 
 	for (;;) {
 		folio_wait_writeback(folio);
@@ -2091,7 +2091,7 @@ int nfs_wb_folio(struct inode *inode, struct folio *folio)
 			goto out_error;
 	}
 out_error:
-	trace_nfs_writeback_folio_done(inode, folio, ret);
+	trace_nfs_writeback_folio_done(inode, range_start, len, ret);
 	return ret;
 }
 
-- 
2.43.0


