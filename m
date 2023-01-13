Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 860BD669C42
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jan 2023 16:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjAMPbA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Jan 2023 10:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbjAMPaa (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Jan 2023 10:30:30 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F7725E2
        for <linux-nfs@vger.kernel.org>; Fri, 13 Jan 2023 07:23:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 11A08CE20E4
        for <linux-nfs@vger.kernel.org>; Fri, 13 Jan 2023 15:23:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D52C433F2;
        Fri, 13 Jan 2023 15:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673623409;
        bh=Iic1LRBOerxdEticEl5FwsjAIN/fSkrT8nfnxkjwkhc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=aVJCFRM/B+Pj3depQnf3ZOa3l8A0l6RKJIPqVx9PiYtmD4CvtMFdFzMnCuBr9hAIA
         cs3FkKQ2RwdU9zzq2SlNCy0sDbjRJB2BAeLQ5/ST0OOLrTi5qc6oqOWg+G5D9yE42z
         1E7VAczMWRexFn7uTL8UbzcQepsDTg9C0dtWCqCcmomQ10ryZQXbh1qdjp/ORZ9RT6
         pJAJKiTGmv/o/fufmNAP92Z/YG4jZg0jfEacLos827CksuRqOkeBtLzshT7vQeJzY2
         mc71SSiYhAOON8iDJUFRSdXc/v6oxg6vE7ZoZJeAw/PUWa21imFy/CYVzRqVh76ViI
         GoznxsvR8uFqw==
Subject: [PATCH v1 19/41] SUNRPC: Clean up cipher set up for v1 encryption
 types
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, simo@redhat.com
Date:   Fri, 13 Jan 2023 10:23:28 -0500
Message-ID: <167362340814.8960.5512279594588055531.stgit@bazille.1015granger.net>
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

De-duplicate some common code.

Tested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_krb5_mech.c |   58 ++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index 33fa09fa3d21..579ff755d535 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -204,17 +204,32 @@ get_gss_krb5_enctype(int etype)
 	return NULL;
 }
 
+static struct crypto_sync_skcipher *
+gss_krb5_alloc_cipher_v1(struct krb5_ctx *ctx, struct xdr_netobj *key)
+{
+	struct crypto_sync_skcipher *tfm;
+
+	tfm = crypto_alloc_sync_skcipher(ctx->gk5e->encrypt_name, 0, 0);
+	if (IS_ERR(tfm))
+		return NULL;
+	if (crypto_sync_skcipher_setkey(tfm, key->data, key->len)) {
+		crypto_free_sync_skcipher(tfm);
+		return NULL;
+	}
+	return tfm;
+}
+
 static inline const void *
 get_key(const void *p, const void *end,
 	struct krb5_ctx *ctx, struct crypto_sync_skcipher **res)
 {
+	struct crypto_sync_skcipher *tfm;
 	struct xdr_netobj	key;
 	int			alg;
 
 	p = simple_get_bytes(p, end, &alg, sizeof(alg));
 	if (IS_ERR(p))
 		goto out_err;
-
 	switch (alg) {
 	case ENCTYPE_DES_CBC_CRC:
 	case ENCTYPE_DES_CBC_MD4:
@@ -223,37 +238,26 @@ get_key(const void *p, const void *end,
 		alg = ENCTYPE_DES_CBC_RAW;
 		break;
 	}
-
 	if (!supported_gss_krb5_enctype(alg)) {
-		printk(KERN_WARNING "gss_kerberos_mech: unsupported "
-			"encryption key algorithm %d\n", alg);
-		p = ERR_PTR(-EINVAL);
-		goto out_err;
+		pr_warn("gss_krb5: unsupported enctype: %d\n", alg);
+		goto out_err_inval;
 	}
+
 	p = simple_get_netobj(p, end, &key);
 	if (IS_ERR(p))
 		goto out_err;
-
-	*res = crypto_alloc_sync_skcipher(ctx->gk5e->encrypt_name, 0, 0);
-	if (IS_ERR(*res)) {
-		printk(KERN_WARNING "gss_kerberos_mech: unable to initialize "
-			"crypto algorithm %s\n", ctx->gk5e->encrypt_name);
-		*res = NULL;
-		goto out_err_free_key;
-	}
-	if (crypto_sync_skcipher_setkey(*res, key.data, key.len)) {
-		printk(KERN_WARNING "gss_kerberos_mech: error setting key for "
-			"crypto algorithm %s\n", ctx->gk5e->encrypt_name);
-		goto out_err_free_tfm;
+	tfm = gss_krb5_alloc_cipher_v1(ctx, &key);
+	kfree(key.data);
+	if (!tfm) {
+		pr_warn("gss_krb5: failed to initialize cipher '%s'\n",
+			ctx->gk5e->encrypt_name);
+		goto out_err_inval;
 	}
+	*res = tfm;
 
-	kfree(key.data);
 	return p;
 
-out_err_free_tfm:
-	crypto_free_sync_skcipher(*res);
-out_err_free_key:
-	kfree(key.data);
+out_err_inval:
 	p = ERR_PTR(-EINVAL);
 out_err:
 	return p;
@@ -372,14 +376,10 @@ gss_krb5_import_ctx_v1(struct krb5_ctx *ctx, gfp_t gfp_mask)
 	keyin.data = ctx->Ksess;
 	keyin.len = ctx->gk5e->keylength;
 
-	/* seq uses the raw key */
-	ctx->seq = context_v2_alloc_cipher(ctx, ctx->gk5e->encrypt_name,
-					   ctx->Ksess);
+	ctx->seq = gss_krb5_alloc_cipher_v1(ctx, &keyin);
 	if (ctx->seq == NULL)
 		goto out_err;
-
-	ctx->enc = context_v2_alloc_cipher(ctx, ctx->gk5e->encrypt_name,
-					   ctx->Ksess);
+	ctx->enc = gss_krb5_alloc_cipher_v1(ctx, &keyin);
 	if (ctx->enc == NULL)
 		goto out_free_seq;
 


