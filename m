Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 151B734D287
	for <lists+linux-nfs@lfdr.de>; Mon, 29 Mar 2021 16:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbhC2OkN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 29 Mar 2021 10:40:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:40386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230401AbhC2Ojr (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 29 Mar 2021 10:39:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 54FC56192C;
        Mon, 29 Mar 2021 14:39:47 +0000 (UTC)
Subject: [PATCH v1 0/6] Restructure how svcrdma handles RDMA Read
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 29 Mar 2021 10:39:46 -0400
Message-ID: <161702808762.5937.3596341039481819410.stgit@klimt.1015granger.net>
User-Agent: StGit/1.0-5-g755c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi-

I'm on a "mission" to reduce the amount of page allocator churn
that happens during server-side RPC call processing.

In the case where svcrdma needs to perform an RDMA Read to pull
Read chunks from a client, currently two calls to svc_rdma_recvfrom
are necessary:

Call 1:

An ingress Receive is processed. If there are Read chunks, the
transport strips the pages out of the passed-in svc_rqst, sets up
the RDMA Read with those pages and posts the Read, then returns
the svc_rqst with missing pages. Return value of zero means no
RPC Call is ready yet.

---

Meanwhile svc has to refill those pages in the svc_rqst to
prepare it for the next incoming RPC.

---

Call 2:

The Read completion has occurred. The transport strips the pages
out of the passed-in svc_rqst and frees them. It copies the
pages from the Read sink buffer into the svc_rqst, and returns
the completed RPC.

---


Instead, let's do the RDMA Reads synchronously with a single call to
svc_rdma_recvfrom(). When svc_rdma_recvfrom() handles an ingress
Receive with Read chunks, set up the RDMA Read sink buffer using the
available pages in the svc_rqst, and wait right there for
completion.

For large Read chunks, this avoids freeing a bunch of pages and then
allocating them again. Fewer trips to the page allocator means less
time with IRQs disabled, and measurably faster turn-around for the
next RPC.

Also, now that XPT_BUSY is cleared immediately when a Receive is
dequeued, the transport can handle a higher rate of incoming RPCs.


---

Chuck Lever (6):
      SUNRPC: Export svc_xprt_received()
      SUNRPC: Move svc_xprt_received() call sites
      svcrdma: Single-stage RDMA Read
      svcrdma: Remove sc_read_complete_q
      svcrdma: Remove svc_rdma_recv_ctxt::rc_pages and ::rc_arg
      svcrdma: Clean up dto_q critical section in svc_rdma_recvfrom()


 include/linux/sunrpc/svc_rdma.h          |   5 --
 net/sunrpc/svc_xprt.c                    |   7 +-
 net/sunrpc/svcsock.c                     |   9 +-
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  |  76 +++-------------
 net/sunrpc/xprtrdma/svc_rdma_rw.c        | 108 ++++++++---------------
 net/sunrpc/xprtrdma/svc_rdma_transport.c |   1 -
 6 files changed, 60 insertions(+), 146 deletions(-)

--
Chuck Lever

