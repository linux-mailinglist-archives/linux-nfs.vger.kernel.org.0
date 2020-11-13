Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B712B1DF7
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Nov 2020 16:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgKMPDM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Nov 2020 10:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgKMPDM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Nov 2020 10:03:12 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83D64C0613D1
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:02:53 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id b11so4694364qvr.9
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 07:02:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=ZfaPsoHARUKobWJYyh/xAxYHvicQZUoOseSFX3buHvA=;
        b=T5mQTsFlIJDnkuCiOzfMossud5J6nHJhM5EeqsKsNl7K68sZeSxFGI/vpkhYh0gdlq
         Pk1rPRIboaTTDLgAP5H/IiajmB3cPo0/Bwp0/ElGwbR6upL6RNOdOl5qTigJA3Br6fhn
         Aq+rb514SeAtACtMLoSXE8Sz2EGYNv+N9BYKVv4kwfo4xvAFl45Qk5iU2S3CNqIWaFnO
         yVWMm+pF+v+8JJZJEaPIVrpRTsfzRU5CfGd63dbi/QRtKnXyj7YlxpA7FPmP5X9axzKB
         c6DWTjvLqsSyPewhdpCuuIQIOr2aPafwWeAtjg2jsA26HBTSieNuqW08y5IcXyNnheZa
         8UQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=ZfaPsoHARUKobWJYyh/xAxYHvicQZUoOseSFX3buHvA=;
        b=FG1zHxzcoG+MJCVq5+wZfORZzNeMI1qF85tJ8s/zwCIZ5Ud6Hn3n2X6cRie11jF9Bq
         r7+dR1KUlFYh+fCI3QC8nR8cYqFYLMxxrHsZSx6BaxoegGvrcq1WM43WEddNBghCnPSU
         ZgvM+bxfgCaqGfNYv34thcT65plgsKFn265SzcWCP1b3SqwvECoyjrX/MRXnxJ0fWtkC
         EtWTwlh7yDFRpBDW112aR3T4Y743FiNOq30+jmrxYJBHRLO+G/Io0dIphe6YXeuLumid
         UF4mA+UAiQnfG81fsNePYbtJimhICa3MTG67J2KfjQKN52fldwEB5C79oU+++Qc6X+x+
         J8GQ==
X-Gm-Message-State: AOAM53290KJ70sVsmPq0XF7pL/MOW5xB5/SM96hQxWS55sez0bHMPACH
        w/3+9FsM8X8twmS/L+yiqSIvIAko+qI=
X-Google-Smtp-Source: ABdhPJwlXIOE/zEeresK5tuV+z5ETX3KN85VMF3AIa56MeqbHgSC2g8IPvce642qUPPOsGsiKRrebQ==
X-Received: by 2002:a0c:ff23:: with SMTP id x3mr2744890qvt.23.1605279771737;
        Fri, 13 Nov 2020 07:02:51 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id z6sm6317006qti.88.2020.11.13.07.02.50
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2020 07:02:51 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0ADF2o8t032652
        for <linux-nfs@vger.kernel.org>; Fri, 13 Nov 2020 15:02:50 GMT
Subject: [PATCH v1 05/61] NFSD: Replace the internals of the READ_BUF() macro
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 13 Nov 2020 10:02:50 -0500
Message-ID: <160527977023.6186.8362456431432350401.stgit@klimt.1015granger.net>
In-Reply-To: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
References: <160527962905.6186.17550620763636619885.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Convert the READ_BUF macro in nfs4xdr.c from open code to instead
use the new xdr_stream-style decoders already in use by the encode
side (and by the in-kernel NFS client implementation). Once this
conversion is done, each individual NFSv4 argument decoder can be
independently cleaned up to replace these macros with C code.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4proc.c         |    4 -
 fs/nfsd/nfs4xdr.c          |  181 ++++++--------------------------------------
 fs/nfsd/xdr4.h             |   10 --
 include/linux/sunrpc/xdr.h |    2 
 net/sunrpc/xdr.c           |   44 +++++++++++
 5 files changed, 76 insertions(+), 165 deletions(-)

diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index 7295b8eeb43f..91197626d0d2 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -1023,8 +1023,8 @@ nfsd4_write(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 
 	write->wr_how_written = write->wr_stable_how;
 
-	nvecs = svc_fill_write_vector(rqstp, write->wr_pagelist,
-				      &write->wr_head, write->wr_buflen);
+	nvecs = svc_fill_write_vector(rqstp, write->wr_payload.pages,
+				      write->wr_payload.head, write->wr_buflen);
 	WARN_ON_ONCE(nvecs > ARRAY_SIZE(rqstp->rq_vec));
 
 	status = nfsd_vfs_write(rqstp, &cstate->current_fh, nf,
diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
index 6c3d45f68b75..26265d649c39 100644
--- a/fs/nfsd/nfs4xdr.c
+++ b/fs/nfsd/nfs4xdr.c
@@ -129,90 +129,13 @@ xdr_error:					\
 	memcpy((x), p, nbytes);			\
 	p += XDR_QUADLEN(nbytes);		\
 } while (0)
-
-/* READ_BUF, read_buf(): nbytes must be <= PAGE_SIZE */
-#define READ_BUF(nbytes)  do {			\
-	if (nbytes <= (u32)((char *)argp->end - (char *)argp->p)) {	\
-		p = argp->p;			\
-		argp->p += XDR_QUADLEN(nbytes);	\
-	} else if (!(p = read_buf(argp, nbytes))) { \
-		dprintk("NFSD: xdr error (%s:%d)\n", \
-				__FILE__, __LINE__); \
-		goto xdr_error;			\
-	}					\
-} while (0)
-
-static void next_decode_page(struct nfsd4_compoundargs *argp)
-{
-	argp->p = page_address(argp->pagelist[0]);
-	argp->pagelist++;
-	if (argp->pagelen < PAGE_SIZE) {
-		argp->end = argp->p + XDR_QUADLEN(argp->pagelen);
-		argp->pagelen = 0;
-	} else {
-		argp->end = argp->p + (PAGE_SIZE>>2);
-		argp->pagelen -= PAGE_SIZE;
-	}
-}
-
-static __be32 *read_buf(struct nfsd4_compoundargs *argp, u32 nbytes)
-{
-	/* We want more bytes than seem to be available.
-	 * Maybe we need a new page, maybe we have just run out
-	 */
-	unsigned int avail = (char *)argp->end - (char *)argp->p;
-	__be32 *p;
-
-	if (argp->pagelen == 0) {
-		struct kvec *vec = &argp->rqstp->rq_arg.tail[0];
-
-		if (!argp->tail) {
-			argp->tail = true;
-			avail = vec->iov_len;
-			argp->p = vec->iov_base;
-			argp->end = vec->iov_base + avail;
-		}
-
-		if (avail < nbytes)
-			return NULL;
-
-		p = argp->p;
-		argp->p += XDR_QUADLEN(nbytes);
-		return p;
-	}
-
-	if (avail + argp->pagelen < nbytes)
-		return NULL;
-	if (avail + PAGE_SIZE < nbytes) /* need more than a page !! */
-		return NULL;
-	/* ok, we can do it with the current plus the next page */
-	if (nbytes <= sizeof(argp->tmp))
-		p = argp->tmp;
-	else {
-		kfree(argp->tmpp);
-		p = argp->tmpp = kmalloc(nbytes, GFP_KERNEL);
-		if (!p)
-			return NULL;
-		
-	}
-	/*
-	 * The following memcpy is safe because read_buf is always
-	 * called with nbytes > avail, and the two cases above both
-	 * guarantee p points to at least nbytes bytes.
-	 */
-	memcpy(p, argp->p, avail);
-	next_decode_page(argp);
-	memcpy(((char*)p)+avail, argp->p, (nbytes - avail));
-	argp->p += XDR_QUADLEN(nbytes - avail);
-	return p;
-}
-
-static unsigned int compoundargs_bytes_left(struct nfsd4_compoundargs *argp)
-{
-	unsigned int this = (char *)argp->end - (char *)argp->p;
-
-	return this + argp->pagelen;
-}
+#define READ_BUF(nbytes)			\
+	do {					\
+		p = xdr_inline_decode(argp->xdr,\
+				      nbytes);	\
+		if (!p)				\
+			goto xdr_error;		\
+	} while (0)
 
 static int zero_clientid(clientid_t *clid)
 {
@@ -259,44 +182,6 @@ svcxdr_dupstr(struct nfsd4_compoundargs *argp, void *buf, u32 len)
 	return p;
 }
 
