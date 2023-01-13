Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C4B669C56
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jan 2023 16:31:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjAMPbr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Jan 2023 10:31:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjAMPbX (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Jan 2023 10:31:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA8893C20
        for <linux-nfs@vger.kernel.org>; Fri, 13 Jan 2023 07:24:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 013BD620DB
        for <linux-nfs@vger.kernel.org>; Fri, 13 Jan 2023 15:24:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C424C433F1;
        Fri, 13 Jan 2023 15:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673623491;
        bh=95bsxLo4a4ZblD9HrvKC0Rtul43dyBzsmW308CcxgXk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=aQ62g9iPaQb3woDu/k94mfv5eO9zHYDteg2NljlM51w3zc0F13mjbryZLde1b68UO
         h4wdNNgIe47g0zHMl/kJrWOhX+AWzjAk3GoGjun1R3pt7TcGC+3wk3O+1r+/ydCzaX
         wiQvsrNSSU2holvYutrMMl4AuGpn0YVL2Pk/RtRbxnOE8agmmteoXoXF+q2iv4GA/W
         umZnvT8x6XD7xwxb9a6atJnwf+s6Y1CF0jOcyN5W9SslYmiaDi457UDWa1HgYBq+XO
         My4/sPiJZv2LcHySD0JZAA0595yIWvN+8DBvRBjAnKdMI1+S5C45uuFaE15GvJj4YI
         NIVM7ghvYUTdA==
Subject: [PATCH v1 32/41] SUNRPC: Export get_gss_krb5_enctype()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, simo@redhat.com
Date:   Fri, 13 Jan 2023 10:24:50 -0500
Message-ID: <167362349024.8960.17925315944330916382.stgit@bazille.1015granger.net>
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

I plan to add KUnit tests that will need enctype profile
information. Export the enctype profile lookup function.

Tested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_krb5_internal.h |    1 +
 net/sunrpc/auth_gss/gss_krb5_mech.c     |   35 ++++++++++++++-----------------
 2 files changed, 17 insertions(+), 19 deletions(-)

diff --git a/net/sunrpc/auth_gss/gss_krb5_internal.h b/net/sunrpc/auth_gss/gss_krb5_internal.h
index b2cf975a42d4..a24e67938c80 100644
--- a/net/sunrpc/auth_gss/gss_krb5_internal.h
+++ b/net/sunrpc/auth_gss/gss_krb5_internal.h
@@ -219,6 +219,7 @@ u32 krb5_etm_decrypt(struct krb5_ctx *kctx, u32 offset, u32 len,
 
 #if IS_ENABLED(CONFIG_KUNIT)
 void krb5_nfold(u32 inbits, const u8 *in, u32 outbits, u8 *out);
+const struct gss_krb5_enctype *gss_krb5_lookup_enctype(u32 etype);
 #endif
 
 #endif /* _NET_SUNRPC_AUTH_GSS_KRB5_INTERNAL_H */
diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index 6e728a8a3a37..7af651daf814 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -19,6 +19,7 @@
 #include <linux/sunrpc/auth.h>
 #include <linux/sunrpc/gss_krb5.h>
 #include <linux/sunrpc/xdr.h>
+#include <kunit/visibility.h>
 
 #include "auth_gss_internal.h"
 #include "gss_krb5_internal.h"
@@ -309,28 +310,24 @@ static void gss_krb5_prepare_enctype_priority_list(void)
 	}
 }
 
-static const int num_supported_enctypes =
-	ARRAY_SIZE(supported_gss_krb5_enctypes);
-
-static int
-supported_gss_krb5_enctype(int etype)
+/**
+ * gss_krb5_lookup_enctype - Retrieve profile information for a given enctype
+ * @etype: ENCTYPE value
+ *
+ * Returns a pointer to a gss_krb5_enctype structure, or NULL if no
+ * matching etype is found.
+ */
+VISIBLE_IF_KUNIT
+const struct gss_krb5_enctype *gss_krb5_lookup_enctype(u32 etype)
 {
-	int i;
-	for (i = 0; i < num_supported_enctypes; i++)
-		if (supported_gss_krb5_enctypes[i].etype == etype)
-			return 1;
-	return 0;
-}
+	size_t i;
 
-static const struct gss_krb5_enctype *
-get_gss_krb5_enctype(int etype)
-{
-	int i;
-	for (i = 0; i < num_supported_enctypes; i++)
+	for (i = 0; i < ARRAY_SIZE(supported_gss_krb5_enctypes); i++)
 		if (supported_gss_krb5_enctypes[i].etype == etype)
 			return &supported_gss_krb5_enctypes[i];
 	return NULL;
 }
+EXPORT_SYMBOL_IF_KUNIT(gss_krb5_lookup_enctype);
 
 static struct crypto_sync_skcipher *
 gss_krb5_alloc_cipher_v1(struct krb5_ctx *ctx, struct xdr_netobj *key)
@@ -366,7 +363,7 @@ get_key(const void *p, const void *end,
 		alg = ENCTYPE_DES_CBC_RAW;
 		break;
 	}
-	if (!supported_gss_krb5_enctype(alg)) {
+	if (!gss_krb5_lookup_enctype(alg)) {
 		pr_warn("gss_krb5: unsupported enctype: %d\n", alg);
 		goto out_err_inval;
 	}
@@ -405,7 +402,7 @@ gss_import_v1_context(const void *p, const void *end, struct krb5_ctx *ctx)
 	/* Old format supports only DES!  Any other enctype uses new format */
 	ctx->enctype = ENCTYPE_DES_CBC_RAW;
 
-	ctx->gk5e = get_gss_krb5_enctype(ctx->enctype);
+	ctx->gk5e = gss_krb5_lookup_enctype(ctx->enctype);
 	if (ctx->gk5e == NULL) {
 		p = ERR_PTR(-EINVAL);
 		goto out_err;
@@ -677,7 +674,7 @@ gss_import_v2_context(const void *p, const void *end, struct krb5_ctx *ctx,
 	/* Map ENCTYPE_DES3_CBC_SHA1 to ENCTYPE_DES3_CBC_RAW */
 	if (ctx->enctype == ENCTYPE_DES3_CBC_SHA1)
 		ctx->enctype = ENCTYPE_DES3_CBC_RAW;
-	ctx->gk5e = get_gss_krb5_enctype(ctx->enctype);
+	ctx->gk5e = gss_krb5_lookup_enctype(ctx->enctype);
 	if (ctx->gk5e == NULL) {
 		dprintk("gss_kerberos_mech: unsupported krb5 enctype %u\n",
 			ctx->enctype);


