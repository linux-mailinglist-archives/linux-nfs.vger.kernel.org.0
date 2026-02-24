Return-Path: <linux-nfs+bounces-19160-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Ad1K8ZMnWmhOQQAu9opvQ
	(envelope-from <linux-nfs+bounces-19160-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 08:01:26 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 072EF182AE8
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 08:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67554302DB66
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Feb 2026 07:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19272836AF;
	Tue, 24 Feb 2026 07:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="qTEs8EyR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from n169-111.mail.139.com (n169-111.mail.139.com [120.232.169.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4511FF1AD;
	Tue, 24 Feb 2026 07:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771916474; cv=none; b=rMG9IxW5ug3f+L4ODGpRcpoJu1e411VHCWfmgUFO5HhXll898lzuVJeFzNknHNL+ysi02Yj9cZVjwkyYq7lRbY7peyirbZzpNSk4WkfGMsofktmDQcyUG6QoCnhlv6llevUda5g9gLHPmtmeQ9se05xxdQhaqEbPkblU+wyJyZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771916474; c=relaxed/simple;
	bh=UoQ27TNkBWsgai/h5SzU1NFobM5Bcm/+jATQ8QwrhLo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=u3JOwTp++LIoETG48kbpkkD8DDQmb3zAnhhOM7KvjqRhsSwLSnhxQjqr5impcYf659Bu73caMTpEXPDkvbPk7jJUz+Ng5qfLjUR6Zn1AMWV6gWMdr5hhLaTgU357IHEdPcvX/QfQGk3HKBJqQzCbHXt1NpLLhhN05tbCXqBN5QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=qTEs8EyR; arc=none smtp.client-ip=120.232.169.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=qTEs8EyRbdqp97VW6HJjx+dz4B82TOrWOe4Uyn+YfnmeWPkzkaLrBTR8IjaaEGYEm5GwGLplljBcr
	 SfA0vXQMaP4l0ah4JsyDcazYS2cRDWxePwjl1zfB2xPYrI7DcFZ0UyaKOm90a1o9F9RrFDx68YpG6u
	 bI5ogXUAd9p5ofMA=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from NTT-kernel-dev (unknown[60.247.85.88])
	by rmsmtp-lg-appmail-18-12021 (RichMail) with SMTP id 2ef5699d4ca4477-01491;
	Tue, 24 Feb 2026 15:00:59 +0800 (CST)
X-RM-TRANSID:2ef5699d4ca4477-01491
From: Li hongliang <1468888505@139.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	hch@lst.de
Cc: patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	trond.myklebust@hammerspace.com,
	anna@kernel.org,
	linux-nfs@vger.kernel.org,
	chuck.lever@oracle.com,
	Anna.Schumaker@Netapp.com
Subject: [PATCH 6.6.y 1/2] nfs: pass explicit offset/count to trace events
Date: Tue, 24 Feb 2026 15:00:58 +0800
Message-Id: <20260224070058.2933695-1-1468888505@139.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.54 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-19160-lists,linux-nfs=lfdr.de];
	DMARC_NA(0.00)[139.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[139.com:-];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[139.com];
	FROM_NEQ_ENVFROM(0.00)[1468888505@139.com,linux-nfs@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[139.com:mid,139.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email]
X-Rspamd-Queue-Id: 072EF182AE8
X-Rspamd-Action: no action

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit fada32ed6dbc748f447c8d050a961b75d946055a ]

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
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
[ Minor conflict resolved. ]
Signed-off-by: Li hongliang <1468888505@139.com>
---
 fs/nfs/file.c     |  5 +++--
 fs/nfs/nfstrace.h | 36 ++++++++++++++++++++----------------
 fs/nfs/read.c     |  8 +++++---
 fs/nfs/write.c    | 10 +++++-----
 4 files changed, 33 insertions(+), 26 deletions(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 2f4db026f8d6..9b6f4cc4d582 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -441,7 +441,7 @@ static void nfs_invalidate_folio(struct folio *folio, size_t offset,
 	/* Cancel any unstarted writes on this page */
 	nfs_wb_folio_cancel(inode, folio);
 	folio_wait_fscache(folio);
-	trace_nfs_invalidate_folio(inode, folio);
+	trace_nfs_invalidate_folio(inode, folio_pos(folio) + offset, length);
 }
 
 /*
@@ -509,7 +509,8 @@ static int nfs_launder_folio(struct folio *folio)
 
 	folio_wait_fscache(folio);
 	ret = nfs_wb_folio(inode, folio);
-	trace_nfs_launder_folio_done(inode, folio, ret);
+	trace_nfs_launder_folio_done(inode, folio_pos(folio),
+			folio_size(folio), ret);
 	return ret;
 }
 
diff --git a/fs/nfs/nfstrace.h b/fs/nfs/nfstrace.h
index 4e90ca531176..004c25f0782b 100644
--- a/fs/nfs/nfstrace.h
+++ b/fs/nfs/nfstrace.h
@@ -933,10 +933,11 @@ TRACE_EVENT(nfs_sillyrename_unlink,
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
@@ -944,7 +945,7 @@ DECLARE_EVENT_CLASS(nfs_folio_event,
 			__field(u64, fileid)
 			__field(u64, version)
 			__field(loff_t, offset)
-			__field(u32, count)
+			__field(size_t, count)
 		),
 
 		TP_fast_assign(
@@ -954,13 +955,13 @@ DECLARE_EVENT_CLASS(nfs_folio_event,
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
@@ -972,18 +973,20 @@ DECLARE_EVENT_CLASS(nfs_folio_event,
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
@@ -992,7 +995,7 @@ DECLARE_EVENT_CLASS(nfs_folio_event_done,
 			__field(u64, fileid)
 			__field(u64, version)
 			__field(loff_t, offset)
-			__field(u32, count)
+			__field(size_t, count)
 		),
 
 		TP_fast_assign(
@@ -1002,14 +1005,14 @@ DECLARE_EVENT_CLASS(nfs_folio_event_done,
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
@@ -1021,10 +1024,11 @@ DECLARE_EVENT_CLASS(nfs_folio_event_done,
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
index 688a24e9bc8b..ed411897e33f 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -333,13 +333,15 @@ int nfs_read_add_folio(struct nfs_pageio_descriptor *pgio,
 int nfs_read_folio(struct file *file, struct folio *folio)
 {
 	struct inode *inode = file_inode(file);
+	loff_t pos = folio_pos(folio);
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
@@ -382,7 +384,7 @@ int nfs_read_folio(struct file *file, struct folio *folio)
 out_put:
 	put_nfs_open_context(ctx);
 out:
-	trace_nfs_aop_readpage_done(inode, folio, ret);
+	trace_nfs_aop_readpage_done(inode, pos, len, ret);
 	return ret;
 out_unlock:
 	folio_unlock(folio);
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index ef69b15aa72e..7b225ef1a284 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -2131,17 +2131,17 @@ int nfs_wb_folio_cancel(struct inode *inode, struct folio *folio)
  */
 int nfs_wb_folio(struct inode *inode, struct folio *folio)
 {
-	loff_t range_start = folio_file_pos(folio);
-	loff_t range_end = range_start + (loff_t)folio_size(folio) - 1;
+	loff_t range_start = folio_pos(folio);
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
@@ -2159,7 +2159,7 @@ int nfs_wb_folio(struct inode *inode, struct folio *folio)
 			goto out_error;
 	}
 out_error:
-	trace_nfs_writeback_folio_done(inode, folio, ret);
+	trace_nfs_writeback_folio_done(inode, range_start, len, ret);
 	return ret;
 }
 
-- 
2.34.1



