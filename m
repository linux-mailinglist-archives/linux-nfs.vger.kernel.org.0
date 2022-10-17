Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8632D601AA0
	for <lists+linux-nfs@lfdr.de>; Mon, 17 Oct 2022 22:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiJQUvx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 17 Oct 2022 16:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiJQUvw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 17 Oct 2022 16:51:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBCADF88
        for <linux-nfs@vger.kernel.org>; Mon, 17 Oct 2022 13:51:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED8656118E
        for <linux-nfs@vger.kernel.org>; Mon, 17 Oct 2022 20:51:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E7A3C433D6;
        Mon, 17 Oct 2022 20:51:50 +0000 (UTC)
Subject: [PATCH RFC] SUNRPC: Add support for RFC 8009 encryption types
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, simo@redhat.com
Date:   Mon, 17 Oct 2022 16:51:48 -0400
Message-ID: <166603945959.14665.12642421516208884.stgit@manet.1015granger.net>
User-Agent: StGit/1.5.dev2+g9ce680a5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

These new encryption types provide stronger security by replacing
the deprecated SHA-1 algorithm with SHA-2 in several key areas.
There already appears to be support for these new types in Linux
user space libraries and some KDCs.

Quoting from RFC 8009 Section 1:
> The encryption and checksum types defined in this document are
> intended to support environments that desire to use SHA-256 or
> SHA-384 (defined in [FIPS180]) as the hash algorithm.  Differences
> between the encryption and checksum types defined in this document
> and the pre-existing Kerberos AES encryption and checksum types
> specified in [RFC3962] are:
>
> o The pseudorandom function (PRF) used by PBKDF2 is HMAC-SHA-256 or
>   HMAC-SHA-384.
>
> o A key derivation function from [SP800-108] using the SHA-256 or
>   SHA-384 hash algorithm is used to produce keys for encryption,
>   integrity protection, and checksum operations.
>
> o The HMAC is calculated over the cipher state concatenated with
>   the AES output, instead of being calculated over the confounder
>   and plaintext.  This allows the message receiver to verify the
>   integrity of the message before decrypting the message.
>
> o The HMAC algorithm uses the SHA-256 or SHA-384 hash algorithm for
>   integrity protection and checksum operations.

I suspect that the third bullet point means that some code changes
(rather than just new encryption type parameters) will be needed.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---

The purpose of this RFC is to figure out the code. Testing and
resolving interoperability issues amongst clients and servers that
might or might not support these new enctypes will be the next step.

This patch has been only been compile-tested for now.

 include/linux/sunrpc/gss_krb5.h          |   16 +++++++++
 include/linux/sunrpc/gss_krb5_enctypes.h |   22 +++++++------
 net/sunrpc/auth_gss/gss_krb5_mech.c      |   52 ++++++++++++++++++++++++++++++
 net/sunrpc/auth_gss/gss_krb5_seal.c      |    2 +
 net/sunrpc/auth_gss/gss_krb5_unseal.c    |    2 +
 net/sunrpc/auth_gss/gss_krb5_wrap.c      |    4 ++
 6 files changed, 87 insertions(+), 11 deletions(-)

diff --git a/include/linux/sunrpc/gss_krb5.h b/include/linux/sunrpc/gss_krb5.h
index 91f43d86879d..72ded91b7a86 100644
--- a/include/linux/sunrpc/gss_krb5.h
+++ b/include/linux/sunrpc/gss_krb5.h
@@ -150,6 +150,12 @@ enum seal_alg {
 	SEAL_ALG_DES3KD = 0x0002
 };
 
+/*
+ * These values are assigned by IANA and published via the
+ * subregistry at the link below:
+ *
+ * https://www.iana.org/assignments/kerberos-parameters/kerberos-parameters.xhtml#kerberos-parameters-2
+ */
 #define CKSUMTYPE_CRC32			0x0001
 #define CKSUMTYPE_RSA_MD4		0x0002
 #define CKSUMTYPE_RSA_MD4_DES		0x0003
