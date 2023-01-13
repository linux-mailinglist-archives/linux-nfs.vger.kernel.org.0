Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF7A669C2F
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jan 2023 16:29:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjAMP3r (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Jan 2023 10:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjAMP21 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Jan 2023 10:28:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76F343DA2
        for <linux-nfs@vger.kernel.org>; Fri, 13 Jan 2023 07:22:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AADE620D6
        for <linux-nfs@vger.kernel.org>; Fri, 13 Jan 2023 15:22:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D158C433EF;
        Fri, 13 Jan 2023 15:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673623339;
        bh=wKycOl5c2QV5M/yjvRkD6rUWHsDQ0F2ilyVauonUKPo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=JDW3j3+QpEkFSKYAZUKFUVEP0LnbqreCAZtMoHE7wqo97Jn7HXRpncEP0EJe4ObkW
         6mCzYIN8PShEE05Bx9hUtI25eyVpmuB150ay821yLYvM0Z9dWfR+t/6rkgJkVW8m7C
         Ugc06z8TdqAC82qn6YwwNZIrhbeZgiDulz1kHf48j0cbNHXTGpw+RoxvJ4dc5Lzvq3
         mQ8TNN5qEt9kHTmXlkPflqoT0cjPF77tFXFJITEjKiX9wURkrNgrNxFGYfZY5aKwSq
         Nh4gsLBhsTKCaEx/MAHm8QJcoO92MAWp+I4WGLNCr8TOlX5Ouo/0+WUhtcqSCj6sMy
         pXmb5lhuQQ9aA==
Subject: [PATCH v1 08/41] SUNRPC: Obscure Kerberos signing keys
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, simo@redhat.com
Date:   Fri, 13 Jan 2023 10:22:18 -0500
Message-ID: <167362333850.8960.15009112905314133774.stgit@bazille.1015granger.net>
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

There's no need to keep the signing keys around if we instead allocate
and key an ahash and keep that. This not only enables the subkeys to
be destroyed immediately after deriving them, but it makes the
Kerberos signing code path more efficient.

Tested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/gss_krb5.h         |    5 +-
 net/sunrpc/auth_gss/gss_krb5_crypto.c   |   70 +++++++++++++++++++++++++++++++
 net/sunrpc/auth_gss/gss_krb5_internal.h |    4 ++
 net/sunrpc/auth_gss/gss_krb5_mech.c     |   37 ++++++++++++----
 net/sunrpc/auth_gss/gss_krb5_seal.c     |   30 +++++--------
 net/sunrpc/auth_gss/gss_krb5_unseal.c   |   29 ++++++-------
 6 files changed, 127 insertions(+), 48 deletions(-)

diff --git a/include/linux/sunrpc/gss_krb5.h b/include/linux/sunrpc/gss_krb5.h
index 806df140feae..a9b29401d6d1 100644
--- a/include/linux/sunrpc/gss_krb5.h
+++ b/include/linux/sunrpc/gss_krb5.h
@@ -104,6 +104,8 @@ struct krb5_ctx {
 	struct crypto_sync_skcipher *initiator_enc;
 	struct crypto_sync_skcipher *acceptor_enc_aux;
 	struct crypto_sync_skcipher *initiator_enc_aux;
+	struct crypto_ahash	*acceptor_sign;
+	struct crypto_ahash	*initiator_sign;
 	u8			Ksess[GSS_KRB5_MAX_KEYLEN]; /* session key */
 	u8			cksum[GSS_KRB5_MAX_KEYLEN];
 	atomic_t		seq_send;
@@ -112,8 +114,6 @@ struct krb5_ctx {
 	atomic64_t		confounder;
 	siphash_key_t		confkey;
 	struct xdr_netobj	mech_used;
-	u8			initiator_sign[GSS_KRB5_MAX_KEYLEN];
-	u8			acceptor_sign[GSS_KRB5_MAX_KEYLEN];
 	u8			initiator_integ[GSS_KRB5_MAX_KEYLEN];
 	u8			acceptor_integ[GSS_KRB5_MAX_KEYLEN];
 };
@@ -256,7 +256,6 @@ u32
 gss_unwrap_kerberos(struct gss_ctx *ctx_id, int offset, int len,
 		struct xdr_buf *buf);
 
-
 u32
 krb5_encrypt(struct crypto_sync_skcipher *key,
 	     void *iv, void *in, void *out, int length);
diff --git a/net/sunrpc/auth_gss/gss_krb5_crypto.c b/net/sunrpc/auth_gss/gss_krb5_crypto.c
index 6d962079aa95..3fe16852ccd8 100644
--- a/net/sunrpc/auth_gss/gss_krb5_crypto.c
+++ b/net/sunrpc/auth_gss/gss_krb5_crypto.c
@@ -341,6 +341,76 @@ make_checksum_v2(struct krb5_ctx *kctx, char *header, int hdrlen,
 	return err ? GSS_S_FAILURE : 0;
 }
 
+/**
+ * gss_krb5_checksum - Compute the MAC for a GSS Wrap or MIC token
+ * @tfm: an initialized hash transform
+ * @header: pointer to a buffer containing the token header, or NULL
+ * @hdrlen: number of octets in @header
+ * @body: xdr_buf containing an RPC message (body.len is the message length)
+ * @body_offset: byte offset into @body to start checksumming
+ * @cksumout: OUT: a buffer to be filled in with the computed HMAC
+ *
+ * Usually expressed as H = HMAC(K, message)[1..h] .
+ *
+ * Caller provides the truncation length of the output token (h) in
+ * cksumout.len.
+ *
+ * Return values:
+ *   %GSS_S_COMPLETE: Digest computed, @cksumout filled in
+ *   %GSS_S_FAILURE: Call failed
+ */
+u32
+gss_krb5_checksum(struct crypto_ahash *tfm, char *header, int hdrlen,
+		  const struct xdr_buf *body, int body_offset,
+		  struct xdr_netobj *cksumout)
+{
+	struct ahash_request *req;
+	int err = -ENOMEM;
+	u8 *checksumdata;
+
+	checksumdata = kmalloc(crypto_ahash_digestsize(tfm), GFP_KERNEL);
+	if (!checksumdata)
+		return GSS_S_FAILURE;
+
+	req = ahash_request_alloc(tfm, GFP_KERNEL);
+	if (!req)
+		goto out_free_cksum;
+	ahash_request_set_callback(req, CRYPTO_TFM_REQ_MAY_SLEEP, NULL, NULL);
+	err = crypto_ahash_init(req);
+	if (err)
+		goto out_free_ahash;
+
+	/*
+	 * Per RFC 4121 Section 4.2.4, the checksum is performed over the
+	 * data body first, then over the octets in "header".
+	 */
+	err = xdr_process_buf(body, body_offset, body->len - body_offset,
+			      checksummer, req);
+	if (err)
+		goto out_free_ahash;
+	if (header) {
+		struct scatterlist sg[1];
+
+		sg_init_one(sg, header, hdrlen);
+		ahash_request_set_crypt(req, sg, NULL, hdrlen);
+		err = crypto_ahash_update(req);
+		if (err)
+			goto out_free_ahash;
+	}
+
+	ahash_request_set_crypt(req, NULL, checksumdata, 0);
+	err = crypto_ahash_final(req);
+	if (err)
+		goto out_free_ahash;
+	memcpy(cksumout->data, checksumdata, cksumout->len);
+
+out_free_ahash:
+	ahash_request_free(req);
+out_free_cksum:
+	kfree_sensitive(checksumdata);
+	return err ? GSS_S_FAILURE : GSS_S_COMPLETE;
+}
+
 struct encryptor_desc {
 	u8 iv[GSS_KRB5_MAX_BLOCKSIZE];
 	struct skcipher_request *req;
diff --git a/net/sunrpc/auth_gss/gss_krb5_internal.h b/net/sunrpc/auth_gss/gss_krb5_internal.h
index 6249124aba1d..c7ebaf964483 100644
--- a/net/sunrpc/auth_gss/gss_krb5_internal.h
+++ b/net/sunrpc/auth_gss/gss_krb5_internal.h
@@ -10,4 +10,8 @@
 
 void krb5_make_confounder(struct krb5_ctx *kctx, u8 *p, int conflen);
 
+u32 gss_krb5_checksum(struct crypto_ahash *tfm, char *header, int hdrlen,
+		      const struct xdr_buf *body, int body_offset,
+		      struct xdr_netobj *cksumout);
+
 #endif /* _NET_SUNRPC_AUTH_GSS_KRB5_INTERNAL_H */
diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index ba3cfcb2c7c5..0b8ed365a7cb 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -347,6 +347,21 @@ context_derive_keys_des3(struct krb5_ctx *ctx, gfp_t gfp_mask)
 	return -EINVAL;
 }
 
+static struct crypto_ahash *
+gss_krb5_alloc_hash_v2(struct krb5_ctx *kctx, const struct xdr_netobj *key)
+{
+	struct crypto_ahash *tfm;
+
+	tfm = crypto_alloc_ahash(kctx->gk5e->cksum_name, 0, CRYPTO_ALG_ASYNC);
+	if (IS_ERR(tfm))
+		return NULL;
+	if (crypto_ahash_setkey(tfm, key->data, key->len)) {
+		crypto_free_ahash(tfm);
+		return NULL;
+	}
+	return tfm;
+}
+
 static int
 context_derive_keys_new(struct krb5_ctx *ctx, gfp_t gfp_mask)
 {
@@ -414,23 +429,21 @@ context_derive_keys_new(struct krb5_ctx *ctx, gfp_t gfp_mask)
 
 	/* initiator sign checksum */
 	set_cdata(cdata, KG_USAGE_INITIATOR_SIGN, KEY_USAGE_SEED_CHECKSUM);
-	keyout.data = ctx->initiator_sign;
 	err = krb5_derive_key(ctx->gk5e, &keyin, &keyout, &c, gfp_mask);
-	if (err) {
-		dprintk("%s: Error %d deriving initiator_sign key\n",
-			__func__, err);
+	if (err)
+		goto out_free;
+	ctx->initiator_sign = gss_krb5_alloc_hash_v2(ctx, &keyout);
+	if (ctx->initiator_sign == NULL)
 		goto out_free;
-	}
 
 	/* acceptor sign checksum */
 	set_cdata(cdata, KG_USAGE_ACCEPTOR_SIGN, KEY_USAGE_SEED_CHECKSUM);
-	keyout.data = ctx->acceptor_sign;
 	err = krb5_derive_key(ctx->gk5e, &keyin, &keyout, &c, gfp_mask);
-	if (err) {
-		dprintk("%s: Error %d deriving acceptor_sign key\n",
-			__func__, err);
+	if (err)
+		goto out_free;
+	ctx->acceptor_sign = gss_krb5_alloc_hash_v2(ctx, &keyout);
+	if (ctx->acceptor_sign == NULL)
 		goto out_free;
-	}
 
 	/* initiator seal integrity */
 	set_cdata(cdata, KG_USAGE_INITIATOR_SEAL, KEY_USAGE_SEED_INTEGRITY);
@@ -458,6 +471,8 @@ context_derive_keys_new(struct krb5_ctx *ctx, gfp_t gfp_mask)
 	return ret;
 
 out_free:
+	crypto_free_ahash(ctx->acceptor_sign);
+	crypto_free_ahash(ctx->initiator_sign);
 	crypto_free_sync_skcipher(ctx->acceptor_enc_aux);
 	crypto_free_sync_skcipher(ctx->acceptor_enc);
 	crypto_free_sync_skcipher(ctx->initiator_enc_aux);
@@ -583,6 +598,8 @@ gss_delete_sec_context_kerberos(void *internal_ctx) {
 	crypto_free_sync_skcipher(kctx->initiator_enc);
 	crypto_free_sync_skcipher(kctx->acceptor_enc_aux);
 	crypto_free_sync_skcipher(kctx->initiator_enc_aux);
+	crypto_free_ahash(kctx->acceptor_sign);
+	crypto_free_ahash(kctx->initiator_sign);
 	kfree(kctx->mech_used.data);
 	kfree(kctx);
 }
diff --git a/net/sunrpc/auth_gss/gss_krb5_seal.c b/net/sunrpc/auth_gss/gss_krb5_seal.c
index 33061417ec97..1d6f8a345354 100644
--- a/net/sunrpc/auth_gss/gss_krb5_seal.c
+++ b/net/sunrpc/auth_gss/gss_krb5_seal.c
@@ -65,6 +65,8 @@
 #include <linux/crypto.h>
 #include <linux/atomic.h>
 
+#include "gss_krb5_internal.h"
+
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
 # define RPCDBG_FACILITY        RPCDBG_AUTH
 #endif
@@ -166,14 +168,14 @@ static u32
 gss_get_mic_v2(struct krb5_ctx *ctx, struct xdr_buf *text,
 		struct xdr_netobj *token)
 {
-	char cksumdata[GSS_KRB5_MAX_CKSUM_LEN];
-	struct xdr_netobj cksumobj = { .len = sizeof(cksumdata),
-				       .data = cksumdata};
+	struct crypto_ahash *tfm = ctx->initiate ?
+				   ctx->initiator_sign : ctx->acceptor_sign;
+	struct xdr_netobj cksumobj = {
+		.len =	ctx->gk5e->cksumlength,
+	};
+	__be64 seq_send_be64;
 	void *krb5_hdr;
 	time64_t now;
-	u8 *cksumkey;
-	unsigned int cksum_usage;
-	__be64 seq_send_be64;
 
 	dprintk("RPC:       %s\n", __func__);
 
@@ -184,22 +186,12 @@ gss_get_mic_v2(struct krb5_ctx *ctx, struct xdr_buf *text,
 	seq_send_be64 = cpu_to_be64(atomic64_fetch_inc(&ctx->seq_send64));
 	memcpy(krb5_hdr + 8, (char *) &seq_send_be64, 8);
 
-	if (ctx->initiate) {
-		cksumkey = ctx->initiator_sign;
-		cksum_usage = KG_USAGE_INITIATOR_SIGN;
-	} else {
-		cksumkey = ctx->acceptor_sign;
-		cksum_usage = KG_USAGE_ACCEPTOR_SIGN;
-	}
-
-	if (make_checksum_v2(ctx, krb5_hdr, GSS_KRB5_TOK_HDR_LEN,
-			     text, 0, cksumkey, cksum_usage, &cksumobj))
+	cksumobj.data = krb5_hdr + GSS_KRB5_TOK_HDR_LEN;
+	if (gss_krb5_checksum(tfm, krb5_hdr, GSS_KRB5_TOK_HDR_LEN,
+			      text, 0, &cksumobj))
 		return GSS_S_FAILURE;
 
-	memcpy(krb5_hdr + GSS_KRB5_TOK_HDR_LEN, cksumobj.data, cksumobj.len);
-
 	now = ktime_get_real_seconds();
-
 	return (ctx->endtime < now) ? GSS_S_CONTEXT_EXPIRED : GSS_S_COMPLETE;
 }
 
diff --git a/net/sunrpc/auth_gss/gss_krb5_unseal.c b/net/sunrpc/auth_gss/gss_krb5_unseal.c
index ba04e3ec970a..d52103f1203b 100644
--- a/net/sunrpc/auth_gss/gss_krb5_unseal.c
+++ b/net/sunrpc/auth_gss/gss_krb5_unseal.c
@@ -57,11 +57,14 @@
  * WARRANTIES OF MERCHANTIBILITY AND FITNESS FOR A PARTICULAR PURPOSE.
  */
 
+#include <crypto/algapi.h>
 #include <linux/types.h>
 #include <linux/jiffies.h>
 #include <linux/sunrpc/gss_krb5.h>
 #include <linux/crypto.h>
 
+#include "gss_krb5_internal.h"
+
 #if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
 # define RPCDBG_FACILITY        RPCDBG_AUTH
 #endif
@@ -146,16 +149,18 @@ static u32
 gss_verify_mic_v2(struct krb5_ctx *ctx,
 		struct xdr_buf *message_buffer, struct xdr_netobj *read_token)
 {
+	struct crypto_ahash *tfm = ctx->initiate ?
+				   ctx->acceptor_sign : ctx->initiator_sign;
 	char cksumdata[GSS_KRB5_MAX_CKSUM_LEN];
-	struct xdr_netobj cksumobj = {.len = sizeof(cksumdata),
-				      .data = cksumdata};
-	time64_t now;
+	struct xdr_netobj cksumobj = {
+		.len	= ctx->gk5e->cksumlength,
+		.data	= cksumdata,
+	};
 	u8 *ptr = read_token->data;
-	u8 *cksumkey;
+	__be16 be16_ptr;
+	time64_t now;
 	u8 flags;
 	int i;
-	unsigned int cksum_usage;
-	__be16 be16_ptr;
 
 	dprintk("RPC:       %s\n", __func__);
 
@@ -177,16 +182,8 @@ gss_verify_mic_v2(struct krb5_ctx *ctx,
 		if (ptr[i] != 0xff)
 			return GSS_S_DEFECTIVE_TOKEN;
 
-	if (ctx->initiate) {
-		cksumkey = ctx->acceptor_sign;
-		cksum_usage = KG_USAGE_ACCEPTOR_SIGN;
-	} else {
-		cksumkey = ctx->initiator_sign;
-		cksum_usage = KG_USAGE_INITIATOR_SIGN;
-	}
-
-	if (make_checksum_v2(ctx, ptr, GSS_KRB5_TOK_HDR_LEN, message_buffer, 0,
-			     cksumkey, cksum_usage, &cksumobj))
+	if (gss_krb5_checksum(tfm, ptr, GSS_KRB5_TOK_HDR_LEN,
+			      message_buffer, 0, &cksumobj))
 		return GSS_S_FAILURE;
 
 	if (memcmp(cksumobj.data, ptr + GSS_KRB5_TOK_HDR_LEN,


