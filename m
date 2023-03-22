Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6286C547C
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Mar 2023 20:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjCVTDN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Mar 2023 15:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjCVTC7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Mar 2023 15:02:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7870765B7
        for <linux-nfs@vger.kernel.org>; Wed, 22 Mar 2023 12:02:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46EFDB81DC7
        for <linux-nfs@vger.kernel.org>; Wed, 22 Mar 2023 19:01:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA402C433D2;
        Wed, 22 Mar 2023 19:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679511695;
        bh=fM2bGwK+qcMxO+b7L+OX8xFe2Zl3mhlhV8x1yRJ/5qc=;
        h=Subject:From:To:Cc:Date:From;
        b=tn/mQgyU0jvzNer76pU8WIihu+mkgwg2iaPaHFgLgjKJOhoSabSZyuxSgam65K94j
         FP+W0YQMa1Ea4DBLY5ehXVrm2CXU7OYkrjvCRGiqpe+PGtXxYSGGcqt7FrrJkJCMGb
         jNqvOOFM9A8TKKCPRPfzIaGbGp2qhomjb+2SwRcvN8yPS2VUqcH2lB2h8uNETasQsi
         I9cm2yYJaZePfn/XkIArsPT6DeL6SNlyZaM4KueIpcNkSzwCg7YXnmF/p+qKTMjOy2
         W9S0Xqh2O1vcRxE84QS2LmHk+zOmzP9CjUQWgDn26VnnkrBLFHw99AqSxydys50E2K
         Da1hWa6SwcmsQ==
Subject: [PATCH v1] SUNRPC: Fix a crash in gss_krb5_checksum()
From:   Chuck Lever <cel@kernel.org>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Date:   Wed, 22 Mar 2023 15:01:34 -0400
Message-ID: <167951169462.22263.13708891630674211649.stgit@morisot.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Anna says:
> KASAN reports [...] a slab-out-of-bounds in gss_krb5_checksum(),
> and it can cause my client to panic when running cthon basic
> tests with krb5p.

> Running faddr2line gives me:
>
> gss_krb5_checksum+0x4b6/0x630:
> ahash_request_free at
> /home/anna/Programs/linux-nfs.git/./include/crypto/hash.h:619
> (inlined by) gss_krb5_checksum at
> /home/anna/Programs/linux-nfs.git/net/sunrpc/auth_gss/gss_krb5_crypto.c:358

My diagnosis is that the memcpy() at the end of gss_krb5_checksum()
reads past the end of the buffer containing the checksum data
because the callers have ignored gss_krb5_checksum()'s API contract:

 * Caller provides the truncation length of the output token (h) in
 * cksumout.len.

Instead they provide the fixed length of the hmac buffer. This
length happens to be larger than the value returned by
crypto_ahash_digestsize().

Change these errant callers to work like krb5_etm_{en,de}crypt().
As a defensive measure, bound the length of the byte copy at the
end of gss_krb5_checksum().

Kunit sez:
Testing complete. Ran 68 tests: passed: 68
Elapsed time: 81.680s total, 5.875s configuring, 75.610s building, 0.103s running

Reported-by: Anna Schumaker <schumaker.anna@gmail.com>
Fixes: 8270dbfcebea ("SUNRPC: Obscure Kerberos integrity keys")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_krb5_crypto.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/sunrpc/auth_gss/gss_krb5_crypto.c b/net/sunrpc/auth_gss/gss_krb5_crypto.c
index 6c7c52eeed4f..212c5d57465a 100644
--- a/net/sunrpc/auth_gss/gss_krb5_crypto.c
+++ b/net/sunrpc/auth_gss/gss_krb5_crypto.c
@@ -353,7 +353,9 @@ gss_krb5_checksum(struct crypto_ahash *tfm, char *header, int hdrlen,
 	err = crypto_ahash_final(req);
 	if (err)
 		goto out_free_ahash;
-	memcpy(cksumout->data, checksumdata, cksumout->len);
+
+	memcpy(cksumout->data, checksumdata,
+	       min_t(int, cksumout->len, crypto_ahash_digestsize(tfm)));
 
 out_free_ahash:
 	ahash_request_free(req);
@@ -809,8 +811,7 @@ gss_krb5_aes_encrypt(struct krb5_ctx *kctx, u32 offset,
 	buf->tail[0].iov_len += GSS_KRB5_TOK_HDR_LEN;
 	buf->len += GSS_KRB5_TOK_HDR_LEN;
 
-	/* Do the HMAC */
-	hmac.len = GSS_KRB5_MAX_CKSUM_LEN;
+	hmac.len = kctx->gk5e->cksumlength;
 	hmac.data = buf->tail[0].iov_base + buf->tail[0].iov_len;
 
 	/*
@@ -873,8 +874,7 @@ gss_krb5_aes_decrypt(struct krb5_ctx *kctx, u32 offset, u32 len,
 	if (ret)
 		goto out_err;
 
-	/* Calculate our hmac over the plaintext data */
-	our_hmac_obj.len = sizeof(our_hmac);
+	our_hmac_obj.len = kctx->gk5e->cksumlength;
 	our_hmac_obj.data = our_hmac;
 	ret = gss_krb5_checksum(ahash, NULL, 0, &subbuf, 0, &our_hmac_obj);
 	if (ret)


