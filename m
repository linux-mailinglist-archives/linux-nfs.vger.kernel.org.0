Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1B2742B93
	for <lists+linux-nfs@lfdr.de>; Thu, 29 Jun 2023 19:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjF2Rvh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 29 Jun 2023 13:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjF2Rvg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 29 Jun 2023 13:51:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1481FC3
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 10:51:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B91A3615D2
        for <linux-nfs@vger.kernel.org>; Thu, 29 Jun 2023 17:51:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE66C433C0;
        Thu, 29 Jun 2023 17:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688061094;
        bh=P86FmnaNy5/b7LaxfMmIjk7lU/DwK1JIwLghRVD2pmI=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=b41kCpzcV8SQ5EHgKWAMyFOjwxiZ4mTEajgxI61Z0/euwTPIOfDyBl8nG51i1fQ4D
         3gZFWRJgUvEQ6ENm0g5i6PUqF7Vu4ZwV/07HdmgfWY8UFqn5AgCx3IvcMUj4ul3XQe
         j6hzp+ezX95OySpikdqfVVpUBLf7dr/ry2tX8/2f1i2bmisGH7r3ixRgJn9ebRJqU/
         XctNtmORnJ78Vbgri7r4fsiohR23imU3DnDj4lcSEpzIJ8g6MUtr94BULOKMATHd3H
         XvM+CgT/Nca3UyE3gYl610cvtq1F8SFHmtGRmUJ70wCJtbNZXPC9mer8UTdw14WqJR
         Ros+EXkTcm3jA==
Subject: [PATCH v1 9/9] SUNRPC: Remove net/sunrpc/auth_gss/gss_krb5_seqnum.c
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     Chuck Lever <chuck.lever@oracle.com>, dhowells@redhat.com,
        simo@redhat.com, smayhew@redhat.com
Date:   Thu, 29 Jun 2023 13:51:32 -0400
Message-ID: <168806109289.507650.12755867542546375512.stgit@morisot.1015granger.net>
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

These functions are no longer used.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/auth_gss/Makefile            |    2 -
 net/sunrpc/auth_gss/gss_krb5_internal.h |    7 --
 net/sunrpc/auth_gss/gss_krb5_seqnum.c   |  106 -------------------------------
 3 files changed, 1 insertion(+), 114 deletions(-)
 delete mode 100644 net/sunrpc/auth_gss/gss_krb5_seqnum.c

diff --git a/net/sunrpc/auth_gss/Makefile b/net/sunrpc/auth_gss/Makefile
index 012ae1720689..ad1736d93b76 100644
--- a/net/sunrpc/auth_gss/Makefile
+++ b/net/sunrpc/auth_gss/Makefile
@@ -12,6 +12,6 @@ auth_rpcgss-y := auth_gss.o gss_generic_token.o \
 obj-$(CONFIG_RPCSEC_GSS_KRB5) += rpcsec_gss_krb5.o
 
 rpcsec_gss_krb5-y := gss_krb5_mech.o gss_krb5_seal.o gss_krb5_unseal.o \
-	gss_krb5_seqnum.o gss_krb5_wrap.o gss_krb5_crypto.o gss_krb5_keys.o
+	gss_krb5_wrap.o gss_krb5_crypto.o gss_krb5_keys.o
 
 obj-$(CONFIG_RPCSEC_GSS_KRB5_KUNIT_TEST) += gss_krb5_test.o
diff --git a/net/sunrpc/auth_gss/gss_krb5_internal.h b/net/sunrpc/auth_gss/gss_krb5_internal.h
index 9a4b110a6154..3afd4065bf3d 100644
--- a/net/sunrpc/auth_gss/gss_krb5_internal.h
+++ b/net/sunrpc/auth_gss/gss_krb5_internal.h
@@ -153,13 +153,6 @@ static inline int krb5_derive_key(struct krb5_ctx *kctx,
 	return gk5e->derive_key(gk5e, inkey, outkey, &label, gfp_mask);
 }
 
