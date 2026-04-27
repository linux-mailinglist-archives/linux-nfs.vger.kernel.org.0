Return-Path: <linux-nfs+bounces-21189-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2O/sEx5r72nFBAEAu9opvQ
	(envelope-from <linux-nfs+bounces-21189-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 15:56:46 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D639C473D96
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 15:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0A859301AF37
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 13:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8CE3D8108;
	Mon, 27 Apr 2026 13:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AmEZV2/x"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20093CF682;
	Mon, 27 Apr 2026 13:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777297884; cv=none; b=ACV/SJtAno7h0r7/9vpFxNiQKQeXaZMtnC2rSyIyOo+FBiQ1ZRsxR7a/BI8Z3qo5p3skN1kG6TXoPw3Dej/bsXDS4HSPHnNiD+5PM+qjZB9QfVFRyWmQP89w3axuuYFoZ5VkQ54n3mRxibvQrOtA592MOA8Qym4Fa/DgbL4goa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777297884; c=relaxed/simple;
	bh=egYLvfDqeAfSxlqHCUEczvOB8wEdCBL9wIzAZOjLZco=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sv4jb0i0UXw/byEetKuxf99zzoxgwKa+Z5SzjYPdacjub0aY40v5I6s9JSIS7K2qb2c4upyTN8geHytChphOC7uigN03fbq9ltqptZt/Cror9c9NByZ0yr9CBDsTkzN0MvYTsHYgIg3GyssQetzQvRqa/TvzG7L1jzOeLd9PViQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AmEZV2/x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3C0CC2BCB7;
	Mon, 27 Apr 2026 13:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777297884;
	bh=egYLvfDqeAfSxlqHCUEczvOB8wEdCBL9wIzAZOjLZco=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AmEZV2/xQAuhZkxNguNZU74qpUdF3uZ8Ffq/Mup8QQGj6tH7D/c3T53U7yQ439FYo
	 f53GIFvz3i4jHb0aAzzFewMZNULilSysmb2E692ArX30TAUsX21AuVMEvAUaymIq0i
	 cHZ9NWjEbJpCNsd8XKN0knHYgNDP6Qv1DIwrkbz1vDUQgMXW2tLpCJtodpPRl7ayCE
	 xESB08uChyn+8aPISw1ujVNHO6b05xYQXEYP7USNBZxMa+ApY2B0DY7LBQHRdXytlJ
	 bL5SdLZO1Dzr+s5QeDfJIcXfuJeUsyRGQJSWaaLBXAtQUk59TB/uOuaKaWmTUkIQie
	 8Yt5StoUMlUQQ==
From: Chuck Lever <cel@kernel.org>
Date: Mon, 27 Apr 2026 09:50:56 -0400
Subject: [PATCH 12/18] SUNRPC: Remove wrap/unwrap function pointers from
 enctype table
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-crypto-krb5-api-v1-12-1fc1253b64c0@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3727;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=Uwl3PFwk22qkNrr0ypGYiXqldKy+foUyUwbJ9/2un/E=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp72nGOfoyY8krkOQfQRJwpzPa/2amZXBRC0NKd
 chxNVv5ws6JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCae9pxgAKCRAzarMzb2Z/
 l9frEAC/Tv4Q1KR1GB+Gb3BDH8p7wC7YIhES/JWlmr+bqkoTDhw6Q9GKPjEpnvsuOCEqVZfZIKt
 MKhmHl86voBzNM5o88WEsN0KLrDX3mwlaGoLwGtE0otLTztu7pqiWLyRdoWRL2RItHwGg4FpvJ7
 71H+U9BKxX4RA8PiyFo78rPTFR7nPbYaxVXvad7dzNmq6NYvxxC5yVm/qcD6b9nVjRou9bQg0kX
 Y5kfPg91CmnaRzI/4hUChZYw4PL0umyIONQmmSKIhEB8cKsljTym25jh7QJVFAqulXN0hN0MWfG
 DvbrGHI2DkNWevYfCG3/nUFZC9noI11CNsG6+hro1W3/6AmwAx3+qF+4aMLAk5OmzlwpJiEAtx+
 sWHHBIZXlg3iCDtC7TtevcArKboEP8IKbLcd4c0AGe3LgvNMx09yNhahU/RvMlDQ6ElNwiYgnwL
 OG3YzHSd6rqMRgS0TGJy8kFdvJFMzvbpNRKx1tEEUMQlfARIRt1pt1QOYVGblEQLRRgsf0FkOv+
 1YgWH0PK2XMp/0Azqu8AzSDiUnm9q0Ri6/nR1YG7C5lvfnVt0Lpuh4EDwchKBrAH1lnImU5GN/p
 X+3Qb/6AmI5N5b8BUwYwLTp4fMLeRrEddcqrMxOy2mq8cjfZtsPh6fmvgc2vj5y4MwHrtZn37UK
 TrM/Te/76TmpePA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: D639C473D96
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
	TAGGED_FROM(0.00)[bounces-21189-lists,linux-nfs=lfdr.de];
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

Every enctype points .wrap and .unwrap at gss_krb5_wrap_v2()
and gss_krb5_unwrap_v2(). As with get_mic/verify_mic, the
indirection dates from when v1 enctypes had different wrap
implementations. Call the functions directly and remove the
pointers from struct gss_krb5_enctype.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_krb5_internal.h |  5 -----
 net/sunrpc/auth_gss/gss_krb5_mech.c     | 18 ++----------------
 2 files changed, 2 insertions(+), 21 deletions(-)

diff --git a/net/sunrpc/auth_gss/gss_krb5_internal.h b/net/sunrpc/auth_gss/gss_krb5_internal.h
index a63f8d465b63..92b0baed920c 100644
--- a/net/sunrpc/auth_gss/gss_krb5_internal.h
+++ b/net/sunrpc/auth_gss/gss_krb5_internal.h
@@ -44,11 +44,6 @@ struct gss_krb5_enctype {
 		       struct xdr_buf *buf, struct page **pages);
 	u32 (*decrypt)(struct krb5_ctx *kctx, u32 offset, u32 len,
 		       struct xdr_buf *buf, u32 *headskip, u32 *tailskip);
-	u32 (*wrap)(struct krb5_ctx *kctx, int offset,
-		    struct xdr_buf *buf, struct page **pages);
-	u32 (*unwrap)(struct krb5_ctx *kctx, int offset, int len,
-		      struct xdr_buf *buf, unsigned int *slack,
-		      unsigned int *align);
 };
 
 /* krb5_ctx flags definitions */
diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index 511e19e0e786..d027ddab132f 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -46,9 +46,6 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 	  .encrypt = gss_krb5_aead_encrypt,
 	  .decrypt = gss_krb5_aead_decrypt,
 
-	  .wrap = gss_krb5_wrap_v2,
-	  .unwrap = gss_krb5_unwrap_v2,
-
 	  .signalg = -1,
 	  .sealalg = -1,
 	  .keybytes = 16,
@@ -73,9 +70,6 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 	  .encrypt = gss_krb5_aead_encrypt,
 	  .decrypt = gss_krb5_aead_decrypt,
 
-	  .wrap = gss_krb5_wrap_v2,
-	  .unwrap = gss_krb5_unwrap_v2,
-
 	  .signalg = -1,
 	  .sealalg = -1,
 	  .keybytes = 32,
@@ -110,8 +104,6 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 		.encrypt	= gss_krb5_aead_encrypt,
 		.decrypt	= gss_krb5_aead_decrypt,
 
-		.wrap		= gss_krb5_wrap_v2,
-		.unwrap		= gss_krb5_unwrap_v2,
 	},
 	/*
 	 * Camellia-256 with CMAC (RFC 6803)
@@ -134,8 +126,6 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 		.encrypt	= gss_krb5_aead_encrypt,
 		.decrypt	= gss_krb5_aead_decrypt,
 
-		.wrap		= gss_krb5_wrap_v2,
-		.unwrap		= gss_krb5_unwrap_v2,
 	},
 #endif
 
@@ -161,8 +151,6 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 		.encrypt	= gss_krb5_aead_encrypt,
 		.decrypt	= gss_krb5_aead_decrypt,
 
-		.wrap		= gss_krb5_wrap_v2,
-		.unwrap		= gss_krb5_unwrap_v2,
 	},
 	/*
 	 * AES-256 with SHA-384 (RFC 8009)
@@ -185,8 +173,6 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 		.encrypt	= gss_krb5_aead_encrypt,
 		.decrypt	= gss_krb5_aead_decrypt,
 
-		.wrap		= gss_krb5_wrap_v2,
-		.unwrap		= gss_krb5_unwrap_v2,
 	},
 #endif
 };
@@ -631,7 +617,7 @@ static u32 gss_krb5_wrap(struct gss_ctx *gctx, int offset,
 {
 	struct krb5_ctx	*kctx = gctx->internal_ctx_id;
 
-	return kctx->gk5e->wrap(kctx, offset, buf, pages);
+	return gss_krb5_wrap_v2(kctx, offset, buf, pages);
 }
 
 /**
@@ -653,7 +639,7 @@ static u32 gss_krb5_unwrap(struct gss_ctx *gctx, int offset,
 {
 	struct krb5_ctx	*kctx = gctx->internal_ctx_id;
 
-	return kctx->gk5e->unwrap(kctx, offset, len, buf,
+	return gss_krb5_unwrap_v2(kctx, offset, len, buf,
 				  &gctx->slack, &gctx->align);
 }
 

-- 
2.53.0


