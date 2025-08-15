Return-Path: <linux-nfs+bounces-13696-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E94C8B288CB
	for <lists+linux-nfs@lfdr.de>; Sat, 16 Aug 2025 01:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7177A1BC0C18
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Aug 2025 23:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D344E285CA3;
	Fri, 15 Aug 2025 23:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmtf28T/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDB62D373B
	for <linux-nfs@vger.kernel.org>; Fri, 15 Aug 2025 23:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755300615; cv=none; b=g/GaRBIhgqVhKuNaRVKil1aJU/C10N1AZOJHD+LtfVy0zks79bc/w37P1/HKins3tOa8PICOlonaa42laxhyrioMDC3CEIhmbEPojdbdS/H5sLvt5xSxbtKHKCx+z/StcW5Tj0b/DjUz3i/s+I6FqNhQ/cILl6EZ2yqZ8EpILKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755300615; c=relaxed/simple;
	bh=OhmEeED4YOctBsfPo1qL6SyOY5rP5mA2MBNU7cDiUU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jSygt0INw1p9yKdJXOxMdaVfrz3TQXbHEQ/aXjIeZ9tCqg0qTwNrEsfsyAYAOqFVF2x1YxVZDZYek96O7ZOVsksjlz7Ir8Yiuw/7YBzQ96rUeMIIrvSxNjdZpr+UuzDN9AOa59oZvYEYZZI7TT6P94mlNIaEM8kdRkbqtJ0zbCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmtf28T/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C903C4CEEB;
	Fri, 15 Aug 2025 23:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755300615;
	bh=OhmEeED4YOctBsfPo1qL6SyOY5rP5mA2MBNU7cDiUU0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bmtf28T/3Rp2njL8D+/G/RZRoMbnbzuEgVokK4+TollLPSCNjr7gxXR8mi7gTO1S/
	 j0m+xj+oy6e5i5JizXMXvLoM0cxRRqnSa+FqQaDZVtNFhqV+lqenAxnu9aeprQdVPu
	 an9pX3r59U6nyTqStaFVRv8wWobA47OAoW8H4mZfVxjskhTtDQ8dxqDEElt1FesepO
	 zJysyaPflo7pxssCxlKGLWHDix6b0bSjS/N5PFmziGiJa1biWuocDNSjQd5e34c5eN
	 orvvQTmYGlQY8fw5HIb7ewRa00JNwyZ7MC8QT/vnN65m4Np8CZ7VzLGNRy9es+woFc
	 9M8ZYiO/bBfMg==
From: Mike Snitzer <snitzer@kernel.org>
To: Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna.schumaker@oracle.com>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v8 8/9] nfs/direct: add tracepoints for misaligned DIO READ and WRITE support
Date: Fri, 15 Aug 2025 19:30:02 -0400
Message-ID: <20250815233003.55071-9-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250815233003.55071-1-snitzer@kernel.org>
References: <20250815233003.55071-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add nfs_analyze_dio_class and use it to create nfs_analyze_read_dio
and nfs_analyze_write_dio trace events.

These trace events show how the NFS client splits a given misaligned
IO into a mix of misaligned head and/or tail extents and a DIO-aligned
middle extent.  The misaligned head and/or tail extents are issued
using buffered IO and the DIO-aligned middle is issued using O_DIRECT.

This combination of trace events is useful for LOCALIO DIO READs:

  echo 1 > /sys/kernel/tracing/events/nfs/nfs_analyze_read_dio/enable
  echo 1 > /sys/kernel/tracing/events/nfs/nfs_initiate_read/enable
  echo 1 > /sys/kernel/tracing/events/nfs/nfs_readpage_done/enable
  echo 1 > /sys/kernel/tracing/events/xfs/xfs_file_direct_read/enable

This combination of trace events is useful for LOCALIO DIO WRITEs:

  echo 1 > /sys/kernel/tracing/events/nfs/nfs_analyze_write_dio/enable
  echo 1 > /sys/kernel/tracing/events/nfs/nfs_initiate_write/enable
  echo 1 > /sys/kernel/tracing/events/nfs/nfs_writeback_done/enable
  echo 1 > /sys/kernel/tracing/events/xfs/xfs_file_direct_write/enable

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 fs/nfs/direct.c   | 10 +++++---
 fs/nfs/nfstrace.h | 58 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/direct.c b/fs/nfs/direct.c
