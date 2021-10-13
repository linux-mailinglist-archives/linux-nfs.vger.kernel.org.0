Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3D5C42C3DC
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Oct 2021 16:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237060AbhJMOtQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Oct 2021 10:49:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:53096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237207AbhJMOtN (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 13 Oct 2021 10:49:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 69E2D60E09;
        Wed, 13 Oct 2021 14:47:10 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH v1 3/6] svcrdma: Remove dprintk call site in svc_rdma_parse_connect_private()
Date:   Wed, 13 Oct 2021 10:47:09 -0400
Message-Id:  <163413642926.6408.7192303522581995956.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.33.0.113.g6c40894d24
In-Reply-To:  <163413628188.6408.17033105928649076434.stgit@bazille.1015granger.net>
References:  <163413628188.6408.17033105928649076434.stgit@bazille.1015granger.net>
User-Agent: StGit/1.1+62.ged16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1101; h=from:subject:message-id; bh=XgzUEXukK7N05z1x+gmSa1b0g5Fm+Il9JOCAcTMKrlo=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBhZvFtTrLFswUBkMgn76fs9muBCG81tPBTD3A9/GRY MN9zsG+JAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYWbxbQAKCRAzarMzb2Z/l4AEEA CacOtonyz77k68sXOQBm9zDc131QIkokrdD5kS0lVM9VVSET9cYaqrwrkmHBDN04AAmNIOTMd78/yt KkOeMOTu4a9m2A8jEVhOwNEe2fBLBHueCJe4V+e/kKFmg+hA3wtd9mB8D6fKqvHqQjaG1rVXHZSjOH AWH12O+9SffJ6p7fdla3M5GLboO3nEcoS/OZuCGsqnYXwgLRR2fDg7JuxbRyi4D0dRFktkKjKAgsg5 jPWUPULy6r2AfPEvesKaVmaBkCzzT4UuLTUDHnCwuPbcuj4Ha4Z8GqTn8rYUse7YpViHyV2aHPIDQM w8UK65/LQyjMFUCDlcuwa2WbpXMJSdqJlS5MZ/wEbkXyJwXBuy/aK0IKbFTUBGHkQTQYfznVqWFt81 ctGqdEcXlgB1AFC+aPkD4Wu/8MbHVT36GsLuNdRngMgL6cQ60HEFQ/jgSsGW1xYqu93PLvVqOu90r7 pLbDs+ghLO/D0gzvpoT6CjV/JN5KS66WGYnPwTeD+U6BPt4rE/6a6jEdXAYKeHItR3zbzdZO47qqcU b9gIHbP9UsK/7+H+p1lMl6oytVVI0eGI4b4X1W53PIN0IBlOU/vuSbtvxAZKNRJaEFgZMmPnElGifZ a9/5WVhQNDkiJAet9ZpS1gyCdA4PniwbZo68p+mrKZYJF3+MZOUWlZgjswww==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Deprecation. The effect of the RPCRDMA_CMP_F_SND_W_INV_OK setting is
obvious from subsequent server activity.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_transport.c |    9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 9aea253af2da..11cecfb7761a 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -164,16 +164,9 @@ svc_rdma_parse_connect_private(struct svcxprt_rdma *newxprt,
 
 	if (pmsg &&
 	    pmsg->cp_magic == rpcrdma_cmp_magic &&
-	    pmsg->cp_version == RPCRDMA_CMP_VERSION) {
+	    pmsg->cp_version == RPCRDMA_CMP_VERSION)
 		newxprt->sc_snd_w_inv = pmsg->cp_flags &
 					RPCRDMA_CMP_F_SND_W_INV_OK;
-
-		dprintk("svcrdma: client send_size %u, recv_size %u "
-			"remote inv %ssupported\n",
-			rpcrdma_decode_buffer_size(pmsg->cp_send_size),
-			rpcrdma_decode_buffer_size(pmsg->cp_recv_size),
-			newxprt->sc_snd_w_inv ? "" : "un");
-	}
 }
 
 /*

