Return-Path: <linux-nfs+bounces-13326-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 198ABB16930
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Jul 2025 01:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C24B582380
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Jul 2025 23:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD508226CF7;
	Wed, 30 Jul 2025 23:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k47sEsaP"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9314376
	for <linux-nfs@vger.kernel.org>; Wed, 30 Jul 2025 23:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753916727; cv=none; b=i/uGMMZH4xFsDwBzYtPdv8xhUU93tIwZZ97mAgg+Q/gHWLcL1dVvnwXL6fGotjTFCavAVHWXeI7BLuFaPD8cvHF51td3kaZFk/9wiJ8/4MQ5K7xwRKanDrMetVcxAKj6F/4tVyPR6F0QYEXW1nJGVP4ieT+L+IMYgr2DtfcNq2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753916727; c=relaxed/simple;
	bh=4jvn4Rcy5X5jDnYwOVFN0oThrRoTKiG4sPQaPiGFjLk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FqTEE7/rq1cuS1cxVicmGWaEkdcbyhnxGOY6GQpq9aSrh1Z8d98NR1PpBlsM8zrgzeV5O9R5vYsYmOJKQ7Id/Z9QyGjUXcI9O+5FGWftyovY3sv+VwQeOMFC3/1oPEcLI9QCm/3UTJ9sfDMsfrQ7FGxqt7ODJ4fJ6r5ReJ7s2kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k47sEsaP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15B44C4CEF7;
	Wed, 30 Jul 2025 23:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753916727;
	bh=4jvn4Rcy5X5jDnYwOVFN0oThrRoTKiG4sPQaPiGFjLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=k47sEsaPiJqGYQPF17Mx2gcwunCuBBxA/WuZ0OUcylXn9IIO2Sx7LJVcKel0hQYv0
	 VmVs/VIkf+/Mz6MD4JmWO6B10irOX6yOZxRSyveDFncRh/D3SfF9Y7RSvcn/OBhwVE
	 XAWiprcyXjnmA7redyy5/6J4GRkoO3r0egs8XT8i3L5bpM3gxGv3ViHS3TXscqWfW5
	 k33tGLM1n0YrNYS/dAi2MNsnWCTHYZgjNaKkCcq1FqUFvBcO0epn44vpGl9MNek7Oh
	 BAASm9ZFJfXp1MIt+8cPCpwmZx+zrDXSzyfaYU6TPtBm/X7BUwNo0CkbkNwIx5M982
	 apzacnnKKOmAQ==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH 1/3] NFSD: rename and update nfsd_read_vector_dio trace event to nfsd_analyze_dio
Date: Wed, 30 Jul 2025 19:05:22 -0400
Message-ID: <20250730230524.84976-2-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250730230524.84976-1-snitzer@kernel.org>
References: <20250730230524.84976-1-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mike Snitzer <snitzer@hammerspace.com>

Rename nfsd_read_vector_dio trace event to nfsd_analyze_dio and update
it so that it provides useful tracing for both READ and WRITE.  This
prepares for nfsd_vfs_write() to also make use of it when handling
misaligned WRITEs.

Signed-off-by: Mike Snitzer <snitzer@hammerspace.com>
---
 fs/nfsd/trace.h | 37 ++++++++++++++++++++++++-------------
 fs/nfsd/vfs.c   | 11 ++++++-----
 2 files changed, 30 insertions(+), 18 deletions(-)

diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 55055482f8a8..51b47fd041a8 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -473,41 +473,52 @@ DEFINE_NFSD_IO_EVENT(write_done);
 DEFINE_NFSD_IO_EVENT(commit_start);
 DEFINE_NFSD_IO_EVENT(commit_done);
 
-TRACE_EVENT(nfsd_read_vector_dio,
+TRACE_EVENT(nfsd_analyze_dio,
 	TP_PROTO(struct svc_rqst *rqstp,
 		 struct svc_fh	*fhp,
+		 u32		rw,
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
+	TP_ARGS(rqstp, fhp, rw, offset, len, start, start_len, middle, middle_len, end, end_len),
 	TP_STRUCT__entry(
 		__field(u32, xid)
 		__field(u32, fh_hash)
+		__field(u32, rw)
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
 		__entry->fh_hash = knfsd_fh_hash(&fhp->fh_handle);
+		__entry->rw = rw;
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
+	TP_printk("xid=0x%08x fh_hash=0x%08x %s offset=%llu len=%u start=%llu+%lu middle=%llu+%lu end=%llu+%lu",
 		  __entry->xid, __entry->fh_hash,
+		  __entry->rw ? "WRITE" : "READ",
 		  __entry->offset, __entry->len,
-		  __entry->start, __entry->start_extra,
-		  __entry->end, __entry->end_extra)
+		  __entry->start, __entry->start_len,
+		  __entry->middle, __entry->middle_len,
+		  __entry->end, __entry->end_len)
 );
 
 DECLARE_EVENT_CLASS(nfsd_err_class,
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 46189020172f..0863350c4259 100644
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
+	trace_nfsd_analyze_dio(rqstp, fhp, READ, offset, len,
+			       read_dio->start, read_dio->start_extra,
+			       offset, (middle_end - offset),
+			       middle_end, read_dio->end_extra);
 	return true;
 }
 
-- 
2.44.0


