Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0A8299612
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Oct 2020 19:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781840AbgJZSz1 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Oct 2020 14:55:27 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:33228 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1780843AbgJZSz0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Oct 2020 14:55:26 -0400
Received: by mail-qv1-f66.google.com with SMTP id w9so4836145qvj.0;
        Mon, 26 Oct 2020 11:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=pwlWqdUZIEkYkK9f30HVQeJD00T2Q9dGcArjB32xi2c=;
        b=u4SqqDZZyKu350YQ+yuUhztJK27jPmFRDoS9lL846Kz2yam4ePDCwsxWbu0gB40H0d
         Sb4cfDFFG0TMUMHxugShcNBgmWQZAKnIZXLNmCEn+dzllAsKXK9wqydCrQndlgWAGDCJ
         2RzWfTg5jDInBQsAEGcB82hX1OSCD6F1mHloye35RrPTzBNgW4LiRiiAdJ1WshRU9JO0
         B/ut2HY2cR/yqlUMAWz08OS35ajqzNiwfnuitYvQQ2WPgWIcy9jA6SGsy2MpDgAC9PvK
         00I148TbyLgUOYNsKAY4qZA0mw+ud9BdMdvqFfiUXVLdi6ahaWcnxX8+ZJKza/HorWhH
         ugpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=pwlWqdUZIEkYkK9f30HVQeJD00T2Q9dGcArjB32xi2c=;
        b=FSqrG+8AhmXu9ZBhXaeTxvGwH3n35zwKDcws3Q2tyP//1hCombNm0CVTq1NcvMsS7/
         FboW5CqK3szubrt0DfzztIcrIaO8FQ71Hopb7mNsnpJjrvisWhCAHBMIl2pEDVcrZoBW
         8qh3lKGlZFHXo/nA6Gj8M0IsPBoF8W24j+h4wEYYbvvdIkbMRlISA9ogOBkBIw1QV5IM
         2ynpH5h1d/TsYUbvw37q3hUvxlA8Q/UJ4UUjKLXPVNGxbGYmMz+iH8vkyXSiXNLpnV/J
         NMAoxOi3xy0vPRC4ZyJ6s1kUkXMLq1BOIrVzbV5YiWrD/gd/oz5fOfkqfK03gBcdLENs
         yt/Q==
X-Gm-Message-State: AOAM531xkbZKGqCKXuxPamyeTw28K+dgsZOSyXHtW4b62ci84iISCmh/
        YFupmDumngBJ47okgXiJpp4DFFYpvAE=
X-Google-Smtp-Source: ABdhPJxrsDAh9YWoosbMJ9p/Jn8dUoJM80/8M4OijANZs29Si5JLg/2XU5Hh+kfPyISvyPyrLzukLQ==
X-Received: by 2002:a0c:a482:: with SMTP id x2mr19173200qvx.47.1603738524787;
        Mon, 26 Oct 2020 11:55:24 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id 9sm7333699qkv.110.2020.10.26.11.55.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2020 11:55:24 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 09QItNxO013664;
        Mon, 26 Oct 2020 18:55:23 GMT
Subject: [PATCH 17/20] svcrdma: Clean up chunk tracepoints
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 26 Oct 2020 14:55:23 -0400
Message-ID: <160373852307.1886.2787183721434561772.stgit@klimt.1015granger.net>
In-Reply-To: <160373843299.1886.12604782813896379719.stgit@klimt.1015granger.net>
References: <160373843299.1886.12604782813896379719.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We already have trace_svcrdma_decode_rseg(), which records each
ingress Read segment. Instead of reporting those again when they
are about to be posted as RDMA Reads, let's fire one tracepoint
before posting each type of chunk.