-static __be32
-svcxdr_construct_vector(struct nfsd4_compoundargs *argp, struct kvec *head,
-			struct page ***pagelist, u32 buflen)
-{
-	int avail;
-	int len;
-	int pages;
-
-	/* Sorry .. no magic macros for this.. *
-	 * READ_BUF(write->wr_buflen);
-	 * SAVEMEM(write->wr_buf, write->wr_buflen);
-	 */
-	avail = (char *)argp->end - (char *)argp->p;
-	if (avail + argp->pagelen < buflen) {
-		dprintk("NFSD: xdr error (%s:%d)\n",
-			       __FILE__, __LINE__);
-		return nfserr_bad_xdr;
-	}
-	head->iov_base = argp->p;
-	head->iov_len = avail;
-	*pagelist = argp->pagelist;
-
-	len = XDR_QUADLEN(buflen) << 2;
-	if (len >= avail) {
-		len -= avail;
-
-		pages = len >> PAGE_SHIFT;
-		argp->pagelist += pages;
-		argp->pagelen -= pages * PAGE_SIZE;
-		len -= pages * PAGE_SIZE;
-
-		next_decode_page(argp);
-	}
-	argp->p += XDR_QUADLEN(len);
-
-	return 0;
-}
-
 /**
  * savemem - duplicate a chunk of memory for later processing
  * @argp: NFSv4 compound argument structure to be freed with
@@ -396,7 +281,7 @@ nfsd4_decode_fattr(struct nfsd4_compoundargs *argp, u32 *bmval,
 		READ_BUF(4); len += 4;
 		nace = be32_to_cpup(p++);
 
-		if (nace > compoundargs_bytes_left(argp)/20)
+		if (nace > xdr_stream_remaining(argp->xdr) / sizeof(struct nfs4_ace))
 			/*
 			 * Even with 4-byte names there wouldn't be
 			 * space for that many aces; something fishy is
@@ -927,7 +812,7 @@ static __be32 nfsd4_decode_share_deny(struct nfsd4_compoundargs *argp, u32 *x)
 
 static __be32 nfsd4_decode_opaque(struct nfsd4_compoundargs *argp, struct xdr_netobj *o)
 {
-	__be32 *p;
+	DECODE_HEAD;
 
 	READ_BUF(4);
 	o->len = be32_to_cpup(p++);
@@ -937,9 +822,8 @@ static __be32 nfsd4_decode_opaque(struct nfsd4_compoundargs *argp, struct xdr_ne
 
 	READ_BUF(o->len);
 	SAVEMEM(o->data, o->len);
-	return nfs_ok;
-xdr_error:
-	return nfserr_bad_xdr;
+
+	DECODE_TAIL;
 }
 
 static __be32
@@ -1317,10 +1201,8 @@ nfsd4_decode_write(struct nfsd4_compoundargs *argp, struct nfsd4_write *write)
 		goto xdr_error;
 	write->wr_buflen = be32_to_cpup(p++);
 
-	status = svcxdr_construct_vector(argp, &write->wr_head,
-					 &write->wr_pagelist, write->wr_buflen);
-	if (status)
-		return status;
+	if (!xdr_stream_subsegment(argp->xdr, &write->wr_payload, write->wr_buflen))
+		goto xdr_error;
 
 	DECODE_TAIL;
 }
@@ -1889,13 +1771,14 @@ nfsd4_decode_seek(struct nfsd4_compoundargs *argp, struct nfsd4_seek *seek)
  */
 
 /*
- * Decode data into buffer. Uses head and pages constructed by
- * svcxdr_construct_vector.
+ * Decode data into buffer.
  */
 static __be32
