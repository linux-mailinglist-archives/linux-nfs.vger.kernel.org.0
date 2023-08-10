Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E7D77731E
	for <lists+linux-nfs@lfdr.de>; Thu, 10 Aug 2023 10:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233698AbjHJIjy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 10 Aug 2023 04:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232080AbjHJIjx (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 10 Aug 2023 04:39:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9FADC
        for <linux-nfs@vger.kernel.org>; Thu, 10 Aug 2023 01:39:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 038AC6539E
        for <linux-nfs@vger.kernel.org>; Thu, 10 Aug 2023 08:39:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED789C433C7;
        Thu, 10 Aug 2023 08:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691656792;
        bh=PXPoMFrsgAFHqr/4bBZEHHWbQsM7B4gZYjh1x02b02s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F7VOk1uUKx7+Rp0Y0e8XmFaLr70dY7eOeFytnzUXwn97eEixhdLtnXZmIDwDNN5sS
         Wxg+6AMz9QJKJ4z2ZuQ1stdnWGnH2pLpEn7YTZhpr+2mjXSB0bYRWVrPTCTSiAmKQM
         p0lCtTxJgwqSDu8qg33byifae/5Wvn4qybNNgcrYRr9F6sDHctmPYMWRHxcHhIisiz
         +GcQ+LcsyJiEBqdsKtQsSAxS8KPgGXCWoE5Jxm4rRDs8SY/dc3pBdpXKa57YRy6aES
         HHDzvkA3ElmWGrV2SEDgFGjDNaJFXykKO9+WIcCSNwAiJS7EYntiM+/Jk8L8kHYBOx
         jdLS80TsWnjTQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, chuck.lever@oracle.com,
        jlayton@kernel.org, neilb@suse.de
Subject: [PATCH v6 1/3] SUNRPC: add verbose parameter to __svc_print_addr()
Date:   Thu, 10 Aug 2023 10:39:19 +0200
Message-ID: <fa58a3979f1d1d129337fd73f2fde3b19a40970a.1691656474.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1691656474.git.lorenzo@kernel.org>
References: <cover.1691656474.git.lorenzo@kernel.org>
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

Reviewed-by: NeilBrown <neilb@suse.de>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 include/linux/sunrpc/svc_xprt.h | 12 ++++++------
 net/sunrpc/svc_xprt.c           |  2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/sunrpc/svc_xprt.h b/include/linux/sunrpc/svc_xprt.h
index fa55d12dc765..2615cc535199 100644
--- a/include/linux/sunrpc/svc_xprt.h
+++ b/include/linux/sunrpc/svc_xprt.h
@@ -213,21 +213,21 @@ static inline unsigned short svc_xprt_remote_port(const struct svc_xprt *xprt)
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
index d3280ae70e36..940be13d02b0 100644
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