@@ -160,6 +166,8 @@ enum seal_alg {
 #define CKSUMTYPE_HMAC_SHA1_DES3	0x000c
 #define CKSUMTYPE_HMAC_SHA1_96_AES128   0x000f
 #define CKSUMTYPE_HMAC_SHA1_96_AES256   0x0010
+#define CKSUMTYPE_HMAC_SHA256_128_AES128	0x0013
+#define CKSUMTYPE_HMAC_SHA384_192_AES256	0x0014
 #define CKSUMTYPE_HMAC_MD5_ARCFOUR      -138 /* Microsoft md5 hmac cksumtype */
 
 /* from gssapi_err_krb5.h */
@@ -180,19 +188,25 @@ enum seal_alg {
 
 /* per Kerberos v5 protocol spec crypto types from the wire. 
  * these get mapped to linux kernel crypto routines.  
+ *
+ * These values are assigned by IANA and published via the
+ * subregistry at the link below:
+ *
+ * https://www.iana.org/assignments/kerberos-parameters/kerberos-parameters.xhtml#kerberos-parameters-1
  */
 #define ENCTYPE_NULL            0x0000
 #define ENCTYPE_DES_CBC_CRC     0x0001	/* DES cbc mode with CRC-32 */
 #define ENCTYPE_DES_CBC_MD4     0x0002	/* DES cbc mode with RSA-MD4 */
 #define ENCTYPE_DES_CBC_MD5     0x0003	/* DES cbc mode with RSA-MD5 */
 #define ENCTYPE_DES_CBC_RAW     0x0004	/* DES cbc mode raw */
-/* XXX deprecated? */
 #define ENCTYPE_DES3_CBC_SHA    0x0005	/* DES-3 cbc mode with NIST-SHA */
 #define ENCTYPE_DES3_CBC_RAW    0x0006	/* DES-3 cbc mode raw */
 #define ENCTYPE_DES_HMAC_SHA1   0x0008
 #define ENCTYPE_DES3_CBC_SHA1   0x0010
 #define ENCTYPE_AES128_CTS_HMAC_SHA1_96 0x0011
 #define ENCTYPE_AES256_CTS_HMAC_SHA1_96 0x0012
+#define ENCTYPE_AES128_CTS_HMAC_SHA256_128	0x0013
+#define ENCTYPE_AES256_CTS_HMAC_SHA384_192	0x0014
 #define ENCTYPE_ARCFOUR_HMAC            0x0017
 #define ENCTYPE_ARCFOUR_HMAC_EXP        0x0018
 #define ENCTYPE_UNKNOWN         0x01ff
diff --git a/include/linux/sunrpc/gss_krb5_enctypes.h b/include/linux/sunrpc/gss_krb5_enctypes.h
index 87eea679d750..82aa74f1f2cf 100644
--- a/include/linux/sunrpc/gss_krb5_enctypes.h
+++ b/include/linux/sunrpc/gss_krb5_enctypes.h
@@ -15,11 +15,13 @@
 /*
  * NB: This list includes DES3_CBC_SHA1, which was deprecated by RFC 8429.
  *
- * ENCTYPE_AES256_CTS_HMAC_SHA1_96
- * ENCTYPE_AES128_CTS_HMAC_SHA1_96
- * ENCTYPE_DES3_CBC_SHA1
+ * ENCTYPE_AES128_CTS_HMAC_SHA256_192	20
+ * ENCTYPE_AES128_CTS_HMAC_SHA256_128	19
+ * ENCTYPE_AES256_CTS_HMAC_SHA1_96	18
+ * ENCTYPE_AES128_CTS_HMAC_SHA1_96	17
+ * ENCTYPE_DES3_CBC_SHA1		16
  */
-#define KRB5_SUPPORTED_ENCTYPES "18,17,16"
+#define KRB5_SUPPORTED_ENCTYPES "20,19,18,17,16"
 
 #else	/* CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES */
 
@@ -27,12 +29,12 @@
  * NB: This list includes encryption types that were deprecated
  * by RFC 8429 and RFC 6649.
  *
- * ENCTYPE_AES256_CTS_HMAC_SHA1_96
- * ENCTYPE_AES128_CTS_HMAC_SHA1_96
- * ENCTYPE_DES3_CBC_SHA1
- * ENCTYPE_DES_CBC_MD5
- * ENCTYPE_DES_CBC_CRC
- * ENCTYPE_DES_CBC_MD4
+ * ENCTYPE_AES256_CTS_HMAC_SHA1_96	18
+ * ENCTYPE_AES128_CTS_HMAC_SHA1_96	17
+ * ENCTYPE_DES3_CBC_SHA1		16
+ * ENCTYPE_DES_CBC_MD5			3
+ * ENCTYPE_DES_CBC_CRC			1
+ * ENCTYPE_DES_CBC_MD4			2
  */
 #define KRB5_SUPPORTED_ENCTYPES "18,17,16,3,1,2"
 
diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index 1c092b05c2bb..2c5a11693e55 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -120,6 +120,54 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 	  .cksumlength = 12,
 	  .keyed_cksum = 1,
 	},
+#ifdef CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES
+	/*
+	 * AES-128 with SHA-2. See RFC 8009.
+	 */
+	{
+		.etype		= ENCTYPE_AES128_CTS_HMAC_SHA256_128,
+		.ctype		= CKSUMTYPE_HMAC_SHA256_128_AES128,
+		.name		= "aes128-cts-hmac-sha256-128",
+		.encrypt_name	= "cts(cbc(aes))",
+		.cksum_name	= "hmac(sha256)",
+		.encrypt	= krb5_encrypt,
+		.decrypt	= krb5_decrypt,
+		.mk_key		= gss_krb5_aes_make_key,
+		.encrypt_v2	= gss_krb5_aes_encrypt,
+		.decrypt_v2	= gss_krb5_aes_decrypt,
+		.signalg	= -1,
+		.sealalg	= -1,
+		.keybytes	= 16,
+		.keylength	= 16,
+		.blocksize	= 16,
+		.conflen	= 16,
+		.cksumlength	= 16,
+		.keyed_cksum	= 1,
+	}
+	/*
+	 * AES-256 with SHA-3. See RFC 8009.
+	 */
+	{
+		.etype		= ENCTYPE_AES256_CTS_HMAC_SHA384_192,
+		.ctype		= CKSUMTYPE_HMAC_SHA384_192_AES256,
+		.name		= "aes256-cts-hmac-sha384-192",
+		.encrypt_name	= "cts(cbc(aes))",
+		.cksum_name	= "hmac(sha384)",
+		.encrypt	= krb5_encrypt,
+		.decrypt	= krb5_decrypt,
+		.mk_key		= gss_krb5_aes_make_key,
+		.encrypt_v2	= gss_krb5_aes_encrypt,
+		.decrypt_v2	= gss_krb5_aes_decrypt,
+		.signalg	= -1,
+		.sealalg	= -1,
+		.keybytes	= 32,
+		.keylength	= 32,
+		.blocksize	= 16,
+		.conflen	= 16,
+		.cksumlength	= 24,
+		.keyed_cksum	= 1,
+	}
+#endif /* CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES */
 };
 
 static const int num_supported_enctypes =
