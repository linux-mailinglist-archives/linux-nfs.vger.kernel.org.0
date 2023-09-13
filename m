Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6AD79F2C1
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Sep 2023 22:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjIMUTD (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Sep 2023 16:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjIMUTD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 13 Sep 2023 16:19:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B611BC6
        for <linux-nfs@vger.kernel.org>; Wed, 13 Sep 2023 13:18:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4AACC433C8;
        Wed, 13 Sep 2023 20:18:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694636339;
        bh=Fpw4durKzpRQRcn5x6pizxF+i5KLCs8hLKzh1VAbV1Q=;
        h=From:To:Cc:Subject:Date:From;
        b=cG5JyOwxVH2HeNK0PTZoziP6qqFbY2rh2xN3F63LvzCYRBKW0C4JhxzUFCImQuRX2
         Kkg0qfP6goF6PozAq9uz/Vbm5F+/1GANpnJWLEwGP3Wdk2Ys71no2MvSQ3zEPWKDWY
         H/dAnLB/FByclfF2OCkj0FMnMar48gYCL8cPyrpbSVKkNdv3P6K8U6fO4PXptCPi58
         sJ7cp+uLlWyZZANyKuvfHOPML9CX3tEo0COBxVdcSd7AkEShFPEMPF5xP4DUeHZTaV
         tOGOajpOvOCc33Dw3EABgTtM3JjASiBy2GpR88XrZk5/NOr0i9MDPO+jnUij/CBMWJ
         Yd63OKkaezcUw==
From:   trondmy@kernel.org
To:     Anna Schumaker <anna.schumaker@netapp.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] SUNRPC: Silence compiler complaints about tautological comparisons
Date:   Wed, 13 Sep 2023 16:12:33 -0400
Message-ID: <20230913201233.126405-1-trondmy@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

On 64-bit systems, the compiler will complain that the comparison
between SIZE_MAX and the 32-bit unsigned int 'len' is unnecessary.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 This still checks for whether or not there is an overflow, and
 returns an error message if that is the case.

 include/linux/sunrpc/xdr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sunrpc/xdr.h b/include/linux/sunrpc/xdr.h
index f89ec4b5ea16..915b2e7fa38d 100644
--- a/include/linux/sunrpc/xdr.h
+++ b/include/linux/sunrpc/xdr.h
@@ -775,7 +775,7 @@ xdr_stream_decode_uint32_array(struct xdr_stream *xdr,
 
 	if (unlikely(xdr_stream_decode_u32(xdr, &len) < 0))
 		return -EBADMSG;
-	if (len > SIZE_MAX / sizeof(*p))
+	if (U32_MAX >= SIZE_MAX / sizeof(*p) && len > SIZE_MAX / sizeof(*p))
 		return -EBADMSG;
 	p = xdr_inline_decode(xdr, len * sizeof(*p));
 	if (unlikely(!p))
-- 
2.41.0

