Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ADD0742B91
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jun 2023 19:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbjF2RvY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Jun 2023 13:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjF2RvX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Jun 2023 13:51:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482621FC3
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 10:51:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CEE57615C9
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 17:51:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE68CC433C8;
        Thu, 29 Jun 2023 17:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688061081;
        bh=okHdx6BQVR5is2e2YqJthEqwagwglA1pkNX/hkuC6Pg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=c4Ybp2XZiiEtiDMu4XyzqXGbcrTkTdRvjK1V/jH0215HDcFyxMQh0U957XlLlcQrH
         tYHEk16adTmUXDEEU20fhNS/gPjVAa/5tfWeF8IppVFW30Bg2sCMzLcf0Zl5x30FrS
         V23Wn6tidLxswTqhGlxPcxSJz7zofC/MSzDGGdK+MdAO06y4eP+mDHRUE0kw1HswhJ
         otid76C4fxO/ufL4PbLa2BjZTb9TUq+sg+h5jIHUOVcVpIEhK5J4dxN+BGvw8gQG4n
         mpMz5tIzkznsYPoqqPwna3Ihkpm0dZwhFFq6i4KTuak8nzm+FDMy4CqfJn7N3LMH32
         1dl+kgWx80gtQ==
Subject: [PATCH v1 7/9] SUNRPC: Remove CONFIG_RPCSEC_GSS_KRB5_CRYPTOSYSTEM
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, dhowells@redhat.com,
        simo@redhat.com, smayhew@redhat.com
Date:   Thu, 29 Jun 2023 13:51:19 -0400
Message-ID: <168806107993.507650.15029086211137381355.stgit@morisot.1015granger.net>
In-Reply-To: <168806089210.507650.17584608037244782863.stgit@morisot.1015granger.net>
References: <168806089210.507650.17584608037244782863.stgit@morisot.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

This code is now always on, so the ifdef can be removed.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/Kconfig                  |    7 -------
 net/sunrpc/auth_gss/gss_krb5_mech.c |    7 -------
 2 files changed, 14 deletions(-)

diff --git a/net/sunrpc/Kconfig b/net/sunrpc/Kconfig
index 68c95cfd8afa..2d8b67dac7b5 100644
--- a/net/sunrpc/Kconfig
+++ b/net/sunrpc/Kconfig
@@ -34,10 +34,6 @@ config RPCSEC_GSS_KRB5
 
 	  If unsure, say Y.
 
-config RPCSEC_GSS_KRB5_CRYPTOSYSTEM
-	bool
-	depends on RPCSEC_GSS_KRB5
-
 config RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1
 	bool "Enable Kerberos enctypes based on AES and SHA-1"
 	depends on RPCSEC_GSS_KRB5
@@ -45,7 +41,6 @@ config RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1
 	depends on CRYPTO_HMAC && CRYPTO_SHA1
 	depends on CRYPTO_AES
 	default y
-	select RPCSEC_GSS_KRB5_CRYPTOSYSTEM
 	help
 	  Choose Y to enable the use of Kerberos 5 encryption types
 	  that utilize Advanced Encryption Standard (AES) ciphers and
@@ -58,7 +53,6 @@ config RPCSEC_GSS_KRB5_ENCTYPES_CAMELLIA
 	depends on CRYPTO_CBC && CRYPTO_CTS && CRYPTO_CAMELLIA
 	depends on CRYPTO_CMAC
 	default n
-	select RPCSEC_GSS_KRB5_CRYPTOSYSTEM
 	help
 	  Choose Y to enable the use of Kerberos 5 encryption types
 	  that utilize Camellia ciphers (RFC 3713) and CMAC digests
@@ -72,7 +66,6 @@ config RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA2
 	depends on CRYPTO_HMAC && CRYPTO_SHA256 && CRYPTO_SHA512
 	depends on CRYPTO_AES
 	default n
-	select RPCSEC_GSS_KRB5_CRYPTOSYSTEM
 	help
 	  Choose Y to enable the use of Kerberos 5 encryption types
 	  that utilize Advanced Encryption Standard (AES) ciphers and
diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index 09fff5011d11..38a0c93e4b60 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -29,10 +29,7 @@
 #endif
 
 static struct gss_api_mech gss_kerberos_mech;
-
-#if defined(CONFIG_RPCSEC_GSS_KRB5_CRYPTOSYSTEM)
 static int gss_krb5_import_ctx_v2(struct krb5_ctx *ctx, gfp_t gfp_mask);
-#endif
 
 static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 #if defined(CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1)
@@ -273,8 +270,6 @@ const struct gss_krb5_enctype *gss_krb5_lookup_enctype(u32 etype)
 }
 EXPORT_SYMBOL_IF_KUNIT(gss_krb5_lookup_enctype);
 
-#if defined(CONFIG_RPCSEC_GSS_KRB5_CRYPTOSYSTEM)
-
 static struct crypto_sync_skcipher *
 gss_krb5_alloc_cipher_v2(const char *cname, const struct xdr_netobj *key)
 {
@@ -403,8 +398,6 @@ gss_krb5_import_ctx_v2(struct krb5_ctx *ctx, gfp_t gfp_mask)
 	goto out;
 }
 
-#endif
-
 static int
 gss_import_v2_context(const void *p, const void *end, struct krb5_ctx *ctx,
 		gfp_t gfp_mask)


