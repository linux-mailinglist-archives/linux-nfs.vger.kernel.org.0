Return-Path: <linux-nfs+bounces-21182-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEkJHlZq72l3BAEAu9opvQ
	(envelope-from <linux-nfs+bounces-21182-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 15:53:26 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D895473C7C
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 15:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 92B81301AF3C
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 13:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633C53D47A6;
	Mon, 27 Apr 2026 13:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sCoqCE4a"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F1153D47A0;
	Mon, 27 Apr 2026 13:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777297873; cv=none; b=l7S7tG87ifiir2WbVaSMls1ADlKwAOgRGlhj35+vzYaUhZbAWntGkYMl/+Wrmm3pMMN9POLcSbjWKRBjYmKu0aNMWzp87DKQAcQ6eEklDVihgcR7C1lsQbrftU+UPsFT/eB49JE39dIawi0LzX4ZZE4kNXzsxZaSjj4y/ZQfo7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777297873; c=relaxed/simple;
	bh=WebmMuO0GtsEnZlq3e0ViZ/mlcfYH4UNZpiuzGloJZA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tEwmXq77bk5O0HtZJh8Dqh7eBa38Yz5YYz8jPyZSJX9Chv8xtW1YjBwCEWlBp4zbIsCmf9PwzrV1I1Gg7aaNP1tIePjtHxG3vX4Qhi/H6uW3LO/PFsuIDuG9/Ih09POWTyW6xX5QaRDkz6NSqCG9qTDhh3FdzUmIn0lQrF9C5r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sCoqCE4a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82953C2BCB7;
	Mon, 27 Apr 2026 13:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777297872;
	bh=WebmMuO0GtsEnZlq3e0ViZ/mlcfYH4UNZpiuzGloJZA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sCoqCE4azfhIoE1JIuGxd+yqq59ZL12SFildSO97VN7AE0Q6tUidRnqDHkcfwo/MU
	 GalMYowLP4Wqka0MKC5DXLxy0ffX7ZfxNSI2tE0MmsfD2p9WCzf86ZFE4UPkZtDTJp
	 LMelLcmQnIIjwTXYJi9rAeT8DkHp86Bid5ZQ+KwMhRE0zkAhi044uAkd3QKcQE/Xc1
	 zs2kBgVBc9mIFhHEvSl8VxF3DHudyeNZ/arsS1HaCd+7PZ6AB47fVREd9wz5SPw8Bl
	 7FsMJ4pbd69uM6g/Z7a787gS3NgWKGL19N8mNdxCndY+v8PUgIhrgA+feqYPb+iYSi
	 j9jWlDM7otVbQ==
From: Chuck Lever <cel@kernel.org>
Date: Mon, 27 Apr 2026 09:50:49 -0400
Subject: [PATCH 05/18] SUNRPC: Prepare crypto/krb5 encryption and checksum
 handles
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-crypto-krb5-api-v1-5-1fc1253b64c0@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4018;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=gIF+zj1lUruHRjk1DAe+8zgG+kjGT03O1Sb1NyGEew8=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp72nFRahyVNMouJ9NbHt3wtwPZdenp5v/b9+BZ
 5VCrRZPZRmJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCae9pxQAKCRAzarMzb2Z/
 l75UEACORe1s7jjdtgdhTuGwOVR5+cIpL0l6wRrveVGP2ng4ZxLAW9OnS1Jc/+E2WEJN4y/LXFw
 VB+syVPnvjwRJQmqM+yEyYMnmmfHXHYdMMny1qwkMChAO7y1C63amMIU0EiYukbUe1aQ3kkU/KS
 67Mo1bawKYZG7xn4bGOyxcu4/RfFDDWf/UmqOU4j0bofsy9RakQ9LWEw3IaHXXOdvQVKgoz14gW
 OUQQspoOMqFUfzSeIAhZ4ki7fgFb/dhgBiKipippXoGV6yEmdAk+24t9EfkswbL04csuhWgi1eS
 GImBdCUTVyZjq5Zfq9FiIICQ6XyDI0RrS9EGjF+KTZyIX1egateE8euIZGdjW6G6qkDFctok4HW
 oZ/poST/2Mm12eT5e5OwtmBu/NHUkK5gmqxNRzxMgyR+Mw3it4+K3SrikSRLB2fXoAnwqt5cwgQ
 97iIfJVQxX47JSyyMHcxF/FVcRaI1Qd9ycyDq2KnpxJZQ/P8K9HgGSgtDQlkROeBG+GD+ap4/p4
 qxnXE099SSCk4MZtSX6KWrdJGTlxd/JU/AuKtprkgOlH0wf0mwP/EpFnMKZMBi8NVOUpKjYRAy4
 BkOj4HdX8QjUhjFx6qDAZbyjhOKImjKXSiLs4HnFRi1ziizOgrXcNi65n5EMegmDK4ajHYvYL3T
 LnZ7oI0SbYHuuXw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 0D895473C7C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21182-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

From: Chuck Lever <chuck.lever@oracle.com>

Allocate crypto_aead handles for encryption (one per direction)
and crypto_shash handles for checksumming (one per direction)
using the crypto/krb5 library's key preparation functions.

These four handles derive their subkeys from the session key
and the RFC 4121 usage numbers and are ready for use in
encrypt, decrypt, get_mic, and verify_mic operations.

The existing crypto_sync_skcipher and crypto_ahash handles
remain in place for now; subsequent patches switch the
per-message operations to the new handles and then remove
the old ones.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_krb5_internal.h |  4 +++
 net/sunrpc/auth_gss/gss_krb5_mech.c     | 45 +++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/net/sunrpc/auth_gss/gss_krb5_internal.h b/net/sunrpc/auth_gss/gss_krb5_internal.h
index a3fe4be3b9ae..33d41d972bd1 100644
--- a/net/sunrpc/auth_gss/gss_krb5_internal.h
+++ b/net/sunrpc/auth_gss/gss_krb5_internal.h
@@ -65,6 +65,10 @@ struct krb5_ctx {
 	u32			flags;
 	const struct gss_krb5_enctype *gk5e; /* enctype-specific info */
 	const struct krb5_enctype *krb5e; /* crypto/krb5 enctype */
+	struct crypto_aead	*initiator_enc_aead;
+	struct crypto_aead	*acceptor_enc_aead;
+	struct crypto_shash	*initiator_sign_shash;
+	struct crypto_shash	*acceptor_sign_shash;
 	struct crypto_sync_skcipher *enc;
 	struct crypto_sync_skcipher *seq;
 	struct crypto_sync_skcipher *acceptor_enc;
diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index 7606bbd7b8c4..35189c57fd0c 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -300,6 +300,10 @@ gss_krb5_import_ctx_v2(struct krb5_ctx *ctx, gfp_t gfp_mask)
 		.len	= ctx->gk5e->keylength,
 		.data	= ctx->Ksess,
 	};
+	struct krb5_buffer TK = {
+		.len	= ctx->gk5e->keylength,
+		.data	= ctx->Ksess,
+	};
 	struct xdr_netobj keyout;
 	int ret = -EINVAL;
 
@@ -374,12 +378,49 @@ gss_krb5_import_ctx_v2(struct krb5_ctx *ctx, gfp_t gfp_mask)
 	if (ctx->acceptor_integ == NULL)
 		goto out_free;
 
+	ctx->initiator_enc_aead =
+		crypto_krb5_prepare_encryption(ctx->krb5e, &TK,
+					       KG_USAGE_INITIATOR_SEAL,
+					       gfp_mask);
+	if (IS_ERR(ctx->initiator_enc_aead)) {
+		ret = PTR_ERR(ctx->initiator_enc_aead);
+		goto out_free;
+	}
+	ctx->acceptor_enc_aead =
+		crypto_krb5_prepare_encryption(ctx->krb5e, &TK,
+					       KG_USAGE_ACCEPTOR_SEAL,
+					       gfp_mask);
+	if (IS_ERR(ctx->acceptor_enc_aead)) {
+		ret = PTR_ERR(ctx->acceptor_enc_aead);
+		goto out_free;
+	}
+	ctx->initiator_sign_shash =
+		crypto_krb5_prepare_checksum(ctx->krb5e, &TK,
+					     KG_USAGE_INITIATOR_SIGN,
+					     gfp_mask);
+	if (IS_ERR(ctx->initiator_sign_shash)) {
+		ret = PTR_ERR(ctx->initiator_sign_shash);
+		goto out_free;
+	}
+	ctx->acceptor_sign_shash =
+		crypto_krb5_prepare_checksum(ctx->krb5e, &TK,
+					     KG_USAGE_ACCEPTOR_SIGN,
+					     gfp_mask);
+	if (IS_ERR(ctx->acceptor_sign_shash)) {
+		ret = PTR_ERR(ctx->acceptor_sign_shash);
+		goto out_free;
+	}
+
 	ret = 0;
 out:
 	kfree_sensitive(keyout.data);
 	return ret;
 
 out_free:
+	crypto_free_shash(ctx->acceptor_sign_shash);
+	crypto_free_shash(ctx->initiator_sign_shash);
+	crypto_free_aead(ctx->acceptor_enc_aead);
+	crypto_free_aead(ctx->initiator_enc_aead);
 	crypto_free_ahash(ctx->acceptor_integ);
 	crypto_free_ahash(ctx->initiator_integ);
 	crypto_free_ahash(ctx->acceptor_sign);
@@ -502,6 +543,10 @@ gss_krb5_delete_sec_context(void *internal_ctx)
 {
 	struct krb5_ctx *kctx = internal_ctx;
 
+	crypto_free_shash(kctx->acceptor_sign_shash);
+	crypto_free_shash(kctx->initiator_sign_shash);
+	crypto_free_aead(kctx->acceptor_enc_aead);
+	crypto_free_aead(kctx->initiator_enc_aead);
 	crypto_free_sync_skcipher(kctx->seq);
 	crypto_free_sync_skcipher(kctx->enc);
 	crypto_free_sync_skcipher(kctx->acceptor_enc);

-- 
2.53.0


