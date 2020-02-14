Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C31C815F87B
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Feb 2020 22:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387904AbgBNVMK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 14 Feb 2020 16:12:10 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:41891 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388611AbgBNVMK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 14 Feb 2020 16:12:10 -0500
Received: by mail-yw1-f65.google.com with SMTP id l22so4864737ywc.8
        for <linux-nfs@vger.kernel.org>; Fri, 14 Feb 2020 13:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JBINryEt5KKoVgjkRtc1//2JVS4TLtwlkx/Yzht0EW4=;
        b=KGG75ecxVEW4kymWq7oPdjLDqLjZtQw/aUPrmnGCscgNemvkhDDjac11fjq3lAFq2S
         VOnLfwcimSPaSfdKJOGIneuqdCIIxZALbmbuqRp09FvLNOlQcsU7aG1PVcbOnxKqsfFa
         A502+bdWw7YXuatcLZ4r2EDdjXYH7KxdolC0YVkW9oJG5tEQPYOZ0nrsaBuf9j73j6hc
         O/dIIb2ZTNc9RbJtvnBAEIwCjQyQPW1G7E0ibbJMABR8Luk3DwbU8XW+4KAxM2WA16Z4
         BXN6LihoX7dnOYSyApzUkS6ny9m6VyMkic53rz0nP8RDY0DMJWa0o5DwETQgcRsENRnb
         IQrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=JBINryEt5KKoVgjkRtc1//2JVS4TLtwlkx/Yzht0EW4=;
        b=VIVjOfk1IyQekR2Gbx0cA5ijFMSYI4jUCXCxokkhCfyKXBOOW1LbefXm8ou5m21RlF
         6riv/3zIHM6Hoftr1MDMzG7uHrMxeVShIoamGkVghhNc3eazQDcceGZAEHguhgO2quMi
         7gPde1kATtu+9g67iJZ41gxarnfXWA5jtH+kQFeV7PNaS15XktpkZRsoMR9OogWqw1u7
         BqrLnwH/MffDtAJkp19wK0izrA47zJyKwX3mIBDu1/NJbxBytgE03m979+jwS9j7AsdN
         mxniLHwjgNwUynfKM/A8boKlGb3/ACW1JRn1P9xTDpZSyvZypi9nB7/ZSzwZ2NqbYe9h
         jggQ==
X-Gm-Message-State: APjAAAV2HIZdVgzXh4AVMLh6dbMYEdCHXMk4F0b8UVZLYhh8Q3eFAcoY
        /zF42CdEQg2Gi9/QfdrAfo4=
X-Google-Smtp-Source: APXvYqwMY9W1y3/x/3MeEbVhTygSyTdg/EQw+9y9TqaulDHCLVEtwSI8yzvr+PSDLFNQWKNq6G/jvQ==
X-Received: by 2002:a81:98c7:: with SMTP id p190mr4168393ywg.200.1581714729075;
        Fri, 14 Feb 2020 13:12:09 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id t3sm3360985ywi.18.2020.02.14.13.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 13:12:08 -0800 (PST)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     bfields@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH v2 1/4] NFSD: Return eof and maxcount to nfsd4_encode_read()
Date:   Fri, 14 Feb 2020 16:12:03 -0500
Message-Id: <20200214211206.407725-2-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200214211206.407725-1-Anna.Schumaker@Netapp.com>
References: <20200214211206.407725-1-Anna.Schumaker@Netapp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Anna Schumaker <Anna.Schumaker@Netapp.com>

