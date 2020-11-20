Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF402BB714
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Nov 2020 21:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731028AbgKTUeA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 20 Nov 2020 15:34:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730372AbgKTUeA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 20 Nov 2020 15:34:00 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94F9C0613CF
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:33:59 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id q5so10157609qkc.12
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 12:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=HcSb6CUIyEdHtSUSeX0VbJSU8WnCONnxaJpo3aBIQQY=;
        b=ZpjXLP1LWQWc1GG/sIqUVQm3AO+WkUG8EzZwZIeSadcuRSXWwlJ7xqONbml4iRIIqO
         9xi0f9Zbda60C5zTTGd4ny/ChenJ3vocv7RxWy102Iz3UfvaLq47XMPx9ZtKg0961ATW
         dAUvo7G7RF874cPCOuYd2TNYhWaphGg+EZ6XPa3DOAilgVYrywwggks7s0wOJSfmZOje
         79KO8826wjrCUnk4IbWvlaa2oDp4OYeb04vY4Jw5MzjVIAdUpwE/vrgvBnYL5xnO6j6C
         eBn3408RuTrYZDOH7CG+KJKRtQ/TWnaGXKsW8WbMbUnd/vr4yhj27SpQyUlbQ9zYYE+r
         nMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=HcSb6CUIyEdHtSUSeX0VbJSU8WnCONnxaJpo3aBIQQY=;
        b=Ple2Vsupg6ryExBO4++SNjiTydDvZF/G0YpNoNp0VX6GpBovIeG8nZGC8p1iDWJ09K
         HAujMzS323t2XWwDv+wFfacCMPaTKJh5ixTHkhQeZDKo4yUASeI+NgIxnK4JOdc88hS2
         eLHxGHU1nRX+x3RKM0QJjhDTzP1WrQ5lOhx+FNL1lgDzB6u0KljpA2yRQ7rwd0oCJzAT
         K+8tK7jgqapZ+cW/zdrCbH0tKnxLX6ez+tu1KC3kK+JYr+Tsy+PKEHZF8E0E66fxyvZ/
         X6OLAkj4WnKDHlknUH0Gk1pVTZMGY12VkoCYCXtzEn7KuaFpMH9RgoihrX5k1i3cx5Kp
         4DXg==
X-Gm-Message-State: AOAM532T9CVxvqZ2XuAU2Rk1Ar5ArIhmj1AUCbA4TAvur3Mud28cK9fO
        /ojwpFRJvqEx0m7qSnWhMuJDMgsv5qQ=
X-Google-Smtp-Source: ABdhPJyVgcema9Lvcz7L3GyiZ/qI4cYQYJLcL+r0/A6Ga5G8L3yLjNeHr3LUoXGT7O5OImvVLa5W1Q==
X-Received: by 2002:a37:7d01:: with SMTP id y1mr18534902qkc.327.1605904438484;
        Fri, 20 Nov 2020 12:33:58 -0800 (PST)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id q31sm2144296qtd.23.2020.11.20.12.33.57
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Nov 2020 12:33:57 -0800 (PST)
Sender: Chuck Lever <chucklever@gmail.com>
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 0AKKXuGq029208
        for <linux-nfs@vger.kernel.org>; Fri, 20 Nov 2020 20:33:56 GMT
Subject: [PATCH v2 002/118] SUNRPC: Add xdr_set_scratch_page() and
 xdr_reset_scratch_buffer()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:33:56 -0500
Message-ID: <160590443670.1340.14301271082837069231.stgit@klimt.1015granger.net>
In-Reply-To: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
References: <160590425404.1340.8850646771948736468.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Clean up: De-duplicate some frequently-used code.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfs/blocklayout/blocklayout.c          |    2 +
 fs/nfs/blocklayout/dev.c                  |    2 +
 fs/nfs/dir.c                              |    2 +
 fs/nfs/filelayout/filelayout.c            |    2 +
 fs/nfs/filelayout/filelayoutdev.c         |    2 +
 fs/nfs/flexfilelayout/flexfilelayout.c    |    2 +
 fs/nfs/flexfilelayout/flexfilelayoutdev.c |    2 +
 fs/nfs/nfs42xdr.c                         |    2 +
 fs/nfs/nfs4xdr.c                          |    6 +---
 fs/nfsd/nfs4proc.c                        |    2 +
 include/linux/sunrpc/xdr.h                |   44 ++++++++++++++++++++++++++++-
 net/sunrpc/auth_gss/gss_rpc_xdr.c         |    2 +
 net/sunrpc/xdr.c                          |   28 +++---------------
 13 files changed, 59 insertions(+), 39 deletions(-)

