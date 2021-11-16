Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33B9145280B
	for <lists+linux-nfs@lfdr.de>; Tue, 16 Nov 2021 03:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241062AbhKPCxV (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 15 Nov 2021 21:53:21 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:59422 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348326AbhKPCt2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 15 Nov 2021 21:49:28 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B358C2193C;
        Tue, 16 Nov 2021 02:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1637030788; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wO0r1Q1BLtXip2CPbwTG/6Ut5fpHeAZt8oAWaKb7z2w=;
        b=IWtnEJbvd8DYW2oMcEU1fczbOAygAipGuytwF6nHbM20wr4CgabUm8RW5VRkYvt81lKZNZ
        VUmTwkY1Jpfr7RLnbkSCtjlVGfa0Jqw1yn/udGEQl6NLlI5YgwC/Foc2wtnGgIE7u9qZZU
        XPQorHS+Lwos+3IA3DXJ3prh6EDzGQU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1637030788;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wO0r1Q1BLtXip2CPbwTG/6Ut5fpHeAZt8oAWaKb7z2w=;
        b=t4Eg3yrplfyW5VHY+J42FbZmmLbrJOjEWLmzylPbexKrTngyeE9Gr+i7ja0CSR+r5Tq+g0
        8rq6txu++cKV+NAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5E21E13B70;
        Tue, 16 Nov 2021 02:46:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id H8SxB4Ibk2EHCQAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 16 Nov 2021 02:46:26 +0000
Subject: [PATCH 08/13] NFS: discard NFS_RPC_SWAPFLAGS and RPC_TASK_ROOTCREDS
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>
Cc:     linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 16 Nov 2021 13:44:04 +1100
Message-ID: <163703064455.25805.7846689888578353600.stgit@noble.brown>
In-Reply-To: <163702956672.25805.16457749992977493579.stgit@noble.brown>
References: <163702956672.25805.16457749992977493579.stgit@noble.brown>
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
index 05f249f20f55..5a605e51f4b1 100644
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