So we'll get:

        nfsd-1998  [002]   321.666615: svcrdma_decode_rseg:  cq.id=4 cid=42 segno=0 position=0 192@0x013ca9ebfae14000:0xb0010b05
        nfsd-1998  [002]   321.666615: svcrdma_decode_rseg:  cq.id=4 cid=42 segno=1 position=0 7688@0x013ca9ebf914e000:0xb0010a05
        nfsd-1998  [002]   321.666615: svcrdma_decode_rseg:  cq.id=4 cid=42 segno=2 position=0 28@0x013ca9ebfae15000:0xb0010905
        nfsd-1998  [002]   321.666622: svcrdma_decode_rqst:  cq.id=4 cid=42 xid=0x013ca9eb vers=1 credits=128 proc=RDMA_NOMSG hdrlen=100

        nfsd-1998  [002]   321.666642: svcrdma_post_read_chunk: cq.id=3 cid=112 sqecount=3

kworker/2:1H-221   [002]   321.673949: svcrdma_wc_read:      cq.id=3 cid=112 status=SUCCESS (0/0x0)

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h        |  110 ++++-----------------------------
 net/sunrpc/xprtrdma/svc_rdma_rw.c     |   27 ++++----
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |    2 -
 3 files changed, 26 insertions(+), 113 deletions(-)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index 054dedd0280c..896aafc37b09 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -1410,45 +1410,6 @@ DEFINE_BADREQ_EVENT(drop);
 DEFINE_BADREQ_EVENT(badproc);
 DEFINE_BADREQ_EVENT(parse);
 
