Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A144780EC
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Dec 2021 00:53:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbhLPXxj (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Dec 2021 18:53:39 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:47206 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbhLPXxj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Dec 2021 18:53:39 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4D7EA212C8;
        Thu, 16 Dec 2021 23:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639698818; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uJLgBSr+4ac2HtnFPf6KLC0wSgPyRK3wpQcub+LxsjE=;
        b=B5BZGrGhS1sLx+jn04Rr1MuE1ChyurPGtdI+nwDT/Hr/0+QXFKuZRtGCvuCRNoIkwlwyKP
        9BfV/qhMuMbcQqDMBat4fq1Wo0xQWckKo0jCjlYNMmPl0tfn2JBp9hUPp/dnjydtCifmiB
        8RRyHATryW0Fh+YgaDAS7VV2qTL3pAI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639698818;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uJLgBSr+4ac2HtnFPf6KLC0wSgPyRK3wpQcub+LxsjE=;
        b=+QQyfMGX2CvZGYolzHHLcWwYdfeq3Mk7+x940MXnO+mysULhS3FXrt8AFWVVKGMrMf+WAT
        O4p/XR+Idp/HN7CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 564E413EFD;
        Thu, 16 Dec 2021 23:53:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id qkUhBX/Ru2GpWwAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 16 Dec 2021 23:53:35 +0000
Subject: [PATCH 11/18] SUNRPC/call_alloc: async tasks mustn't block waiting
 for memory
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
Message-ID: <163969850317.20885.3872948365489724355.stgit@noble.brown>
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
on the minimum one rpciod thread to be able to handle everything.
So it must not block waiting for memory.

mempools are particularly a problem as memory can only be released back
to the mempool by an async rpc task running.  If all available
workqueue threads are waiting on the mempool, no thread is available to
return anything.

rpc_malloc() can block, and this might cause deadlocks.
So check RPC_IS_ASYNC(), rather than RPC_IS_SWAPPER() to determine if
blocking is acceptable.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 net/sunrpc/sched.c              |    4 +++-
 net/sunrpc/xprtrdma/transport.c |    4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index e2c835482791..d5b6e897f5a5 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -1023,8 +1023,10 @@ int rpc_malloc(struct rpc_task *task)
 	struct rpc_buffer *buf;
 	gfp_t gfp = GFP_NOFS;
 
+	if (RPC_IS_ASYNC(task))
+		gfp = GFP_NOWAIT | __GFP_NOWARN;
 	if (RPC_IS_SWAPPER(task))
-		gfp = __GFP_MEMALLOC | GFP_NOWAIT | __GFP_NOWARN;
+		gfp |= __GFP_MEMALLOC;
 
 	size += sizeof(struct rpc_buffer);
 	if (size <= RPC_BUFFER_MAXSIZE)
diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 16e5696314a4..a52277115500 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -574,8 +574,10 @@ xprt_rdma_allocate(struct rpc_task *task)
 	gfp_t flags;
 
 	flags = RPCRDMA_DEF_GFP;
+	if (RPC_IS_ASYNC(task))
+		flags = GFP_NOWAIT | __GFP_NOWARN;
 	if (RPC_IS_SWAPPER(task))
-		flags = __GFP_MEMALLOC | GFP_NOWAIT | __GFP_NOWARN;
+		flags |= __GFP_MEMALLOC;
 
 	if (!rpcrdma_check_regbuf(r_xprt, req->rl_sendbuf, rqst->rq_callsize,
 				  flags))


