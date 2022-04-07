Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED304F876C
	for <lists+linux-nfs@lfdr.de>; Thu,  7 Apr 2022 20:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347014AbiDGSya (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 7 Apr 2022 14:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347008AbiDGSy3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 7 Apr 2022 14:54:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CF2195338
        for <linux-nfs@vger.kernel.org>; Thu,  7 Apr 2022 11:52:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F0BC661DA5
        for <linux-nfs@vger.kernel.org>; Thu,  7 Apr 2022 18:52:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4280C385A4
        for <linux-nfs@vger.kernel.org>; Thu,  7 Apr 2022 18:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649357547;
        bh=GaFjUOZTSMhrtwTWxNX8cUUnv05zT8jAdmJkkZCIX7o=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=gDj5D4ciUGGhsspMMBkszbDw54keCWacuY0m4bDwkDyUHwWIMxJfGpR2DF2DTps/F
         zbWhaErPlxMeeIQS2kOpiTeQGCnhLNmv1eaGYlFQnLgDgNA07ILMOjnK8erHjOYJYE
         PVXjXcfb7QO2Dg4jVx6j7iGALdD//nkNWxRDo5zY2KPUl5UT51AxyATDGvL70JOKEZ
         +Hy41DO1SZthS09g2bVsSbi4YHMtRfXuDTcIDVYvaagrrtlIKyaecPxW0gOrOWgd+C
         PURGfqSuSARcZu7SQOIsTRA8EzlaTTo8iLZf5zCiJyQ4T+LvaoFtdB1K9uf2BKN8eO
         p5hQ/Ism70LTQ==
From:   trondmy@kernel.org
To:     linux-nfs@vger.kernel.org
Subject: [PATCH v2 7/8] SUNRPC: svc_tcp_sendmsg() should handle errors from xdr_alloc_bvec()
Date:   Thu,  7 Apr 2022 14:46:00 -0400
Message-Id: <20220407184601.1064640-7-trondmy@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220407184601.1064640-6-trondmy@kernel.org>
References: <20220407184601.1064640-1-trondmy@kernel.org>
 <20220407184601.1064640-2-trondmy@kernel.org>
 <20220407184601.1064640-3-trondmy@kernel.org>
 <20220407184601.1064640-4-trondmy@kernel.org>
 <20220407184601.1064640-5-trondmy@kernel.org>
 <20220407184601.1064640-6-trondmy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@hammerspace.com>

The allocation is done with GFP_KERNEL, but it could still fail in a low
memory situation.

Fixes: 4a85a6a3320b ("SUNRPC: Handle TCP socket sends with kernel_sendpage() again")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/svcsock.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/svcsock.c b/net/sunrpc/svcsock.c
index 478f857cdaed..6ea3d87e1147 100644
--- a/net/sunrpc/svcsock.c
+++ b/net/sunrpc/svcsock.c
@@ -1096,7 +1096,9 @@ static int svc_tcp_sendmsg(struct socket *sock, struct xdr_buf *xdr,
 	int ret;
 
 	*sentp = 0;
-	xdr_alloc_bvec(xdr, GFP_KERNEL);
+	ret = xdr_alloc_bvec(xdr, GFP_KERNEL);
+	if (ret < 0)
+		return ret;
 
 	ret = kernel_sendmsg(sock, &msg, &rm, 1, rm.iov_len);
 	if (ret < 0)
-- 
2.35.1

