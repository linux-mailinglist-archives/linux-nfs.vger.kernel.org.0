Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2B23F14CDFD
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2020 17:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgA2QKH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Jan 2020 11:10:07 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:39782 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgA2QKH (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 29 Jan 2020 11:10:07 -0500
Received: by mail-yw1-f68.google.com with SMTP id h126so69765ywc.6
        for <linux-nfs@vger.kernel.org>; Wed, 29 Jan 2020 08:10:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=lYPbrMLHi8rck1zIT7mg0NARHSsZEMZTsgzCvB2zmZ8=;
        b=cLC4PLcpEQ+oivEeu25wf/XZj3mreOIR6wfeIdmKY+6+4SWRpMCj6SEpMomLWnl6qc
         YTyMZDI24/uJz0Wp6DEW+FLIOX1INt4Vd75FIC+Mu2YuIE3dedTmdq7SAYGUbIW1XG+v
         QNGNqZU8Dsm9R1Qp0+zX30LZAbVz9TaGIZlm3ChGcwlBgRwPGlgLppJPWO2EN1ChMQvh
         zIWCp0mIiVGyU9m4yZYhJJFN80ZWovdEZ4xjVKmuEZMvaMwDCK+9mBsfm/3hqtCpxk4n
         vDDwobrAif4jdWKUyQdUBucmgESx17tKsNpz3wBkWIBhccG6nvFn5jN0NZFZELuOMB8e
         8AGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=lYPbrMLHi8rck1zIT7mg0NARHSsZEMZTsgzCvB2zmZ8=;
        b=nKv563b0B9Zd67+cTZDp+yQZwFhT9CE0KIfpMh4cn8BrjLoL0aTMkxZhWG2EPWXbJS
         O0YHb48qpu3QaCTh435B4sQr2Nm5zW/tWW/EEdVEa8S/J5VU7tMLhpnv8EI4saCdJdV0
         57kwFPzOjB5FYoouTf5AV9aE1sdlGYCXx+gO9gP/SpY0SgaFbIF2f8w/hWf+silqY8oX
         WGdVnJ907E78TPBL3NKNlggUZUivr+9D8vFApT+9nimKVSsKxh1MRt4lRobytJdrYQls
         5xptmlreNEL9I+b2U2ilQXaAVNz/0ITKdQdAo2pQyIF3r/ENOIWcYZ5RDrXXfDrlrpnb
         jtVQ==
X-Gm-Message-State: APjAAAUWvk9KNVBuw/TeL4Z7QQcQkJzNTHtwhbxalP4UQ+9xmkFXdJKi
        4b7EKq42zTlPshMS3l6BWgA1A5H0
X-Google-Smtp-Source: APXvYqwqmU9wPsOSbpgQkS5gsxYWU77EYJJsWCMZpues1YoTlpNHjOYYekNL3Q5fknfPEIlaZ14lbg==
X-Received: by 2002:a0d:e28c:: with SMTP id l134mr22230176ywe.54.1580314206183;
        Wed, 29 Jan 2020 08:10:06 -0800 (PST)
Received: from bazille.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id j68sm1124817ywg.6.2020.01.29.08.10.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jan 2020 08:10:05 -0800 (PST)
Subject: [PATCH RFC 7/8] sunrpc: Add new contractual constraint on xdr_buf
 API
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 29 Jan 2020 11:10:05 -0500
Message-ID: <20200129161005.3024.19820.stgit@bazille.1015granger.net>
In-Reply-To: <20200129155516.3024.56575.stgit@bazille.1015granger.net>
References: <20200129155516.3024.56575.stgit@bazille.1015granger.net>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Server-side only.

Let's move some XDR padding logic into the transports, where it
can be handled automatically. Essentially, all three sections of
the xdr_buf always begin on XDR alignment, and the RPC layer
will insert padding between the sections to enforce that
guarantee, as the buffer is transmitted.

o head[0] has always begun on an XDR boundary, so no change there.
o Insertion should be "almost never" for the boundary between
  head[0] and the page list. This is determined by checking if
  head[0].iov_len is XDR-aligned.
o Insertion might be somewhat frequent for the boundary between
  the page list and tail[0]. This is determined by checking if
  (head[0].iov_len + page_len) is XDR-aligned.

Whatever is contained in each section of the xdr_buf remains the
responsibility of the upper layer to form correctly.

So if nfsd4_encode_readv wants to stuff a bunch of XDR items into
the page list, it is free to do so without confusing the transport.
The only alignment concern is the last item in the page list,
which will be automatically handled by RPC and the transport layers.

One benefit of this change is that padding logic duplicated
throughout the NFSD Reply encoders can be eliminated. Those changes
will occur in subsequent patches.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4xdr.c |   55 +++++++++++++----------------------------------------
 net/sunrpc/xdr.c  |   12 ++++++------
 2 files changed, 19 insertions(+), 48 deletions(-)

diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 92a6ada60932..c4d5595dd38e 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -3457,10 +3457,6 @@ static __be32 nfsd4_encode_splice_read(
 	__be32 nfserr;
 	__be32 *p = xdr->p - 2;
 
-	/* Make sure there will be room for padding if needed */
-	if (xdr->end - xdr->p < 1)
-		return nfserr_resource;
-
 	nfserr = nfsd_splice_read(read->rd_rqstp, read->rd_fhp,
 				  file, read->rd_offset, &maxcount, &eof);
 	read->rd_length = maxcount;
@@ -3470,32 +3466,18 @@ static __be32 nfsd4_encode_splice_read(
 		 * page length; reset it so as not to confuse
 		 * xdr_truncate_encode:
 		 */
-		buf->page_len = 0;
+		xdr_buf_set_pagelen(buf, 0);
 		return nfserr;
 	}
 
 	*(p++) = htonl(eof);
 	*(p++) = htonl(maxcount);
 
-	buf->page_len = maxcount;
-	buf->len += maxcount;
+	xdr_buf_set_pagelen(buf, maxcount);
+	buf->len = xdr_buf_msglen(buf);
 	xdr->page_ptr += (buf->page_base + maxcount + PAGE_SIZE - 1)
 							/ PAGE_SIZE;
 
-	/* Use rest of head for padding and remaining ops: */
-	buf->tail[0].iov_base = xdr->p;
-	buf->tail[0].iov_len = 0;
-	xdr->iov = buf->tail;
-	if (maxcount&3) {
-		int pad = 4 - (maxcount&3);
-
-		*(xdr->p++) = 0;
-
-		buf->tail[0].iov_base += maxcount&3;
-		buf->tail[0].iov_len = pad;
-		buf->len += pad;
-	}
-
 	space_left = min_t(int, (void *)xdr->end - (void *)xdr->p,
 				buf->buflen - buf->len);
 	buf->buflen = buf->len + space_left;
@@ -3518,8 +3500,6 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
 	__be32 nfserr;
 	__be32 tmp;
 	__be32 *p;
-	u32 zzz = 0;
-	int pad;
 
 	/* Ensure xdr_reserve_space behaves itself */
 	if (xdr->iov == xdr->buf->head) {
@@ -3531,7 +3511,7 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
 	v = 0;
 	while (len) {
 		thislen = min_t(long, len, PAGE_SIZE);
-		p = xdr_reserve_space(xdr, (thislen+3)&~3);
+		p = xdr_reserve_space(xdr, thislen);
 		WARN_ON_ONCE(!p);
 		resp->rqstp->rq_vec[v].iov_base = p;
 		resp->rqstp->rq_vec[v].iov_len = thislen;
@@ -3540,23 +3520,18 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
 	}
 	read->rd_vlen = v;
 
-	len = maxcount;
 	nfserr = nfsd_readv(resp->rqstp, read->rd_fhp, file, read->rd_offset,
 			    resp->rqstp->rq_vec, read->rd_vlen, &maxcount,
 			    &eof);
 	read->rd_length = maxcount;
 	if (nfserr)
 		return nfserr;
-	xdr_truncate_encode(xdr, starting_len + 8 + ((maxcount+3)&~3));
+	xdr_truncate_encode(xdr, starting_len + 8 + maxcount);
 
 	tmp = htonl(eof);
 	write_bytes_to_xdr_buf(xdr->buf, starting_len    , &tmp, 4);
 	tmp = htonl(maxcount);
 	write_bytes_to_xdr_buf(xdr->buf, starting_len + 4, &tmp, 4);
-
-	pad = (maxcount&3) ? 4 - (maxcount&3) : 0;
-	write_bytes_to_xdr_buf(xdr->buf, starting_len + 8 + maxcount,
-								&zzz, pad);
 	return 0;
 
 }
@@ -3610,8 +3585,7 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
 nfsd4_encode_readlink(struct nfsd4_compoundres *resp, __be32 nfserr, struct nfsd4_readlink *readlink)
 {
 	int maxcount;
-	__be32 wire_count;
-	int zero = 0;
+	__be32 tmp;
 	struct xdr_stream *xdr = &resp->xdr;
 	int length_offset = xdr->buf->len;
 	__be32 *p;
@@ -3621,9 +3595,12 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
 		return nfserr_resource;
 	maxcount = PAGE_SIZE;
 
+	/* XXX: This is probably going to result
+	 * in the same bad behavior of RPC/RDMA */
 	p = xdr_reserve_space(xdr, maxcount);
 	if (!p)
 		return nfserr_resource;
+
 	/*
 	 * XXX: By default, vfs_readlink() will truncate symlinks if they
 	 * would overflow the buffer.  Is this kosher in NFSv4?  If not, one
@@ -3639,12 +3616,9 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
 		return nfserr;
 	}
 
-	wire_count = htonl(maxcount);
-	write_bytes_to_xdr_buf(xdr->buf, length_offset, &wire_count, 4);
-	xdr_truncate_encode(xdr, length_offset + 4 + ALIGN(maxcount, 4));
-	if (maxcount & 3)
-		write_bytes_to_xdr_buf(xdr->buf, length_offset + 4 + maxcount,
-						&zero, 4 - (maxcount&3));
+	tmp = cpu_to_be32(maxcount);
+	write_bytes_to_xdr_buf(xdr->buf, length_offset, &tmp, 4);
+	xdr_truncate_encode(xdr, length_offset + 4 + xdr_align_size(maxcount));
 	return 0;
 }
 
@@ -3718,6 +3692,7 @@ static __be32 nfsd4_encode_readv(struct nfsd4_compoundres *resp,
 	}
 	if (nfserr)
 		goto err_no_verf;
+	WARN_ON(maxcount != xdr_align_size(maxcount));
 
 	if (readdir->cookie_offset) {
 		wire_offset = cpu_to_be64(offset);
@@ -4568,10 +4543,6 @@ void nfsd4_release_compoundargs(struct svc_rqst *rqstp)
 	 * All that remains is to write the tag and operation count...
 	 */
 	struct nfsd4_compoundres *resp = rqstp->rq_resp;
-	struct xdr_buf *buf = resp->xdr.buf;
-
-	WARN_ON_ONCE(buf->len != buf->head[0].iov_len + buf->page_len +
-				 buf->tail[0].iov_len);
 
 	rqstp->rq_next_page = resp->xdr.page_ptr + 1;
 
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index f3104be8ff5d..d2dadb200024 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -675,15 +675,15 @@ void xdr_truncate_encode(struct xdr_stream *xdr, size_t len)
 	int fraglen;
 	int new;
 
-	if (len > buf->len) {
+	if (len > xdr_buf_msglen(buf)) {
 		WARN_ON_ONCE(1);
 		return;
 	}
 	xdr_commit_encode(xdr);
 
-	fraglen = min_t(int, buf->len - len, tail->iov_len);
+	fraglen = min_t(int, xdr_buf_msglen(buf) - len, tail->iov_len);
 	tail->iov_len -= fraglen;
-	buf->len -= fraglen;
+	buf->len = xdr_buf_msglen(buf);
 	if (tail->iov_len) {
 		xdr->p = tail->iov_base + tail->iov_len;
 		WARN_ON_ONCE(!xdr->end);
@@ -691,12 +691,12 @@ void xdr_truncate_encode(struct xdr_stream *xdr, size_t len)
 		return;
 	}
 	WARN_ON_ONCE(fraglen);
-	fraglen = min_t(int, buf->len - len, buf->page_len);
+	fraglen = min_t(int, xdr_buf_msglen(buf) - len, buf->page_len);
 	buf->page_len -= fraglen;
-	buf->len -= fraglen;
+	buf->page_pad = xdr_pad_size(buf->page_len);
+	buf->len = xdr_buf_msglen(buf);
 
 	new = buf->page_base + buf->page_len;
-
 	xdr->page_ptr = buf->pages + (new >> PAGE_SHIFT);
 
 	if (buf->page_len) {

