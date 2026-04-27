Return-Path: <linux-nfs+bounces-21179-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLUsFw9q72l3BAEAu9opvQ
	(envelope-from <linux-nfs+bounces-21179-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 15:52:15 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6F9473C33
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 15:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1E94F3012B77
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 13:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED0C3D34AE;
	Mon, 27 Apr 2026 13:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmZwho9v"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A68026E142;
	Mon, 27 Apr 2026 13:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777297868; cv=none; b=h3ZSKwsZuqbdJ2SEPsy6D3lFMzZLmfdaX15FtURXMwHKzLhgeu/mWqzHN0xNqZzaoEo9MI/zmJ7N8xVkmB2/7qGf5iupZZyflaMxvdQP5jzJulSO8gKGq/66Rm8M5li092sSAxGuep7Glxn2Yd+KmvKdzo3kaSDFbD6lecPZKqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777297868; c=relaxed/simple;
	bh=r1hYi1/oKydNUvI6m8duphJXDw03FN+TkYQxFlxueUI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YLyIeeud9h5flR5lctMNaZtq/5u3cLOwknD9GCM9qRFnaNoxOghUL0JLEDLGqT1uZaGMgIAqaH+1SdKlfIqznQ08bSsaNHLsxOVpiuog2l6z5sfsEFbDfUwT7noHGDCLiMaQosqjsMmYd3A5zSrtRf8iEtUg4L3daWkqdl5pen8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmZwho9v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E7BAC2BCB5;
	Mon, 27 Apr 2026 13:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777297868;
	bh=r1hYi1/oKydNUvI6m8duphJXDw03FN+TkYQxFlxueUI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gmZwho9v1+gM2jolFs1G3RTAs4MYpAS90BPPZ6yrb/Frw34kVX4CQSJXtiuOZfKtd
	 GMNzP601SYvkMLaKOT+iFjuwkBlDPj66ET4qlfTL/A3/DYidBBXqY3Lm96sghjv8pF
	 jibTRzJlqTClDBsRS17/h5XpdzFw5rsLC45eAvJdLKNSMKh+K/gmqH8Qf4KpONw6gT
	 ui4EOgRxbCTiViHup8qtr5ca1MDdB9bBRwp667cTXNJHkJfQt5DXKqA0zjn1I8ZuRv
	 wtMkzYdYQim39UEABMesbyx7EkO3xQmJDsLjufYq+8E5pCeKPF01kjuoGiLxl8ekrT
	 wuvk9Sec5G8UQ==
From: Chuck Lever <cel@kernel.org>
Date: Mon, 27 Apr 2026 09:50:46 -0400
Subject: [PATCH 02/18] SUNRPC: Add crypto/krb5 enctype lookup to krb5_ctx
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-crypto-krb5-api-v1-2-1fc1253b64c0@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2248;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=b2ZSdAzBPiVLFHRO+Lg181bnZ6M76vrWo49KY9Cl4Mg=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp72nFrCelih++qT2SPw4nS8mvUBUUZw5tAxRYf
 KnG/EmfUV+JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCae9pxQAKCRAzarMzb2Z/
 lzv4D/9Y3ktzhJ2TUuDh3zUrb/UhaMCCqbXbsF6mLTRgp4yNea4DHhZ2MKsoW7Y/mUhDOAFmO+c
 9tXxHq/hfcy0QAJ7DWGFTQsVdLt7YveMraZVmJgopvSpEwSAfNv+/rk4BhkX+gas9EDY4RxzXI/
 XzZOf7vXKLClRReXUlrGyaPQ6rAM5Y95DF7KLjsEbBcVsG0ryvk4h+rq1mDfl4FCWZ1YH8NFMf2
 NRr3WSrNjeosKerjoNBRz5oUEQVKwodWk3G9A8pvD2y6ayxTqQcwr5DpkWQNqW9LOMbTHn2Y+fr
 o20N7iImSrp9BECEwjh7u4oUA1nGldxBAdwwKgZr5PqmC9oTKUwzocvNmYdQx3dd5Ve9EJzcM1p
 nk9hyDkfDuKqwKP2LXDnYtPRLRG0FnZT/pvDsdINpu7DtqFuN1z905m8369ko7KDT04+pWFeMO0
 QKSCd1o1Skm41ondPWJz8MdypUeCEFDEyaRTJ2DF22G9nHSv9AIVZa0xB3DzKgO2bOdwup1h/qg
 b65kKDnHP6RfKvQUnF9H74tKstrM1hQ+zsw4pYKcCAoyt3w/Kd91+3ISG097aryB7Pzir5aDEAr
 3Ncng34K2/7ShoBIBnEC6TcSVHH392YmqVr9WL9gUkt4dVRYUpX2rxTsYLQ/p9Cnv1q1o+GlV7w
 sdA1uq8VmXf/noQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: EB6F9473C33
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
	TAGGED_FROM(0.00)[bounces-21179-lists,linux-nfs=lfdr.de];
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

Each krb5_ctx currently points to a gss_krb5_enctype, the
rpcsec_gss_krb5 module's own enctype descriptor. To begin
using the common crypto/krb5 library, store a pointer to the
corresponding struct krb5_enctype (from <crypto/krb5.h>) as
well.

The lookup is performed in gss_import_v2_context() immediately
after the existing gss_krb5_lookup_enctype() call. If
crypto_krb5_find_enctype() cannot find a matching enctype the
context import fails, ensuring the module never operates with
a partially-initialized krb5_ctx.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_krb5_internal.h | 3 +++
 net/sunrpc/auth_gss/gss_krb5_mech.c     | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/net/sunrpc/auth_gss/gss_krb5_internal.h b/net/sunrpc/auth_gss/gss_krb5_internal.h
index 8769e9e705bf..11402c3b4972 100644
--- a/net/sunrpc/auth_gss/gss_krb5_internal.h
+++ b/net/sunrpc/auth_gss/gss_krb5_internal.h
@@ -8,6 +8,8 @@
 #ifndef _NET_SUNRPC_AUTH_GSS_KRB5_INTERNAL_H
 #define _NET_SUNRPC_AUTH_GSS_KRB5_INTERNAL_H
 
+#include <crypto/krb5.h>
+
 /*
  * The RFCs often specify payload lengths in bits. This helper
  * converts a specified bit-length to the number of octets/bytes.
@@ -62,6 +64,7 @@ struct krb5_ctx {
 	u32			enctype;
 	u32			flags;
 	const struct gss_krb5_enctype *gk5e; /* enctype-specific info */
+	const struct krb5_enctype *krb5e; /* crypto/krb5 enctype */
 	struct crypto_sync_skcipher *enc;
 	struct crypto_sync_skcipher *seq;
 	struct crypto_sync_skcipher *acceptor_enc;
diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index 6db64a9111a9..060d8fc4358e 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -432,6 +432,13 @@ gss_import_v2_context(const void *p, const void *end, struct krb5_ctx *ctx,
 		p = ERR_PTR(-EINVAL);
 		goto out_err;
 	}
+	ctx->krb5e = crypto_krb5_find_enctype(ctx->enctype);
+	if (!ctx->krb5e) {
+		dprintk("gss_kerberos_mech: crypto/krb5 missing enctype %u\n",
+			ctx->enctype);
+		p = ERR_PTR(-EINVAL);
+		goto out_err;
+	}
 	keylen = ctx->gk5e->keylength;
 
 	p = simple_get_bytes(p, end, ctx->Ksess, keylen);

-- 
2.53.0


