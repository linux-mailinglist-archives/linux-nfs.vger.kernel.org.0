Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA205B0D81
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Sep 2022 21:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiIGTxF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Sep 2022 15:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiIGTxE (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Sep 2022 15:53:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B3AA0324
        for <linux-nfs@vger.kernel.org>; Wed,  7 Sep 2022 12:53:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 227B461A4D
        for <linux-nfs@vger.kernel.org>; Wed,  7 Sep 2022 19:53:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37BA2C433B5;
        Wed,  7 Sep 2022 19:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662580381;
        bh=sj5ZvJiPGu/T9/NNcbOg5pkHqUIvFri80W+VOmqlhSM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Yo+b9KRcQLKsvXPh8dhmQwcIzP+655nCz3c53ly2Yj67b5FRdRO0ClW3BIftcPW6K
         a/spAt9EMUbKnjpKp2RNORTs7+9LND//TOKZjQm9awRn8mEaz6MmcZAGMiKn4LL4Wf
         x3utoxQ+iqJxFwhXkITMJ0dXoSoQ/NUeTU2tHx/mBSROX5RMaPF4wRERqSwGfc5J2Z
         mff7YwqhDOrL2c3K6R8xsYcIjGhxmtHrxNwCHFtqFIp/wYR7yniNXtRDyi53cDHt1H
         j/FhdKcJZnW6vL190lecfsoHwg3GIKdet0WylosKQFSnySgi2Mt8+ugbfHqlMuiLwF
         vwgToG4yT2geg==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, chuck.lever@oracle.com
Cc:     anna@kernel.org
Subject: [PATCH v2 1/1] NFSD: Simplify READ_PLUS
Date:   Wed,  7 Sep 2022 15:52:59 -0400
Message-Id: <20220907195259.926736-2-anna@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220907195259.926736-1-anna@kernel.org>
References: <20220907195259.926736-1-anna@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

Chuck had suggested reverting READ_PLUS so it returns a single DATA
segment covering the requested read range. This prepares the server for
a future "sparse read" function so support can easily be added without
needing to rip out the old READ_PLUS code at the same time.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfsd/nfs4xdr.c | 139 +++++++++++-----------------------------------
 1 file changed, 32 insertions(+), 107 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 1e9690a061ec..bcc8c385faf2 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4731,79 +4731,37 @@ nfsd4_encode_offload_status(struct nfsd4_compoundres *resp, __be32 nfserr,
 
 static __be32
 nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
-			    struct nfsd4_read *read,
-			    unsigned long *maxcount, u32 *eof,
-			    loff_t *pos)
+			    struct nfsd4_read *read)
 {
-	struct xdr_stream *xdr = resp->xdr;
+	bool splice_ok = test_bit(RQ_SPLICE_OK, &resp->rqstp->rq_flags);
 	struct file *file = read->rd_nf->nf_file;
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
+	struct xdr_stream *xdr = resp->xdr;
+	unsigned long maxcount;
+	__be32 nfserr, *p;
 
 	/* Content type, offset, byte count */
 	p = xdr_reserve_space(xdr, 4 + 8 + 4);
 	if (!p)
-		return nfserr_resource;
+		return nfserr_io;
+	if (resp->xdr->buf->page_len && splice_ok) {
+		WARN_ON_ONCE(splice_ok);
+		return nfserr_io;
+	}
 
-	read->rd_vlen = xdr_reserve_space_vec(xdr, resp->rqstp->rq_vec, *maxcount);
-	if (read->rd_vlen < 0)
-		return nfserr_resource;
+	maxcount = min_t(unsigned long, read->rd_length,
+			 (xdr->buf->buflen - xdr->buf->len));
 
-	nfserr = nfsd_readv(resp->rqstp, read->rd_fhp, file, read->rd_offset,
-			    resp->rqstp->rq_vec, read->rd_vlen, maxcount, eof);
+	if (file->f_op->splice_read && splice_ok)
+		nfserr = nfsd4_encode_splice_read(resp, read, file, maxcount);
+	else
+		nfserr = nfsd4_encode_readv(resp, read, file, maxcount);
 	if (nfserr)
 		return nfserr;
-	xdr_truncate_encode(xdr, starting_len + 16 + xdr_align_size(*maxcount));
 
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
-	return nfs_ok;
-}
-
-static __be32
-nfsd4_encode_read_plus_hole(struct nfsd4_compoundres *resp,
-			    struct nfsd4_read *read,
-			    unsigned long *maxcount, u32 *eof)
-{
-	struct file *file = read->rd_nf->nf_file;
-	loff_t data_pos = vfs_llseek(file, read->rd_offset, SEEK_DATA);
-	loff_t f_size = i_size_read(file_inode(file));
-	unsigned long count;
-	__be32 *p;
-
-	if (data_pos == -ENXIO)
-		data_pos = f_size;
-	else if (data_pos <= read->rd_offset || (data_pos < f_size && data_pos % PAGE_SIZE))
-		return nfsd4_encode_read_plus_data(resp, read, maxcount, eof, &f_size);
-	count = data_pos - read->rd_offset;
-
-	/* Content type, offset, byte count */
-	p = xdr_reserve_space(resp->xdr, 4 + 8 + 8);
-	if (!p)
-		return nfserr_resource;
-
-	*p++ = htonl(NFS4_CONTENT_HOLE);
+	*p++ = cpu_to_be32(NFS4_CONTENT_DATA);
 	p = xdr_encode_hyper(p, read->rd_offset);
-	p = xdr_encode_hyper(p, count);
+	*p = cpu_to_be32(read->rd_length);
 
-	*eof = (read->rd_offset + count) >= f_size;
-	*maxcount = min_t(unsigned long, count, *maxcount);
 	return nfs_ok;
 }
 
