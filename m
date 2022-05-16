Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB116529230
	for <lists+linux-nfs@lfdr.de>; Mon, 16 May 2022 23:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348903AbiEPVBq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 May 2022 17:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348961AbiEPVBA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 May 2022 17:01:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41872BD3
        for <linux-nfs@vger.kernel.org>; Mon, 16 May 2022 13:35:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 37E39B81661
        for <linux-nfs@vger.kernel.org>; Mon, 16 May 2022 20:35:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F088C36AE3;
        Mon, 16 May 2022 20:35:53 +0000 (UTC)
From:   Anna.Schumaker@Netapp.com
To:     steved@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v1 6/6] NFSD: Repeal and replace the READ_PLUS implementation
Date:   Mon, 16 May 2022 16:35:49 -0400
Message-Id: <20220516203549.2605575-7-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220516203549.2605575-1-Anna.Schumaker@Netapp.com>
References: <20220516203549.2605575-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Rather than relying on the underlying filesystem to tell us where hole
and data segments are through vfs_llseek(), let's instead do the hole
compression ourselves. This has a few advantages over the old
implementation:

1) A single call to the underlying filesystem through nfsd_readv() means
   the file can't change from underneath us in the middle of encoding.
2) A single call to the underlying filestem also means that the
   underlying filesystem only needs to synchronize cached and on-disk
   data one time instead of potentially many speeding up the reply.
3) Hole support for filesystems that don't support SEEK_HOLE and SEEK_DATA

I also included an optimization where we can cut down on the amount of
memory being shifed around by doing the compression as (hole, data)
pairs.

This patch not only fixes xfstests generic/091 and generic/263
for me but the "-g quick" group tests also finish about a minute faster.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfsd/nfs4xdr.c | 202 +++++++++++++++++++++++-----------------------
 1 file changed, 102 insertions(+), 100 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index da92e7d2ab6a..973b4a1e7990 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4731,81 +4731,121 @@ nfsd4_encode_offload_status(struct nfsd4_compoundres *resp, __be32 nfserr,
 	return nfserr;
 }
 
+struct read_plus_segment {
+	enum data_content4 type;
+	unsigned long offset;
+	unsigned long length;
+	unsigned int page_pos;
+};
+
 static __be32
-nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
-			    struct nfsd4_read *read,
-			    unsigned long *maxcount, u32 *eof,
-			    loff_t *pos)
+nfsd4_read_plus_readv(struct nfsd4_compoundres *resp, struct nfsd4_read *read,
+		      unsigned long *maxcount, u32 *eof)
 {
 	struct xdr_stream *xdr = resp->xdr;
-	struct file *file = read->rd_nf->nf_file;
-	int starting_len = xdr->buf->len;
-	loff_t hole_pos;
-	__be32 nfserr;
-	__be32 *p, tmp;
-	__be64 tmp64;
-
-	hole_pos = pos ? *pos : vfs_llseek(file, read->rd_offset, SEEK_HOLE);
-	if (hole_pos > read->rd_offset)
-		*maxcount = min_t(unsigned long, *maxcount, hole_pos - read->rd_offset);
-	*maxcount = min_t(unsigned long, *maxcount, (xdr->buf->buflen - xdr->buf->len));
-
-	/* Content type, offset, byte count */
-	p = xdr_reserve_space(xdr, 4 + 8 + 4);
-	if (!p)
-		return nfserr_resource;
+	unsigned int starting_len = xdr->buf->len;
+	__be32 nfserr, zero = xdr_zero;
+	int pad;
 
+	/* xdr_reserve_space_vec() switches us to the xdr->pages */
 	read->rd_vlen = xdr_reserve_space_vec(xdr, resp->rqstp->rq_vec, *maxcount);
 	if (read->rd_vlen < 0)
 		return nfserr_resource;
 
-	nfserr = nfsd_readv(resp->rqstp, read->rd_fhp, file, read->rd_offset,
-			    resp->rqstp->rq_vec, read->rd_vlen, maxcount, eof);
+	nfserr = nfsd_readv(resp->rqstp, read->rd_fhp, read->rd_nf->nf_file,
+			    read->rd_offset, resp->rqstp->rq_vec, read->rd_vlen,
+			    maxcount, eof);
 	if (nfserr)
 		return nfserr;
-	xdr_truncate_encode(xdr, starting_len + 16 + xdr_align_size(*maxcount));
+	xdr_truncate_encode(xdr, starting_len + xdr_align_size(*maxcount));
 
-	tmp = htonl(NFS4_CONTENT_DATA);
-	write_bytes_to_xdr_buf(xdr->buf, starting_len,      &tmp,   4);
-	tmp64 = cpu_to_be64(read->rd_offset);
-	write_bytes_to_xdr_buf(xdr->buf, starting_len + 4,  &tmp64, 8);
-	tmp = htonl(*maxcount);
-	write_bytes_to_xdr_buf(xdr->buf, starting_len + 12, &tmp,   4);
-
-	tmp = xdr_zero;
-	write_bytes_to_xdr_buf(xdr->buf, starting_len + 16 + *maxcount, &tmp,
-			       xdr_pad_size(*maxcount));
+	pad = (*maxcount&3) ? 4 - (*maxcount&3) : 0;
+	write_bytes_to_xdr_buf(xdr->buf, starting_len + *maxcount, &zero, pad);
 	return nfs_ok;
 }
 
