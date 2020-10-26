Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626C9299619
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Oct 2020 19:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1782650AbgJZSzn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Oct 2020 14:55:43 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33183 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404083AbgJZSzn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 26 Oct 2020 14:55:43 -0400
Received: by mail-qk1-f195.google.com with SMTP id t128so4357351qke.0;
        Mon, 26 Oct 2020 11:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Vymb2yCzvYitWm6SQObXkOBnQGFIWDdTY+l3B7ejUEA=;
        b=k9S6M3wl/gIevM0n/0x3VaxjmEbcbwQ2AeA8qaZx7myIv4aIgIPF8KRixz4WaWiJ04
         J4q8XlXEfYsx/rWU2c243HkI6ugThhf6KF1FnQYcTINKoBiZKlCDETtpLuCoVR9v2Xct
         Qt+6ekfEQnYiCPqi4ssplufuXuSK3sLTWkgsnyp4MqXSZDwGd1f0Jd4rp4r/EEunGYC+
         n0wMig7YJzgPD8DyHqAkiaeoy4s/tXLnTLK2x50nARR0lDDKzuQKkmsMr6ZsrrxWfHNw
         y56OzLXoT+SBWsyHpOZMvwsnaP4M0A6Lv7pwWvS4dKM8KiP8vEa1qqFaRwil5HbGKjR4
         Q2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=Vymb2yCzvYitWm6SQObXkOBnQGFIWDdTY+l3B7ejUEA=;
        b=oqzo/ALZXoI/dm67H5kdgJWwoNqw9JjA/jlg35blmDXyuntDWLh67Tfkv1F386RW3F
         qDTp198+MOmb00dcErWtxDv/de+qHbWVJ0wzAwH4eSNFM1hDVtjGYsev6ltIJwvXKsWt
         aY0nE3R/Z0u5grVx+eU61A1EqB18MhHD58P5pMJ5QOYwkxuTWyB+0Hx/fmjSzZGvfKj6
         UYuOQ/Owjs05xNaNRwmIWqzZRaj97336dOC4P8sPQnM2ltL5fxeNACrRaF5ymUiljJlF
         CKawI2bw8WDwiAQLJtyAQC/IaT4ROyyTrsw20+tBN37K+8jNoO2XDRBV7ShD4G3kTEMB
         oPfw==
X-Gm-Message-State: AOAM532DC0O2tdvGPPrZlKbv0g9CJDLOHW15v+mu9FAetnouXI081yk2
        ty5ep002fIfqd64AlHrJwTYfeGN9O1w=
X-Google-Smtp-Source: ABdhPJy/u9F53qWlo1VUKHWtiJ1o7msQVgZP6QQkFTR4SkkjhY/U2HCx8/UMrrzpzLbP/a9XO+SlCg==
X-Received: by 2002:a37:e202:: with SMTP id g2mr19684270qki.450.1603738540496;
        Mon, 26 Oct 2020 11:55:40 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id h9sm6959269qth.78.2020.10.26.11.55.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2020 11:55:39 -0700 (PDT)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 09QItcOa013673;
        Mon, 26 Oct 2020 18:55:38 GMT
Subject: [PATCH 20/20] svcrdma: support multiple Read chunks per RPC
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 26 Oct 2020 14:55:38 -0400
Message-ID: <160373853877.1886.1700569114249029475.stgit@klimt.1015granger.net>
In-Reply-To: <160373843299.1886.12604782813896379719.stgit@klimt.1015granger.net>
References: <160373843299.1886.12604782813896379719.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

An efficient way to handle multiple Read chunks is to post them all
together and then take a single completion. This is also how the
code is already structured: when the Read completion fires, all
portions of the incoming RPC message are available to be assembled.

The difficult problem is setting up the Read sink buffers so that
the server pulls the client's data into place, making subsequent
pull-up unnecessary. There are several cases:

* No Read chunks. No-op.

* One data item Read chunk. This is the fast case, where the inline
  part of the RPC-over-RDMA message becomes the head and tail, and
  the data item chunk is placed in buf->pages.

