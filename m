Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F38FA669C54
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jan 2023 16:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjAMPbj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Jan 2023 10:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230184AbjAMPbU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Jan 2023 10:31:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A882E80AF7
        for <linux-nfs@vger.kernel.org>; Fri, 13 Jan 2023 07:24:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1E62AB8216D
        for <linux-nfs@vger.kernel.org>; Fri, 13 Jan 2023 15:24:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC59C433D2;
        Fri, 13 Jan 2023 15:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673623478;
        bh=hVWiOllP3jcynmTOLjTVN1U9Cu8q8Pes0o0P9LjTfQQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=uDeBnU6Hq9RBTKY7CS9R29Kn0O/VUX3gCeWahSFzkrcECvBbeVWfIIbnLVvpr1ebQ
         tmp7Xwa+RvPyOj2VvllKfjozfXDXpw2xKMfbeKG7tPH9hNG6O5pzFBJ9ZQxAQnTLfW
         jug2aH7ODnGWbEUxtsozO279gURpybbG3BPLBDlG/x3/V7HY1QhAPW7psECAbMpAkP
         FfvwPfdURYXoS81oS78UK9scUV/KRcFo+RP/iLvgBYqW3N7ZqetossZyfzjHZe1Idh
         TSr9fPH/NEqA1yft/SWdmblehLYPLos2jCnRbdcrS/mmnrRdUbpeWeTpLztcuS3IGp
         VZKIMeVCGwPDg==
Subject: [PATCH v1 30/41] SUNRPC: Move remaining internal definitions to
 gss_krb5_internal.h
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, simo@redhat.com
Date:   Fri, 13 Jan 2023 10:24:37 -0500
Message-ID: <167362347762.8960.9068522489996929477.stgit@bazille.1015granger.net>
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

The goal is to leave only protocol-defined items in gss_krb5.h so
that it can be easily replaced by a generic header. Implementation
specific items are moved to the new internal header.

Tested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/gss_krb5.h         |  119 -------------------------------
 net/sunrpc/auth_gss/auth_gss.c          |   17 ++++
 net/sunrpc/auth_gss/gss_krb5_crypto.c   |    1 
 net/sunrpc/auth_gss/gss_krb5_internal.h |   97 +++++++++++++++++++++++++
 4 files changed, 114 insertions(+), 120 deletions(-)

diff --git a/include/linux/sunrpc/gss_krb5.h b/include/linux/sunrpc/gss_krb5.h
index e5d9a94cf394..2fb2dee08ec6 100644
--- a/include/linux/sunrpc/gss_krb5.h
+++ b/include/linux/sunrpc/gss_krb5.h
@@ -44,12 +44,6 @@
 #include <linux/sunrpc/gss_err.h>
 #include <linux/sunrpc/gss_asn1.h>
 
-/*
- * The RFCs often specify payload lengths in bits. This helper
- * converts a specified bit-length to the number of octets/bytes.
- */
-#define BITS2OCTETS(x)	((x) / 8)
-
 /* Length of constant used in key derivation */
 #define GSS_KRB5_K5CLENGTH (5)
 
@@ -62,76 +56,6 @@
 /* Maximum blocksize for the supported crypto algorithms */
 #define GSS_KRB5_MAX_BLOCKSIZE  (16)
 