+static void
+nfsd4_encode_read_plus_segment(struct xdr_stream *xdr,
+			       struct read_plus_segment *segment,
+			       unsigned int *bufpos, unsigned int *segments)
+{
+	struct xdr_buf *buf = xdr->buf;
+
+	xdr_encode_word(buf, *bufpos, segment->type);
+	xdr_encode_double(buf, *bufpos + 4, segment->offset);
+
+	if (segment->type == NFS4_CONTENT_HOLE) {
+		xdr_encode_double(buf, *bufpos + 12, segment->length);
+		*bufpos += 4 + 8 + 8;
+	} else {
+		size_t align = xdr_align_size(segment->length);
+		xdr_encode_word(buf, *bufpos + 12, segment->length);
+		if (*segments == 0)
+			xdr_buf_trim_head(buf, 4);
+
+		xdr_stream_move_segment(xdr,
+				buf->head[0].iov_len + segment->page_pos,
+				*bufpos + 16, align);
+		*bufpos += 4 + 8 + 4 + align;
+	}
+
+	*segments += 1;
+}
+
 static __be32
-nfsd4_encode_read_plus_hole(struct nfsd4_compoundres *resp,
-			    struct nfsd4_read *read,
-			    unsigned long *maxcount, u32 *eof)
+nfsd4_encode_read_plus_segments(struct nfsd4_compoundres *resp,
+				struct nfsd4_read *read,
+				unsigned int *segments, u32 *eof)
 {
-	struct file *file = read->rd_nf->nf_file;
-	loff_t data_pos = vfs_llseek(file, read->rd_offset, SEEK_DATA);
-	loff_t f_size = i_size_read(file_inode(file));
-	unsigned long count;
-	__be32 *p;
+	enum data_content4 pagetype;
+	struct read_plus_segment segment;
+	struct xdr_stream *xdr = resp->xdr;
+	unsigned long offset = read->rd_offset;
+	unsigned int bufpos = xdr->buf->len;
+	unsigned long maxcount;
+	unsigned int pagelen, i = 0;
+	char *vpage, *p;
+	__be32 nfserr;
 
-	if (data_pos == -ENXIO)
-		data_pos = f_size;
-	else if (data_pos <= read->rd_offset || (data_pos < f_size && data_pos % PAGE_SIZE))
-		return nfsd4_encode_read_plus_data(resp, read, maxcount, eof, &f_size);
-	count = data_pos - read->rd_offset;
-
-	/* Content type, offset, byte count */
-	p = xdr_reserve_space(resp->xdr, 4 + 8 + 8);
-	if (!p)
+	/* enough space for a HOLE segment before we switch to the pages */
+	if (!xdr_reserve_space(xdr, 4 + 8 + 8))
 		return nfserr_resource;
+	xdr_commit_encode(xdr);
 
-	*p++ = htonl(NFS4_CONTENT_HOLE);
-	p = xdr_encode_hyper(p, read->rd_offset);
-	p = xdr_encode_hyper(p, count);
+	maxcount = min_t(unsigned long, read->rd_length,
+			 (xdr->buf->buflen - xdr->buf->len));
 
-	*eof = (read->rd_offset + count) >= f_size;
-	*maxcount = min_t(unsigned long, count, *maxcount);
+	nfserr = nfsd4_read_plus_readv(resp, read, &maxcount, eof);
+	if (nfserr)
+		return nfserr;
+
+	while (maxcount > 0) {
+		vpage = xdr_buf_nth_page_address(xdr->buf, i, &pagelen);
+		pagelen = min_t(unsigned int, pagelen, maxcount);
+		if (!vpage || pagelen == 0)
+			break;
+		p = memchr_inv(vpage, 0, pagelen);
+		pagetype = (p == NULL) ? NFS4_CONTENT_HOLE : NFS4_CONTENT_DATA;
+
+		if (pagetype != segment.type || i == 0) {
+			if (likely(i > 0)) {
+				nfsd4_encode_read_plus_segment(xdr, &segment,
+							      &bufpos, segments);
+				offset += segment.length;
+			}
+			segment.type = pagetype;
+			segment.offset = offset;
+			segment.length = pagelen;
+			segment.page_pos = i * PAGE_SIZE;
+		} else
+			segment.length += pagelen;
+
+		maxcount -= pagelen;
+		i++;
+	}
+
+	nfsd4_encode_read_plus_segment(xdr, &segment, &bufpos, segments);
+	xdr_truncate_encode(xdr, bufpos);
 	return nfs_ok;
 }
 
