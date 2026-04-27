Return-Path: <linux-nfs+bounces-21191-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMaHN5Vs72kcBQEAu9opvQ
	(envelope-from <linux-nfs+bounces-21191-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 16:03:01 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 768B3473F26
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 16:03:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DDD6F3085CD5
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 13:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E7B3D9DAE;
	Mon, 27 Apr 2026 13:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sEfyC36Q"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D35A93D9DA3;
	Mon, 27 Apr 2026 13:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777297887; cv=none; b=cy5ctE0AzEdwzlbBYhvQ71OFzXyScZtKQIqzg0Gu861u4sv9oYzWw70mLh0VWvROlzRBu7SFWKFjqZs6RSIHrIZpF//gaxAk6MwJM69xvL2pQG3OJUWAYwwEe8+5evN3KdkZmzUMhupcQ76bj1mItJWWAdGPysS8JP84bL4YPVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777297887; c=relaxed/simple;
	bh=6KyOy2T3eYoGeppXBLzlNx80JZ9530iBLIsDriP4a9c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GLk9M6KYOm9w8+LZqucKI1DYxNzOtkOOkvKwfmmg2og+eVMpdGkQyQKIG0qkk+H5YLpkr9JAFpPEXWTV42iEG9HnR3rlVZdP3YJFVh2O9YUXhh3HgJRGXM4k/FgZuxoF83eBtJPLrIqvJbPuwfiIxhTBBnPwLN5hPdK3gHqDlII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sEfyC36Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E03C2BCB4;
	Mon, 27 Apr 2026 13:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777297887;
	bh=6KyOy2T3eYoGeppXBLzlNx80JZ9530iBLIsDriP4a9c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sEfyC36Qz2/oWkDm26LVad8aDqbDuSctBg1WUUO6d3Qp4J6pLRAuK/MXUEkN639pl
	 tcun7841sObscHUt6/vg600Px6zG0TvHe30K2mAzulZjirWNOTis6pIsWQbx/4vUbw
	 fIV+3uLYmYsktT0YlSYUVrvyNQnvLwnNWasuwWS4b7WFR/BN4nnGxONZOYJgPJOetN
	 CRod3JmKgWt1xQtap54ml1x0DFVJhqEBgU+a+SyaKnDyW2HDynHjGbGrCleHteC/qM
	 eWA2+dquvJO5jOShyvPPvbSz5bAlA9smnvhVlLZi1Okow/wU0TA14DvlB/dKbF/X5x
	 bVDLmc0Oz6coA==
From: Chuck Lever <cel@kernel.org>
Date: Mon, 27 Apr 2026 09:50:58 -0400
Subject: [PATCH 14/18] SUNRPC: Remove legacy skcipher/ahash handles from
 krb5_ctx
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-crypto-krb5-api-v1-14-1fc1253b64c0@oracle.com>
References: <20260427-crypto-krb5-api-v1-0-1fc1253b64c0@oracle.com>
In-Reply-To: <20260427-crypto-krb5-api-v1-0-1fc1253b64c0@oracle.com>
To: Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
 NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>, 
 Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-nfs@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
 David Howells <dhowells@redhat.com>, Simo Sorce <simo@redhat.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=20275;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=tt5djmPJwtjRxGMUZFCmvtMnBOcV818KrBwWmq6LXfw=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp72nGKMMKPr82CC2eZgXLebDmujBtv7G3JcGLd
 UXYny2aIPWJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCae9pxgAKCRAzarMzb2Z/
 l/Z1EACBLZRMyQ7a13b2OTDX+IN2QrItQrNvMSAlKvipizivdFX0D30vPOokc4MgivPF8/ua8lx
 8jTsII4dXyIihVTvf5ZrygcqzN6tz6w5na+7oONZe3UFZIxbPeiblawteApZ8V+lTXVjREnkoQT
 bQaYQfvUvovr/KrvI2SZKeDRnWDL9matE0MY6akSnKoTovRb/lL08N/WYqrV1+V4cvcfRJfkiTX
 dSQxG9yX2ve3iECeMWm9VIJuc1EwFmfuEDETGEMqlz7dtrO+uR4rUWjd9wFyGC9mgXxUzPeMsdX
 XvGoRncN3AGjn6rnS2St7YTNoiRPX1DHVtSrci4ScxLl8TCioctdraeOwARWuxTLcNKGQHXRqWC
 hLSubuN/Z+1nRT/qAS8eAD1nflLTdvc5u/TgncffE6NyzECS6Bqfn91ste6ca9Zt/WtdXj2efJO
 MmOJ7XX7nJ+VWWDa+DTAgIAiWA3uC9QX3gxmZ3BjP5FTxZovf77re2FkB3/Tqnd96ujnpcXh25N
 eIxOes9zqk6IYyV2qIOahZo76UD18xLVJ6cT12pidrVIw9I/rCSWHGvbt5IDzJLnCelng2a/4FY
 MHqVwdvi00/Od0SgDWQuBCn3XI2vRKA0kSC5oq64w9nlz8I4SDC/lBAIHnl3wKwsPuhcAHh54ja
 eTgTpffqiGcHbUA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 768B3473F26
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21191-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,hmac.data:url,keyout.data:url,our_hmac_obj.data:url]

