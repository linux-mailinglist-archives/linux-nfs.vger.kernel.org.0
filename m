Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6786669C4B
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jan 2023 16:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjAMPbS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Jan 2023 10:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjAMPaj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Jan 2023 10:30:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE87E7ECAE
        for <linux-nfs@vger.kernel.org>; Fri, 13 Jan 2023 07:24:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 33A6BB820D4
        for <linux-nfs@vger.kernel.org>; Fri, 13 Jan 2023 15:24:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 873BEC433D2;
        Fri, 13 Jan 2023 15:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673623440;
        bh=7Kj8AQXfW1wRp279GQLla/GlVkbmwX1X193sBM3n3zM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=BWZ34QMmeEyOd7NOVc9l3AKNaUTrht4lDN8kDmaY9B4J7cbK6jYaagHKBsCiTYVSl
         Lrr2r04Acz/JW/YO7uCgAHvqc/Hqeu/N6HUMA+LzMZOYQXQFeHnJHgG/NAu0J0RzJT
         ArvudPoYNR27o6XeeUlLmqjPwSgwH9dzCfoQhTYnzE0c5y76hLUbkUynEofLLHmrfR
         G2KNyK06+TAxqNptbUN48OtHvn96Hvjyw4BRQh0NkpGBSq8kgUPRL4eYYynRYkGDW1
         ScGeaOEaDOzi+s7olOwQiJccpQqzMXhjHA+DWmkq0fG68G2j4GXcGOB74xmptSsorh
         n9QzJ+yEGUdNA==
Subject: [PATCH v1 24/41] SUNRPC: Add KDF-HMAC-SHA2
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, simo@redhat.com
Date:   Fri, 13 Jan 2023 10:23:59 -0500
Message-ID: <167362343968.8960.15888057547200220750.stgit@bazille.1015granger.net>
In-Reply-To: <167362164696.8960.16701168753472560115.stgit@bazille.1015granger.net>
References: <167362164696.8960.16701168753472560115.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

The RFC 8009 encryption types use a different key derivation
function than the RFC 3962 encryption types. The new key derivation
function is defined in Section 3 of RFC 8009.

Tested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_krb5_internal.h |    6 ++
 net/sunrpc/auth_gss/gss_krb5_keys.c     |  117 +++++++++++++++++++++++++++++++
 net/sunrpc/auth_gss/gss_krb5_mech.c     |    2 +
 3 files changed, 125 insertions(+)

diff --git a/net/sunrpc/auth_gss/gss_krb5_internal.h b/net/sunrpc/auth_gss/gss_krb5_internal.h
index e1c61c267dad..818a5fd89a8f 100644
--- a/net/sunrpc/auth_gss/gss_krb5_internal.h
+++ b/net/sunrpc/auth_gss/gss_krb5_internal.h
@@ -52,6 +52,12 @@ int krb5_derive_key_v2(const struct gss_krb5_enctype *gk5e,
 		       const struct xdr_netobj *label,
 		       gfp_t gfp_mask);
 
