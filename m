Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6D83222AF
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Feb 2021 00:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhBVXhO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 22 Feb 2021 18:37:14 -0500
Received: from btbn.de ([5.9.118.179]:51364 "EHLO btbn.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229996AbhBVXhN (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 22 Feb 2021 18:37:13 -0500
Received: from Kryux.localdomain (muedsl-82-207-198-025.citykom.de [82.207.198.25])
        by btbn.de (Postfix) with ESMTPSA id CD4B811E981;
        Tue, 23 Feb 2021 00:36:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rothenpieler.org;
        s=mail; t=1614036991;
        bh=tMLEVN/iD5cZUgWXeZ3iblLrucHf+nrkwFvf23GuuxM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=BJXzU3aVu7/k+g30eDBdmLiAemUYmhG6HtM4y8kTPcNbiqNmRdOzaqUilRLEiCa5C
         eWmaE1Opu3LITO2YlsjiqN/xyKF8yoMyDZ4Qm9AdVGULpthKY9F8s2V+e5tADSs6kx
         KH+y4KN+KbQzorvjJUPY5hApi5bl0KS12b/EAoz4SOaZC96wSiXXCPvFHbjaJVc8HP
         KGnzqugUBj+ORKPuY6HsJupThRDtVtt0SWYja8l0mEvbRtsVPY1AksGZr8BK9oQBLB
         hRllRT9mqONYAKbiniwcb3RSW6PmJlgdIMTV/QcRhCnJl9eTQh3smxD/IgndDElVTl
         kGn1UM7gntfOQ==
From:   Timo Rothenpieler <timo@rothenpieler.org>
To:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>,
        Olga Kornievskaia <aglo@umich.edu>,
        Dai Ngo <dai.ngo@oracle.com>,
        Timo Rothenpieler <timo@rothenpieler.org>
Subject: [PATCH] svcrdma: disable timeouts on rdma backchannel
Date:   Tue, 23 Feb 2021 00:36:19 +0100
Message-Id: <20210222233619.21568-1-timo@rothenpieler.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <C99EA5DE-814A-418B-9685-D400F4E7B964@oracle.com>
References: <C99EA5DE-814A-418B-9685-D400F4E7B964@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This brings it in line with the regular tcp backchannel, which also has
all those timeouts disabled.

Prevents the backchannel from timing out, getting some async operations
like server side copying getting stuck indefinitely on the client side.

Signed-off-by: Timo Rothenpieler <timo@rothenpieler.org>
---
Did the same testing with this applied than before, and could not
observe it getting stuck, same as with the previous patch, which I
removed before testing this one.

This obviously still does not fix the issue of it being seemingly unable
to reestablish the disconnected backchannel.
An event that disconnects the backchannel but leaves the main connection
intact seems a pretty rare occurance though, outside of this issue.

 net/sunrpc/xprtrdma/svc_rdma_backchannel.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
index 63f8be974df2..8186ab6f99f1 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_backchannel.c
@@ -252,9 +252,9 @@ xprt_setup_rdma_bc(struct xprt_create *args)
 	xprt->timeout = &xprt_rdma_bc_timeout;
 	xprt_set_bound(xprt);
 	xprt_set_connected(xprt);
-	xprt->bind_timeout = RPCRDMA_BIND_TO;
-	xprt->reestablish_timeout = RPCRDMA_INIT_REEST_TO;
-	xprt->idle_timeout = RPCRDMA_IDLE_DISC_TO;
+	xprt->bind_timeout = 0;
+	xprt->reestablish_timeout = 0;
+	xprt->idle_timeout = 0;
 
 	xprt->prot = XPRT_TRANSPORT_BC_RDMA;
 	xprt->ops = &xprt_rdma_bc_procs;
-- 
2.25.1

