Return-Path: <linux-nfs+bounces-13442-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 858BAB1BA6D
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Aug 2025 20:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB1211895F82
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Aug 2025 18:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DA2299A84;
	Tue,  5 Aug 2025 18:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+xZ6Sf4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB7725394C
	for <linux-nfs@vger.kernel.org>; Tue,  5 Aug 2025 18:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754419472; cv=none; b=FQeVK51aQXXvGuR0zG6bWOqKugl3vEZUQ1CFRVSONWsMQIeHTL29EZSLtbJdnQ7221nhi1AhZ5gbKkc02ZdpXd5SXGMPMVEapWu1obDXok+9dhHtjpKwcYdFKm4vMcNmH8oG+c3cnieMGvM2H8J5KQP7vw0K2CCsaT3dijk0hPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754419472; c=relaxed/simple;
	bh=rIAsgV8OZOucXIWc9uV0WhWNgdyyQcTcq7ysmiXTFls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZFf8dhh86yeUnoTcCFF92e0LTzeVNhdf79c4cjcWbS/GHw6A9lWPFT7i8RsgQG9k40pwHHnhqdoYriFy/do7uaJRUBC+3B0eF5keaabCmRMQ2fgCAeGJQpY9gGED9nnWay60Kmd4rsEvV5X1FINV1FDANjpUBxTGV/d7apuS+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+xZ6Sf4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31416C4CEF0;
	Tue,  5 Aug 2025 18:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754419472;
	bh=rIAsgV8OZOucXIWc9uV0WhWNgdyyQcTcq7ysmiXTFls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n+xZ6Sf4saVqviMl935y991A3i7/S6+6mrKG+3njrhbToAwiWlFZ2CsVPNpw9t2dP
	 7bsTssHdA51RSG40rM0nDSXnErsPM7t1VWDXg72w83db59Wk1iaNcJ69p1EnM7nP/K
	 8qWzp6IjrCPLx68fAQXKz9/mP0alJQSPe3WYFuwuVOU9JymAE5F3AHWiceJESnsVpk
	 6fA04PA9H0l5KCMadhQDsjEJMAFzus5qORqM/XG3vscQ2B332l+4n9HCe2V6GIpmzM
	 7KwfonNFuvWxcGB+3ZMXP8PdvA4fmrwj1AwicdMhdliZOQio4YPjPd+APrw1HQhs6X
	 iLcRNxiuPawgA==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v4 2/4] NFSD: refactor nfsd_read_vector_dio to EVENT_CLASS useful for READ and WRITE
Date: Tue,  5 Aug 2025 14:44:26 -0400
Message-ID: <20250805184428.5848-3-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250805184428.5848-1-snitzer@kernel.org>
References: <20250805184428.5848-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Transform nfsd_read_vector_dio trace event into nfsd_analyze_dio_class
and use it to create nfsd_analyze_read_dio and nfsd_analyze_write_dio
trace events.

This prepares for nfsd_vfs_write() to also make use of it when
handling misaligned WRITEs.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/trace.h | 52 ++++++++++++++++++++++++++++++++++++-------------
 fs/nfsd/vfs.c   | 11 ++++++-----
 2 files changed, 44 insertions(+), 19 deletions(-)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 55055482f8a84..4173bd9344b6b 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -473,25 +473,29 @@ DEFINE_NFSD_IO_EVENT(write_done);
 DEFINE_NFSD_IO_EVENT(commit_start);
 DEFINE_NFSD_IO_EVENT(commit_done);
 
