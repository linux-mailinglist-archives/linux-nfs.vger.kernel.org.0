Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4B436496D
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Apr 2021 20:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240470AbhDSSCf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Apr 2021 14:02:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:40862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240433AbhDSSCe (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 19 Apr 2021 14:02:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A02D61001;
        Mon, 19 Apr 2021 18:02:04 +0000 (UTC)
Subject: [PATCH v3 04/26] xprtrdma: Avoid Receive Queue wrapping
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 19 Apr 2021 14:02:03 -0400
Message-ID: <161885532369.38598.5198559642333362919.stgit@manet.1015granger.net>
In-Reply-To: <161885481568.38598.16682844600209775665.stgit@manet.1015granger.net>
References: <161885481568.38598.16682844600209775665.stgit@manet.1015granger.net>
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


