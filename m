Return-Path: <linux-nfs+bounces-21186-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPiUM8hq72l3BAEAu9opvQ
	(envelope-from <linux-nfs+bounces-21186-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 15:55:20 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D537473CEB
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 15:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B82C9303128B
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 13:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1ED3D6CA4;
	Mon, 27 Apr 2026 13:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAUgO0FB"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70963D669B;
	Mon, 27 Apr 2026 13:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777297879; cv=none; b=mpddmp8hE4OUEKrhs6gxmzwWQyuoslyuynZSoaOzbJ4JegoRD83AN7SHHPKzFfVhQKxU32O93ShrxxGuXpRWLzrwdZYciBe4tm4ZViROgekf4od0qV4iDU8Kp9UyT+LmQkAb3gcfmgH0VDJ6bETv+WCDPruWB58F8A0I/4eTbxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777297879; c=relaxed/simple;
	bh=+iCZS+x1ulBRg2AFCNAWWwnNsck0y0py2IyDgHFO3Zk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tyEs2dXwaSdCUu3UkjT/v0pKAUCJFXKTuunlEOvSopeaCJ2s7HrzhDwKnvUsT33JBQn/raW/33YcMFmwADsCGfB+M5dlFxjcQyOfxlEXvyXRiQr0iexitOthGJOm0pRp6b++C+rFBcWclAmukM1Pdk+H/Y9i58YPahGdNb79pVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAUgO0FB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A0CBC2BCB4;
	Mon, 27 Apr 2026 13:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777297879;
	bh=+iCZS+x1ulBRg2AFCNAWWwnNsck0y0py2IyDgHFO3Zk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZAUgO0FB0b1/B0ael700JecZr1GQCaylwQ5eQp1ZF0HrhfKcryERVVeA6m1NxU+kW
	 ERzZOfFXHY7g6eQ0dCoTzRJQ8xkOIWzv7noaI9oIvBc9xBo63clLLpw/Pv8Ozm87JN
	 A9GMnCn3GXFT7w9297nMXtpsgK9e7/6lDNAiM5tFO23nwH98XXEDCJFLhEYChhFjTD
	 Z9hUOEWUCYoCuDEvUJSTt/sBD6yBVsjZ7CGXRzknJYfYC8jX08DwOpAXYP0GyT8Ehj
	 GtuDLooYaZfN+ORLgTUYX1IMGlGnFhh5tBHuPeKl2mwMK6ABsU5Gbm/527u4OIAMEz
	 VRrS3fJkgb51A==
From: Chuck Lever <cel@kernel.org>
Date: Mon, 27 Apr 2026 09:50:53 -0400
Subject: [PATCH 09/18] SUNRPC: Switch MIC token generation to crypto/krb5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-crypto-krb5-api-v1-9-1fc1253b64c0@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8105;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=cWdmy/9P2Ee68GQI+cDvolLt9zsdLCw2oTTq+Yz8Tns=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp72nGGu4OlIH7aebl3EgkJzmXrU5P8nNJb8DTn
 wcaGcSsJ26JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCae9pxgAKCRAzarMzb2Z/
 l5zlD/9HPi973VI678LHcl962BGa5hHfK0MvTZZ8Xn/9PmVS7qZ+BNwjggNCRtbEuSspz221BEc
 51W8CfAxCM60O16A4YeCs0+IlXuidstngddhnq4zCO1R1ymejnkslv43vmOx5Q61QNPTPMS+B9G
 RxOshvq4O1hgEFmYrRUjMP0xzVKoLr7TVdySgvlFGRVNxIINUCSsICtaLsZFEtnsHP/ikydftw+
 BEIrL6IlyE7G+f1PPSFctU882m6oKI/Q8dKjItzVJMUV8jr3QdixRomclAwufTsfqsghzSvpTot
 MHxa1BR701v2c97MLfCHmany9fR2M/wTaQWZXSajgA545IHqK70MfmVLi7z+bT9v71X/OPS37ah
 6dtqAirJrl+F6pbGmDYR2Lm/gW4ZKgXqRctFnKsi2Kqt5xfdx6pDsm+OuMppI7j3FMeWRltOcJZ
 9ZtYToNBVApcNWI3mmbC2MXLB/Ne59PqxcEbplNep7++sHi5g3T/DJKTNQFaP00m/xcs+kQAMqE
 2N+xi1gzuyxzMyTtNMJXjUaqhCWcrKGTR7FECkDUu7NFYo7T4XO2poxEjl5ONrpAnwg2FYVCoBb
 1ZCGlQCNSiPAYDLHFpgwYsg4BJCUWwApEcah4vxLkyqDjiupAsG3HShzBpLm40PGWWz2tnn685I
 zgSqP+O7GVb03/Q==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 6D537473CEB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21186-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,cksumobj.data:url]

