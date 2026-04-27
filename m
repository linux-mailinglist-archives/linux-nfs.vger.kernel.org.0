Return-Path: <linux-nfs+bounces-21184-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCBLENlr72nFBAEAu9opvQ
	(envelope-from <linux-nfs+bounces-21184-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 15:59:53 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3ED473E7B
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 15:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA915306171B
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 13:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1843D5647;
	Mon, 27 Apr 2026 13:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mbgG4x7B"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775B53D171A;
	Mon, 27 Apr 2026 13:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777297876; cv=none; b=njjJcFnDAsb+B/0bqJMBBHIEcigxre6DFByJFZnLCs0cGhCOEPUPcgVBnlcXmxSKAwvy53l0aFiEWDggmi+Ho/n78WYWdnt+7HaalJHPwNqbC6zd09EfIPb34mcrytqJ/3t0VE7VMAl1k73TbzPWNXMpkHWVeYv8KQn7lc3d158=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777297876; c=relaxed/simple;
	bh=G9r2fuimPedWQQUIMFXL1tj47Q934Qh804yIy2phhVI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CopNEq2n5XEONboxdfEDihkdV3/fP/vHxKVEDL1xcYclSZJh4DbuDGCIN1s7AXFif0WyRvhY/QWbAE3tqKY5kr/ihkHVoKv/PehtIY2ayqrEbbsn7oBi9C7ZsZ3d3bxUWHBra+2eljjDLGM5IBrmc8hEEFAbsjqBwz0UUp6LDZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mbgG4x7B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC0E9C2BCB4;
	Mon, 27 Apr 2026 13:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777297876;
	bh=G9r2fuimPedWQQUIMFXL1tj47Q934Qh804yIy2phhVI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mbgG4x7BvJHPA1K4c9PjunwNg5SKHffNHD7RzqVrq7L0irzRlAqrK+hHOccGOM3dM
	 TOSjzcI/vMPbjAhiKu50T/XIojOvfHJ9Ko4GPltJvZtBWZVGu1GKec2XfE9OE4cghT
	 Uxk7gc0I9XAmNmtYr/FZPfxTVtwYioDw3ZwgY4g4Kw8o/ZX4ViB5RAnV8qZJyFdxNt
	 QKxZZntZ1R3U32JoEYFiiKDvCdtjtypKGP8clMBskL80yj95xzOzAUx3vZixRRwmvJ
	 IpPQLQMrRvBs/sl28+gH1W+a8o2r+8Vhfg7r38uKWuLv7GS2pDV57j6enyHbLk/mGr
	 5sU+InoKkYkog==
From: Chuck Lever <cel@kernel.org>
Date: Mon, 27 Apr 2026 09:50:51 -0400
Subject: [PATCH 07/18] SUNRPC: Switch wrap token decryption to crypto/krb5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-crypto-krb5-api-v1-7-1fc1253b64c0@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4465;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=tSwu4bk90pIxOExzs6XERM0X3csMpleUNaX4EUlJDJE=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp72nGFeGsxDNoLj1J549fveBSxRNrCRg+vK/bJ
 Cb7eYWR5CKJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCae9pxgAKCRAzarMzb2Z/
 l4iqD/0anAO759Jy2inHUdrf2ja2FKXw7g7IOPF47KqOOdOzUdGHNNilHlfz7N6ryNlV30ayMJg
 ee0eeYS8JN0GwLyJIfiVpIgOxPgtpVphikeD+mC2EoEjY3ZmpgPtm733Xslb3dZtuo5BwyjzVB2
 V1jxhHYhQDcPntJSUB2vXdIerPJHEzUvHWkH9tUptnHZeFpPXwIaECj+edZerTAUV8CihyZsQb0
 BGa/Iawldr8z1vQiEaadu/1vgH32MH4P7wqsXY9Pvz5IUYZJkjFm5zw5irmGa0T+s2mGB/dq+xJ
 Tb+RDckkONR+0JIDosNraI2cvdPfLUEV2UOpEToH+ur/kb6OaV5cQVUlamvt77NT/0jXIzEXpCY
 cznYMQcShWYGfl+NNnhQvOvVosTRaLXVQFnJE9nXSZHL9x0hL20phXJp3e7MMyV6mneECySwk9O
 /2qafn65UBhoED0AqetbNzw5BjcuiQ2wgnzYRfkAIRX4oUKpba4NOrwvghjHYV70JoSe3yGQF5K
 wMybL9xSeOOVem8L/G0Rhl+QO82jr9yOgbBrPnmuXP6hDb/ra3D8AzC5sgs9H7Qsv+PuyfYhiJA
 BfVz6cJhyr1/UloFQt1ACxH+6KEIQ2OeK3EIj2nqGdc5Cm5KF3Y6ChPJS2hdsQHfWlTfkgZ2HYg
 2wHwHF4Q0wGlUdA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: AF3ED473E7B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21184-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,oracle.com:mid,oracle.com:email]

From: Chuck Lever <chuck.lever@oracle.com>

Replace the per-enctype .decrypt callbacks (gss_krb5_aes_decrypt
and krb5_etm_decrypt) with a single gss_krb5_aead_decrypt()
wrapper that delegates to crypto_krb5_decrypt().

