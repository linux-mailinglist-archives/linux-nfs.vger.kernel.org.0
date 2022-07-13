Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36E88573CF9
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Jul 2022 21:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236848AbiGMTI7 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Jul 2022 15:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236850AbiGMTIz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Jul 2022 15:08:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFBB1EC50
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 12:08:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE66061DC4
        for <linux-nfs@vger.kernel.org>; Wed, 13 Jul 2022 19:08:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3FD9C341CE;
        Wed, 13 Jul 2022 19:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657739333;
        bh=fmJ8s7x27mEIM9o2owbfSQ05uOJ3dXYeVj4HPM9/c/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I82i7h8wV8zPaENi4a4IViYXVkMVOzTXmsjy+bpszYUu+05qcrR/4P2xRlhkpIYyC
         xa5LEPM45xpoWcBVWXfl5qu6QMAXsBszbOB13+PRE5SsyqqH7+gWktzq4F/rBhzOHJ
         ehnSDY6F0uZ/LR8TXJJ2lSVHwCZ+GLqv9B+3jCOTg87bK2Zs15I311j+qh2hr1Kl2C
         2x0uxP+wVNIchaBzYm/vcXeJq8nKrre2T+m7EWVGdetHiwAqu2/6Qi17kLR/uXxNq1
         rQzS3dLPJiBiM8jzNNUAAMOcwxNS5eK0kku2WIUIYK/BrONWo4RBxjcdQ+oCCzsjMF
         yld9WeBtzw4cw==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, trond.myklebust@hammerspace.com
Cc:     anna@kernel.org
Subject: [PATCH v2 3/5] NFS: Replace the READ_PLUS decoding code
Date:   Wed, 13 Jul 2022 15:08:47 -0400
Message-Id: <20220713190849.615778-4-anna@kernel.org>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220713190849.615778-1-anna@kernel.org>
References: <20220713190849.615778-1-anna@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

We now take a 2-step process that allows us to place data and hole
segments directly at their final position in the xdr_stream without
needing to do a bunch of redundant copies to expand holes. Due to the
variable lengths of each segment, the xdr metadata might cross page
boundaries which I account for by setting a small scratch buffer so
xdr_inline_decode() won't fail.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfs/nfs42xdr.c | 168 ++++++++++++++++++++++++----------------------
 1 file changed, 87 insertions(+), 81 deletions(-)

diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index 271e5f92ed01..b56f05113d36 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -1025,73 +1025,84 @@ static int decode_deallocate(struct xdr_stream *xdr, struct nfs42_falloc_res *re
 	return decode_op_hdr(xdr, OP_DEALLOCATE);
 }
 
