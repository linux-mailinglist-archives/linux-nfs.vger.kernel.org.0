Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97C2669C3C
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jan 2023 16:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjAMPau (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Jan 2023 10:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjAMPaK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Jan 2023 10:30:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FDDB7EC93
        for <linux-nfs@vger.kernel.org>; Fri, 13 Jan 2023 07:23:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F36C4B82121
        for <linux-nfs@vger.kernel.org>; Fri, 13 Jan 2023 15:22:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57832C433D2;
        Fri, 13 Jan 2023 15:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673623377;
        bh=v4JgldVMqv+TdODbHkrf0+pe07F9Njga7uDvxHurm+I=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=PtRSS/fkyRPxh7gUPWf2pWIIpqUPV8pG/VVTvX4N1rtlX2kHGyJBQFz7XhGeXSJNh
         rHAsNmmIqOuMU7Yrat8LfCwPH1uZ/WolBEojVBqGj/1rn0V9cN8SToOGfc1Ggmz6q/
         bZQEek2goAZIQ03Vvcl9pCV74sRzQhX3RvxNJ8jpib0ESUaS0y5rJKRj7WZcS2a1Bw
         o7f53iXI3nb1NzeWo7OLdUBWpt/n7UIlvwOTjpwsM1NK8E/nLOxdDIOmLt2qPlSFKV
         6gTw50BQAA+nYJIeafg207bG/qv3WZCXcG+kQUgFd8tEdKmEPT1KRxzeeBnoMicqqL
         JECATMrJc092w==
Subject: [PATCH v1 14/41] SUNRPC: Replace KRB5_SUPPORTED_ENCTYPES macro
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, simo@redhat.com
Date:   Fri, 13 Jan 2023 10:22:56 -0500
Message-ID: <167362337645.8960.2534116685918772760.stgit@bazille.1015granger.net>
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

Now that all consumers of the KRB5_SUPPORTED_ENCTYPES macro are
within the SunRPC layer, the macro can be replaced with something
private and more flexible.

Tested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/gss_krb5_enctypes.h |   41 ------------------------------
 net/sunrpc/auth_gss/gss_krb5_mech.c      |   41 +++++++++++++++++++++++++++++-
 2 files changed, 39 insertions(+), 43 deletions(-)
 delete mode 100644 include/linux/sunrpc/gss_krb5_enctypes.h

diff --git a/include/linux/sunrpc/gss_krb5_enctypes.h b/include/linux/sunrpc/gss_krb5_enctypes.h
deleted file mode 100644
index 87eea679d750..000000000000
--- a/include/linux/sunrpc/gss_krb5_enctypes.h
+++ /dev/null
@@ -1,41 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Define the string that exports the set of kernel-supported
- * Kerberos enctypes. This list is sent via upcall to gssd, and
- * is also exposed via the nfsd /proc API. The consumers generally
- * treat this as an ordered list, where the first item in the list
- * is the most preferred.
- */
-
-#ifndef _LINUX_SUNRPC_GSS_KRB5_ENCTYPES_H
-#define _LINUX_SUNRPC_GSS_KRB5_ENCTYPES_H
-
-#ifdef CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES
-
-/*
- * NB: This list includes DES3_CBC_SHA1, which was deprecated by RFC 8429.
- *
- * ENCTYPE_AES256_CTS_HMAC_SHA1_96
- * ENCTYPE_AES128_CTS_HMAC_SHA1_96
- * ENCTYPE_DES3_CBC_SHA1
- */
-#define KRB5_SUPPORTED_ENCTYPES "18,17,16"
-
-#else	/* CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES */
-
-/*
- * NB: This list includes encryption types that were deprecated
- * by RFC 8429 and RFC 6649.
- *
- * ENCTYPE_AES256_CTS_HMAC_SHA1_96
- * ENCTYPE_AES128_CTS_HMAC_SHA1_96
- * ENCTYPE_DES3_CBC_SHA1
- * ENCTYPE_DES_CBC_MD5
- * ENCTYPE_DES_CBC_CRC
- * ENCTYPE_DES_CBC_MD4
- */
-#define KRB5_SUPPORTED_ENCTYPES "18,17,16,3,1,2"
-
-#endif	/* CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES */
-
-#endif	/* _LINUX_SUNRPC_GSS_KRB5_ENCTYPES_H */
diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index 4986435e9b92..a0c4e45888a4 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -19,7 +19,6 @@
 #include <linux/sunrpc/auth.h>
 #include <linux/sunrpc/gss_krb5.h>
 #include <linux/sunrpc/xdr.h>
-#include <linux/sunrpc/gss_krb5_enctypes.h>
 
 #include "auth_gss_internal.h"
 #include "gss_krb5_internal.h"
@@ -145,6 +144,43 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 	},
 };
 
+/*
+ * The list of advertised enctypes is specified in order of most
+ * preferred to least.
+ */
+static char gss_krb5_enctype_priority_list[64];
+
+static void gss_krb5_prepare_enctype_priority_list(void)
+{
+	static const u32 gss_krb5_enctypes[] = {
+		ENCTYPE_AES256_CTS_HMAC_SHA1_96,
+		ENCTYPE_AES128_CTS_HMAC_SHA1_96,
+		ENCTYPE_DES3_CBC_SHA1,
+#ifndef CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES
+		ENCTYPE_DES_CBC_MD5,
+		ENCTYPE_DES_CBC_CRC,
+		ENCTYPE_DES_CBC_MD4,
+#endif
+	};
+	size_t total, i;
+	char buf[16];
+	char *sep;
+	int n;
+
+	sep = "";
+	gss_krb5_enctype_priority_list[0] = '\0';
+	for (total = 0, i = 0; i < ARRAY_SIZE(gss_krb5_enctypes); i++) {
+		n = sprintf(buf, "%s%u", sep, gss_krb5_enctypes[i]);
+		if (n < 0)
+			break;
+		if (total + n >= sizeof(gss_krb5_enctype_priority_list))
+			break;
+		strcat(gss_krb5_enctype_priority_list, buf);
+		sep = ",";
+		total += n;
+	}
+}
+
 static const int num_supported_enctypes =
 	ARRAY_SIZE(supported_gss_krb5_enctypes);
 
@@ -763,13 +799,14 @@ static struct gss_api_mech gss_kerberos_mech = {
 	.gm_ops		= &gss_kerberos_ops,
 	.gm_pf_num	= ARRAY_SIZE(gss_kerberos_pfs),
 	.gm_pfs		= gss_kerberos_pfs,
-	.gm_upcall_enctypes = KRB5_SUPPORTED_ENCTYPES,
+	.gm_upcall_enctypes = gss_krb5_enctype_priority_list,
 };
 
 static int __init init_kerberos_module(void)
 {
 	int status;
 
+	gss_krb5_prepare_enctype_priority_list();
 	status = gss_mech_register(&gss_kerberos_mech);
 	if (status)
 		printk("Failed to register kerberos gss mechanism!\n");