From: Chuck Lever <chuck.lever@oracle.com>

Previous patches switched all per-message crypto operations
(encrypt, decrypt, get_mic, verify_mic) from the internal
skcipher/ahash primitives to crypto/krb5 AEAD and shash
handles. The old crypto_sync_skcipher and crypto_ahash fields in
struct krb5_ctx are no longer referenced at runtime.

Remove the ten legacy handle fields from struct krb5_ctx
along with the key derivation and handle allocation code in
gss_krb5_import_ctx_v2() that populated them. Context import
now prepares only the four crypto/krb5 handles (two AEAD for
encryption, two shash for checksums). The corresponding cleanup
in gss_krb5_delete_sec_context() and the error path is likewise
reduced.

The krb5_derive_key() inline wrapper, gss_krb5_alloc_cipher_v2(),
and gss_krb5_alloc_hash_v2() become unused and are removed.
The per-enctype encrypt/decrypt functions (gss_krb5_aes_encrypt,
gss_krb5_aes_decrypt, krb5_etm_encrypt, krb5_etm_decrypt) that
were the sole remaining consumers of these fields are also removed;
their function-pointer call sites were already deleted in earlier
patches.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_krb5_crypto.c   | 307 --------------------------------
 net/sunrpc/auth_gss/gss_krb5_internal.h |  54 ------
 net/sunrpc/auth_gss/gss_krb5_mech.c     | 135 +-------------
 3 files changed, 3 insertions(+), 493 deletions(-)

diff --git a/net/sunrpc/auth_gss/gss_krb5_crypto.c b/net/sunrpc/auth_gss/gss_krb5_crypto.c
index 3a8e6710a51b..cfd5b56d1b52 100644
--- a/net/sunrpc/auth_gss/gss_krb5_crypto.c
+++ b/net/sunrpc/auth_gss/gss_krb5_crypto.c
@@ -578,137 +578,6 @@ int krb5_cbc_cts_decrypt(struct crypto_sync_skcipher *cts_tfm,
 }
 EXPORT_SYMBOL_IF_KUNIT(krb5_cbc_cts_decrypt);
 
