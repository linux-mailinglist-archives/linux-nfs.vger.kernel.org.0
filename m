Return-Path: <linux-nfs+bounces-21188-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LVgF+dr72nFBAEAu9opvQ
	(envelope-from <linux-nfs+bounces-21188-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 16:00:07 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3521F473E8A
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 16:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8DFD93010805
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 13:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EDA53D75D3;
	Mon, 27 Apr 2026 13:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OMQWZGMu"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2243D75C9;
	Mon, 27 Apr 2026 13:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777297883; cv=none; b=hh1i+4lZECSQ54K3KgxeuDbXfefi6TyMkN72xIzerAjDrfsG6B4jTQgaPNP2Rv6h9jolK9CkveAHHdtdeLEffH+WRSbJsZAzbpRW4I5+bhpRCmHmghy39urMNs/1r3z6vqzWSKTw7k6OcaTcTcgQup1TA7T42Q7zhHX0ocbaGWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777297883; c=relaxed/simple;
	bh=gOd4QtnOZY12A1Ot1uXAzdkY2kPXnXnhNWUqsatweSA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gLoZv2MdnuViyCdxI5NWc/6rCQ+SxCADbGGU28mj4bNKAWg/hYiN2Iek8gdcCCfOeB05pU8dSWakmHR0YTA5kS4yKml5piopUEZ64i4+b/JwnYOmWLsAiiCa78D3BwkafOiq9m28pIHBoC1nGMZM7tHKobqrsyhU47Wy2iVLbiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OMQWZGMu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B18CC2BCB4;
	Mon, 27 Apr 2026 13:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777297882;
	bh=gOd4QtnOZY12A1Ot1uXAzdkY2kPXnXnhNWUqsatweSA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OMQWZGMuqkdv3Gh0uJCtm6puV1ziAO+fKeAhfsFASaNv7hw9Bt9K48hNmOpL817Gs
	 V6pj/AgH/hCLMio8X3ePIZdwpcInAeMQDTZcWpjSaduyaeWNhTaYUVoRoaEH9KUaBt
	 /gM+udehCpegsqlcpzmUfefR4E5e5cOacNcdh2l5MzPW9E7fuKNw61y4nYfHhGZ+kU
	 /cLxtuH5WkFxfxEQIHQsz5nz2jCsJ3D+JHVV8L/zgTIcSSPcUMAfthY9appuBoCj/5
	 cipySnvKvi5qEW6fpxDcc09+EwrT0ROJE9Dty0DpfC9JK+WnUI4YEqEbHEOw8AxBmM
	 ecLUieYweynXA==
From: Chuck Lever <cel@kernel.org>
Date: Mon, 27 Apr 2026 09:50:55 -0400
Subject: [PATCH 11/18] SUNRPC: Remove get_mic/verify_mic function pointers
 from enctype table
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-crypto-krb5-api-v1-11-1fc1253b64c0@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4091;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=HVTf5jSOxEkVGmyWHGj+15bNC17Rd0Qh3QZ2+6tLPn8=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp72nGWz7ReVKuwxYBL+PKSVeC/GOiISXKLAT1J
 8OYjZvpSFWJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCae9pxgAKCRAzarMzb2Z/
 l59eEACK6JIU6NZDa+KI63r5T8lL2qZugTf4vgsWXCnyA4me06XqLlgGKn+dkgHd5AFUlI8abyO
 T/ayn9XN3wCbRFD0GlwU+1ys7fhj1fYZV1rqKUx+0AZZ4eCIdzyb3KWr+1oHYoEOPrFLLarA+hA
 tm8wlS0p2kNENhffll7c/04qIRosRHpKblCGEorAwPWGYsslOd80SZMUJGZnnZL5Ep0N70aCZH9
 mrhfXKP6N9m1SoAvuByyf3pjWYrA6IQZ5l53m14tmh3UDmkoYw9F56hPEYCJQBN0QOOViDeY5kz
 vAyyK2A+oZMDBDHDtgRtFws35Ut2Uke5X5uXaRqeLy+1l3lPi18T8F1rI7+pi3UXFT5YZBByFTX
 JKjvgxRi3a7YYXjqsIT57RBedBto3aP6scL7wWROoxJ2qsqHrwUNBTmZNMPheb/YCELH86r4fYR
 fawkqAIS3gbsIusVxcGMsHmkbFSNWpMCP7g/b7HlsV4x7kI/y7gA9ixQhP70hL76xlPsIj+bfMA
 VvMRGizA1PgWTLmNJy4SxaXJRq1hYxP/35qgEJi6TUWsz8yHzaUzfoFhaDBHpCx9cy7rRHLyVQn
 A6jVlFFJrGOg8GcaQGy7H4wpvoP6UI5SUpiJWdAwh0rOl2B/98qgo3O2Vph3QIXwS9PwnYtfNt9
 33FnNYQkoDtbZUQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 3521F473E8A
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
	TAGGED_FROM(0.00)[bounces-21188-lists,linux-nfs=lfdr.de];
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

Every enctype in the table points .get_mic and .verify_mic at
the same pair of functions. The indirection served no purpose
after the v1 enctype support was removed. Call
gss_krb5_get_mic_v2() and gss_krb5_verify_mic_v2() directly
from the GSS mechanism dispatch and drop the function pointers
from struct gss_krb5_enctype.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_krb5_internal.h |  4 ----
 net/sunrpc/auth_gss/gss_krb5_mech.c     | 16 ++--------------
 2 files changed, 2 insertions(+), 18 deletions(-)

diff --git a/net/sunrpc/auth_gss/gss_krb5_internal.h b/net/sunrpc/auth_gss/gss_krb5_internal.h
index 83e969494b54..a63f8d465b63 100644
--- a/net/sunrpc/auth_gss/gss_krb5_internal.h
+++ b/net/sunrpc/auth_gss/gss_krb5_internal.h
@@ -44,10 +44,6 @@ struct gss_krb5_enctype {
 		       struct xdr_buf *buf, struct page **pages);
 	u32 (*decrypt)(struct krb5_ctx *kctx, u32 offset, u32 len,
 		       struct xdr_buf *buf, u32 *headskip, u32 *tailskip);
-	u32 (*get_mic)(struct krb5_ctx *kctx, struct xdr_buf *text,
-		       struct xdr_netobj *token);
-	u32 (*verify_mic)(struct krb5_ctx *kctx, struct xdr_buf *message_buffer,
-			  struct xdr_netobj *read_token);
 	u32 (*wrap)(struct krb5_ctx *kctx, int offset,
 		    struct xdr_buf *buf, struct page **pages);
 	u32 (*unwrap)(struct krb5_ctx *kctx, int offset, int len,
diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index 9a5e367fef5b..511e19e0e786 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -46,8 +46,6 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 	  .encrypt = gss_krb5_aead_encrypt,
 	  .decrypt = gss_krb5_aead_decrypt,
 
-	  .get_mic = gss_krb5_get_mic_v2,
-	  .verify_mic = gss_krb5_verify_mic_v2,
 	  .wrap = gss_krb5_wrap_v2,
 	  .unwrap = gss_krb5_unwrap_v2,
 
@@ -75,8 +73,6 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 	  .encrypt = gss_krb5_aead_encrypt,
 	  .decrypt = gss_krb5_aead_decrypt,
 
-	  .get_mic = gss_krb5_get_mic_v2,
-	  .verify_mic = gss_krb5_verify_mic_v2,
 	  .wrap = gss_krb5_wrap_v2,
 	  .unwrap = gss_krb5_unwrap_v2,
 
@@ -114,8 +110,6 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 		.encrypt	= gss_krb5_aead_encrypt,
 		.decrypt	= gss_krb5_aead_decrypt,
 
-		.get_mic	= gss_krb5_get_mic_v2,
-		.verify_mic	= gss_krb5_verify_mic_v2,
 		.wrap		= gss_krb5_wrap_v2,
 		.unwrap		= gss_krb5_unwrap_v2,
 	},
@@ -140,8 +134,6 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 		.encrypt	= gss_krb5_aead_encrypt,
 		.decrypt	= gss_krb5_aead_decrypt,
 
-		.get_mic	= gss_krb5_get_mic_v2,
-		.verify_mic	= gss_krb5_verify_mic_v2,
 		.wrap		= gss_krb5_wrap_v2,
 		.unwrap		= gss_krb5_unwrap_v2,
 	},
