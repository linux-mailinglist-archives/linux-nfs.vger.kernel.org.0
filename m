Return-Path: <linux-nfs+bounces-21195-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OI8Fslr72nFBAEAu9opvQ
	(envelope-from <linux-nfs+bounces-21195-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 15:59:37 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDC0473E5C
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 15:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2A0323016BA5
	for <lists+linux-nfs@lfdr.de>; Mon, 27 Apr 2026 13:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0FD3DA7F3;
	Mon, 27 Apr 2026 13:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SABeRa2T"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 730F33DA7ED;
	Mon, 27 Apr 2026 13:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777297894; cv=none; b=CZdcvmws56rHdLHAzBcdwf1yJ1DwFxLE8R+dDkNF7LlInDQgnusG/A/QXnykQYo6TYr/tyBrNCCnBBxz+3hH2cHU47cR6aQkmLoyp3TrevSER7uHECykZHJqlnmsvHD54baL4WjsOSzvEkrFN9qpoYM8DgCiYqysiBB9ksmeywk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777297894; c=relaxed/simple;
	bh=ee48qQ1ebmEk113ksktKi85c/cNBi1NXFBxr5NvstQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WWrrM47aE+/FfRux8bNHnhl2E0rB9FuNEVvcD9U14Dup5njP3T/oFRJ2KoDBqnNpfobPqXeNtEqvUW0xwMiF+0Kz/Dz7BWIUEhs8qZNn8TanPbM1gRsb0+5YXBPEClm6x+aQIgRZQkvfsgNeWZ1N11Y3FL3nIm8/Wdqn04/fNbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SABeRa2T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E66E8C2BCB4;
	Mon, 27 Apr 2026 13:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777297894;
	bh=ee48qQ1ebmEk113ksktKi85c/cNBi1NXFBxr5NvstQI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SABeRa2TSxwIaGAql/M/N4P/l6kM6uO/b8zYxE0xOTjTFThc5v3FDV3VmRcT3FpvO
	 gfTxZZIWSSXmWkblbdUkN8NeLztCYTI8KK8q4kFabCQM1X+vsm3pexBRmMZomI/lMV
	 /ZNK7e9o/NGIfJYKRcOtActYr1n7iBJqa71lDDz6W9m1ikcp6nOsfADUtBIb4XKOQR
	 fRlC2uRYGtnrwypvHBuY6CFu9ZVwgoFhm6q5omNT69i9hen5qoxXAFVnYb7X/Irlxr
	 ZY1HXSp2tClzz34YEBwQF6r2NVykYpRbTklwqF/+B9NmfVX+zRrBnYt+4L2P8Gfusv
	 MvCBLmHaDEdNA==
From: Chuck Lever <cel@kernel.org>
Date: Mon, 27 Apr 2026 09:51:02 -0400
Subject: [PATCH 18/18] SUNRPC: Remove dead rpcsec_gss_krb5 definitions
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260427-crypto-krb5-api-v1-18-1fc1253b64c0@oracle.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9198;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=ZcFb+k2n2t58LNAq047I6Ch8sAwnbgJ5yMByohgAJt0=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp72nHhPB1gj2AZ6nAAJsMn+/ZRncpq03Ac9W10
 MSvSQ/KmtOJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCae9pxwAKCRAzarMzb2Z/
 lzFJEACmEB6wjbeS3sPQo2wKLJoy7IJ78ZSAznwmAsX3/ZZiT73a+Yn8Ep400TJPgRPUvoqAGeg
 G4rbAseDMOwI7MK2IQSr9bYi84hPKrL5t8g1XZ9ywFRFBZJlQcE40WDeUnViEJ65yux0KvIZJ9M
 qtNeA4y8hLaYUUawucTgfEfmZmb41zTwOZUPPq8Aad/TDdyjRCr8GhDwd5xAd0Zl2Muy/HH7LNx
 vEi5BqkEteBryuWoNwBJhEpbwoa64WRhE/Zh1Els2r2mqVSMs9zKbHsvIOrS4cOAmtgT07lNKjz
 adZ3tIc9J1a08xg8J5oX0funr/qeWk3Dh4B2TIB6Us4uxie4U1JluqTWe0aQCXGrmhH53OZS0At
 6F9mAQZLK00pUCynwrUkAkZwqXbLLBJVdWM6taBqnsalWvQ7bHLhQRF+jSiftYBsagyZbxcIsp+
 J5BYoeimKr3JyuGjH2KK7BR8Fq1nwfxpkzn74acYld418hjEAWiI1fcTUGD8WtInr6xu4lRzD7+
 eGMeAVVZg6u+VWkdZYmaVko1d/fQLsnV3Zjm1rIrxDFlTz9YffH18XoNZrhrIV2O0jVFX/8BY9v
 cj/0MI1RdQRIicCGmpG52hrk8jM7QHgIo/d8tVSRGIbFIJXG9/xp1UAVxUS5Q9xDu56drwv/ugB
 Dc/0CqmNvYXt+hg==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Rspamd-Queue-Id: CCDC0473E5C
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
	TAGGED_FROM(0.00)[bounces-21195-lists,linux-nfs=lfdr.de];
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

The migration to crypto/krb5 eliminated the per-enctype
function dispatch and direct crypto API usage, leaving
behind a number of orphaned definitions.

Remove the following from gss_krb5.h:

 - GSS_KRB5_K5CLENGTH, used only by removed key derivation
 - KG_TOK_MIC_MSG and KG_TOK_WRAP_MSG (Kerberos v1 token
   types; v1 support was dropped earlier)
 - KG2_TOK_INITIAL and KG2_TOK_RESPONSE (context
   establishment token types; no remaining users)
 - KG2_RESP_FLAG_ERROR and KG2_RESP_FLAG_DELEG_OK
 - enum sgn_alg and enum seal_alg (v1 algorithm constants)
 - All CKSUMTYPE_* definitions, now duplicated by
   KRB5_CKSUMTYPE_* in <crypto/krb5.h>
 - The KG_ error constants from gssapi_err_krb5.h, which
   have no remaining users
 - The ENCTYPE_* constant block, replaced by KRB5_ENCTYPE_*
   from <crypto/krb5.h>
 - KG_USAGE_SEAL/SIGN/SEQ (3DES usage constants)
 - KEY_USAGE_SEED_CHECKSUM/ENCRYPTION/INTEGRITY, duplicated
   by <crypto/krb5.h>
 - #include <crypto/skcipher.h>, no longer needed

Remove the cksum[] field from struct krb5_ctx in
gss_krb5_internal.h; no code reads or writes it after the
key derivation removal.

Switch gss_krb5_enctypes[] in gss_krb5_mech.c to the
canonical KRB5_ENCTYPE_* names from <crypto/krb5.h>.

Remove stale #include directives:
 - <crypto/skcipher.h> from gss_krb5_wrap.c
 - <linux/random.h> and <linux/crypto.h> from
   gss_krb5_seal.c

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/gss_krb5.h         | 105 --------------------------------
 net/sunrpc/auth_gss/gss_krb5_internal.h |   1 -
 net/sunrpc/auth_gss/gss_krb5_mech.c     |  12 ++--
 net/sunrpc/auth_gss/gss_krb5_seal.c     |   2 -
 net/sunrpc/auth_gss/gss_krb5_wrap.c     |   1 -
 5 files changed, 6 insertions(+), 115 deletions(-)

diff --git a/include/linux/sunrpc/gss_krb5.h b/include/linux/sunrpc/gss_krb5.h
index 43950b5237c8..1cd452ed1db5 100644
--- a/include/linux/sunrpc/gss_krb5.h
+++ b/include/linux/sunrpc/gss_krb5.h
@@ -37,13 +37,9 @@
 #ifndef _LINUX_SUNRPC_GSS_KRB5_H
 #define _LINUX_SUNRPC_GSS_KRB5_H
 
-#include <crypto/skcipher.h>
 #include <linux/sunrpc/auth_gss.h>
 #include <linux/sunrpc/gss_err.h>
 
-/* Length of constant used in key derivation */
-#define GSS_KRB5_K5CLENGTH (5)
-
 /* Maximum key length (in bytes) for the supported crypto algorithms */
 #define GSS_KRB5_MAX_KEYLEN (32)
 
@@ -56,11 +52,6 @@
 /* The length of the Kerberos GSS token header */
 #define GSS_KRB5_TOK_HDR_LEN	(16)
 
-#define KG_TOK_MIC_MSG    0x0101
-#define KG_TOK_WRAP_MSG   0x0201
-
-#define KG2_TOK_INITIAL     0x0101
-#define KG2_TOK_RESPONSE    0x0202
 #define KG2_TOK_MIC         0x0404
 #define KG2_TOK_WRAP        0x0504
 
@@ -68,102 +59,6 @@
 #define KG2_TOKEN_FLAG_SEALED           0x02
 #define KG2_TOKEN_FLAG_ACCEPTORSUBKEY   0x04
 
-#define KG2_RESP_FLAG_ERROR             0x0001
-#define KG2_RESP_FLAG_DELEG_OK          0x0002
-
-enum sgn_alg {
-	SGN_ALG_DES_MAC_MD5 = 0x0000,
-	SGN_ALG_MD2_5 = 0x0001,
-	SGN_ALG_DES_MAC = 0x0002,
-	SGN_ALG_3 = 0x0003,		/* not published */
-	SGN_ALG_HMAC_SHA1_DES3_KD = 0x0004
-};
-enum seal_alg {
-	SEAL_ALG_NONE = 0xffff,
-	SEAL_ALG_DES = 0x0000,
-	SEAL_ALG_1 = 0x0001,		/* not published */
-	SEAL_ALG_DES3KD = 0x0002
-};
-
-/*
- * These values are assigned by IANA and published via the
- * subregistry at the link below:
- *
- * https://www.iana.org/assignments/kerberos-parameters/kerberos-parameters.xhtml#kerberos-parameters-2
- */
-#define CKSUMTYPE_CRC32			0x0001
-#define CKSUMTYPE_RSA_MD4		0x0002
-#define CKSUMTYPE_RSA_MD4_DES		0x0003
-#define CKSUMTYPE_DESCBC		0x0004
-#define CKSUMTYPE_RSA_MD5		0x0007
-#define CKSUMTYPE_RSA_MD5_DES		0x0008
-#define CKSUMTYPE_NIST_SHA		0x0009
-#define CKSUMTYPE_HMAC_SHA1_DES3	0x000c
-#define CKSUMTYPE_HMAC_SHA1_96_AES128   0x000f
-#define CKSUMTYPE_HMAC_SHA1_96_AES256   0x0010
-#define CKSUMTYPE_CMAC_CAMELLIA128	0x0011
-#define CKSUMTYPE_CMAC_CAMELLIA256	0x0012
-#define CKSUMTYPE_HMAC_SHA256_128_AES128	0x0013
-#define CKSUMTYPE_HMAC_SHA384_192_AES256	0x0014
-#define CKSUMTYPE_HMAC_MD5_ARCFOUR      -138 /* Microsoft md5 hmac cksumtype */
-
-/* from gssapi_err_krb5.h */
-#define KG_CCACHE_NOMATCH                        (39756032L)
-#define KG_KEYTAB_NOMATCH                        (39756033L)
-#define KG_TGT_MISSING                           (39756034L)
-#define KG_NO_SUBKEY                             (39756035L)
-#define KG_CONTEXT_ESTABLISHED                   (39756036L)
-#define KG_BAD_SIGN_TYPE                         (39756037L)
-#define KG_BAD_LENGTH                            (39756038L)
-#define KG_CTX_INCOMPLETE                        (39756039L)
-#define KG_CONTEXT                               (39756040L)
-#define KG_CRED                                  (39756041L)
-#define KG_ENC_DESC                              (39756042L)
-#define KG_BAD_SEQ                               (39756043L)
-#define KG_EMPTY_CCACHE                          (39756044L)
-#define KG_NO_CTYPES                             (39756045L)
-
-/* per Kerberos v5 protocol spec crypto types from the wire. 
- * these get mapped to linux kernel crypto routines.  
- *
- * These values are assigned by IANA and published via the
- * subregistry at the link below:
- *
- * https://www.iana.org/assignments/kerberos-parameters/kerberos-parameters.xhtml#kerberos-parameters-1
- */
-#define ENCTYPE_NULL            0x0000
-#define ENCTYPE_DES_CBC_CRC     0x0001	/* DES cbc mode with CRC-32 */
-#define ENCTYPE_DES_CBC_MD4     0x0002	/* DES cbc mode with RSA-MD4 */
-#define ENCTYPE_DES_CBC_MD5     0x0003	/* DES cbc mode with RSA-MD5 */
-#define ENCTYPE_DES_CBC_RAW     0x0004	/* DES cbc mode raw */
-/* XXX deprecated? */
-#define ENCTYPE_DES3_CBC_SHA    0x0005	/* DES-3 cbc mode with NIST-SHA */
-#define ENCTYPE_DES3_CBC_RAW    0x0006	/* DES-3 cbc mode raw */
-#define ENCTYPE_DES_HMAC_SHA1   0x0008
-#define ENCTYPE_DES3_CBC_SHA1   0x0010
-#define ENCTYPE_AES128_CTS_HMAC_SHA1_96 0x0011
-#define ENCTYPE_AES256_CTS_HMAC_SHA1_96 0x0012
-#define ENCTYPE_AES128_CTS_HMAC_SHA256_128	0x0013
-#define ENCTYPE_AES256_CTS_HMAC_SHA384_192	0x0014
-#define ENCTYPE_ARCFOUR_HMAC            0x0017
-#define ENCTYPE_ARCFOUR_HMAC_EXP        0x0018
-#define ENCTYPE_CAMELLIA128_CTS_CMAC	0x0019
-#define ENCTYPE_CAMELLIA256_CTS_CMAC	0x001A
-#define ENCTYPE_UNKNOWN         0x01ff
-
-/*
- * Constants used for key derivation
- */
-/* for 3DES */
-#define KG_USAGE_SEAL (22)
-#define KG_USAGE_SIGN (23)
-#define KG_USAGE_SEQ  (24)
-
-/* from rfc3961 */
-#define KEY_USAGE_SEED_CHECKSUM         (0x99)
-#define KEY_USAGE_SEED_ENCRYPTION       (0xAA)
-#define KEY_USAGE_SEED_INTEGRITY        (0x55)
-
 /* from rfc4121 */
 #define KG_USAGE_ACCEPTOR_SEAL  (22)
 #define KG_USAGE_ACCEPTOR_SIGN  (23)
diff --git a/net/sunrpc/auth_gss/gss_krb5_internal.h b/net/sunrpc/auth_gss/gss_krb5_internal.h
index 208f9df9ea96..3b392e96f25d 100644
--- a/net/sunrpc/auth_gss/gss_krb5_internal.h
+++ b/net/sunrpc/auth_gss/gss_krb5_internal.h
@@ -26,7 +26,6 @@ struct krb5_ctx {
 	struct crypto_shash	*initiator_sign_shash;
 	struct crypto_shash	*acceptor_sign_shash;
 	u8			Ksess[GSS_KRB5_MAX_KEYLEN]; /* session key */
-	u8			cksum[GSS_KRB5_MAX_KEYLEN];
 	atomic64_t		seq_send64;
 	time64_t		endtime;
 	struct xdr_netobj	mech_used;
diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index 996e452b9b3c..c41b5f3e1789 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -33,12 +33,12 @@ static struct gss_api_mech gss_kerberos_mech;
  * enctypes that crypto/krb5 supports are advertised.
  */
 static const u32 gss_krb5_enctypes[] = {
-	ENCTYPE_AES256_CTS_HMAC_SHA384_192,
-	ENCTYPE_AES128_CTS_HMAC_SHA256_128,
-	ENCTYPE_CAMELLIA256_CTS_CMAC,
-	ENCTYPE_CAMELLIA128_CTS_CMAC,
-	ENCTYPE_AES256_CTS_HMAC_SHA1_96,
-	ENCTYPE_AES128_CTS_HMAC_SHA1_96,
+	KRB5_ENCTYPE_AES256_CTS_HMAC_SHA384_192,
+	KRB5_ENCTYPE_AES128_CTS_HMAC_SHA256_128,
+	KRB5_ENCTYPE_CAMELLIA256_CTS_CMAC,
+	KRB5_ENCTYPE_CAMELLIA128_CTS_CMAC,
+	KRB5_ENCTYPE_AES256_CTS_HMAC_SHA1_96,
+	KRB5_ENCTYPE_AES128_CTS_HMAC_SHA1_96,
 };
 
 static char gss_krb5_enctype_priority_list[64];
diff --git a/net/sunrpc/auth_gss/gss_krb5_seal.c b/net/sunrpc/auth_gss/gss_krb5_seal.c
index 66c179337029..cfe066e89f23 100644
--- a/net/sunrpc/auth_gss/gss_krb5_seal.c
+++ b/net/sunrpc/auth_gss/gss_krb5_seal.c
@@ -61,8 +61,6 @@
 #include <linux/types.h>
 #include <linux/jiffies.h>
 #include <linux/sunrpc/gss_krb5.h>
-#include <linux/random.h>
-#include <linux/crypto.h>
 #include <linux/atomic.h>
 #include <linux/scatterlist.h>
 #include <linux/slab.h>
diff --git a/net/sunrpc/auth_gss/gss_krb5_wrap.c b/net/sunrpc/auth_gss/gss_krb5_wrap.c
index 93aa7500d032..ac4b32df42b9 100644
--- a/net/sunrpc/auth_gss/gss_krb5_wrap.c
+++ b/net/sunrpc/auth_gss/gss_krb5_wrap.c
@@ -28,7 +28,6 @@
  * SUCH DAMAGES.
  */
 
-#include <crypto/skcipher.h>
 #include <linux/types.h>
 #include <linux/jiffies.h>
 #include <linux/sunrpc/gss_krb5.h>

-- 
2.53.0


