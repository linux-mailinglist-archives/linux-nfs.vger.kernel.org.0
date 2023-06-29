Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B13742B90
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jun 2023 19:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjF2RvW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Jun 2023 13:51:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231634AbjF2RvR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Jun 2023 13:51:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E558126B6
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 10:51:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DB1E615D2
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 17:51:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF86C433C0;
        Thu, 29 Jun 2023 17:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688061074;
        bh=34YZ46qznG4z8Zo7dWBsd0nnnfMu5RjX9Ab+Jb9Bo+s=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=OsQOkOFdOeYYAR+XjgwdoocqoWyrZvPy2/HzvJtmVC7kHLRF5FZWCEzIzpqNI1npx
         JJhdfwXq8x3UMcXmdQyeUOaTVYzrx2BA4sz9GAj7X7/4SILyYsieSZ8ViLvRJmktIx
         ArqUjdD1zRGgvx9q7J7Rn36sJfMTQJv6HNuN1Sn256X1WtlGzQw3qZco3XvC91ZYSS
         yIvbHeJjhdL7fCbcTrX9Get5yFiwb07pdyXRURwritc9eFxfCvfo/+CjDpKTpJAZ29
         rdvG1muv7BhMRcbITvswwEVa50ROgnb9SXHjWxbZnAD26pAyERmfHqbgWWjgcoJjqQ
         IXdvhqz2HsLIA==
Subject: [PATCH v1 6/9] SUNRPC: Remove gss_import_v1_context()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, dhowells@redhat.com,
        simo@redhat.com, smayhew@redhat.com
Date:   Thu, 29 Jun 2023 13:51:13 -0400
Message-ID: <168806107352.507650.2586864499160013168.stgit@morisot.1015granger.net>
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

We no longer support importing v1 contexts.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_krb5_mech.c |  142 -----------------------------------
 1 file changed, 1 insertion(+), 141 deletions(-)

diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index 890ad877792f..09fff5011d11 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -273,143 +273,6 @@ const struct gss_krb5_enctype *gss_krb5_lookup_enctype(u32 etype)
 }
 EXPORT_SYMBOL_IF_KUNIT(gss_krb5_lookup_enctype);
 