* A Position-zero Read chunk. Treated like TCP: the Read chunk is
  pulled into contiguous pages.

+ A Position-zero Read chunk with data item chunks. Treated like
  TCP: all of the Read chunks are pulled into contiguous pages.

+ Multiple data item chunks. Treated like TCP: the inline part is
  copied and the data item chunks are pulled into contiguous pages.

The "*" cases are already supported. This patch adds support for the
"+" cases.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_rw.c |  236 +++++++++++++++++++++++++++++++++++--
 1 file changed, 222 insertions(+), 14 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 6ec7bdc7b4d3..12aa4c53b48f 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -754,7 +754,121 @@ static int svc_rdma_build_read_chunk(struct svc_rdma_read_info *info,
 }
 
 /**
- * svc_rdma_read_data_items - Construct RDMA Reads to pull data item Read chunks
+ * svc_rdma_copy_inline_range - Copy part of the inline content into pages
+ * @info: context for RDMA Reads
+ * @offset: offset into the Receive buffer of region to copy
+ * @remaining: length of region to copy
+ *
+ * Take a page at a time from rqstp->rq_pages and copy the inline
+ * content from the Receive buffer into that page. Update
+ * info->ri_pageno and info->ri_pageoff so that the next RDMA Read
+ * result will land contiguously with the copied content.
+ *
+ * Return values:
+ *   %0: Inline content was successfully copied
+ *   %-EINVAL: offset or length was incorrect
+ */
+static int svc_rdma_copy_inline_range(struct svc_rdma_read_info *info,
+				      unsigned int offset,
+				      unsigned int remaining)
+{
+	struct svc_rdma_recv_ctxt *head = info->ri_readctxt;
+	unsigned char *dst, *src = head->rc_recv_buf;
+	struct svc_rqst *rqstp = info->ri_rqst;
+	unsigned int page_no, numpages;
+
+	numpages = PAGE_ALIGN(info->ri_pageoff + remaining) >> PAGE_SHIFT;
+	for (page_no = 0; page_no < numpages; page_no++) {
+		unsigned int page_len;
+
+		page_len = min_t(unsigned int, remaining,
+				 PAGE_SIZE - info->ri_pageoff);
+
+		head->rc_arg.pages[info->ri_pageno] =
+			rqstp->rq_pages[info->ri_pageno];
+		if (!info->ri_pageoff)
+			head->rc_page_count++;
+
+		dst = page_address(head->rc_arg.pages[info->ri_pageno]);
+		memcpy(dst + info->ri_pageno, src + offset, page_len);
+
+		info->ri_totalbytes += page_len;
+		info->ri_pageoff += page_len;
+		if (info->ri_pageoff == PAGE_SIZE) {
+			info->ri_pageno++;
+			info->ri_pageoff = 0;
+		}
+		remaining -= page_len;
+		offset += page_len;
+	}
+
+	return -EINVAL;
+}
+
+/**
+ * svc_rdma_read_multiple_chunks - Construct RDMA Reads to pull data item Read chunks
+ * @info: context for RDMA Reads
+ *
+ * The chunk data lands in head->rc_arg as a series of contiguous pages,
+ * like an incoming TCP call.
+ *
+ * Return values:
+ *   %0: RDMA Read WQEs were successfully built
+ *   %-EINVAL: client provided too many chunks or segments,
+ *   %-ENOMEM: rdma_rw context pool was exhausted,
+ *   %-ENOTCONN: posting failed (connection is lost),
+ *   %-EIO: rdma_rw initialization failed (DMA mapping, etc).
+ */
+static noinline int svc_rdma_read_multiple_chunks(struct svc_rdma_read_info *info)
+{
+	struct svc_rdma_recv_ctxt *head = info->ri_readctxt;
+	const struct svc_rdma_pcl *pcl = &head->rc_read_pcl;
+	struct svc_rdma_chunk *chunk, *next;
+	struct xdr_buf *buf = &head->rc_arg;
+	unsigned int start, length;
+	int ret;
+
+	start = 0;
+	chunk = pcl_first_chunk(pcl);
+	length = chunk->ch_position;
+	ret = svc_rdma_copy_inline_range(info, start, length);
+	if (ret < 0)
+		return ret;
+
+	pcl_for_each_chunk(chunk, pcl) {
+		ret = svc_rdma_build_read_chunk(info, chunk);
+		if (ret < 0)
+			return ret;
+
+		next = pcl_next_chunk(pcl, chunk);
+		if (!next)
+			break;
+
+		start += length;
+		length = next->ch_position - info->ri_totalbytes;
+		ret = svc_rdma_copy_inline_range(info, start, length);
+		if (ret < 0)
+			return ret;
+	}
+
+	start += length;
+	length = head->rc_byte_len - start;
+	ret = svc_rdma_copy_inline_range(info, start, length);
+	if (ret < 0)
+		return ret;
+
+	buf->len += info->ri_totalbytes;
+	buf->buflen += info->ri_totalbytes;
+
+	head->rc_hdr_count = 1;
+	buf->head[0].iov_base = page_address(head->rc_pages[0]);
+	buf->head[0].iov_len = min_t(size_t, PAGE_SIZE, info->ri_totalbytes);
+	buf->page_len = info->ri_totalbytes - buf->head[0].iov_len;
+	return 0;
+}
+
+/**
+ * svc_rdma_read_data_item - Construct RDMA Reads to pull data item Read chunks
  * @info: context for RDMA Reads
  *
  * The chunk data lands in the page list of head->rc_arg.pages.
@@ -770,7 +884,7 @@ static int svc_rdma_build_read_chunk(struct svc_rdma_read_info *info,
  *   %-ENOTCONN: posting failed (connection is lost),
  *   %-EIO: rdma_rw initialization failed (DMA mapping, etc).
  */
