Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EF39742B8F
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jun 2023 19:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbjF2RvS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Jun 2023 13:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjF2RvM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Jun 2023 13:51:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476CE1FC6
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 10:51:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD811615D1
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 17:51:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC9C4C433C0;
        Thu, 29 Jun 2023 17:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688061068;
        bh=XhQB/5G5eNzUYCygF5fsXBT1WAuQ7i0JEJGebgrW2JM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=BLsdTFfNGv1nE49pC+4nrb0IErWym6zhzkYbW+z3JiB8r8mkgtZ+kzfau7uUvu87G
         SKmem2GyFSVdpd5IfqSRz2uyQRvQq3hjvyPFESyU1UWBcWLr3xuNz/yoLAmKdVgzPA
         3fLC88pzny649yXTsPpKlDha0VERxa0O2nj1lCFTSDPuzTcscowF4s4HTo+uKzA8+Y
         GGxAE76snzrWYgCY6jGGiiCQnbeavMCOdeSFmDHPbYLjYacoejrx+jlxdvhZoHFasD
         5kXCSkI/+FDCNbEH8GbX/WAC9QOqdDDTo+4Ue4xeYRRdh5Bfn8ZFCoS27vBQ+0a/kk
         15IrJ7GpU/RPA==
Subject: [PATCH v1 5/9] SUNRPC: Remove krb5_derive_key_v1()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, dhowells@redhat.com,
        simo@redhat.com, smayhew@redhat.com
Date:   Thu, 29 Jun 2023 13:51:06 -0400
Message-ID: <168806106698.507650.13173270389268609415.stgit@morisot.1015granger.net>
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

This function is no longer used.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/gss_krb5_internal.h |    6 --
 net/sunrpc/auth_gss/gss_krb5_keys.c     |   84 -------------------------------
 2 files changed, 90 deletions(-)

diff --git a/net/sunrpc/auth_gss/gss_krb5_internal.h b/net/sunrpc/auth_gss/gss_krb5_internal.h
index 3471a574997a..c1aea062c01b 100644
--- a/net/sunrpc/auth_gss/gss_krb5_internal.h
+++ b/net/sunrpc/auth_gss/gss_krb5_internal.h
@@ -104,12 +104,6 @@ u32 gss_krb5_unwrap_v2(struct krb5_ctx *kctx, int offset, int len,
 
 /* Key Derivation Functions */
 
-int krb5_derive_key_v1(const struct gss_krb5_enctype *gk5e,
-		       const struct xdr_netobj *inkey,
-		       struct xdr_netobj *outkey,
-		       const struct xdr_netobj *label,
-		       gfp_t gfp_mask);
-
 int krb5_derive_key_v2(const struct gss_krb5_enctype *gk5e,
 		       const struct xdr_netobj *inkey,
 		       struct xdr_netobj *outkey,
diff --git a/net/sunrpc/auth_gss/gss_krb5_keys.c b/net/sunrpc/auth_gss/gss_krb5_keys.c
index 5347fe1cc93f..06d8ee0db000 100644
--- a/net/sunrpc/auth_gss/gss_krb5_keys.c
+++ b/net/sunrpc/auth_gss/gss_krb5_keys.c
@@ -222,90 +222,6 @@ static int krb5_DK(const struct gss_krb5_enctype *gk5e,
 	return ret;
 }
 
-#define smask(step) ((1<<step)-1)
-#define pstep(x, step) (((x)&smask(step))^(((x)>>step)&smask(step)))
-#define parity_char(x) pstep(pstep(pstep((x), 4), 2), 1)
-
-static void mit_des_fixup_key_parity(u8 key[8])
-{
-	int i;
-	for (i = 0; i < 8; i++) {
-		key[i] &= 0xfe;
-		key[i] |= 1^parity_char(key[i]);
-	}
-}
-
-static int krb5_random_to_key_v1(const struct gss_krb5_enctype *gk5e,
-				 struct xdr_netobj *randombits,
-				 struct xdr_netobj *key)
-{
-	int i, ret = -EINVAL;
-
-	if (key->len != 24) {
-		dprintk("%s: key->len is %d\n", __func__, key->len);
-		goto err_out;
-	}
-	if (randombits->len != 21) {
-		dprintk("%s: randombits->len is %d\n",
-			__func__, randombits->len);
-		goto err_out;
-	}
-
-	/* take the seven bytes, move them around into the top 7 bits of the
-	   8 key bytes, then compute the parity bits.  Do this three times. */
-
-	for (i = 0; i < 3; i++) {
-		memcpy(key->data + i*8, randombits->data + i*7, 7);
-		key->data[i*8+7] = (((key->data[i*8]&1)<<1) |
-				    ((key->data[i*8+1]&1)<<2) |
-				    ((key->data[i*8+2]&1)<<3) |
-				    ((key->data[i*8+3]&1)<<4) |
-				    ((key->data[i*8+4]&1)<<5) |
-				    ((key->data[i*8+5]&1)<<6) |
-				    ((key->data[i*8+6]&1)<<7));
-
-		mit_des_fixup_key_parity(key->data + i*8);
-	}
-	ret = 0;
-err_out:
-	return ret;
-}
-
-/**
- * krb5_derive_key_v1 - Derive a subkey for an RFC 3961 enctype
- * @gk5e: Kerberos 5 enctype profile
- * @inkey: base protocol key
- * @outkey: OUT: derived key
- * @label: subkey usage label
- * @gfp_mask: memory allocation control flags
- *
- * Caller sets @outkey->len to the desired length of the derived key.
- *
- * On success, returns 0 and fills in @outkey. A negative errno value
- * is returned on failure.
- */
-int krb5_derive_key_v1(const struct gss_krb5_enctype *gk5e,
-		       const struct xdr_netobj *inkey,
-		       struct xdr_netobj *outkey,
-		       const struct xdr_netobj *label,
-		       gfp_t gfp_mask)
-{
-	struct xdr_netobj inblock;
-	int ret;
-
-	inblock.len = gk5e->keybytes;
-	inblock.data = kmalloc(inblock.len, gfp_mask);
-	if (!inblock.data)
-		return -ENOMEM;
-
-	ret = krb5_DK(gk5e, inkey, inblock.data, label, gfp_mask);
-	if (!ret)
-		ret = krb5_random_to_key_v1(gk5e, &inblock, outkey);
-
-	kfree_sensitive(inblock.data);
-	return ret;
-}
-
 /*
  * This is the identity function, with some sanity checking.
  */


