Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B442246D57
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Aug 2020 18:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389128AbgHQQx6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Aug 2020 12:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389103AbgHQQxd (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Aug 2020 12:53:33 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65BCC061348
        for <linux-nfs@vger.kernel.org>; Mon, 17 Aug 2020 09:53:16 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id z3so15125049ilh.3
        for <linux-nfs@vger.kernel.org>; Mon, 17 Aug 2020 09:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RtwFYKDGf1W/tp3xEFF0blS9Fjq7SLSWxBtcEH0xbEQ=;
        b=qUPOgDt3cvtA5PigsjKYKD0jx+NncQsbU0zTibsUGe6CaexhVZmNCfI3GkYrXgLW/0
         r0uhztQuAkyg5YvIBgMlT57VRu6aZvc61P701yzsYt0QLKH+1hviq+gtOXz8+c+rHdVQ
         gJm5UUVEmRTYAbeh+pQFrLh9itjUsrJX/R8ezuc793epkQBQj0KyUr9Zew7g8mCEY0IE
         mK+wzAxfIcvG7Xar8XQrnOSVmPULMaTOHdl+gtOfOwAWWZYDj4PMMqfWsoylURFaoOTp
         YczUhSpkV/m59u4jraHJNbuEr4Pe98ZKXWaJ3GgDJlf/ztYXFG9t8mTBbkuDjmFJb9tn
         B1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=RtwFYKDGf1W/tp3xEFF0blS9Fjq7SLSWxBtcEH0xbEQ=;
        b=A9n7SMtj1x3vGOCM9sJCbHdIPMCsM1ptuVpbQ3pctx038piKvcwg3ff2Ibvd+5+FQi
         wMD+ZijoEDWq+YcSBRu9autrMM0nxSZoZd9wIPhiySiuTc+gVsYiqoLiI2OwiPz85ztG
         2vH/EQUJFaQVAXb32ILB8rnK/5f3zRKgL2LBOPBsRSld6O5diKyk66x/2pf48xPZst5L
         6hOu00MeswlmLKgbmgOwHOikRtI/eaNWDYFvwE5Cak/zXFNWCrgYE+XXz7PyYg0QB+hk
         imUFIb78IDnZO2cAUlXtR9x1QvF3qGyNx5EseB+tKKh0iOyjeTMhaqRXD1rU0+Ho/gd4
         LoFw==
X-Gm-Message-State: AOAM531BZSCGXxv2d1yNYmHJWAO+GeshbHdH8f/U9kmF+NcWqxCGel6f
        wJRNxI77F9LNipAOIBU7aK0=
X-Google-Smtp-Source: ABdhPJyq+DUfAAxJmopAYoBJhTrBZljH8lzQZL4Z6xYi6fNEI+jA4xykE9ydzwszwSBMiCqClNdLIQ==
X-Received: by 2002:a92:cf52:: with SMTP id c18mr14524652ilr.44.1597683196086;
        Mon, 17 Aug 2020 09:53:16 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id s3sm9410039iol.49.2020.08.17.09.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 09:53:15 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     bfields@redhat.com, chuck.lever@oracle.com,
        linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v4 4/5] NFSD: Return both a hole and a data segment
Date:   Mon, 17 Aug 2020 12:53:09 -0400
Message-Id: <20200817165310.354092-5-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817165310.354092-1-Anna.Schumaker@Netapp.com>
References: <20200817165310.354092-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

But only one of each right now. We'll expand on this in the next patch.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfsd/nfs4xdr.c | 51 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 37 insertions(+), 14 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 2fa39217c256..3f4860103b25 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4373,7 +4373,7 @@ nfsd4_encode_offload_status(struct nfsd4_compoundres *resp, __be32 nfserr,
 static __be32
 nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
 			    struct nfsd4_read *read,
-			    unsigned long maxcount,  u32 *eof)
+			    unsigned long *maxcount, u32 *eof)
 {
 	struct xdr_stream *xdr = &resp->xdr;
 	struct file *file = read->rd_nf->nf_file;
@@ -4384,19 +4384,19 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
 	__be64 tmp64;
 
 	if (hole_pos > read->rd_offset)
-		maxcount = min_t(unsigned long, maxcount, hole_pos - read->rd_offset);
+		*maxcount = min_t(unsigned long, *maxcount, hole_pos - read->rd_offset);
 
 	/* Content type, offset, byte count */
 	p = xdr_reserve_space(xdr, 4 + 8 + 4);
 	if (!p)
 		return nfserr_resource;
 
-	read->rd_vlen = xdr_reserve_space_vec(xdr, resp->rqstp->rq_vec, maxcount);
+	read->rd_vlen = xdr_reserve_space_vec(xdr, resp->rqstp->rq_vec, *maxcount);
 	if (read->rd_vlen < 0)
 		return nfserr_resource;
 
 	nfserr = nfsd_readv(resp->rqstp, read->rd_fhp, file, read->rd_offset,
-			    resp->rqstp->rq_vec, read->rd_vlen, &maxcount, eof);
+			    resp->rqstp->rq_vec, read->rd_vlen, maxcount, eof);
 	if (nfserr)
 		return nfserr;
 
