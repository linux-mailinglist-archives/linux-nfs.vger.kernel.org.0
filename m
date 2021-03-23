Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B28073469F1
	for <lists+linux-nfs@lfdr.de>; Tue, 23 Mar 2021 21:38:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbhCWUhu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 23 Mar 2021 16:37:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:49184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233274AbhCWUh2 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Tue, 23 Mar 2021 16:37:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D5888619BA;
        Tue, 23 Mar 2021 20:37:27 +0000 (UTC)
Subject: [PATCH 1 4/4] svcrdma: Retain the page backing
 rq_res.head[0].iov_base
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Tue, 23 Mar 2021 16:37:27 -0400
Message-ID: <161653184711.1499.18423742648834808627.stgit@klimt.1015granger.net>
In-Reply-To: <161653161669.1499.11923816743962834540.stgit@klimt.1015granger.net>
References: <161653161669.1499.11923816743962834540.stgit@klimt.1015granger.net>
User-Agent: StGit/1.0-5-g755c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

svc_rdma_sendto() now waits for the NIC hardware to finish with
the pages backing rq_res. We still have to release the page array
in some cases, but now it's always safe to immediately re-use the
page backing rq_res's head buffer.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/svc_rdma_sendto.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index f093c9b536ff..056452cabc98 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -957,6 +957,11 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 	ret = svc_rdma_send_reply_msg(rdma, sctxt, rctxt, rqstp);
 	if (ret < 0)
 		goto err1;
+
+	/* Prevent svc_xprt_release() from releasing the page backing
+	 * rq_res.head[0].iov_base. It's no longer being accessed by
+	 * the I/O device. */
+	rqstp->rq_respages++;
 	return 0;
 
  err2:


