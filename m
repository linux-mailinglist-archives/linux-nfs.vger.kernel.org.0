Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91F3642C3D8
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Oct 2021 16:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233590AbhJMOtH (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Oct 2021 10:49:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:52980 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230385AbhJMOtH (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 13 Oct 2021 10:49:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D279E61130;
        Wed, 13 Oct 2021 14:47:03 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH v1 2/6] svcrdma: Remove dprintk call site in svc_rdma_create_xprt()
Date:   Wed, 13 Oct 2021 10:47:02 -0400
Message-Id:  <163413642271.6408.118012829392169503.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.33.0.113.g6c40894d24
In-Reply-To:  <163413628188.6408.17033105928649076434.stgit@bazille.1015granger.net>
References:  <163413628188.6408.17033105928649076434.stgit@bazille.1015granger.net>
User-Agent: StGit/1.1+62.ged16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=988; h=from:subject:message-id; bh=ik04DHwnDbOcw4LYRYI9K7hscvAobiJpvns68OLdLpA=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBhZvFmrgaF0T/hlLGUTHNShlrKh9ixl9rzzWgdH6kd ZfZm50KJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYWbxZgAKCRAzarMzb2Z/lz5cEA C/WB+Ab87k6v4ozLInhfCkb33D2oNY5CQdiBMDInhIKyXZmtCb8kpFEGpVQ7RSa5DNrKwn12wwphn3 DzaIC9ytUIoWrwrlRQtvRfRkp/UEa82VHuEPlR7Nrn/wK1brbaypG8Hyk2lVl67pOZAEHESHMieazZ CyJdrAa++Sspryu8Wu5yowttwhL+ByUh2srlWQ/urj/2yAb2xba0iXSbAWkuzL/XUVlCcIxuKOTz7v PbtaEp6OLmdokSevYzc+QJYkQjLcDEq/8r9BGR7gkPvCJvUz0xmMkmG9QB03wN5IK31DTgAEN5Wgtk IoV35AUJSp1wwiXsrhPDPtIwVsRUL980FVIKNCIysNbiuTTwlQE9QudT2QTtrdk0GczB65qFgaZGYn rl2UM6NIft6vSlo/GO9qBvgiS8f3CO6aQlbwLX8mXP41+oeOQZ4HO3Ejov4R0S3biqBbdO4b4HQBWB 2SLT0+Qg5tbzKxmEpqxSEYYipVU3jUfNOjm50AI4vv49f24hdZl5+GP6x1NkF3Gy0DB1PcmJ3ZD/9f TaWXQED7dS0VHekUEJP88dXA0B0KWXnY5VBmNWPdTJIfe8bRnirp2vuu0jioKtXacctiWf1TaD2sdr DPGvOyCy+Nb30BtBuzUG6hpmZoM90+HUuzpWqCJiLFuzbrK6cPqCCJj8F22Q==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Deprecation. Generally a dprintk() that appears during a memory
exhaustion scenario is unnecessary and can even be
counterproductive.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_transport.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 94b20fb47135..9aea253af2da 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -129,10 +129,9 @@ static struct svcxprt_rdma *svc_rdma_create_xprt(struct svc_serv *serv,
 {
 	struct svcxprt_rdma *cma_xprt = kzalloc(sizeof *cma_xprt, GFP_KERNEL);
 
-	if (!cma_xprt) {
-		dprintk("svcrdma: failed to create new transport\n");
+	if (!cma_xprt)
 		return NULL;
-	}
+
 	svc_xprt_init(net, &svc_rdma_class, &cma_xprt->sc_xprt, serv);
 	INIT_LIST_HEAD(&cma_xprt->sc_accept_q);
 	INIT_LIST_HEAD(&cma_xprt->sc_rq_dto_q);