diff --git a/fs/nfs/blocklayout/blocklayout.c b/fs/nfs/blocklayout/blocklayout.c
index 08108b6d2fa1..3be6836074ae 100644
--- a/fs/nfs/blocklayout/blocklayout.c
+++ b/fs/nfs/blocklayout/blocklayout.c
@@ -697,7 +697,7 @@ bl_alloc_lseg(struct pnfs_layout_hdr *lo, struct nfs4_layoutget_res *lgr,
 
 	xdr_init_decode_pages(&xdr, &buf,
 			lgr->layoutp->pages, lgr->layoutp->len);
-	xdr_set_scratch_buffer(&xdr, page_address(scratch), PAGE_SIZE);
+	xdr_set_scratch_page(&xdr, scratch);
 
 	status = -EIO;
 	p = xdr_inline_decode(&xdr, 4);
diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
index dec5880ac6de..acb1d22907da 100644
--- a/fs/nfs/blocklayout/dev.c
+++ b/fs/nfs/blocklayout/dev.c
@@ -510,7 +510,7 @@ bl_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 		goto out;
 
 	xdr_init_decode_pages(&xdr, &buf, pdev->pages, pdev->pglen);
-	xdr_set_scratch_buffer(&xdr, page_address(scratch), PAGE_SIZE);
+	xdr_set_scratch_page(&xdr, scratch);
 
 	p = xdr_inline_decode(&xdr, sizeof(__be32));
 	if (!p)
diff --git a/fs/nfs/dir.c b/fs/nfs/dir.c
index 4e011adaf967..8a24fe20dccf 100644
--- a/fs/nfs/dir.c
+++ b/fs/nfs/dir.c
@@ -576,7 +576,7 @@ int nfs_readdir_page_filler(nfs_readdir_descriptor_t *desc, struct nfs_entry *en
 		goto out_nopages;
 
 	xdr_init_decode_pages(&stream, &buf, xdr_pages, buflen);
-	xdr_set_scratch_buffer(&stream, page_address(scratch), PAGE_SIZE);
+	xdr_set_scratch_page(&stream, scratch);
 
 	do {
 		if (entry->label)
diff --git a/fs/nfs/filelayout/filelayout.c b/fs/nfs/filelayout/filelayout.c
index 7f5aa0403e16..d158a500c25c 100644
--- a/fs/nfs/filelayout/filelayout.c
+++ b/fs/nfs/filelayout/filelayout.c
@@ -666,7 +666,7 @@ filelayout_decode_layout(struct pnfs_layout_hdr *flo,
 		return -ENOMEM;
 
 	xdr_init_decode_pages(&stream, &buf, lgr->layoutp->pages, lgr->layoutp->len);
-	xdr_set_scratch_buffer(&stream, page_address(scratch), PAGE_SIZE);
+	xdr_set_scratch_page(&stream, scratch);
 
 	/* 20 = ufl_util (4), first_stripe_index (4), pattern_offset (8),
 	 * num_fh (4) */
diff --git a/fs/nfs/filelayout/filelayoutdev.c b/fs/nfs/filelayout/filelayoutdev.c
index d913e818858f..86c3f7e69ec4 100644
--- a/fs/nfs/filelayout/filelayoutdev.c
+++ b/fs/nfs/filelayout/filelayoutdev.c
@@ -82,7 +82,7 @@ nfs4_fl_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 		goto out_err;
 
 	xdr_init_decode_pages(&stream, &buf, pdev->pages, pdev->pglen);
-	xdr_set_scratch_buffer(&stream, page_address(scratch), PAGE_SIZE);
+	xdr_set_scratch_page(&stream, scratch);
 
 	/* Get the stripe count (number of stripe index) */
 	p = xdr_inline_decode(&stream, 4);
diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index a163533446fa..d7010686d39a 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -378,7 +378,7 @@ ff_layout_alloc_lseg(struct pnfs_layout_hdr *lh,
 
 	xdr_init_decode_pages(&stream, &buf, lgr->layoutp->pages,
 			      lgr->layoutp->len);
-	xdr_set_scratch_buffer(&stream, page_address(scratch), PAGE_SIZE);
+	xdr_set_scratch_page(&stream, scratch);
 
 	/* stripe unit and mirror_array_cnt */
 	rc = -EIO;
diff --git a/fs/nfs/flexfilelayout/flexfilelayoutdev.c b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
index 3eda40a320a5..c9b61b818ec1 100644
--- a/fs/nfs/flexfilelayout/flexfilelayoutdev.c
+++ b/fs/nfs/flexfilelayout/flexfilelayoutdev.c
@@ -69,7 +69,7 @@ nfs4_ff_alloc_deviceid_node(struct nfs_server *server, struct pnfs_device *pdev,
 	INIT_LIST_HEAD(&dsaddrs);
 
 	xdr_init_decode_pages(&stream, &buf, pdev->pages, pdev->pglen);
-	xdr_set_scratch_buffer(&stream, page_address(scratch), PAGE_SIZE);
+	xdr_set_scratch_page(&stream, scratch);
 
 	/* multipath count */
 	p = xdr_inline_decode(&stream, 4);
diff --git a/fs/nfs/nfs42xdr.c b/fs/nfs/nfs42xdr.c
index 6e060a88f98c..cb5d4da2308f 100644
--- a/fs/nfs/nfs42xdr.c
+++ b/fs/nfs/nfs42xdr.c
@@ -1540,7 +1540,7 @@ static int nfs4_xdr_dec_listxattrs(struct rpc_rqst *rqstp,
 	struct compound_hdr hdr;
 	int status;
 
-	xdr_set_scratch_buffer(xdr, page_address(res->scratch), PAGE_SIZE);
+	xdr_set_scratch_page(xdr, res->scratch);
 
 	status = decode_compound_hdr(xdr, &hdr);
 	if (status)
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index c6dbfcae7517..2eabe5add344 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -6403,10 +6403,8 @@ nfs4_xdr_dec_getacl(struct rpc_rqst *rqstp, struct xdr_stream *xdr,
 	struct compound_hdr hdr;
 	int status;
 
-	if (res->acl_scratch != NULL) {
-		void *p = page_address(res->acl_scratch);
-		xdr_set_scratch_buffer(xdr, p, PAGE_SIZE);
-	}
+	if (res->acl_scratch != NULL)
+		xdr_set_scratch_page(xdr, res->acl_scratch);
 	status = decode_compound_hdr(xdr, &hdr);
 	if (status)
 		goto out;
diff --git a/fs/nfsd/nfs4proc.c b/fs/nfsd/nfs4proc.c
index e83b21778816..20772f6b0b2d 100644
--- a/fs/nfsd/nfs4proc.c
+++ b/fs/nfsd/nfs4proc.c
@@ -2276,7 +2276,7 @@ static void svcxdr_init_encode(struct svc_rqst *rqstp,
 	xdr->end = head->iov_base + PAGE_SIZE - rqstp->rq_auth_slack;
 	/* Tail and page_len should be zero at this point: */
 	buf->len = buf->head[0].iov_len;
-	xdr->scratch.iov_len = 0;
+	xdr_reset_scratch_buffer(xdr);
 	xdr->page_ptr = buf->pages - 1;
 	buf->buflen = PAGE_SIZE * (1 + rqstp->rq_page_end - buf->pages)
 		- rqstp->rq_auth_slack;
diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index ec2a22ccdc2a..2729d2d6efce 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -248,7 +248,6 @@ extern void xdr_init_decode(struct xdr_stream *xdr, struct xdr_buf *buf,
 			    __be32 *p, struct rpc_rqst *rqst);
 extern void xdr_init_decode_pages(struct xdr_stream *xdr, struct xdr_buf *buf,
 		struct page **pages, unsigned int len);
-extern void xdr_set_scratch_buffer(struct xdr_stream *xdr, void *buf, size_t buflen);
 extern __be32 *xdr_inline_decode(struct xdr_stream *xdr, size_t nbytes);
 extern unsigned int xdr_read_pages(struct xdr_stream *xdr, unsigned int len);
 extern void xdr_enter_page(struct xdr_stream *xdr, unsigned int len);
@@ -256,6 +255,49 @@ extern int xdr_process_buf(struct xdr_buf *buf, unsigned int offset, unsigned in
 extern uint64_t xdr_align_data(struct xdr_stream *, uint64_t, uint32_t);
 extern uint64_t xdr_expand_hole(struct xdr_stream *, uint64_t, uint64_t);
 
+/**
+ * xdr_set_scratch_buffer - Attach a scratch buffer for decoding data.
+ * @xdr: pointer to xdr_stream struct
+ * @buf: pointer to an empty buffer
+ * @buflen: size of 'buf'
+ *
+ * The scratch buffer is used when decoding from an array of pages.
+ * If an xdr_inline_decode() call spans across page boundaries, then
+ * we copy the data into the scratch buffer in order to allow linear
+ * access.
+ */
+static inline void
+xdr_set_scratch_buffer(struct xdr_stream *xdr, void *buf, size_t buflen)
+{
+	xdr->scratch.iov_base = buf;
+	xdr->scratch.iov_len = buflen;
+}
+
+/**
+ * xdr_set_scratch_page - Attach a scratch buffer for decoding data
+ * @xdr: pointer to xdr_stream struct
+ * @page: an anonymous page
+ *
+ * See xdr_set_scratch_buffer().
+ */
+static inline void
+xdr_set_scratch_page(struct xdr_stream *xdr, struct page *page)
+{
+	xdr_set_scratch_buffer(xdr, page_address(page), PAGE_SIZE);
+}
+
+/**
+ * xdr_reset_scratch_buffer - Clear scratch buffer information
+ * @xdr: pointer to xdr_stream struct
+ *
+ * See xdr_set_scratch_buffer().
+ */
+static inline void
+xdr_reset_scratch_buffer(struct xdr_stream *xdr)
+{
+	xdr_set_scratch_buffer(xdr, NULL, 0);
+}
+
 /**
  * xdr_stream_remaining - Return the number of bytes remaining in the stream
  * @xdr: pointer to struct xdr_stream
diff --git a/net/sunrpc/auth_gss/gss_rpc_xdr.c b/net/sunrpc/auth_gss/gss_rpc_xdr.c
index 2ff7b7083eba..c636c648849b 100644
--- a/net/sunrpc/auth_gss/gss_rpc_xdr.c
+++ b/net/sunrpc/auth_gss/gss_rpc_xdr.c
@@ -789,7 +789,7 @@ int gssx_dec_accept_sec_context(struct rpc_rqst *rqstp,
 	scratch = alloc_page(GFP_KERNEL);
 	if (!scratch)
 		return -ENOMEM;
-	xdr_set_scratch_buffer(xdr, page_address(scratch), PAGE_SIZE);
+	xdr_set_scratch_page(xdr, scratch);
 
 	/* res->status */
 	err = gssx_dec_status(xdr, &res->status);
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 28f81769a27c..c607744b3ea8 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -669,7 +669,7 @@ void xdr_init_encode(struct xdr_stream *xdr, struct xdr_buf *buf, __be32 *p,
 	struct kvec *iov = buf->head;
 	int scratch_len = buf->buflen - buf->page_len - buf->tail[0].iov_len;
 
-	xdr_set_scratch_buffer(xdr, NULL, 0);
+	xdr_reset_scratch_buffer(xdr);
 	BUG_ON(scratch_len < 0);
 	xdr->buf = buf;
 	xdr->iov = iov;
@@ -713,7 +713,7 @@ inline void xdr_commit_encode(struct xdr_stream *xdr)
 	page = page_address(*xdr->page_ptr);
 	memcpy(xdr->scratch.iov_base, page, shift);
 	memmove(page, page + shift, (void *)xdr->p - page);
-	xdr->scratch.iov_len = 0;
+	xdr_reset_scratch_buffer(xdr);
 }
 EXPORT_SYMBOL_GPL(xdr_commit_encode);
 
@@ -743,8 +743,7 @@ static __be32 *xdr_get_next_encode_buffer(struct xdr_stream *xdr,
 	 * the "scratch" iov to track any temporarily unused fragment of
 	 * space at the end of the previous buffer:
 	 */
-	xdr->scratch.iov_base = xdr->p;
-	xdr->scratch.iov_len = frag1bytes;
+	xdr_set_scratch_buffer(xdr, xdr->p, frag1bytes);
 	p = page_address(*xdr->page_ptr);
 	/*
 	 * Note this is where the next encode will start after we've
@@ -1052,8 +1051,7 @@ void xdr_init_decode(struct xdr_stream *xdr, struct xdr_buf *buf, __be32 *p,
 		     struct rpc_rqst *rqst)
 {
 	xdr->buf = buf;
-	xdr->scratch.iov_base = NULL;
-	xdr->scratch.iov_len = 0;
+	xdr_reset_scratch_buffer(xdr);
 	xdr->nwords = XDR_QUADLEN(buf->len);
 	if (buf->head[0].iov_len != 0)
 		xdr_set_iov(xdr, buf->head, buf->len);
@@ -1101,24 +1099,6 @@ static __be32 * __xdr_inline_decode(struct xdr_stream *xdr, size_t nbytes)
 	return p;
 }
 
-/**
- * xdr_set_scratch_buffer - Attach a scratch buffer for decoding data.
- * @xdr: pointer to xdr_stream struct
- * @buf: pointer to an empty buffer
- * @buflen: size of 'buf'
- *
- * The scratch buffer is used when decoding from an array of pages.
- * If an xdr_inline_decode() call spans across page boundaries, then
- * we copy the data into the scratch buffer in order to allow linear
- * access.
- */
-void xdr_set_scratch_buffer(struct xdr_stream *xdr, void *buf, size_t buflen)
-{
-	xdr->scratch.iov_base = buf;
-	xdr->scratch.iov_len = buflen;
-}
-EXPORT_SYMBOL_GPL(xdr_set_scratch_buffer);
-
 static __be32 *xdr_copy_to_scratch(struct xdr_stream *xdr, size_t nbytes)
 {
 	__be32 *p;


