Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81C0C7706F0
	for <lists+linux-nfs@lfdr.de>; Fri,  4 Aug 2023 19:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbjHDRTi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 4 Aug 2023 13:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjHDRTh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 4 Aug 2023 13:19:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81DC198B
        for <linux-nfs@vger.kernel.org>; Fri,  4 Aug 2023 10:19:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37F8E620BB
        for <linux-nfs@vger.kernel.org>; Fri,  4 Aug 2023 17:19:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23FA1C433C7;
        Fri,  4 Aug 2023 17:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691169575;
        bh=/nwWr/nkThbjozqWCukHopWKFADZofLEei2D5AV6DI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D31X3fr2mtaV79JmgpE9UVcI5dGsNx/Lfe8q8wSfeKA+25B9+nPYAgAWUZelac6qb
         WdQ+EuYWodf3R/ZqzzFly245x73sPfObkdMT6K+AqKze2527T1TQjCWsAEwQOXL41R
         2Zzc3HFE4kT/078fmYqIOWVPUjWy01LKDhzRsQDuJUDiCQ6+c+79GdU75iNpo5/ImG
         yBIKMfzaYskEkQ7AZe+4cWf960GEAq/hu0bTOthBDPx8UTcFUsTxd0zW95ej+E2YFr
         KaqyI8a1IkfCilYzXO+b9vEF5RE2AKe1iO5tRfbZ+AnJ6HaMvWZBpz2g5U0+LbbRkY
         CBiCPKhksg1LA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, chuck.lever@oracle.com,
        jlayton@kernel.org, neilb@suse.de
Subject: [PATCH v5 1/2] SUNRPC: add verbose parameter to __svc_print_addr()
Date:   Fri,  4 Aug 2023 19:16:07 +0200
Message-ID: <d0e0e9cacaf90940417c6cf2fb0baff817386643.1691169103.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691169103.git.lorenzo@kernel.org>
References: <cover.1691169103.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Introduce verbose parameter to utility routine in order to reduce output
verbosity. This is a preliminary patch to add rpc_status entry in nfsd
debug filesystem in order to dump pending RPC requests debugging
information.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/linux/sunrpc/svc_xprt.h | 12 ++++++------
 net/sunrpc/svc_xprt.c           |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_xprt.h
index a6b12631db21..285bb25798c6 100644
--- a/include/linux/sunrpc/svc_xprt.h
+++ b/include/linux/sunrpc/svc_xprt.h
@@ -209,21 +209,21 @@ static inline unsigned short svc_xprt_remote_port(const struct svc_xprt *xprt)
 }
 
 static inline char *__svc_print_addr(const struct sockaddr *addr,
-				     char *buf, const size_t len)
+				     char *buf, const size_t len,
+				     bool verbose)
 {
 	const struct sockaddr_in *sin = (const struct sockaddr_in *)addr;
 	const struct sockaddr_in6 *sin6 = (const struct sockaddr_in6 *)addr;
 
 	switch (addr->sa_family) {
 	case AF_INET:
-		snprintf(buf, len, "%pI4, port=%u", &sin->sin_addr,
-			ntohs(sin->sin_port));
+		snprintf(buf, len, "%pI4%s%hu", &sin->sin_addr,
+			 verbose ? ", port=" : " ", ntohs(sin->sin_port));
 		break;
 
 	case AF_INET6:
-		snprintf(buf, len, "%pI6, port=%u",
-			 &sin6->sin6_addr,
-			ntohs(sin6->sin6_port));
+		snprintf(buf, len, "%pI6%s%hu", &sin6->sin6_addr,
+			 verbose ? ", port=" : " ", ntohs(sin6->sin6_port));
 		break;
 
 	default:
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 62c7919ea610..16b794d291a4 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -386,7 +386,7 @@ EXPORT_SYMBOL_GPL(svc_xprt_copy_addrs);
  */
 char *svc_print_addr(struct svc_rqst *rqstp, char *buf, size_t len)
 {
-	return __svc_print_addr(svc_addr(rqstp), buf, len);
+	return __svc_print_addr(svc_addr(rqstp), buf, len, true);
 }
 EXPORT_SYMBOL_GPL(svc_print_addr);
 
-- 
2.41.0