-static struct crypto_sync_skcipher *
-gss_krb5_alloc_cipher_v1(struct krb5_ctx *ctx, struct xdr_netobj *key)
-{
-	struct crypto_sync_skcipher *tfm;
-
-	tfm = crypto_alloc_sync_skcipher(ctx->gk5e->encrypt_name, 0, 0);
-	if (IS_ERR(tfm))
-		return NULL;
-	if (crypto_sync_skcipher_setkey(tfm, key->data, key->len)) {
-		crypto_free_sync_skcipher(tfm);
-		return NULL;
-	}
-	return tfm;
-}
-
-static inline const void *
-get_key(const void *p, const void *end,
-	struct krb5_ctx *ctx, struct crypto_sync_skcipher **res)
-{
-	struct crypto_sync_skcipher *tfm;
-	struct xdr_netobj	key;
-	int			alg;
-
-	p = simple_get_bytes(p, end, &alg, sizeof(alg));
-	if (IS_ERR(p))
-		goto out_err;
-	switch (alg) {
-	case ENCTYPE_DES_CBC_CRC:
-	case ENCTYPE_DES_CBC_MD4:
-	case ENCTYPE_DES_CBC_MD5:
-		/* Map all these key types to ENCTYPE_DES_CBC_RAW */
-		alg = ENCTYPE_DES_CBC_RAW;
-		break;
-	}
-	if (!gss_krb5_lookup_enctype(alg)) {
-		pr_warn("gss_krb5: unsupported enctype: %d\n", alg);
-		goto out_err_inval;
-	}
-
-	p = simple_get_netobj(p, end, &key);
-	if (IS_ERR(p))
-		goto out_err;
-	tfm = gss_krb5_alloc_cipher_v1(ctx, &key);
-	kfree(key.data);
-	if (!tfm) {
-		pr_warn("gss_krb5: failed to initialize cipher '%s'\n",
-			ctx->gk5e->encrypt_name);
-		goto out_err_inval;
-	}
-	*res = tfm;
-
-	return p;
-
-out_err_inval:
-	p = ERR_PTR(-EINVAL);
-out_err:
-	return p;
-}
-
-static int
-gss_import_v1_context(const void *p, const void *end, struct krb5_ctx *ctx)
-{
-	u32 seq_send;
-	int tmp;
-	u32 time32;
-
-	p = simple_get_bytes(p, end, &ctx->initiate, sizeof(ctx->initiate));
-	if (IS_ERR(p))
-		goto out_err;
-
-	/* Old format supports only DES!  Any other enctype uses new format */
-	ctx->enctype = ENCTYPE_DES_CBC_RAW;
-
-	ctx->gk5e = gss_krb5_lookup_enctype(ctx->enctype);
-	if (ctx->gk5e == NULL) {
-		p = ERR_PTR(-EINVAL);
-		goto out_err;
-	}
-
-	/* The downcall format was designed before we completely understood
-	 * the uses of the context fields; so it includes some stuff we
-	 * just give some minimal sanity-checking, and some we ignore
-	 * completely (like the next twenty bytes): */
-	if (unlikely(p + 20 > end || p + 20 < p)) {
-		p = ERR_PTR(-EFAULT);
-		goto out_err;
-	}
-	p += 20;
-	p = simple_get_bytes(p, end, &tmp, sizeof(tmp));
-	if (IS_ERR(p))
-		goto out_err;
-	if (tmp != SGN_ALG_DES_MAC_MD5) {
-		p = ERR_PTR(-ENOSYS);
-		goto out_err;
-	}
-	p = simple_get_bytes(p, end, &tmp, sizeof(tmp));
-	if (IS_ERR(p))
-		goto out_err;
-	if (tmp != SEAL_ALG_DES) {
-		p = ERR_PTR(-ENOSYS);
-		goto out_err;
-	}
-	p = simple_get_bytes(p, end, &time32, sizeof(time32));
-	if (IS_ERR(p))
-		goto out_err;
-	/* unsigned 32-bit time overflows in year 2106 */
-	ctx->endtime = (time64_t)time32;
-	p = simple_get_bytes(p, end, &seq_send, sizeof(seq_send));
-	if (IS_ERR(p))
-		goto out_err;
-	atomic_set(&ctx->seq_send, seq_send);
-	p = simple_get_netobj(p, end, &ctx->mech_used);
-	if (IS_ERR(p))
-		goto out_err;
-	p = get_key(p, end, ctx, &ctx->enc);
-	if (IS_ERR(p))
-		goto out_err_free_mech;
-	p = get_key(p, end, ctx, &ctx->seq);
-	if (IS_ERR(p))
-		goto out_err_free_key1;
-	if (p != end) {
-		p = ERR_PTR(-EFAULT);
-		goto out_err_free_key2;
-	}
-
-	return 0;
-
-out_err_free_key2:
-	crypto_free_sync_skcipher(ctx->seq);
-out_err_free_key1:
-	crypto_free_sync_skcipher(ctx->enc);
-out_err_free_mech:
-	kfree(ctx->mech_used.data);
-out_err:
-	return PTR_ERR(p);
-}
-
 #if defined(CONFIG_RPCSEC_GSS_KRB5_CRYPTOSYSTEM)
 
 static struct crypto_sync_skcipher *
@@ -622,10 +485,7 @@ gss_krb5_import_sec_context(const void *p, size_t len, struct gss_ctx *ctx_id,
 	if (ctx == NULL)
 		return -ENOMEM;
 
-	if (len == 85)
-		ret = gss_import_v1_context(p, end, ctx);
-	else
-		ret = gss_import_v2_context(p, end, ctx, gfp_mask);
+	ret = gss_import_v2_context(p, end, ctx, gfp_mask);
 	memzero_explicit(&ctx->Ksess, sizeof(ctx->Ksess));
 	if (ret) {
 		kfree(ctx);


