Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDF46742B8C
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jun 2023 19:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjF2Rux (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Jun 2023 13:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229991AbjF2Ruv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Jun 2023 13:50:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5881FC3
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 10:50:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5ACC8615C5
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 17:50:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69DF8C433C0;
        Thu, 29 Jun 2023 17:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688061047;
        bh=rH9SXGM9Mp0PXIDGxSA0WwKOq5xxNS+gh3RmCIaZIHU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=fmjlFBOmXGWfF1LUouA3KJE/2LArhdl4D2nOdGdpJgHjdMiNdtlmQ/9YenfBC8Nhh
         4KlQZ/LE5qUmRzSgMfRbDdzcVF3I+q35RR59AuQAyPRhri6ZtITApRE7a00B+fKHA/
         tqHa5CxLW8Vkmbzhc5u9tQsu/xAFTGO2lqc78d36qUVC/m5D7XCl/lB8pl2HMjpOs0
         bmU/L16TLJuEonf7t8aEm7EhJZnN2sNbkqfugZvygnyygfi8f0LRbyot+mFZebGmVr
         d68RQGMz3fnDu2C8ep4vqYno5RbDNpWPhxlKlhYv+q4bH2X4RfaZq2llCVwwmrixCP
         wE8aV3inM8q2w==
Subject: [PATCH v1 2/9] SUNRPC: Remove Kunit tests for the DES3 encryption
 type
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, dhowells@redhat.com,
        simo@redhat.com, smayhew@redhat.com
Date:   Thu, 29 Jun 2023 13:50:46 -0400
Message-ID: <168806104641.507650.138994454907889438.stgit@morisot.1015granger.net>
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

The DES3 encryption type is no longer implemented.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_krb5_test.c |  196 -----------------------------------
 1 file changed, 196 deletions(-)

diff --git a/net/sunrpc/auth_gss/gss_krb5_test.c b/net/sunrpc/auth_gss/gss_krb5_test.c
index 95ca783795c5..85625e3f3814 100644
--- a/net/sunrpc/auth_gss/gss_krb5_test.c
+++ b/net/sunrpc/auth_gss/gss_krb5_test.c
@@ -320,208 +320,12 @@ static void rfc3961_nfold_case(struct kunit *test)
 			    "result mismatch");
 }
 
