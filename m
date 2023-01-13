Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783E5669C15
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Jan 2023 16:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjAMP2g (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Jan 2023 10:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjAMP2R (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Jan 2023 10:28:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0168143D
        for <linux-nfs@vger.kernel.org>; Fri, 13 Jan 2023 07:21:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0ED7F620D6
        for <linux-nfs@vger.kernel.org>; Fri, 13 Jan 2023 15:21:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D767C433F0;
        Fri, 13 Jan 2023 15:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673623301;
        bh=QaJGYjsXTHDcxun8svP1bv6moYjQCPBWR2JSPH/tTRE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=lhV6+kpmJhBypQQ+bVTnauchTdTqV+5CTNiB4HMwLrmTSURBNhFCCvvG5vYWm3KrX
         reTrV8laAjQd/vqnUhOUQ8bASwvEe1CDwNHD4tI6YQiPoL0S4trM8vVGrPhHObdv+3
         sirLJZFE1N5whd0h6/pTz0qe3sWE3Z7ygbkEpFDIVnUdTqfeIC9rOnHP7uX1pJgK4S
         R0KL8eI269A45zMJArcYFs+6g+CpfyjcI4oeRCFdBtV/Jta/JN9RGN2+wvHJFrPXE5
         g3BMazwaWj59AJWgHh0x3l7BAtCivrPvpmpe1fWxf/9IVmB2N/dBhCh8bhnI3bIhUR
         cYtRXfSru9q6Q==
Subject: [PATCH v1 02/41] SUNRPC: Remove .blocksize field from struct
 gss_krb5_enctype
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     dhowells@redhat.com, simo@redhat.com
Date:   Fri, 13 Jan 2023 10:21:40 -0500
Message-ID: <167362330030.8960.6672671046687912325.stgit@bazille.1015granger.net>
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

It is not clear from documenting comments, specifications, or code
usage what value the gss_krb5_enctype.blocksize field is supposed
to store. The "encryption blocksize" depends only on the cipher
being used, so that value can be derived where it's needed instead
of stored as a constant.

RFC 3961 Section 5.2 says:

> cipher block size, c
>    This is the block size of the block cipher underlying the
>    encryption and decryption functions indicated above, used for key
>    derivation and for the size of the message confounder and initial
>    vector.  (If a block cipher is not in use, some comparable
>    parameter should be determined.)  It must be at least 5 octets.
>
>    This is not actually an independent parameter; rather, it is a
>    property of the functions E and D.  It is listed here to clarify
>    the distinction between it and the message block size, m.

In the Linux kernel's implemenation of the SunRPC RPCSEC GSS
Kerberos 5 mechanism, the cipher block size, which is dependent on
the encryption and decryption transforms, is used only in
krb5_derive_key(), so it is straightforward to replace it.

Tested-by: Scott Mayhew <smayhew@redhat.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/sunrpc/gss_krb5.h     |    1 -
 net/sunrpc/auth_gss/gss_krb5_keys.c |    4 +---
 net/sunrpc/auth_gss/gss_krb5_mech.c |    4 ----
 3 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/include/linux/sunrpc/gss_krb5.h b/include/linux/sunrpc/gss_krb5.h
index 0135139ddf20..9a833825b55b 100644
--- a/include/linux/sunrpc/gss_krb5.h
+++ b/include/linux/sunrpc/gss_krb5.h
@@ -64,7 +64,6 @@ struct gss_krb5_enctype {
 	const char		*cksum_name;	/* crypto checksum name */
 	const u16		signalg;	/* signing algorithm */
 	const u16		sealalg;	/* sealing algorithm */
-	const u32		blocksize;	/* encryption blocksize */
 	const u32		conflen;	/* confounder length
 						   (normally the same as
 						   the blocksize) */
diff --git a/net/sunrpc/auth_gss/gss_krb5_keys.c b/net/sunrpc/auth_gss/gss_krb5_keys.c
index 726c076950c0..554cfd23f288 100644
--- a/net/sunrpc/auth_gss/gss_krb5_keys.c
+++ b/net/sunrpc/auth_gss/gss_krb5_keys.c
@@ -150,7 +150,6 @@ u32 krb5_derive_key(const struct gss_krb5_enctype *gk5e,
 	struct crypto_sync_skcipher *cipher;
 	u32 ret = EINVAL;
 
-	blocksize = gk5e->blocksize;
 	keybytes = gk5e->keybytes;
 	keylength = gk5e->keylength;
 
@@ -160,11 +159,10 @@ u32 krb5_derive_key(const struct gss_krb5_enctype *gk5e,
 	cipher = crypto_alloc_sync_skcipher(gk5e->encrypt_name, 0, 0);
 	if (IS_ERR(cipher))
 		goto err_return;
+	blocksize = crypto_sync_skcipher_blocksize(cipher);
 	if (crypto_sync_skcipher_setkey(cipher, inkey->data, inkey->len))
 		goto err_return;
 
-	/* allocate and set up buffers */
-
 	ret = ENOMEM;
 	inblockdata = kmalloc(blocksize, gfp_mask);
 	if (inblockdata == NULL)
diff --git a/net/sunrpc/auth_gss/gss_krb5_mech.c b/net/sunrpc/auth_gss/gss_krb5_mech.c
index 1c092b05c2bb..dd85fc9ca80b 100644
--- a/net/sunrpc/auth_gss/gss_krb5_mech.c
+++ b/net/sunrpc/auth_gss/gss_krb5_mech.c
@@ -47,7 +47,6 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 	  .sealalg = SEAL_ALG_DES,
 	  .keybytes = 7,
 	  .keylength = 8,
-	  .blocksize = 8,
 	  .conflen = 8,
 	  .cksumlength = 8,
 	  .keyed_cksum = 0,
@@ -69,7 +68,6 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 	  .sealalg = SEAL_ALG_DES3KD,
 	  .keybytes = 21,
 	  .keylength = 24,
-	  .blocksize = 8,
 	  .conflen = 8,
 	  .cksumlength = 20,
 	  .keyed_cksum = 1,
@@ -92,7 +90,6 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 	  .sealalg = -1,
 	  .keybytes = 16,
 	  .keylength = 16,
-	  .blocksize = 16,
 	  .conflen = 16,
 	  .cksumlength = 12,
 	  .keyed_cksum = 1,
@@ -115,7 +112,6 @@ static const struct gss_krb5_enctype supported_gss_krb5_enctypes[] = {
 	  .sealalg = -1,
 	  .keybytes = 32,
 	  .keylength = 32,
-	  .blocksize = 16,
 	  .conflen = 16,
 	  .cksumlength = 12,
 	  .keyed_cksum = 1,