@@ -169,8 +161,6 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 		.encrypt	= gss_krb5_aead_encrypt,
 		.decrypt	= gss_krb5_aead_decrypt,
 
-		.get_mic	= gss_krb5_get_mic_v2,
-		.verify_mic	= gss_krb5_verify_mic_v2,
 		.wrap		= gss_krb5_wrap_v2,
 		.unwrap		= gss_krb5_unwrap_v2,
 	},
@@ -195,8 +185,6 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 		.encrypt	= gss_krb5_aead_encrypt,
 		.decrypt	= gss_krb5_aead_decrypt,
 
-		.get_mic	= gss_krb5_get_mic_v2,
-		.verify_mic	= gss_krb5_verify_mic_v2,
 		.wrap		= gss_krb5_wrap_v2,
 		.unwrap		= gss_krb5_unwrap_v2,
 	},
@@ -601,7 +589,7 @@ static u32 gss_krb5_get_mic(struct gss_ctx *gctx, struct xdr_buf *text,
 {
 	struct krb5_ctx *kctx = gctx->internal_ctx_id;
 
-	return kctx->gk5e->get_mic(kctx, text, token);
+	return gss_krb5_get_mic_v2(kctx, text, token);
 }
 
 /**
@@ -623,7 +611,7 @@ static u32 gss_krb5_verify_mic(struct gss_ctx *gctx,
 {
 	struct krb5_ctx *kctx = gctx->internal_ctx_id;
 
-	return kctx->gk5e->verify_mic(kctx, message_buffer, read_token);
+	return gss_krb5_verify_mic_v2(kctx, message_buffer, read_token);
 }
 
 /**

-- 
2.53.0


