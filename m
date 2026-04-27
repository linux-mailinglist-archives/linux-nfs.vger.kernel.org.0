Return-Path: <linux-nfs+bounces-21183-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKKaIAJr72l3BAEAu9opvQ
	(envelope-from <linux-nfs+bounces-21183-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 15:56:18 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB35473D80
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 15:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D0AD63023D7D
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 13:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74753D5221;
	Mon, 27 Apr 2026 13:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KdZs/37B"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A25493D47DD;
	Mon, 27 Apr 2026 13:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777297874; cv=none; b=AQ5+XClPQVRSL8SDrvOLanATb89p3AQ0Lt3XGzI6/TOVAC7zKWTAuGQKlCPFkob3Tvd6SGe9uXn5We23t/9qVN4H8BQWy6IQq/fiXPhzyD9P1VPbax0M79Cx+X4jdZGJuP8OMxql1BamrWtgi2CUHKWQltCkxw5oLolOLyEkDeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777297874; c=relaxed/simple;
	bh=NTl7qTopFJStCGZUPMgCylLG1NE1rViTzBAAii1iHc4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pMxCXHRRGXzWhwm567wCrHTa/JxvBZSxTToRNVy7UzURM3KYt2dRHdSfRMzHbMYfbzlTqlinPwZ2PKgBxQHEhIBZunZ0sO3UyRKul350dctOQTnGzhlgLFQi7jorU9NJ1X6gSJWhnd2jWUrHX6yabxVf8jw1pO4vFlm1u1ymsZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KdZs/37B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21069C2BCC4;
	Mon, 27 Apr 2026 13:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777297874;
	bh=NTl7qTopFJStCGZUPMgCylLG1NE1rViTzBAAii1iHc4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KdZs/37Bhgst73kQhmwLeECJ098BLP9RJnrBLiuwhN/pKy+nBxk7cesNDta56vYqi
	 4P1AXYrbQ42/1bQDz4ZzSeBPJIbJO+VZdVefWAA8PGlRtepSPr937dp1yMs35qjLrG
	 ISaPiFMCWa9IobFKRsSKDK8XRa2Q+V70icDVCfsEFT8muqsIXWdRpiGuBuaxk4Cd60
	 YZffe85QCfdS+CiYddoAcsSNBra/AmeP9ElSLSUpfrWXmBy0Q1DTpjEQ4AkhezsqLd
	 wwxu+J8XCocuPhWl6L7SlKboeobcBC67hdcKkvk0OE3VMgH8jZG8mVcdTNUT3yTPQL
	 Qz6UW6LncdbNw==
From: Chuck Lever <cel@kernel.org>
Date: Mon, 27 Apr 2026 09:50:50 -0400
Subject: [PATCH 06/18] SUNRPC: Switch wrap token encryption to crypto/krb5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-crypto-krb5-api-v1-6-1fc1253b64c0@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7628;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=R/aMik3QQ8JCxSimmF7L2sz2beX+NWRS8XfGB0VJLi0=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp72nGC51ztGmXkAEWeEC/R7aDDt7OPi7UGiZPR
 knV4pE+iYGJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCae9pxgAKCRAzarMzb2Z/
 l+YFD/9PHECMHSn3C/nx/fwrl949zbuvuH3Eg9hemyCsKLFsSEmChpu4eIseWL6COIeRd/2AdBm
 mdNfVVpkVFTkqC0MDXRSnIESAA/cXRc5h9UoE3bmzdSCTIa3VjS8RZ3/cf/RtUaBnSowVEP3SgE
 CtLWmFCv/OJ5Cn836vqjlFdxDrE3cJRGZguv0fNlD1M4en0/Zy29atheMTjFwp6jbq///vYKcFP
 aw7rxdXT61zAXwdFwN0l4ze1tLVs5ngdX6NdIL7akIxuKZhdfRAM2nrAAltWZaUUNswViLAjkGV
 g2jvD0gsNcuINZpSkconxEZXSuX8M4qInuw1BIzBqCHw5bKOstn0td+GQJ+47ni/YX+Momhnnxl
 UMAQx0XXdz+xmncVNpEs1A+admiiYQVntYQXJZa8xWrRH8pC5C9t6v0HrQEGpSC8t28KeJB6xJv
 pfCE9Sz7T6Z/cvibPOakMWWPh1KGoXZCS06jgIP+HxTCncr5WAyljTl1Ff3CMKSvdwEBNRT6M5f
 QIurLY20LTXgfLDWttui3dLb/Z146eFr3SiLEUbYwnfnxIz3k4kcaZOENJonOVm2ZAa1YZ0DSg1
 KKoCy/QstbMxnqQsPPJ6xOXWoBEJ7koMlz214Wt5svVHMIeWACG31lCGt/VJxIyqSfjq86Q19Oq
 F7ou1l9iLDetIGw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 6DB35473D80
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
	TAGGED_FROM(0.00)[bounces-21183-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

From: Chuck Lever <chuck.lever@oracle.com>

Replace the per-enctype .encrypt callbacks (gss_krb5_aes_encrypt and
krb5_etm_encrypt) with a single gss_krb5_aead_encrypt() wrapper that
delegates to crypto_krb5_encrypt().

The xdr_buf setup -- GSS header insertion, confounder space
allocation, and token header copy -- remains unchanged. The
difference is that the CBC-CTS encryption and HMAC computation are
now a single AEAD operation through the crypto/krb5 library. Both
the MtE construction (RFC 3962) and the EtM construction (RFC 8009)
are handled transparently by the AEAD transform.

The plaintext page data must be copied from the page cache pages to
the scratch output pages before building the scatterlist, since the
AEAD operates in-place rather than using separate input and output
scatterlists.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_krb5_crypto.c   | 97 +++++++++++++++++++++++++++++++++
 net/sunrpc/auth_gss/gss_krb5_internal.h |  5 ++
 net/sunrpc/auth_gss/gss_krb5_mech.c     | 12 ++--
 3 files changed, 108 insertions(+), 6 deletions(-)

diff --git a/net/sunrpc/auth_gss/gss_krb5_crypto.c b/net/sunrpc/auth_gss/gss_krb5_crypto.c
index 16dcf115de1e..85425d4a28c2 100644
--- a/net/sunrpc/auth_gss/gss_krb5_crypto.c
+++ b/net/sunrpc/auth_gss/gss_krb5_crypto.c
@@ -953,3 +953,100 @@ krb5_etm_decrypt(struct krb5_ctx *kctx, u32 offset, u32 len,
 		ret = GSS_S_FAILURE;
 	return ret;
 }
+
+/**
+ * gss_krb5_aead_encrypt - Encrypt a wrap token using crypto/krb5
+ * @kctx: Kerberos context
+ * @offset: byte offset of the GSS token header in @buf
+ * @buf: OUT: send buffer
+ * @pages: plaintext payload pages (page cache data)
+ *
+ * The xdr_buf setup mirrors the original per-enctype encrypt
+ * functions, but the CBC-CTS encryption and HMAC are replaced
+ * by a single AEAD operation through the crypto/krb5 library.
+ *
+ * Return values:
+ *   %GSS_S_COMPLETE: Encryption successful
+ *   %GSS_S_FAILURE: Encryption failed
+ */
+u32
+gss_krb5_aead_encrypt(struct krb5_ctx *kctx, u32 offset,
+		      struct xdr_buf *buf, struct page **pages)
+{
+	const struct krb5_enctype *krb5 = kctx->krb5e;
+	struct crypto_aead *aead = kctx->initiate ?
+		kctx->initiator_enc_aead : kctx->acceptor_enc_aead;
+	unsigned int conflen = krb5->conf_len;
+	unsigned int cksum_len = krb5->cksum_len;
+	unsigned int sec_offset, sec_len, data_len;
+	struct scatterlist sg[XDR_BUF_TO_SG_NENTS];
+	struct scatterlist *sg_overflow = NULL;
+	ssize_t ret;
+	int nsg;
+
+	/* Insert space for the confounder */
+	if (xdr_extend_head(buf, offset + GSS_KRB5_TOK_HDR_LEN, conflen))
+		return GSS_S_FAILURE;
+
+	/* Ensure a tail segment exists */
+	if (buf->tail[0].iov_base == NULL) {
+		buf->tail[0].iov_base = buf->head[0].iov_base
+						+ buf->head[0].iov_len;
+		buf->tail[0].iov_len = 0;
+	}
+
+	/* Append a copy of the plaintext GSS token header (RFC 4121 Sec 4.2.4) */
+	memcpy(buf->tail[0].iov_base + buf->tail[0].iov_len,
+	       buf->head[0].iov_base + offset, GSS_KRB5_TOK_HDR_LEN);
+	buf->tail[0].iov_len += GSS_KRB5_TOK_HDR_LEN;
+	buf->len += GSS_KRB5_TOK_HDR_LEN;
+
+	/* Reserve space for the integrity checksum */
+	buf->tail[0].iov_len += cksum_len;
+	buf->len += cksum_len;
+
+	/*
+	 * The AEAD operates in-place, but on the client send path the
+	 * plaintext payload lives in page cache pages that must not be
+	 * modified.  Copy the payload into the scratch output pages
+	 * first.  On the server send path @pages and buf->pages are
+	 * the same array, and no copy is needed.
+	 *
+	 * Both arrays share buf->page_base, so the same index and
+	 * intra-page offset address corresponding data in each.
+	 */
+	if (pages != buf->pages) {
+		unsigned int poff = buf->page_base;
+		unsigned int plen = buf->page_len;
+		unsigned int i = poff >> PAGE_SHIFT;
+		unsigned int off = offset_in_page(poff);
+
+		while (plen) {
+			unsigned int n = min_t(unsigned int, plen,
+					       PAGE_SIZE - off);
+			memcpy_page(buf->pages[i], off, pages[i], off, n);
+			plen -= n;
+			i++;
+			off = 0;
+		}
+	}
+
+	/* Build scatterlist covering the secured region */
+	sec_offset = offset + GSS_KRB5_TOK_HDR_LEN;
+	sec_len = buf->len - sec_offset;
+	data_len = sec_len - conflen - cksum_len;
+
+	nsg = xdr_buf_to_sg_alloc(buf, sec_offset, sec_len,
+				  sg, ARRAY_SIZE(sg),
+				  &sg_overflow, GFP_NOFS);
+	if (nsg < 0)
+		return GSS_S_FAILURE;
+
+	ret = crypto_krb5_encrypt(krb5, aead, sg, nsg, sec_len,
+				  conflen, data_len, false);
+	kfree(sg_overflow);
+	if (ret < 0)
+		return GSS_S_FAILURE;
+
+	return GSS_S_COMPLETE;
+}
diff --git a/net/sunrpc/auth_gss/gss_krb5_internal.h b/net/sunrpc/auth_gss/gss_krb5_internal.h
index 33d41d972bd1..ce43e1be7577 100644
--- a/net/sunrpc/auth_gss/gss_krb5_internal.h
+++ b/net/sunrpc/auth_gss/gss_krb5_internal.h
@@ -186,6 +186,11 @@ u32 krb5_etm_decrypt(struct krb5_ctx *kctx, u32 offset, u32 len,
 
 u32 gss_krb5_errno_to_status(int err);
 
+u32 gss_krb5_aead_encrypt(struct krb5_ctx *kctx, u32 offset,
+			  struct xdr_buf *buf, struct page **pages);
+u32 gss_krb5_aead_decrypt(struct krb5_ctx *kctx, u32 offset, u32 len,
+			  struct xdr_buf *buf, u32 *headskip, u32 *tailskip);
+
 #if IS_ENABLED(CONFIG_KUNIT)
 void krb5_nfold(u32 inbits, const u8 *in, u32 outbits, u8 *out);
 const struct gss_krb5_enctype *gss_krb5_lookup_enctype(u32 etype);
diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index 35189c57fd0c..6cd7eb203350 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -43,7 +43,7 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 	  .aux_cipher = "cbc(aes)",
 	  .cksum_name = "hmac(sha1)",
 	  .derive_key = krb5_derive_key_v2,
-	  .encrypt = gss_krb5_aes_encrypt,
+	  .encrypt = gss_krb5_aead_encrypt,
 	  .decrypt = gss_krb5_aes_decrypt,
 
 	  .get_mic = gss_krb5_get_mic_v2,
@@ -72,7 +72,7 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 	  .aux_cipher = "cbc(aes)",
 	  .cksum_name = "hmac(sha1)",
 	  .derive_key = krb5_derive_key_v2,
-	  .encrypt = gss_krb5_aes_encrypt,
+	  .encrypt = gss_krb5_aead_encrypt,
 	  .decrypt = gss_krb5_aes_decrypt,
 
 	  .get_mic = gss_krb5_get_mic_v2,
@@ -111,7 +111,7 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 		.Ki_length	= BITS2OCTETS(128),
 
 		.derive_key	= krb5_kdf_feedback_cmac,
-		.encrypt	= gss_krb5_aes_encrypt,
+		.encrypt	= gss_krb5_aead_encrypt,
 		.decrypt	= gss_krb5_aes_decrypt,
 
 		.get_mic	= gss_krb5_get_mic_v2,
@@ -137,7 +137,7 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 		.Ki_length	= BITS2OCTETS(256),
 
 		.derive_key	= krb5_kdf_feedback_cmac,
-		.encrypt	= gss_krb5_aes_encrypt,
+		.encrypt	= gss_krb5_aead_encrypt,
 		.decrypt	= gss_krb5_aes_decrypt,
 
 		.get_mic	= gss_krb5_get_mic_v2,
@@ -166,7 +166,7 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 		.Ki_length	= BITS2OCTETS(128),
 
 		.derive_key	= krb5_kdf_hmac_sha2,
-		.encrypt	= krb5_etm_encrypt,
+		.encrypt	= gss_krb5_aead_encrypt,
 		.decrypt	= krb5_etm_decrypt,
 
 		.get_mic	= gss_krb5_get_mic_v2,
@@ -192,7 +192,7 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 		.Ki_length	= BITS2OCTETS(192),
 
 		.derive_key	= krb5_kdf_hmac_sha2,
-		.encrypt	= krb5_etm_encrypt,
+		.encrypt	= gss_krb5_aead_encrypt,
 		.decrypt	= krb5_etm_decrypt,
 
 		.get_mic	= gss_krb5_get_mic_v2,

-- 
2.53.0


