Return-Path: <linux-nfs+bounces-21190-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id fWB9BmFs72kcBQEAu9opvQ
	(envelope-from <linux-nfs+bounces-21190-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 16:02:09 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C65473EDC
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 16:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3FBF1306ED12
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 13:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715AB3D8918;
	Mon, 27 Apr 2026 13:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jc5O4qy/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7973D75C9;
	Mon, 27 Apr 2026 13:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777297886; cv=none; b=aYDfavqnwbrWrO942P6P1csXTKpCPVdE2CSHfOqOKXGjw5ZBvvau2YMydRxVJz/ZKxXJsr2Esu3q/vLZxpUCaxrYif3x30Ss3xrPr0dCEOvkicspc3vU8c6Con1A0bkjuxjCpCNKU1lsSO/eoM2eMu2TIQFCatKVsk62WtL9IVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777297886; c=relaxed/simple;
	bh=yGcxBy/mCpephCAJZf9ZTaYjfigB/HuqOf/uzkA2Muc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oWdkSkqp3xI4obf/4phaQeSHxlS2kt31OILA02XxqdL0pLx6siOxyTT0KG4ViFTEbUXQmOjEI5vLMM5xHiZUFiYnzvcmC5sHCLmWF7LqEnQjhReZvdQ1mcKzzxGDUxuBNn6yaLNGO6ob2rkO7qUEYZB6S7oVsphHED8OELbqwYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jc5O4qy/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8493EC19425;
	Mon, 27 Apr 2026 13:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777297885;
	bh=yGcxBy/mCpephCAJZf9ZTaYjfigB/HuqOf/uzkA2Muc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Jc5O4qy/LAaeZPs5SecvT6DuABRr/cd8r/gBocB7nOgWTQTVtDtcb69R5GjyK2MQM
	 QpgWyOnPOoxFCVmcZiFQamAbM7WuEQuAOGW+bdM2//0XAxXtwrhJdFv4y9nj+PQE/2
	 MZ3gxRnY9Ph6F2qpQqSDDbMIbOJwnCBG8+Vfrk7/ja3SWyJMiwWM7pGtjLb1t647bt
	 aggUHm6BU5VPg7YlX1+HT6lrJ4z764ADhl7sOyaE5Mu5bTN+Wnmq5GYK0/4AbpSE89
	 hpZeSgBPnZYgTC2pfH8HK4EOTZPXR3DnqNGqrAqyIKV2/o3t4SteR6vVf0RQftYbJ+
	 SCQHYUaxCTV5w==
From: Chuck Lever <cel@kernel.org>
Date: Mon, 27 Apr 2026 09:50:57 -0400
Subject: [PATCH 13/18] SUNRPC: Remove encrypt/decrypt function pointers
 from enctype table
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-crypto-krb5-api-v1-13-1fc1253b64c0@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5239;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=yGVm7UPVoysz/3BVXKnSvDbGngtDy2JCmp4VdHHAgVw=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp72nGzo6X1u4h5NXzrgioGehAScuRsLo0BcBzi
 8PTBEYqACaJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCae9pxgAKCRAzarMzb2Z/
 l5P3D/4vkdocRJB04cy+ofSZFrXeb8Bh3FNU6FUw44q2IifKcRtwooCUpt/OJNwXQo+L3Xf7KSI
 o6AB0EpaXN3K84D24iUFAHlGtdsj7eQHtPf8gb+kyeCwNa2/TbYm1amyx222msHeBWghQkIMAtI
 Bg5AKtmq6k8kgywolAtkgSi+cLLjFx7LnlYg3Y1ib+H6/F9PRNkhUT4/Ex0GRNI7jlh92TKw/WN
 +7bwb29IRPRAtnDsv37LQNHBG9G74l5+QQMBuR2UX0/8pp0H5t+wxcEWbz4pQXdags+HTibVy09
 sQaM694oOBjqvQ+Qq8koJvr2oyZPRi9uBZtqgpze8URZr0Vvl+8Fa550YE7oWReOgcDhDZeIi/n
 hNf8s37XMcCJWn3eYytJ1UAE7cNbwf1dgXf0u00+SjiTMhwCtgTKoKC3xNZBmwpx1CnhYx09Unn
 +efQAv9S+hHPe4K1SMA5qP6TrOK4KdOYbKC3fc3mZNRRYfhyT7a+mn/gMbjen2XErTkxxf4TosV
 h9/+gvXmFVMBc0HK2OU8zOuE+gxE6QaiVlJSsRV++p06e1QlYC6GMTHLrA4q7eZvKcb/yrmCqQN
 cmHORol9BhaAYza0LyTD8F1hSFn9NEcyQTvT1z9PxXfm7dUvaf44B5GyX80ULaCRS/YZNQ6bFQJ
 I4w1li20kiF1sag==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 55C65473EDC
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
	TAGGED_FROM(0.00)[bounces-21190-lists,linux-nfs=lfdr.de];
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

All enctypes now route through gss_krb5_aead_encrypt() and
gss_krb5_aead_decrypt(). The per-enctype .encrypt and .decrypt
function pointers served the same purpose as .get_mic and
.wrap before them: dispatching v1 versus v2 implementations.
With v1 support long removed and the Camellia decrypt path
migrated in a preceding patch, every table entry points to
the same pair of functions.

Call gss_krb5_aead_encrypt() and gss_krb5_aead_decrypt()
directly from gss_krb5_wrap_v2() and gss_krb5_unwrap_v2(),
and drop the function pointers from struct gss_krb5_enctype.

While here, propagate the GSS status code returned by
gss_krb5_aead_decrypt() instead of discarding it.
The old indirect call sites returned GSS_S_FAILURE
unconditionally, losing the distinction between an
integrity failure (GSS_S_BAD_SIG) and a structural
error (GSS_S_DEFECTIVE_TOKEN).

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_krb5_internal.h |  4 ----
 net/sunrpc/auth_gss/gss_krb5_mech.c     | 12 ------------
 net/sunrpc/auth_gss/gss_krb5_wrap.c     | 12 ++++++------
 3 files changed, 6 insertions(+), 22 deletions(-)

diff --git a/net/sunrpc/auth_gss/gss_krb5_internal.h b/net/sunrpc/auth_gss/gss_krb5_internal.h
index 92b0baed920c..8258e6862aa2 100644
--- a/net/sunrpc/auth_gss/gss_krb5_internal.h
+++ b/net/sunrpc/auth_gss/gss_krb5_internal.h
@@ -40,10 +40,6 @@ struct gss_krb5_enctype {
 			  struct xdr_netobj *out,
 			  const struct xdr_netobj *label,
 			  gfp_t gfp_mask);
-	u32 (*encrypt)(struct krb5_ctx *kctx, u32 offset,
-		       struct xdr_buf *buf, struct page **pages);
-	u32 (*decrypt)(struct krb5_ctx *kctx, u32 offset, u32 len,
-		       struct xdr_buf *buf, u32 *headskip, u32 *tailskip);
 };
 
 /* krb5_ctx flags definitions */
diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index d027ddab132f..912821efc937 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -43,8 +43,6 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 	  .aux_cipher = "cbc(aes)",
 	  .cksum_name = "hmac(sha1)",
 	  .derive_key = krb5_derive_key_v2,
-	  .encrypt = gss_krb5_aead_encrypt,
-	  .decrypt = gss_krb5_aead_decrypt,
 
 	  .signalg = -1,
 	  .sealalg = -1,
@@ -67,8 +65,6 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 	  .aux_cipher = "cbc(aes)",
 	  .cksum_name = "hmac(sha1)",
 	  .derive_key = krb5_derive_key_v2,
-	  .encrypt = gss_krb5_aead_encrypt,
-	  .decrypt = gss_krb5_aead_decrypt,
 
 	  .signalg = -1,
 	  .sealalg = -1,
@@ -101,8 +97,6 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 		.Ki_length	= BITS2OCTETS(128),
 
 		.derive_key	= krb5_kdf_feedback_cmac,
-		.encrypt	= gss_krb5_aead_encrypt,
-		.decrypt	= gss_krb5_aead_decrypt,
 
 	},
 	/*
@@ -123,8 +117,6 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 		.Ki_length	= BITS2OCTETS(256),
 
 		.derive_key	= krb5_kdf_feedback_cmac,
-		.encrypt	= gss_krb5_aead_encrypt,
-		.decrypt	= gss_krb5_aead_decrypt,
 
 	},
 #endif
@@ -148,8 +140,6 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 		.Ki_length	= BITS2OCTETS(128),
 
 		.derive_key	= krb5_kdf_hmac_sha2,
-		.encrypt	= gss_krb5_aead_encrypt,
-		.decrypt	= gss_krb5_aead_decrypt,
 
 	},
 	/*
@@ -170,8 +160,6 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 		.Ki_length	= BITS2OCTETS(192),
 
 		.derive_key	= krb5_kdf_hmac_sha2,
-		.encrypt	= gss_krb5_aead_encrypt,
-		.decrypt	= gss_krb5_aead_decrypt,
 
 	},
 #endif
diff --git a/net/sunrpc/auth_gss/gss_krb5_wrap.c b/net/sunrpc/auth_gss/gss_krb5_wrap.c
index b3e1738ff6bf..93aa7500d032 100644
--- a/net/sunrpc/auth_gss/gss_krb5_wrap.c
+++ b/net/sunrpc/auth_gss/gss_krb5_wrap.c
@@ -112,9 +112,9 @@ gss_krb5_wrap_v2(struct krb5_ctx *kctx, int offset,
 	*ptr++ = (unsigned char) ((KG2_TOK_WRAP>>8) & 0xff);
 	*ptr++ = (unsigned char) (KG2_TOK_WRAP & 0xff);
 
-	if ((kctx->flags & KRB5_CTX_FLAG_INITIATOR) == 0)
+	if (!kctx->initiate)
 		flags |= KG2_TOKEN_FLAG_SENTBYACCEPTOR;
-	if ((kctx->flags & KRB5_CTX_FLAG_ACCEPTOR_SUBKEY) != 0)
+	if (kctx->flags & KRB5_CTX_FLAG_ACCEPTOR_SUBKEY)
 		flags |= KG2_TOKEN_FLAG_ACCEPTORSUBKEY;
 	/* We always do confidentiality in wrap tokens */
 	flags |= KG2_TOKEN_FLAG_SEALED;
@@ -130,7 +130,7 @@ gss_krb5_wrap_v2(struct krb5_ctx *kctx, int offset,
 	be64ptr = (__be64 *)be16ptr;
 	*be64ptr = cpu_to_be64(atomic64_fetch_inc(&kctx->seq_send64));
 
-	err = (*kctx->gk5e->encrypt)(kctx, offset, buf, pages);
+	err = gss_krb5_aead_encrypt(kctx, offset, buf, pages);
 	if (err)
 		return err;
 
@@ -184,10 +184,10 @@ gss_krb5_unwrap_v2(struct krb5_ctx *kctx, int offset, int len,
 	if (rrc != 0)
 		rotate_left(offset + 16, buf, rrc);
 
-	err = (*kctx->gk5e->decrypt)(kctx, offset, len, buf,
-				     &headskip, &tailskip);
+	err = gss_krb5_aead_decrypt(kctx, offset, len, buf,
+				    &headskip, &tailskip);
 	if (err)
-		return GSS_S_FAILURE;
+		return err;
 
 	/*
 	 * Retrieve the decrypted gss token header and verify

-- 
2.53.0


