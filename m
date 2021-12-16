Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6034D4780F2
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Dec 2021 00:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhLPXx4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Dec 2021 18:53:56 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:56422 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbhLPXx4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Dec 2021 18:53:56 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4C5251F37F;
        Thu, 16 Dec 2021 23:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639698835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f9JPZARu0omLin5bRQVSgWDU6wAXTb1AVpCm2PGq0QA=;
        b=XkyI4ce5LB7cLg0dZlvq/6cmAkIAlrOduZ3YaFyQlqABD8YnjmxuQ3tqORjbkTXll3mDxg
        VBgynpVdMJrYSmT5w3wMlCSXbxjFyO1A2mzVAn+2715rUj2Aj9DqoeIs5bP3zOyGIz8aEL
        zZXfps1UomDTorCv+vMH9ZfEBjFwLFI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639698835;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=f9JPZARu0omLin5bRQVSgWDU6wAXTb1AVpCm2PGq0QA=;
        b=zyNmjZO9NIndVyf1Mh426Eme8KWpjWDzaouhaq4ppJ7DxpOjj59Xgx/6m8mwAIDmFL8t0G
        xicSDE4ks/ug8BCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 35EDA13EFD;
        Thu, 16 Dec 2021 23:53:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id auDHOI/Ru2G8WwAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 16 Dec 2021 23:53:51 +0000
Subject: [PATCH 13/18] SUNRPC/xprt: async tasks mustn't block waiting for
 memory
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Cc:     linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 17 Dec 2021 10:48:23 +1100
Message-ID: <163969850327.20885.823088186596498420.stgit@noble.brown>
In-Reply-To: <163969801519.20885.3977673503103544412.stgit@noble.brown>
References: <163969801519.20885.3977673503103544412.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

When memory is short, new worker threads cannot be created and we depend
on the minimum one rpciod thread to be able to handle everything.  So it
must not block waiting for memory.

xprt_dynamic_alloc_slot can block indefinitely.  This can tie up all
workqueue threads and NFS can deadlock.  So when called from a
workqueue, set __GFP_NORETRY.

The rdma alloc_slot already does not block.  However it sets the error
to -EAGAIN suggesting this will trigger a sleep.  It does not.  As we
can see in call_reserveresult(), only -ENOMEM causes a sleep.  -EAGAIN
causes immediate retry.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 net/sunrpc/xprt.c               |    5 ++++-
 net/sunrpc/xprtrdma/transport.c |    2 +-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index a02de2bddb28..47d207e416ab 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -1687,12 +1687,15 @@ static bool xprt_throttle_congested(struct rpc_xprt *xprt, struct rpc_task *task
 static struct rpc_rqst *xprt_dynamic_alloc_slot(struct rpc_xprt *xprt)
 {
 	struct rpc_rqst *req = ERR_PTR(-EAGAIN);
+	gfp_t gfp_mask = GFP_NOFS;
 
 	if (xprt->num_reqs >= xprt->max_reqs)
 		goto out;
 	++xprt->num_reqs;
 	spin_unlock(&xprt->reserve_lock);
-	req = kzalloc(sizeof(struct rpc_rqst), GFP_NOFS);
+	if (current->flags & PF_WQ_WORKER)
+		gfp_mask |= __GFP_NORETRY | __GFP_NOWARN;
+	req = kzalloc(sizeof(struct rpc_rqst), gfp_mask);
 	spin_lock(&xprt->reserve_lock);
 	if (req != NULL)
 		goto out;
diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index a52277115500..32df23796747 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -521,7 +521,7 @@ xprt_rdma_alloc_slot(struct rpc_xprt *xprt, struct rpc_task *task)
 	return;
 
 out_sleep:
-	task->tk_status = -EAGAIN;
+	task->tk_status = -ENOMEM;
 	xprt_add_backlog(xprt, task);
 }
 


