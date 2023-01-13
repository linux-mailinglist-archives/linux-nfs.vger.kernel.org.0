Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46ED4669C46
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jan 2023 16:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjAMPbC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Jan 2023 10:31:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbjAMPac (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Jan 2023 10:30:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54385F49C
        for <linux-nfs@vger.kernel.org>; Fri, 13 Jan 2023 07:23:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 614636212C
        for <linux-nfs@vger.kernel.org>; Fri, 13 Jan 2023 15:23:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 952E9C433F0;
        Fri, 13 Jan 2023 15:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673623421;
        bh=EflpkU3JaHApkZEMJNADvDghLV7Vh/jHmqORPqgORvw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=gFO9b2P6rKIa+cdbrT5Vc8qafJRM21qiAvzxZezxLMfBto0+C+rc/wSNz7VpcrIW4
         8BiZSV02tnTQBeJWRKZ1aw3Ta6j4Nx4A0gwq76MSyyKs00g0PoZlJOtPlwa/rf44iz
         /70gFI2VBgltfkxLo1y6v8JqpRUWV8s/QNkL/g2VPChg8EVeK1rH1MJmcvZ4cdLy1b
         1AtqImsD3rcQ454wsyADUBMkN2dE/L0FJAvyngRtbEEbCpzLZn6yACdoX5O+TsHtNG
         O45ekTC6cJZQnCmoReccu8mBiggziau5sGLHYC3gwY6D/x/obvFlZTKDPLCe8OXNMb
         TyeX8MX2gysAw==
Subject: [PATCH v1 21/41] SUNRPC: Add new subkey length fields
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, simo@redhat.com
Date:   Fri, 13 Jan 2023 10:23:40 -0500
Message-ID: <167362342075.8960.8739690579435009216.stgit@bazille.1015granger.net>
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

The aes256-cts-hmac-sha384-192 enctype specifies the length of its
checksum and integrity subkeys as 192 bits, but the length of its
encryption subkey (Ke) as 256 bits. Add new fields to struct
gss_krb5_enctype that specify the key lengths individually, and
where needed, use the correct new field instead of ->keylength.

Tested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/gss_krb5.h     |   14 ++++++++++++--
 net/sunrpc/auth_gss/gss_krb5_mech.c |   20 ++++++++++++++------
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/include/linux/sunrpc/gss_krb5.h b/include/linux/sunrpc/gss_krb5.h
index 0c08f4f75b43..48e82397132b 100644
--- a/include/linux/sunrpc/gss_krb5.h
+++ b/include/linux/sunrpc/gss_krb5.h
@@ -44,10 +44,16 @@
 #include <linux/sunrpc/gss_err.h>
 #include <linux/sunrpc/gss_asn1.h>
 
+/*
+ * The RFCs often specify payload lengths in bits. This helper
+ * converts a specified bit-length to the number of octets/bytes.
+ */
+#define BITS2OCTETS(x)	((x) / 8)
+
 /* Length of constant used in key derivation */
 #define GSS_KRB5_K5CLENGTH (5)
 
-/* Maximum key length (in bytes) for the supported crypto algorithms*/
+/* Maximum key length (in bytes) for the supported crypto algorithms */
 #define GSS_KRB5_MAX_KEYLEN (32)
 
 /* Maximum checksum function output for the supported crypto algorithms */
@@ -70,7 +76,11 @@ struct gss_krb5_enctype {
 	const u32		cksumlength;	/* checksum length */
 	const u32		keyed_cksum;	/* is it a keyed cksum? */
 	const u32		keybytes;	/* raw key len, in bytes */
-	const u32		keylength;	/* final key len, in bytes */
+	const u32		keylength;	/* protocol key length, in octets */
+	const u32		Kc_length;	/* checksum subkey length, in octets */
+	const u32		Ke_length;	/* encryption subkey length, in octets */
+	const u32		Ki_length;	/* integrity subkey length, in octets */
+
 	int (*import_ctx)(struct krb5_ctx *ctx, gfp_t gfp_mask);
 	int (*derive_key)(const struct gss_krb5_enctype *gk5e,
 			  const struct xdr_netobj *in,
diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index b48a06769891..03725f2dd28f 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -108,8 +108,11 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 	  .signalg = -1,
 	  .sealalg = -1,
 	  .keybytes = 16,
-	  .keylength = 16,
-	  .cksumlength = 12,
+	  .keylength = BITS2OCTETS(128),
+	  .Kc_length = BITS2OCTETS(128),
+	  .Ke_length = BITS2OCTETS(128),
+	  .Ki_length = BITS2OCTETS(128),
+	  .cksumlength = BITS2OCTETS(96),
 	  .keyed_cksum = 1,
 	},
 	/*
@@ -135,8 +138,11 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 	  .signalg = -1,
 	  .sealalg = -1,
 	  .keybytes = 32,
-	  .keylength = 32,
-	  .cksumlength = 12,
+	  .keylength = BITS2OCTETS(256),
+	  .Kc_length = BITS2OCTETS(256),
+	  .Ke_length = BITS2OCTETS(256),
+	  .Ki_length = BITS2OCTETS(256),
+	  .cksumlength = BITS2OCTETS(96),
 	  .keyed_cksum = 1,
 	},
 #endif
@@ -423,12 +429,12 @@ gss_krb5_import_ctx_v2(struct krb5_ctx *ctx, gfp_t gfp_mask)
 	struct xdr_netobj keyout;
 	int ret = -EINVAL;
 
-	keyout.data = kmalloc(ctx->gk5e->keylength, gfp_mask);
+	keyout.data = kmalloc(GSS_KRB5_MAX_KEYLEN, gfp_mask);
 	if (!keyout.data)
 		return -ENOMEM;
-	keyout.len = ctx->gk5e->keylength;
 
 	/* initiator seal encryption */
+	keyout.len = ctx->gk5e->Ke_length;
 	if (krb5_derive_key(ctx, &keyin, &keyout, KG_USAGE_INITIATOR_SEAL,
 			    KEY_USAGE_SEED_ENCRYPTION, gfp_mask))
 		goto out;
@@ -461,6 +467,7 @@ gss_krb5_import_ctx_v2(struct krb5_ctx *ctx, gfp_t gfp_mask)
 	}
 
 	/* initiator sign checksum */
+	keyout.len = ctx->gk5e->Kc_length;
 	if (krb5_derive_key(ctx, &keyin, &keyout, KG_USAGE_INITIATOR_SIGN,
 			    KEY_USAGE_SEED_CHECKSUM, gfp_mask))
 		goto out_free;
@@ -477,6 +484,7 @@ gss_krb5_import_ctx_v2(struct krb5_ctx *ctx, gfp_t gfp_mask)
 		goto out_free;
 
 	/* initiator seal integrity */
+	keyout.len = ctx->gk5e->Ki_length;
 	if (krb5_derive_key(ctx, &keyin, &keyout, KG_USAGE_INITIATOR_SEAL,
 			    KEY_USAGE_SEED_INTEGRITY, gfp_mask))
 		goto out_free;