+int krb5_kdf_hmac_sha2(const struct gss_krb5_enctype *gk5e,
+		       const struct xdr_netobj *inkey,
+		       struct xdr_netobj *outkey,
+		       const struct xdr_netobj *in_constant,
+		       gfp_t gfp_mask);
+
 /**
  * krb5_derive_key - Derive a subkey from a protocol key
  * @kctx: Kerberos 5 context
diff --git a/net/sunrpc/auth_gss/gss_krb5_keys.c b/net/sunrpc/auth_gss/gss_krb5_keys.c
index f6de4fdd63ae..724be20f5417 100644
--- a/net/sunrpc/auth_gss/gss_krb5_keys.c
+++ b/net/sunrpc/auth_gss/gss_krb5_keys.c
@@ -60,6 +60,7 @@
 #include <linux/sunrpc/gss_krb5.h>
 #include <linux/sunrpc/xdr.h>
 #include <linux/lcm.h>
+#include <crypto/hash.h>
 
 #include "gss_krb5_internal.h"
 
@@ -361,3 +362,119 @@ int krb5_derive_key_v2(const struct gss_krb5_enctype *gk5e,
 	kfree_sensitive(inblock.data);
 	return ret;
 }
+
+/*
+ * K1 = HMAC-SHA(key, 0x00000001 | label | 0x00 | k)
+ *
+ *    key: The source of entropy from which subsequent keys are derived.
+ *
+ *    label: An octet string describing the intended usage of the
+ *    derived key.
+ *
+ *    k: Length in bits of the key to be outputted, expressed in
+ *    big-endian binary representation in 4 bytes.
+ */
+static int
+krb5_hmac_K1(struct crypto_shash *tfm, const struct xdr_netobj *label,
+	     u32 outlen, struct xdr_netobj *K1)
+{
+	__be32 k = cpu_to_be32(outlen * 8);
+	SHASH_DESC_ON_STACK(desc, tfm);
+	__be32 one = cpu_to_be32(1);
+	u8 zero = 0;
+	int ret;
+
+	desc->tfm = tfm;
+	ret = crypto_shash_init(desc);
+	if (ret)
+		goto out_err;
+	ret = crypto_shash_update(desc, (u8 *)&one, sizeof(one));
+	if (ret)
+		goto out_err;
+	ret = crypto_shash_update(desc, label->data, label->len);
+	if (ret)
+		goto out_err;
+	ret = crypto_shash_update(desc, &zero, sizeof(zero));
+	if (ret)
+		goto out_err;
+	ret = crypto_shash_update(desc, (u8 *)&k, sizeof(k));
+	if (ret)
+		goto out_err;
+	ret = crypto_shash_final(desc, K1->data);
+	if (ret)
+		goto out_err;
+
+out_err:
+	shash_desc_zero(desc);
+	return ret;
+}
+
+/**
+ * krb5_kdf_hmac_sha2 - Derive a subkey for an AES/SHA2-based enctype
+ * @gk5e: Kerberos 5 enctype policy parameters
+ * @inkey: base protocol key
+ * @outkey: OUT: derived key
+ * @label: subkey usage label
+ * @gfp_mask: memory allocation control flags
+ *
+ * RFC 8009 Section 3:
+ *
+ *  "We use a key derivation function from Section 5.1 of [SP800-108],
+ *   which uses the HMAC algorithm as the PRF."
+ *
+ *	function KDF-HMAC-SHA2(key, label, [context,] k):
+ *		k-truncate(K1)
+ *
+ * Caller sets @outkey->len to the desired length of the derived key.
+ *
+ * On success, returns 0 and fills in @outkey. A negative errno value
+ * is returned on failure.
+ */
+int
+krb5_kdf_hmac_sha2(const struct gss_krb5_enctype *gk5e,
+		   const struct xdr_netobj *inkey,
+		   struct xdr_netobj *outkey,
+		   const struct xdr_netobj *label,
+		   gfp_t gfp_mask)
+{
+	struct crypto_shash *tfm;
+	struct xdr_netobj K1 = {
+		.data = NULL,
+	};
+	int ret;
+
+	/*
+	 * This implementation assumes the HMAC used for an enctype's
+	 * key derivation is the same as the HMAC used for its
+	 * checksumming. This happens to be true for enctypes that
+	 * are currently supported by this implementation.
+	 */
+	tfm = crypto_alloc_shash(gk5e->cksum_name, 0, 0);
+	if (IS_ERR(tfm)) {
+		ret = PTR_ERR(tfm);
+		goto out;
+	}
+	ret = crypto_shash_setkey(tfm, inkey->data, inkey->len);
+	if (ret)
+		goto out_free_tfm;
+
+	K1.len = crypto_shash_digestsize(tfm);
+	K1.data = kmalloc(K1.len, gfp_mask);
+	if (!K1.data) {
+		ret = -ENOMEM;
+		goto out_free_tfm;
+	}
+
+	ret = krb5_hmac_K1(tfm, label, outkey->len, &K1);
+	if (ret)
+		goto out_free_tfm;
+
+	/* k-truncate and random-to-key */
+	memcpy(outkey->data, K1.data, outkey->len);
+
+out_free_tfm:
+	kfree_sensitive(K1.data);
+	crypto_free_shash(tfm);
+out:
+	return ret;
+}
diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index bfcd13e6eb18..95a041a80e21 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -166,6 +166,7 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 		.Ki_length	= BITS2OCTETS(128),
 
 		.import_ctx	= gss_krb5_import_ctx_v2,
+		.derive_key	= krb5_kdf_hmac_sha2,
 
 		.get_mic	= gss_krb5_get_mic_v2,
 		.verify_mic	= gss_krb5_verify_mic_v2,
@@ -190,6 +191,7 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 		.Ki_length	= BITS2OCTETS(192),
 
 		.import_ctx	= gss_krb5_import_ctx_v2,
+		.derive_key	= krb5_kdf_hmac_sha2,
 
 		.get_mic	= gss_krb5_get_mic_v2,
 		.verify_mic	= gss_krb5_verify_mic_v2,