@@ -4813,69 +4853,31 @@ static __be32
 nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
 		       struct nfsd4_read *read)
 {
-	unsigned long maxcount, count;
 	struct xdr_stream *xdr = resp->xdr;
-	struct file *file;
 	int starting_len = xdr->buf->len;
-	int last_segment = xdr->buf->len;
-	int segments = 0;
-	__be32 *p, tmp;
-	bool is_data;
-	loff_t pos;
+	unsigned int segments = 0;
 	u32 eof;
 
 	if (nfserr)
 		return nfserr;
-	file = read->rd_nf->nf_file;
 
 	/* eof flag, segment count */
-	p = xdr_reserve_space(xdr, 4 + 4);
-	if (!p)
+	if (!xdr_reserve_space(xdr, 4 + 4))
 		return nfserr_resource;
 	xdr_commit_encode(xdr);
 
-	maxcount = min_t(unsigned long, read->rd_length,
-			 (xdr->buf->buflen - xdr->buf->len));
-	count    = maxcount;
-
-	eof = read->rd_offset >= i_size_read(file_inode(file));
+	eof = read->rd_offset >= i_size_read(file_inode(read->rd_nf->nf_file));
 	if (eof)
 		goto out;
 
-	pos = vfs_llseek(file, read->rd_offset, SEEK_HOLE);
-	is_data = pos > read->rd_offset;
-
-	while (count > 0 && !eof) {
-		maxcount = count;
-		if (is_data)
-			nfserr = nfsd4_encode_read_plus_data(resp, read, &maxcount, &eof,
-						segments == 0 ? &pos : NULL);
-		else
-			nfserr = nfsd4_encode_read_plus_hole(resp, read, &maxcount, &eof);
-		if (nfserr)
-			goto out;
-		count -= maxcount;
-		read->rd_offset += maxcount;
-		is_data = !is_data;
-		last_segment = xdr->buf->len;
-		segments++;
-	}
-
+	nfserr = nfsd4_encode_read_plus_segments(resp, read, &segments, &eof);
 out:
-	if (nfserr && segments == 0)
+	if (nfserr)
 		xdr_truncate_encode(xdr, starting_len);
 	else {
-		if (nfserr) {
-			xdr_truncate_encode(xdr, last_segment);
-			nfserr = nfs_ok;
-			eof = 0;
-		}
-		tmp = htonl(eof);
-		write_bytes_to_xdr_buf(xdr->buf, starting_len,     &tmp, 4);
-		tmp = htonl(segments);
-		write_bytes_to_xdr_buf(xdr->buf, starting_len + 4, &tmp, 4);
+		xdr_encode_word(xdr->buf, starting_len,     eof);
+		xdr_encode_word(xdr->buf, starting_len + 4, segments);
 	}
-
 	return nfserr;
 }
 
-- 
2.36.1

