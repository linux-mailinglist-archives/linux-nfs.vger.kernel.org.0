Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12DFC352D7A
	for <lists+linux-nfs@lfdr.de>; Fri,  2 Apr 2021 18:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234996AbhDBPaV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 2 Apr 2021 11:30:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39240 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229553AbhDBPaU (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 2 Apr 2021 11:30:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 717E061104;
        Fri,  2 Apr 2021 15:30:19 +0000 (UTC)
Subject: [PATCH v2 1/8] xprtrdma: Avoid Receive Queue wrapping
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Fri, 02 Apr 2021 11:30:18 -0400
Message-ID: <161737741848.2012531.4888281916982707053.stgit@manet.1015granger.net>
In-Reply-To: <161737723751.2012531.17740046594972271239.stgit@manet.1015granger.net>
References: <161737723751.2012531.17740046594972271239.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Commit e340c2d6ef2a ("xprtrdma: Reduce the doorbell rate (Receive)")
increased the number of Receive WRs that are posted by the client,
but did not increase the size of the Receive Queue allocated during
transport set-up.

This is usually not an issue because RPCRDMA_BACKWARD_WRS is defined
as (32) when SUNRPC_BACKCHANNEL is defined. In cases where it isn't,
there is a real risk of Receive Queue wrapping.

Fixes: e340c2d6ef2a ("xprtrdma: Reduce the doorbell rate (Receive)")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Tom Talpey <tom@talpey.com>
---
 net/sunrpc/xprtrdma/frwr_ops.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 766a1048a48a..132df9b59ab4 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -257,6 +257,7 @@ int frwr_query_device(struct rpcrdma_ep *ep, const struct ib_device *device)
 	ep->re_attr.cap.max_send_wr += 1; /* for ib_drain_sq */
 	ep->re_attr.cap.max_recv_wr = ep->re_max_requests;
 	ep->re_attr.cap.max_recv_wr += RPCRDMA_BACKWARD_WRS;
+	ep->re_attr.cap.max_recv_wr += RPCRDMA_MAX_RECV_BATCH;
 	ep->re_attr.cap.max_recv_wr += 1; /* for ib_drain_rq */
 
 	ep->re_max_rdma_segs =


