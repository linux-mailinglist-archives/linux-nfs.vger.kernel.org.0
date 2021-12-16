Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE0134780F6
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Dec 2021 00:54:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhLPXyL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 16 Dec 2021 18:54:11 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:47258 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbhLPXyK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 16 Dec 2021 18:54:10 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id BB5B42111A;
        Thu, 16 Dec 2021 23:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639698849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CDOSHbb3cCHR/Wvsf3Dv/Q3+pqM/Z1sApkeWL3yPdmA=;
        b=iZeNAv29PjQn6MX3D30qEOwbbGRbKdljvGl7O2FDh/D1Ag/7JsP/cNzRO8ED1jhDtvylBz
        1BR6p151QwShGB5UAXtTFlx7nME3ze7DAxBS964FzJCfwjplb3UmVzILM3jHwMnSkT7ddN
        vY1HFMPXTPsVRa9Wv6KIxwlcodTSXyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639698849;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CDOSHbb3cCHR/Wvsf3Dv/Q3+pqM/Z1sApkeWL3yPdmA=;
        b=R9FXTSaA1m7h0cmZRDVZmblZ/AwfUnuQZJZKPm6EJ960BqMU94yab6AoBrD6cPJnUX3h64
        S8cvKTw5ET5ojfDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A0B0713EFD;
        Thu, 16 Dec 2021 23:54:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id tzqYFp7Ru2HNWwAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 16 Dec 2021 23:54:06 +0000
Subject: [PATCH 15/18] NFS: discard NFS_RPC_SWAPFLAGS and RPC_TASK_ROOTCREDS
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
Message-ID: <163969850333.20885.17464715871688147966.stgit@noble.brown>
In-Reply-To: <163969801519.20885.3977673503103544412.stgit@noble.brown>
References: <163969801519.20885.3977673503103544412.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

NFS_RPC_SWAPFLAGS is only used for READ requests.
It sets RPC_TASK_SWAPPER which gives some memory-allocation priority to
requests.  This is not needed for swap READ - though it is for writes
where it is set via a different mechanism.

RPC_TASK_ROOTCREDS causes the 'machine' credential to be used.
This is not needed as the root credential is saved when the swap file is
opened, and this is used for all IO.

So NFS_RPC_SWAPFLAGS isn't needed, and as it is the only user of
RPC_TASK_ROOTCREDS, that isn't needed either.

Remove both.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfs/read.c                 |    4 ----
 include/linux/nfs_fs.h        |    5 -----
 include/linux/sunrpc/sched.h  |    1 -
 include/trace/events/sunrpc.h |    1 -
 net/sunrpc/auth.c             |    2 +-
 5 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/fs/nfs/read.c b/fs/nfs/read.c
index d11af2a9299c..a8f2b884306c 100644
--- a/fs/nfs/read.c
+++ b/fs/nfs/read.c
@@ -194,10 +194,6 @@ static void nfs_initiate_read(struct nfs_pgio_header *hdr,
 			      const struct nfs_rpc_ops *rpc_ops,
 			      struct rpc_task_setup *task_setup_data, int how)
 {
-	struct inode *inode = hdr->inode;
-	int swap_flags = IS_SWAPFILE(inode) ? NFS_RPC_SWAPFLAGS : 0;
-
-	task_setup_data->flags |= swap_flags;
 	rpc_ops->read_setup(hdr, msg);
 	trace_nfs_initiate_read(hdr);
 }
diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
index 3a210478f665..5dce9129fe64 100644
--- a/include/linux/nfs_fs.h
+++ b/include/linux/nfs_fs.h
@@ -45,11 +45,6 @@
  */
 #define NFS_MAX_TRANSPORTS 16
 
-/*
- * These are the default flags for swap requests
- */
-#define NFS_RPC_SWAPFLAGS		(RPC_TASK_SWAPPER|RPC_TASK_ROOTCREDS)
-
 /*
  * Size of the NFS directory verifier
  */
diff --git a/include/linux/sunrpc/sched.h b/include/linux/sunrpc/sched.h
index db964bb63912..56710f8056d3 100644
--- a/include/linux/sunrpc/sched.h
+++ b/include/linux/sunrpc/sched.h
@@ -124,7 +124,6 @@ struct rpc_task_setup {
 #define RPC_TASK_MOVEABLE	0x0004		/* nfs4.1+ rpc tasks */
 #define RPC_TASK_NULLCREDS	0x0010		/* Use AUTH_NULL credential */
 #define RPC_CALL_MAJORSEEN	0x0020		/* major timeout seen */
-#define RPC_TASK_ROOTCREDS	0x0040		/* force root creds */
 #define RPC_TASK_DYNAMIC	0x0080		/* task was kmalloc'ed */
 #define	RPC_TASK_NO_ROUND_ROBIN	0x0100		/* send requests on "main" xprt */
 #define RPC_TASK_SOFT		0x0200		/* Use soft timeouts */
diff --git a/include/trace/events/sunrpc.h b/include/trace/events/sunrpc.h
index 3a99358c262b..141dc34a450e 100644
--- a/include/trace/events/sunrpc.h
+++ b/include/trace/events/sunrpc.h
@@ -311,7 +311,6 @@ TRACE_EVENT(rpc_request,
 		{ RPC_TASK_MOVEABLE, "MOVEABLE" },			\
 		{ RPC_TASK_NULLCREDS, "NULLCREDS" },			\
 		{ RPC_CALL_MAJORSEEN, "MAJORSEEN" },			\
-		{ RPC_TASK_ROOTCREDS, "ROOTCREDS" },			\
 		{ RPC_TASK_DYNAMIC, "DYNAMIC" },			\
 		{ RPC_TASK_NO_ROUND_ROBIN, "NO_ROUND_ROBIN" },		\
 		{ RPC_TASK_SOFT, "SOFT" },				\
diff --git a/net/sunrpc/auth.c b/net/sunrpc/auth.c
index 6bfa19f9fa6a..682fcd24bf43 100644
--- a/net/sunrpc/auth.c
+++ b/net/sunrpc/auth.c
@@ -670,7 +670,7 @@ rpcauth_bindcred(struct rpc_task *task, const struct cred *cred, int flags)
 	/* If machine cred couldn't be bound, try a root cred */
 	if (new)
 		;
-	else if (cred == &machine_cred || (flags & RPC_TASK_ROOTCREDS))
+	else if (cred == &machine_cred)
 		new = rpcauth_bind_root_cred(task, lookupflags);
 	else if (flags & RPC_TASK_NULLCREDS)
 		new = authnull_ops.lookup_cred(NULL, NULL, 0);


