Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A97EB618DB5
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Nov 2022 02:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbiKDBnL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Nov 2022 21:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiKDBnJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Nov 2022 21:43:09 -0400
Received: from mail.nfschina.com (mail.nfschina.com [124.16.136.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 061EC2229C;
        Thu,  3 Nov 2022 18:43:09 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 490CB1E80D9D;
        Fri,  4 Nov 2022 09:41:02 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 32uXRg-KJKvS; Fri,  4 Nov 2022 09:40:59 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 2DD4B1E80D9C;
        Fri,  4 Nov 2022 09:40:59 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     trond.myklebust@hammerspace.com, anna@kernel.org,
        chuck.lever@oracle.com, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li zeming <zeming@nfschina.com>
Subject: [PATCH] sunrpc: svc: Remove an unused static function svc_ungetu32()
Date:   Fri,  4 Nov 2022 09:43:03 +0800
Message-Id: <20221104014303.3146-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The svc_ungetu32 function is not used, you could remove it.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 include/linux/sunrpc/svc.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index daecb009c05b..6990867470ca 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -220,13 +220,6 @@ static inline __be32 svc_getu32(struct kvec *iov)
 	return val;
 }
 
-static inline void svc_ungetu32(struct kvec *iov)
-{
-	__be32 *vp = (__be32 *)iov->iov_base;
-	iov->iov_base = (void *)(vp - 1);
-	iov->iov_len += sizeof(*vp);
-}
-
 static inline void svc_putu32(struct kvec *iov, __be32 val)
 {
 	__be32 *vp = iov->iov_base + iov->iov_len;
-- 
2.18.2