I want to reuse nfsd4_encode_readv() and nfsd4_encode_splice_read() in
READ_PLUS rather than reimplementing them. READ_PLUS returns a single
eof flag for the entire call and a separate maxcount for each data
segment, so we need to have the READ call encode these values in a
different place.

Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
---
 fs/nfsd/nfs4xdr.c | 60 ++++++++++++++++++++---------------------------
 1 file changed, 26 insertions(+), 34 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 9761512674a0..45f0623f6488 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3521,23 +3521,22 @@ nfsd4_encode_open_downgrade(struct nfsd4_compoundres *resp, __be32 nfserr, struc
 
 static __be32 nfsd4_encode_splice_read(
 				struct nfsd4_compoundres *resp,
-				struct nfsd4_read *read,
-				struct file *file, unsigned long maxcount)
+				struct nfsd4_read *read, struct file *file,
+				unsigned long *maxcount, u32 *eof)
 {
 	struct xdr_stream *xdr = &resp->xdr;
 	struct xdr_buf *buf = xdr->buf;
-	u32 eof;
+	long len;
 	int space_left;
 	__be32 nfserr;
-	__be32 *p = xdr->p - 2;
 
 	/* Make sure there will be room for padding if needed */
 	if (xdr->end - xdr->p < 1)
 		return nfserr_resource;
 
+	len = *maxcount;
 	nfserr = nfsd_splice_read(read->rd_rqstp, read->rd_fhp,
-				  file, read->rd_offset, &maxcount, &eof);
-	read->rd_length = maxcount;
+				  file, read->rd_offset, maxcount, eof);
 	if (nfserr) {
 		/*
 		 * nfsd_splice_actor may have already messed with the
@@ -3548,24 +3547,21 @@ static __be32 nfsd4_encode_splice_read(
 		return nfserr;
 	}
 
-	*(p++) = htonl(eof);
-	*(p++) = htonl(maxcount);
-
-	buf->page_len = maxcount;
-	buf->len += maxcount;
-	xdr->page_ptr += (buf->page_base + maxcount + PAGE_SIZE - 1)
+	buf->page_len = *maxcount;
+	buf->len += *maxcount;
+	xdr->page_ptr += (buf->page_base + *maxcount + PAGE_SIZE - 1)
 							/ PAGE_SIZE;
 
 	/* Use rest of head for padding and remaining ops: */
 	buf->tail[0].iov_base = xdr->p;
 	buf->tail[0].iov_len = 0;
 	xdr->iov = buf->tail;
-	if (maxcount&3) {
-		int pad = 4 - (maxcount&3);
+	if (*maxcount&3) {
+		int pad = 4 - (*maxcount&3);
 
 		*(xdr->p++) = 0;
 
-		buf->tail[0].iov_base += maxcount&3;
+		buf->tail[0].iov_base += *maxcount&3;
 		buf->tail[0].iov_len = pad;
 		buf->len += pad;
 	}
@@ -3579,22 +3575,20 @@ static __be32 nfsd4_encode_splice_read(
 }
 
 static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
-				 struct nfsd4_read *read,
-				 struct file *file, unsigned long maxcount)
+				 struct nfsd4_read *read, struct file *file,
+				 unsigned long *maxcount, u32 *eof)
 {
 	struct xdr_stream *xdr = &resp->xdr;
-	u32 eof;
 	int v;
 	int starting_len = xdr->buf->len - 8;
 	long len;
 	int thislen;
 	__be32 nfserr;
-	__be32 tmp;
 	__be32 *p;
 	u32 zzz = 0;
 	int pad;
 
-	len = maxcount;
+	len = *maxcount;
 	v = 0;
 
 	thislen = min_t(long, len, ((void *)xdr->end - (void *)xdr->p));
@@ -3616,22 +3610,15 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
 	}
 	read->rd_vlen = v;
 
-	len = maxcount;
+	len = *maxcount;
 	nfserr = nfsd_readv(resp->rqstp, read->rd_fhp, file, read->rd_offset,
-			    resp->rqstp->rq_vec, read->rd_vlen, &maxcount,
-			    &eof);
-	read->rd_length = maxcount;
+			    resp->rqstp->rq_vec, read->rd_vlen, maxcount, eof);
 	if (nfserr)
 		return nfserr;
-	xdr_truncate_encode(xdr, starting_len + 8 + ((maxcount+3)&~3));
+	xdr_truncate_encode(xdr, starting_len + 8 + ((*maxcount+3)&~3));
 
-	tmp = htonl(eof);
-	write_bytes_to_xdr_buf(xdr->buf, starting_len    , &tmp, 4);
-	tmp = htonl(maxcount);
-	write_bytes_to_xdr_buf(xdr->buf, starting_len + 4, &tmp, 4);
-
-	pad = (maxcount&3) ? 4 - (maxcount&3) : 0;
-	write_bytes_to_xdr_buf(xdr->buf, starting_len + 8 + maxcount,
+	pad = (*maxcount&3) ? 4 - (*maxcount&3) : 0;
+	write_bytes_to_xdr_buf(xdr->buf, starting_len + 8 + *maxcount,
 								&zzz, pad);
 	return 0;
 
@@ -3642,6 +3629,7 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
 		  struct nfsd4_read *read)
 {
 	unsigned long maxcount;
+	u32 eof;
 	struct xdr_stream *xdr = &resp->xdr;
 	struct file *file;
 	int starting_len = xdr->buf->len;
@@ -3670,13 +3658,17 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
 
 	if (file->f_op->splice_read &&
 	    test_bit(RQ_SPLICE_OK, &resp->rqstp->rq_flags))
-		nfserr = nfsd4_encode_splice_read(resp, read, file, maxcount);
+		nfserr = nfsd4_encode_splice_read(resp, read, file, &maxcount, &eof);
 	else
-		nfserr = nfsd4_encode_readv(resp, read, file, maxcount);
+		nfserr = nfsd4_encode_readv(resp, read, file, &maxcount, &eof);
 
 	if (nfserr)
 		xdr_truncate_encode(xdr, starting_len);
 
+	read->rd_length = maxcount;
+	*p++ = htonl(eof);
+	*p++ = htonl(maxcount);
+
 	return nfserr;
 }
 
-- 
2.25.0

