Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83D5514CDFF
	for <lists+linux-nfs@lfdr.de>; Wed, 29 Jan 2020 17:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgA2QKO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 Jan 2020 11:10:14 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:38787 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726564AbgA2QKN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 29 Jan 2020 11:10:13 -0500
Received: by mail-yw1-f66.google.com with SMTP id 10so74850ywv.5
        for <linux-nfs@vger.kernel.org>; Wed, 29 Jan 2020 08:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=IBeAT3MNso6QQ1ymMCvS4pnVjcGugaVKGx5OtZXOog0=;
        b=SGr2tpLB1R3O5qvIOvqtEoGdX6Pas7HNnX1Vt4XfsvfXapbvQa0A5qkAQ3RYtejQ9/
         6Lp8Aypz6vjlUCSEW30WQIn2ZtKWZQ5JnYDrF7QgyW3ebRk4t0svxTkj65JRNiRa1T4+
         /hxsvE9qnqpInPNzkVzNc74E0G4tuoaF/ZmBu3RTrmpy9aLZtrPcgnhoWRbHOZFwtqD8
         Ld1qosocTDa3sUadjapiWZZsPz07usZm/T5hrwvT9nvVhSQJR43Kg0qOPtLJ3HCj5U4u
         QrAzjLJL4X5bHSghod7r6LcdXeERttO78+BfQQBk4qrAIS3qhTNjdFuVV7ewpXUA7sPD
         PG1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=IBeAT3MNso6QQ1ymMCvS4pnVjcGugaVKGx5OtZXOog0=;
        b=NE38zFWpCdietkl80Y4P/HwzEAnHi0lkZJY6lsuAjqd6lCeOjljBhMC2q15cAuHL76
         xmoIkgEMF0LxUw0kbe+RyoP96BPnzi8Bb60xL30StKg4PDpktrS878QnBMgGACi1/h7s
         TGsm1uR6lx4KPSCT+y7sRmRYeSqyF+te9VT8YIsFBDnLFLs99jVfy1QDje3g1kVZaDI+
         w4EJM/tn5KYdiySBETO+oGV28paMB301vGBB3g6c80aNfaZtvBJZQGAEp43UoR9HvhPc
         yNIVIS0h1cFij/FVq4jNAcXATYImxiK/uMA3ltpKz8zhkOIMSzIKA0OfJ1/grRaVQ+nd
         P/OA==
X-Gm-Message-State: APjAAAUJyIUrnAMT8D1G3U7dgO07lox7DeFH6+vlt8Kw7KiLcu+2fzfG
        I4EZ63MnYZDMiQIQKz/zh1J7W8z/
X-Google-Smtp-Source: APXvYqx9Cpep+bNC+zHbwzBM0daomLY9pMO/x8zx5YV93YOH8YfaiGCrp1QaEwGkqV+np8JxZa3kmw==
X-Received: by 2002:a81:d8d:: with SMTP id 135mr20031943ywn.127.1580314212471;
        Wed, 29 Jan 2020 08:10:12 -0800 (PST)
Received: from bazille.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id d137sm1152575ywd.86.2020.01.29.08.10.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jan 2020 08:10:12 -0800 (PST)
Subject: [PATCH RFC 8/8] SUNRPC: GSS support for automated padding of
 xdr_buf::pages
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 29 Jan 2020 11:10:11 -0500
Message-ID: <20200129161011.3024.26645.stgit@bazille.1015granger.net>
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

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_krb5_crypto.c |   13 ++++----
 net/sunrpc/auth_gss/gss_krb5_wrap.c   |   11 ++++---
 net/sunrpc/auth_gss/svcauth_gss.c     |   51 +++++++++++++++++++--------------
 net/sunrpc/xdr.c                      |    3 ++
 4 files changed, 45 insertions(+), 33 deletions(-)

diff --git a/net/sunrpc/auth_gss/gss_krb5_crypto.c b/net/sunrpc/auth_gss/gss_krb5_crypto.c
index 6f2d30d7b766..eb5a43b61b42 100644
--- a/net/sunrpc/auth_gss/gss_krb5_crypto.c
+++ b/net/sunrpc/auth_gss/gss_krb5_crypto.c
@@ -412,8 +412,9 @@
 	err = crypto_ahash_init(req);
 	if (err)
 		goto out;
