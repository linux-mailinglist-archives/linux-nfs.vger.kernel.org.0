Return-Path: <linux-nfs+bounces-13366-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 711DCB17942
	for <lists+linux-nfs@lfdr.de>; Fri,  1 Aug 2025 01:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7BED1C266DE
	for <lists+linux-nfs@lfdr.de>; Thu, 31 Jul 2025 23:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961A227EC73;
	Thu, 31 Jul 2025 23:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gT7jXEdg"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA0227E1D0
	for <linux-nfs@vger.kernel.org>; Thu, 31 Jul 2025 23:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754003199; cv=none; b=XOJMBG0ZeQABIKAe/3IrIZMmx9N48PsxNATx4DuTDhYfZWzgcyBxSBNC4slFu5Wcy4udcwpLWawSOBWvYUxq7233QGnw8BOt29ed0xsel9wLDJzYVYkPJimGWZ+/uMaG2B08BnrZdVs3z0hY/V1G24td1ZYgEIgFUqyiuOh1wiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754003199; c=relaxed/simple;
	bh=oPP4kHzzuG4ViNpSECWUincQ7pb870xxfg1fZN1+VUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=leRpX8rPa0fGWVl7+Hg8C838kD34S0DzFHxW9PeT3nZQYVPaBjzsMYqjUhc9rZDACwmT4e2nhfC5zHnBtGY/3ymaTtiCH49JQtoc6S6d6lYYVOl8DSvg2iMnhTPpKZp237sOzXDhJnrOuVJfkxUqNv6BZRqCK+yfUXqwHIggP+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gT7jXEdg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD61EC4CEF4;
	Thu, 31 Jul 2025 23:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754003196;
	bh=oPP4kHzzuG4ViNpSECWUincQ7pb870xxfg1fZN1+VUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gT7jXEdgvsPFjnOP+rb7CZs5xUjjSSwGRHciff+9n6DX8zOUpp9YynXhTbsegznqQ
	 E5GJQH0kqLHMF7M71rzlB4OFvKbqzEYq6ddkk8SpozWBn80UP6aXpilxwXy6jGHzCs
	 cmTuu3JKyrc9HoBNsEIXFQXTbr6rjZVyZcd4IADYAu6T5DJ9Aq70hOW+kfIl1x/QYp
	 k+6fR61O2v6ZyR0jLlUY2kWMSsMBbUpu2LbOTUIdZvGQwE7GtWhkfNMs0S4blUo4Mh
	 wGz3CUIzuWzuK4urIsYiFDks67gZmSmEdTfFKohrV/mhmthwTq739s8Jx451bcy8hV
	 8qvhIifxOjYIA==
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org
Subject: [PATCH v3 1/4] NFSD: refactor nfsd_read_vector_dio to EVENT_CLASS useful for READ and WRITE
Date: Thu, 31 Jul 2025 19:06:30 -0400
Message-ID: <20250731230633.89983-2-snitzer@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20250731230633.89983-1-snitzer@kernel.org>
References: <20250731230633.89983-1-snitzer@kernel.org>
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
index 46189020172fb..35c29b8ade9c3 100644
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