The new wrapper builds a scatterlist covering the secured
region (confounder through checksum), passes it to the AEAD
decrypt operation, and derives the confounder and checksum
lengths from the data offset and length that
crypto_krb5_decrypt() reports. The caller's token header
verification and buffer adjustment logic is unchanged.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_krb5_crypto.c | 53 +++++++++++++++++++++++++++++++++++
 net/sunrpc/auth_gss/gss_krb5_mech.c   |  8 +++---
 2 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/auth_gss/gss_krb5_crypto.c b/net/sunrpc/auth_gss/gss_krb5_crypto.c
index 85425d4a28c2..31c2c86b873f 100644
--- a/net/sunrpc/auth_gss/gss_krb5_crypto.c
+++ b/net/sunrpc/auth_gss/gss_krb5_crypto.c
@@ -1050,3 +1050,56 @@ gss_krb5_aead_encrypt(struct krb5_ctx *kctx, u32 offset,
 
 	return GSS_S_COMPLETE;
 }
+
+/**
+ * gss_krb5_aead_decrypt - Decrypt a wrap token using crypto/krb5
+ * @kctx: Kerberos context
+ * @offset: byte offset of the GSS token header in @buf
+ * @len: total length of the GSS token
+ * @buf: ciphertext buffer, decrypted in-place
+ * @headskip: OUT: confounder length, in octets
+ * @tailskip: OUT: checksum length, in octets
+ *
+ * Return values:
+ *   %GSS_S_COMPLETE: Decryption and integrity verification succeeded
+ *   %GSS_S_BAD_SIG: Integrity checksum did not match
+ *   %GSS_S_DEFECTIVE_TOKEN: Token is malformed or truncated
+ *   %GSS_S_FAILURE: Decryption failed
+ */
+u32
+gss_krb5_aead_decrypt(struct krb5_ctx *kctx, u32 offset, u32 len,
+		      struct xdr_buf *buf, u32 *headskip, u32 *tailskip)
+{
+	const struct krb5_enctype *krb5 = kctx->krb5e;
+	struct crypto_aead *aead = kctx->initiate ?
+		kctx->acceptor_enc_aead : kctx->initiator_enc_aead;
+	unsigned int sec_offset, sec_len;
+	size_t data_offset, data_len;
+	struct scatterlist sg[XDR_BUF_TO_SG_NENTS];
+	struct scatterlist *sg_overflow = NULL;
+	int nsg, ret;
+
+	/* Secured region starts after the GSS token header */
+	sec_offset = offset + GSS_KRB5_TOK_HDR_LEN;
+	if (len < sec_offset)
+		return GSS_S_DEFECTIVE_TOKEN;
+	sec_len = len - sec_offset;
+
+	nsg = xdr_buf_to_sg_alloc(buf, sec_offset, sec_len,
+				  sg, ARRAY_SIZE(sg),
+				  &sg_overflow, GFP_NOFS);
+	if (nsg < 0)
+		return GSS_S_FAILURE;
+
+	data_offset = 0;
+	data_len = sec_len;
+	ret = crypto_krb5_decrypt(krb5, aead, sg, nsg,
+				  &data_offset, &data_len);
+	kfree(sg_overflow);
+	if (ret < 0)
+		return gss_krb5_errno_to_status(ret);
+
+	*headskip = data_offset;
+	*tailskip = sec_len - data_offset - data_len;
+	return GSS_S_COMPLETE;
+}
diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index 6cd7eb203350..66372e152c3b 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -44,7 +44,7 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 	  .cksum_name = "hmac(sha1)",
 	  .derive_key = krb5_derive_key_v2,
 	  .encrypt = gss_krb5_aead_encrypt,
-	  .decrypt = gss_krb5_aes_decrypt,
+	  .decrypt = gss_krb5_aead_decrypt,
 
 	  .get_mic = gss_krb5_get_mic_v2,
 	  .verify_mic = gss_krb5_verify_mic_v2,
@@ -73,7 +73,7 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 	  .cksum_name = "hmac(sha1)",
 	  .derive_key = krb5_derive_key_v2,
 	  .encrypt = gss_krb5_aead_encrypt,
-	  .decrypt = gss_krb5_aes_decrypt,
+	  .decrypt = gss_krb5_aead_decrypt,
 
 	  .get_mic = gss_krb5_get_mic_v2,
 	  .verify_mic = gss_krb5_verify_mic_v2,
@@ -167,7 +167,7 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 
 		.derive_key	= krb5_kdf_hmac_sha2,
 		.encrypt	= gss_krb5_aead_encrypt,
-		.decrypt	= krb5_etm_decrypt,
+		.decrypt	= gss_krb5_aead_decrypt,
 
 		.get_mic	= gss_krb5_get_mic_v2,
 		.verify_mic	= gss_krb5_verify_mic_v2,
@@ -193,7 +193,7 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 
 		.derive_key	= krb5_kdf_hmac_sha2,
 		.encrypt	= gss_krb5_aead_encrypt,
-		.decrypt	= krb5_etm_decrypt,
+		.decrypt	= gss_krb5_aead_decrypt,
 
 		.get_mic	= gss_krb5_get_mic_v2,
 		.verify_mic	= gss_krb5_verify_mic_v2,

-- 
2.53.0


