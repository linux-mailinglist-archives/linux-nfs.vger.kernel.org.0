Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F164A742B8D
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jun 2023 19:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjF2Ru5 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Jun 2023 13:50:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjF2Ru5 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Jun 2023 13:50:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF5C1FCD
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 10:50:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9EA0615CC
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 17:50:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E1EC433C0;
        Thu, 29 Jun 2023 17:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688061055;
        bh=J6PNDert80EtjEHXkSgRLPoF4xIun7+6YU9a0gRitEI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=CTBPyCrjOKdoAZdrwknVA+WAodOcewE08oYBNyAVUVh1YC2VB0vFVk23nxCfTOvMR
         Ja6oRj2o2KBDiDNfyPakkzO8wNrjuSUBT0RcyGwaE6QLAhLWyH6r6/uwJehpjOgZIT
         B3LIepWbRZHEwoWW3RhTDupAeLEuLMPziHQqd4avtpp/pPHxybxE3efh2btd2prtRZ
         PICRKSW8dgtmUclYb2dGuveacAkv/v6duNxiPiz69EUzAAZjv6G+T0Y4QbqNSFIu3P
         3RAm53Ihy1FmY6heMlcbYn/x1s0Zq1/VtCOfi95meezcJ6BZmPf/WP52zM3p9DDQLU
         r57zVtWaPowwA==
Subject: [PATCH v1 3/9] SUNRPC: Remove DES and DES3 enctypes from the
 supported enctypes list
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, dhowells@redhat.com,
        simo@redhat.com, smayhew@redhat.com
Date:   Thu, 29 Jun 2023 13:50:52 -0400
Message-ID: <168806105298.507650.13297416784093913326.stgit@morisot.1015granger.net>
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

These enctypes can no longer be enabled via CONFIG.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_krb5_mech.c |   52 -----------------------------------
 1 file changed, 52 deletions(-)

diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index 20e21d08badb..39160a8ca3b6 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -39,52 +39,6 @@ static int gss_krb5_import_ctx_v2(struct krb5_ctx *ctx, gfp_t gfp_mask);
 #endif
 
 static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
-#if defined(CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_DES)
-	/*
-	 * DES (All DES enctypes are mapped to the same gss functionality)
-	 */
-	{
-	  .etype = ENCTYPE_DES_CBC_RAW,
-	  .ctype = CKSUMTYPE_RSA_MD5,
-	  .name = "des-cbc-crc",
-	  .encrypt_name = "cbc(des)",
-	  .cksum_name = "md5",
-	  .import_ctx = gss_krb5_import_ctx_des,
-	  .get_mic = gss_krb5_get_mic_v1,
-	  .verify_mic = gss_krb5_verify_mic_v1,
-	  .wrap = gss_krb5_wrap_v1,
-	  .unwrap = gss_krb5_unwrap_v1,
-	  .signalg = SGN_ALG_DES_MAC_MD5,
-	  .sealalg = SEAL_ALG_DES,
-	  .keybytes = 7,
-	  .keylength = 8,
-	  .cksumlength = 8,
-	  .keyed_cksum = 0,
-	},
-	/*
-	 * 3DES
-	 */
-	{
-	  .etype = ENCTYPE_DES3_CBC_RAW,
-	  .ctype = CKSUMTYPE_HMAC_SHA1_DES3,
-	  .name = "des3-hmac-sha1",
-	  .encrypt_name = "cbc(des3_ede)",
-	  .cksum_name = "hmac(sha1)",
-	  .import_ctx = gss_krb5_import_ctx_v1,
-	  .derive_key = krb5_derive_key_v1,
-	  .get_mic = gss_krb5_get_mic_v1,
-	  .verify_mic = gss_krb5_verify_mic_v1,
-	  .wrap = gss_krb5_wrap_v1,
-	  .unwrap = gss_krb5_unwrap_v1,
-	  .signalg = SGN_ALG_HMAC_SHA1_DES3_KD,
-	  .sealalg = SEAL_ALG_DES3KD,
-	  .keybytes = 21,
-	  .keylength = 24,
-	  .cksumlength = 20,
-	  .keyed_cksum = 1,
-	},
-#endif
-
 #if defined(CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1)
 	/*
 	 * AES-128 with SHA-1 (RFC 3962)
@@ -283,12 +237,6 @@ static void gss_krb5_prepare_enctype_priority_list(void)
 #if defined(CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1)
 		ENCTYPE_AES256_CTS_HMAC_SHA1_96,
 		ENCTYPE_AES128_CTS_HMAC_SHA1_96,
-#endif
-#if defined(CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_DES)
-		ENCTYPE_DES3_CBC_SHA1,
-		ENCTYPE_DES_CBC_MD5,
-		ENCTYPE_DES_CBC_CRC,
-		ENCTYPE_DES_CBC_MD4,
 #endif
 	};
 	size_t total, i;


