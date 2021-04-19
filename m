Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97FDD364964
	for <lists+linux-nfs@lfdr.de>; Mon, 19 Apr 2021 20:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240347AbhDSSCK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 19 Apr 2021 14:02:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:40744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234356AbhDSSCJ (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 19 Apr 2021 14:02:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5C2E561001;
        Mon, 19 Apr 2021 18:01:39 +0000 (UTC)
Subject: [PATCH v3 00/26] NFS/RDMA client patches for next
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 19 Apr 2021 14:01:38 -0400
Message-ID: <161885481568.38598.16682844600209775665.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Trond-

Anna suggested I send these directly to you for review. They include
the three SUNRPC patches you've already seen and all NFS/RDMA
client-related patches I'm interested in seeing in the next kernel
release. All of these have been posted before and have been updated
with changes requested by reviewers.

---

Chuck Lever (26):
      SUNRPC: Move fault injection call sites
      SUNRPC: Remove trace_xprt_transmit_queued
      SUNRPC: Add tracepoint that fires when an RPC is retransmitted
      xprtrdma: Avoid Receive Queue wrapping
      xprtrdma: Do not refresh Receive Queue while it is draining
      xprtrdma: Put flushed Receives on free list instead of destroying them
      xprtrdma: Improve locking around rpcrdma_rep destruction
      xprtrdma: Improve commentary around rpcrdma_reps_unmap()
      xprtrdma: Improve locking around rpcrdma_rep creation
      xprtrdma: Fix cwnd update ordering
      xprtrdma: Delete rpcrdma_recv_buffer_put()
      xprtrdma: rpcrdma_mr_pop() already does list_del_init()
      xprtrdma: Rename frwr_release_mr()
      xprtrdma: Clarify use of barrier in frwr_wc_localinv_done()
      xprtrdma: Do not recycle MR after FastReg/LocalInv flushes
      xprtrdma: Do not wake RPC consumer on a failed LocalInv
      xprtrdma: Avoid Send Queue wrapping
      xprtrdma: Add tracepoints showing FastReg WRs and remote invalidation
      xprtrdma: Add an rpcrdma_mr_completion_class
      xprtrdma: Don't display r_xprt memory addresses in tracepoints
      xprtrdma: Remove the RPC/RDMA QP event handler
      xprtrdma: Move fr_cid to struct rpcrdma_mr
      xprtrdma: Move cqe to struct rpcrdma_mr
      xprtrdma: Move fr_linv_done field to struct rpcrdma_mr
      xprtrdma: Move the Work Request union to struct rpcrdma_mr
      xprtrdma: Move fr_mr field to struct rpcrdma_mr


 include/trace/events/rpcrdma.h    | 146 ++++++++++-----------
 include/trace/events/sunrpc.h     |  41 +++++-
 net/sunrpc/xprt.c                 |   6 +-
 net/sunrpc/xprtrdma/backchannel.c |   4 +-
 net/sunrpc/xprtrdma/frwr_ops.c    | 208 +++++++++++++-----------------
 net/sunrpc/xprtrdma/rpc_rdma.c    |  39 +++++-
 net/sunrpc/xprtrdma/verbs.c       | 131 +++++++++----------
 net/sunrpc/xprtrdma/xprt_rdma.h   |  29 ++---
 8 files changed, 317 insertions(+), 287 deletions(-)

--
Chuck Lever

