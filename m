Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8F3742B8B
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jun 2023 19:50:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjF2Ruo (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Jun 2023 13:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjF2Run (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Jun 2023 13:50:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4561FCD
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 10:50:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1573615BF
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 17:50:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF8DC433C0;
        Thu, 29 Jun 2023 17:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688061041;
        bh=JRHCaQvLWABcch/5SSCrXBPntRk+/06wUjHU5nKNT6A=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=DeaFaN6wDxwoetzPotbkzSFvTZ4RfndXBi+f+9Zznw3rvrywYAh/syTE31yYKsZwg
         q3Bmm2EVbW6Oa4bZcxnRCK7BOb/x51cRmDAfdNvI8ABsvJNVIlYQc8O5wEiSBKUjhR
         EyixxAalxLopgoKIblW7uWrNgvk+EhhYJh4qrw3X45lXquppST5SaJjlbxkbqRKC0k
         jbnvLBj2/ULYJU7r6P71BctNwFwnJRQVJXnfxmNgo8WkTm3YYM9vA3wriTgrobisDh
         XooRyOQBtTOy9ScXOnAlSYctFgnctyqMBvMqmeEV3qdVHdlR2coXdmW08T3CZ1Z3xE
         RNUeKTFFH6GnA==
Subject: [PATCH v1 1/9] SUNRPC: Remove RPCSEC_GSS_KRB5_ENCTYPES_DES
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, dhowells@redhat.com,
        simo@redhat.com, smayhew@redhat.com
Date:   Thu, 29 Jun 2023 13:50:39 -0400
Message-ID: <168806103993.507650.17272925711898578977.stgit@morisot.1015granger.net>
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

Make it impossible to enable support for the DES or DES3 Kerberos
encryption types in SunRPC. These enctypes were deprecated by RFCs
6649 and 8429 because they are known to be insecure.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/.kunitconfig |    1 -
 net/sunrpc/Kconfig      |   28 ----------------------------
 2 files changed, 29 deletions(-)

diff --git a/net/sunrpc/.kunitconfig b/net/sunrpc/.kunitconfig
index a55a00fa649b..eb02b906c295 100644
--- a/net/sunrpc/.kunitconfig
+++ b/net/sunrpc/.kunitconfig
@@ -23,7 +23,6 @@ CONFIG_NFS_FS=y
 CONFIG_SUNRPC=y
 CONFIG_SUNRPC_GSS=y
 CONFIG_RPCSEC_GSS_KRB5=y
-CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_DES=y
 CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1=y
 CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_CAMELLIA=y
 CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA2=y
diff --git a/net/sunrpc/Kconfig b/net/sunrpc/Kconfig
index 4afc5fd71d44..68c95cfd8afa 100644
--- a/net/sunrpc/Kconfig
+++ b/net/sunrpc/Kconfig
@@ -34,38 +34,10 @@ config RPCSEC_GSS_KRB5
 
 	  If unsure, say Y.
 
-config RPCSEC_GSS_KRB5_SIMPLIFIED
-	bool
-	depends on RPCSEC_GSS_KRB5
-
 config RPCSEC_GSS_KRB5_CRYPTOSYSTEM
 	bool
 	depends on RPCSEC_GSS_KRB5
 
-config RPCSEC_GSS_KRB5_ENCTYPES_DES
-	bool "Enable Kerberos enctypes based on DES (deprecated)"
-	depends on RPCSEC_GSS_KRB5
-	depends on CRYPTO_CBC && CRYPTO_CTS && CRYPTO_ECB
-	depends on CRYPTO_HMAC && CRYPTO_MD5 && CRYPTO_SHA1
-	depends on CRYPTO_DES
-	default n
-	select RPCSEC_GSS_KRB5_SIMPLIFIED
-	help
-	  Choose Y to enable the use of deprecated Kerberos 5
-	  encryption types that utilize Data Encryption Standard
-	  (DES) based ciphers. These include des-cbc-md5,
-	  des-cbc-crc, and des-cbc-md4, which were deprecated by
-	  RFC 6649, and des3-cbc-sha1, which was deprecated by RFC
-	  8429.
-
-	  These encryption types are known to be insecure, therefore
-	  the default setting of this option is N. Support for these
-	  encryption types is available only for compatibility with
-	  legacy NFS client and server implementations.
-
-	  Removal of support is planned for a subsequent kernel
-	  release.
-
 config RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1
 	bool "Enable Kerberos enctypes based on AES and SHA-1"
 	depends on RPCSEC_GSS_KRB5