-TRACE_EVENT(nfsd_read_vector_dio,
+DECLARE_EVENT_CLASS(nfsd_analyze_dio_class,
 	TP_PROTO(struct svc_rqst *rqstp,
 		 struct svc_fh	*fhp,
 		 u64		offset,
 		 u32		len,
-		 loff_t         start,
-		 loff_t         start_extra,
-		 loff_t         end,
-		 loff_t         end_extra),
-	TP_ARGS(rqstp, fhp, offset, len, start, start_extra, end, end_extra),
+		 loff_t		start,
+		 ssize_t	start_len,
+		 loff_t		middle,
+		 ssize_t	middle_len,
+		 loff_t		end,
+		 ssize_t	end_len),
+	TP_ARGS(rqstp, fhp, offset, len, start, start_len, middle, middle_len, end, end_len),
 	TP_STRUCT__entry(
 		__field(u32, xid)
 		__field(u32, fh_hash)
 		__field(u64, offset)
 		__field(u32, len)
 		__field(loff_t, start)
-		__field(loff_t, start_extra)
+		__field(ssize_t, start_len)
+		__field(loff_t, middle)
+		__field(ssize_t, middle_len)
 		__field(loff_t, end)
-		__field(loff_t, end_extra)
+		__field(ssize_t, end_len)
 	),
 	TP_fast_assign(
 		__entry->xid = be32_to_cpu(rqstp->rq_xid);
@@ -499,16 +503,36 @@ TRACE_EVENT(nfsd_read_vector_dio,
 		__entry->offset = offset;
 		__entry->len = len;
 		__entry->start = start;
-		__entry->start_extra = start_extra;
+		__entry->start_len = start_len;
+		__entry->middle = middle;
+		__entry->middle_len = middle_len;
 		__entry->end = end;
-		__entry->end_extra = end_extra;
+		__entry->end_len = end_len;
 	),
-	TP_printk("xid=0x%08x fh_hash=0x%08x offset=%llu len=%u start=%llu+%llu end=%llu-%llu",
+	TP_printk("xid=0x%08x fh_hash=0x%08x offset=%llu len=%u start=%llu+%lu middle=%llu+%lu end=%llu+%lu",
 		  __entry->xid, __entry->fh_hash,
 		  __entry->offset, __entry->len,
-		  __entry->start, __entry->start_extra,
-		  __entry->end, __entry->end_extra)
-);
+		  __entry->start, __entry->start_len,
+		  __entry->middle, __entry->middle_len,
+		  __entry->end, __entry->end_len)
+)
+
+#define DEFINE_NFSD_ANALYZE_DIO_EVENT(name)			\
+DEFINE_EVENT(nfsd_analyze_dio_class, nfsd_analyze_##name##_dio,	\
+	TP_PROTO(struct svc_rqst *rqstp,			\
+		 struct svc_fh	*fhp,				\
+		 u64		offset,				\
+		 u32		len,				\
+		 loff_t		start,				\
+		 ssize_t	start_len,			\
+		 loff_t		middle,				\
+		 ssize_t	middle_len,			\
+		 loff_t		end,				\
+		 ssize_t	end_len),			\
+	TP_ARGS(rqstp, fhp, offset, len, start, start_len, middle, middle_len, end, end_len))
+
+DEFINE_NFSD_ANALYZE_DIO_EVENT(read);
+DEFINE_NFSD_ANALYZE_DIO_EVENT(write);
 
 DECLARE_EVENT_CLASS(nfsd_err_class,
 	TP_PROTO(struct svc_rqst *rqstp,
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index e1751d3715264..609b85f8bde3e 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -1094,7 +1094,7 @@ static bool nfsd_analyze_read_dio(struct svc_rqst *rqstp, struct svc_fh *fhp,
 				  struct nfsd_read_dio *read_dio)
 {
 	const u32 dio_blocksize = nf->nf_dio_read_offset_align;
-	loff_t orig_end = offset + len;
+	loff_t middle_end, orig_end = offset + len;
 
 	if (WARN_ONCE(!nf->nf_dio_mem_align || !nf->nf_dio_read_offset_align,
 		      "%s: underlying filesystem has not provided DIO alignment info\n",
@@ -1133,10 +1133,11 @@ static bool nfsd_analyze_read_dio(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	}
 
 	/* Show original offset and count, and how it was expanded for DIO */
-	trace_nfsd_read_vector_dio(rqstp, fhp, offset, len,
-				   read_dio->start, read_dio->start_extra,
-				   read_dio->end, read_dio->end_extra);
-
+	middle_end = read_dio->end - read_dio->end_extra;
+	trace_nfsd_analyze_read_dio(rqstp, fhp, offset, len,
+				    read_dio->start, read_dio->start_extra,
+				    offset, (middle_end - offset),
+				    middle_end, read_dio->end_extra);
 	return true;
 }
 
-- 
2.44.0


