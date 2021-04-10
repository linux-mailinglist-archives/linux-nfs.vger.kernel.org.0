Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B09A535AFB2
	for <lists+linux-nfs@lfdr.de>; Sat, 10 Apr 2021 20:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbhDJSwK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 10 Apr 2021 14:52:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:41748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234768AbhDJSwK (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Sat, 10 Apr 2021 14:52:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 350F46113A;
        Sat, 10 Apr 2021 18:51:55 +0000 (UTC)
Subject: [PATCH v1 1/4] xprtrdma: Add tracepoints showing FastReg WRs and
 remote invalidation
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Sat, 10 Apr 2021 14:51:54 -0400
Message-ID: <161808071446.21449.3156196898157282561.stgit@manet.1015granger.net>
In-Reply-To: <161808067409.21449.15778528150201556096.stgit@manet.1015granger.net>
References: <161808067409.21449.15778528150201556096.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

The Send signaling logic is a little subtle, so add some
observability around it. For every xprtrdma_mr_fastreg event, there
should be an xprtrdma_mr_localinv or xprtrdma_mr_reminv event.

When these tracepoints are enabled, we can see exactly when an MR is
DMA-mapped, registered, invalidated (either locally or remotely) and
then DMA-unmapped.

   kworker/u25:2-190   [000]   787.979512: xprtrdma_mr_map:      task:351@5 mr.id=4 nents=2 5608@0x8679e0c8f6f56000:0x00000503 (TO_DEVICE)
   kworker/u25:2-190   [000]   787.979515: xprtrdma_chunk_read:  task:351@5 pos=148 5608@0x8679e0c8f6f56000:0x00000503 (last)
   kworker/u25:2-190   [000]   787.979519: xprtrdma_marshal:     task:351@5 xid=0x8679e0c8: hdr=52 xdr=148/5608/0 read list/inline
   kworker/u25:2-190   [000]   787.979525: xprtrdma_mr_fastreg:  task:351@5 mr.id=4 nents=2 5608@0x8679e0c8f6f56000:0x00000503 (TO_DEVICE)
   kworker/u25:2-190   [000]   787.979526: xprtrdma_post_send:   task:351@5 cq.id=0 cid=73 (2 SGEs)

 ...

    kworker/5:1H-219   [005]   787.980567: xprtrdma_wc_receive:  cq.id=1 cid=161 status=SUCCESS (0/0x0) received=164
    kworker/5:1H-219   [005]   787.980571: xprtrdma_post_recvs:  peer=[192.168.100.55]:20049 r_xprt=0xffff8884974d4000: 0 new recvs, 70 active (rc 0)
    kworker/5:1H-219   [005]   787.980573: xprtrdma_reply:       task:351@5 xid=0x8679e0c8 credits=64
    kworker/5:1H-219   [005]   787.980576: xprtrdma_mr_reminv:   task:351@5 mr.id=4 nents=2 5608@0x8679e0c8f6f56000:0x00000503 (TO_DEVICE)
    kworker/5:1H-219   [005]   787.980577: xprtrdma_mr_unmap:    mr.id=4 nents=2 5608@0x8679e0c8f6f56000:0x00000503 (TO_DEVICE)

Note that I've moved the xprtrdma_post_send tracepoint so that event
always appears after the xprtrdma_mr_fastreg tracepoint. Otherwise
the event log looks counterintuitive (FastReg is always supposed to
happen before Send).

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/trace/events/rpcrdma.h |    2 ++
 net/sunrpc/xprtrdma/frwr_ops.c |    2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/trace/events/rpcrdma.h b/include/trace/events/rpcrdma.h
index e38e745d13b0..9462326b3535 100644
--- a/include/trace/events/rpcrdma.h
+++ b/include/trace/events/rpcrdma.h
@@ -1010,7 +1010,9 @@ TRACE_EVENT(xprtrdma_frwr_maperr,
 	)
 );
 
+DEFINE_MR_EVENT(fastreg);
 DEFINE_MR_EVENT(localinv);
+DEFINE_MR_EVENT(reminv);
 DEFINE_MR_EVENT(map);
 
 DEFINE_ANON_MR_EVENT(unmap);
diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 43a412ea337a..0f47c1e24037 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -400,6 +400,7 @@ int frwr_send(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 	list_for_each_entry(mr, &req->rl_registered, mr_list) {
 		struct rpcrdma_frwr *frwr;
 
+		trace_xprtrdma_mr_fastreg(mr);
 		frwr = &mr->frwr;
 
 		frwr->fr_cqe.done = frwr_wc_fastreg;
@@ -440,6 +441,7 @@ void frwr_reminv(struct rpcrdma_rep *rep, struct list_head *mrs)
 	list_for_each_entry(mr, mrs, mr_list)
 		if (mr->mr_handle == rep->rr_inv_rkey) {
 			list_del_init(&mr->mr_list);
+			trace_xprtrdma_mr_reminv(mr);
 			frwr_mr_put(mr);
 			break;	/* only one invalidated MR per RPC */
 		}