-u32
-gss_krb5_aes_encrypt(struct krb5_ctx *kctx, u32 offset,
-		     struct xdr_buf *buf, struct page **pages)
-{
-	u32 err;
-	struct xdr_netobj hmac;
-	u8 *ecptr;
-	struct crypto_sync_skcipher *cipher, *aux_cipher;
-	struct crypto_ahash *ahash;
-	struct page **save_pages;
-	unsigned int conflen;
-
-	if (kctx->initiate) {
-		cipher = kctx->initiator_enc;
-		aux_cipher = kctx->initiator_enc_aux;
-		ahash = kctx->initiator_integ;
-	} else {
-		cipher = kctx->acceptor_enc;
-		aux_cipher = kctx->acceptor_enc_aux;
-		ahash = kctx->acceptor_integ;
-	}
-	conflen = crypto_sync_skcipher_blocksize(cipher);
-
-	/* hide the gss token header and insert the confounder */
-	offset += GSS_KRB5_TOK_HDR_LEN;
-	if (xdr_extend_head(buf, offset, conflen))
-		return GSS_S_FAILURE;
-	krb5_make_confounder(buf->head[0].iov_base + offset, conflen);
-	offset -= GSS_KRB5_TOK_HDR_LEN;
-
-	if (buf->tail[0].iov_base != NULL) {
-		ecptr = buf->tail[0].iov_base + buf->tail[0].iov_len;
-	} else {
-		buf->tail[0].iov_base = buf->head[0].iov_base
-							+ buf->head[0].iov_len;
-		buf->tail[0].iov_len = 0;
-		ecptr = buf->tail[0].iov_base;
-	}
-
-	/* copy plaintext gss token header after filler (if any) */
-	memcpy(ecptr, buf->head[0].iov_base + offset, GSS_KRB5_TOK_HDR_LEN);
-	buf->tail[0].iov_len += GSS_KRB5_TOK_HDR_LEN;
-	buf->len += GSS_KRB5_TOK_HDR_LEN;
-
-	hmac.len = kctx->gk5e->cksumlength;
-	hmac.data = buf->tail[0].iov_base + buf->tail[0].iov_len;
-
-	/*
-	 * When we are called, pages points to the real page cache
-	 * data -- which we can't go and encrypt!  buf->pages points
-	 * to scratch pages which we are going to send off to the
-	 * client/server.  Swap in the plaintext pages to calculate
-	 * the hmac.
-	 */
-	save_pages = buf->pages;
-	buf->pages = pages;
-
-	err = gss_krb5_checksum(ahash, NULL, 0, buf,
-				offset + GSS_KRB5_TOK_HDR_LEN, &hmac);
-	buf->pages = save_pages;
-	if (err)
-		return GSS_S_FAILURE;
-
-	err = krb5_cbc_cts_encrypt(cipher, aux_cipher,
-				   offset + GSS_KRB5_TOK_HDR_LEN,
-				   buf, pages, NULL, 0);
-	if (err)
-		return GSS_S_FAILURE;
-
-	/* Now update buf to account for HMAC */
-	buf->tail[0].iov_len += kctx->gk5e->cksumlength;
-	buf->len += kctx->gk5e->cksumlength;
-
-	return GSS_S_COMPLETE;
-}
-
-u32
-gss_krb5_aes_decrypt(struct krb5_ctx *kctx, u32 offset, u32 len,
-		     struct xdr_buf *buf, u32 *headskip, u32 *tailskip)
-{
-	struct crypto_sync_skcipher *cipher, *aux_cipher;
-	struct crypto_ahash *ahash;
-	struct xdr_netobj our_hmac_obj;
-	u8 our_hmac[GSS_KRB5_MAX_CKSUM_LEN];
-	u8 pkt_hmac[GSS_KRB5_MAX_CKSUM_LEN];
-	struct xdr_buf subbuf;
-	u32 ret = 0;
-
-	if (kctx->initiate) {
-		cipher = kctx->acceptor_enc;
-		aux_cipher = kctx->acceptor_enc_aux;
-		ahash = kctx->acceptor_integ;
-	} else {
-		cipher = kctx->initiator_enc;
-		aux_cipher = kctx->initiator_enc_aux;
-		ahash = kctx->initiator_integ;
-	}
-
-	/* create a segment skipping the header and leaving out the checksum */
-	xdr_buf_subsegment(buf, &subbuf, offset + GSS_KRB5_TOK_HDR_LEN,
-				    (len - offset - GSS_KRB5_TOK_HDR_LEN -
-				     kctx->gk5e->cksumlength));
-
-	ret = krb5_cbc_cts_decrypt(cipher, aux_cipher, 0, &subbuf);
-	if (ret)
-		goto out_err;
-
-	our_hmac_obj.len = kctx->gk5e->cksumlength;
-	our_hmac_obj.data = our_hmac;
-	ret = gss_krb5_checksum(ahash, NULL, 0, &subbuf, 0, &our_hmac_obj);
-	if (ret)
-		goto out_err;
-
-	/* Get the packet's hmac value */
-	ret = read_bytes_from_xdr_buf(buf, len - kctx->gk5e->cksumlength,
-				      pkt_hmac, kctx->gk5e->cksumlength);
-	if (ret)
-		goto out_err;
-
-	if (crypto_memneq(pkt_hmac, our_hmac, kctx->gk5e->cksumlength) != 0) {
-		ret = GSS_S_BAD_SIG;
-		goto out_err;
-	}
-	*headskip = crypto_sync_skcipher_blocksize(cipher);
-	*tailskip = kctx->gk5e->cksumlength;
-out_err:
-	if (ret && ret != GSS_S_BAD_SIG)
-		ret = GSS_S_FAILURE;
-	return ret;
-}
-
 /**
  * krb5_etm_checksum - Compute a MAC for a GSS Wrap token
  * @cipher: an initialized cipher transform
@@ -778,182 +647,6 @@ u32 krb5_etm_checksum(struct crypto_sync_skcipher *cipher,
 }
 EXPORT_SYMBOL_IF_KUNIT(krb5_etm_checksum);
 
-/**
- * krb5_etm_encrypt - Encrypt using the RFC 8009 rules
- * @kctx: Kerberos context
- * @offset: starting offset of the payload, in bytes
- * @buf: OUT: send buffer to contain the encrypted payload
- * @pages: plaintext payload
- *
- * The main difference with aes_encrypt is that "The HMAC is
- * calculated over the cipher state concatenated with the AES
- * output, instead of being calculated over the confounder and
- * plaintext.  This allows the message receiver to verify the
- * integrity of the message before decrypting the message."
- *
- * RFC 8009 Section 5:
- *
- * encryption function: as follows, where E() is AES encryption in
- * CBC-CS3 mode, and h is the size of truncated HMAC (128 bits or
- * 192 bits as described above).
- *
- *    N = random value of length 128 bits (the AES block size)
- *    IV = cipher state
- *    C = E(Ke, N | plaintext, IV)
- *    H = HMAC(Ki, IV | C)
- *    ciphertext = C | H[1..h]
- *
- * This encryption formula provides AEAD EtM with key separation.
- *
- * Return values:
- *   %GSS_S_COMPLETE: Encryption successful
- *   %GSS_S_FAILURE: Encryption failed
- */
-u32
-krb5_etm_encrypt(struct krb5_ctx *kctx, u32 offset,
-		 struct xdr_buf *buf, struct page **pages)
-{
-	struct crypto_sync_skcipher *cipher, *aux_cipher;
-	struct crypto_ahash *ahash;
-	struct xdr_netobj hmac;
-	unsigned int conflen;
-	u8 *ecptr;
-	u32 err;
-
-	if (kctx->initiate) {
-		cipher = kctx->initiator_enc;
-		aux_cipher = kctx->initiator_enc_aux;
-		ahash = kctx->initiator_integ;
-	} else {
-		cipher = kctx->acceptor_enc;
-		aux_cipher = kctx->acceptor_enc_aux;
-		ahash = kctx->acceptor_integ;
-	}
-	conflen = crypto_sync_skcipher_blocksize(cipher);
-
-	offset += GSS_KRB5_TOK_HDR_LEN;
-	if (xdr_extend_head(buf, offset, conflen))
-		return GSS_S_FAILURE;
-	krb5_make_confounder(buf->head[0].iov_base + offset, conflen);
-	offset -= GSS_KRB5_TOK_HDR_LEN;
-
-	if (buf->tail[0].iov_base) {
-		ecptr = buf->tail[0].iov_base + buf->tail[0].iov_len;
-	} else {
-		buf->tail[0].iov_base = buf->head[0].iov_base
-							+ buf->head[0].iov_len;
-		buf->tail[0].iov_len = 0;
-		ecptr = buf->tail[0].iov_base;
-	}
-
-	memcpy(ecptr, buf->head[0].iov_base + offset, GSS_KRB5_TOK_HDR_LEN);
-	buf->tail[0].iov_len += GSS_KRB5_TOK_HDR_LEN;
-	buf->len += GSS_KRB5_TOK_HDR_LEN;
-
-	err = krb5_cbc_cts_encrypt(cipher, aux_cipher,
-				   offset + GSS_KRB5_TOK_HDR_LEN,
-				   buf, pages, NULL, 0);
-	if (err)
-		return GSS_S_FAILURE;
-
-	hmac.data = buf->tail[0].iov_base + buf->tail[0].iov_len;
-	hmac.len = kctx->gk5e->cksumlength;
-	err = krb5_etm_checksum(cipher, ahash,
-				buf, offset + GSS_KRB5_TOK_HDR_LEN, &hmac);
-	if (err)
-		goto out_err;
-	buf->tail[0].iov_len += kctx->gk5e->cksumlength;
-	buf->len += kctx->gk5e->cksumlength;
-
-	return GSS_S_COMPLETE;
-
-out_err:
-	return GSS_S_FAILURE;
-}
-
-/**
- * krb5_etm_decrypt - Decrypt using the RFC 8009 rules
- * @kctx: Kerberos context
- * @offset: starting offset of the ciphertext, in bytes
- * @len: size of ciphertext to unwrap
- * @buf: ciphertext to unwrap
- * @headskip: OUT: the enctype's confounder length, in octets
- * @tailskip: OUT: the enctype's HMAC length, in octets
- *
- * RFC 8009 Section 5:
- *
- * decryption function: as follows, where D() is AES decryption in
- * CBC-CS3 mode, and h is the size of truncated HMAC.
- *
- *    (C, H) = ciphertext
- *        (Note: H is the last h bits of the ciphertext.)
- *    IV = cipher state
- *    if H != HMAC(Ki, IV | C)[1..h]
- *        stop, report error
- *    (N, P) = D(Ke, C, IV)
- *
- * Return values:
- *   %GSS_S_COMPLETE: Decryption successful
- *   %GSS_S_BAD_SIG: computed HMAC != received HMAC
- *   %GSS_S_FAILURE: Decryption failed
- */
-u32
-krb5_etm_decrypt(struct krb5_ctx *kctx, u32 offset, u32 len,
-		 struct xdr_buf *buf, u32 *headskip, u32 *tailskip)
-{
-	struct crypto_sync_skcipher *cipher, *aux_cipher;
-	u8 our_hmac[GSS_KRB5_MAX_CKSUM_LEN];
-	u8 pkt_hmac[GSS_KRB5_MAX_CKSUM_LEN];
-	struct xdr_netobj our_hmac_obj;
-	struct crypto_ahash *ahash;
-	struct xdr_buf subbuf;
-	u32 ret = 0;
-
-	if (kctx->initiate) {
-		cipher = kctx->acceptor_enc;
-		aux_cipher = kctx->acceptor_enc_aux;
-		ahash = kctx->acceptor_integ;
-	} else {
-		cipher = kctx->initiator_enc;
-		aux_cipher = kctx->initiator_enc_aux;
-		ahash = kctx->initiator_integ;
-	}
-
-	/* Extract the ciphertext into @subbuf. */
-	xdr_buf_subsegment(buf, &subbuf, offset + GSS_KRB5_TOK_HDR_LEN,
-			   (len - offset - GSS_KRB5_TOK_HDR_LEN -
-			    kctx->gk5e->cksumlength));
-
-	our_hmac_obj.data = our_hmac;
-	our_hmac_obj.len = kctx->gk5e->cksumlength;
-	ret = krb5_etm_checksum(cipher, ahash, &subbuf, 0, &our_hmac_obj);
-	if (ret)
-		goto out_err;
-	ret = read_bytes_from_xdr_buf(buf, len - kctx->gk5e->cksumlength,
-				      pkt_hmac, kctx->gk5e->cksumlength);
-	if (ret)
-		goto out_err;
-	if (crypto_memneq(pkt_hmac, our_hmac, kctx->gk5e->cksumlength) != 0) {
-		ret = GSS_S_BAD_SIG;
-		goto out_err;
-	}
-
-	ret = krb5_cbc_cts_decrypt(cipher, aux_cipher, 0, &subbuf);
-	if (ret) {
-		ret = GSS_S_FAILURE;
-		goto out_err;
-	}
-
-	*headskip = crypto_sync_skcipher_blocksize(cipher);
-	*tailskip = kctx->gk5e->cksumlength;
-	return GSS_S_COMPLETE;
-
-out_err:
-	if (ret != GSS_S_BAD_SIG)
-		ret = GSS_S_FAILURE;
-	return ret;
-}
-
 /**
  * gss_krb5_aead_encrypt - Encrypt a wrap token using crypto/krb5
  * @kctx: Kerberos context
diff --git a/net/sunrpc/auth_gss/gss_krb5_internal.h b/net/sunrpc/auth_gss/gss_krb5_internal.h
index 8258e6862aa2..6b08a7486e0b 100644
--- a/net/sunrpc/auth_gss/gss_krb5_internal.h
+++ b/net/sunrpc/auth_gss/gss_krb5_internal.h
@@ -56,16 +56,6 @@ struct krb5_ctx {
 	struct crypto_aead	*acceptor_enc_aead;
 	struct crypto_shash	*initiator_sign_shash;
 	struct crypto_shash	*acceptor_sign_shash;
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
 	u8			Ksess[GSS_KRB5_MAX_KEYLEN]; /* session key */
 	u8			cksum[GSS_KRB5_MAX_KEYLEN];
 	atomic_t		seq_send;
