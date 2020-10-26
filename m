Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 472402995FB
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Oct 2020 19:54:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1781690AbgJZSyl (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Oct 2020 14:54:41 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:35100 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1781703AbgJZSyk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Oct 2020 14:54:40 -0400
Received: by mail-qk1-f196.google.com with SMTP id 140so9395811qko.2;
        Mon, 26 Oct 2020 11:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=wu3XOdGbkHibd96A6V6XV5F8it0NUJhYHwRFYpHKKcY=;
        b=ntS/AAZdDqY5VuKVb0j7GpI9CQ7JFYri6JobA2wEMtznMVUTCvdLUhhtsjEMuc0OKX
         voRO2XZ+BjM8BvC7BKX6ZSVry/meAv5NWPuYUwj3AVDkNgb0501m5CKB7pLycoAa+yXe
         iFNxRfjeJr5P05vxOA8I7Ob+KvREX1MMMitCnCjFIqCiVk7Fc08WVBlpDiEH5rJuipot
         yZS9d56L5L2EwgR438kP4v2Gbxylqmy670LwK5WT9tSp0VHbSyMe9M0y72AEF7XTSOIp
         UXN3MA1dvsdANwGmuX5zdhVxggweobfq+1Ccfwlpj8ER2uNdaU97ZdP4iZztKWJ6He8K
         DaaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=wu3XOdGbkHibd96A6V6XV5F8it0NUJhYHwRFYpHKKcY=;
        b=aJkhHO35IXlqZmwqWzqULKsFLjMSBVKfaLLMAA8mnkg6kHJ3o32D+DfllhsKd1g2k6
         NCYhJYnX7s11p84zUq+BZMjMbGNqZw12v/xPCRzqaZ0+ylpGCEq4rnhSCGRrKTy4Hf1E
         f7YKXUzSXX/VTHvAAy8cqCEYQMJuq2gd+4Sel4mhOCgUF7qB4e9Q66u2KgY7tfI5jwH1
         P0J3+5GWrkgLjP06MEf8kEqLJ/x7ciUbQdYUbTV1hnUU5gdpOQlQIA0YzyoTWeFcVEMi
         xSxyy4kpuMjobmmicttrC4aDC4LWuAuHjCpVmVa1LlLtLdEl1epjDmmwcvMLhp6F8dq6
         jljQ==
X-Gm-Message-State: AOAM530oVodMeNfRaJ29s3ru0lamy+7eqGjlTTz6hdiSNXhSsXOlx9M8
        mc5O9qQcPCLKIGr5NOwIpnUFOYtvqLs=
X-Google-Smtp-Source: ABdhPJwkfvRrd+8Wr8AHVBsJ0RbuzCakg82wrzURNaeBby8GlziJ5pNqiDmC1WZWl18YuGXbotGUHA==
X-Received: by 2002:a05:620a:1221:: with SMTP id v1mr18531416qkj.98.1603738477360;
        Mon, 26 Oct 2020 11:54:37 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id f4sm7419742qtd.35.2020.10.26.11.54.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2020 11:54:36 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 09QIsZRH013637;
        Mon, 26 Oct 2020 18:54:35 GMT
Subject: [PATCH 08/20] svcrdma: Add a "parsed chunk list" data structure
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 26 Oct 2020 14:54:35 -0400
Message-ID: <160373847543.1886.8846090291470374221.stgit@klimt.1015granger.net>
In-Reply-To: <160373843299.1886.12604782813896379719.stgit@klimt.1015granger.net>
References: <160373843299.1886.12604782813896379719.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This simple data structure binds the location of each data payload
inside of an RPC message to the chunk that will be used to push it
to or pull it from the client.

There are several benefits to this small additional overhead:

 * It enables support for more than one chunk in incoming Read and
   Write lists.

 * It translates the version-specific on-the-wire format into a
   generic in-memory structure, enabling support for multiple
   versions of the RPC/RDMA transport protocol.

 * It enables the server to re-organize a chunk list if it needs to
   adjust where Read chunk data lands in server memory without
   altering the contents of the XDR-encoded Receive buffer.

Construction of these lists is done while sanity checking each
incoming RPC/RDMA header. Subsequent patches will make use of the
generated data structures.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/svc_rdma.h         |   12 +
 include/linux/sunrpc/svc_rdma_pcl.h     |  128 +++++++++++++
 include/trace/events/rpcrdma.h          |   75 +++++++-
 net/sunrpc/xprtrdma/Makefile            |    2 
 net/sunrpc/xprtrdma/svc_rdma_pcl.c      |  306 +++++++++++++++++++++++++++++++
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |  196 ++++++++++++--------
 6 files changed, 635 insertions(+), 84 deletions(-)
 create mode 100644 include/linux/sunrpc/svc_rdma_pcl.h
 create mode 100644 net/sunrpc/xprtrdma/svc_rdma_pcl.c

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index f5a3c852bb90..a89d4209fe2a 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -47,6 +47,8 @@
 #include <linux/sunrpc/svcsock.h>
 #include <linux/sunrpc/rpc_rdma.h>
 #include <linux/sunrpc/rpc_rdma_cid.h>
+#include <linux/sunrpc/svc_rdma_pcl.h>
+
 #include <rdma/ib_verbs.h>
 #include <rdma/rdma_cm.h>
 
@@ -142,8 +144,18 @@ struct svc_rdma_recv_ctxt {
 	unsigned int		rc_page_count;
 	unsigned int		rc_hdr_count;
 	u32			rc_inv_rkey;
+
+	struct svc_rdma_pcl	rc_call_pcl;
+
+	struct svc_rdma_pcl	rc_read_pcl;
+
 	__be32			*rc_write_list;
+	struct svc_rdma_chunk	*rc_cur_result_payload;
+	struct svc_rdma_pcl	rc_write_pcl;
+
 	__be32			*rc_reply_chunk;
+	struct svc_rdma_pcl	rc_reply_pcl;
+
 	unsigned int		rc_read_payload_offset;
 	unsigned int		rc_read_payload_length;
 	struct page		*rc_pages[RPCSVC_MAXPAGES];
diff --git a/include/linux/sunrpc/svc_rdma_pcl.h b/include/linux/sunrpc/svc_rdma_pcl.h
new file mode 100644
index 000000000000..7516ad0fae80
--- /dev/null
+++ b/include/linux/sunrpc/svc_rdma_pcl.h
@@ -0,0 +1,128 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2020, Oracle and/or its affiliates
+ */
+
+#ifndef SVC_RDMA_PCL_H
+#define SVC_RDMA_PCL_H
+
+#include <linux/list.h>
+
+struct svc_rdma_segment {
+	u32			rs_handle;
+	u32			rs_length;
+	u64			rs_offset;
+};
+
+struct svc_rdma_chunk {
+	struct list_head	ch_list;
+
+	u32			ch_position;
+	u32			ch_length;
+	u32			ch_payload_length;
+
+	u32			ch_segcount;
+	struct svc_rdma_segment	ch_segments[];
+};
+
+struct svc_rdma_pcl {
+	unsigned int		cl_count;
+	struct list_head	cl_chunks;
+};
+
+/**
+ * pcl_init - Initialize a parsed chunk list
+ * @pcl: parsed chunk list to initialize
+ *
+ */
+static inline void pcl_init(struct svc_rdma_pcl *pcl)
+{
+	INIT_LIST_HEAD(&pcl->cl_chunks);
+}
+
+/**
+ * pcl_is_empty - Return true if parsed chunk list is empty
+ * @pcl: parsed chunk list
+ *
+ */
+static inline bool pcl_is_empty(const struct svc_rdma_pcl *pcl)
+{
+	return list_empty(&pcl->cl_chunks);
+}
+
+/**
+ * pcl_first_chunk - Return first chunk in a parsed chunk list
+ * @pcl: parsed chunk list
+ *
+ * Returns the first chunk in the list, or NULL if the list is empty.
+ */
+static inline struct svc_rdma_chunk *
+pcl_first_chunk(const struct svc_rdma_pcl *pcl)
+{
+	if (pcl_is_empty(pcl))
+		return NULL;
+	return list_first_entry(&pcl->cl_chunks, struct svc_rdma_chunk,
+				ch_list);
+}
+
+/**
+ * pcl_next_chunk - Return next chunk in a parsed chunk list
+ * @pcl: a parsed chunk list
+ * @chunk: chunk in @pcl
+ *
+ * Returns the next chunk in the list, or NULL if @chunk is already last.
+ */
+static inline struct svc_rdma_chunk *
+pcl_next_chunk(const struct svc_rdma_pcl *pcl, struct svc_rdma_chunk *chunk)
+{
+	if (list_is_last(&chunk->ch_list, &pcl->cl_chunks))
+		return NULL;
+	return list_next_entry(chunk, ch_list);
+}
+
+/**
+ * pcl_for_each_chunk - Iterate over chunks in a parsed chunk list
+ * @pos: the loop cursor
+ * @pcl: a parsed chunk list
+ */
+#define pcl_for_each_chunk(pos, pcl) \
+	for (pos = list_first_entry(&(pcl)->cl_chunks, struct svc_rdma_chunk, ch_list); \
+	     &pos->ch_list != &(pcl)->cl_chunks; \
+	     pos = list_next_entry(pos, ch_list))
+
+/**
+ * pcl_for_each_segment - Iterate over segments in a parsed chunk
+ * @pos: the loop cursor
+ * @chunk: a parsed chunk
+ */
+#define pcl_for_each_segment(pos, chunk) \
+	for (pos = &(chunk)->ch_segments[0]; \
+	     pos <= &(chunk)->ch_segments[(chunk)->ch_segcount - 1]; \
+	     pos++)
+
+/**
+ * pcl_chunk_end_offset - Return offset of byte range following @chunk
+ * @chunk: chunk in @pcl
+ *
+ * Returns starting offset of the region just after @chunk
+ */
+static inline unsigned int
+pcl_chunk_end_offset(const struct svc_rdma_chunk *chunk)
+{
+	return xdr_align_size(chunk->ch_position + chunk->ch_payload_length);
+}
+
+struct svc_rdma_recv_ctxt;
+
+extern void pcl_free(struct svc_rdma_pcl *pcl);
+extern bool pcl_alloc_call(struct svc_rdma_recv_ctxt *rctxt, __be32 *p);
+extern bool pcl_alloc_read(struct svc_rdma_recv_ctxt *rctxt, __be32 *p);
+extern bool pcl_alloc_write(struct svc_rdma_recv_ctxt *rctxt,
+			    struct svc_rdma_pcl *pcl, __be32 *p);
+extern int pcl_process_nonpayloads(const struct svc_rdma_pcl *pcl,
+				   const struct xdr_buf *xdr,
+				   int (*actor)(const struct xdr_buf *,
+						void *),
+				   void *data);
+
+#endif	/* SVC_RDMA_PCL_H */
diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index bf1065772228..72b941aef43b 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -1446,12 +1446,83 @@ DECLARE_EVENT_CLASS(svcrdma_segment_event,
 				),					\
 				TP_ARGS(handle, length, offset))
 
-DEFINE_SEGMENT_EVENT(decode_wseg);
-DEFINE_SEGMENT_EVENT(encode_rseg);
 DEFINE_SEGMENT_EVENT(send_rseg);
 DEFINE_SEGMENT_EVENT(encode_wseg);
 DEFINE_SEGMENT_EVENT(send_wseg);
 
+TRACE_EVENT(svcrdma_decode_rseg,
+	TP_PROTO(
+		const struct rpc_rdma_cid *cid,
+		const struct svc_rdma_chunk *chunk,
+		const struct svc_rdma_segment *segment
+	),
+
+	TP_ARGS(cid, chunk, segment),
+
+	TP_STRUCT__entry(
+		__field(u32, cq_id)
+		__field(int, completion_id)
+		__field(u32, segno)
+		__field(u32, position)
+		__field(u32, handle)
+		__field(u32, length)
+		__field(u64, offset)
+	),
+
+	TP_fast_assign(
+		__entry->cq_id = cid->ci_queue_id;
+		__entry->completion_id = cid->ci_completion_id;
+		__entry->segno = chunk->ch_segcount;
+		__entry->position = chunk->ch_position;
+		__entry->handle = segment->rs_handle;
+		__entry->length = segment->rs_length;
+		__entry->offset = segment->rs_offset;
+	),
+
+	TP_printk("cq_id=%u cid=%d segno=%u position=%u %u@0x%016llx:0x%08x",
+		__entry->cq_id, __entry->completion_id,
+		__entry->segno, __entry->position, __entry->length,
+		(unsigned long long)__entry->offset, __entry->handle
+	)
+);
+
+TRACE_EVENT(svcrdma_decode_wseg,
+	TP_PROTO(
+		const struct rpc_rdma_cid *cid,
+		const struct svc_rdma_chunk *chunk,
+		u32 segno
+	),
+
+	TP_ARGS(cid, chunk, segno),
+
+	TP_STRUCT__entry(
+		__field(u32, cq_id)
+		__field(int, completion_id)
+		__field(u32, segno)
+		__field(u32, handle)
+		__field(u32, length)
+		__field(u64, offset)
+	),
+
+	TP_fast_assign(
+		const struct svc_rdma_segment *segment =
+			&chunk->ch_segments[segno];
+
+		__entry->cq_id = cid->ci_queue_id;
+		__entry->completion_id = cid->ci_completion_id;
+		__entry->segno = segno;
+		__entry->handle = segment->rs_handle;
+		__entry->length = segment->rs_length;
+		__entry->offset = segment->rs_offset;
+	),
+
+	TP_printk("cq_id=%u cid=%d segno=%u %u@0x%016llx:0x%08x",
+		__entry->cq_id, __entry->completion_id,
+		__entry->segno, __entry->length,
+		(unsigned long long)__entry->offset, __entry->handle
+	)
+);
+
 DECLARE_EVENT_CLASS(svcrdma_chunk_event,
 	TP_PROTO(
 		u32 length
diff --git a/net/sunrpc/xprtrdma/Makefile b/net/sunrpc/xprtrdma/Makefile
index 8ed0377d7a18..55b21bae866d 100644
--- a/net/sunrpc/xprtrdma/Makefile
+++ b/net/sunrpc/xprtrdma/Makefile
@@ -4,5 +4,5 @@ obj-$(CONFIG_SUNRPC_XPRT_RDMA) += rpcrdma.o
 rpcrdma-y := transport.o rpc_rdma.o verbs.o frwr_ops.o \
 	svc_rdma.o svc_rdma_backchannel.o svc_rdma_transport.o \
 	svc_rdma_sendto.o svc_rdma_recvfrom.o svc_rdma_rw.o \
-	module.o
+	svc_rdma_pcl.o module.o
 rpcrdma-$(CONFIG_SUNRPC_BACKCHANNEL) += backchannel.o
diff --git a/net/sunrpc/xprtrdma/svc_rdma_pcl.c b/net/sunrpc/xprtrdma/svc_rdma_pcl.c
new file mode 100644
index 000000000000..b63cfeaa2923
--- /dev/null
+++ b/net/sunrpc/xprtrdma/svc_rdma_pcl.c
@@ -0,0 +1,306 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020 Oracle. All rights reserved.
+ */
+
+#include <linux/sunrpc/svc_rdma.h>
+#include <linux/sunrpc/rpc_rdma.h>
+
+#include "xprt_rdma.h"
+#include <trace/events/rpcrdma.h>
+
+/**
+ * pcl_free - Release all memory associated with a parsed chunk list
+ * @pcl: parsed chunk list
+ *
+ */
+void pcl_free(struct svc_rdma_pcl *pcl)
+{
+	while (!list_empty(&pcl->cl_chunks)) {
+		struct svc_rdma_chunk *chunk;
+
+		chunk = pcl_first_chunk(pcl);
+		list_del(&chunk->ch_list);
+		kfree(chunk);
+	}
+}
+
+static struct svc_rdma_chunk *pcl_alloc_chunk(u32 segcount, u32 position)
+{
+	struct svc_rdma_chunk *chunk;
+
+	chunk = kmalloc(struct_size(chunk, ch_segments, segcount), GFP_KERNEL);
+	if (!chunk)
+		return NULL;
+
+	chunk->ch_position = position;
+	chunk->ch_length = 0;
+	chunk->ch_payload_length = 0;
+	chunk->ch_segcount = 0;
+	return chunk;
+}
+
+static struct svc_rdma_chunk *
+pcl_lookup_position(struct svc_rdma_pcl *pcl, u32 position)
+{
+	struct svc_rdma_chunk *pos;
+
+	pcl_for_each_chunk(pos, pcl) {
+		if (pos->ch_position == position)
+			return pos;
+	}
+	return NULL;
+}
+
+static void pcl_insert_position(struct svc_rdma_pcl *pcl,
+				struct svc_rdma_chunk *chunk)
+{
+	struct svc_rdma_chunk *pos;
+
+	pcl_for_each_chunk(pos, pcl) {
+		if (pos->ch_position > chunk->ch_position)
+			break;
+	}
+	__list_add(&chunk->ch_list, pos->ch_list.prev, &pos->ch_list);
+	pcl->cl_count++;
+}
+
+static void pcl_set_read_segment(const struct svc_rdma_recv_ctxt *rctxt,
+				 struct svc_rdma_chunk *chunk,
+				 u32 handle, u32 length, u64 offset)
+{
+	struct svc_rdma_segment *segment;
+
+	segment = &chunk->ch_segments[chunk->ch_segcount];
+	segment->rs_handle = handle;
+	segment->rs_length = length;
+	segment->rs_offset = offset;
+
+	trace_svcrdma_decode_rseg(&rctxt->rc_cid, chunk, segment);
+
+	chunk->ch_length += length;
+	chunk->ch_segcount++;
+}
+
+/**
+ * pcl_alloc_call - Construct a parsed chunk list for the Call body
+ * @rctxt: Ingress receive context
+ * @p: Start of an un-decoded Read list
+ *
+ * Assumptions:
+ * - The incoming Read list has already been sanity checked.
+ * - cl_count is already set to the number of segments in
+ *   the un-decoded list.
+ * - The list might not be in order by position.
+ *
+ * Return values:
+ *       %true: Parsed chunk list was successfully constructed, and
+ *              cl_count is updated to be the number of chunks (ie.
+ *              unique positions) in the Read list.
+ *      %false: Memory allocation failed.
+ */
+bool pcl_alloc_call(struct svc_rdma_recv_ctxt *rctxt, __be32 *p)
+{
+	struct svc_rdma_pcl *pcl = &rctxt->rc_call_pcl;
+	unsigned int i, segcount = pcl->cl_count;
+
+	pcl->cl_count = 0;
+	for (i = 0; i < segcount; i++) {
+		struct svc_rdma_chunk *chunk;
+		u32 position, handle, length;
+		u64 offset;
+
+		p++;	/* skip the list discriminator */
+		p = xdr_decode_read_segment(p, &position, &handle,
+					    &length, &offset);
+		if (position != 0)
+			continue;
+
+		if (pcl_is_empty(pcl)) {
+			chunk = pcl_alloc_chunk(segcount, position);
+			if (!chunk)
+				return false;
+			pcl_insert_position(pcl, chunk);
+		} else {
+			chunk = list_first_entry(&pcl->cl_chunks,
+						 struct svc_rdma_chunk,
+						 ch_list);
+		}
+
+		pcl_set_read_segment(rctxt, chunk, handle, length, offset);
+	}
+
+	return true;
+}
+
+/**
+ * pcl_alloc_read - Construct a parsed chunk list for normal Read chunks
+ * @rctxt: Ingress receive context
+ * @p: Start of an un-decoded Read list
+ *
+ * Assumptions:
+ * - The incoming Read list has already been sanity checked.
+ * - cl_count is already set to the number of segments in
+ *   the un-decoded list.
+ * - The list might not be in order by position.
+ *
+ * Return values:
+ *       %true: Parsed chunk list was successfully constructed, and
+ *              cl_count is updated to be the number of chunks (ie.
+ *              unique position values) in the Read list.
+ *      %false: Memory allocation failed.
+ *
+ * TODO:
+ * - Check for chunk range overlaps
+ */
+bool pcl_alloc_read(struct svc_rdma_recv_ctxt *rctxt, __be32 *p)
+{
+	struct svc_rdma_pcl *pcl = &rctxt->rc_read_pcl;
+	unsigned int i, segcount = pcl->cl_count;
+
+	pcl->cl_count = 0;
+	for (i = 0; i < segcount; i++) {
+		struct svc_rdma_chunk *chunk;
+		u32 position, handle, length;
+		u64 offset;
+
+		p++;	/* skip the list discriminator */
+		p = xdr_decode_read_segment(p, &position, &handle,
+					    &length, &offset);
+		if (position == 0)
+			continue;
+
+		chunk = pcl_lookup_position(pcl, position);
+		if (!chunk) {
+			chunk = pcl_alloc_chunk(segcount, position);
+			if (!chunk)
+				return false;
+			pcl_insert_position(pcl, chunk);
+		}
+
+		pcl_set_read_segment(rctxt, chunk, handle, length, offset);
+	}
+
+	return true;
+}
+
+/**
+ * pcl_alloc_write - Construct a parsed chunk list from a Write list
+ * @rctxt: Ingress receive context
+ * @pcl: Parsed chunk list to populate
+ * @p: Start of an un-decoded Write list
+ *
+ * Assumptions:
+ * - The incoming Write list has already been sanity checked, and
+ * - cl_count is set to the number of chunks in the un-decoded list.
+ *
+ * Return values:
+ *       %true: Parsed chunk list was successfully constructed.
+ *      %false: Memory allocation failed.
+ */
+bool pcl_alloc_write(struct svc_rdma_recv_ctxt *rctxt,
+		     struct svc_rdma_pcl *pcl, __be32 *p)
+{
+	struct svc_rdma_segment *segment;
+	struct svc_rdma_chunk *chunk;
+	unsigned int i, j;
+	u32 segcount;
+
+	for (i = 0; i < pcl->cl_count; i++) {
+		p++;	/* skip the list discriminator */
+		segcount = be32_to_cpup(p++);
+
+		chunk = pcl_alloc_chunk(segcount, 0);
+		if (!chunk)
+			return false;
+		list_add_tail(&chunk->ch_list, &pcl->cl_chunks);
+
+		for (j = 0; j < segcount; j++) {
+			segment = &chunk->ch_segments[j];
+			p = xdr_decode_rdma_segment(p, &segment->rs_handle,
+						    &segment->rs_length,
+						    &segment->rs_offset);
+			trace_svcrdma_decode_wseg(&rctxt->rc_cid, chunk, j);
+
+			chunk->ch_length += segment->rs_length;
+			chunk->ch_segcount++;
+		}
+	}
+	return true;
+}
+
+static int pcl_process_region(const struct xdr_buf *xdr,
+			      unsigned int offset, unsigned int length,
+			      int (*actor)(const struct xdr_buf *, void *),
+			      void *data)
+{
+	struct xdr_buf subbuf;
+
+	if (!length)
+		return 0;
+	if (xdr_buf_subsegment(xdr, &subbuf, offset, length))
+		return -EMSGSIZE;
+	return actor(&subbuf, data);
+}
+
+/**
+ * pcl_process_nonpayloads - Process non-payload regions inside @xdr
+ * @pcl: Chunk list to process
+ * @xdr: xdr_buf to process
+ * @actor: Function to invoke on each non-payload region
+ * @data: Arguments for @actor
+ *
+ * This mechanism must ignore not only result payloads that were already
+ * sent via RDMA Write, but also XDR padding for those payloads that
+ * the upper layer has added.
+ *
+ * Assumptions:
+ *  The xdr->len and ch_position fields are aligned to 4-byte multiples.
+ *
+ * Returns:
+ *   On success, zero,
+ *   %-EMSGSIZE on XDR buffer overflow, or
+ *   The return value of @actor
+ */
+int pcl_process_nonpayloads(const struct svc_rdma_pcl *pcl,
+			    const struct xdr_buf *xdr,
+			    int (*actor)(const struct xdr_buf *, void *),
+			    void *data)
+{
+	struct svc_rdma_chunk *chunk, *next;
+	unsigned int start;
+	int ret;
+
+	chunk = pcl_first_chunk(pcl);
+
+	/* No result payloads were generated */
+	if (!chunk || !chunk->ch_payload_length)
+		return actor(xdr, data);
+
+	/* Process the region before the first result payload */
+	ret = pcl_process_region(xdr, 0, chunk->ch_position, actor, data);
+	if (ret < 0)
+		return ret;
+
+	/* Process the regions between each middle result payload */
+	while ((next = pcl_next_chunk(pcl, chunk))) {
+		if (!next->ch_payload_length)
+			break;
+
+		start = pcl_chunk_end_offset(chunk);
+		ret = pcl_process_region(xdr, start, next->ch_position - start,
+					 actor, data);
+		if (ret < 0)
+			return ret;
+
+		chunk = next;
+	}
+
+	/* Process the region after the last result payload */
+	start = pcl_chunk_end_offset(chunk);
+	ret = pcl_process_region(xdr, start, xdr->len - start, actor, data);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index c6ea2903c21a..ec9d259b149c 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -93,6 +93,7 @@
  * (see rdma_read_complete() below).
  */
 
+#include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <asm/unaligned.h>
 #include <rdma/ib_verbs.h>
@@ -143,6 +144,10 @@ svc_rdma_recv_ctxt_alloc(struct svcxprt_rdma *rdma)
 		goto fail2;
 
 	svc_rdma_recv_cid_init(rdma, &ctxt->rc_cid);
+	pcl_init(&ctxt->rc_call_pcl);
+	pcl_init(&ctxt->rc_read_pcl);
+	pcl_init(&ctxt->rc_write_pcl);
+	pcl_init(&ctxt->rc_reply_pcl);
 
 	ctxt->rc_recv_wr.next = NULL;
 	ctxt->rc_recv_wr.wr_cqe = &ctxt->rc_cqe;
@@ -226,6 +231,11 @@ void svc_rdma_recv_ctxt_put(struct svcxprt_rdma *rdma,
 	for (i = 0; i < ctxt->rc_page_count; i++)
 		put_page(ctxt->rc_pages[i]);
 
+	pcl_free(&ctxt->rc_call_pcl);
+	pcl_free(&ctxt->rc_read_pcl);
+	pcl_free(&ctxt->rc_write_pcl);
+	pcl_free(&ctxt->rc_reply_pcl);
+
 	if (!ctxt->rc_temp)
 		llist_add(&ctxt->rc_node, &rdma->sc_recv_ctxts);
 	else
@@ -385,100 +395,123 @@ static void svc_rdma_build_arg_xdr(struct svc_rqst *rqstp,
 	arg->len = ctxt->rc_byte_len;
 }
 
-/* This accommodates the largest possible Write chunk.
- */
-#define MAX_BYTES_WRITE_CHUNK ((u32)(RPCSVC_MAXPAGES << PAGE_SHIFT))
-
-/* This accommodates the largest possible Position-Zero
- * Read chunk or Reply chunk.
- */
-#define MAX_BYTES_SPECIAL_CHUNK ((u32)((RPCSVC_MAXPAGES + 2) << PAGE_SHIFT))
-
-/* Sanity check the Read list.
+/**
+ * xdr_count_read_segments - Count number of Read segments in Read list
+ * @rctxt: Ingress receive context
+ * @p: Start of an un-decoded Read list
  *
- * Implementation limits:
- * - This implementation supports only one Read chunk.
+ * Before allocating anything, ensure the ingress Read list is safe
+ * to use.
  *
- * Sanity checks:
- * - Read list does not overflow Receive buffer.
- * - Segment size limited by largest NFS data payload.
- *
- * The segment count is limited to how many segments can
- * fit in the transport header without overflowing the
- * buffer. That's about 40 Read segments for a 1KB inline
- * threshold.
+ * The segment count is limited to how many segments can fit in the
+ * transport header without overflowing the buffer. That's about 40
+ * Read segments for a 1KB inline threshold.
  *
  * Return values:
- *       %true: Read list is valid. @rctxt's xdr_stream is updated
- *		to point to the first byte past the Read list.
- *      %false: Read list is corrupt. @rctxt's xdr_stream is left
- *		in an unknown state.
+ *   %true: Read list is valid. @rctxt's xdr_stream is updated to point
+ *	    to the first byte past the Read list. rc_read_pcl and
+ *	    rc_call_pcl cl_count fields are set to the number of
+ *	    Read segments in the list.
+ *  %false: Read list is corrupt. @rctxt's xdr_stream is left in an
+ *	    unknown state.
  */
-static bool xdr_check_read_list(struct svc_rdma_recv_ctxt *rctxt)
+static bool xdr_count_read_segments(struct svc_rdma_recv_ctxt *rctxt, __be32 *p)
 {
-	u32 position, len;
-	bool first;
-	__be32 *p;
-
-	p = xdr_inline_decode(&rctxt->rc_stream, sizeof(*p));
-	if (!p)
-		return false;
-
-	len = 0;
-	first = true;
+	rctxt->rc_call_pcl.cl_count = 0;
+	rctxt->rc_read_pcl.cl_count = 0;
 	while (xdr_item_is_present(p)) {
+		u32 position, handle, length;
+		u64 offset;
+
 		p = xdr_inline_decode(&rctxt->rc_stream,
 				      rpcrdma_readseg_maxsz * sizeof(*p));
 		if (!p)
 			return false;
 
-		if (first) {
-			position = be32_to_cpup(p);
-			first = false;
-		} else if (be32_to_cpup(p) != position) {
-			return false;
+		xdr_decode_read_segment(p, &position, &handle,
+					    &length, &offset);
+		if (position) {
+			if (position & 3)
+				return false;
+			++rctxt->rc_read_pcl.cl_count;
+		} else {
+			++rctxt->rc_call_pcl.cl_count;
 		}
-		p += 2;
-		len += be32_to_cpup(p);
 
 		p = xdr_inline_decode(&rctxt->rc_stream, sizeof(*p));
 		if (!p)
 			return false;
 	}
-	return len <= MAX_BYTES_SPECIAL_CHUNK;
+	return true;
 }
 
-/* The segment count is limited to how many segments can
- * fit in the transport header without overflowing the
- * buffer. That's about 60 Write segments for a 1KB inline
- * threshold.
+/* Sanity check the Read list.
+ *
+ * Sanity checks:
+ * - Read list does not overflow Receive buffer.
+ * - Chunk size limited by largest NFS data payload.
+ *
+ * Return values:
+ *   %true: Read list is valid. @rctxt's xdr_stream is updated
+ *	    to point to the first byte past the Read list.
+ *  %false: Read list is corrupt. @rctxt's xdr_stream is left
+ *	    in an unknown state.
  */
-static bool xdr_check_write_chunk(struct svc_rdma_recv_ctxt *rctxt, u32 maxlen)
+static bool xdr_check_read_list(struct svc_rdma_recv_ctxt *rctxt)
 {
-	u32 i, segcount, total;
 	__be32 *p;
 
 	p = xdr_inline_decode(&rctxt->rc_stream, sizeof(*p));
 	if (!p)
 		return false;
-	segcount = be32_to_cpup(p);
+	if (!xdr_count_read_segments(rctxt, p))
+		return false;
+	if (!pcl_alloc_call(rctxt, p))
+		return false;
+	return pcl_alloc_read(rctxt, p);
+}
 
-	total = 0;
-	for (i = 0; i < segcount; i++) {
-		u32 handle, length;
-		u64 offset;
+static bool xdr_check_write_chunk(struct svc_rdma_recv_ctxt *rctxt)
+{
+	u32 segcount;
+	__be32 *p;
 
-		p = xdr_inline_decode(&rctxt->rc_stream,
-				      rpcrdma_segment_maxsz * sizeof(*p));
-		if (!p)
-			return false;
+	if (xdr_stream_decode_u32(&rctxt->rc_stream, &segcount))
+		return false;
 
-		xdr_decode_rdma_segment(p, &handle, &length, &offset);
-		trace_svcrdma_decode_wseg(handle, length, offset);
+	/* A bogus segcount causes this buffer overflow check to fail. */
+	p = xdr_inline_decode(&rctxt->rc_stream,
+			      segcount * rpcrdma_segment_maxsz * sizeof(*p));
+	return p != NULL;
+}
 
-		total += length;
+/**
+ * xdr_count_write_chunks - Count number of Write chunks in Write list
+ * @rctxt: Received header and decoding state
+ * @p: start of an un-decoded Write list
+ *
+ * Before allocating anything, ensure the ingress Write list is
+ * safe to use.
+ *
+ * Return values:
+ *       %true: Write list is valid. @rctxt's xdr_stream is updated
+ *		to point to the first byte past the Write list, and
+ *		the number of Write chunks is in rc_write_pcl.cl_count.
+ *      %false: Write list is corrupt. @rctxt's xdr_stream is left
+ *		in an indeterminate state.
+ */
+static bool xdr_count_write_chunks(struct svc_rdma_recv_ctxt *rctxt, __be32 *p)
+{
+	rctxt->rc_write_pcl.cl_count = 0;
+	while (xdr_item_is_present(p)) {
+		if (!xdr_check_write_chunk(rctxt))
+			return false;
+		++rctxt->rc_write_pcl.cl_count;
+		p = xdr_inline_decode(&rctxt->rc_stream, sizeof(*p));
+		if (!p)
+			return false;
 	}
-	return total <= maxlen;
+	return true;
 }
 
 /* Sanity check the Write list.
@@ -498,24 +531,22 @@ static bool xdr_check_write_chunk(struct svc_rdma_recv_ctxt *rctxt, u32 maxlen)
  */
 static bool xdr_check_write_list(struct svc_rdma_recv_ctxt *rctxt)
 {
-	u32 chcount = 0;
 	__be32 *p;
 
 	p = xdr_inline_decode(&rctxt->rc_stream, sizeof(*p));
 	if (!p)
 		return false;
-	rctxt->rc_write_list = p;
-	while (xdr_item_is_present(p)) {
-		if (!xdr_check_write_chunk(rctxt, MAX_BYTES_WRITE_CHUNK))
-			return false;
-		++chcount;
-		p = xdr_inline_decode(&rctxt->rc_stream, sizeof(*p));
-		if (!p)
-			return false;
-	}
-	if (!chcount)
-		rctxt->rc_write_list = NULL;
-	return chcount < 2;
+
+	rctxt->rc_write_list = NULL;
+	if (!xdr_count_write_chunks(rctxt, p))
+		return false;
+	if (!pcl_alloc_write(rctxt, &rctxt->rc_write_pcl, p))
+		return false;
+
+	if (!pcl_is_empty(&rctxt->rc_write_pcl))
+		rctxt->rc_write_list = p;
+	rctxt->rc_cur_result_payload = pcl_first_chunk(&rctxt->rc_write_pcl);
+	return rctxt->rc_write_pcl.cl_count < 2;
 }
 
 /* Sanity check the Reply chunk.
@@ -537,13 +568,16 @@ static bool xdr_check_reply_chunk(struct svc_rdma_recv_ctxt *rctxt)
 	p = xdr_inline_decode(&rctxt->rc_stream, sizeof(*p));
 	if (!p)
 		return false;
+
 	rctxt->rc_reply_chunk = NULL;
-	if (xdr_item_is_present(p)) {
-		if (!xdr_check_write_chunk(rctxt, MAX_BYTES_SPECIAL_CHUNK))
-			return false;
-		rctxt->rc_reply_chunk = p;
-	}
-	return true;
+	if (!xdr_item_is_present(p))
+		return true;
+	if (!xdr_check_write_chunk(rctxt))
+		return false;
+
+	rctxt->rc_reply_chunk = p;
+	rctxt->rc_reply_pcl.cl_count = 1;
+	return pcl_alloc_write(rctxt, &rctxt->rc_reply_pcl, p);
 }
 
 /* RPC-over-RDMA Version One private extension: Remote Invalidation.