-static int decode_read_plus_data(struct xdr_stream *xdr,
-				 struct nfs_pgio_args *args,
-				 struct nfs_pgio_res *res)
-{
-	uint32_t count, recvd;
+struct read_plus_segment {
+	enum data_content4 type;
 	uint64_t offset;
+	union {
+		struct {
+			uint64_t length;
+		} hole;
+
+		struct {
+			uint32_t length;
+			unsigned int from;
+		} data;
+	};
+};
+
+static inline uint64_t read_plus_segment_length(struct read_plus_segment *seg)
+{
+	return seg->type == NFS4_CONTENT_DATA ? seg->data.length : seg->hole.length;
+}
+
+static int decode_read_plus_segment(struct xdr_stream *xdr,
+				    struct read_plus_segment *seg)
+{
 	__be32 *p;
 
-	p = xdr_inline_decode(xdr, 8 + 4);
+	p = xdr_inline_decode(xdr, 4);
 	if (!p)
-		return 1;
-
-	p = xdr_decode_hyper(p, &offset);
-	count = be32_to_cpup(p);
-	recvd = xdr_align_data(xdr, res->count, xdr_align_size(count));
-	if (recvd > count)
-		recvd = count;
-	if (res->count + recvd > args->count) {
-		if (args->count > res->count)
-			res->count += args->count - res->count;
-		return 1;
-	}
-	res->count += recvd;
-	if (count > recvd)
-		return 1;
+		return -EIO;
+	seg->type = be32_to_cpup(p++);
+
+	p = xdr_inline_decode(xdr, seg->type == NFS4_CONTENT_DATA ? 12 : 16);
+	if (!p)
+		return -EIO;
+	p = xdr_decode_hyper(p, &seg->offset);
+
+	if (seg->type == NFS4_CONTENT_DATA) {
+		struct xdr_buf buf;
+		uint32_t len = be32_to_cpup(p);
+
+		seg->data.length = len;
+		seg->data.from = xdr_stream_pos(xdr);
+
+		if (!xdr_stream_subsegment(xdr, &buf, xdr_align_size(len)))
+			return -EIO;
+	} else if (seg->type == NFS4_CONTENT_HOLE) {
+		xdr_decode_hyper(p, &seg->hole.length);
+	} else
+		return -EINVAL;
 	return 0;
 }
 
-static int decode_read_plus_hole(struct xdr_stream *xdr,
-				 struct nfs_pgio_args *args,
-				 struct nfs_pgio_res *res, uint32_t *eof)
+static int process_read_plus_segment(struct xdr_stream *xdr,
+				     struct nfs_pgio_args *args,
+				     struct nfs_pgio_res *res,
+				     struct read_plus_segment *seg)
 {
-	uint64_t offset, length, recvd;
-	__be32 *p;
+	unsigned long offset = seg->offset;
+	unsigned long length = read_plus_segment_length(seg);
+	unsigned int bufpos;
 
-	p = xdr_inline_decode(xdr, 8 + 8);
-	if (!p)
-		return 1;
-
-	p = xdr_decode_hyper(p, &offset);
-	p = xdr_decode_hyper(p, &length);
-	if (offset != args->offset + res->count) {
-		/* Server returned an out-of-sequence extent */
-		if (offset > args->offset + res->count ||
-		    offset + length < args->offset + res->count) {
-			dprintk("NFS: server returned out of sequence extent: "
-				"offset/size = %llu/%llu != expected %llu\n",
-				(unsigned long long)offset,
-				(unsigned long long)length,
-				(unsigned long long)(args->offset +
-						     res->count));
-			return 1;
-		}
-		length -= args->offset + res->count - offset;
+	if (offset + length < args->offset)
+		return 0;
+	else if (offset > args->offset + args->count) {
+		res->eof = 0;
+		return 0;
+	} else if (offset < args->offset) {
+		length -= (args->offset - offset);
+		offset = args->offset;
+	} else if (offset + length > args->offset + args->count) {
+		length = (args->offset + args->count) - offset;
+		res->eof = 0;
 	}
-	if (length + res->count > args->count) {
-		*eof = 0;
-		if (unlikely(res->count >= args->count))
-			return 1;
-		length = args->count - res->count;
-	}
-	recvd = xdr_expand_hole(xdr, res->count, length);
-	res->count += recvd;
 
-	if (recvd < length)
-		return 1;
-	return 0;
+	bufpos = xdr->buf->head[0].iov_len + (offset - args->offset);
+	if (seg->type == NFS4_CONTENT_HOLE)
+		return xdr_stream_zero(xdr, bufpos, length);
+	else
+		return xdr_stream_move_subsegment(xdr, seg->data.from, bufpos, length);
 }
 
 static int decode_read_plus(struct xdr_stream *xdr, struct nfs_pgio_res *res)
@@ -1099,8 +1110,10 @@ static int decode_read_plus(struct xdr_stream *xdr, struct nfs_pgio_res *res)
 	struct nfs_pgio_header *hdr =
 		container_of(res, struct nfs_pgio_header, res);
 	struct nfs_pgio_args *args = &hdr->args;
-	uint32_t eof, segments, type;
+	uint32_t segments;
+	struct read_plus_segment *segs;
 	int status, i;
+	char scratch_buf[16];
 	__be32 *p;
 
 	status = decode_op_hdr(xdr, OP_READ_PLUS);
@@ -1112,38 +1125,31 @@ static int decode_read_plus(struct xdr_stream *xdr, struct nfs_pgio_res *res)
 		return -EIO;
 
 	res->count = 0;
-	eof = be32_to_cpup(p++);
+	res->eof = be32_to_cpup(p++);
 	segments = be32_to_cpup(p++);
 	if (segments == 0)
-		goto out;
+		return status;
 
+	segs = kmalloc_array(segments, sizeof(*segs), GFP_KERNEL);
+	if (!segs)
+		return -ENOMEM;
+
+	xdr_set_scratch_buffer(xdr, &scratch_buf, 32);
+	status = -EIO;
 	for (i = 0; i < segments; i++) {
-		p = xdr_inline_decode(xdr, 4);
-		if (!p)
-			goto early_out;
-
-		type = be32_to_cpup(p++);
-		if (type == NFS4_CONTENT_DATA)
-			status = decode_read_plus_data(xdr, args, res);
-		else if (type == NFS4_CONTENT_HOLE)
-			status = decode_read_plus_hole(xdr, args, res, &eof);
-		else
-			return -EINVAL;
-
+		status = decode_read_plus_segment(xdr, &segs[i]);
 		if (status < 0)
-			return status;
-		if (status > 0)
-			goto early_out;
+			goto out;
 	}
 
+	xdr_set_pagelen(xdr, xdr_align_size(args->count));
+	for (i = segments; i > 0; i--)
+		res->count += process_read_plus_segment(xdr, args, res, &segs[i-1]);
+	status = 0;
+
 out:
-	res->eof = eof;
-	return 0;
-early_out:
-	if (unlikely(!i))
-		return -EIO;
-	res->eof = 0;
-	return 0;
+	kfree(segs);
+	return status;
 }
 
 static int decode_seek(struct xdr_stream *xdr, struct nfs42_seek_res *res)
-- 
2.37.0

