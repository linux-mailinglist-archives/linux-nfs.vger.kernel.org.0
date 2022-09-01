Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CB765A9EF8
	for <lists+linux-nfs@lfdr.de>; Thu,  1 Sep 2022 20:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbiIASds (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 1 Sep 2022 14:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233907AbiIASdr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 1 Sep 2022 14:33:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C927E30D
        for <linux-nfs@vger.kernel.org>; Thu,  1 Sep 2022 11:33:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0F2C0B828F3
        for <linux-nfs@vger.kernel.org>; Thu,  1 Sep 2022 18:33:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D311C433D7;
        Thu,  1 Sep 2022 18:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662057223;
        bh=v2IqCGP7VHklT/X8stTFEcqwso4EF2HdNUac23iWnb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pr2e8XwB+uHr97E37oFQ9qDH03cMmhnnJ+vspCFNwMdFeXoeyNW+ES5CjjpYQxzEc
         BmiMwTpohpj4ZVUNS22qXQS+1SBb97eyNlD3IO5N0mF6/I0TTWW3nwz4Jvm8/yhOt6
         2ttvD1pPm7FlxqLm1eieL5epe1/t52FD+dm7rs20hI6S2QUuJvy9MqT93RUCVsrqMS
         1IBGjqGRxKaUiVdVc+hPRadwLP1JfajlwKw59jpAs4gdonbjIdYkoTxRRIag3uStNN
         hjytJNZaLL8eOebDrYFEwGTDf7Z5PffRu6p+AK9jraTTOVXOH21g+Jo4sPdpxlouIL
         8eMK7YlpIEoqw==
From:   Anna Schumaker <anna@kernel.org>
To:     linux-nfs@vger.kernel.org, chuck.lever@oracle.com
Cc:     anna@kernel.org
Subject: [PATCH 1/1] NFSD: Simplify READ_PLUS
Date:   Thu,  1 Sep 2022 14:33:41 -0400
Message-Id: <20220901183341.1543827-2-anna@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220901183341.1543827-1-anna@kernel.org>
References: <20220901183341.1543827-1-anna@kernel.org>
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

Change the implementation to return a single DATA segment covering the
requested read range.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfsd/nfs4xdr.c | 122 ++++++++--------------------------------------
 1 file changed, 20 insertions(+), 102 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 1e9690a061ec..adbff7737c14 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4731,79 +4731,30 @@ nfsd4_encode_offload_status(struct nfsd4_compoundres *resp, __be32 nfserr,
 
 static __be32
 nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
-			    struct nfsd4_read *read,
-			    unsigned long *maxcount, u32 *eof,
-			    loff_t *pos)
+			    struct nfsd4_read *read)
 {
+	unsigned long maxcount;
 	struct xdr_stream *xdr = resp->xdr;
 	struct file *file = read->rd_nf->nf_file;
-	int starting_len = xdr->buf->len;
-	loff_t hole_pos;
 	__be32 nfserr;
-	__be32 *p, tmp;
-	__be64 tmp64;
-
-	hole_pos = pos ? *pos : vfs_llseek(file, read->rd_offset, SEEK_HOLE);
-	if (hole_pos > read->rd_offset)
-		*maxcount = min_t(unsigned long, *maxcount, hole_pos - read->rd_offset);
-	*maxcount = min_t(unsigned long, *maxcount, (xdr->buf->buflen - xdr->buf->len));
+	__be32 *p;
 
 	/* Content type, offset, byte count */
 	p = xdr_reserve_space(xdr, 4 + 8 + 4);
 	if (!p)
 		return nfserr_resource;
 
-	read->rd_vlen = xdr_reserve_space_vec(xdr, resp->rqstp->rq_vec, *maxcount);
-	if (read->rd_vlen < 0)
-		return nfserr_resource;
+	maxcount = min_t(unsigned long, read->rd_length,
+			 (xdr->buf->buflen - xdr->buf->len));
 
-	nfserr = nfsd_readv(resp->rqstp, read->rd_fhp, file, read->rd_offset,
-			    resp->rqstp->rq_vec, read->rd_vlen, maxcount, eof);
+	nfserr = nfsd4_encode_readv(resp, read, file, maxcount);
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
 
@@ -4811,20 +4762,14 @@ static __be32
 nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
 		       struct nfsd4_read *read)
 {
-	unsigned long maxcount, count;
 	struct xdr_stream *xdr = resp->xdr;
-	struct file *file;
+	struct file *file = read->rd_nf->nf_file;
 	int starting_len = xdr->buf->len;
-	int last_segment = xdr->buf->len;
 	int segments = 0;
-	__be32 *p, tmp;
-	bool is_data;
-	loff_t pos;
-	u32 eof;
+	__be32 *p;
 
 	if (nfserr)
 		return nfserr;
-	file = read->rd_nf->nf_file;
 
 	/* eof flag, segment count */
 	p = xdr_reserve_space(xdr, 4 + 4);
@@ -4832,48 +4777,21 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
 		return nfserr_resource;
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