@@ -4811,69 +4769,36 @@ static __be32
 nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
 		       struct nfsd4_read *read)
 {
-	unsigned long maxcount, count;
+	struct file *file = read->rd_nf->nf_file;
 	struct xdr_stream *xdr = resp->xdr;
-	struct file *file;
 	int starting_len = xdr->buf->len;
-	int last_segment = xdr->buf->len;
-	int segments = 0;
-	__be32 *p, tmp;
-	bool is_data;
-	loff_t pos;
-	u32 eof;
+	u32 segments = 0;
+	__be32 *p;
 
 	if (nfserr)
 		return nfserr;
-	file = read->rd_nf->nf_file;
 
 	/* eof flag, segment count */
 	p = xdr_reserve_space(xdr, 4 + 4);
 	if (!p)
-		return nfserr_resource;
+		return nfserr_io;
 	xdr_commit_encode(xdr);
 
-	maxcount = min_t(unsigned long, read->rd_length,
-			 (xdr->buf->buflen - xdr->buf->len));
-	count    = maxcount;
-
-	eof = read->rd_offset >= i_size_read(file_inode(file));
-	if (eof)
+	read->rd_eof = read->rd_offset >= i_size_read(file_inode(file));
+	if (read->rd_eof)
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
-out:
-	if (nfserr && segments == 0)
+	nfserr = nfsd4_encode_read_plus_data(resp, read);
+	if (nfserr) {
 		xdr_truncate_encode(xdr, starting_len);
-	else {
-		if (nfserr) {
-			xdr_truncate_encode(xdr, last_segment);
-			nfserr = nfs_ok;
-			eof = 0;
-		}
-		tmp = htonl(eof);
-		write_bytes_to_xdr_buf(xdr->buf, starting_len,     &tmp, 4);
-		tmp = htonl(segments);
-		write_bytes_to_xdr_buf(xdr->buf, starting_len + 4, &tmp, 4);
+		return nfserr;
 	}
 
+	segments++;
+
+out:
+	p = xdr_encode_bool(p, read->rd_eof);
+	*p = cpu_to_be32(segments);
 	return nfserr;
 }
 
-- 
2.37.2

