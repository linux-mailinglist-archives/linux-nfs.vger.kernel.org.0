Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 045172E9C7
	for <lists+linux-nfs@lfdr.de>; Thu, 30 May 2019 02:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbfE3An3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 29 May 2019 20:43:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:46444 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726527AbfE3An3 (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 29 May 2019 20:43:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 679B8AC66;
        Thu, 30 May 2019 00:43:28 +0000 (UTC)
From:   NeilBrown <neilb@suse.com>
To:     Olga Kornievskaia <aglo@umich.edu>,
        Chuck Lever <chuck.lever@oracle.com>,
        Schumaker Anna <Anna.Schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>
Date:   Thu, 30 May 2019 10:41:28 +1000
Subject: [PATCH 4/9] SUNRPC: enhance rpc_clnt_show_stats() to report on all
 xprts.
Cc:     linux-nfs@vger.kernel.org
Message-ID: <155917688867.3988.13820076347074775411.stgit@noble.brown>
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

Now that a client can have multiple xprts, we need to
report the statistics for all of them.

Reported-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: NeilBrown <neilb@suse.com>
---
 net/sunrpc/stats.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/sunrpc/stats.c b/net/sunrpc/stats.c
index 2b6dc7e5f74f..d26df6074bca 100644
--- a/net/sunrpc/stats.c
+++ b/net/sunrpc/stats.c
@@ -236,9 +236,16 @@ static void _print_rpc_iostats(struct seq_file *seq, struct rpc_iostats *stats,
 		   ktime_to_ms(stats->om_execute));
 }
 
+static int do_print_stats(struct rpc_clnt *clnt, struct rpc_xprt *xprt, void *seqv)
+{
+	struct seq_file *seq = seqv;
+
+	xprt->ops->print_stats(xprt, seq);
+	return 0;
+}
+
 void rpc_clnt_show_stats(struct seq_file *seq, struct rpc_clnt *clnt)
 {
-	struct rpc_xprt *xprt;
 	unsigned int op, maxproc = clnt->cl_maxproc;
 
 	if (!clnt->cl_metrics)
@@ -248,11 +255,7 @@ void rpc_clnt_show_stats(struct seq_file *seq, struct rpc_clnt *clnt)
 	seq_printf(seq, "p/v: %u/%u (%s)\n",
 			clnt->cl_prog, clnt->cl_vers, clnt->cl_program->name);
 
-	rcu_read_lock();
-	xprt = rcu_dereference(clnt->cl_xprt);
-	if (xprt)
-		xprt->ops->print_stats(xprt, seq);
-	rcu_read_unlock();
+	rpc_clnt_iterate_for_each_xprt(clnt, do_print_stats, seq);
 
 	seq_printf(seq, "\tper-op statistics\n");
 	for (op = 0; op < maxproc; op++) {