-struct krb5_ctx;
-
-struct gss_krb5_enctype {
-	const u32		etype;		/* encryption (key) type */
-	const u32		ctype;		/* checksum type */
-	const char		*name;		/* "friendly" name */
-	const char		*encrypt_name;	/* crypto encrypt name */
-	const char		*aux_cipher;	/* aux encrypt cipher name */
-	const char		*cksum_name;	/* crypto checksum name */
-	const u16		signalg;	/* signing algorithm */
-	const u16		sealalg;	/* sealing algorithm */
-	const u32		cksumlength;	/* checksum length */
-	const u32		keyed_cksum;	/* is it a keyed cksum? */
-	const u32		keybytes;	/* raw key len, in bytes */
-	const u32		keylength;	/* protocol key length, in octets */
-	const u32		Kc_length;	/* checksum subkey length, in octets */
-	const u32		Ke_length;	/* encryption subkey length, in octets */
-	const u32		Ki_length;	/* integrity subkey length, in octets */
-
-	int (*import_ctx)(struct krb5_ctx *ctx, gfp_t gfp_mask);
-	int (*derive_key)(const struct gss_krb5_enctype *gk5e,
-			  const struct xdr_netobj *in,
-			  struct xdr_netobj *out,
-			  const struct xdr_netobj *label,
-			  gfp_t gfp_mask);
-	u32 (*encrypt)(struct krb5_ctx *kctx, u32 offset,
-			struct xdr_buf *buf, struct page **pages);
-	u32 (*decrypt)(struct krb5_ctx *kctx, u32 offset, u32 len,
-		       struct xdr_buf *buf, u32 *headskip, u32 *tailskip);
-	u32 (*get_mic)(struct krb5_ctx *kctx, struct xdr_buf *text,
-		       struct xdr_netobj *token);
-	u32 (*verify_mic)(struct krb5_ctx *kctx, struct xdr_buf *message_buffer,
-			  struct xdr_netobj *read_token);
-	u32 (*wrap)(struct krb5_ctx *kctx, int offset,
-		    struct xdr_buf *buf, struct page **pages);
-	u32 (*unwrap)(struct krb5_ctx *kctx, int offset, int len,
-		      struct xdr_buf *buf, unsigned int *slack,
-		      unsigned int *align);
-};
-
-/* krb5_ctx flags definitions */
-#define KRB5_CTX_FLAG_INITIATOR         0x00000001
-#define KRB5_CTX_FLAG_CFX               0x00000002
-#define KRB5_CTX_FLAG_ACCEPTOR_SUBKEY   0x00000004
-
-struct krb5_ctx {
-	int			initiate; /* 1 = initiating, 0 = accepting */
-	u32			enctype;
-	u32			flags;
-	const struct gss_krb5_enctype *gk5e; /* enctype-specific info */
-	struct crypto_sync_skcipher *enc;
-	struct crypto_sync_skcipher *seq;
-	struct crypto_sync_skcipher *acceptor_enc;
-	struct crypto_sync_skcipher *initiator_enc;
-	struct crypto_sync_skcipher *acceptor_enc_aux;
-	struct crypto_sync_skcipher *initiator_enc_aux;
-	struct crypto_ahash	*acceptor_sign;
-	struct crypto_ahash	*initiator_sign;
-	struct crypto_ahash	*initiator_integ;
-	struct crypto_ahash	*acceptor_integ;
-	u8			Ksess[GSS_KRB5_MAX_KEYLEN]; /* session key */
-	u8			cksum[GSS_KRB5_MAX_KEYLEN];
-	atomic_t		seq_send;
-	atomic64_t		seq_send64;
-	time64_t		endtime;
-	atomic64_t		confounder;
-	siphash_key_t		confkey;
-	struct xdr_netobj	mech_used;
-};
-
 /* The length of the Kerberos GSS token header */
 #define GSS_KRB5_TOK_HDR_LEN	(16)
 
