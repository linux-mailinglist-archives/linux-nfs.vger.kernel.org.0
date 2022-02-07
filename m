Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715024AB48F
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Feb 2022 07:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346934AbiBGGPz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Feb 2022 01:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352076AbiBGEsn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 6 Feb 2022 23:48:43 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A818C043181;
        Sun,  6 Feb 2022 20:48:42 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2472B1F37E;
        Mon,  7 Feb 2022 04:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644209321; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=abp/o94+2rJ4ao5gU5Y3VRhEK9AxXE9gpElUGz0LzVk=;
        b=CCn6rwGgP1ohSmx2GAqIuYP8+Qj6wqy0px0oekO6styNpRvwCtVHm+LgMww7xKi0dZxr33
        F9KVX5dJGAHKxI8KHRFoW/9WEqDbubyDmE97JuSIsq374hFBq9bgFNGw7hHp+kM2IV8b6V
        v8ETLUb5TzNyIoMihm1YrQCqDarH5TE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644209321;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=abp/o94+2rJ4ao5gU5Y3VRhEK9AxXE9gpElUGz0LzVk=;
        b=zX3qPGqzKSp/jTG3hChxzUyM+Yu2Mr9oyUJcRa20dUWYAXy1z0gdUFudbbOcKK+2H6ZalB
        KkALKn9wZTiQL3CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 47EF01330E;
        Mon,  7 Feb 2022 04:48:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id HcYZAaWkAGKHNQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 07 Feb 2022 04:48:37 +0000
Subject: [PATCH 16/21] NFS: discard NFS_RPC_SWAPFLAGS and RPC_TASK_ROOTCREDS
From:   NeilBrown <neilb@suse.de>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Hemment <markhemm@googlemail.com>,
        Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>
Cc:     linux-nfs@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 07 Feb 2022 15:46:01 +1100
Message-ID: <164420916121.29374.12391432623392264427.stgit@noble.brown>
In-Reply-To: <164420889455.29374.17958998143835612560.stgit@noble.brown>
References: <164420889455.29374.17958998143835612560.stgit@noble.brown>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index eb00229c1a50..cd797ce3a67c 100644
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
index 02aa49323d1d..ff8b3820409c 100644
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
index 29982d60b68a..ac33892da411 100644
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


