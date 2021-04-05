Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66057354542
	for <lists+linux-nfs@lfdr.de>; Mon,  5 Apr 2021 18:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242434AbhDEQfA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 5 Apr 2021 12:35:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:40720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239097AbhDEQfA (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 5 Apr 2021 12:35:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 391BC61398;
        Mon,  5 Apr 2021 16:34:54 +0000 (UTC)
Subject: [PATCH v1 1/6] xprtrdma: rpcrdma_mr_pop() already does
 list_del_init()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Mon, 05 Apr 2021 12:34:53 -0400
Message-ID: <161764049336.29855.1836712073865697630.stgit@manet.1015granger.net>
In-Reply-To: <161764034907.29855.614994107807503843.stgit@manet.1015granger.net>
References: <161764034907.29855.614994107807503843.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The rpcrdma_mr_pop() earlier in the function has already cleared
out mr_list, so it must not be done again in the error path.

Fixes: 847568942f93 ("xprtrdma: Remove fr_state")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/frwr_ops.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 132df9b59ab4..aca2228095db 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -576,7 +576,6 @@ void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 		mr = container_of(frwr, struct rpcrdma_mr, frwr);
 		bad_wr = bad_wr->next;
 
-		list_del_init(&mr->mr_list);
 		frwr_mr_recycle(mr);
 	}
 }


