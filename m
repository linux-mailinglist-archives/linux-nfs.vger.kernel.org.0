Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E6DB1AFFC2
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Apr 2020 04:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgDTCRo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Apr 2020 22:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725865AbgDTCRo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Apr 2020 22:17:44 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECAAEC061A0C
        for <linux-nfs@vger.kernel.org>; Sun, 19 Apr 2020 19:17:43 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id o19so9098514qkk.5
        for <linux-nfs@vger.kernel.org>; Sun, 19 Apr 2020 19:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=aTjHGeT6+kE39VQDxB+GTI1hXvZ7PeTlY7MZrHznDn0=;
        b=HpwM9GuZHEvDdyq9kwXxhgiP3U7X6E0/AZfLDbtCEYxpqoKVX3qmGpjmIFAvcR6fVm
         1TfWcAI0BcP1SvrXdVe2kjxrF/RMS09wN5RQpvacyUtAZjQzBUvZ1sEnlmpEtKbsKYSs
         GPtTn76OAyIx+GlwLiT+HydNtULupxFCUhap0aDUlY3boNuSTo2MOxSXwF2kbL4WsCPX
         8NMvVtK0DdWwudf1ePGjIUHnyCeBl2g71NIr5rSjzxJ2zcbenXCPVtKSVlu+NJq/kqxS
         mzYHXz5Pvy7Ra3KUKS90gT6aMw3Qz+wOLKsr2yVu/5JJFspxbUMAAhiOjf0YCRa4Sn+n
         cvqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=aTjHGeT6+kE39VQDxB+GTI1hXvZ7PeTlY7MZrHznDn0=;
        b=F5fM/4I9zLtJ6gcdF02Dz5lr9a5gvIgrB22SNVEBUZWTOKWKrqNtxuZ+gXUrCbLISX
         XXPX92LVkmMf3hAYS2xBvaqiKR2ggAHjKnQKDj5My08PpkA/er1xMS+rAEndkYXefm19
         rbpiszDHBlegrNCUCn7Ur64IuH56cXVLuThwBBtY4ZY8O47EA647o7yp5IUOmWlXqDli
         DjZmAZnxIpxYGt7tEBY6i5PF5gamyoihWEKxI4ph0GCyPdF3LYIYGqoZsiRx3pZ6mAwR
         hPya0gU7YZLtwR/oF5+r5xc/GIPMnSfBOIG0uEfj2GX7hlSTQgkiQ1QXluC2nfvZ+RBR
         t3+Q==
X-Gm-Message-State: AGi0PuZMO2TWza9H6PivZEWIBPiskEZ/+usMyzqxX5Of7eX1yyKeIYww
        P4/moKd9EQ0V+b3spjzjMOraOs/s
X-Google-Smtp-Source: APiQypLvZUKCkVPUJpsbSl1LgaYcwKydt3zF1eW9sXGo9uKK589PefZ1o5etEJDQMOpSOdB9yR+Q2w==
X-Received: by 2002:a37:9d8c:: with SMTP id g134mr14530574qke.307.1587349062805;
        Sun, 19 Apr 2020 19:17:42 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id a3sm22219008qka.61.2020.04.19.19.17.42
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Apr 2020 19:17:42 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 03K2HfVW017001
        for <linux-nfs@vger.kernel.org>; Mon, 20 Apr 2020 02:17:41 GMT
Subject: [PATCH v1 1/3] SUNRPC: Add "@len" parameter to gss_unwrap()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Sun, 19 Apr 2020 22:17:41 -0400
Message-ID: <20200420021741.3416.87760.stgit@klimt.1015granger.net>
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

Refactor: This is a pre-requisite to fixing the client-side ralign
computation in gss_unwrap_resp_priv().

The length value is passed in explicitly rather that as the value
of buf->len. This will subsequently allow gss_unwrap_kerberos_v1()
to compute a slack and align value, instead of computing it in
gss_unwrap_resp_priv().

