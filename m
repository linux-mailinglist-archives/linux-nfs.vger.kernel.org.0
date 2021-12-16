Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC124780F0
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Dec 2021 00:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbhLPXxq (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Dec 2021 18:53:46 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:47236 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhLPXxq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Dec 2021 18:53:46 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 21B742111A;
        Thu, 16 Dec 2021 23:53:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639698825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Xf0wQNVm3xiMoEph9xuiX0w4MC4SZqJ4flfzelN2po=;
        b=HvkZQeCMFZCPSVQFUK/PUY7B7v+NLZpUF/m3Yj4xJKsbEa2leGoz9gqvwpHJBag+WefWI6
        0VBcdl08xnIcY9vXn22pP/IeYzRGO28wyAsDZqf87G24s8KrbkeUDwXMNDYgmtPjvbHcDh
        qpdO8NC1Q9cEMZN1/U1R1NMXfhuVzC0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639698825;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Xf0wQNVm3xiMoEph9xuiX0w4MC4SZqJ4flfzelN2po=;
        b=vZy0FnDUXHJwQKOG4m/0/p1GY8oOwPXQ5ScsZz3bmlnHvp6t/QmB/UuBmIoCdt7YEvO6Gw
        uqEETfQGhz4AvEAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2C84913EFD;
        Thu, 16 Dec 2021 23:53:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RrWdNoXRu2GtWwAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 16 Dec 2021 23:53:41 +0000
Subject: [PATCH 12/18] SUNRPC/auth: async tasks mustn't block waiting for
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
Message-ID: <163969850320.20885.16756746953092069326.stgit@noble.brown>
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

mempools are particularly a problem as memory can only be released back
to the mempool by an async rpc task running.  If all available workqueue
threads are waiting on the mempool, no thread is available to return
anything.

lookup_cred() can block on a mempool or kmalloc - and this can cause
deadlocks.  So add a new RPCAUTH_LOOKUP flag for async lookups and don't
block on memory.  If the -ENOMEM gets back to call_refreshresult(), wait
a short while and try again.  HZ>>4 is chosen as it is used elsewhere
for -ENOMEM retries.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 include/linux/sunrpc/auth.h    |    1 +
 net/sunrpc/auth.c              |    6 +++++-
 net/sunrpc/auth_gss/auth_gss.c |    6 +++++-
 net/sunrpc/auth_unix.c         |   10 ++++++++--
 net/sunrpc/clnt.c              |    3 +++
 5 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/include/linux/sunrpc/auth.h b/include/linux/sunrpc/auth.h
index 98da816b5fc2..3e6ce288a7fc 100644
--- a/include/linux/sunrpc/auth.h
+++ b/include/linux/sunrpc/auth.h
@@ -99,6 +99,7 @@ struct rpc_auth_create_args {
 
 /* Flags for rpcauth_lookupcred() */
 #define RPCAUTH_LOOKUP_NEW		0x01	/* Accept an uninitialised cred */
+#define RPCAUTH_LOOKUP_ASYNC		0x02	/* Don't block waiting for memory */
 
 /*
  * Client authentication ops
diff --git a/net/sunrpc/auth.c b/net/sunrpc/auth.c
index a9f0d17fdb0d..6bfa19f9fa6a 100644
--- a/net/sunrpc/auth.c
+++ b/net/sunrpc/auth.c
@@ -615,6 +615,8 @@ rpcauth_bind_root_cred(struct rpc_task *task, int lookupflags)
 	};
 	struct rpc_cred *ret;
 
+	if (RPC_IS_ASYNC(task))
+		lookupflags |= RPCAUTH_LOOKUP_ASYNC;
 	ret = auth->au_ops->lookup_cred(auth, &acred, lookupflags);
 	put_cred(acred.cred);
 	return ret;
@@ -631,6 +633,8 @@ rpcauth_bind_machine_cred(struct rpc_task *task, int lookupflags)
 
 	if (!acred.principal)
 		return NULL;
+	if (RPC_IS_ASYNC(task))
+		lookupflags |= RPCAUTH_LOOKUP_ASYNC;
 	return auth->au_ops->lookup_cred(auth, &acred, lookupflags);
 }
 
@@ -654,7 +658,7 @@ rpcauth_bindcred(struct rpc_task *task, const struct cred *cred, int flags)
 	};
 
 	if (flags & RPC_TASK_ASYNC)
-		lookupflags |= RPCAUTH_LOOKUP_NEW;
+		lookupflags |= RPCAUTH_LOOKUP_NEW | RPCAUTH_LOOKUP_ASYNC;
 	if (task->tk_op_cred)
 		/* Task must use exactly this rpc_cred */
 		new = get_rpccred(task->tk_op_cred);
diff --git a/net/sunrpc/auth_gss/auth_gss.c b/net/sunrpc/auth_gss/auth_gss.c
index 5f42aa5fc612..df72d6301f78 100644
--- a/net/sunrpc/auth_gss/auth_gss.c
+++ b/net/sunrpc/auth_gss/auth_gss.c
@@ -1341,7 +1341,11 @@ gss_hash_cred(struct auth_cred *acred, unsigned int hashbits)
 static struct rpc_cred *
 gss_lookup_cred(struct rpc_auth *auth, struct auth_cred *acred, int flags)
 {
-	return rpcauth_lookup_credcache(auth, acred, flags, GFP_NOFS);
+	gfp_t gfp = GFP_NOFS;
+
+	if (flags & RPCAUTH_LOOKUP_ASYNC)
+		gfp = GFP_NOWAIT | __GFP_NOWARN;
+	return rpcauth_lookup_credcache(auth, acred, flags, gfp);
 }
 
 static struct rpc_cred *
diff --git a/net/sunrpc/auth_unix.c b/net/sunrpc/auth_unix.c
index e7df1f782b2e..e5819265dd1b 100644
--- a/net/sunrpc/auth_unix.c
+++ b/net/sunrpc/auth_unix.c
@@ -43,8 +43,14 @@ unx_destroy(struct rpc_auth *auth)
 static struct rpc_cred *
 unx_lookup_cred(struct rpc_auth *auth, struct auth_cred *acred, int flags)
 {
-	struct rpc_cred *ret = mempool_alloc(unix_pool, GFP_NOFS);
-
+	gfp_t gfp = GFP_NOFS;
+	struct rpc_cred *ret;
+
+	if (flags & RPCAUTH_LOOKUP_ASYNC)
+		gfp = GFP_NOWAIT | __GFP_NOWARN;
+	ret = mempool_alloc(unix_pool, gfp);
+	if (!ret)
+		return ERR_PTR(-ENOMEM);
 	rpcauth_init_cred(ret, acred, auth, &unix_credops);
 	ret->cr_flags = 1UL << RPCAUTH_CRED_UPTODATE;
 	return ret;
diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index a312ea2bc440..238b2ef5491f 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1745,6 +1745,9 @@ call_refreshresult(struct rpc_task *task)
 		task->tk_cred_retry--;
 		trace_rpc_retry_refresh_status(task);
 		return;
+	case -ENOMEM:
+		rpc_delay(task, HZ >> 4);
+		return;
 	}
 	trace_rpc_refresh_status(task);
 	rpc_call_rpcerror(task, status);