@@ -440,6 +488,8 @@ context_derive_keys_new(struct krb5_ctx *ctx, gfp_t gfp_mask)
 	switch (ctx->enctype) {
 	case ENCTYPE_AES128_CTS_HMAC_SHA1_96:
 	case ENCTYPE_AES256_CTS_HMAC_SHA1_96:
+	case ENCTYPE_AES128_CTS_HMAC_SHA256_128:
+	case ENCTYPE_AES256_CTS_HMAC_SHA384_192:
 		ctx->initiator_enc_aux =
 			context_v2_alloc_cipher(ctx, "cbc(aes)",
 						ctx->initiator_seal);
@@ -531,6 +581,8 @@ gss_import_v2_context(const void *p, const void *end, struct krb5_ctx *ctx,
 		return context_derive_keys_des3(ctx, gfp_mask);
 	case ENCTYPE_AES128_CTS_HMAC_SHA1_96:
 	case ENCTYPE_AES256_CTS_HMAC_SHA1_96:
+	case ENCTYPE_AES128_CTS_HMAC_SHA256_128:
+	case ENCTYPE_AES256_CTS_HMAC_SHA384_192:
 		return context_derive_keys_new(ctx, gfp_mask);
 	default:
 		return -EINVAL;
diff --git a/net/sunrpc/auth_gss/gss_krb5_seal.c b/net/sunrpc/auth_gss/gss_krb5_seal.c
index 33061417ec97..252bc30e09aa 100644
--- a/net/sunrpc/auth_gss/gss_krb5_seal.c
+++ b/net/sunrpc/auth_gss/gss_krb5_seal.c
@@ -217,6 +217,8 @@ gss_get_mic_kerberos(struct gss_ctx *gss_ctx, struct xdr_buf *text,
 		return gss_get_mic_v1(ctx, text, token);
 	case ENCTYPE_AES128_CTS_HMAC_SHA1_96:
 	case ENCTYPE_AES256_CTS_HMAC_SHA1_96:
+	case ENCTYPE_AES128_CTS_HMAC_SHA256_128:
+	case ENCTYPE_AES256_CTS_HMAC_SHA384_192:
 		return gss_get_mic_v2(ctx, text, token);
 	}
 }
diff --git a/net/sunrpc/auth_gss/gss_krb5_unseal.c b/net/sunrpc/auth_gss/gss_krb5_unseal.c
index ba04e3ec970a..58d7b49a6a9a 100644
--- a/net/sunrpc/auth_gss/gss_krb5_unseal.c
+++ b/net/sunrpc/auth_gss/gss_krb5_unseal.c
@@ -221,6 +221,8 @@ gss_verify_mic_kerberos(struct gss_ctx *gss_ctx,
 		return gss_verify_mic_v1(ctx, message_buffer, read_token);
 	case ENCTYPE_AES128_CTS_HMAC_SHA1_96:
 	case ENCTYPE_AES256_CTS_HMAC_SHA1_96:
+	case ENCTYPE_AES128_CTS_HMAC_SHA256_128:
+	case ENCTYPE_AES256_CTS_HMAC_SHA384_192:
 		return gss_verify_mic_v2(ctx, message_buffer, read_token);
 	}
 }