-nfsd4_vbuf_from_vector(struct nfsd4_compoundargs *argp, struct kvec *head,
-		       struct page **pages, char **bufp, u32 buflen)
+nfsd4_vbuf_from_vector(struct nfsd4_compoundargs *argp, struct xdr_buf *xdr,
+		       char **bufp, u32 buflen)
 {
+	struct page **pages = xdr->pages;
+	struct kvec *head = xdr->head;
 	char *tmp, *dp;
 	u32 len;
 
@@ -2010,8 +1893,6 @@ nfsd4_decode_setxattr(struct nfsd4_compoundargs *argp,
 {
 	DECODE_HEAD;
 	u32 flags, maxcount, size;
-	struct kvec head;
-	struct page **pagelist;
 
 	READ_BUF(4);
 	flags = be32_to_cpup(p++);
@@ -2034,12 +1915,12 @@ nfsd4_decode_setxattr(struct nfsd4_compoundargs *argp,
 
 	setxattr->setxa_len = size;
 	if (size > 0) {
-		status = svcxdr_construct_vector(argp, &head, &pagelist, size);
-		if (status)
-			return status;
+		struct xdr_buf payload;
 
-		status = nfsd4_vbuf_from_vector(argp, &head, pagelist,
-		    &setxattr->setxa_buf, size);
+		if (!xdr_stream_subsegment(argp->xdr, &payload, size))
+			goto xdr_error;
+		status = nfsd4_vbuf_from_vector(argp, &payload,
+						&setxattr->setxa_buf, size);
 	}
 
 	DECODE_TAIL;
@@ -5279,8 +5160,6 @@ void nfsd4_release_compoundargs(struct svc_rqst *rqstp)
 		kfree(args->ops);
 		args->ops = args->iops;
 	}
-	kfree(args->tmpp);
-	args->tmpp = NULL;
 	while (args->to_free) {
 		struct svcxdr_tmpbuf *tb = args->to_free;
 		args->to_free = tb->next;
@@ -5293,19 +5172,11 @@ nfs4svc_decode_compoundargs(struct svc_rqst *rqstp, __be32 *p)
 {
 	struct nfsd4_compoundargs *args = rqstp->rq_argp;
 
-	if (rqstp->rq_arg.head[0].iov_len % 4) {
-		/* client is nuts */
-		dprintk("%s: compound not properly padded! (peeraddr=%pISc xid=0x%x)",
-			__func__, svc_addr(rqstp), be32_to_cpu(rqstp->rq_xid));
-		return 0;
-	}
-	args->p = p;
-	args->end = rqstp->rq_arg.head[0].iov_base + rqstp->rq_arg.head[0].iov_len;
-	args->pagelist = rqstp->rq_arg.pages;
-	args->pagelen = rqstp->rq_arg.page_len;
-	args->tail = false;
+	/* svcxdr_tmp_alloc */
 	args->tmpp = NULL;
 	args->to_free = NULL;
+
+	args->xdr = &rqstp->rq_xdr_stream;
 	args->ops = args->iops;
 	args->rqstp = rqstp;
 
diff --git a/fs/nfsd/xdr4.h b/fs/nfsd/xdr4.h
index 37f89ad5e992..0eb13bd603ea 100644
--- a/fs/nfsd/xdr4.h
+++ b/fs/nfsd/xdr4.h
@@ -419,8 +419,7 @@ struct nfsd4_write {
 	u64		wr_offset;          /* request */
 	u32		wr_stable_how;      /* request */
 	u32		wr_buflen;          /* request */
-	struct kvec	wr_head;
-	struct page **	wr_pagelist;        /* request */
+	struct xdr_buf	wr_payload;         /* request */
 
 	u32		wr_bytes_written;   /* response */
 	u32		wr_how_written;     /* response */
@@ -696,15 +695,10 @@ struct svcxdr_tmpbuf {
 
 struct nfsd4_compoundargs {
 	/* scratch variables for XDR decode */
-	__be32 *			p;
-	__be32 *			end;
-	struct page **			pagelist;
-	int				pagelen;
-	bool				tail;
 	__be32				tmp[8];
 	__be32 *			tmpp;
+	struct xdr_stream		*xdr;
 	struct svcxdr_tmpbuf		*to_free;
-
 	struct svc_rqst			*rqstp;
 
 	u32				taglen;
diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 3fffd7f15c3a..579beeb0dac2 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -259,6 +259,8 @@ extern void xdr_enter_page(struct xdr_stream *xdr, unsigned int len);
 extern int xdr_process_buf(struct xdr_buf *buf, unsigned int offset, unsigned int len, int (*actor)(struct scatterlist *, void *), void *data);
 extern uint64_t xdr_align_data(struct xdr_stream *, uint64_t, uint32_t);
 extern uint64_t xdr_expand_hole(struct xdr_stream *, uint64_t, uint64_t);
+extern bool xdr_stream_subsegment(struct xdr_stream *xdr, struct xdr_buf *subbuf,
+				  unsigned int len);
 
 /**
  * xdr_set_scratch_buffer - Attach a scratch buffer for decoding data.
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index c607744b3ea8..272c9d566e6a 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -1407,6 +1407,50 @@ int xdr_buf_subsegment(const struct xdr_buf *buf, struct xdr_buf *subbuf,
 }
 EXPORT_SYMBOL_GPL(xdr_buf_subsegment);
 
+/**
+ * xdr_stream_subsegment - set @subbuf to a portion of @xdr
+ * @xdr: an xdr_stream set up for decoding
+ * @subbuf: the result buffer
+ * @nbytes: length of @xdr to extract, in bytes
+ *
+ * Sets up @subbuf to represent a portion of @xdr. The portion
+ * starts at the current offset in @xdr, and extends for a length
+ * of @nbytes. If this is successful, @xdr is advanced to the next
+ * position following that portion.
+ *
+ * Return values:
+ *   %true: @subbuf has been initialized, and @xdr has been advanced.
+ *   %false: a bounds error occurred; @xdr is unchanged.
+ */
+bool xdr_stream_subsegment(struct xdr_stream *xdr, struct xdr_buf *subbuf,
+			   unsigned int nbytes)
+{
+	unsigned int len, remaining, offset;
+
+	if (xdr_buf_subsegment(xdr->buf, subbuf, xdr_stream_pos(xdr), nbytes))
+		return false;
+
+	if (subbuf->head[0].iov_len)
+		__xdr_inline_decode(xdr, subbuf->head[0].iov_len);
+
+	remaining = subbuf->page_len;
+	offset = subbuf->page_base;
+	while (remaining) {
+		len = min_t(unsigned int, remaining, PAGE_SIZE);
+		len -= offset;
+
+		if (xdr->p == xdr->end)
+			xdr_set_next_buffer(xdr);
+		__xdr_inline_decode(xdr, len);
+
+		remaining -= len;
+		offset = 0;
+	}
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(xdr_stream_subsegment);
+
 /**
  * xdr_buf_trim - lop at most "len" bytes off the end of "buf"
  * @buf: buf to be trimmed


