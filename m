Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A0B25E83E
	for <lists+linux-nfs@lfdr.de>; Sat,  5 Sep 2020 16:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbgIEODs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sat, 5 Sep 2020 10:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgIEODi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sat, 5 Sep 2020 10:03:38 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AE8C061244
        for <linux-nfs@vger.kernel.org>; Sat,  5 Sep 2020 07:03:35 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id E171A5F98; Sat,  5 Sep 2020 10:03:26 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org E171A5F98
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1599314606;
        bh=7LkyHTNKwI21A1gS4C2w882VK3WDdvg604nL66Wjoi0=;
        h=Date:To:Cc:Subject:From:From;
        b=MqhfJo3LIpZnKH8f0O6/lUTEiUaF2BvYg1f7YNc8k9EMuaPLIXPqeUSWHSNSFS3gk
         I41IakO2eeVYyGRaypiBH9EuNsTK6mKEAoBFF7UwlSg68F7NyNx8CQ7IWtGAJaHs0H
         STD3wheA6halzdrokY0dMlerxrlpS10XM9B/z9Jk=
Date:   Sat, 5 Sep 2020 10:03:26 -0400
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <schumakeranna@gmail.com>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH] SUNRPC: stop printk reading past end of string
Message-ID: <20200905140326.GA26625@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

Since p points at raw xdr data, there's no guarantee that it's NULL
terminated, so we should give a length.  And probably escape any special
characters too.

Reported-by: Zhi Li <yieli@redhat.com>
Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 net/sunrpc/rpcb_clnt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/rpcb_clnt.c b/net/sunrpc/rpcb_clnt.c
index c27123e6ba80..4a67685c83eb 100644
--- a/net/sunrpc/rpcb_clnt.c
+++ b/net/sunrpc/rpcb_clnt.c
@@ -982,8 +982,8 @@ static int rpcb_dec_getaddr(struct rpc_rqst *req, struct xdr_stream *xdr,
 	p = xdr_inline_decode(xdr, len);
 	if (unlikely(p == NULL))
 		goto out_fail;
-	dprintk("RPC: %5u RPCB_%s reply: %s\n", req->rq_task->tk_pid,
-			req->rq_task->tk_msg.rpc_proc->p_name, (char *)p);
+	dprintk("RPC: %5u RPCB_%s reply: %*pE\n", req->rq_task->tk_pid,
+			req->rq_task->tk_msg.rpc_proc->p_name, len, (char *)p);
 
 	if (rpc_uaddr2sockaddr(req->rq_xprt->xprt_net, (char *)p, len,
 				sap, sizeof(address)) == 0)
-- 
2.26.2

