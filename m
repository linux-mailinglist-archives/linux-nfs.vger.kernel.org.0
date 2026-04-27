Return-Path: <linux-nfs+bounces-21187-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAEBKuJq72nFBAEAu9opvQ
	(envelope-from <linux-nfs+bounces-21187-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 15:55:46 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 46C12473D53
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 15:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 098543037CD6
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 13:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 871A33D6CD8;
	Mon, 27 Apr 2026 13:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PFocm/x4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631023D6699;
	Mon, 27 Apr 2026 13:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777297881; cv=none; b=CaLNwIzwhd1OSgD+mn7KxDnLL9LWhrQD+4eQoF02hsZ71XBgjOi+2DaJCGoQfp8lkD/cBXCVYxo5EXvHqlcity0+EC0s4eHJ4lsS79IZS0FxIcdUG2C2w93oBIBL+7IkQlz0ulDdmrSD6wDbuOWSjMZrRgHvalwP91ScJ6bWaYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777297881; c=relaxed/simple;
	bh=3shOJYtBwIkZvQMhtlzAau9neKcXD6O4OFZl67h8sUk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fUh//UIUEpZMR2ZJpNTTiUV2cZ8V/bryqMJmXAbFoinKoXOUEyIrFjykizeUZrG7CDwWTlOoXZPciqmotO9I+4plbjjK7nSShYhGbS+8WvU0iyyzWzGZQHnHgAcStwlB0P8C+2gc85ukPeZqkNg/vQSIxhkVpYjJ5gVq1fSeAVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PFocm/x4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C1AC19425;
	Mon, 27 Apr 2026 13:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777297881;
	bh=3shOJYtBwIkZvQMhtlzAau9neKcXD6O4OFZl67h8sUk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PFocm/x49aVYroHzlyGEdKs6h2pXYwEQttY9X3ZhPR+56hr+Klt21M7lJ4nDNpsGP
	 L3PtLbb7fakXWZzHdVFN7884mYvrX1oxig1vzsboHgmkjwb2EvhrN11r9LQheI6tTy
	 Q/+GWAe3jxy42sPiRIoy1+vI7I7EIPk8QCWTUpfSUZ/jUlZsa/JRws+0wcFJPJ5wRr
	 JjuHnKU2s0tbvxRDxg5/5kgxY868JAAkRhQ5h1mth3Qxp753u9zW3RxXo3Z+hez+Mv
	 apuDrVkobA1OevTlSB6k2i4xgnKk2Oaq3FKllsFW0C1uAepC4N6kAa8c75ITt0YQFg
	 orNqYbQeILB2A==
From: Chuck Lever <cel@kernel.org>
Date: Mon, 27 Apr 2026 09:50:54 -0400
Subject: [PATCH 10/18] SUNRPC: Switch MIC token verification to crypto/krb5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-crypto-krb5-api-v1-10-1fc1253b64c0@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3231;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=0dcsJobPrsjsjfNQRSiBpNQCew6ChgPlIgJ+JiXeORQ=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp72nGyn10Ds6sYjkW1sj4sdjhxVPTDPUCpptr6
 37iOA1vc5aJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCae9pxgAKCRAzarMzb2Z/
 ly3PD/9YpTp6XiUXYQvtGICdr0Wzw9KNbzPgEx5LJae7eweuuKt8q5a02sgclDn4OryJ0nZydSu
 3anEJE9CmmEmArFptncz2jolYGqBIzZjgGOPxCw3PXbc00g18PZcys4f1kSff9OPKgXhASXqlJx
 3LgOlT9kiDsJolxlbTKWOFAEpvf890rgThJsYSWcOehgy37NpaUbXyZw4n+bD5NSRnXNO9yUHcP
 vSYxqzyY8KLUYG5y5jVB9fhjKX+fWTL8Wn+3I+3IpZxuCsrfbctnXRfn8cENnQqmb77/8tlXnyp
 PJGfUQcZKtp+VdvhHSkxkWw3AQdSXN/t5F8d+knSI0Fbuzn5xDCDdoG6VbmE7Pr8fPDy8ZuCfqP
 LaZMvuPN7s1x1w4AGWJ/CKI+SCSRwziYEwszeeKUxLJ0mx7Dala1PnM52KySEQKnOPlNLE8b276
 ujwA9S2zoKJdAOcORlZ34yPXnkwAYCk+qJUIjYsMzqfWr0x6mJ+VZ/jLIusCdMT5suJ7QrIufuJ
 MkGNFvAVCff3KlybUp3LXC67FedtA3KP/voAXhu5LFP3ReyT9V2D2T/GK4K4tAuqu9rva+5qInK
 qnjpkCZdzTQjvtJXL00A806lL71Cp9TA3udGcbgQ16GKnzS4PmcrRG4aL+RgZeSwikvCK+6s35z
 H8vEitosxN5ox1g==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 46C12473D53
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
	TAGGED_FROM(0.00)[bounces-21187-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:mid,oracle.com:email]

From: Chuck Lever <chuck.lever@oracle.com>

gss_krb5_verify_mic_v2() currently recomputes a checksum using
gss_krb5_checksum() and then compares it against the received
checksum with memcmp(). Replace this with a call to
crypto_krb5_verify_mic(), which performs the hash, comparison,
and offset/length adjustment in a single operation through the
crypto/krb5 library.

The scatterlist layout required by RFC 4121 Section 4.2.4 is
constructed via gss_krb5_mic_build_sg(), the shared helper
introduced in the preceding commit. The received checksum
occupies the first scatterlist entry, pointing directly into
the token buffer.

The errno result from crypto_krb5_verify_mic() is mapped to a
GSS major status code via gss_krb5_errno_to_status(), which
returns GSS_S_BAD_SIG for -EBADMSG (checksum mismatch).

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_krb5_unseal.c | 36 ++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/net/sunrpc/auth_gss/gss_krb5_unseal.c b/net/sunrpc/auth_gss/gss_krb5_unseal.c
index ef0e6af9fc95..b5fb70419faa 100644
--- a/net/sunrpc/auth_gss/gss_krb5_unseal.c
+++ b/net/sunrpc/auth_gss/gss_krb5_unseal.c
@@ -60,6 +60,8 @@
 #include <linux/types.h>
 #include <linux/jiffies.h>
 #include <linux/sunrpc/gss_krb5.h>
+#include <linux/scatterlist.h>
+#include <linux/slab.h>
 
 #include "gss_krb5_internal.h"
 
@@ -71,18 +73,19 @@ u32
 gss_krb5_verify_mic_v2(struct krb5_ctx *ctx, struct xdr_buf *message_buffer,
 		       struct xdr_netobj *read_token)
 {
-	struct crypto_ahash *tfm = ctx->initiate ?
-				   ctx->acceptor_sign : ctx->initiator_sign;
-	char cksumdata[GSS_KRB5_MAX_CKSUM_LEN];
-	struct xdr_netobj cksumobj = {
-		.len	= ctx->gk5e->cksumlength,
-		.data	= cksumdata,
-	};
+	const struct krb5_enctype *krb5 = ctx->krb5e;
+	struct crypto_shash *shash = ctx->initiate ?
+		ctx->acceptor_sign_shash : ctx->initiator_sign_shash;
+	unsigned int cksum_len = krb5->cksum_len;
+	struct scatterlist sg_head[XDR_BUF_TO_SG_NENTS];
+	struct scatterlist *sg_overflow;
+	size_t mic_offset, mic_len;
 	u8 *ptr = read_token->data;
 	__be16 be16_ptr;
 	time64_t now;
 	u8 flags;
-	int i;
+	int nsg, i;
+	int ret;
 
 	dprintk("RPC:       %s\n", __func__);
 
@@ -104,13 +107,20 @@ gss_krb5_verify_mic_v2(struct krb5_ctx *ctx, struct xdr_buf *message_buffer,
 		if (ptr[i] != 0xff)
 			return GSS_S_DEFECTIVE_TOKEN;
 
-	if (gss_krb5_checksum(tfm, ptr, GSS_KRB5_TOK_HDR_LEN,
-			      message_buffer, 0, &cksumobj))
+	nsg = gss_krb5_mic_build_sg(message_buffer,
+				    ptr + GSS_KRB5_TOK_HDR_LEN,
+				    cksum_len, ptr,
+				    sg_head, &sg_overflow);
+	if (nsg < 0)
 		return GSS_S_FAILURE;
 
-	if (memcmp(cksumobj.data, ptr + GSS_KRB5_TOK_HDR_LEN,
-				ctx->gk5e->cksumlength))
-		return GSS_S_BAD_SIG;
+	mic_offset = 0;
+	mic_len = cksum_len + message_buffer->len + GSS_KRB5_TOK_HDR_LEN;
+	ret = crypto_krb5_verify_mic(krb5, shash, NULL, sg_head, nsg,
+				     &mic_offset, &mic_len);
+	kfree(sg_overflow);
+	if (ret)
+		return gss_krb5_errno_to_status(ret);
 
 	/* it got through unscathed.  Make sure the context is unexpired */
 	now = ktime_get_real_seconds();

-- 
2.53.0