-/*
- * RFC 3961 Appendix A.3.  DES3 DR and DK
- *
- * These tests show the derived-random and derived-key values for the
- * des3-hmac-sha1-kd encryption scheme, using the DR and DK functions
- * defined in section 6.3.1.  The input keys were randomly generated;
- * the usage values are from this specification.
- *
- * This test material is copyright (C) The Internet Society (2005).
- */
-
-DEFINE_HEX_XDR_NETOBJ(des3_dk_usage_155,
-		      0x00, 0x00, 0x00, 0x01, 0x55
-);
-
-DEFINE_HEX_XDR_NETOBJ(des3_dk_usage_1aa,
-		      0x00, 0x00, 0x00, 0x01, 0xaa
-);
-
-DEFINE_HEX_XDR_NETOBJ(des3_dk_usage_kerberos,
-		      0x6b, 0x65, 0x72, 0x62, 0x65, 0x72, 0x6f, 0x73
-);
-
-DEFINE_HEX_XDR_NETOBJ(des3_dk_test1_base_key,
-		      0xdc, 0xe0, 0x6b, 0x1f, 0x64, 0xc8, 0x57, 0xa1,
-		      0x1c, 0x3d, 0xb5, 0x7c, 0x51, 0x89, 0x9b, 0x2c,
-		      0xc1, 0x79, 0x10, 0x08, 0xce, 0x97, 0x3b, 0x92
-);
-DEFINE_HEX_XDR_NETOBJ(des3_dk_test1_derived_key,
-		      0x92, 0x51, 0x79, 0xd0, 0x45, 0x91, 0xa7, 0x9b,
-		      0x5d, 0x31, 0x92, 0xc4, 0xa7, 0xe9, 0xc2, 0x89,
-		      0xb0, 0x49, 0xc7, 0x1f, 0x6e, 0xe6, 0x04, 0xcd
-);
-
-DEFINE_HEX_XDR_NETOBJ(des3_dk_test2_base_key,
-		      0x5e, 0x13, 0xd3, 0x1c, 0x70, 0xef, 0x76, 0x57,
-		      0x46, 0x57, 0x85, 0x31, 0xcb, 0x51, 0xc1, 0x5b,
-		      0xf1, 0x1c, 0xa8, 0x2c, 0x97, 0xce, 0xe9, 0xf2
-);
-DEFINE_HEX_XDR_NETOBJ(des3_dk_test2_derived_key,
-		      0x9e, 0x58, 0xe5, 0xa1, 0x46, 0xd9, 0x94, 0x2a,
-		      0x10, 0x1c, 0x46, 0x98, 0x45, 0xd6, 0x7a, 0x20,
-		      0xe3, 0xc4, 0x25, 0x9e, 0xd9, 0x13, 0xf2, 0x07
-);
-
-DEFINE_HEX_XDR_NETOBJ(des3_dk_test3_base_key,
-		      0x98, 0xe6, 0xfd, 0x8a, 0x04, 0xa4, 0xb6, 0x85,
-		      0x9b, 0x75, 0xa1, 0x76, 0x54, 0x0b, 0x97, 0x52,
-		      0xba, 0xd3, 0xec, 0xd6, 0x10, 0xa2, 0x52, 0xbc
-);
-DEFINE_HEX_XDR_NETOBJ(des3_dk_test3_derived_key,
-		      0x13, 0xfe, 0xf8, 0x0d, 0x76, 0x3e, 0x94, 0xec,
-		      0x6d, 0x13, 0xfd, 0x2c, 0xa1, 0xd0, 0x85, 0x07,
-		      0x02, 0x49, 0xda, 0xd3, 0x98, 0x08, 0xea, 0xbf
-);
-
-DEFINE_HEX_XDR_NETOBJ(des3_dk_test4_base_key,
-		      0x62, 0x2a, 0xec, 0x25, 0xa2, 0xfe, 0x2c, 0xad,
-		      0x70, 0x94, 0x68, 0x0b, 0x7c, 0x64, 0x94, 0x02,
-		      0x80, 0x08, 0x4c, 0x1a, 0x7c, 0xec, 0x92, 0xb5
-);
-DEFINE_HEX_XDR_NETOBJ(des3_dk_test4_derived_key,
-		      0xf8, 0xdf, 0xbf, 0x04, 0xb0, 0x97, 0xe6, 0xd9,
-		      0xdc, 0x07, 0x02, 0x68, 0x6b, 0xcb, 0x34, 0x89,
-		      0xd9, 0x1f, 0xd9, 0xa4, 0x51, 0x6b, 0x70, 0x3e
-);
-
-DEFINE_HEX_XDR_NETOBJ(des3_dk_test5_base_key,
-		      0xd3, 0xf8, 0x29, 0x8c, 0xcb, 0x16, 0x64, 0x38,
-		      0xdc, 0xb9, 0xb9, 0x3e, 0xe5, 0xa7, 0x62, 0x92,
-		      0x86, 0xa4, 0x91, 0xf8, 0x38, 0xf8, 0x02, 0xfb
-);
-DEFINE_HEX_XDR_NETOBJ(des3_dk_test5_derived_key,
-		      0x23, 0x70, 0xda, 0x57, 0x5d, 0x2a, 0x3d, 0xa8,
-		      0x64, 0xce, 0xbf, 0xdc, 0x52, 0x04, 0xd5, 0x6d,
-		      0xf7, 0x79, 0xa7, 0xdf, 0x43, 0xd9, 0xda, 0x43
-);
-
-DEFINE_HEX_XDR_NETOBJ(des3_dk_test6_base_key,
-		      0xc1, 0x08, 0x16, 0x49, 0xad, 0xa7, 0x43, 0x62,
-		      0xe6, 0xa1, 0x45, 0x9d, 0x01, 0xdf, 0xd3, 0x0d,
-		      0x67, 0xc2, 0x23, 0x4c, 0x94, 0x07, 0x04, 0xda
-);
-DEFINE_HEX_XDR_NETOBJ(des3_dk_test6_derived_key,
-		      0x34, 0x80, 0x57, 0xec, 0x98, 0xfd, 0xc4, 0x80,
-		      0x16, 0x16, 0x1c, 0x2a, 0x4c, 0x7a, 0x94, 0x3e,
-		      0x92, 0xae, 0x49, 0x2c, 0x98, 0x91, 0x75, 0xf7
-);
-
-DEFINE_HEX_XDR_NETOBJ(des3_dk_test7_base_key,
-		      0x5d, 0x15, 0x4a, 0xf2, 0x38, 0xf4, 0x67, 0x13,
-		      0x15, 0x57, 0x19, 0xd5, 0x5e, 0x2f, 0x1f, 0x79,
-		      0x0d, 0xd6, 0x61, 0xf2, 0x79, 0xa7, 0x91, 0x7c
-);
-DEFINE_HEX_XDR_NETOBJ(des3_dk_test7_derived_key,
-		      0xa8, 0x80, 0x8a, 0xc2, 0x67, 0xda, 0xda, 0x3d,
-		      0xcb, 0xe9, 0xa7, 0xc8, 0x46, 0x26, 0xfb, 0xc7,
-		      0x61, 0xc2, 0x94, 0xb0, 0x13, 0x15, 0xe5, 0xc1
-);
-
-DEFINE_HEX_XDR_NETOBJ(des3_dk_test8_base_key,
-		      0x79, 0x85, 0x62, 0xe0, 0x49, 0x85, 0x2f, 0x57,
-		      0xdc, 0x8c, 0x34, 0x3b, 0xa1, 0x7f, 0x2c, 0xa1,
-		      0xd9, 0x73, 0x94, 0xef, 0xc8, 0xad, 0xc4, 0x43
-);
-DEFINE_HEX_XDR_NETOBJ(des3_dk_test8_derived_key,
-		      0xc8, 0x13, 0xf8, 0x8a, 0x3b, 0xe3, 0xb3, 0x34,
-		      0xf7, 0x54, 0x25, 0xce, 0x91, 0x75, 0xfb, 0xe3,
-		      0xc8, 0x49, 0x3b, 0x89, 0xc8, 0x70, 0x3b, 0x49
-);
-
-DEFINE_HEX_XDR_NETOBJ(des3_dk_test9_base_key,
-		      0x26, 0xdc, 0xe3, 0x34, 0xb5, 0x45, 0x29, 0x2f,
-		      0x2f, 0xea, 0xb9, 0xa8, 0x70, 0x1a, 0x89, 0xa4,
-		      0xb9, 0x9e, 0xb9, 0x94, 0x2c, 0xec, 0xd0, 0x16
-);
-DEFINE_HEX_XDR_NETOBJ(des3_dk_test9_derived_key,
-		      0xf4, 0x8f, 0xfd, 0x6e, 0x83, 0xf8, 0x3e, 0x73,
-		      0x54, 0xe6, 0x94, 0xfd, 0x25, 0x2c, 0xf8, 0x3b,
-		      0xfe, 0x58, 0xf7, 0xd5, 0xba, 0x37, 0xec, 0x5d
-);
-
-static const struct gss_krb5_test_param rfc3961_kdf_test_params[] = {
-	{
-		.desc			= "des3-hmac-sha1 key derivation case 1",
-		.enctype		= ENCTYPE_DES3_CBC_RAW,
-		.base_key		= &des3_dk_test1_base_key,
-		.usage			= &des3_dk_usage_155,
-		.expected_result	= &des3_dk_test1_derived_key,
-	},
-	{
-		.desc			= "des3-hmac-sha1 key derivation case 2",
-		.enctype		= ENCTYPE_DES3_CBC_RAW,
-		.base_key		= &des3_dk_test2_base_key,
-		.usage			= &des3_dk_usage_1aa,
-		.expected_result	= &des3_dk_test2_derived_key,
-	},
-	{
-		.desc			= "des3-hmac-sha1 key derivation case 3",
-		.enctype		= ENCTYPE_DES3_CBC_RAW,
-		.base_key		= &des3_dk_test3_base_key,
-		.usage			= &des3_dk_usage_155,
-		.expected_result	= &des3_dk_test3_derived_key,
-	},
-	{
-		.desc			= "des3-hmac-sha1 key derivation case 4",
-		.enctype		= ENCTYPE_DES3_CBC_RAW,
-		.base_key		= &des3_dk_test4_base_key,
-		.usage			= &des3_dk_usage_1aa,
-		.expected_result	= &des3_dk_test4_derived_key,
-	},
-	{
-		.desc			= "des3-hmac-sha1 key derivation case 5",
-		.enctype		= ENCTYPE_DES3_CBC_RAW,
-		.base_key		= &des3_dk_test5_base_key,
-		.usage			= &des3_dk_usage_kerberos,
-		.expected_result	= &des3_dk_test5_derived_key,
-	},
-	{
-		.desc			= "des3-hmac-sha1 key derivation case 6",
-		.enctype		= ENCTYPE_DES3_CBC_RAW,
-		.base_key		= &des3_dk_test6_base_key,
-		.usage			= &des3_dk_usage_155,
-		.expected_result	= &des3_dk_test6_derived_key,
-	},
-	{
-		.desc			= "des3-hmac-sha1 key derivation case 7",
-		.enctype		= ENCTYPE_DES3_CBC_RAW,
-		.base_key		= &des3_dk_test7_base_key,
-		.usage			= &des3_dk_usage_1aa,
-		.expected_result	= &des3_dk_test7_derived_key,
-	},
-	{
-		.desc			= "des3-hmac-sha1 key derivation case 8",
-		.enctype		= ENCTYPE_DES3_CBC_RAW,
-		.base_key		= &des3_dk_test8_base_key,
-		.usage			= &des3_dk_usage_155,
-		.expected_result	= &des3_dk_test8_derived_key,
-	},
-	{
-		.desc			= "des3-hmac-sha1 key derivation case 9",
-		.enctype		= ENCTYPE_DES3_CBC_RAW,
-		.base_key		= &des3_dk_test9_base_key,
-		.usage			= &des3_dk_usage_1aa,
-		.expected_result	= &des3_dk_test9_derived_key,
-	},
-};
-
-/* Creates the function rfc3961_kdf_gen_params */
-KUNIT_ARRAY_PARAM(rfc3961_kdf, rfc3961_kdf_test_params, gss_krb5_get_desc);
-
 static struct kunit_case rfc3961_test_cases[] = {
 	{
 		.name			= "RFC 3961 n-fold",
 		.run_case		= rfc3961_nfold_case,
 		.generate_params	= rfc3961_nfold_gen_params,
 	},
-	{
-		.name			= "RFC 3961 key derivation",
-		.run_case		= kdf_case,
-		.generate_params	= rfc3961_kdf_gen_params,
-	},
 	{}
 };
 