@@ -4404,7 +4404,7 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
 	write_bytes_to_xdr_buf(xdr->buf, starting_len,      &tmp,   4);
 	tmp64 = cpu_to_be64(read->rd_offset);
 	write_bytes_to_xdr_buf(xdr->buf, starting_len + 4,  &tmp64, 8);
-	tmp = htonl(maxcount);
+	tmp = htonl(*maxcount);
 	write_bytes_to_xdr_buf(xdr->buf, starting_len + 12, &tmp,   4);
 	return nfs_ok;
 }
@@ -4412,11 +4412,19 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
 static __be32
 nfsd4_encode_read_plus_hole(struct nfsd4_compoundres *resp,
 			    struct nfsd4_read *read,
-			    unsigned long maxcount, u32 *eof)
+			    unsigned long *maxcount, u32 *eof)
 {
 	struct file *file = read->rd_nf->nf_file;
+	loff_t data_pos = vfs_llseek(file, read->rd_offset, SEEK_DATA);
+	unsigned long count;
 	__be32 *p;
 
+	if (data_pos == -ENXIO)
+		data_pos = i_size_read(file_inode(file));
+	else if (data_pos <= read->rd_offset)
+		return nfserr_resource;
+	count = data_pos - read->rd_offset;
+
 	/* Content type, offset, byte count */
 	p = xdr_reserve_space(&resp->xdr, 4 + 8 + 8);
 	if (!p)
@@ -4424,9 +4432,10 @@ nfsd4_encode_read_plus_hole(struct nfsd4_compoundres *resp,
 
 	*p++ = htonl(NFS4_CONTENT_HOLE);
 	 p   = xdr_encode_hyper(p, read->rd_offset);
-	 p   = xdr_encode_hyper(p, maxcount);
+	 p   = xdr_encode_hyper(p, count);
 
-	*eof = (read->rd_offset + maxcount) >= i_size_read(file_inode(file));
+	*eof = (read->rd_offset + count) >= i_size_read(file_inode(file));
+	*maxcount = min_t(unsigned long, count, *maxcount);
 	return nfs_ok;
 }
 
@@ -4434,7 +4443,7 @@ static __be32
 nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
 		       struct nfsd4_read *read)
 {
-	unsigned long maxcount;
+	unsigned long maxcount, count;
 	struct xdr_stream *xdr = &resp->xdr;
 	struct file *file;
 	int starting_len = xdr->buf->len;
@@ -4457,6 +4466,7 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
 	maxcount = min_t(unsigned long, maxcount,
 			 (xdr->buf->buflen - xdr->buf->len));
 	maxcount = min_t(unsigned long, maxcount, read->rd_length);
+	count    = maxcount;
 
 	eof = read->rd_offset >= i_size_read(file_inode(file));
 	if (eof)
@@ -4465,13 +4475,26 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
 	pos = vfs_llseek(file, read->rd_offset, SEEK_DATA);
 	if (pos == -ENXIO)
 		pos = i_size_read(file_inode(file));
+	else if (pos < 0)
+		pos = read->rd_offset;
 
-	if (pos > read->rd_offset) {
-		maxcount = pos - read->rd_offset;
-		nfserr = nfsd4_encode_read_plus_hole(resp, read, maxcount, &eof);
+	if (pos == read->rd_offset) {
+		maxcount = count;
+		nfserr = nfsd4_encode_read_plus_data(resp, read, &maxcount, &eof);
+		if (nfserr)
+			goto out;
+		count -= maxcount;
+		read->rd_offset += maxcount;
 		segments++;
-	} else {
-		nfserr = nfsd4_encode_read_plus_data(resp, read, maxcount, &eof);
+	}
+
+	if (count > 0 && !eof) {
+		maxcount = count;
+		nfserr = nfsd4_encode_read_plus_hole(resp, read, &maxcount, &eof);
+		if (nfserr)
+			goto out;
+		count -= maxcount;
+		read->rd_offset += maxcount;
 		segments++;
 	}
 
-- 
2.28.0

