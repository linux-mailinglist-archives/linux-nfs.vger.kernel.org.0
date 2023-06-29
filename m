Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61DE7742B92
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jun 2023 19:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjF2Rve (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Jun 2023 13:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjF2Rva (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Jun 2023 13:51:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E471FC3
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 10:51:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 43103615C9
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 17:51:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56914C433C8;
        Thu, 29 Jun 2023 17:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688061087;
        bh=+PL6px9D7yrSpF5qiVXUXsSHqO3AKwQbPB4KnivhYRM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=tUvFYdPcrWxv4gQwikXn9CI2SrxVcR16tgLT9c298SkKVLCEuxuunIJAs1kJyAkOu
         h3Otf9zptZ+MNuR+FqPbzmIvA5a2hm87lF9nfjn+CHMW5sEZwQWAphXj84VGG+4BdZ
         EN4nqe5jqLhmwIhRJt3ASnPDXQZettSPAbbFS4jscCM5wfNxCfC9opuS1QTRJXyBD4
         XZ9vijqpC3wN2ZbEP53cDVgEUSWdhFan6sh9/4RzUjiDoJKc8s+RN7PtPLMIEftVYA
         k6D8SVCipJvA1aBb964estUHDIBm3jwtcL3Nkj7/gCuFzVKnpjU5sR28KxraLzPaio
         beq3TOSbsRJPQ==
Subject: [PATCH v1 8/9] SUNRPC: Remove the ->import_ctx method
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, dhowells@redhat.com,
        simo@redhat.com, smayhew@redhat.com
Date:   Thu, 29 Jun 2023 13:51:26 -0400
Message-ID: <168806108646.507650.11558795115041578061.stgit@morisot.1015granger.net>
In-Reply-To: <168806089210.507650.17584608037244782863.stgit@morisot.1015granger.net>
References: <168806089210.507650.17584608037244782863.stgit@morisot.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

All supported encryption types now use the same context import
function.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_krb5_internal.h |    1 -
 net/sunrpc/auth_gss/gss_krb5_mech.c     |   12 +-----------
 2 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/net/sunrpc/auth_gss/gss_krb5_internal.h b/net/sunrpc/auth_gss/gss_krb5_internal.h
index c1aea062c01b..9a4b110a6154 100644
--- a/net/sunrpc/auth_gss/gss_krb5_internal.h
+++ b/net/sunrpc/auth_gss/gss_krb5_internal.h
@@ -33,7 +33,6 @@ struct gss_krb5_enctype {
 	const u32		Ke_length;	/* encryption subkey length, in octets */
 	const u32		Ki_length;	/* integrity subkey length, in octets */
 
-	int (*import_ctx)(struct krb5_ctx *ctx, gfp_t gfp_mask);
 	int (*derive_key)(const struct gss_krb5_enctype *gk5e,
 			  const struct xdr_netobj *in,
 			  struct xdr_netobj *out,
diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index 38a0c93e4b60..e31cfdf7eadc 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -29,7 +29,6 @@
 #endif
 
 static struct gss_api_mech gss_kerberos_mech;
-static int gss_krb5_import_ctx_v2(struct krb5_ctx *ctx, gfp_t gfp_mask);
 
 static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 #if defined(CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1)
@@ -43,7 +42,6 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 	  .encrypt_name = "cts(cbc(aes))",
 	  .aux_cipher = "cbc(aes)",
 	  .cksum_name = "hmac(sha1)",
-	  .import_ctx = gss_krb5_import_ctx_v2,
 	  .derive_key = krb5_derive_key_v2,
 	  .encrypt = gss_krb5_aes_encrypt,
 	  .decrypt = gss_krb5_aes_decrypt,
@@ -73,7 +71,6 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 	  .encrypt_name = "cts(cbc(aes))",
 	  .aux_cipher = "cbc(aes)",
 	  .cksum_name = "hmac(sha1)",
-	  .import_ctx = gss_krb5_import_ctx_v2,
 	  .derive_key = krb5_derive_key_v2,
 	  .encrypt = gss_krb5_aes_encrypt,
 	  .decrypt = gss_krb5_aes_decrypt,
@@ -113,7 +110,6 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 		.Ke_length	= BITS2OCTETS(128),
 		.Ki_length	= BITS2OCTETS(128),
 
-		.import_ctx	= gss_krb5_import_ctx_v2,
 		.derive_key	= krb5_kdf_feedback_cmac,
 		.encrypt	= gss_krb5_aes_encrypt,
 		.decrypt	= gss_krb5_aes_decrypt,
@@ -140,7 +136,6 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 		.Ke_length	= BITS2OCTETS(256),
 		.Ki_length	= BITS2OCTETS(256),
 
-		.import_ctx	= gss_krb5_import_ctx_v2,
 		.derive_key	= krb5_kdf_feedback_cmac,
 		.encrypt	= gss_krb5_aes_encrypt,
 		.decrypt	= gss_krb5_aes_decrypt,
@@ -170,7 +165,6 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 		.Ke_length	= BITS2OCTETS(128),
 		.Ki_length	= BITS2OCTETS(128),
 
-		.import_ctx	= gss_krb5_import_ctx_v2,
 		.derive_key	= krb5_kdf_hmac_sha2,
 		.encrypt	= krb5_etm_encrypt,
 		.decrypt	= krb5_etm_decrypt,
@@ -197,7 +191,6 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 		.Ke_length	= BITS2OCTETS(256),
 		.Ki_length	= BITS2OCTETS(192),
 
-		.import_ctx	= gss_krb5_import_ctx_v2,
 		.derive_key	= krb5_kdf_hmac_sha2,
 		.encrypt	= krb5_etm_encrypt,
 		.decrypt	= krb5_etm_decrypt,
@@ -431,9 +424,6 @@ gss_import_v2_context(const void *p, const void *end, struct krb5_ctx *ctx,
 	p = simple_get_bytes(p, end, &ctx->enctype, sizeof(ctx->enctype));
 	if (IS_ERR(p))
 		goto out_err;
-	/* Map ENCTYPE_DES3_CBC_SHA1 to ENCTYPE_DES3_CBC_RAW */
-	if (ctx->enctype == ENCTYPE_DES3_CBC_SHA1)
-		ctx->enctype = ENCTYPE_DES3_CBC_RAW;
 	ctx->gk5e = gss_krb5_lookup_enctype(ctx->enctype);
 	if (ctx->gk5e == NULL) {
 		dprintk("gss_kerberos_mech: unsupported krb5 enctype %u\n",
@@ -460,7 +450,7 @@ gss_import_v2_context(const void *p, const void *end, struct krb5_ctx *ctx,
 	}
 	ctx->mech_used.len = gss_kerberos_mech.gm_oid.len;
 
-	return ctx->gk5e->import_ctx(ctx, gfp_mask);
+	return gss_krb5_import_ctx_v2(ctx, gfp_mask);
 
 out_err:
 	return PTR_ERR(p);


