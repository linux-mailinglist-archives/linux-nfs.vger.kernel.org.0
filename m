Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C18261544
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Sep 2020 18:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731957AbgIHQrK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 8 Sep 2020 12:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731956AbgIHQ0T (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 8 Sep 2020 12:26:19 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E399C06179F
        for <linux-nfs@vger.kernel.org>; Tue,  8 Sep 2020 09:26:06 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id d190so17757244iof.3
        for <linux-nfs@vger.kernel.org>; Tue, 08 Sep 2020 09:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gF4PFGeOCBPbyVDX2yvL+porZgljePXBrb0QVyft2vc=;
        b=CsVxCIKT5dFNSCN2oTW/KY2IS/GvnAfgbkFLzCt+gH6CSSWwsN9ViMR5NHmD1vkxTq
         SJubjv4bdvg+NbnBvA+JXDj//oU7KFk1vrdHEvf8nAS79s9H1w1uRditovAwVywQnDRN
         zk3YKD0ffZJHYpj7oR1gMT/DUPAyhKNw0J4fkFDXpzibosqfs+vyS1D7yprYddcSKsnD
         cEF1BPHhGgjiZ5VJONWSZbFtPIdyrLKDd0ACYwEKon4QfPGH+F6MlGvedxVN7llIXfOW
         Si2dAxeCbFQ32D28Wuw5QHdJERIZfUVIMUkEBacm7BlgfYEz+w36pQR+zOmW8Q3m9+9s
         O5BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=gF4PFGeOCBPbyVDX2yvL+porZgljePXBrb0QVyft2vc=;
        b=o8/5kWZXvWDfGG0DcH05fMZ14NB/CoArxaZXZxGSvQflyMeW7QJ0Mj4t3J3Hwt7m0b
         TlPnkpCfaVPg+WFq32uaeUhW7ggIRB51GzoQJEmjE7oP0WswSFORGZ3ARGV1enKmPUFi
         m8e9ni6u5T2F9h5XR0oTlvpg1ye3kK+POMgmMR82Rn02lTcdN2VNsbHa9+6Hai5RsJh6
         c4uq43KNRAqR1XXUfJELU+jjJ3hEG5XVARRyTNajeHWhvEO0K9OH1cQlN/SttG0uPHs0
         xhxi8yhccEzquS1XpphlzSFPd95Rzkhz8Qkketxkjnl8/Gg3ytHeFcMz2ORAxO0sj4rU
         oKhw==
X-Gm-Message-State: AOAM531zLrXomcNOkFHB6G8kzDOqvednmSMX25UmR9hkP+37ZAF64m15
        5Tqix2BQtxBTuCP4nOZpuHo=
X-Google-Smtp-Source: ABdhPJxNSuiV+YvEVUpTjO4FbpA1xAMjGcVGXZemMMPVqWm4SgrI++enm2aLr5jJiKhnIEYrBCJuIw==
X-Received: by 2002:a6b:f919:: with SMTP id j25mr22013078iog.113.1599582365573;
        Tue, 08 Sep 2020 09:26:05 -0700 (PDT)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id v7sm10269657ilg.83.2020.09.08.09.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 09:26:04 -0700 (PDT)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     bfields@redhat.com, chuck.lever@oracle.com,
        linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v5 4/5] NFSD: Return both a hole and a data segment
Date:   Tue,  8 Sep 2020 12:25:58 -0400
Message-Id: <20200908162559.509113-5-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200908162559.509113-1-Anna.Schumaker@Netapp.com>
References: <20200908162559.509113-1-Anna.Schumaker@Netapp.com>
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
v5: If we've already encoded a segment, then return a short read if
    later segments return an error for some reason.
---
 fs/nfsd/nfs4xdr.c | 54 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 39 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 45159bd9e9a4..856606263c1d 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -4603,7 +4603,7 @@ nfsd4_encode_offload_status(struct nfsd4_compoundres *resp, __be32 nfserr,
 static __be32
 nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
 			    struct nfsd4_read *read,
-			    unsigned long maxcount,  u32 *eof)
+			    unsigned long *maxcount, u32 *eof)
 {
 	struct xdr_stream *xdr = &resp->xdr;
 	struct file *file = read->rd_nf->nf_file;
@@ -4614,19 +4614,19 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
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
 
@@ -4634,7 +4634,7 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
 	write_bytes_to_xdr_buf(xdr->buf, starting_len,      &tmp,   4);
 	tmp64 = cpu_to_be64(read->rd_offset);
 	write_bytes_to_xdr_buf(xdr->buf, starting_len + 4,  &tmp64, 8);
-	tmp = htonl(maxcount);
+	tmp = htonl(*maxcount);
 	write_bytes_to_xdr_buf(xdr->buf, starting_len + 12, &tmp,   4);
 	return nfs_ok;
 }
@@ -4642,11 +4642,19 @@ nfsd4_encode_read_plus_data(struct nfsd4_compoundres *resp,
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
@@ -4654,9 +4662,10 @@ nfsd4_encode_read_plus_hole(struct nfsd4_compoundres *resp,
 
 	*p++ = htonl(NFS4_CONTENT_HOLE);
 	 p   = xdr_encode_hyper(p, read->rd_offset);
-	 p   = xdr_encode_hyper(p, maxcount);
+	 p   = xdr_encode_hyper(p, count);
 
-	*eof = (read->rd_offset + maxcount) >= i_size_read(file_inode(file));
+	*eof = (read->rd_offset + count) >= i_size_read(file_inode(file));
+	*maxcount = min_t(unsigned long, count, *maxcount);
 	return nfs_ok;
 }
 
@@ -4664,7 +4673,7 @@ static __be32
 nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
 		       struct nfsd4_read *read)
 {
-	unsigned long maxcount;
+	unsigned long maxcount, count;
 	struct xdr_stream *xdr = &resp->xdr;
 	struct file *file;
 	int starting_len = xdr->buf->len;
@@ -4687,6 +4696,7 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
 	maxcount = min_t(unsigned long, maxcount,
 			 (xdr->buf->buflen - xdr->buf->len));
 	maxcount = min_t(unsigned long, maxcount, read->rd_length);
+	count    = maxcount;
 
 	eof = read->rd_offset >= i_size_read(file_inode(file));
 	if (eof)
@@ -4695,24 +4705,38 @@ nfsd4_encode_read_plus(struct nfsd4_compoundres *resp, __be32 nfserr,
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
 
 out:
-	if (nfserr)
+	if (nfserr && segments == 0)
 		xdr_truncate_encode(xdr, starting_len);
 	else {
 		tmp = htonl(eof);
 		write_bytes_to_xdr_buf(xdr->buf, starting_len,     &tmp, 4);
 		tmp = htonl(segments);
 		write_bytes_to_xdr_buf(xdr->buf, starting_len + 4, &tmp, 4);
+		nfserr = nfs_ok;
 	}
 
 	return nfserr;
-- 
2.28.0

