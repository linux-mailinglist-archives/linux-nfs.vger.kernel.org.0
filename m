Return-Path: <linux-nfs+bounces-21185-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KN6EC2dr72nFBAEAu9opvQ
	(envelope-from <linux-nfs+bounces-21185-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 15:57:59 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B008473DE0
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 15:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E5A6D303234F
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 13:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197A93D6477;
	Mon, 27 Apr 2026 13:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RcLs0jMv"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E518E3D646E;
	Mon, 27 Apr 2026 13:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777297878; cv=none; b=cNBEdNNAumvGdADyyKGfw6F7cBfkjzObbpoeH2cbruq2njTBh8F1NyoHh4MEbPfUK81Ir+zxVs4wWXScX0fiviJR2z3wgel2bGH2sJhW4BCj4yCuPAte8h3X2qWMsbcxyU3P8Nl4ZcdXnWAXuAv8Ag1cfpg4rFAwwVWqthDZv5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777297878; c=relaxed/simple;
	bh=k/K9/EiLn5wRpJ2NuvUquM2S7KuWzlaz51ggfW6HGSI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UTJXOtBpbNvBcqMwHK1xw0FHcDUAX0n/btW3K+z3W6aq/4l05940VzR55Dp11nQrtbPKQs1pEA52Jxge3wkd7ySGImuHLSlKYr/gEhUxa5wx7uqvxFwWKdX0xYqInrCCOXLIuvaW7bgiApTPFbd0AkcUCgRet+n+UZ4eh73mMSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RcLs0jMv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6584EC19425;
	Mon, 27 Apr 2026 13:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777297877;
	bh=k/K9/EiLn5wRpJ2NuvUquM2S7KuWzlaz51ggfW6HGSI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RcLs0jMvGPWIthf/KzGHE9kRB3UV6FIvnPfNO4leioHiB9q4vhVGAijabryu8zPOv
	 hmaILM4krbFSW7Dbd9lTMzhwGp2J9u11T/qaeHERLSXL2oQ5o+iNzrgCHd8hHyvxl0
	 oZFUy5Y88zrSWa21AqpnaagdWTjBbeIt81Jnt5ojwy72/oszQIQ+FB/CTQQhmbdBUN
	 qautxHzvYEX31/j9L7d9u8xLsyoxc5C+sX/7hz+ULjIg6SdrVvHYOhUwub8G/5CZNR
	 AVSLJXHYSorim4kmkSYcpQgHAep/sUPvciD4oxEIcrW7XyRAFl+QDreqMQ8YzRTycz
	 XPAIVZkI/QX2A==
From: Chuck Lever <cel@kernel.org>
Date: Mon, 27 Apr 2026 09:50:52 -0400
Subject: [PATCH 08/18] SUNRPC: Switch Camellia decrypt to crypto/krb5
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-crypto-krb5-api-v1-8-1fc1253b64c0@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1760;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=EKQj0Ql4x67SqTQ1pjG3yJEYqZdNDTI7xXPAYjK/xVQ=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp72nG2uAftq60rEKc3EZWwgPa+FvtKURHCFjOF
 P8VAgWzrBaJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCae9pxgAKCRAzarMzb2Z/
 l3gDD/42QUuyLN+oEbwG0rxVRb+oCxea+gCX9vaGWsiI2X+vq5S9IBdusgzHT9jAZ40RocolM8P
 J0sTYGigekXO84ACWrcrxIiEWx8S8GxPkg75PcAW/htKp2gffnZden1RNoKYX5sF8iXkgF8Bgl6
 guWzXukUSvHKrfrRpN/YyzQuB7m/TqFUygfa8LdNTvUFWTwU6sy1r2vNDVQJzyB+eXFTnSkex5M
 UIAuXsm/ZRON3Y7U8PiL0VqtEMnQ5zXBqzgvlfwBMWuj6jAsABY63uSoWQ9m2hyzoewyOspNDMV
 VkMxeU0I51D+BeA/5zjO43xUAn7noThBzDhM2piEQ+BQXw5EInV8euSNX5iVit0Ij8aEUxcb833
 81viZfEe/OwtiCtekkDLT0CeeXJXB8FNnUMnYrM6PwVp9mPbzxDzJQYRrzo9BA1NhcH+jDpcBku
 /CNEAU+Bk44XuMdJYIGBx3GVsYxWlldZ+HxcqjL3cXm4RmD9CruQq3gs0uohPkPS+zzEIOsHVeQ
 FORJteO13yOX//56EEL33CXywDX4no5OQnb4KR9RNr034KdwvO4dE2maY+xkm2eLNjytX6NWe7M
 PIpcH7Vi4V7sMmQmsOGerZ8O488/u/zyxj1mYOQRfRR6+88cQJsIqzLKrDnQFl418HK/x0oZT4m
 3hrE1nUr6zusxSA==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 2B008473DE0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21185-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oracle.com:mid,oracle.com:email]

From: Chuck Lever <chuck.lever@oracle.com>

The Camellia enctypes (RFC 6803) use the same MtE authenticated
encryption construction as AES-SHA1 (RFC 3962), implemented in
crypto/krb5 by the rfc3961_simplified profile. The encrypt path
already uses gss_krb5_aead_encrypt() for Camellia, but the decrypt
path was left on the old gss_krb5_aes_decrypt() code when the AES
enctypes were migrated.

Switch the Camellia .decrypt callback to gss_krb5_aead_decrypt() to
complete the AEAD migration for all enctypes. The conf_len and
cksum_len values in crypto/krb5's Camellia enctype descriptors match
the block size and checksum length that gss_krb5_aes_decrypt() was
using, so the headskip and tailskip returned to the unwrap layer are
unchanged.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_krb5_mech.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index 66372e152c3b..9a5e367fef5b 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -112,7 +112,7 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 
 		.derive_key	= krb5_kdf_feedback_cmac,
 		.encrypt	= gss_krb5_aead_encrypt,
-		.decrypt	= gss_krb5_aes_decrypt,
+		.decrypt	= gss_krb5_aead_decrypt,
 
 		.get_mic	= gss_krb5_get_mic_v2,
 		.verify_mic	= gss_krb5_verify_mic_v2,
@@ -138,7 +138,7 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 
 		.derive_key	= krb5_kdf_feedback_cmac,
 		.encrypt	= gss_krb5_aead_encrypt,
-		.decrypt	= gss_krb5_aes_decrypt,
+		.decrypt	= gss_krb5_aead_decrypt,
 
 		.get_mic	= gss_krb5_get_mic_v2,
 		.verify_mic	= gss_krb5_verify_mic_v2,

-- 
2.53.0


