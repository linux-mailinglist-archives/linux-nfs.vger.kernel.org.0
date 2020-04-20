Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75F751AFFC3
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Apr 2020 04:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgDTCRt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 19 Apr 2020 22:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725865AbgDTCRt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 19 Apr 2020 22:17:49 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D037C061A0C
        for <linux-nfs@vger.kernel.org>; Sun, 19 Apr 2020 19:17:49 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id x66so9061782qkd.9
        for <linux-nfs@vger.kernel.org>; Sun, 19 Apr 2020 19:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=EggBC0z7Ug3UXGew6XyB0cQ+fL9zHJm5QGjsz39Ry9I=;
        b=l2MfChzD73raYF5mAxum7ot3EB/hcBxTOp7NK8X8qRPGspfE7aIaa093dPJH2sAdaU
         7TCQgtXKK2KfgOaDLP06pzK2gFSLgFKinNkots4YmmJddw5MUxc4dHvat0dBAZvuxbtL
         pDgW5ZdeNCyl0/tQ0O48Nw106HroZ+3UkKEpGXj054CPDD/4O0igMMENpt63wuQYz0aj
         0mMJctL92osYYevVk/269AADsVMGtavYyJD8uSZRuCfpDRDsleARu1IUcxp2O0Q8XDmw
         GRwsvKkO07LH8zBaWNmzUQRrEdCUbQNVJBs+iDHIZA5nZN/c1eTzx5Y3Im9llYzfBQXR
         jAVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=EggBC0z7Ug3UXGew6XyB0cQ+fL9zHJm5QGjsz39Ry9I=;
        b=OkgvjM15/Lm+x2yvN2+SlGHYbSeTCp/m1Nn6pI+N/HzS+oN2YHYrEy4i8VJkmU949v
         SmCaUbQI8MugjG8TmBfGQEJrzxx3YgCDSJqA3fSP2DK8RLKzoMeGvUvBVizy2SPu+DJX
         QFuN3IZZvsR+MuHc3OTzW8YkeUPuDcr5OKMddoMaxPl6w3HHnzwwfMzQ/yDFFD5lVNyq
         zc8sKx1OGaSOTsKrCrDqIPmLAAiLEJV5MgzqbbyYUrpUuczwu2V9sY1UPdBWf5Bsl1YX
         NJj7yXlQV4Sv9nmMQLPemPKQFQJHg42FuhepfAje7xGmwYBQbKmM0CQpIGLSBSfoEJAK
         rx+Q==
X-Gm-Message-State: AGi0PuZ4aZn7H0/3PCNvainl+NVR5Xh/PkrKxjXp/S4P5//oIHWXnn8V
        WZ4K35Zta5nQiow1wvqaJOfm6bHQ
X-Google-Smtp-Source: APiQypKQJ+mcsqI+t9AyFo6AbBvpPIxv+Aiwo8rZMNusjVkpRDcfV8XTcWow6kc3do7kT0wrYN/WGw==
X-Received: by 2002:a37:614a:: with SMTP id v71mr5419516qkb.326.1587349068083;
        Sun, 19 Apr 2020 19:17:48 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id j76sm14112742qke.114.2020.04.19.19.17.47
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Apr 2020 19:17:47 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 03K2Hkh0017004
        for <linux-nfs@vger.kernel.org>; Mon, 20 Apr 2020 02:17:46 GMT
Subject: [PATCH v1 2/3] SUNRPC: Fix GSS privacy computation of
 auth->au_ralign
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Sun, 19 Apr 2020 22:17:46 -0400
Message-ID: <20200420021746.3416.51903.stgit@klimt.1015granger.net>
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

When the au_ralign field was added to gss_unwrap_resp_priv, the
wrong calculation was used. Setting au_rslack == au_ralign is
probably correct for kerberos_v1 privacy, but kerberos_v2 privacy
adds additional GSS data after the clear text RPC message.
au_ralign needs to be smaller than au_rslack in that fairly common
case.

When xdr_buf_trim() is restored to gss_unwrap_kerberos_v2(), it does
exactly what I feared it would: it trims off part of the clear text
RPC message. However, that's because rpc_prepare_reply_pages() does
not set up the rq_rcv_buf's tail correctly because au_ralign is too
large.

Fixing the au_ralign computation also corrects the alignment of
rq_rcv_buf->pages so that the client does not have to shift reply
data payloads after they are received.

Fixes: 35e77d21baa0 ("SUNRPC: Add rpc_auth::au_ralign field")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/gss_api.h      |    1 +
 net/sunrpc/auth_gss/auth_gss.c      |    8 +++-----
 net/sunrpc/auth_gss/gss_krb5_wrap.c |   19 +++++++++++++++----
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/include/linux/sunrpc/gss_api.h b/include/linux/sunrpc/gss_api.h
index e9a79518d652..bc07e51f20d1 100644
--- a/include/linux/sunrpc/gss_api.h
+++ b/include/linux/sunrpc/gss_api.h
@@ -21,6 +21,7 @@
 struct gss_ctx {
 	struct gss_api_mech	*mech_type;
 	void			*internal_ctx_id;
+	unsigned int		slack, align;
 };
 
 #define GSS_C_NO_BUFFER		((struct xdr_netobj) 0)
diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index 7885f37e3688..ac5cac0dd24b 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -2032,7 +2032,6 @@ gss_unwrap_resp_priv(struct rpc_task *task, struct rpc_cred *cred,
 	struct xdr_buf *rcv_buf = &rqstp->rq_rcv_buf;
 	struct kvec *head = rqstp->rq_rcv_buf.head;
 	struct rpc_auth *auth = cred->cr_auth;
-	unsigned int savedlen = rcv_buf->len;
 	u32 offset, opaque_len, maj_stat;
 	__be32 *p;
 
@@ -2059,10 +2058,9 @@ gss_unwrap_resp_priv(struct rpc_task *task, struct rpc_cred *cred,
 	 */
 	xdr_init_decode(xdr, rcv_buf, p, rqstp);
 
-	auth->au_rslack = auth->au_verfsize + 2 +
-			  XDR_QUADLEN(savedlen - rcv_buf->len);
-	auth->au_ralign = auth->au_verfsize + 2 +
-			  XDR_QUADLEN(savedlen - rcv_buf->len);
+	auth->au_rslack = auth->au_verfsize + 2 + ctx->gc_gss_ctx->slack;
+	auth->au_ralign = auth->au_verfsize + 2 + ctx->gc_gss_ctx->align;
+
 	return 0;
 unwrap_failed:
 	trace_rpcgss_unwrap_failed(task);
diff --git a/net/sunrpc/auth_gss/gss_krb5_wrap.c b/net/sunrpc/auth_gss/gss_krb5_wrap.c
index c7589e35d5d9..4905652e7567 100644
--- a/net/sunrpc/auth_gss/gss_krb5_wrap.c
+++ b/net/sunrpc/auth_gss/gss_krb5_wrap.c
@@ -262,7 +262,8 @@ gss_wrap_kerberos_v1(struct krb5_ctx *kctx, int offset,
 
 static u32
 gss_unwrap_kerberos_v1(struct krb5_ctx *kctx, int offset, int len,
-		       struct xdr_buf *buf)
+		       struct xdr_buf *buf, unsigned int *slack,
+		       unsigned int *align)
 {
 	int			signalg;
 	int			sealalg;
@@ -280,6 +281,7 @@ gss_unwrap_kerberos_v1(struct krb5_ctx *kctx, int offset, int len,
 	u32			conflen = kctx->gk5e->conflen;
 	int			crypt_offset;
 	u8			*cksumkey;
+	unsigned int		saved_len = buf->len;
 
 	dprintk("RPC:       gss_unwrap_kerberos\n");
 
@@ -383,6 +385,10 @@ gss_unwrap_kerberos_v1(struct krb5_ctx *kctx, int offset, int len,
 	if (gss_krb5_remove_padding(buf, blocksize))
 		return GSS_S_DEFECTIVE_TOKEN;
 
+	/* slack must include room for krb5 padding */
+	*slack = XDR_QUADLEN(saved_len - buf->len);
+	/* The GSS blob always precedes the RPC message payload */
+	*align = *slack;
 	return GSS_S_COMPLETE;
 }
 
@@ -489,7 +495,8 @@ gss_wrap_kerberos_v2(struct krb5_ctx *kctx, u32 offset,
 
 static u32
 gss_unwrap_kerberos_v2(struct krb5_ctx *kctx, int offset, int len,
-		       struct xdr_buf *buf)
+		       struct xdr_buf *buf, unsigned int *slack,
+		       unsigned int *align)
 {
 	time64_t	now;
 	u8		*ptr;
@@ -583,6 +590,8 @@ gss_unwrap_kerberos_v2(struct krb5_ctx *kctx, int offset, int len,
 	/* Trim off the trailing "extra count" and checksum blob */
 	buf->len -= ec + GSS_KRB5_TOK_HDR_LEN + tailskip;
 
+	*align = XDR_QUADLEN(GSS_KRB5_TOK_HDR_LEN + headskip);
+	*slack = *align + XDR_QUADLEN(ec + GSS_KRB5_TOK_HDR_LEN + tailskip);
 	return GSS_S_COMPLETE;
 }
 
@@ -617,9 +626,11 @@ gss_unwrap_kerberos(struct gss_ctx *gctx, int offset,
 	case ENCTYPE_DES_CBC_RAW:
 	case ENCTYPE_DES3_CBC_RAW:
 	case ENCTYPE_ARCFOUR_HMAC:
-		return gss_unwrap_kerberos_v1(kctx, offset, len, buf);
+		return gss_unwrap_kerberos_v1(kctx, offset, len, buf,
+					      &gctx->slack, &gctx->align);
 	case ENCTYPE_AES128_CTS_HMAC_SHA1_96:
 	case ENCTYPE_AES256_CTS_HMAC_SHA1_96:
-		return gss_unwrap_kerberos_v2(kctx, offset, len, buf);
+		return gss_unwrap_kerberos_v2(kctx, offset, len, buf,
+					      &gctx->slack, &gctx->align);
 	}
 }

