Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC26C669C25
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jan 2023 16:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjAMP3A (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Jan 2023 10:29:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjAMP2V (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Jan 2023 10:28:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B94876CA
        for <linux-nfs@vger.kernel.org>; Fri, 13 Jan 2023 07:21:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A2573B820D2
        for <linux-nfs@vger.kernel.org>; Fri, 13 Jan 2023 15:21:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05675C4339B;
        Fri, 13 Jan 2023 15:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673623314;
        bh=0Oum7s/rQWA/1mTmpbrwZOv7bnMHiykn/XyBuVDv5k4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=o6STalZXAPVrXfhuKtE4dwG/Ctr+RUWNAvcw/U2Y3OwXMyd08Yo0bq4kjmHSGaDWp
         bZM9Ql3mAluSkICNuHg/sRLy3xCyXqhlQW1VrUtcFit1/7NpuVyUukANMOJkWMcssr
         VZ+XA1bKYNDTLVcLaDf0hRftJ1P+QEAJX4fm+jF+b7UAkJeDF9ZQXcfCJWeh1UDzrx
         SAe+I7Jb85FcxYdi4jy992NcIyvFac6QaPGViSvFkOwqTydYLEMuKzRSdKs7l9m+op
         PNPIDgFdHtxMala0F3CsdlDdvj8JCj4yxpFEB21lR18eUq0GWanMER5HJOJDOkoXfd
         82mp/+pqM0Fmw==
Subject: [PATCH v1 04/41] SUNRPC: Improve Kerberos confounder generation
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, simo@redhat.com
Date:   Fri, 13 Jan 2023 10:21:53 -0500
Message-ID: <167362331302.8960.7194615871100298109.stgit@bazille.1015granger.net>
In-Reply-To: <167362164696.8960.16701168753472560115.stgit@bazille.1015granger.net>
References: <167362164696.8960.16701168753472560115.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Other common Kerberos implementations use a fully random confounder
for encryption. For a Kerberos implementation that is part of an O/S
I/O stack, this is impractical. However, using a fast PRG that does
not deplete the system entropy pool is possible and desirable.

Use an atomic type to ensure that confounder generation
deterministically generates a unique and pseudo-random result in the
face of concurrent execution, and make the confounder generation
materials unique to each Keberos context. The latter has several
benefits:

- the internal counter will wrap less often
- no way to guess confounders based on other Kerberos-encrypted
  traffic
- better scalability

Since confounder generation is part of Kerberos itself rather than
the GSS-API Kerberos mechanism, the function is renamed and moved.

Tested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/gss_krb5.h         |    7 +++---
 net/sunrpc/auth_gss/gss_krb5_crypto.c   |   28 ++++++++++++++++++++++-
 net/sunrpc/auth_gss/gss_krb5_internal.h |   13 +++++++++++
 net/sunrpc/auth_gss/gss_krb5_mech.c     |   17 +++++++-------
 net/sunrpc/auth_gss/gss_krb5_wrap.c     |   38 ++-----------------------------
 5 files changed, 56 insertions(+), 47 deletions(-)
 create mode 100644 net/sunrpc/auth_gss/gss_krb5_internal.h

diff --git a/include/linux/sunrpc/gss_krb5.h b/include/linux/sunrpc/gss_krb5.h
index 51860e3a0216..192f5b37763f 100644
--- a/include/linux/sunrpc/gss_krb5.h
+++ b/include/linux/sunrpc/gss_krb5.h
@@ -38,6 +38,8 @@
 #define _LINUX_SUNRPC_GSS_KRB5_H
 
 #include <crypto/skcipher.h>
+#include <linux/siphash.h>
+
 #include <linux/sunrpc/auth_gss.h>
 #include <linux/sunrpc/gss_err.h>
 #include <linux/sunrpc/gss_asn1.h>
@@ -106,6 +108,8 @@ struct krb5_ctx {
 	atomic_t		seq_send;
 	atomic64_t		seq_send64;
 	time64_t		endtime;
+	atomic64_t		confounder;
+	siphash_key_t		confkey;
 	struct xdr_netobj	mech_used;
 	u8			initiator_sign[GSS_KRB5_MAX_KEYLEN];
 	u8			acceptor_sign[GSS_KRB5_MAX_KEYLEN];
@@ -311,7 +315,4 @@ gss_krb5_aes_decrypt(struct krb5_ctx *kctx, u32 offset, u32 len,
 		     struct xdr_buf *buf, u32 *plainoffset,
 		     u32 *plainlen);
 
-void
-gss_krb5_make_confounder(char *p, u32 conflen);
-
 #endif /* _LINUX_SUNRPC_GSS_KRB5_H */
diff --git a/net/sunrpc/auth_gss/gss_krb5_crypto.c b/net/sunrpc/auth_gss/gss_krb5_crypto.c
index 8aa5610ef660..6d962079aa95 100644
--- a/net/sunrpc/auth_gss/gss_krb5_crypto.c
+++ b/net/sunrpc/auth_gss/gss_krb5_crypto.c
@@ -47,10 +47,36 @@
 #include <linux/sunrpc/gss_krb5.h>
 #include <linux/sunrpc/xdr.h>
 
+#include "gss_krb5_internal.h"
+
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
 # define RPCDBG_FACILITY        RPCDBG_AUTH
 #endif
 
+/**
+ * krb5_make_confounder - Generate a unique pseudorandom string
+ * @kctx: Kerberos context
+ * @p: memory location into which to write the string
+ * @conflen: string length to write, in octets
+ *
+ * To avoid draining the system's entropy pool when under heavy
+ * encrypted I/O loads, the @kctx has a small amount of random seed
+ * data that is then hashed to generate each pseudorandom confounder
+ * string.
+ */
+void
+krb5_make_confounder(struct krb5_ctx *kctx, u8 *p, int conflen)
+{
+	u64 *q = (u64 *)p;
+
+	WARN_ON_ONCE(conflen < sizeof(*q));
+	while (conflen > 0) {
+		*q++ = siphash_1u64(atomic64_inc_return(&kctx->confounder),
+				    &kctx->confkey);
+		conflen -= sizeof(*q);
+	}
+}
+
 u32
 krb5_encrypt(
 	struct crypto_sync_skcipher *tfm,
@@ -630,7 +656,7 @@ gss_krb5_aes_encrypt(struct krb5_ctx *kctx, u32 offset,
 	offset += GSS_KRB5_TOK_HDR_LEN;
 	if (xdr_extend_head(buf, offset, conflen))
 		return GSS_S_FAILURE;
-	gss_krb5_make_confounder(buf->head[0].iov_base + offset, conflen);
+	krb5_make_confounder(kctx, buf->head[0].iov_base + offset, conflen);
 	offset -= GSS_KRB5_TOK_HDR_LEN;
 
 	if (buf->tail[0].iov_base != NULL) {
diff --git a/net/sunrpc/auth_gss/gss_krb5_internal.h b/net/sunrpc/auth_gss/gss_krb5_internal.h
new file mode 100644
index 000000000000..6249124aba1d
--- /dev/null
+++ b/net/sunrpc/auth_gss/gss_krb5_internal.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 or BSD-3-Clause */
+/*
+ * SunRPC GSS Kerberos 5 mechanism internal definitions
+ *
+ * Copyright (c) 2022 Oracle and/or its affiliates.
+ */
+
+#ifndef _NET_SUNRPC_AUTH_GSS_KRB5_INTERNAL_H
+#define _NET_SUNRPC_AUTH_GSS_KRB5_INTERNAL_H
+
+void krb5_make_confounder(struct krb5_ctx *kctx, u8 *p, int conflen);
+
+#endif /* _NET_SUNRPC_AUTH_GSS_KRB5_INTERNAL_H */
diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index 08a86ece665e..6d59794c9b69 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -550,16 +550,17 @@ gss_import_sec_context_kerberos(const void *p, size_t len,
 		ret = gss_import_v1_context(p, end, ctx);
 	else
 		ret = gss_import_v2_context(p, end, ctx, gfp_mask);
-
-	if (ret == 0) {
-		ctx_id->internal_ctx_id = ctx;
-		if (endtime)
-			*endtime = ctx->endtime;
-	} else
+	if (ret) {
 		kfree(ctx);
+		return ret;
+	}
 
-	dprintk("RPC:       %s: returning %d\n", __func__, ret);
-	return ret;
+	ctx_id->internal_ctx_id = ctx;
+	if (endtime)
+		*endtime = ctx->endtime;
+	atomic64_set(&ctx->confounder, get_random_u64());
+	get_random_bytes(&ctx->confkey, sizeof(ctx->confkey));
+	return 0;
 }
 
 static void
diff --git a/net/sunrpc/auth_gss/gss_krb5_wrap.c b/net/sunrpc/auth_gss/gss_krb5_wrap.c
index bd068e936947..374214f3c463 100644
--- a/net/sunrpc/auth_gss/gss_krb5_wrap.c
+++ b/net/sunrpc/auth_gss/gss_krb5_wrap.c
@@ -32,9 +32,10 @@
 #include <linux/types.h>
 #include <linux/jiffies.h>
 #include <linux/sunrpc/gss_krb5.h>
-#include <linux/random.h>
 #include <linux/pagemap.h>
 
+#include "gss_krb5_internal.h"
+
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
 # define RPCDBG_FACILITY	RPCDBG_AUTH
 #endif
@@ -113,39 +114,6 @@ gss_krb5_remove_padding(struct xdr_buf *buf, int blocksize)
 	return 0;
 }
 
-void
-gss_krb5_make_confounder(char *p, u32 conflen)
-{
-	static u64 i = 0;
-	u64 *q = (u64 *)p;
-
-	/* rfc1964 claims this should be "random".  But all that's really
-	 * necessary is that it be unique.  And not even that is necessary in
-	 * our case since our "gssapi" implementation exists only to support
-	 * rpcsec_gss, so we know that the only buffers we will ever encrypt
-	 * already begin with a unique sequence number.  Just to hedge my bets
-	 * I'll make a half-hearted attempt at something unique, but ensuring
-	 * uniqueness would mean worrying about atomicity and rollover, and I
-	 * don't care enough. */
-
-	/* initialize to random value */
-	if (i == 0) {
-		i = get_random_u32();
-		i = (i << 32) | get_random_u32();
-	}
-
-	switch (conflen) {
-	case 16:
-		*q++ = i++;
-		fallthrough;
-	case 8:
-		*q++ = i++;
-		break;
-	default:
-		BUG();
-	}
-}
-
 /* Assumptions: the head and tail of inbuf are ours to play with.
  * The pages, however, may be real pages in the page cache and we replace
  * them with scratch pages from **pages before writing to them. */
@@ -211,7 +179,7 @@ gss_wrap_kerberos_v1(struct krb5_ctx *kctx, int offset,
 	ptr[6] = 0xff;
 	ptr[7] = 0xff;
 
-	gss_krb5_make_confounder(msg_start, conflen);
+	krb5_make_confounder(kctx, msg_start, conflen);
 
 	if (kctx->gk5e->keyed_cksum)
 		cksumkey = kctx->cksum;


