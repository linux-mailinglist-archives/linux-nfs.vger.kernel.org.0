Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A2C54AB48C
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Feb 2022 07:16:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244977AbiBGGPx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Feb 2022 01:15:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352075AbiBGEsf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 6 Feb 2022 23:48:35 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622E0C043181;
        Sun,  6 Feb 2022 20:48:35 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CCCD8210E8;
        Mon,  7 Feb 2022 04:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1644209313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ca/QMA9b8aSP2XqDNpzMoh70WOqFOvfMXBDfQmXLg8g=;
        b=g7MhZp92/rnAsaBQF/LBN2grTXpM1lSbRGyvPNrVbdb93Hur/KShishK0kboEEwtuBgXEN
        eV5m3zMF/R1LupwK2CXzQ0u20tEnJ9/jxsjPA8hEJhCJA48lpiq2r6PjIQxxf6AYRjBofP
        Fhn0FQcRrR9S9O3YbkmJ9Fq76of65ME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1644209313;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ca/QMA9b8aSP2XqDNpzMoh70WOqFOvfMXBDfQmXLg8g=;
        b=S7cvC95vxV7Ud1UDWIFO6Oa2myUbnd6qE+5EbMwEIspBQunKCydhhC2WbDtoFc/abo0+oz
        jz1Nwrey9mHimyDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7A6061330E;
        Mon,  7 Feb 2022 04:48:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jU5zDZ6kAGJ/NQAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 07 Feb 2022 04:48:30 +0000
Subject: [PATCH 15/21] SUNRPC: remove scheduling boost for "SWAPPER" tasks.
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
Message-ID: <164420916121.29374.301108979284279934.stgit@noble.brown>
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

Currently, tasks marked as "swapper" tasks get put to the front of
non-priority rpc_queues, and are sorted earlier than non-swapper tasks on
the transport's ->xmit_queue.

This is pointless as currently *all* tasks for a mount that has swap
enabled on *any* file are marked as "swapper" tasks.  So the net result
is that the non-priority rpc_queues are reverse-ordered (LIFO).

This scheduling boost is not necessary to avoid deadlocks, and hurts
fairness, so remove it.  If there were a need to expedite some requests,
the tk_priority mechanism is a more appropriate tool.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 net/sunrpc/sched.c |    7 -------
 net/sunrpc/xprt.c  |   11 -----------
 2 files changed, 18 deletions(-)

diff --git a/net/sunrpc/sched.c b/net/sunrpc/sched.c
index d5b6e897f5a5..256302bf6557 100644
--- a/net/sunrpc/sched.c
+++ b/net/sunrpc/sched.c
@@ -186,11 +186,6 @@ static void __rpc_add_wait_queue_priority(struct rpc_wait_queue *queue,
 
 /*
  * Add new request to wait queue.
- *
- * Swapper tasks always get inserted at the head of the queue.
- * This should avoid many nasty memory deadlocks and hopefully
- * improve overall performance.
- * Everyone else gets appended to the queue to ensure proper FIFO behavior.
  */
 static void __rpc_add_wait_queue(struct rpc_wait_queue *queue,
 		struct rpc_task *task,
@@ -199,8 +194,6 @@ static void __rpc_add_wait_queue(struct rpc_wait_queue *queue,
 	INIT_LIST_HEAD(&task->u.tk_wait.timer_list);
 	if (RPC_IS_PRIORITY(queue))
 		__rpc_add_wait_queue_priority(queue, task, queue_priority);
-	else if (RPC_IS_SWAPPER(task))
-		list_add(&task->u.tk_wait.list, &queue->tasks[0]);
 	else
 		list_add_tail(&task->u.tk_wait.list, &queue->tasks[0]);
 	task->tk_waitqueue = queue;
diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index 47d207e416ab..a0a2583fe941 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -1354,17 +1354,6 @@ xprt_request_enqueue_transmit(struct rpc_task *task)
 				INIT_LIST_HEAD(&req->rq_xmit2);
 				goto out;
 			}
-		} else if (RPC_IS_SWAPPER(task)) {
-			list_for_each_entry(pos, &xprt->xmit_queue, rq_xmit) {
-				if (pos->rq_cong || pos->rq_bytes_sent)
-					continue;
-				if (RPC_IS_SWAPPER(pos->rq_task))
-					continue;
-				/* Note: req is added _before_ pos */
-				list_add_tail(&req->rq_xmit, &pos->rq_xmit);
-				INIT_LIST_HEAD(&req->rq_xmit2);
-				goto out;
-			}
 		} else if (!req->rq_seqno) {
 			list_for_each_entry(pos, &xprt->xmit_queue, rq_xmit) {
 				if (pos->rq_task->tk_owner != task->tk_owner)


