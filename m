Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB1B542C3DF
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Oct 2021 16:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237194AbhJMOtU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 13 Oct 2021 10:49:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:53136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233971AbhJMOtU (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 13 Oct 2021 10:49:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF7B860F21;
        Wed, 13 Oct 2021 14:47:16 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH v1 4/6] svcrdma: Remove dprintk call sites during QP creation
Date:   Wed, 13 Oct 2021 10:47:16 -0400
Message-Id:  <163413643583.6408.15197434543794100032.stgit@bazille.1015granger.net>
X-Mailer: git-send-email 2.33.0.113.g6c40894d24
In-Reply-To:  <163413628188.6408.17033105928649076434.stgit@bazille.1015granger.net>
References:  <163413628188.6408.17033105928649076434.stgit@bazille.1015granger.net>
User-Agent: StGit/1.1+62.ged16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1208; h=from:subject:message-id; bh=FRC2h1RBBN/Po84WMyVhVKnP8xRRkGCjDJn70Hg9lWM=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBhZvFzDYVkOvfPo+rOVbAy9U1mpYFUivxAqxxXgDxL drq0aruJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYWbxcwAKCRAzarMzb2Z/l5SjEA C1U6BtF6XytmZ3ytya9dGWbNpimiP8+bFsretEqU215ZgJ38H0P7pA54dQrgSytU2sAS4NJUtdvAYR 1jx7OX37jxi/05Vk+TAeg6y5pCsUCQHI8Sm2m4CRpZFCunk+W+Mu01khHBcN0ftx7uNqEwzR44Ep6v 9jpRxzhbOAJXUhIXxfNePwuLti675JWATegJ82L3RFCBRGxpmp3ZLnIrmtNBDDtl7QDBUi/A6O0qMD ukmMHF8W22i2X4E3edcPkjdTno63j4kqgjCBt1pWY6hAXDS6XxkI7rX94bdHXUWAEB6EW1vj3rkbjF rLXyUuNN+OkNlOB5bxI1LTMRU6Y7YrulHShxBpWJHTb4uj4rXDMe/HIc1nKm6WxZxPcevzNdede5mE CZrhsGZCJ26E/+PVDEnLicTvHBTcpxB6FDJiaoJ2KDVBEmsGQx1Xr/16pbJY7rlhxHWjmi6o5iW6yP 80d3ak8XBu6TQI5YQ4FMSf8vms3iTwnutqXi7Egz47yOvF0xBSejdQAkwe1FNYEDPmSCtAmf1vSxI3 fHh8gZxACuYBqjbrwCvruffSlRplCGmMhl3Grs5+LxQDpHpktRImdk8XidoPBXPTsvN9uki+/3XMPU yw/jKPaqR/VklquSHmex28vkbQH1/nXn/vyRlpJr8Pyq3J0M7naJQZOZOpig==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Deprecation. Printing pointer addresses in the log isn't valuable,
and the other information is now available from the core's qp_create
tracepoint.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_transport.c |    7 -------
 1 file changed, 7 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 11cecfb7761a..e105e2d89b9b 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -445,13 +445,6 @@ static struct svc_xprt *svc_rdma_accept(struct svc_xprt *xprt)
 	qp_attr.qp_type = IB_QPT_RC;
 	qp_attr.send_cq = newxprt->sc_sq_cq;
 	qp_attr.recv_cq = newxprt->sc_rq_cq;
-	dprintk("svcrdma: newxprt->sc_cm_id=%p, newxprt->sc_pd=%p\n",
-		newxprt->sc_cm_id, newxprt->sc_pd);
-	dprintk("    cap.max_send_wr = %d, cap.max_recv_wr = %d\n",
-		qp_attr.cap.max_send_wr, qp_attr.cap.max_recv_wr);
-	dprintk("    cap.max_send_sge = %d, cap.max_recv_sge = %d\n",
-		qp_attr.cap.max_send_sge, qp_attr.cap.max_recv_sge);
-
 	ret = rdma_create_qp(newxprt->sc_cm_id, newxprt->sc_pd, &qp_attr);
 	if (ret) {
 		trace_svcrdma_qp_err(newxprt, ret);

