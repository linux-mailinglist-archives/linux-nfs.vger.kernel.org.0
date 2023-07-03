Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDAF745B47
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jul 2023 13:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbjGCLiF (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Jul 2023 07:38:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbjGCLhy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 3 Jul 2023 07:37:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67140198;
        Mon,  3 Jul 2023 04:37:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EE59760F00;
        Mon,  3 Jul 2023 11:37:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00269C433C9;
        Mon,  3 Jul 2023 11:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688384264;
        bh=NWdm4COWp2k09VYLKv3/EMMJkaiYec6oWrtpHhnAdio=;
        h=From:To:Cc:Subject:Date:From;
        b=BUJp2I4tfvNJnQyBQ7mRS4r9bhjY6iDaZatDtPvGUGRSMTW+yTIuvFgIodu6nfukJ
         Ir3sfcG1YlLLR9YZXB6YIKumcnsyEd1orp1XlNfFS9pcIYFUF7hYuu/PLv1gquQ+MX
         eUbjrWhcdg89M2+/8hr9u8aM5D7jmRhg49yjetMcM2Yp8lbDHDfIxnBf8Xxqiul2LG
         IQeQdjKFGFzUHJTaDSlprBM7iQ2e3D5C84bDauoUdzk5V7ZQxGBB9sGJMT7vjXYjv7
         rLfln/mxaLdx0zGVrdVVW4hfbm7SV9AgnrElV5CGJ266xfcDdY/+71CCzEb+AUQUCR
         G3sPgBRvhHiig==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Neil Brown <neilb@suse.de>,
        Olga Kornievskaia <kolga@netapp.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Dan Carpenter <error27@gmail.com>,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] sunrpc: avoid constant-out-of-range warning with clang
Date:   Mon,  3 Jul 2023 13:37:22 +0200
Message-Id: <20230703113737.694995-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The overflow check in xdr_stream_decode_uint32_array() was added for
32-bit systems, but on 64-bit builds it causes a build warning when
building with clang and W=1:

In file included from init/do_mounts.c:22:
include/linux/sunrpc/xdr.h:778:10: error: result of comparison of constant 4611686018427387903 with expression of type '__u32' (aka 'unsigned int') is always false [-Werror,-Wtautological-constant-out-of-range-compare]
  778 |         if (len > SIZE_MAX / sizeof(*p))

Shut up the warning with a type cast.

Fixes: 23a9dbbe0faf1 ("NFSD: prevent integer overflow on 32 bit systems")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/linux/sunrpc/xdr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index f89ec4b5ea169..6736121ee6a03 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -775,7 +775,7 @@ xdr_stream_decode_uint32_array(struct xdr_stream *xdr,
 
 	if (unlikely(xdr_stream_decode_u32(xdr, &len) < 0))
 		return -EBADMSG;
-	if (len > SIZE_MAX / sizeof(*p))
+	if ((size_t)len > SIZE_MAX / sizeof(*p))
 		return -EBADMSG;
 	p = xdr_inline_decode(xdr, len * sizeof(*p));
 	if (unlikely(!p))
-- 
2.39.2