-DECLARE_EVENT_CLASS(svcrdma_segment_event,
-	TP_PROTO(
-		u32 handle,
-		u32 length,
-		u64 offset
-	),
-
-	TP_ARGS(handle, length, offset),
-
-	TP_STRUCT__entry(
-		__field(u32, handle)
-		__field(u32, length)
-		__field(u64, offset)
-	),
-
-	TP_fast_assign(
-		__entry->handle = handle;
-		__entry->length = length;
-		__entry->offset = offset;
-	),
-
-	TP_printk("%u@0x%016llx:0x%08x",
-		__entry->length, (unsigned long long)__entry->offset,
-		__entry->handle
-	)
-);
-
-#define DEFINE_SEGMENT_EVENT(name)					\
-		DEFINE_EVENT(svcrdma_segment_event, svcrdma_##name,\
-				TP_PROTO(				\
-					u32 handle,			\
-					u32 length,			\
-					u64 offset			\
-				),					\
-				TP_ARGS(handle, length, offset))
-
-DEFINE_SEGMENT_EVENT(send_rseg);
-DEFINE_SEGMENT_EVENT(send_wseg);
-
 TRACE_EVENT(svcrdma_encode_wseg,
 	TP_PROTO(
 		const struct svc_rdma_send_ctxt *ctxt,
@@ -1558,62 +1519,6 @@ TRACE_EVENT(svcrdma_decode_wseg,
 	)
 );
 
-DECLARE_EVENT_CLASS(svcrdma_chunk_event,
-	TP_PROTO(
-		u32 length
-	),
-
-	TP_ARGS(length),
-
-	TP_STRUCT__entry(
-		__field(u32, length)
-	),
-
-	TP_fast_assign(
-		__entry->length = length;
-	),
-
-	TP_printk("length=%u",
-		__entry->length
-	)
-);
-
-#define DEFINE_CHUNK_EVENT(name)					\
-		DEFINE_EVENT(svcrdma_chunk_event, svcrdma_##name,	\
-				TP_PROTO(				\
-					u32 length			\
-				),					\
-				TP_ARGS(length))
-
-DEFINE_CHUNK_EVENT(send_pzr);
-DEFINE_CHUNK_EVENT(encode_write_chunk);
-DEFINE_CHUNK_EVENT(send_write_chunk);
-DEFINE_CHUNK_EVENT(encode_read_chunk);
-DEFINE_CHUNK_EVENT(send_reply_chunk);
-
-TRACE_EVENT(svcrdma_send_read_chunk,
-	TP_PROTO(
-		u32 length,
-		u32 position
-	),
-
-	TP_ARGS(length, position),
-
-	TP_STRUCT__entry(
-		__field(u32, length)
-		__field(u32, position)
-	),
-
-	TP_fast_assign(
-		__entry->length = length;
-		__entry->position = position;
-	),
-
-	TP_printk("length=%u position=%u",
-		__entry->length, __entry->position
-	)
-);
-
 DECLARE_EVENT_CLASS(svcrdma_error_event,
 	TP_PROTO(
 		__be32 xid
@@ -1936,7 +1841,7 @@ TRACE_EVENT(svcrdma_rq_post_err,
 	)
 );
 
-TRACE_EVENT(svcrdma_post_chunk,
+DECLARE_EVENT_CLASS(svcrdma_post_chunk_class,
 	TP_PROTO(
 		const struct rpc_rdma_cid *cid,
 		int sqecount
@@ -1962,6 +1867,19 @@ TRACE_EVENT(svcrdma_post_chunk,
 	)
 );
 
+#define DEFINE_POST_CHUNK_EVENT(name)					\
+		DEFINE_EVENT(svcrdma_post_chunk_class,			\
+				svcrdma_post_##name##_chunk,		\
+				TP_PROTO(				\
+					const struct rpc_rdma_cid *cid,	\
+					int sqecount			\
+				),					\
+				TP_ARGS(cid, sqecount))
+
+DEFINE_POST_CHUNK_EVENT(read);
+DEFINE_POST_CHUNK_EVENT(write);
+DEFINE_POST_CHUNK_EVENT(reply);
+
 DEFINE_COMPLETION_EVENT(svcrdma_wc_read);
 DEFINE_COMPLETION_EVENT(svcrdma_wc_write);
 
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 4efa1fa3f6fb..0de95207eaf1 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -358,7 +358,6 @@ static int svc_rdma_post_chunk_ctxt(struct svc_rdma_chunk_ctxt *cc)
 	do {
 		if (atomic_sub_return(cc->cc_sqecount,
 				      &rdma->sc_sq_avail) > 0) {
-			trace_svcrdma_post_chunk(&cc->cc_cid, cc->cc_sqecount);
 			ret = ib_post_send(rdma->sc_qp, first_wr, &bad_wr);
 			if (ret)
 				break;
@@ -468,8 +467,6 @@ svc_rdma_build_writes(struct svc_rdma_write_info *info,
 		if (ret < 0)
 			return -EIO;
 
-		trace_svcrdma_send_wseg(seg->rs_handle, write_len, offset);
-
 		list_add(&ctxt->rw_list, &cc->cc_rwctxts);
 		cc->cc_sqecount += ret;
 		if (write_len == seg->rs_length - info->wi_seg_off) {
@@ -588,21 +585,22 @@ int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma,
 			      const struct xdr_buf *xdr)
 {
 	struct svc_rdma_write_info *info;
+	struct svc_rdma_chunk_ctxt *cc;
 	int ret;
 
 	info = svc_rdma_write_info_alloc(rdma, chunk);
 	if (!info)
 		return -ENOMEM;
+	cc = &info->wi_cc;
 
 	ret = svc_rdma_xb_write(xdr, info);
 	if (ret != xdr->len)
 		goto out_err;
 
-	ret = svc_rdma_post_chunk_ctxt(&info->wi_cc);
+	trace_svcrdma_post_write_chunk(&cc->cc_cid, cc->cc_sqecount);
+	ret = svc_rdma_post_chunk_ctxt(cc);
 	if (ret < 0)
 		goto out_err;
-
-	trace_svcrdma_send_write_chunk(xdr->page_len);
 	return xdr->len;
 
 out_err:
@@ -628,6 +626,7 @@ int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma,
 			      const struct xdr_buf *xdr)
 {
 	struct svc_rdma_write_info *info;
+	struct svc_rdma_chunk_ctxt *cc;
 	struct svc_rdma_chunk *chunk;
 	int ret;
 
@@ -638,17 +637,18 @@ int svc_rdma_send_reply_chunk(struct svcxprt_rdma *rdma,
 	info = svc_rdma_write_info_alloc(rdma, chunk);
 	if (!info)
 		return -ENOMEM;
+	cc = &info->wi_cc;
 
 	ret = pcl_process_nonpayloads(&rctxt->rc_write_pcl, xdr,
 				      svc_rdma_xb_write, info);
 	if (ret < 0)
 		goto out_err;
 
-	ret = svc_rdma_post_chunk_ctxt(&info->wi_cc);
+	trace_svcrdma_post_reply_chunk(&cc->cc_cid, cc->cc_sqecount);
+	ret = svc_rdma_post_chunk_ctxt(cc);
 	if (ret < 0)
 		goto out_err;
 
-	trace_svcrdma_send_reply_chunk(xdr->len);
 	return xdr->len;
 
 out_err:
@@ -735,10 +735,8 @@ static int svc_rdma_build_read_chunk(struct svc_rqst *rqstp,
 		if (ret < 0)
 			break;
 
-		trace_svcrdma_send_rseg(handle, length, offset);
 		info->ri_chunklen += length;
 	}
-
 	return ret;
 }
 
@@ -760,8 +758,6 @@ static int svc_rdma_build_normal_read_chunk(struct svc_rqst *rqstp,
 	if (ret < 0)
 		goto out;
 
-	trace_svcrdma_send_read_chunk(info->ri_chunklen, info->ri_position);
-
 	head->rc_hdr_count = 0;
 
 	/* Split the Receive buffer between the head and tail
@@ -816,8 +812,6 @@ static int svc_rdma_build_pz_read_chunk(struct svc_rqst *rqstp,
 	if (ret < 0)
 		goto out;
 
-	trace_svcrdma_send_pzr(info->ri_chunklen);
-
 	head->rc_arg.len += info->ri_chunklen;
 	head->rc_arg.buflen += info->ri_chunklen;
 
@@ -874,6 +868,7 @@ int svc_rdma_recv_read_chunk(struct svcxprt_rdma *rdma, struct svc_rqst *rqstp,
 			     struct svc_rdma_recv_ctxt *head, __be32 *p)
 {
 	struct svc_rdma_read_info *info;
+	struct svc_rdma_chunk_ctxt *cc;
 	int ret;
 
 	/* The request (with page list) is constructed in
@@ -891,6 +886,7 @@ int svc_rdma_recv_read_chunk(struct svcxprt_rdma *rdma, struct svc_rqst *rqstp,
 	info = svc_rdma_read_info_alloc(rdma);
 	if (!info)
 		return -ENOMEM;
+	cc = &info->ri_cc;
 	info->ri_readctxt = head;
 	info->ri_pageno = 0;
 	info->ri_pageoff = 0;
@@ -903,7 +899,8 @@ int svc_rdma_recv_read_chunk(struct svcxprt_rdma *rdma, struct svc_rqst *rqstp,
 	if (ret < 0)
 		goto out_err;
 
-	ret = svc_rdma_post_chunk_ctxt(&info->ri_cc);
+	trace_svcrdma_post_read_chunk(&cc->cc_cid, cc->cc_sqecount);
+	ret = svc_rdma_post_chunk_ctxt(cc);
 	if (ret < 0)
 		goto out_err;
 	svc_rdma_save_io_pages(rqstp, 0, head->rc_page_count);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 7d35bd6224ea..035eb99b8ede 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -411,8 +411,6 @@ static ssize_t svc_rdma_encode_write_chunk(struct svc_rdma_send_ctxt *sctxt,
 	unsigned int segno;
 	ssize_t len, ret;
 
-	trace_svcrdma_encode_write_chunk(remaining);
-
 	len = 0;
 	ret = xdr_stream_encode_item_present(&sctxt->sc_stream);
 	if (ret < 0)


