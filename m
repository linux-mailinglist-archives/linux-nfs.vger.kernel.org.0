Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 979774977E8
	for <lists+linux-nfs@lfdr.de>; Mon, 24 Jan 2022 04:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241241AbiAXDyE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 23 Jan 2022 22:54:04 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:47058 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241240AbiAXDyD (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 23 Jan 2022 22:54:03 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 5F8221F3B1;
        Mon, 24 Jan 2022 03:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1642996442; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Xf0wQNVm3xiMoEph9xuiX0w4MC4SZqJ4flfzelN2po=;
        b=emgzZtjciaKBzXok+isTqdewPHWN8QVhen+0ytn7jFeHei00IfPUvjy2BPRi6mEcVPbUrg
        LXA3vTnrwxGAgVWrpvxuWeZvI5lKlC7rDcIl+GQ7PDhbFYD26jjibZyD3S0Lp08+c56j/I
        /yy/YhrtQMN9noix8Byt2vBiidKJg0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1642996442;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/Xf0wQNVm3xiMoEph9xuiX0w4MC4SZqJ4flfzelN2po=;
        b=GWySUa2k8w9hiuYeo9wTlAVCgAxekBzAAMvelpOsSQucqbJT/OhbX0h7TTSHk95eX3Xwty
        tzzL4VYl83wZLWAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7575913305;
        Mon, 24 Jan 2022 03:53:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id FjM9Ddci7mHNRQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 24 Jan 2022 03:53:59 +0000
Subject: [PATCH 16/23] SUNRPC/auth: async tasks mustn't block waiting for
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
Date:   Mon, 24 Jan 2022 14:48:32 +1100
Message-ID: <164299611283.26253.4389271361333923379.stgit@noble.brown>
In-Reply-To: <164299573337.26253.7538614611220034049.stgit@noble.brown>
References: <164299573337.26253.7538614611220034049.stgit@noble.brown>
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