From: Chuck Lever <chuck.lever@oracle.com>

gss_krb5_get_mic_v2() currently computes the MIC checksum by
driving a crypto_ahash directly, calling gss_krb5_checksum()
with the message body and GSS token header. Replace this with
a call to crypto_krb5_get_mic(), which performs the same keyed
hash operation through the crypto/krb5 library.

RFC 4121 Section 4.2.4 specifies that the checksum covers the
message body followed by the token header. Because the
crypto/krb5 metadata parameter is hashed before the data, the
GSS header cannot be passed as metadata. Instead, the header
is appended to the scatterlist after the body data, producing
the correct hash input ordering without using the metadata
parameter.

The scatterlist layout is:
  [checksum_output | message_body | gss_header]

The first scatterlist entry points directly into the
token buffer, so the checksum is written in place.

A shared helper, gss_krb5_mic_build_sg(), is introduced in
gss_krb5_crypto.c to construct this scatterlist layout. The
helper handles overflow allocation and scatterlist chaining
for large xdr_buf page arrays. It is reused by the verify_mic
counterpart in the following commit.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_krb5_crypto.c   | 82 +++++++++++++++++++++++++++++++++
 net/sunrpc/auth_gss/gss_krb5_internal.h |  6 +++
 net/sunrpc/auth_gss/gss_krb5_seal.c     | 45 +++++++++++++-----
 3 files changed, 121 insertions(+), 12 deletions(-)

diff --git a/net/sunrpc/auth_gss/gss_krb5_crypto.c b/net/sunrpc/auth_gss/gss_krb5_crypto.c
index 31c2c86b873f..3a8e6710a51b 100644
--- a/net/sunrpc/auth_gss/gss_krb5_crypto.c
+++ b/net/sunrpc/auth_gss/gss_krb5_crypto.c
@@ -1103,3 +1103,85 @@ gss_krb5_aead_decrypt(struct krb5_ctx *kctx, u32 offset, u32 len,
 	*tailskip = sec_len - data_offset - data_len;
 	return GSS_S_COMPLETE;
 }