Fixes: 35e77d21baa0 ("SUNRPC: Add rpc_auth::au_ralign field")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/gss_api.h        |    2 ++
 include/linux/sunrpc/gss_krb5.h       |    6 +++---
 net/sunrpc/auth_gss/auth_gss.c        |    4 ++--
 net/sunrpc/auth_gss/gss_krb5_crypto.c |    8 ++++----
 net/sunrpc/auth_gss/gss_krb5_wrap.c   |   26 +++++++++++++++-----------
 net/sunrpc/auth_gss/gss_mech_switch.c |    3 ++-
 net/sunrpc/auth_gss/svcauth_gss.c     |    8 ++------
 7 files changed, 30 insertions(+), 27 deletions(-)

diff --git a/include/linux/sunrpc/gss_api.h b/include/linux/sunrpc/gss_api.h
index 48c1b1674cbf..e9a79518d652 100644
--- a/include/linux/sunrpc/gss_api.h
+++ b/include/linux/sunrpc/gss_api.h
@@ -66,6 +66,7 @@ u32 gss_wrap(
 u32 gss_unwrap(
 		struct gss_ctx		*ctx_id,
 		int			offset,
+		int			len,
 		struct xdr_buf		*inbuf);
 u32 gss_delete_sec_context(
 		struct gss_ctx		**ctx_id);
@@ -126,6 +127,7 @@ struct gss_api_ops {
 	u32 (*gss_unwrap)(
 			struct gss_ctx		*ctx_id,
 			int			offset,
+			int			len,
 			struct xdr_buf		*buf);
 	void (*gss_delete_sec_context)(
 			void			*internal_ctx_id);
diff --git a/include/linux/sunrpc/gss_krb5.h b/include/linux/sunrpc/gss_krb5.h
index c1d77dd8ed41..e8f8ffe7448b 100644
--- a/include/linux/sunrpc/gss_krb5.h
+++ b/include/linux/sunrpc/gss_krb5.h
@@ -83,7 +83,7 @@ struct gss_krb5_enctype {
 	u32 (*encrypt_v2) (struct krb5_ctx *kctx, u32 offset,
 			   struct xdr_buf *buf,
 			   struct page **pages); /* v2 encryption function */
-	u32 (*decrypt_v2) (struct krb5_ctx *kctx, u32 offset,
+	u32 (*decrypt_v2) (struct krb5_ctx *kctx, u32 offset, u32 len,
 			   struct xdr_buf *buf, u32 *headskip,
 			   u32 *tailskip);	/* v2 decryption function */
 };
@@ -255,7 +255,7 @@ gss_wrap_kerberos(struct gss_ctx *ctx_id, int offset,
 		struct xdr_buf *outbuf, struct page **pages);
 
 u32
-gss_unwrap_kerberos(struct gss_ctx *ctx_id, int offset,
+gss_unwrap_kerberos(struct gss_ctx *ctx_id, int offset, int len,
 		struct xdr_buf *buf);
 
 
@@ -312,7 +312,7 @@ gss_krb5_aes_encrypt(struct krb5_ctx *kctx, u32 offset,
 		     struct page **pages);
 
 u32
-gss_krb5_aes_decrypt(struct krb5_ctx *kctx, u32 offset,
+gss_krb5_aes_decrypt(struct krb5_ctx *kctx, u32 offset, u32 len,
 		     struct xdr_buf *buf, u32 *plainoffset,
 		     u32 *plainlen);
 
diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index 25fbd8d9de74..7885f37e3688 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -2043,9 +2043,9 @@ gss_unwrap_resp_priv(struct rpc_task *task, struct rpc_cred *cred,
 	offset = (u8 *)(p) - (u8 *)head->iov_base;
 	if (offset + opaque_len > rcv_buf->len)
 		goto unwrap_failed;
-	rcv_buf->len = offset + opaque_len;
 
-	maj_stat = gss_unwrap(ctx->gc_gss_ctx, offset, rcv_buf);
+	maj_stat = gss_unwrap(ctx->gc_gss_ctx, offset,
+			      offset + opaque_len, rcv_buf);
 	if (maj_stat == GSS_S_CONTEXT_EXPIRED)
 		clear_bit(RPCAUTH_CRED_UPTODATE, &cred->cr_flags);
 	if (maj_stat != GSS_S_COMPLETE)
diff --git a/net/sunrpc/auth_gss/gss_krb5_crypto.c b/net/sunrpc/auth_gss/gss_krb5_crypto.c
index 6f2d30d7b766..e7180da1fc6a 100644
--- a/net/sunrpc/auth_gss/gss_krb5_crypto.c
+++ b/net/sunrpc/auth_gss/gss_krb5_crypto.c
@@ -851,8 +851,8 @@ gss_krb5_aes_encrypt(struct krb5_ctx *kctx, u32 offset,
 }
 
 u32
-gss_krb5_aes_decrypt(struct krb5_ctx *kctx, u32 offset, struct xdr_buf *buf,
-		     u32 *headskip, u32 *tailskip)
+gss_krb5_aes_decrypt(struct krb5_ctx *kctx, u32 offset, u32 len,
+		     struct xdr_buf *buf, u32 *headskip, u32 *tailskip)
 {
 	struct xdr_buf subbuf;
 	u32 ret = 0;
@@ -881,7 +881,7 @@ gss_krb5_aes_decrypt(struct krb5_ctx *kctx, u32 offset, struct xdr_buf *buf,
 
 	/* create a segment skipping the header and leaving out the checksum */
 	xdr_buf_subsegment(buf, &subbuf, offset + GSS_KRB5_TOK_HDR_LEN,
-				    (buf->len - offset - GSS_KRB5_TOK_HDR_LEN -
+				    (len - offset - GSS_KRB5_TOK_HDR_LEN -
 				     kctx->gk5e->cksumlength));
 
 	nblocks = (subbuf.len + blocksize - 1) / blocksize;
@@ -926,7 +926,7 @@ gss_krb5_aes_decrypt(struct krb5_ctx *kctx, u32 offset, struct xdr_buf *buf,
 		goto out_err;
 
 	/* Get the packet's hmac value */
-	ret = read_bytes_from_xdr_buf(buf, buf->len - kctx->gk5e->cksumlength,
+	ret = read_bytes_from_xdr_buf(buf, len - kctx->gk5e->cksumlength,
 				      pkt_hmac, kctx->gk5e->cksumlength);
 	if (ret)
 		goto out_err;
diff --git a/net/sunrpc/auth_gss/gss_krb5_wrap.c b/net/sunrpc/auth_gss/gss_krb5_wrap.c
index 6c1920eed771..c7589e35d5d9 100644
--- a/net/sunrpc/auth_gss/gss_krb5_wrap.c
+++ b/net/sunrpc/auth_gss/gss_krb5_wrap.c
@@ -261,7 +261,8 @@ gss_wrap_kerberos_v1(struct krb5_ctx *kctx, int offset,
 }
 
 static u32
-gss_unwrap_kerberos_v1(struct krb5_ctx *kctx, int offset, struct xdr_buf *buf)
+gss_unwrap_kerberos_v1(struct krb5_ctx *kctx, int offset, int len,
+		       struct xdr_buf *buf)
 {
 	int			signalg;
 	int			sealalg;
@@ -284,7 +285,7 @@ gss_unwrap_kerberos_v1(struct krb5_ctx *kctx, int offset, struct xdr_buf *buf)
 
 	ptr = (u8 *)buf->head[0].iov_base + offset;
 	if (g_verify_token_header(&kctx->mech_used, &bodysize, &ptr,
-					buf->len - offset))
+					len - offset))
 		return GSS_S_DEFECTIVE_TOKEN;
 
 	if ((ptr[0] != ((KG_TOK_WRAP_MSG >> 8) & 0xff)) ||
@@ -324,6 +325,7 @@ gss_unwrap_kerberos_v1(struct krb5_ctx *kctx, int offset, struct xdr_buf *buf)
 	    (!kctx->initiate && direction != 0))
 		return GSS_S_BAD_SIG;
 
+	buf->len = len;
 	if (kctx->enctype == ENCTYPE_ARCFOUR_HMAC) {
 		struct crypto_sync_skcipher *cipher;
 		int err;
@@ -376,7 +378,7 @@ gss_unwrap_kerberos_v1(struct krb5_ctx *kctx, int offset, struct xdr_buf *buf)
 	data_len = (buf->head[0].iov_base + buf->head[0].iov_len) - data_start;
 	memmove(orig_start, data_start, data_len);
 	buf->head[0].iov_len -= (data_start - orig_start);
-	buf->len -= (data_start - orig_start);
+	buf->len = len - (data_start - orig_start);
 
 	if (gss_krb5_remove_padding(buf, blocksize))
 		return GSS_S_DEFECTIVE_TOKEN;
@@ -486,7 +488,8 @@ gss_wrap_kerberos_v2(struct krb5_ctx *kctx, u32 offset,
 }
 
 static u32
-gss_unwrap_kerberos_v2(struct krb5_ctx *kctx, int offset, struct xdr_buf *buf)
+gss_unwrap_kerberos_v2(struct krb5_ctx *kctx, int offset, int len,
+		       struct xdr_buf *buf)
 {
 	time64_t	now;
 	u8		*ptr;
@@ -532,7 +535,7 @@ gss_unwrap_kerberos_v2(struct krb5_ctx *kctx, int offset, struct xdr_buf *buf)
 	if (rrc != 0)
 		rotate_left(offset + 16, buf, rrc);
 
-	err = (*kctx->gk5e->decrypt_v2)(kctx, offset, buf,
+	err = (*kctx->gk5e->decrypt_v2)(kctx, offset, len, buf,
 					&headskip, &tailskip);
 	if (err)
 		return GSS_S_FAILURE;
@@ -542,7 +545,7 @@ gss_unwrap_kerberos_v2(struct krb5_ctx *kctx, int offset, struct xdr_buf *buf)
 	 * it against the original
 	 */
 	err = read_bytes_from_xdr_buf(buf,
-				buf->len - GSS_KRB5_TOK_HDR_LEN - tailskip,
+				len - GSS_KRB5_TOK_HDR_LEN - tailskip,
 				decrypted_hdr, GSS_KRB5_TOK_HDR_LEN);
 	if (err) {
 		dprintk("%s: error %u getting decrypted_hdr\n", __func__, err);
@@ -568,14 +571,14 @@ gss_unwrap_kerberos_v2(struct krb5_ctx *kctx, int offset, struct xdr_buf *buf)
 	 * Note that buf->head[0].iov_len may indicate the available
 	 * head buffer space rather than that actually occupied.
 	 */
-	movelen = min_t(unsigned int, buf->head[0].iov_len, buf->len);
+	movelen = min_t(unsigned int, buf->head[0].iov_len, len);
 	movelen -= offset + GSS_KRB5_TOK_HDR_LEN + headskip;
 	if (offset + GSS_KRB5_TOK_HDR_LEN + headskip + movelen >
 	    buf->head[0].iov_len)
 		return GSS_S_FAILURE;
 	memmove(ptr, ptr + GSS_KRB5_TOK_HDR_LEN + headskip, movelen);
 	buf->head[0].iov_len -= GSS_KRB5_TOK_HDR_LEN + headskip;
-	buf->len -= GSS_KRB5_TOK_HDR_LEN + headskip;
+	buf->len = len - GSS_KRB5_TOK_HDR_LEN + headskip;
 
 	/* Trim off the trailing "extra count" and checksum blob */
 	buf->len -= ec + GSS_KRB5_TOK_HDR_LEN + tailskip;
@@ -603,7 +606,8 @@ gss_wrap_kerberos(struct gss_ctx *gctx, int offset,
 }
 
 u32
-gss_unwrap_kerberos(struct gss_ctx *gctx, int offset, struct xdr_buf *buf)
+gss_unwrap_kerberos(struct gss_ctx *gctx, int offset,
+		    int len, struct xdr_buf *buf)
 {
 	struct krb5_ctx	*kctx = gctx->internal_ctx_id;
 
@@ -613,9 +617,9 @@ gss_unwrap_kerberos(struct gss_ctx *gctx, int offset, struct xdr_buf *buf)
 	case ENCTYPE_DES_CBC_RAW:
 	case ENCTYPE_DES3_CBC_RAW:
 	case ENCTYPE_ARCFOUR_HMAC:
-		return gss_unwrap_kerberos_v1(kctx, offset, buf);
+		return gss_unwrap_kerberos_v1(kctx, offset, len, buf);
 	case ENCTYPE_AES128_CTS_HMAC_SHA1_96:
 	case ENCTYPE_AES256_CTS_HMAC_SHA1_96:
-		return gss_unwrap_kerberos_v2(kctx, offset, buf);
+		return gss_unwrap_kerberos_v2(kctx, offset, len, buf);
 	}
 }
diff --git a/net/sunrpc/auth_gss/gss_mech_switch.c b/net/sunrpc/auth_gss/gss_mech_switch.c
index db550bfc2642..69316ab1b9fa 100644
--- a/net/sunrpc/auth_gss/gss_mech_switch.c
+++ b/net/sunrpc/auth_gss/gss_mech_switch.c
@@ -411,10 +411,11 @@ gss_wrap(struct gss_ctx	*ctx_id,
 u32
 gss_unwrap(struct gss_ctx	*ctx_id,
 	   int			offset,
+	   int			len,
 	   struct xdr_buf	*buf)
 {
 	return ctx_id->mech_type->gm_ops
-		->gss_unwrap(ctx_id, offset, buf);
+		->gss_unwrap(ctx_id, offset, len, buf);
 }
 
 
diff --git a/net/sunrpc/auth_gss/svcauth_gss.c b/net/sunrpc/auth_gss/svcauth_gss.c
index 54ae5be62f6a..d0a2f084e5a4 100644
--- a/net/sunrpc/auth_gss/svcauth_gss.c
+++ b/net/sunrpc/auth_gss/svcauth_gss.c
@@ -934,7 +934,7 @@ static int
 unwrap_priv_data(struct svc_rqst *rqstp, struct xdr_buf *buf, u32 seq, struct gss_ctx *ctx)
 {
 	u32 priv_len, maj_stat;
-	int pad, saved_len, remaining_len, offset;
+	int pad, remaining_len, offset;
 
 	clear_bit(RQ_SPLICE_OK, &rqstp->rq_flags);
 
@@ -954,12 +954,8 @@ unwrap_priv_data(struct svc_rqst *rqstp, struct xdr_buf *buf, u32 seq, struct gs
 	buf->len -= pad;
 	fix_priv_head(buf, pad);
 
-	/* Maybe it would be better to give gss_unwrap a length parameter: */
-	saved_len = buf->len;
-	buf->len = priv_len;
-	maj_stat = gss_unwrap(ctx, 0, buf);
+	maj_stat = gss_unwrap(ctx, 0, priv_len, buf);
 	pad = priv_len - buf->len;
-	buf->len = saved_len;
 	buf->len -= pad;
 	/* The upper layers assume the buffer is aligned on 4-byte boundaries.
 	 * In the krb5p case, at least, the data ends up offset, so we need to