-static int svc_rdma_read_data_items(struct svc_rdma_read_info *info)
+static int svc_rdma_read_data_item(struct svc_rdma_read_info *info)
 {
 	struct svc_rdma_recv_ctxt *head = info->ri_readctxt;
 	struct xdr_buf *buf = &head->rc_arg;
@@ -778,9 +892,6 @@ static int svc_rdma_read_data_items(struct svc_rdma_read_info *info)
 	unsigned int length;
 	int ret;
 
-	if (head->rc_read_pcl.cl_count > 1)
-		return -EINVAL;
-
 	chunk = pcl_first_chunk(&head->rc_read_pcl);
 	ret = svc_rdma_build_read_chunk(info, chunk);
 	if (ret < 0)
@@ -815,6 +926,104 @@ static int svc_rdma_read_data_items(struct svc_rdma_read_info *info)
 	return ret;
 }
 
+/**
+ * svc_rdma_read_chunk_range - Build RDMA Read WQEs for portion of a chunk
+ * @info: context for RDMA Reads
+ * @chunk: parsed Call chunk to pull
+ * @offset: offset of region to pull
+ * @length: length of region to pull
+ *
+ * Return values:
+ *   %0: RDMA Read WQEs were successfully built
+ *   %-EINVAL: there were not enough resources to finish
+ *   %-ENOMEM: rdma_rw context pool was exhausted,
+ *   %-ENOTCONN: posting failed (connection is lost),
+ *   %-EIO: rdma_rw initialization failed (DMA mapping, etc).
+ */
+static int svc_rdma_read_chunk_range(struct svc_rdma_read_info *info,
+				     const struct svc_rdma_chunk *chunk,
+				     unsigned int offset, unsigned int length)
+{
+	const struct svc_rdma_segment *segment;
+	int ret;
+
+	ret = -EINVAL;
+	pcl_for_each_segment(segment, chunk) {
+		struct svc_rdma_segment dummy;
+
+		if (offset > segment->rs_length) {
+			offset -= segment->rs_length;
+			continue;
+		}
+
+		dummy.rs_handle = segment->rs_handle;
+		dummy.rs_length = min_t(u32, length, segment->rs_length) - offset;
+		dummy.rs_offset = segment->rs_offset + offset;
+
+		ret = svc_rdma_build_read_segment(info, &dummy);
+		if (ret < 0)
+			break;
+
+		info->ri_totalbytes += dummy.rs_length;
+		length -= dummy.rs_length;
+		offset = 0;
+	}
+	return ret;
+}
+
+/**
+ * svc_rdma_read_call_chunk - Build RDMA Read WQEs to pull a Long Message
+ * @info: context for RDMA Reads
+ *
+ * Return values:
+ *   %0: RDMA Read WQEs were successfully built
+ *   %-EINVAL: there were not enough resources to finish
+ *   %-ENOMEM: rdma_rw context pool was exhausted,
+ *   %-ENOTCONN: posting failed (connection is lost),
+ *   %-EIO: rdma_rw initialization failed (DMA mapping, etc).
+ */
+static int svc_rdma_read_call_chunk(struct svc_rdma_read_info *info)
+{
+	struct svc_rdma_recv_ctxt *head = info->ri_readctxt;
+	const struct svc_rdma_chunk *call_chunk =
+			pcl_first_chunk(&head->rc_call_pcl);
+	const struct svc_rdma_pcl *pcl = &head->rc_read_pcl;
+	struct svc_rdma_chunk *chunk, *next;
+	unsigned int start, length;
+	int ret;
+
+	if (pcl_is_empty(pcl))
+		return svc_rdma_build_read_chunk(info, call_chunk);
+
+	start = 0;
+	chunk = pcl_first_chunk(pcl);
+	length = chunk->ch_position;
+	ret = svc_rdma_read_chunk_range(info, call_chunk, start, length);
+	if (ret < 0)
+		return ret;
+
+	pcl_for_each_chunk(chunk, pcl) {
+		ret = svc_rdma_build_read_chunk(info, chunk);
+		if (ret < 0)
+			return ret;
+
+		next = pcl_next_chunk(pcl, chunk);
+		if (!next)
+			break;
+
+		start += length;
+		length = next->ch_position - info->ri_totalbytes;
+		ret = svc_rdma_read_chunk_range(info, call_chunk,
+						start, length);
+		if (ret < 0)
+			return ret;
+	}
+
+	start += length;
+	length = call_chunk->ch_length - start;
+	return svc_rdma_read_chunk_range(info, call_chunk, start, length);
+}
+
 /**
  * svc_rdma_read_special - Build RDMA Read WQEs to pull a Long Message
  * @info: context for RDMA Reads
@@ -834,17 +1043,13 @@ static int svc_rdma_read_data_items(struct svc_rdma_read_info *info)
  *   %-ENOTCONN: posting failed (connection is lost),
  *   %-EIO: rdma_rw initialization failed (DMA mapping, etc).
  */
