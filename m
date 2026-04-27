Return-Path: <linux-nfs+bounces-21193-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCiJIZJr72nFBAEAu9opvQ
	(envelope-from <linux-nfs+bounces-21193-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 15:58:42 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 257DA473E28
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 15:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C819E3091DDC
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 13:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E6E3DA5B6;
	Mon, 27 Apr 2026 13:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dLtXvah/"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726983DA5B3;
	Mon, 27 Apr 2026 13:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777297891; cv=none; b=YH+lEeZIINoArt6IYcSpdRJ2HYSdjVKfEisWosyWbBHImn+rzC4WoiQTI1FAHL5LEkkBSlBFdtXt/W5MmzaI56VJv50n9vPsrDkGAinAya52n5u7ApTiGyUOrtgVST7kwqP2a3Pm/9p/hqD3GEz3+GpcjfAZSK/4yZur49S50g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777297891; c=relaxed/simple;
	bh=uDKhrJ7x7ffxZoObrA4/cf+HeGWhcqfbzRxPIKUrSkY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kIhiJK3ZuO0l7X4va8orIykDToudzwj2fXdOpfWrtu3+t/7UjFV+WJElikKIsy8ehPsezi+sRbhpQAqIx7EA8UmcwYBmyW+Jmb1HbpiO5sxMKIFi3g5DwEc/YRzl9/mzXBM1da0bjkmMhBX/L1TGYB61NAriA7N/UfFXXcG6yRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dLtXvah/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0CEBC2BCC6;
	Mon, 27 Apr 2026 13:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777297891;
	bh=uDKhrJ7x7ffxZoObrA4/cf+HeGWhcqfbzRxPIKUrSkY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dLtXvah/XjuJibyPwvo8WEPO3ox828tQ0+pJi3cOMkIiRd13GZlK6Vlahqxxu2TfR
	 xZiOxvzoJ51OXxOb/MqEWx8ZdSISXhj0WM+uat1A8/6O1PvP1XmvJJDsMd4lO+s/g6
	 DtA+a1SIqLRmJkfRAJx53h24x1rP/034zDjc5+/YTNYuothC9NxbkOtI/bshxeWvlo
	 sT+/KfofD5rG2iNElzSHuUCRCvULf8MCSdz3iF6QhMRzI8re8R3ONYm5LYrkGdpxuw
	 WBwhXHf7AMWlUCp67mtz6SBZaE3o68UsddBIzFLPQ+d6E1zVsDApeAS0Tqp10kXRYx
	 WYx4WK0ilECZA==
From: Chuck Lever <cel@kernel.org>
Date: Mon, 27 Apr 2026 09:51:00 -0400
Subject: [PATCH 16/18] SUNRPC: Remove per-enctype Kconfig options
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-crypto-krb5-api-v1-16-1fc1253b64c0@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4734;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=tNPqHJXQbmnKY7HdI3pJcdNeP8u9XHsjgRxKVFE1wLY=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp72nG2wRVEla/X54Wa9jzx9l4H9AIkRkws5LLI
 rl97R5PdE6JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCae9pxgAKCRAzarMzb2Z/
 l4Y6D/9N56r4wK8ntbDXz4DIve5wI4fnuGqkLbGCOu82OnBl0imeit7WXBqeShhkA0CAi0eK5s0
 /V/gfuoygBDjmj6vPUSfZpMAqWHkjRiPN2qWkoLKd3Xg5HWNdwWHxnAPRbgkK9uKHPx5UfVIycz
 JI/q4xrlA+rU9MBtI/pX/TZwSA3jyXOUqhl0/SHX2fR9+jlGtpSL/1aNva6rlakC1nvD0/3msRW
 JuSsmXJFDBhViphExnAzYD9ipU94OkV5tjMbntsb2vY2cR+vngoDP+I2s0oFCrNaiZIIGrUm1u5
 fjB8+W2CgGtJn6L3TlawK3oSdOdubFBda7oaifShpsh2YMpcPyPQFHSEtK0+WSpQ9pgSzdP7w1K
 jg53b1qB0CydTb2ADo11YCsHYDnSPf0to1Af1sXPmVPBibiJWoZS9E4f5iNHh1z/+keeB6DDZYf
 RxEy8kghAc77Cb4fAQQj3sGwQvwwAsa178BOI/QHDNaeN8lLK9TvrSj+z0T/1G8vi2OFOP3iG+1
 DspXgkNNaGKVevxUvb+zK8xHrCP53WnJZOpNhPW09q4iifLxx62tIYluQfbzGhymMGFSJ5vxZED
 c2lTWXF1z7H4w6tNS5QYQxWp/NZ7kYBB1u2SB+FJQgrjQEEIEQNIuPZnNF8u7UTGD/dlfs7O1oF
 m+CrJyXDORtegew==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: 257DA473E28
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
	TAGGED_FROM(0.00)[bounces-21193-lists,linux-nfs=lfdr.de];
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

The RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1,
RPCSEC_GSS_KRB5_ENCTYPES_CAMELLIA, and
RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA2 Kconfig options
originally gated both algorithm availability and the
advertised enctype list. Now that per-message crypto
operations are routed through crypto/krb5, these options
control only which enctype numbers appear in the gssd
upcall string; the underlying algorithms are always
present.

Remove the per-enctype Kconfig options and replace the
ifdef-gated enctype table with a candidate list looked
up in the crypto/krb5 enctype table at module init
time. Each enctype is included in the advertised list
only if crypto_krb5_find_enctype() finds it in the
library's enctype table. When a new enctype is added
to crypto/krb5, adding its constant to the candidate
array is sufficient to begin advertising it.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/Kconfig                  | 38 -------------------------------------
 net/sunrpc/auth_gss/gss_krb5_mech.c | 30 ++++++++++++++---------------
 2 files changed, 14 insertions(+), 54 deletions(-)

diff --git a/net/sunrpc/Kconfig b/net/sunrpc/Kconfig
index 1c2e1fe9d365..305c55cdbd45 100644
--- a/net/sunrpc/Kconfig
+++ b/net/sunrpc/Kconfig
@@ -35,44 +35,6 @@ config RPCSEC_GSS_KRB5
 
 	  If unsure, say Y.
 
-config RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1
-	bool "Enable Kerberos enctypes based on AES and SHA-1"
-	depends on RPCSEC_GSS_KRB5
-	depends on CRYPTO_CBC && CRYPTO_CTS
-	depends on CRYPTO_HMAC && CRYPTO_SHA1
-	depends on CRYPTO_AES
-	default y
-	help
-	  Choose Y to enable the use of Kerberos 5 encryption types
-	  that utilize Advanced Encryption Standard (AES) ciphers and
-	  SHA-1 digests. These include aes128-cts-hmac-sha1-96 and
-	  aes256-cts-hmac-sha1-96.
-
-config RPCSEC_GSS_KRB5_ENCTYPES_CAMELLIA
-	bool "Enable Kerberos encryption types based on Camellia and CMAC"
-	depends on RPCSEC_GSS_KRB5
-	depends on CRYPTO_CBC && CRYPTO_CTS && CRYPTO_CAMELLIA
-	depends on CRYPTO_CMAC
-	default n
-	help
-	  Choose Y to enable the use of Kerberos 5 encryption types
-	  that utilize Camellia ciphers (RFC 3713) and CMAC digests
-	  (NIST Special Publication 800-38B). These include
-	  camellia128-cts-cmac and camellia256-cts-cmac.
-
-config RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA2
-	bool "Enable Kerberos enctypes based on AES and SHA-2"
-	depends on RPCSEC_GSS_KRB5
-	depends on CRYPTO_CBC && CRYPTO_CTS
-	depends on CRYPTO_HMAC && CRYPTO_SHA256 && CRYPTO_SHA512
-	depends on CRYPTO_AES
-	default n
-	help
-	  Choose Y to enable the use of Kerberos 5 encryption types
-	  that utilize Advanced Encryption Standard (AES) ciphers and
-	  SHA-2 digests. These include aes128-cts-hmac-sha256-128 and
-	  aes256-cts-hmac-sha384-192.
-
 config SUNRPC_DEBUG
 	bool "RPC: Enable dprintk debugging"
 	depends on SUNRPC && SYSCTL
diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index 5a52fd84f946..996e452b9b3c 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -28,27 +28,23 @@
 static struct gss_api_mech gss_kerberos_mech;
 
 /*
- * The list of advertised enctypes is specified in order of most
- * preferred to least.
+ * Candidate enctypes in order of most preferred to least.
+ * Each is probed against crypto/krb5 at module init; only
+ * enctypes that crypto/krb5 supports are advertised.
  */
+static const u32 gss_krb5_enctypes[] = {
+	ENCTYPE_AES256_CTS_HMAC_SHA384_192,
+	ENCTYPE_AES128_CTS_HMAC_SHA256_128,
+	ENCTYPE_CAMELLIA256_CTS_CMAC,
+	ENCTYPE_CAMELLIA128_CTS_CMAC,
+	ENCTYPE_AES256_CTS_HMAC_SHA1_96,
+	ENCTYPE_AES128_CTS_HMAC_SHA1_96,
+};
+
 static char gss_krb5_enctype_priority_list[64];
 
 static void gss_krb5_prepare_enctype_priority_list(void)
 {
-	static const u32 gss_krb5_enctypes[] = {
-#if defined(CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA2)
-		ENCTYPE_AES256_CTS_HMAC_SHA384_192,
-		ENCTYPE_AES128_CTS_HMAC_SHA256_128,
-#endif
-#if defined(CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_CAMELLIA)
-		ENCTYPE_CAMELLIA256_CTS_CMAC,
-		ENCTYPE_CAMELLIA128_CTS_CMAC,
-#endif
-#if defined(CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1)
-		ENCTYPE_AES256_CTS_HMAC_SHA1_96,
-		ENCTYPE_AES128_CTS_HMAC_SHA1_96,
-#endif
-	};
 	size_t total, i;
 	char buf[16];
 	char *sep;
@@ -57,6 +53,8 @@ static void gss_krb5_prepare_enctype_priority_list(void)
 	sep = "";
 	gss_krb5_enctype_priority_list[0] = '\0';
 	for (total = 0, i = 0; i < ARRAY_SIZE(gss_krb5_enctypes); i++) {
+		if (!crypto_krb5_find_enctype(gss_krb5_enctypes[i]))
+			continue;
 		n = sprintf(buf, "%s%u", sep, gss_krb5_enctypes[i]);
 		if (n < 0)
 			break;

-- 
2.53.0


