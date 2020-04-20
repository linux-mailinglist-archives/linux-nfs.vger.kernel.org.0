Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBF41AFFC4
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Apr 2020 04:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgDTCRy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Apr 2020 22:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725865AbgDTCRy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Apr 2020 22:17:54 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B156C061A0C
        for <linux-nfs@vger.kernel.org>; Sun, 19 Apr 2020 19:17:54 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id 71so7278590qtc.12
        for <linux-nfs@vger.kernel.org>; Sun, 19 Apr 2020 19:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=b7tlG07clEFF9STPa5hXgvlTXsY3s7JQl7d81ZwxX2k=;
        b=ocRORBqLlio32Rt9/7IyNHkh5OoKDKQFlsugDb5r1mAHLiYMWwHhtoeDWEV7wr2s5a
         24mbO6W1Z6dpVcL9QSkOg2jfyxpD8l4gy5mlOf28JB0Z+tH2ThFvoIxjd1kcBE3SdQU+
         E8Gat1ggC27GHhEHMxtHc2yqlKIzApaKD1fJlAiCcXYiL29R3hWZueLYk1et4N+9cfBk
         eMtGJrAe07oqTfudUco3jJ2yANKBARiOiD7jZvltBsroJHambZO8WqXPbeUC1qU7/kv2
         njpaolaASxCDTdoTLGi41+tyOUALOAUDAEhJhzBZaEG8u9q1IE61MBrblkHyls7YiI8G
         pkcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=b7tlG07clEFF9STPa5hXgvlTXsY3s7JQl7d81ZwxX2k=;
        b=h0WDEFdoTrMGrmc8eMzNSnMU4zPgad/C7VCnbMnkZPFnFu6KqNmHyUaKvgWNAdyKNk
         CDGt46nFTZ78oilvFr9Qmjb86ekF/VPohRESBhoa+h0xiq1IvOySB1hJiO8XtPnvoofp
         t80DF8M8TOkC36OR2cu4bywWbJHKQam5gNndV3KblXX20e5moZAw8u2hKocdwfEuSfh5
         ADqTOzPWgCTSHvxPvjZdEGc4guvLdU5LmjvEUweTzWIV0CT5Gln8PCB3r4qvsyrFJ/iQ
         G3jCB5b7ju1cG06RIxPcxoJTXjxg76z0eau3d/KcccflahLeqrg1L1bjdPqSbADBgpcj
         Jt0w==
X-Gm-Message-State: AGi0Puabq5znC5NdKvp8HLC8wEYDuY78YSpXOI9u2/23yYMii/SsML5L
        pfDCDEz98DD42SY3MMiqWZpOonuj
X-Google-Smtp-Source: APiQypKcVKdYVkv0jer1S1BN75j/0FZtXis0PCngiyIVFaQqC7hVJIAnsU5kg/XSk6gRpq8pDZvNzg==
X-Received: by 2002:ac8:39a2:: with SMTP id v31mr13691700qte.373.1587349073405;
        Sun, 19 Apr 2020 19:17:53 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id f127sm21561172qkd.74.2020.04.19.19.17.52
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Apr 2020 19:17:53 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 03K2Hp1G017007
        for <linux-nfs@vger.kernel.org>; Mon, 20 Apr 2020 02:17:51 GMT