-static int svc_rdma_read_special(struct svc_rdma_read_info *info)
+static noinline int svc_rdma_read_special(struct svc_rdma_read_info *info)
 {
 	struct svc_rdma_recv_ctxt *head = info->ri_readctxt;
 	struct xdr_buf *buf = &head->rc_arg;
 	int ret;
 
-	if (head->rc_call_pcl.cl_count > 1)
-		return -EINVAL;
-
-	ret = svc_rdma_build_read_chunk(info,
-					pcl_first_chunk(&head->rc_call_pcl));
+	ret = svc_rdma_read_call_chunk(info);
 	if (ret < 0)
 		goto out;
 
@@ -933,9 +1138,12 @@ int svc_rdma_process_read_list(struct svcxprt_rdma *rdma,
 	info->ri_pageoff = 0;
 	info->ri_totalbytes = 0;
 
-	if (pcl_is_empty(&head->rc_call_pcl))
-		ret = svc_rdma_read_data_items(info);
-	else
+	if (pcl_is_empty(&head->rc_call_pcl)) {
+		if (head->rc_read_pcl.cl_count == 1)
+			ret = svc_rdma_read_data_item(info);
+		else
+			ret = svc_rdma_read_multiple_chunks(info);
+	} else
 		ret = svc_rdma_read_special(info);
 	if (ret < 0)
 		goto out_err;


