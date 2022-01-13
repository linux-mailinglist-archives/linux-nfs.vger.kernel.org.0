Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5D1448DCC7
	for <lists+linux-nfs@lfdr.de>; Thu, 13 Jan 2022 18:20:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbiAMRU0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Jan 2022 12:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiAMRU0 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 Jan 2022 12:20:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9F01C061574
        for <linux-nfs@vger.kernel.org>; Thu, 13 Jan 2022 09:20:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6259F61CBC
        for <linux-nfs@vger.kernel.org>; Thu, 13 Jan 2022 17:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C866C36AE9;
        Thu, 13 Jan 2022 17:20:24 +0000 (UTC)
From:   Chuck Lever <chuck.lever@oracle.com>
To:     anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 1/3] xprtrdma: Remove final dprintk call sites from xprtrdma
Date:   Thu, 13 Jan 2022 12:20:23 -0500
Message-Id:  <164209442350.12592.14921966531121954143.stgit@morisot.1015granger.net>
X-Mailer: git-send-email 2.34.0
In-Reply-To:  <164209428615.12592.12164353310787172940.stgit@morisot.1015granger.net>
References:  <164209428615.12592.12164353310787172940.stgit@morisot.1015granger.net>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1629; h=from:subject:message-id; bh=4si20t/QRYTiDqfiL8DdGptX3J5TbdpGyoqEdXgQ93s=; b=owEBbQKS/ZANAwAIATNqszNvZn+XAcsmYgBh4F9XJKOBfn6Q5Tl+W3acod/Ud/g4C3W6Hy/tiiCU QjkyZ7aJAjMEAAEIAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCYeBfVwAKCRAzarMzb2Z/l/a9EA CJD6ulTUf/C1Zbklz38ddJwCbTyFHjHXAJaJELr43NJ2xvhUX2PZkoxHSbNPDiMDxSFTVR9tQ9D66R mI8nU2XDfgkV6vLb+HHm2jHjdyWrSUO7Uzn4MabqCIHpIxZutNvszZUEwdsXJs/4oHXTw6KFJxl2Y4 84OVhTqCD5IMyQsTp81XHyaKBkq+oMnCW3m9NBP2RDUxs7pIJRxyBQ+pJOtHPs7QcZde+2ozLRKgL0 19u/WIXujsvPpateG+e1stR50zMx9UdCkXArKBe2UtBGg3cHxrqR6D9zcZDjHNtI8UPZeyu5WqeU66 4T82MnRvyAHuV46YpB+5YYkhzptXb//80sucRrfJ/KkIk5vWdEoYM/OvBVyGuzgIEprs08Q6YFWSLc wMKzigWv/WxoPHPubKxrtqEtmF3Iu5kho9B8Ek6dhPGkhoZ4TfE/b4d/o51WQ9dEFITcvT91rsPwvl 2E+6/Ao9OAdcPCpnvcngrfSOLOtAvSfYTExlKz7pWWMYi41nK/o/1jdCVyvW1KW56gCxVo4HCSCgg4 I5pZfQCaJ90x5NWbbT3O7hNT6ZAxqTBHDnzn/XIfkyea6EudbsH1iRTTpqXUEiSauiPGeFVCoxHCLo MlYxZ1wjSVSlAqB5N2JOFwmIbYXI+aDnvadwqiBUICReYWjFNAw7zmgF0nxw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp; fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Deprecated. This information is available via tracepoints.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/verbs.c |   12 ------------
 1 file changed, 12 deletions(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 3d3673ba9e1e..1d6e85fe3133 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -274,8 +274,6 @@ rpcrdma_cm_event_handler(struct rdma_cm_id *id, struct rdma_cm_event *event)
 		ep->re_connect_status = -ENETUNREACH;
 		goto wake_connect_worker;
 	case RDMA_CM_EVENT_REJECTED:
-		dprintk("rpcrdma: connection to %pISpc rejected: %s\n",
-			sap, rdma_reject_msg(id, event->status));
 		ep->re_connect_status = -ECONNREFUSED;
 		if (event->status == IB_CM_REJ_STALE_CONN)
 			ep->re_connect_status = -ENOTCONN;
@@ -291,8 +289,6 @@ rpcrdma_cm_event_handler(struct rdma_cm_id *id, struct rdma_cm_event *event)
 		break;
 	}
 
-	dprintk("RPC:       %s: %pISpc on %s/frwr: %s\n", __func__, sap,
-		ep->re_id->device->name, rdma_event_msg(event->event));
 	return 0;
 }
 
@@ -419,14 +415,6 @@ static int rpcrdma_ep_create(struct rpcrdma_xprt *r_xprt)
 	ep->re_attr.qp_type = IB_QPT_RC;
 	ep->re_attr.port_num = ~0;
 
-	dprintk("RPC:       %s: requested max: dtos: send %d recv %d; "
-		"iovs: send %d recv %d\n",
-		__func__,
-		ep->re_attr.cap.max_send_wr,
-		ep->re_attr.cap.max_recv_wr,
-		ep->re_attr.cap.max_send_sge,
-		ep->re_attr.cap.max_recv_sge);
-
 	ep->re_send_batch = ep->re_max_requests >> 3;
 	ep->re_send_count = ep->re_send_batch;
 	init_waitqueue_head(&ep->re_connect_wait);

