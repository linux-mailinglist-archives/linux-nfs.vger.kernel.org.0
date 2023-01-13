Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2F59669C4C
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jan 2023 16:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjAMPb0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Jan 2023 10:31:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjAMPax (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Jan 2023 10:30:53 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E73727AE
        for <linux-nfs@vger.kernel.org>; Fri, 13 Jan 2023 07:24:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DE02BCE20EA
        for <linux-nfs@vger.kernel.org>; Fri, 13 Jan 2023 15:24:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D41C433F0;
        Fri, 13 Jan 2023 15:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673623447;
        bh=0LPtWDYopNVHoUKc6pVsLieucuZ7BDcBrs7Av4pM8OE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=FvyG942YYoAqaeiac5OQ7O8yeazU2ivOAnFsz1ZOQfz1yZ7NpWWtvy5fHITdsJq0r
         pLUoVPQjOIxXFuNzd+9Ou88xQ1GIYH+UxlB02xieC35BSC+t7OBWP+aThVqE/3bUKA
         Dt3Jh40ihPRTnWsfVUviMiXF/PDomZy6yF1qDlwvyRn432noxowTj4WvZegSbUeFv9
         tjQDea2N4gNKPZIn09rhK5H9C7+p4CKc6I+rBwEWbYdwjJ/LIZ6tgGRauOiBnWr32n
         o9MwBoM0rFDqcTt7MbHxn9Km0upKAQ08241nYypRkIVVYi97Fr3cUBqQE2/JpnktWG
         sSqwDpvK/5WoA==
Subject: [PATCH v1 25/41] SUNRPC: Add RFC 8009 encryption and decryption
 functions
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, simo@redhat.com
Date:   Fri, 13 Jan 2023 10:24:05 -0500
Message-ID: <167362344597.8960.11361135105165588212.stgit@bazille.1015granger.net>
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

RFC 8009 enctypes use different crypt formulae than previous
Kerberos 5 encryption types. Section 1 of RFC 8009 explains the
reason for this change:

> The new types conform to the framework specified in [RFC3961],
> but do not use the simplified profile, as the simplified profile
> is not compliant with modern cryptographic best practices such as
> calculating Message Authentication Codes (MACs) over ciphertext
> rather than plaintext.

Add new .encrypt and .decrypt functions to handle this variation.

The new approach described above is referred to as Encrypt-then-MAC
(or EtM). Hence the names of the new functions added here are
prefixed with "krb5_etm_".

A critical second difference with previous crypt formulae is that
the cipher state is included in the computed HMAC. Note however that
for RPCSEC, the initial cipher state is easy to compute on both
initiator and acceptor because it is always all zeroes.

Tested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_krb5_crypto.c   |  227 +++++++++++++++++++++++++++++++
 net/sunrpc/auth_gss/gss_krb5_internal.h |    6 +
 net/sunrpc/auth_gss/gss_krb5_mech.c     |    4 +
 3 files changed, 237 insertions(+)

diff --git a/net/sunrpc/auth_gss/gss_krb5_crypto.c b/net/sunrpc/auth_gss/gss_krb5_crypto.c
index 27bfb8c6b931..9112b3f87e72 100644
--- a/net/sunrpc/auth_gss/gss_krb5_crypto.c
+++ b/net/sunrpc/auth_gss/gss_krb5_crypto.c
@@ -862,3 +862,230 @@ gss_krb5_aes_decrypt(struct krb5_ctx *kctx, u32 offset, u32 len,
 		ret = GSS_S_FAILURE;
 	return ret;
 }
+
+static u32
+krb5_etm_checksum(struct crypto_sync_skcipher *cipher,
+		  struct crypto_ahash *tfm, const struct xdr_buf *body,
+		  int body_offset, struct xdr_netobj *cksumout)
+{
+	unsigned int ivsize = crypto_sync_skcipher_ivsize(cipher);
+	struct ahash_request *req;
+	struct scatterlist sg[1];
+	u8 *iv, *checksumdata;
+	int err = -ENOMEM;
+
+	checksumdata = kmalloc(crypto_ahash_digestsize(tfm), GFP_KERNEL);
+	if (!checksumdata)
+		return GSS_S_FAILURE;
+	/* For RPCSEC, the "initial cipher state" is always all zeroes. */
+	iv = kzalloc(ivsize, GFP_KERNEL);
+	if (!iv)
+		goto out_free_mem;
+
+	req = ahash_request_alloc(tfm, GFP_KERNEL);
+	if (!req)
+		goto out_free_mem;
+	ahash_request_set_callback(req, CRYPTO_TFM_REQ_MAY_SLEEP, NULL, NULL);
+	err = crypto_ahash_init(req);
+	if (err)
+		goto out_free_ahash;
+
+	sg_init_one(sg, iv, ivsize);
+	ahash_request_set_crypt(req, sg, NULL, ivsize);
+	err = crypto_ahash_update(req);
+	if (err)
+		goto out_free_ahash;
+	err = xdr_process_buf(body, body_offset, body->len - body_offset,
+			      checksummer, req);
+	if (err)
+		goto out_free_ahash;
+
+	ahash_request_set_crypt(req, NULL, checksumdata, 0);
+	err = crypto_ahash_final(req);
+	if (err)
+		goto out_free_ahash;
+	memcpy(cksumout->data, checksumdata, cksumout->len);
+
+out_free_ahash:
+	ahash_request_free(req);
+out_free_mem:
+	kfree(iv);
+	kfree_sensitive(checksumdata);
+	return err ? GSS_S_FAILURE : GSS_S_COMPLETE;
+}
+
+/**
+ * krb5_etm_encrypt - Encrypt using the RFC 8009 rules
+ * @kctx: Kerberos context
+ * @offset: starting offset of the payload, in bytes
+ * @buf: OUT: send buffer to contain the encrypted payload
+ * @pages: plaintext payload
+ *
+ * The main difference with aes_encrypt is that "The HMAC is
+ * calculated over the cipher state concatenated with the AES
+ * output, instead of being calculated over the confounder and
+ * plaintext.  This allows the message receiver to verify the
+ * integrity of the message before decrypting the message."
+ *
+ * RFC 8009 Section 5:
+ *
+ * encryption function: as follows, where E() is AES encryption in
+ * CBC-CS3 mode, and h is the size of truncated HMAC (128 bits or
+ * 192 bits as described above).
+ *
+ *    N = random value of length 128 bits (the AES block size)
+ *    IV = cipher state
+ *    C = E(Ke, N | plaintext, IV)
+ *    H = HMAC(Ki, IV | C)
+ *    ciphertext = C | H[1..h]
+ *
+ * This encryption formula provides AEAD EtM with key separation.
+ *
+ * Return values:
+ *   %GSS_S_COMPLETE: Encryption successful
+ *   %GSS_S_FAILURE: Encryption failed
+ */
+u32
+krb5_etm_encrypt(struct krb5_ctx *kctx, u32 offset,
+		 struct xdr_buf *buf, struct page **pages)
+{
+	struct crypto_sync_skcipher *cipher, *aux_cipher;
+	struct crypto_ahash *ahash;
+	struct xdr_netobj hmac;
+	unsigned int conflen;
+	u8 *ecptr;
+	u32 err;
+
+	if (kctx->initiate) {
+		cipher = kctx->initiator_enc;
+		aux_cipher = kctx->initiator_enc_aux;
+		ahash = kctx->initiator_integ;
+	} else {
+		cipher = kctx->acceptor_enc;
+		aux_cipher = kctx->acceptor_enc_aux;
+		ahash = kctx->acceptor_integ;
+	}
+	conflen = crypto_sync_skcipher_blocksize(cipher);
+
+	offset += GSS_KRB5_TOK_HDR_LEN;
+	if (xdr_extend_head(buf, offset, conflen))
+		return GSS_S_FAILURE;
+	krb5_make_confounder(kctx, buf->head[0].iov_base + offset, conflen);
+	offset -= GSS_KRB5_TOK_HDR_LEN;
+
+	if (buf->tail[0].iov_base) {
+		ecptr = buf->tail[0].iov_base + buf->tail[0].iov_len;
+	} else {
+		buf->tail[0].iov_base = buf->head[0].iov_base
+							+ buf->head[0].iov_len;
+		buf->tail[0].iov_len = 0;
+		ecptr = buf->tail[0].iov_base;
+	}
+
+	memcpy(ecptr, buf->head[0].iov_base + offset, GSS_KRB5_TOK_HDR_LEN);
+	buf->tail[0].iov_len += GSS_KRB5_TOK_HDR_LEN;
+	buf->len += GSS_KRB5_TOK_HDR_LEN;
+
+	err = krb5_cbc_cts_encrypt(cipher, aux_cipher,
+				   offset + GSS_KRB5_TOK_HDR_LEN,
+				   buf, pages);
+	if (err)
+		return GSS_S_FAILURE;
+
+	hmac.data = buf->tail[0].iov_base + buf->tail[0].iov_len;
+	hmac.len = kctx->gk5e->cksumlength;
+	err = krb5_etm_checksum(cipher, ahash,
+				buf, offset + GSS_KRB5_TOK_HDR_LEN, &hmac);
+	if (err)
+		goto out_err;
+	buf->tail[0].iov_len += kctx->gk5e->cksumlength;
+	buf->len += kctx->gk5e->cksumlength;
+
+	return GSS_S_COMPLETE;
+
+out_err:
+	return GSS_S_FAILURE;
+}
+
+/**
+ * krb5_etm_decrypt - Decrypt using the RFC 8009 rules
+ * @kctx: Kerberos context
+ * @offset: starting offset of the ciphertext, in bytes
+ * @len:
+ * @buf:
+ * @headskip: OUT: the enctype's confounder length, in octets
+ * @tailskip: OUT: the enctype's HMAC length, in octets
+ *
+ * RFC 8009 Section 5:
+ *
+ * decryption function: as follows, where D() is AES decryption in
+ * CBC-CS3 mode, and h is the size of truncated HMAC.
+ *
+ *    (C, H) = ciphertext
+ *        (Note: H is the last h bits of the ciphertext.)
+ *    IV = cipher state
+ *    if H != HMAC(Ki, IV | C)[1..h]
+ *        stop, report error
+ *    (N, P) = D(Ke, C, IV)
+ *
+ * Return values:
+ *   %GSS_S_COMPLETE: Decryption successful
+ *   %GSS_S_BAD_SIG: computed HMAC != received HMAC
+ *   %GSS_S_FAILURE: Decryption failed
+ */
+u32
+krb5_etm_decrypt(struct krb5_ctx *kctx, u32 offset, u32 len,
+		 struct xdr_buf *buf, u32 *headskip, u32 *tailskip)
+{
+	struct crypto_sync_skcipher *cipher, *aux_cipher;
+	u8 our_hmac[GSS_KRB5_MAX_CKSUM_LEN];
+	u8 pkt_hmac[GSS_KRB5_MAX_CKSUM_LEN];
+	struct xdr_netobj our_hmac_obj;
+	struct crypto_ahash *ahash;
+	struct xdr_buf subbuf;
+	u32 ret = 0;
+
+	if (kctx->initiate) {
+		cipher = kctx->acceptor_enc;
+		aux_cipher = kctx->acceptor_enc_aux;
+		ahash = kctx->acceptor_integ;
+	} else {
+		cipher = kctx->initiator_enc;
+		aux_cipher = kctx->initiator_enc_aux;
+		ahash = kctx->initiator_integ;
+	}
+
+	/* Extract the ciphertext into @subbuf. */
+	xdr_buf_subsegment(buf, &subbuf, offset + GSS_KRB5_TOK_HDR_LEN,
+			   (len - offset - GSS_KRB5_TOK_HDR_LEN -
+			    kctx->gk5e->cksumlength));
+
+	our_hmac_obj.data = our_hmac;
+	our_hmac_obj.len = kctx->gk5e->cksumlength;
+	ret = krb5_etm_checksum(cipher, ahash, &subbuf, 0, &our_hmac_obj);
+	if (ret)
+		goto out_err;
+	ret = read_bytes_from_xdr_buf(buf, len - kctx->gk5e->cksumlength,
+				      pkt_hmac, kctx->gk5e->cksumlength);
+	if (ret)
+		goto out_err;
+	if (crypto_memneq(pkt_hmac, our_hmac, kctx->gk5e->cksumlength) != 0) {
+		ret = GSS_S_BAD_SIG;
+		goto out_err;
+	}
+
+	ret = krb5_cbc_cts_decrypt(cipher, aux_cipher, 0, &subbuf);
+	if (ret) {
+		ret = GSS_S_FAILURE;
+		goto out_err;
+	}
+
+	*headskip = crypto_sync_skcipher_blocksize(cipher);
+	*tailskip = kctx->gk5e->cksumlength;
+	return GSS_S_COMPLETE;
+
+out_err:
+	if (ret != GSS_S_BAD_SIG)
+		ret = GSS_S_FAILURE;
+	return ret;
+}
diff --git a/net/sunrpc/auth_gss/gss_krb5_internal.h b/net/sunrpc/auth_gss/gss_krb5_internal.h
index 818a5fd89a8f..d16563afaeae 100644
--- a/net/sunrpc/auth_gss/gss_krb5_internal.h
+++ b/net/sunrpc/auth_gss/gss_krb5_internal.h
@@ -108,4 +108,10 @@ u32 gss_krb5_aes_encrypt(struct krb5_ctx *kctx, u32 offset,
 u32 gss_krb5_aes_decrypt(struct krb5_ctx *kctx, u32 offset, u32 len,
 			 struct xdr_buf *buf, u32 *plainoffset, u32 *plainlen);
 
+u32 krb5_etm_encrypt(struct krb5_ctx *kctx, u32 offset, struct xdr_buf *buf,
+		     struct page **pages);
+
+u32 krb5_etm_decrypt(struct krb5_ctx *kctx, u32 offset, u32 len,
+		     struct xdr_buf *buf, u32 *headskip, u32 *tailskip);
+
 #endif /* _NET_SUNRPC_AUTH_GSS_KRB5_INTERNAL_H */
diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index 95a041a80e21..fa0b5197fe32 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -167,6 +167,8 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 
 		.import_ctx	= gss_krb5_import_ctx_v2,
 		.derive_key	= krb5_kdf_hmac_sha2,
+		.encrypt	= krb5_etm_encrypt,
+		.decrypt	= krb5_etm_decrypt,
 
 		.get_mic	= gss_krb5_get_mic_v2,
 		.verify_mic	= gss_krb5_verify_mic_v2,
@@ -192,6 +194,8 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 
 		.import_ctx	= gss_krb5_import_ctx_v2,
 		.derive_key	= krb5_kdf_hmac_sha2,
+		.encrypt	= krb5_etm_encrypt,
+		.decrypt	= krb5_etm_decrypt,
 
 		.get_mic	= gss_krb5_get_mic_v2,
 		.verify_mic	= gss_krb5_verify_mic_v2,