-	err = xdr_process_buf(body, body_offset, body->len - body_offset,
-			      checksummer, req);
+	err = xdr_process_buf(body, body_offset,
+			      xdr_buf_msglen(body) - body_offset, checksummer,
+			      req);
 	if (err)
 		goto out;
 	if (header != NULL) {
@@ -682,12 +683,10 @@ struct decryptor_desc {
 	SYNC_SKCIPHER_REQUEST_ON_STACK(req, cipher);
 	u8 *data;
 	struct page **save_pages;
-	u32 len = buf->len - offset;
+	u32 len = xdr_buf_msglen(buf) - offset;
 
-	if (len > GSS_KRB5_MAX_BLOCKSIZE * 2) {
-		WARN_ON(0);
+	if (len > GSS_KRB5_MAX_BLOCKSIZE * 2)
 		return -ENOMEM;
-	}
 	data = kmalloc(GSS_KRB5_MAX_BLOCKSIZE * 2, GFP_NOFS);
 	if (!data)
 		return -ENOMEM;
@@ -800,7 +799,7 @@ struct decryptor_desc {
 	if (err)
 		return GSS_S_FAILURE;
 
-	nbytes = buf->len - offset - GSS_KRB5_TOK_HDR_LEN;
+	nbytes = xdr_buf_msglen(buf) - offset - GSS_KRB5_TOK_HDR_LEN;
 	nblocks = (nbytes + blocksize - 1) / blocksize;
 	cbcbytes = 0;
 	if (nblocks > 2)
diff --git a/net/sunrpc/auth_gss/gss_krb5_wrap.c b/net/sunrpc/auth_gss/gss_krb5_wrap.c
index 14a0aff0cd84..8d71d561f430 100644
--- a/net/sunrpc/auth_gss/gss_krb5_wrap.c
+++ b/net/sunrpc/auth_gss/gss_krb5_wrap.c
@@ -405,12 +405,13 @@ static void rotate_buf_a_little(struct xdr_buf *buf, unsigned int shift)
 	BUG_ON(shift > LOCAL_BUF_LEN);
 
 	read_bytes_from_xdr_buf(buf, 0, head, shift);
-	for (i = 0; i + shift < buf->len; i += LOCAL_BUF_LEN) {
-		this_len = min(LOCAL_BUF_LEN, buf->len - (i + shift));
+	for (i = 0; i + shift < xdr_buf_msglen(buf); i += LOCAL_BUF_LEN) {
+		this_len = min_t(unsigned int, LOCAL_BUF_LEN,
+				 xdr_buf_msglen(buf) - (i + shift));
 		read_bytes_from_xdr_buf(buf, i+shift, tmp, this_len);
 		write_bytes_to_xdr_buf(buf, i, tmp, this_len);
 	}
-	write_bytes_to_xdr_buf(buf, buf->len - shift, head, shift);
+	write_bytes_to_xdr_buf(buf, xdr_buf_msglen(buf) - shift, head, shift);
 }
 
 static void _rotate_left(struct xdr_buf *buf, unsigned int shift)
@@ -418,7 +419,7 @@ static void _rotate_left(struct xdr_buf *buf, unsigned int shift)
 	int shifted = 0;
 	int this_shift;
 
-	shift %= buf->len;
+	shift %= xdr_buf_msglen(buf);
 	while (shifted < shift) {
 		this_shift = min(shift - shifted, LOCAL_BUF_LEN);
 		rotate_buf_a_little(buf, this_shift);
@@ -430,7 +431,7 @@ static void rotate_left(u32 base, struct xdr_buf *buf, unsigned int shift)
 {
 	struct xdr_buf subbuf;
 
-	xdr_buf_subsegment(buf, &subbuf, base, buf->len - base);
+	xdr_buf_subsegment(buf, &subbuf, base, xdr_buf_msglen(buf) - base);
 	_rotate_left(&subbuf, shift);
 }
 
diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index c62d1f10978b..893b9114cb8a 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -907,12 +907,6 @@ u32 svcauth_gss_flavor(struct auth_domain *dom)
 	return stat;
 }
 
-static inline int
-total_buf_len(struct xdr_buf *buf)
-{
-	return buf->head[0].iov_len + buf->page_len + buf->tail[0].iov_len;
-}
-
 static void
 fix_priv_head(struct xdr_buf *buf, int pad)
 {
@@ -941,7 +935,7 @@ u32 svcauth_gss_flavor(struct auth_domain *dom)
 	/* buf->len is the number of bytes from the original start of the
 	 * request to the end, where head[0].iov_len is just the bytes
 	 * not yet read from the head, so these two values are different: */
-	remaining_len = total_buf_len(buf);
+	remaining_len = xdr_buf_msglen(buf);
 	if (priv_len > remaining_len)
 		return -EINVAL;
 	pad = remaining_len - priv_len;
@@ -961,7 +955,7 @@ u32 svcauth_gss_flavor(struct auth_domain *dom)
 	/* XXX: This is very inefficient.  It would be better to either do
 	 * this while we encrypt, or maybe in the receive code, if we can peak
 	 * ahead and work out the service and mechanism there. */
-	offset = buf->head[0].iov_len % 4;
+	offset = buf->head[0].iov_len & 3;
 	if (offset) {
 		buf->buflen = RPCSVC_MAXPAYLOAD;
 		xdr_shift_buf(buf, offset);
@@ -1671,12 +1665,30 @@ static void destroy_use_gss_proxy_proc_entry(struct net *net) {}
 	int integ_offset, integ_len;
 	int stat = -EINVAL;
 
+	/* Fill in pad bytes for xdr_buf::pages: */
+	if (resbuf->page_pad) {
+		if (resbuf->tail[0].iov_base != NULL) {
+			memmove((u8 *)resbuf->tail[0].iov_base + sizeof(__be32),
+				resbuf->tail[0].iov_base,
+				resbuf->tail[0].iov_len);
+		} else {
+			resbuf->tail[0].iov_base =
+					(u8 *)resbuf->head[0].iov_base +
+					resbuf->head[0].iov_len;
+			resbuf->tail[0].iov_len = 0;
+		}
+		memset(resbuf->tail[0].iov_base, 0, sizeof(__be32));
+		resbuf->tail[0].iov_base = (u8 *)resbuf->tail[0].iov_base +
+					   (4 - resbuf->page_pad);
+		resbuf->tail[0].iov_len += resbuf->page_pad;
+		resbuf->page_pad = 0;
+	}
+
 	p = svcauth_gss_prepare_to_wrap(resbuf, gsd);
 	if (p == NULL)
 		goto out;
 	integ_offset = (u8 *)(p + 1) - (u8 *)resbuf->head[0].iov_base;
-	integ_len = resbuf->len - integ_offset;
-	BUG_ON(integ_len % 4);
+	integ_len = xdr_buf_msglen(resbuf) - integ_offset;
 	*p++ = htonl(integ_len);
 	*p++ = htonl(gc->gc_seq);
 	if (xdr_buf_subsegment(resbuf, &integ_buf, integ_offset, integ_len)) {
@@ -1716,7 +1728,6 @@ static void destroy_use_gss_proxy_proc_entry(struct net *net) {}
 	struct page **inpages = NULL;
 	__be32 *p, *len;
 	int offset;
-	int pad;
 
 	p = svcauth_gss_prepare_to_wrap(resbuf, gsd);
 	if (p == NULL)
@@ -1735,7 +1746,7 @@ static void destroy_use_gss_proxy_proc_entry(struct net *net) {}
 	 * there is RPC_MAX_AUTH_SIZE slack space available in
 	 * both the head and tail.
 	 */
-	if (resbuf->tail[0].iov_base) {
+	if (resbuf->tail[0].iov_base != NULL) {
 		BUG_ON(resbuf->tail[0].iov_base >= resbuf->head[0].iov_base
 							+ PAGE_SIZE);
 		BUG_ON(resbuf->tail[0].iov_base < resbuf->head[0].iov_base);
@@ -1746,6 +1757,7 @@ static void destroy_use_gss_proxy_proc_entry(struct net *net) {}
 			resbuf->tail[0].iov_base,
 			resbuf->tail[0].iov_len);
 		resbuf->tail[0].iov_base += RPC_MAX_AUTH_SIZE;
+		/* XXX: insert padding for resbuf->pages */
 	}
 	/*
 	 * If there is no current tail data, make sure there is
@@ -1754,21 +1766,18 @@ static void destroy_use_gss_proxy_proc_entry(struct net *net) {}
 	 * is RPC_MAX_AUTH_SIZE slack space available in both the
 	 * head and tail.
 	 */
-	if (resbuf->tail[0].iov_base == NULL) {
+	else {
 		if (resbuf->head[0].iov_len + 2*RPC_MAX_AUTH_SIZE > PAGE_SIZE)
 			return -ENOMEM;
 		resbuf->tail[0].iov_base = resbuf->head[0].iov_base
 			+ resbuf->head[0].iov_len + RPC_MAX_AUTH_SIZE;
-		resbuf->tail[0].iov_len = 0;
+		memset(resbuf->tail[0].iov_base, 0, sizeof(__be32));
+		resbuf->tail[0].iov_len = resbuf->page_pad;
+		resbuf->page_pad = 0;
 	}
 	if (gss_wrap(gsd->rsci->mechctx, offset, resbuf, inpages))
 		return -ENOMEM;
-	*len = htonl(resbuf->len - offset);
-	pad = 3 - ((resbuf->len - offset - 1)&3);
-	p = (__be32 *)(resbuf->tail[0].iov_base + resbuf->tail[0].iov_len);
-	memset(p, 0, pad);
-	resbuf->tail[0].iov_len += pad;
-	resbuf->len += pad;
+	*len = cpu_to_be32(xdr_buf_msglen(resbuf) - offset);
 	return 0;
 }
 
@@ -1789,7 +1798,7 @@ static void destroy_use_gss_proxy_proc_entry(struct net *net) {}
 	/* normally not set till svc_send, but we need it here: */
 	/* XXX: what for?  Do we mess it up the moment we call svc_putu32
 	 * or whatever? */
-	resbuf->len = total_buf_len(resbuf);
+	resbuf->len = xdr_buf_msglen(resbuf);
 	switch (gc->gc_svc) {
 	case RPC_GSS_SVC_NONE:
 		break;
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index d2dadb200024..798ebb406058 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -1132,6 +1132,9 @@ void xdr_enter_page(struct xdr_stream *xdr, unsigned int len)
 		base -= buf->page_len;
 		subbuf->page_len = 0;
 	}
+	/* XXX: Still need to deal with case where buf->page_pad is non-zero */
+	WARN_ON(buf->page_pad);
+	subbuf->page_pad = 0;
 
 	if (base < buf->tail[0].iov_len) {
 		subbuf->tail[0].iov_base = buf->tail[0].iov_base + base;

