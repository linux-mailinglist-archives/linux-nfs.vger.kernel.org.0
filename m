Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F27B72E9C5
	for <lists+linux-nfs@lfdr.de>; Thu, 30 May 2019 02:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbfE3AnR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 May 2019 20:43:17 -0400
Received: from mx2.suse.de ([195.135.220.15]:46412 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726527AbfE3AnR (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 29 May 2019 20:43:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 83E58ADCB;
        Thu, 30 May 2019 00:43:15 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Olga Kornievskaia <aglo@umich.edu>,
        Chuck Lever <chuck.lever@oracle.com>,
        Schumaker Anna <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>
Date:   Thu, 30 May 2019 10:41:28 +1000
Subject: [PATCH 2/9] SUNRPC: Allow creation of RPC clients with multiple
 connections
Cc:     linux-nfs@vger.kernel.org
Message-ID: <155917688859.3988.12349634364426174850.stgit@noble.brown>
In-Reply-To: <155917564898.3988.6096672032831115016.stgit@noble.brown>
References: <155917564898.3988.6096672032831115016.stgit@noble.brown>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Trond Myklebust <trond.myklebust@primarydata.com>

Add an argument to struct rpc_create_args that allows the specification
of how many transport connections you want to set up to the server.

Multiple transports allow hardware parallelism on the network path to
be fully exploited.  For example if there are multiple network
connections that are bonded together into a single virtual interface,
the bonding mechanism usually distributes flows, rather than packets,
across the multiple connections.  A single TCP flow will then only use
a single connection, while multiple TCP flows can use more of the
connections.
Similarly, when there are multiple DMA engines, multiple offload
engines, or multiple lanes for a network connection, using multiple
flows can allow more of the bandwidth to be utilized.

As an example, Olga Kornievskaia tested NFS read traffic to a
NetApp A700 using a 25GigE Ethernet port.
With a single TCP connection, throughput is limited to about 800
MB/sec
With 4 connections, 2400MB/sec is possible.  With 8, 3000 MB/sec
(24Gb/sec) can be achieved.

Tested-by: Olga Kornievskaia <aglo@umich.edu>
Signed-off-by: Trond Myklebust <trond.myklebust@primarydata.com>
Signed-off-by: NeilBrown <neilb@suse.com>
---
 include/linux/sunrpc/clnt.h |    1 +
 net/sunrpc/clnt.c           |   17 ++++++++++++++++-
 net/sunrpc/xprtmultipath.c  |    3 +--
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/linux/sunrpc/clnt.h b/include/linux/sunrpc/clnt.h
index 6e8073140a5d..4619098affa3 100644
--- a/include/linux/sunrpc/clnt.h
+++ b/include/linux/sunrpc/clnt.h
@@ -124,6 +124,7 @@ struct rpc_create_args {
 	u32			prognumber;	/* overrides program->number */
 	u32			version;
 	rpc_authflavor_t	authflavor;
+	u32			nconnect;
 	unsigned long		flags;
 	char			*client_name;
 	struct svc_xprt		*bc_xprt;	/* NFSv4.1 backchannel */
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 371080ad698a..3619dd5e9e0e 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -528,6 +528,8 @@ struct rpc_clnt *rpc_create(struct rpc_create_args *args)
 		.bc_xprt = args->bc_xprt,
 	};
 	char servername[48];
+	struct rpc_clnt *clnt;
+	int i;
 
 	if (args->bc_xprt) {
 		WARN_ON_ONCE(!(args->protocol & XPRT_TRANSPORT_BC));
@@ -590,7 +592,15 @@ struct rpc_clnt *rpc_create(struct rpc_create_args *args)
 	if (args->flags & RPC_CLNT_CREATE_NONPRIVPORT)
 		xprt->resvport = 0;
 
-	return rpc_create_xprt(args, xprt);
+	clnt = rpc_create_xprt(args, xprt);
+	if (IS_ERR(clnt) || args->nconnect <= 1)
+		return clnt;
+
+	for (i = 0; i < args->nconnect - 1; i++) {
+		if (rpc_clnt_add_xprt(clnt, &xprtargs, NULL, NULL) < 0)
+			break;
+	}
+	return clnt;
 }
 EXPORT_SYMBOL_GPL(rpc_create);
 
@@ -2748,6 +2758,10 @@ int rpc_clnt_test_and_add_xprt(struct rpc_clnt *clnt,
 		return -ENOMEM;
 	data->xps = xprt_switch_get(xps);
 	data->xprt = xprt_get(xprt);
+	if (rpc_xprt_switch_has_addr(data->xps, (struct sockaddr *)&xprt->addr)) {
+		rpc_cb_add_xprt_release(data);
+		goto success;
+	}
 
 	task = rpc_call_null_helper(clnt, xprt, NULL,
 			RPC_TASK_SOFT|RPC_TASK_SOFTCONN|RPC_TASK_ASYNC|RPC_TASK_NULLCREDS,
@@ -2755,6 +2769,7 @@ int rpc_clnt_test_and_add_xprt(struct rpc_clnt *clnt,
 	if (IS_ERR(task))
 		return PTR_ERR(task);
 	rpc_put_task(task);
+success:
 	return 1;
 }
 EXPORT_SYMBOL_GPL(rpc_clnt_test_and_add_xprt);
diff --git a/net/sunrpc/xprtmultipath.c b/net/sunrpc/xprtmultipath.c
index 394e427533be..9d66ce53355d 100644
--- a/net/sunrpc/xprtmultipath.c
+++ b/net/sunrpc/xprtmultipath.c
@@ -52,8 +52,7 @@ void rpc_xprt_switch_add_xprt(struct rpc_xprt_switch *xps,
 	if (xprt == NULL)
 		return;
 	spin_lock(&xps->xps_lock);
-	if ((xps->xps_net == xprt->xprt_net || xps->xps_net == NULL) &&
-	    !rpc_xprt_switch_has_addr(xps, (struct sockaddr *)&xprt->addr))
+	if (xps->xps_net == xprt->xprt_net || xps->xps_net == NULL)
 		xprt_switch_add_xprt_locked(xps, xprt);
 	spin_unlock(&xps->xps_lock);
 }