-s32 krb5_make_seq_num(struct krb5_ctx *kctx, struct crypto_sync_skcipher *key,
-		      int direction, u32 seqnum, unsigned char *cksum,
-		      unsigned char *buf);
-
-s32 krb5_get_seq_num(struct krb5_ctx *kctx, unsigned char *cksum,
-		     unsigned char *buf, int *direction, u32 *seqnum);
-
 void krb5_make_confounder(u8 *p, int conflen);
 
 u32 make_checksum(struct krb5_ctx *kctx, char *header, int hdrlen,
diff --git a/net/sunrpc/auth_gss/gss_krb5_seqnum.c b/net/sunrpc/auth_gss/gss_krb5_seqnum.c
deleted file mode 100644
index 1babc3474e10..000000000000
--- a/net/sunrpc/auth_gss/gss_krb5_seqnum.c
+++ /dev/null
@@ -1,106 +0,0 @@
-/*
- *  linux/net/sunrpc/gss_krb5_seqnum.c
- *
- *  Adapted from MIT Kerberos 5-1.2.1 lib/gssapi/krb5/util_seqnum.c
- *
- *  Copyright (c) 2000 The Regents of the University of Michigan.
- *  All rights reserved.
- *
- *  Andy Adamson   <andros@umich.edu>
- */
-
-/*
- * Copyright 1993 by OpenVision Technologies, Inc.
- *
- * Permission to use, copy, modify, distribute, and sell this software
- * and its documentation for any purpose is hereby granted without fee,
- * provided that the above copyright notice appears in all copies and
- * that both that copyright notice and this permission notice appear in
- * supporting documentation, and that the name of OpenVision not be used
- * in advertising or publicity pertaining to distribution of the software
- * without specific, written prior permission. OpenVision makes no
- * representations about the suitability of this software for any
- * purpose.  It is provided "as is" without express or implied warranty.
- *
- * OPENVISION DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE,
- * INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO
- * EVENT SHALL OPENVISION BE LIABLE FOR ANY SPECIAL, INDIRECT OR
- * CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF
- * USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
- * OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
- * PERFORMANCE OF THIS SOFTWARE.
- */
-
-#include <crypto/skcipher.h>
-#include <linux/types.h>
-#include <linux/sunrpc/gss_krb5.h>
-
-#include "gss_krb5_internal.h"
-
-#if IS_ENABLED(CONFIG_SUNRPC_DEBUG)
-# define RPCDBG_FACILITY        RPCDBG_AUTH
-#endif
-
-s32
-krb5_make_seq_num(struct krb5_ctx *kctx,
-		struct crypto_sync_skcipher *key,
-		int direction,
-		u32 seqnum,
-		unsigned char *cksum, unsigned char *buf)
-{
-	unsigned char *plain;
-	s32 code;
-
-	plain = kmalloc(8, GFP_KERNEL);
-	if (!plain)
-		return -ENOMEM;
-
-	plain[0] = (unsigned char) (seqnum & 0xff);
-	plain[1] = (unsigned char) ((seqnum >> 8) & 0xff);
-	plain[2] = (unsigned char) ((seqnum >> 16) & 0xff);
-	plain[3] = (unsigned char) ((seqnum >> 24) & 0xff);
-
-	plain[4] = direction;
-	plain[5] = direction;
-	plain[6] = direction;
-	plain[7] = direction;
-
-	code = krb5_encrypt(key, cksum, plain, buf, 8);
-	kfree(plain);
-	return code;
-}
-
-s32
-krb5_get_seq_num(struct krb5_ctx *kctx,
-	       unsigned char *cksum,
-	       unsigned char *buf,
-	       int *direction, u32 *seqnum)
-{
-	s32 code;
-	unsigned char *plain;
-	struct crypto_sync_skcipher *key = kctx->seq;
-
-	dprintk("RPC:       krb5_get_seq_num:\n");
-
-	plain = kmalloc(8, GFP_KERNEL);
-	if (!plain)
-		return -ENOMEM;
-
-	if ((code = krb5_decrypt(key, cksum, buf, plain, 8)))
-		goto out;
-
-	if ((plain[4] != plain[5]) || (plain[4] != plain[6]) ||
-	    (plain[4] != plain[7])) {
-		code = (s32)KG_BAD_SEQ;
-		goto out;
-	}
-
-	*direction = plain[4];
-
-	*seqnum = ((plain[0]) |
-		   (plain[1] << 8) | (plain[2] << 16) | (plain[3] << 24));
-
-out:
-	kfree(plain);
-	return code;
-}