@@ -249,47 +173,4 @@ enum seal_alg {
 #define KG_USAGE_INITIATOR_SEAL (24)
 #define KG_USAGE_INITIATOR_SIGN (25)
 
-/*
- * This compile-time check verifies that we will not exceed the
- * slack space allotted by the client and server auth_gss code
- * before they call gss_wrap().
- */
-#define GSS_KRB5_MAX_SLACK_NEEDED \
-	(GSS_KRB5_TOK_HDR_LEN     /* gss token header */         \
-	+ GSS_KRB5_MAX_CKSUM_LEN  /* gss token checksum */       \
-	+ GSS_KRB5_MAX_BLOCKSIZE  /* confounder */               \
-	+ GSS_KRB5_MAX_BLOCKSIZE  /* possible padding */         \
-	+ GSS_KRB5_TOK_HDR_LEN    /* encrypted hdr in v2 token */\
-	+ GSS_KRB5_MAX_CKSUM_LEN  /* encryption hmac */          \
-	+ 4 + 4                   /* RPC verifier */             \
-	+ GSS_KRB5_TOK_HDR_LEN                                   \
-	+ GSS_KRB5_MAX_CKSUM_LEN)
-
-u32
-make_checksum(struct krb5_ctx *kctx, char *header, int hdrlen,
-		struct xdr_buf *body, int body_offset, u8 *cksumkey,
-		unsigned int usage, struct xdr_netobj *cksumout);
-
-int
-gss_encrypt_xdr_buf(struct crypto_sync_skcipher *tfm, struct xdr_buf *outbuf,
-		    int offset, struct page **pages);
-
-int
-gss_decrypt_xdr_buf(struct crypto_sync_skcipher *tfm, struct xdr_buf *inbuf,
-		    int offset);
-
-s32
-krb5_make_seq_num(struct krb5_ctx *kctx,
-		struct crypto_sync_skcipher *key,
-		int direction,
-		u32 seqnum, unsigned char *cksum, unsigned char *buf);
-
-s32
-krb5_get_seq_num(struct krb5_ctx *kctx,
-	       unsigned char *cksum,
-	       unsigned char *buf, int *direction, u32 *seqnum);
-
-int
-xdr_extend_head(struct xdr_buf *buf, unsigned int base, unsigned int shiftlen);
-
 #endif /* _LINUX_SUNRPC_GSS_KRB5_H */
diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index 2d7b1e03110a..1af71fbb0d80 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -49,6 +49,22 @@ static unsigned int gss_key_expire_timeo = GSS_KEY_EXPIRE_TIMEO;
 # define RPCDBG_FACILITY	RPCDBG_AUTH
 #endif
 
+/*
+ * This compile-time check verifies that we will not exceed the
+ * slack space allotted by the client and server auth_gss code
+ * before they call gss_wrap().
+ */
+#define GSS_KRB5_MAX_SLACK_NEEDED					\
+	(GSS_KRB5_TOK_HDR_LEN		/* gss token header */		\
+	+ GSS_KRB5_MAX_CKSUM_LEN	/* gss token checksum */	\
+	+ GSS_KRB5_MAX_BLOCKSIZE	/* confounder */		\
+	+ GSS_KRB5_MAX_BLOCKSIZE	/* possible padding */		\
+	+ GSS_KRB5_TOK_HDR_LEN		/* encrypted hdr in v2 token */	\
+	+ GSS_KRB5_MAX_CKSUM_LEN	/* encryption hmac */		\
+	+ XDR_UNIT * 2			/* RPC verifier */		\
+	+ GSS_KRB5_TOK_HDR_LEN						\
+	+ GSS_KRB5_MAX_CKSUM_LEN)
+
 #define GSS_CRED_SLACK		(RPC_MAX_AUTH_SIZE * 2)
 /* length of a krb5 verifier (48), plus data added before arguments when
  * using integrity (two 4-byte integers): */
@@ -1042,6 +1058,7 @@ gss_create_new(const struct rpc_auth_create_args *args, struct rpc_clnt *clnt)
 		goto err_put_mech;
 	auth = &gss_auth->rpc_auth;
 	auth->au_cslack = GSS_CRED_SLACK >> 2;
+	BUILD_BUG_ON(GSS_KRB5_MAX_SLACK_NEEDED > RPC_MAX_AUTH_SIZE);
 	auth->au_rslack = GSS_KRB5_MAX_SLACK_NEEDED >> 2;
 	auth->au_verfsize = GSS_VERF_SLACK >> 2;
 	auth->au_ralign = GSS_VERF_SLACK >> 2;
diff --git a/net/sunrpc/auth_gss/gss_krb5_crypto.c b/net/sunrpc/auth_gss/gss_krb5_crypto.c
index 9112b3f87e72..986d8908d172 100644
--- a/net/sunrpc/auth_gss/gss_krb5_crypto.c
+++ b/net/sunrpc/auth_gss/gss_krb5_crypto.c
@@ -567,7 +567,6 @@ xdr_extend_head(struct xdr_buf *buf, unsigned int base, unsigned int shiftlen)
 	if (shiftlen == 0)
 		return 0;
 
-	BUILD_BUG_ON(GSS_KRB5_MAX_SLACK_NEEDED > RPC_MAX_AUTH_SIZE);
 	BUG_ON(shiftlen > RPC_MAX_AUTH_SIZE);
 
 	p = buf->head[0].iov_base + base;
diff --git a/net/sunrpc/auth_gss/gss_krb5_internal.h b/net/sunrpc/auth_gss/gss_krb5_internal.h
index c6d1bf876fe4..4bfb58a162a1 100644
--- a/net/sunrpc/auth_gss/gss_krb5_internal.h
+++ b/net/sunrpc/auth_gss/gss_krb5_internal.h
@@ -8,6 +8,82 @@
 #ifndef _NET_SUNRPC_AUTH_GSS_KRB5_INTERNAL_H
 #define _NET_SUNRPC_AUTH_GSS_KRB5_INTERNAL_H
 
+/*
+ * The RFCs often specify payload lengths in bits. This helper
+ * converts a specified bit-length to the number of octets/bytes.
+ */
+#define BITS2OCTETS(x)	((x) / 8)
+
+struct krb5_ctx;
+
+struct gss_krb5_enctype {
+	const u32		etype;		/* encryption (key) type */
+	const u32		ctype;		/* checksum type */
+	const char		*name;		/* "friendly" name */
+	const char		*encrypt_name;	/* crypto encrypt name */
+	const char		*aux_cipher;	/* aux encrypt cipher name */
+	const char		*cksum_name;	/* crypto checksum name */
+	const u16		signalg;	/* signing algorithm */
+	const u16		sealalg;	/* sealing algorithm */
+	const u32		cksumlength;	/* checksum length */
+	const u32		keyed_cksum;	/* is it a keyed cksum? */
+	const u32		keybytes;	/* raw key len, in bytes */
+	const u32		keylength;	/* protocol key length, in octets */
+	const u32		Kc_length;	/* checksum subkey length, in octets */
+	const u32		Ke_length;	/* encryption subkey length, in octets */
+	const u32		Ki_length;	/* integrity subkey length, in octets */
+
+	int (*import_ctx)(struct krb5_ctx *ctx, gfp_t gfp_mask);
+	int (*derive_key)(const struct gss_krb5_enctype *gk5e,
+			  const struct xdr_netobj *in,
+			  struct xdr_netobj *out,
+			  const struct xdr_netobj *label,
+			  gfp_t gfp_mask);
+	u32 (*encrypt)(struct krb5_ctx *kctx, u32 offset,
+		       struct xdr_buf *buf, struct page **pages);
+	u32 (*decrypt)(struct krb5_ctx *kctx, u32 offset, u32 len,
+		       struct xdr_buf *buf, u32 *headskip, u32 *tailskip);
+	u32 (*get_mic)(struct krb5_ctx *kctx, struct xdr_buf *text,
+		       struct xdr_netobj *token);
+	u32 (*verify_mic)(struct krb5_ctx *kctx, struct xdr_buf *message_buffer,
+			  struct xdr_netobj *read_token);
+	u32 (*wrap)(struct krb5_ctx *kctx, int offset,
+		    struct xdr_buf *buf, struct page **pages);
+	u32 (*unwrap)(struct krb5_ctx *kctx, int offset, int len,
+		      struct xdr_buf *buf, unsigned int *slack,
+		      unsigned int *align);
+};
+
+/* krb5_ctx flags definitions */
+#define KRB5_CTX_FLAG_INITIATOR         0x00000001
+#define KRB5_CTX_FLAG_CFX               0x00000002
+#define KRB5_CTX_FLAG_ACCEPTOR_SUBKEY   0x00000004
+
+struct krb5_ctx {
+	int			initiate; /* 1 = initiating, 0 = accepting */
+	u32			enctype;
+	u32			flags;
+	const struct gss_krb5_enctype *gk5e; /* enctype-specific info */
+	struct crypto_sync_skcipher *enc;
+	struct crypto_sync_skcipher *seq;
+	struct crypto_sync_skcipher *acceptor_enc;
+	struct crypto_sync_skcipher *initiator_enc;
+	struct crypto_sync_skcipher *acceptor_enc_aux;
+	struct crypto_sync_skcipher *initiator_enc_aux;
+	struct crypto_ahash	*acceptor_sign;
+	struct crypto_ahash	*initiator_sign;
+	struct crypto_ahash	*initiator_integ;
+	struct crypto_ahash	*acceptor_integ;
+	u8			Ksess[GSS_KRB5_MAX_KEYLEN]; /* session key */
+	u8			cksum[GSS_KRB5_MAX_KEYLEN];
+	atomic_t		seq_send;
+	atomic64_t		seq_send64;
+	time64_t		endtime;
+	atomic64_t		confounder;
+	siphash_key_t		confkey;
+	struct xdr_netobj	mech_used;
+};
+
 /*
  * GSS Kerberos 5 mechanism Per-Message calls.
  */
@@ -96,8 +172,19 @@ static inline int krb5_derive_key(struct krb5_ctx *kctx,
 	return gk5e->derive_key(gk5e, inkey, outkey, &label, gfp_mask);
 }
 
+s32 krb5_make_seq_num(struct krb5_ctx *kctx, struct crypto_sync_skcipher *key,
+		      int direction, u32 seqnum, unsigned char *cksum,
+		      unsigned char *buf);
+
+s32 krb5_get_seq_num(struct krb5_ctx *kctx, unsigned char *cksum,
+		     unsigned char *buf, int *direction, u32 *seqnum);
+
 void krb5_make_confounder(struct krb5_ctx *kctx, u8 *p, int conflen);
 
+u32 make_checksum(struct krb5_ctx *kctx, char *header, int hdrlen,
+		  struct xdr_buf *body, int body_offset, u8 *cksumkey,
+		  unsigned int usage, struct xdr_netobj *cksumout);
+
 u32 gss_krb5_checksum(struct crypto_ahash *tfm, char *header, int hdrlen,
 		      const struct xdr_buf *body, int body_offset,
 		      struct xdr_netobj *cksumout);
@@ -108,6 +195,16 @@ u32 krb5_encrypt(struct crypto_sync_skcipher *key, void *iv, void *in,
 u32 krb5_decrypt(struct crypto_sync_skcipher *key, void *iv, void *in,
 		 void *out, int length);
 
+int xdr_extend_head(struct xdr_buf *buf, unsigned int base,
+		    unsigned int shiftlen);
+
+int gss_encrypt_xdr_buf(struct crypto_sync_skcipher *tfm,
+			struct xdr_buf *outbuf, int offset,
+			struct page **pages);
+
+int gss_decrypt_xdr_buf(struct crypto_sync_skcipher *tfm,
+			struct xdr_buf *inbuf, int offset);
+
 u32 gss_krb5_aes_encrypt(struct krb5_ctx *kctx, u32 offset,
 			 struct xdr_buf *buf, struct page **pages);
 