+
+/**
+ * gss_krb5_mic_build_sg - Build scatterlist for MIC token operations
+ * @body: xdr_buf containing the message body
+ * @cksum: pointer to checksum area in the token buffer
+ * @cksum_len: length of checksum area
+ * @hdr: pointer to GSS token header
+ * @sg_head: caller-provided scatterlist array; if more than
+ *	XDR_BUF_TO_SG_NENTS entries are needed, an overflow
+ *	scatterlist is allocated and chained automatically
+ * @sg_overflow: OUT: overflow scatterlist, caller must kfree
+ *
+ * Per RFC 4121 Section 4.2.4, MIC token checksums cover the
+ * message body followed by the token header. The checksum
+ * output or received checksum occupies the first scatterlist
+ * entry.  This layout cannot be constructed by
+ * xdr_buf_to_sg_alloc() because the checksum area and the GSS
+ * header lie outside the xdr_buf.
+ *
+ * Returns the number of scatterlist entries on success, or a
+ * negative errno on failure.
+ */
+int gss_krb5_mic_build_sg(const struct xdr_buf *body,
+			  void *cksum, unsigned int cksum_len,
+			  void *hdr,
+			  struct scatterlist *sg_head,
+			  struct scatterlist **sg_overflow)
+{
+	struct scatterlist *entry;
+	int body_max, body_nsg, nsg;
+
+	*sg_overflow = NULL;
+
+	body_max = 2;
+	if (body->page_len)
+		body_max += DIV_ROUND_UP(body->page_len +
+					 offset_in_page(body->page_base),
+					 PAGE_SIZE);
+	nsg = 1 + body_max + 1;
+	if (nsg <= XDR_BUF_TO_SG_NENTS) {
+		sg_init_table(sg_head, nsg);
+	} else {
+		unsigned int overflow_nents =
+			nsg - XDR_BUF_TO_SG_NENTS + 1;
+
+		*sg_overflow = kmalloc_array(overflow_nents,
+					     sizeof(**sg_overflow),
+					     GFP_NOFS);
+		if (!*sg_overflow)
+			return -ENOMEM;
+
+		sg_init_table(sg_head, XDR_BUF_TO_SG_NENTS);
+		sg_init_table(*sg_overflow, overflow_nents);
+		sg_chain(sg_head, XDR_BUF_TO_SG_NENTS, *sg_overflow);
+	}
+
+	sg_set_buf(&sg_head[0], cksum, cksum_len);
+	body_nsg = xdr_buf_to_sg(body, 0, body->len,
+				 sg_next(&sg_head[0]), body_max);
+	if (body_nsg < 0)
+		goto out_err;
+
+	/*
+	 * xdr_buf_to_sg marks the last body entry as end-of-list;
+	 * clear it so the trailing header entry is reachable.
+	 */
+	if (body_nsg > 0) {
+		entry = sg_last(sg_next(&sg_head[0]), body_nsg);
+		sg_unmark_end(entry);
+		entry = sg_next(entry);
+	} else {
+		entry = sg_next(&sg_head[0]);
+	}
+	sg_set_buf(entry, hdr, GSS_KRB5_TOK_HDR_LEN);
+	sg_mark_end(entry);
+	return 1 + body_nsg + 1;
+
+out_err:
+	kfree(*sg_overflow);
+	*sg_overflow = NULL;
+	return body_nsg;
+}
diff --git a/net/sunrpc/auth_gss/gss_krb5_internal.h b/net/sunrpc/auth_gss/gss_krb5_internal.h
index ce43e1be7577..83e969494b54 100644
--- a/net/sunrpc/auth_gss/gss_krb5_internal.h
+++ b/net/sunrpc/auth_gss/gss_krb5_internal.h
@@ -186,6 +186,12 @@ u32 krb5_etm_decrypt(struct krb5_ctx *kctx, u32 offset, u32 len,
 
 u32 gss_krb5_errno_to_status(int err);
 
+int gss_krb5_mic_build_sg(const struct xdr_buf *body,
+			  void *cksum, unsigned int cksum_len,
+			  void *hdr,
+			  struct scatterlist *sg_head,
+			  struct scatterlist **sg_overflow);
+
 u32 gss_krb5_aead_encrypt(struct krb5_ctx *kctx, u32 offset,
 			  struct xdr_buf *buf, struct page **pages);
 u32 gss_krb5_aead_decrypt(struct krb5_ctx *kctx, u32 offset, u32 len,
diff --git a/net/sunrpc/auth_gss/gss_krb5_seal.c b/net/sunrpc/auth_gss/gss_krb5_seal.c
index ce540df9bce4..66c179337029 100644
--- a/net/sunrpc/auth_gss/gss_krb5_seal.c
+++ b/net/sunrpc/auth_gss/gss_krb5_seal.c
@@ -64,6 +64,8 @@
 #include <linux/random.h>
 #include <linux/crypto.h>
 #include <linux/atomic.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
 
 #include "gss_krb5_internal.h"
 
@@ -78,10 +80,10 @@ setup_token_v2(struct krb5_ctx *ctx, struct xdr_netobj *token)
 	void *krb5_hdr;
 	u8 *p, flags = 0x00;
 
-	if ((ctx->flags & KRB5_CTX_FLAG_INITIATOR) == 0)
-		flags |= 0x01;
+	if (!ctx->initiate)
+		flags |= KG2_TOKEN_FLAG_SENTBYACCEPTOR;
 	if (ctx->flags & KRB5_CTX_FLAG_ACCEPTOR_SUBKEY)
-		flags |= 0x04;
+		flags |= KG2_TOKEN_FLAG_ACCEPTORSUBKEY;
 
 	/* Per rfc 4121, sec 4.2.6.1, there is no header,
 	 * just start the token.
@@ -97,7 +99,7 @@ setup_token_v2(struct krb5_ctx *ctx, struct xdr_netobj *token)
 	*ptr++ = 0xffff;
 	*ptr = 0xffff;
 
-	token->len = GSS_KRB5_TOK_HDR_LEN + ctx->gk5e->cksumlength;
+	token->len = GSS_KRB5_TOK_HDR_LEN + ctx->krb5e->cksum_len;
 	return krb5_hdr;
 }
 
@@ -105,14 +107,17 @@ u32
 gss_krb5_get_mic_v2(struct krb5_ctx *ctx, struct xdr_buf *text,
 		    struct xdr_netobj *token)
 {
-	struct crypto_ahash *tfm = ctx->initiate ?
-				   ctx->initiator_sign : ctx->acceptor_sign;
-	struct xdr_netobj cksumobj = {
-		.len =	ctx->gk5e->cksumlength,
-	};
+	const struct krb5_enctype *krb5 = ctx->krb5e;
+	struct crypto_shash *shash = ctx->initiate ?
+		ctx->initiator_sign_shash : ctx->acceptor_sign_shash;
+	unsigned int cksum_len = krb5->cksum_len;
+	struct scatterlist sg_head[XDR_BUF_TO_SG_NENTS];
+	struct scatterlist *sg_overflow;
 	__be64 seq_send_be64;
 	void *krb5_hdr;
 	time64_t now;
+	ssize_t ret;
+	int nsg;
 
 	dprintk("RPC:       %s\n", __func__);
 
@@ -123,9 +128,25 @@ gss_krb5_get_mic_v2(struct krb5_ctx *ctx, struct xdr_buf *text,
 	seq_send_be64 = cpu_to_be64(atomic64_fetch_inc(&ctx->seq_send64));
 	memcpy(krb5_hdr + 8, (char *) &seq_send_be64, 8);
 
-	cksumobj.data = krb5_hdr + GSS_KRB5_TOK_HDR_LEN;
-	if (gss_krb5_checksum(tfm, krb5_hdr, GSS_KRB5_TOK_HDR_LEN,
-			      text, 0, &cksumobj))
+	/*
+	 * The checksum is written directly into the token buffer.
+	 * This is safe: crypto_krb5_get_mic uses shash (software
+	 * hash), so the scatterlist is never DMA-mapped.
+	 */
+	nsg = gss_krb5_mic_build_sg(text,
+				    krb5_hdr + GSS_KRB5_TOK_HDR_LEN,
+				    cksum_len, krb5_hdr,
+				    sg_head, &sg_overflow);
+	if (nsg < 0)
+		return GSS_S_FAILURE;
+
+	ret = crypto_krb5_get_mic(krb5, shash, NULL, sg_head, nsg,
+				  cksum_len + text->len +
+					GSS_KRB5_TOK_HDR_LEN,
+				  cksum_len,
+				  text->len + GSS_KRB5_TOK_HDR_LEN);
+	kfree(sg_overflow);
+	if (ret < 0)
 		return GSS_S_FAILURE;
 
 	now = ktime_get_real_seconds();

-- 
2.53.0