index 3803289a94793..012f5bfa15c21 100644
--- a/fs/nfs/direct.c
+++ b/fs/nfs/direct.c
@@ -441,7 +441,7 @@ static ssize_t nfs_direct_read_schedule_iovec(struct nfs_direct_req *dreq,
  * IO to a DIO-aligned middle and misaligned head and/or tail.
  */
 static bool nfs_analyze_dio(loff_t offset, ssize_t len,
-			    struct nfs_direct_req *dreq)
+			    struct nfs_direct_req *dreq, int rw)
 {
 #if IS_ENABLED(CONFIG_NFS_LOCALIO)
 	/* Hardcoded to PAGE_SIZE (since don't have LOCALIO nfsd_file's
@@ -471,6 +471,10 @@ static bool nfs_analyze_dio(loff_t offset, ssize_t len,
 	dreq->end_offset = middle_end;
 	dreq->end_len = orig_end - middle_end;
 
+	if (rw == READ)
+		trace_nfs_analyze_read_dio(offset, len, dreq);
+	else
+		trace_nfs_analyze_write_dio(offset, len, dreq);
 	return true;
 #else
 	return false;
@@ -524,7 +528,7 @@ ssize_t nfs_file_direct_read(struct kiocb *iocb, struct iov_iter *iter,
 		goto out;
 
 	dreq->inode = inode;
-	if (swap || !nfs_analyze_dio(iocb->ki_pos, count, dreq)) {
+	if (swap || !nfs_analyze_dio(iocb->ki_pos, count, dreq, READ)) {
 		dreq->max_count = count;
 		dreq->io_start = iocb->ki_pos;
 	}
@@ -1119,7 +1123,7 @@ ssize_t nfs_file_direct_write(struct kiocb *iocb, struct iov_iter *iter,
 		goto out;
 
 	dreq->inode = inode;
-	if (swap || !nfs_analyze_dio(pos, count, dreq)) {
+	if (swap || !nfs_analyze_dio(pos, count, dreq, WRITE)) {
 		dreq->max_count = count;
 		dreq->io_start = pos;
 	}
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 4ec66d5e9cc6c..ec4c0f073361a 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -1598,6 +1598,64 @@ DEFINE_NFS_DIRECT_REQ_EVENT(nfs_direct_write_completion);
 DEFINE_NFS_DIRECT_REQ_EVENT(nfs_direct_write_schedule_iovec);
 DEFINE_NFS_DIRECT_REQ_EVENT(nfs_direct_write_reschedule_io);
 
+DECLARE_EVENT_CLASS(nfs_analyze_dio_class,
+	TP_PROTO(
+		loff_t offset,
+		ssize_t count,
+		const struct nfs_direct_req *dreq
+	),
+	TP_ARGS(offset, count, dreq),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(u64, fileid)
+		__field(u32, fhandle)
+		__field(loff_t, offset)
+		__field(ssize_t, count)
+		__field(loff_t, start)
+		__field(ssize_t, start_len)
+		__field(loff_t, middle)
+		__field(ssize_t, middle_len)
+		__field(loff_t, end)
+		__field(ssize_t, end_len)
+	),
+	TP_fast_assign(
+		const struct inode *inode = dreq->inode;
+		const struct nfs_inode *nfsi = NFS_I(inode);
+		const struct nfs_fh *fh = &nfsi->fh;
+
+		__entry->dev = inode->i_sb->s_dev;
+		__entry->fileid = nfsi->fileid;
+		__entry->fhandle = nfs_fhandle_hash(fh);
+		__entry->offset = offset;
+		__entry->count = count;
+		__entry->start = dreq->io_start;
+		__entry->start_len = dreq->start_len;
+		__entry->middle = dreq->middle_offset;
+		__entry->middle_len = dreq->middle_len;
+		__entry->end = dreq->end_offset;
+		__entry->end_len = dreq->end_len;
+	),
+	TP_printk("fileid=%02x:%02x:%llu fhandle=0x%08x "
+		  "offset=%lld count=%zd "
+		  "start=%llu+%lu middle=%llu+%lu end=%llu+%lu",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  (unsigned long long)__entry->fileid,
+		  __entry->fhandle, __entry->offset, __entry->count,
+		  __entry->start, __entry->start_len,
+		  __entry->middle, __entry->middle_len,
+		  __entry->end, __entry->end_len)
+)
+
+#define DEFINE_NFS_ANALYZE_DIO_EVENT(name)			\
+DEFINE_EVENT(nfs_analyze_dio_class, nfs_analyze_##name##_dio,	\
+	TP_PROTO(loff_t offset,					\
+		 ssize_t count,					\
+		 const struct nfs_direct_req *dreq),		\
+	TP_ARGS(offset, count, dreq))
+
+DEFINE_NFS_ANALYZE_DIO_EVENT(read);
+DEFINE_NFS_ANALYZE_DIO_EVENT(write);
+
 TRACE_EVENT(nfs_fh_to_dentry,
 		TP_PROTO(
 			const struct super_block *sb,
-- 
2.44.0