Subject: [PATCH v1 3/3] SUNRPC: Revert 241b1f419f0e ("SUNRPC: Remove
 xdr_buf_trim()")
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Sun, 19 Apr 2020 22:17:51 -0400
Message-ID: <20200420021751.3416.68050.stgit@klimt.1015granger.net>
In-Reply-To: <20200420000639.3416.43270.stgit@klimt.1015granger.net>
References: <20200420000639.3416.43270.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-8-g198f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I've noticed that when krb5i or krb5p security is in use,
retransmitted requests are missing the server's duplicate reply
cache. The computed checksum on the retransmitted request does not
match the cached checksum, resulting in the server performing the
retransmitted request again instead of returning the cached reply.

The assumptions made when removing xdr_buf_trim() were not correct.
In the send paths, the upper layer has already set the segment
lengths correctly, and shorting the buffer's content is simply a
matter of reducing buf->len.

xdr_buf_trim() is the right answer in the receive/unwrap path on
both the client and the server. The buffer segment lengths have to
be shortened one-by-one.

On the server side in particular, head.iov_len needs to be updated
correctly to enable nfsd_cache_csum() to work correctly. The simple
buf->len computation doesn't do that, and that results in
checksumming stale data in the buffer.

The problem isn't noticed until there's significant instability of
the RPC transport. At that point, the reliability of retransmit
detection on the server becomes crucial.

Fixes: 241b1f419f0e ("SUNRPC: Remove xdr_buf_trim()")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/xdr.h          |    1 +
 net/sunrpc/auth_gss/gss_krb5_wrap.c |    7 +++---
 net/sunrpc/auth_gss/svcauth_gss.c   |    2 +-
 net/sunrpc/xdr.c                    |   41 +++++++++++++++++++++++++++++++++++
 4 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index 01bb41908c93..22c207b2425f 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -184,6 +184,7 @@ xdr_adjust_iovec(struct kvec *iov, __be32 *p)
 extern void xdr_shift_buf(struct xdr_buf *, size_t);
 extern void xdr_buf_from_iov(struct kvec *, struct xdr_buf *);
 extern int xdr_buf_subsegment(struct xdr_buf *, struct xdr_buf *, unsigned int, unsigned int);
+extern void xdr_buf_trim(struct xdr_buf *, unsigned int);
 extern int read_bytes_from_xdr_buf(struct xdr_buf *, unsigned int, void *, unsigned int);
 extern int write_bytes_to_xdr_buf(struct xdr_buf *, unsigned int, void *, unsigned int);
 
diff --git a/net/sunrpc/auth_gss/gss_krb5_wrap.c b/net/sunrpc/auth_gss/gss_krb5_wrap.c
index 4905652e7567..cf0fd170ac18 100644
--- a/net/sunrpc/auth_gss/gss_krb5_wrap.c
+++ b/net/sunrpc/auth_gss/gss_krb5_wrap.c
@@ -580,15 +580,14 @@ gss_unwrap_kerberos_v2(struct krb5_ctx *kctx, int offset, int len,
 	 */
 	movelen = min_t(unsigned int, buf->head[0].iov_len, len);
 	movelen -= offset + GSS_KRB5_TOK_HDR_LEN + headskip;
-	if (offset + GSS_KRB5_TOK_HDR_LEN + headskip + movelen >
-	    buf->head[0].iov_len)
-		return GSS_S_FAILURE;
+	BUG_ON(offset + GSS_KRB5_TOK_HDR_LEN + headskip + movelen >
+							buf->head[0].iov_len);
 	memmove(ptr, ptr + GSS_KRB5_TOK_HDR_LEN + headskip, movelen);
 	buf->head[0].iov_len -= GSS_KRB5_TOK_HDR_LEN + headskip;
 	buf->len = len - GSS_KRB5_TOK_HDR_LEN + headskip;
 
 	/* Trim off the trailing "extra count" and checksum blob */
-	buf->len -= ec + GSS_KRB5_TOK_HDR_LEN + tailskip;
+	xdr_buf_trim(buf, ec + GSS_KRB5_TOK_HDR_LEN + tailskip);
 
 	*align = XDR_QUADLEN(GSS_KRB5_TOK_HDR_LEN + headskip);
 	*slack = *align + XDR_QUADLEN(ec + GSS_KRB5_TOK_HDR_LEN + tailskip);
diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index d0a2f084e5a4..50d93c49ef1a 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -906,7 +906,7 @@ unwrap_integ_data(struct svc_rqst *rqstp, struct xdr_buf *buf, u32 seq, struct g
 	if (svc_getnl(&buf->head[0]) != seq)
 		goto out;
 	/* trim off the mic and padding at the end before returning */
-	buf->len -= 4 + round_up_to_quad(mic.len);
+	xdr_buf_trim(buf, round_up_to_quad(mic.len) + 4);
 	stat = 0;
 out:
 	kfree(mic.data);
diff --git a/net/sunrpc/xdr.c b/net/sunrpc/xdr.c
index 15b58c5144f9..6f7d82fb1eb0 100644
--- a/net/sunrpc/xdr.c
+++ b/net/sunrpc/xdr.c
@@ -1150,6 +1150,47 @@ xdr_buf_subsegment(struct xdr_buf *buf, struct xdr_buf *subbuf,
 }
 EXPORT_SYMBOL_GPL(xdr_buf_subsegment);
 
+/**
+ * xdr_buf_trim - lop at most "len" bytes off the end of "buf"
+ * @buf: buf to be trimmed
+ * @len: number of bytes to reduce "buf" by
+ *
+ * Trim an xdr_buf by the given number of bytes by fixing up the lengths. Note
+ * that it's possible that we'll trim less than that amount if the xdr_buf is
+ * too small, or if (for instance) it's all in the head and the parser has
+ * already read too far into it.
+ */
+void xdr_buf_trim(struct xdr_buf *buf, unsigned int len)
+{
+	size_t cur;
+	unsigned int trim = len;
+
+	if (buf->tail[0].iov_len) {
+		cur = min_t(size_t, buf->tail[0].iov_len, trim);
+		buf->tail[0].iov_len -= cur;
+		trim -= cur;
+		if (!trim)
+			goto fix_len;
+	}
+
+	if (buf->page_len) {
+		cur = min_t(unsigned int, buf->page_len, trim);
+		buf->page_len -= cur;
+		trim -= cur;
+		if (!trim)
+			goto fix_len;
+	}
+
+	if (buf->head[0].iov_len) {
+		cur = min_t(size_t, buf->head[0].iov_len, trim);
+		buf->head[0].iov_len -= cur;
+		trim -= cur;
+	}
+fix_len:
+	buf->len -= (len - trim);
+}
+EXPORT_SYMBOL_GPL(xdr_buf_trim);
+
 static void __read_bytes_from_xdr_buf(struct xdr_buf *subbuf, void *obj, unsigned int len)
 {
 	unsigned int this_len;

