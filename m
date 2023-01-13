Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07EBC669C2E
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jan 2023 16:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjAMP3h (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Jan 2023 10:29:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjAMP2Z (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Jan 2023 10:28:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F57277D1B
        for <linux-nfs@vger.kernel.org>; Fri, 13 Jan 2023 07:22:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE60E6216C
        for <linux-nfs@vger.kernel.org>; Fri, 13 Jan 2023 15:22:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19046C433D2;
        Fri, 13 Jan 2023 15:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673623333;
        bh=LFjemD4TUP+Zd2j4WiYOgkDVgJttBm9I86HZmcTSXTw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qqF9OeTtxv+K64krBjv9g6cF2lNtZqfNlRRxW3rotnvfOuA7/L/sbtdSHGH71tSyN
         qw4L+9JgnH+w/3PdS1IFfZml1MTeUQexZMACrQoDKHfWD8W51JIcmc/mzsf0CxJX0m
         q/6k8q6+YbXkcdSwu8GwooAsamM8WEqfY2UWtW4hB7DgPZ9JEvj7qIptrAAFLEJupI
         Tmq7akCfm3pmqlpuizJNPPa/IdwxOLMiUicDQgrPHDWmrItfBQCw6cuRK2BdUjBcxT
         zL+tsBE9F8f9x1KK/XhrqaLYscV3FL4rQkp+/WB+Mu6UIE1GcAa4vbgOQSkmcZE796
         7l1771/8ik0YQ==
Subject: [PATCH v1 07/41] SUNRPC: Obscure Kerberos encryption keys
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, simo@redhat.com
Date:   Fri, 13 Jan 2023 10:22:12 -0500
Message-ID: <167362333213.8960.4251999590261954481.stgit@bazille.1015granger.net>
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

The encryption subkeys are not used after the cipher transforms have
been allocated and keyed. There is no need to retain them in struct
krb5_ctx.

Tested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/gss_krb5.h     |    2 --
 net/sunrpc/auth_gss/gss_krb5_mech.c |   43 +++++++++++++++++++++--------------
 2 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/include/linux/sunrpc/gss_krb5.h b/include/linux/sunrpc/gss_krb5.h
index 77f6adf20f7f..806df140feae 100644
--- a/include/linux/sunrpc/gss_krb5.h
+++ b/include/linux/sunrpc/gss_krb5.h
@@ -114,8 +114,6 @@ struct krb5_ctx {
 	struct xdr_netobj	mech_used;
 	u8			initiator_sign[GSS_KRB5_MAX_KEYLEN];
 	u8			acceptor_sign[GSS_KRB5_MAX_KEYLEN];
-	u8			initiator_seal[GSS_KRB5_MAX_KEYLEN];
-	u8			acceptor_seal[GSS_KRB5_MAX_KEYLEN];
 	u8			initiator_integ[GSS_KRB5_MAX_KEYLEN];
 	u8			acceptor_integ[GSS_KRB5_MAX_KEYLEN];
 };
diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index 3a464cb3f6e9..ba3cfcb2c7c5 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -350,42 +350,49 @@ context_derive_keys_des3(struct krb5_ctx *ctx, gfp_t gfp_mask)
 static int
 context_derive_keys_new(struct krb5_ctx *ctx, gfp_t gfp_mask)
 {
-	struct xdr_netobj c, keyin, keyout;
 	u8 cdata[GSS_KRB5_K5CLENGTH];
+	struct xdr_netobj c = {
+		.len	= sizeof(cdata),
+		.data	= cdata,
+	};
+	struct xdr_netobj keyin = {
+		.len	= ctx->gk5e->keylength,
+		.data	= ctx->Ksess,
+	};
+	struct xdr_netobj keyout;
+	int ret = -EINVAL;
+	void *subkey;
 	u32 err;
 
-	c.len = GSS_KRB5_K5CLENGTH;
-	c.data = cdata;
-
-	keyin.data = ctx->Ksess;
-	keyin.len = ctx->gk5e->keylength;
+	subkey = kmalloc(ctx->gk5e->keylength, gfp_mask);
+	if (!subkey)
+		return -ENOMEM;
 	keyout.len = ctx->gk5e->keylength;
+	keyout.data = subkey;
 
 	/* initiator seal encryption */
 	set_cdata(cdata, KG_USAGE_INITIATOR_SEAL, KEY_USAGE_SEED_ENCRYPTION);
-	keyout.data = ctx->initiator_seal;
 	err = krb5_derive_key(ctx->gk5e, &keyin, &keyout, &c, gfp_mask);
 	if (err) {
 		dprintk("%s: Error %d deriving initiator_seal key\n",
 			__func__, err);
-		goto out_err;
+		goto out;
 	}
 	ctx->initiator_enc = context_v2_alloc_cipher(ctx,
 						     ctx->gk5e->encrypt_name,
-						     ctx->initiator_seal);
+						     subkey);
 	if (ctx->initiator_enc == NULL)
-		goto out_err;
+		goto out;
 	if (ctx->gk5e->aux_cipher) {
 		ctx->initiator_enc_aux =
 			context_v2_alloc_cipher(ctx, ctx->gk5e->aux_cipher,
-						ctx->initiator_seal);
+						subkey);
 		if (ctx->initiator_enc_aux == NULL)
 			goto out_free;
 	}
 
 	/* acceptor seal encryption */
 	set_cdata(cdata, KG_USAGE_ACCEPTOR_SEAL, KEY_USAGE_SEED_ENCRYPTION);
-	keyout.data = ctx->acceptor_seal;
 	err = krb5_derive_key(ctx->gk5e, &keyin, &keyout, &c, gfp_mask);
 	if (err) {
 		dprintk("%s: Error %d deriving acceptor_seal key\n",
@@ -394,13 +401,13 @@ context_derive_keys_new(struct krb5_ctx *ctx, gfp_t gfp_mask)
 	}
 	ctx->acceptor_enc = context_v2_alloc_cipher(ctx,
 						    ctx->gk5e->encrypt_name,
-						    ctx->acceptor_seal);
+						    subkey);
 	if (ctx->acceptor_enc == NULL)
 		goto out_free;
 	if (ctx->gk5e->aux_cipher) {
 		ctx->acceptor_enc_aux =
 			context_v2_alloc_cipher(ctx, ctx->gk5e->aux_cipher,
-						ctx->acceptor_seal);
+						subkey);
 		if (ctx->acceptor_enc_aux == NULL)
 			goto out_free;
 	}
@@ -445,15 +452,17 @@ context_derive_keys_new(struct krb5_ctx *ctx, gfp_t gfp_mask)
 		goto out_free;
 	}
 
-	return 0;
+	ret = 0;
+out:
+	kfree_sensitive(subkey);
+	return ret;
 
 out_free:
 	crypto_free_sync_skcipher(ctx->acceptor_enc_aux);
 	crypto_free_sync_skcipher(ctx->acceptor_enc);
 	crypto_free_sync_skcipher(ctx->initiator_enc_aux);
 	crypto_free_sync_skcipher(ctx->initiator_enc);
-out_err:
-	return -EINVAL;
+	goto out;
 }
 
 static int


