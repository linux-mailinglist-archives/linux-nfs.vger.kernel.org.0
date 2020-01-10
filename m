Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAAC1379C6
	for <lists+linux-nfs@lfdr.de>; Fri, 10 Jan 2020 23:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbgAJWfm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 10 Jan 2020 17:35:42 -0500
Received: from mail-yw1-f67.google.com ([209.85.161.67]:36785 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727387AbgAJWfm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 10 Jan 2020 17:35:42 -0500
Received: by mail-yw1-f67.google.com with SMTP id n184so1326642ywc.3
        for <linux-nfs@vger.kernel.org>; Fri, 10 Jan 2020 14:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=toeTekbN8QoMVU4KUzIxJQ1Ah6+ST9n2qRcQzM7pL5E=;
        b=czuB8y8+QGOXFV06UxMNzhD8km3tii3DOhkUgUDWm15rt1g8qWp5FUWFKd9EpRrMTv
         ZwAmymhpC4xWDfkgPNz92nvFp7VmgscJ/w6BWxrxCl9ltkifQ8QEjh8vVi7i14ljpSFQ
         s+ZSF2B2bdrxqsv05B4FSLgBEjaCaB1UqrwrhWit2+3J96K+RqjMqOwdLBOTynsKd0fD
         Zu5QUscNUZOBTGHKkKXvZ58+fVzM7l/Z0zGSajHvxdOGzG5dLRlnyMEY7qOARYR7XfZm
         LgOTMyNcnc/JSNg7E0uyzSy6O73y6g3JD/MCikr11f+87KTCzw/nwRkQL1SM8pIi1MAq
         rUOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=toeTekbN8QoMVU4KUzIxJQ1Ah6+ST9n2qRcQzM7pL5E=;
        b=P4Kr0fqltcqEUDQuOvhhcPfaJwFlsPqw8aECv3tA4V+hbDZAtX8WdeIfPhPgqCO3xH
         C9ImmGqPq6eh0XX3nrfkS2HfMZHe3cXCsZ5KXRrcjStIqrGA324AQsy8Zf2e9eCiPBaV
         QQh+vgEZsUU5xh46KUz0zB2j8dRdG4HsM1qfw0cBxpeDZmu+4tQ93cal1+qfRWTKbdgY
         +i5ywkbY5AdNHr0awCUi6+xhA5qrjMESk2kFmZ7onFfj/GM6pkP2lYGN+mHRmE2z0lya
         u2tyTx6aqcc4d9GVcjLyplCHgkeE2NXp57Z45FHhCKBFRMBKRoGufjkXqtJHhFcoZ8IZ
         yo9w==
X-Gm-Message-State: APjAAAUlvQgTeD2o7eS62p8zVkaxDpz4Ws9p2qcCXT+ikPE5n7s+Agn4
        UgYlNwPtMIsE4Qid7RpHhfQ=
X-Google-Smtp-Source: APXvYqwlyTnR2feVjDanp7Wq1fPnhBJbpM6YBJU2wQ/ah1oAjKnQWH64DLAFvZp4TaLZ1KtWIHUsYQ==
X-Received: by 2002:a81:3ad0:: with SMTP id h199mr597628ywa.37.1578695741657;
        Fri, 10 Jan 2020 14:35:41 -0800 (PST)
Received: from gouda.nowheycreamery.com (c-68-32-74-190.hsd1.mi.comcast.net. [68.32.74.190])
        by smtp.gmail.com with ESMTPSA id h23sm1607735ywc.105.2020.01.10.14.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 14:35:40 -0800 (PST)
From:   schumaker.anna@gmail.com
X-Google-Original-From: Anna.Schumaker@Netapp.com
To:     bfields@redhat.com, linux-nfs@vger.kernel.org
Cc:     Anna.Schumaker@Netapp.com
Subject: [PATCH 1/4] NFSD: Return eof and maxcount to nfsd4_encode_read()
Date:   Fri, 10 Jan 2020 17:35:35 -0500
Message-Id: <20200110223538.528560-2-Anna.Schumaker@Netapp.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200110223538.528560-1-Anna.Schumaker@Netapp.com>
References: <20200110223538.528560-1-Anna.Schumaker@Netapp.com>
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
index d2dc4c0e22e8..812e82097879 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3446,23 +3446,22 @@ nfsd4_encode_open_downgrade(struct nfsd4_compoundres *resp, __be32 nfserr, struc
 
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
@@ -3473,24 +3472,21 @@ static __be32 nfsd4_encode_splice_read(
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
@@ -3504,22 +3500,20 @@ static __be32 nfsd4_encode_splice_read(
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
@@ -3541,22 +3535,15 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
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
-
-	tmp = htonl(eof);
-	write_bytes_to_xdr_buf(xdr->buf, starting_len    , &tmp, 4);
-	tmp = htonl(maxcount);
-	write_bytes_to_xdr_buf(xdr->buf, starting_len + 4, &tmp, 4);
+	xdr_truncate_encode(xdr, starting_len + 8 + ((*maxcount+3)&~3));
 
-	pad = (maxcount&3) ? 4 - (maxcount&3) : 0;
-	write_bytes_to_xdr_buf(xdr->buf, starting_len + 8 + maxcount,
+	pad = (*maxcount&3) ? 4 - (*maxcount&3) : 0;
+	write_bytes_to_xdr_buf(xdr->buf, starting_len + 8 + *maxcount,
 								&zzz, pad);
 	return 0;
 
@@ -3567,6 +3554,7 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
 		  struct nfsd4_read *read)
 {
 	unsigned long maxcount;
+	u32 eof;
 	struct xdr_stream *xdr = &resp->xdr;
 	struct file *file;
 	int starting_len = xdr->buf->len;
@@ -3595,13 +3583,17 @@ nfsd4_encode_read(struct nfsd4_compoundres *resp, __be32 nfserr,
 
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
2.24.1

