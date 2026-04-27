Return-Path: <linux-nfs+bounces-21181-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eIEwITpq72l3BAEAu9opvQ
	(envelope-from <linux-nfs+bounces-21181-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 15:52:58 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E9A473C66
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 15:52:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 07FC13017D7F
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 13:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBB4C3D4112;
	Mon, 27 Apr 2026 13:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rQ7/hzBt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63413D0918;
	Mon, 27 Apr 2026 13:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777297871; cv=none; b=OSEpnx9utfFVO4Exqf8nxNHr1i3YcT4XllA1dBgwBbInP4UmJhICObtC7BKPRnZErmLDYXKXcsDIBpYFH6eXGW/c8Mw9aITm/zLOM6UVw+CBN4abY05kGDwntQofa66cQfc6OCP50dlZFUrC2L0WfjyfC1X22qDj4dUjsneQsvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777297871; c=relaxed/simple;
	bh=4xG+sUSJGB5dFSk5Akbh6cKn56ztBxeZGPBYVNHyX58=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W6sdXGbutbV8JII7uyd2K9/nLlnTCQx0ZjvSAuxJ3X5ErV2DwmRqkcDYIM/u5U94nK73oNqev++JbpBCMLOQG7zg6cgaXvfZo7+jmJxjadYic/TOKrje244NkNZdpW9hWvo0RNCaytK+9rVpiJSN0554BT7vLYI9yKmqgm8UCZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rQ7/hzBt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D872BC2BCB4;
	Mon, 27 Apr 2026 13:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777297871;
	bh=4xG+sUSJGB5dFSk5Akbh6cKn56ztBxeZGPBYVNHyX58=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rQ7/hzBtdf/Ec91B3i5ccBvFD3hz+7J7RJAPrp5ekME9Vv5sf1pgD7GsbthyKU9Vv
	 Yn9ArMb9g0w+/ogDCEKVArJfLX5cTXbllIt+l7Rp6HcUrMQ5YFOz0T97xEkQoGg6Fr
	 fPltbE+jo4WjIGPXgt/RS1A4/o7tnmHBFeRn9uBh+qSc3S7hVnXae64aFot4NMbV0E
	 VDEQ+RfDv+4FZAMWqj8GEVqDih2VgElKkKh+v9qyth7z5Hru3lN/fHZfLN4U0BgKP0
	 hCoWg9Uw8kMRK39JPPbVSzcgvv9Lw11vF6m+VilSVzUnUevjVqItl/76Vu6gUFNs9D
	 6kclP6N8jFqsQ==
From: Chuck Lever <cel@kernel.org>
Date: Mon, 27 Apr 2026 09:50:48 -0400
Subject: [PATCH 04/18] SUNRPC: Add errno-to-GSS status conversion helper
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-crypto-krb5-api-v1-4-1fc1253b64c0@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2244;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=oevfqUvnbOg6hsj4ytxj2jS4VhqyKRDRd8J7EkBajg8=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp72nFIErD++ns6YvlY6R0ph4QCR+fX7f4zkUa9
 hb3AlWRK1CJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCae9pxQAKCRAzarMzb2Z/
 l2YKEADBwEXEFM/mJ2IIkIPcSdFoRrt2TlC+PmCLOUxAb3JPG5GYrjPKQ/VD6+hQ5qHZFIos6ot
 1zNx3ZvwDyX6Oyhf9pH1NcCYPNwhiu3FTV0KLzx1PxTnBSn0rMt8QdSP+k+95zUxY3gIzKLZjiP
 zJhwEBD91ez7PRT/C3tXxbkzu63SkxnluqyVBfbE8vyy4plHGh4a4zYfQ+hx8EwoAuZbE6IbwSO
 g2Lp281Ur7GRNwbaMuPc/RaVlIQH+PSSmwLqyu5e+VSaWfkCcqOQm+VXo1oI4W2CT+JwHQIgFzp
 TmAxPoMzxnlODvKrgowo3eFfdZRPJlKHpiSfhMcB7D/9cOK2gRjUCSsG68yC0ikQLxJx5GI54GO
 K2lJcxKeqcq32s50UiIK/qvQr9Oob8hIblgDaAN/1SFI1A4kl3XSiOVoG1D+NJOVTwPRw+h7ttB
 tkxXaEyShVxo4YaR50ybWVMwQE3IIqoQxowODEkkJyjOfwBPYBorN/pk/rdA9T7HGEb3oGX/LV/
 z3qRLU/67cOPfcTtePV5z1jK0hfCupP8WMS1jv6hdb9UqtIY+8ZFjKlJz0cjKB3cjQOwHLKYT4r
 TT+MKtZZUCAdCeEex/l07/cdfEIWpo1I01hJ9Evpb93SMp0VkbV0YaV024wPFHm/0els+vK0EKV
 AL0SvgiMAxKcvRA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 56E9A473C66
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
	TAGGED_FROM(0.00)[bounces-21181-lists,linux-nfs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:mid,oracle.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

From: Chuck Lever <chuck.lever@oracle.com>

The crypto/krb5 library returns standard negative errno values,
but the GSS mechanism layer reports results as GSS_S_* major
status codes. A translation is needed at each call site that
will be switched to the new library.

Rather than open-coding the mapping in every wrapper, provide a
single helper function.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_krb5_internal.h |  2 ++
 net/sunrpc/auth_gss/gss_krb5_mech.c     | 24 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/net/sunrpc/auth_gss/gss_krb5_internal.h b/net/sunrpc/auth_gss/gss_krb5_internal.h
index 11402c3b4972..a3fe4be3b9ae 100644
--- a/net/sunrpc/auth_gss/gss_krb5_internal.h
+++ b/net/sunrpc/auth_gss/gss_krb5_internal.h
@@ -180,6 +180,8 @@ u32 krb5_etm_encrypt(struct krb5_ctx *kctx, u32 offset, struct xdr_buf *buf,
 u32 krb5_etm_decrypt(struct krb5_ctx *kctx, u32 offset, u32 len,
 		     struct xdr_buf *buf, u32 *headskip, u32 *tailskip);
 
+u32 gss_krb5_errno_to_status(int err);
+
 #if IS_ENABLED(CONFIG_KUNIT)
 void krb5_nfold(u32 inbits, const u8 *in, u32 outbits, u8 *out);
 const struct gss_krb5_enctype *gss_krb5_lookup_enctype(u32 etype);
diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index 060d8fc4358e..7606bbd7b8c4 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -516,6 +516,30 @@ gss_krb5_delete_sec_context(void *internal_ctx)
 	kfree(kctx);
 }
 
+/**
+ * gss_krb5_errno_to_status - Map a negative errno to a GSS major status
+ * @err: negative errno value, or zero
+ *
+ * Returns:
+ *   %GSS_S_COMPLETE if @err is zero
+ *   %GSS_S_BAD_SIG if @err is -EBADMSG (integrity check failure)
+ *   %GSS_S_DEFECTIVE_TOKEN if @err is -EPROTO (malformed token)
+ *   %GSS_S_FAILURE for all other negative values
+ */
+u32 gss_krb5_errno_to_status(int err)
+{
+	switch (err) {
+	case 0:
+		return GSS_S_COMPLETE;
+	case -EBADMSG:
+		return GSS_S_BAD_SIG;
+	case -EPROTO:
+		return GSS_S_DEFECTIVE_TOKEN;
+	default:
+		return GSS_S_FAILURE;
+	}
+}
+
 /**
  * gss_krb5_get_mic - get_mic for the Kerberos GSS mechanism
  * @gctx: GSS context

-- 
2.53.0