@@ -115,38 +105,6 @@ int krb5_kdf_feedback_cmac(const struct gss_krb5_enctype *gk5e,
 			   const struct xdr_netobj *in_constant,
 			   gfp_t gfp_mask);
 
-/**
- * krb5_derive_key - Derive a subkey from a protocol key
- * @kctx: Kerberos 5 context
- * @inkey: base protocol key
- * @outkey: OUT: derived key
- * @usage: key usage value
- * @seed: key usage seed (one octet)
- * @gfp_mask: memory allocation control flags
- *
- * Caller sets @outkey->len to the desired length of the derived key.
- *
- * On success, returns 0 and fills in @outkey. A negative errno value
- * is returned on failure.
- */
-static inline int krb5_derive_key(struct krb5_ctx *kctx,
-				  const struct xdr_netobj *inkey,
-				  struct xdr_netobj *outkey,
-				  u32 usage, u8 seed, gfp_t gfp_mask)
-{
-	const struct gss_krb5_enctype *gk5e = kctx->gk5e;
-	u8 label_data[GSS_KRB5_K5CLENGTH];
-	struct xdr_netobj label = {
-		.len	= sizeof(label_data),
-		.data	= label_data,
-	};
-	__be32 *p = (__be32 *)label_data;
-
-	*p = cpu_to_be32(usage);
-	label_data[4] = seed;
-	return gk5e->derive_key(gk5e, inkey, outkey, &label, gfp_mask);
-}
-
 void krb5_make_confounder(u8 *p, int conflen);
 
 u32 gss_krb5_checksum(struct crypto_ahash *tfm, char *header, int hdrlen,
@@ -159,18 +117,6 @@ u32 krb5_encrypt(struct crypto_sync_skcipher *key, void *iv, void *in,
 int xdr_extend_head(struct xdr_buf *buf, unsigned int base,
 		    unsigned int shiftlen);
 
-u32 gss_krb5_aes_encrypt(struct krb5_ctx *kctx, u32 offset,
-			 struct xdr_buf *buf, struct page **pages);
-
-u32 gss_krb5_aes_decrypt(struct krb5_ctx *kctx, u32 offset, u32 len,
-			 struct xdr_buf *buf, u32 *plainoffset, u32 *plainlen);
-
-u32 krb5_etm_encrypt(struct krb5_ctx *kctx, u32 offset, struct xdr_buf *buf,
-		     struct page **pages);
-
-u32 krb5_etm_decrypt(struct krb5_ctx *kctx, u32 offset, u32 len,
-		     struct xdr_buf *buf, u32 *headskip, u32 *tailskip);
-
 u32 gss_krb5_errno_to_status(int err);
 
 int gss_krb5_mic_build_sg(const struct xdr_buf *body,
diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index 912821efc937..d8cb79fd2463 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -9,8 +9,6 @@
  *  J. Bruce Fields <bfields@umich.edu>
  */
 
-#include <crypto/hash.h>
-#include <crypto/skcipher.h>
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/init.h>
@@ -225,120 +223,14 @@ const struct gss_krb5_enctype *gss_krb5_lookup_enctype(u32 etype)
 }
 EXPORT_SYMBOL_IF_KUNIT(gss_krb5_lookup_enctype);
 
-static struct crypto_sync_skcipher *
-gss_krb5_alloc_cipher_v2(const char *cname, const struct xdr_netobj *key)
-{
-	struct crypto_sync_skcipher *tfm;
-
-	tfm = crypto_alloc_sync_skcipher(cname, 0, 0);
-	if (IS_ERR(tfm))
-		return NULL;
-	if (crypto_sync_skcipher_setkey(tfm, key->data, key->len)) {
-		crypto_free_sync_skcipher(tfm);
-		return NULL;
-	}
-	return tfm;
-}
-
-static struct crypto_ahash *
-gss_krb5_alloc_hash_v2(struct krb5_ctx *kctx, const struct xdr_netobj *key)
-{
-	struct crypto_ahash *tfm;
-
-	tfm = crypto_alloc_ahash(kctx->gk5e->cksum_name, 0, CRYPTO_ALG_ASYNC);
-	if (IS_ERR(tfm))
-		return NULL;
-	if (crypto_ahash_setkey(tfm, key->data, key->len)) {
-		crypto_free_ahash(tfm);
-		return NULL;
-	}
-	return tfm;
-}
-
 static int
 gss_krb5_import_ctx_v2(struct krb5_ctx *ctx, gfp_t gfp_mask)
 {
-	struct xdr_netobj keyin = {
-		.len	= ctx->gk5e->keylength,
-		.data	= ctx->Ksess,
-	};
 	struct krb5_buffer TK = {
 		.len	= ctx->gk5e->keylength,
 		.data	= ctx->Ksess,
 	};
-	struct xdr_netobj keyout;
-	int ret = -EINVAL;
-
-	keyout.data = kmalloc(GSS_KRB5_MAX_KEYLEN, gfp_mask);
-	if (!keyout.data)
-		return -ENOMEM;
-
-	/* initiator seal encryption */
-	keyout.len = ctx->gk5e->Ke_length;
-	if (krb5_derive_key(ctx, &keyin, &keyout, KG_USAGE_INITIATOR_SEAL,
-			    KEY_USAGE_SEED_ENCRYPTION, gfp_mask))
-		goto out;
-	ctx->initiator_enc = gss_krb5_alloc_cipher_v2(ctx->gk5e->encrypt_name,
-						      &keyout);
-	if (ctx->initiator_enc == NULL)
-		goto out;
-	if (ctx->gk5e->aux_cipher) {
-		ctx->initiator_enc_aux =
-			gss_krb5_alloc_cipher_v2(ctx->gk5e->aux_cipher,
-						 &keyout);
-		if (ctx->initiator_enc_aux == NULL)
-			goto out_free;
-	}
-
-	/* acceptor seal encryption */
-	if (krb5_derive_key(ctx, &keyin, &keyout, KG_USAGE_ACCEPTOR_SEAL,
-			    KEY_USAGE_SEED_ENCRYPTION, gfp_mask))
-		goto out_free;
-	ctx->acceptor_enc = gss_krb5_alloc_cipher_v2(ctx->gk5e->encrypt_name,
-						     &keyout);
-	if (ctx->acceptor_enc == NULL)
-		goto out_free;
-	if (ctx->gk5e->aux_cipher) {
-		ctx->acceptor_enc_aux =
-			gss_krb5_alloc_cipher_v2(ctx->gk5e->aux_cipher,
-						 &keyout);
-		if (ctx->acceptor_enc_aux == NULL)
-			goto out_free;
-	}
-
-	/* initiator sign checksum */
-	keyout.len = ctx->gk5e->Kc_length;
-	if (krb5_derive_key(ctx, &keyin, &keyout, KG_USAGE_INITIATOR_SIGN,
-			    KEY_USAGE_SEED_CHECKSUM, gfp_mask))
-		goto out_free;
-	ctx->initiator_sign = gss_krb5_alloc_hash_v2(ctx, &keyout);
-	if (ctx->initiator_sign == NULL)
-		goto out_free;
-
-	/* acceptor sign checksum */
-	if (krb5_derive_key(ctx, &keyin, &keyout, KG_USAGE_ACCEPTOR_SIGN,
-			    KEY_USAGE_SEED_CHECKSUM, gfp_mask))
-		goto out_free;
-	ctx->acceptor_sign = gss_krb5_alloc_hash_v2(ctx, &keyout);
-	if (ctx->acceptor_sign == NULL)
-		goto out_free;
-
-	/* initiator seal integrity */
-	keyout.len = ctx->gk5e->Ki_length;
-	if (krb5_derive_key(ctx, &keyin, &keyout, KG_USAGE_INITIATOR_SEAL,
-			    KEY_USAGE_SEED_INTEGRITY, gfp_mask))
-		goto out_free;
-	ctx->initiator_integ = gss_krb5_alloc_hash_v2(ctx, &keyout);
-	if (ctx->initiator_integ == NULL)
-		goto out_free;
-
-	/* acceptor seal integrity */
-	if (krb5_derive_key(ctx, &keyin, &keyout, KG_USAGE_ACCEPTOR_SEAL,
-			    KEY_USAGE_SEED_INTEGRITY, gfp_mask))
-		goto out_free;
-	ctx->acceptor_integ = gss_krb5_alloc_hash_v2(ctx, &keyout);
-	if (ctx->acceptor_integ == NULL)
-		goto out_free;
+	int ret;
 
 	ctx->initiator_enc_aead =
 		crypto_krb5_prepare_encryption(ctx->krb5e, &TK,
@@ -373,25 +265,14 @@ gss_krb5_import_ctx_v2(struct krb5_ctx *ctx, gfp_t gfp_mask)
 		goto out_free;
 	}
 
-	ret = 0;
-out:
-	kfree_sensitive(keyout.data);
-	return ret;
+	return 0;
 
 out_free:
 	crypto_free_shash(ctx->acceptor_sign_shash);
 	crypto_free_shash(ctx->initiator_sign_shash);
 	crypto_free_aead(ctx->acceptor_enc_aead);
 	crypto_free_aead(ctx->initiator_enc_aead);
-	crypto_free_ahash(ctx->acceptor_integ);
-	crypto_free_ahash(ctx->initiator_integ);
-	crypto_free_ahash(ctx->acceptor_sign);
-	crypto_free_ahash(ctx->initiator_sign);
-	crypto_free_sync_skcipher(ctx->acceptor_enc_aux);
-	crypto_free_sync_skcipher(ctx->acceptor_enc);
-	crypto_free_sync_skcipher(ctx->initiator_enc_aux);
-	crypto_free_sync_skcipher(ctx->initiator_enc);
-	goto out;
+	return ret;
 }
 
 static int
@@ -509,16 +390,6 @@ gss_krb5_delete_sec_context(void *internal_ctx)
 	crypto_free_shash(kctx->initiator_sign_shash);
 	crypto_free_aead(kctx->acceptor_enc_aead);
 	crypto_free_aead(kctx->initiator_enc_aead);
-	crypto_free_sync_skcipher(kctx->seq);
-	crypto_free_sync_skcipher(kctx->enc);
-	crypto_free_sync_skcipher(kctx->acceptor_enc);
-	crypto_free_sync_skcipher(kctx->initiator_enc);
-	crypto_free_sync_skcipher(kctx->acceptor_enc_aux);
-	crypto_free_sync_skcipher(kctx->initiator_enc_aux);
-	crypto_free_ahash(kctx->acceptor_sign);
-	crypto_free_ahash(kctx->initiator_sign);
-	crypto_free_ahash(kctx->acceptor_integ);
-	crypto_free_ahash(kctx->initiator_integ);
 	kfree(kctx->mech_used.data);
 	kfree(kctx);
 }

-- 
2.53.0