diff --git a/net/sunrpc/auth_gss/gss_krb5_wrap.c b/net/sunrpc/auth_gss/gss_krb5_wrap.c
index 5f96e75f9eec..36659ab5bd58 100644
--- a/net/sunrpc/auth_gss/gss_krb5_wrap.c
+++ b/net/sunrpc/auth_gss/gss_krb5_wrap.c
@@ -571,6 +571,8 @@ gss_wrap_kerberos(struct gss_ctx *gctx, int offset,
 		return gss_wrap_kerberos_v1(kctx, offset, buf, pages);
 	case ENCTYPE_AES128_CTS_HMAC_SHA1_96:
 	case ENCTYPE_AES256_CTS_HMAC_SHA1_96:
+	case ENCTYPE_AES128_CTS_HMAC_SHA256_128:
+	case ENCTYPE_AES256_CTS_HMAC_SHA384_192:
 		return gss_wrap_kerberos_v2(kctx, offset, buf, pages);
 	}
 }
@@ -590,6 +592,8 @@ gss_unwrap_kerberos(struct gss_ctx *gctx, int offset,
 					      &gctx->slack, &gctx->align);
 	case ENCTYPE_AES128_CTS_HMAC_SHA1_96:
 	case ENCTYPE_AES256_CTS_HMAC_SHA1_96:
+	case ENCTYPE_AES128_CTS_HMAC_SHA256_128:
+	case ENCTYPE_AES256_CTS_HMAC_SHA384_192:
 		return gss_unwrap_kerberos_v2(kctx, offset, len, buf,
 					      &gctx->slack, &gctx->align);
 	}


