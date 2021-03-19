Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A772341F6C
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Mar 2021 15:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbhCSObg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 19 Mar 2021 10:31:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:35424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230047AbhCSObb (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 19 Mar 2021 10:31:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 94F3364F18;
        Fri, 19 Mar 2021 14:31:30 +0000 (UTC)
Subject: [PATCH v1 3/6] svcrdma: Remove stale comment for
 svc_rdma_wc_receive()
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Fri, 19 Mar 2021 10:31:29 -0400
Message-ID: <161616428984.173092.14541275971597200933.stgit@klimt.1015granger.net>
In-Reply-To: <161616413550.173092.13403865110684484953.stgit@klimt.1015granger.net>
References: <161616413550.173092.13403865110684484953.stgit@klimt.1015granger.net>
User-Agent: StGit/1.0-5-g755c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

xprt pinning was removed in commit 365e9992b90f ("svcrdma: Remove
transport reference counting"), but this comment was not updated
to reflect that change.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 215d2adadbdd..04148a656b2a 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -322,8 +322,6 @@ bool svc_rdma_post_recvs(struct svcxprt_rdma *rdma)
  * @cq: Completion Queue context
  * @wc: Work Completion object
  *
- * NB: The svc_xprt/svcxprt_rdma is pinned whenever it's possible that
- * the Receive completion handler could be running.
  */
 static void svc_rdma_wc_receive(struct ib_cq *cq, struct ib_wc *wc)
 {


