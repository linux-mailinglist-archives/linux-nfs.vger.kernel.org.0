Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3D875746D
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jul 2023 08:39:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbjGRGjU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Jul 2023 02:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjGRGjR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Jul 2023 02:39:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83213198
        for <linux-nfs@vger.kernel.org>; Mon, 17 Jul 2023 23:39:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 3E6E62197F;
        Tue, 18 Jul 2023 06:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689662355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/t/y/epzgmGxfN8+0Nclw0tUxGKxQ6msbvf5pN6rITY=;
        b=KT1iROBxlr0NZRiLk45c56E2Vj5nGQQJbSFqCiyo/96bzNx1gmuRwAd8nCs5opgPgTkZf7
        l57GX7cxVE9sdTs7ZZddMhHJliJzrw8Vn9DDats/RuYeEI1jOcj4yb8WA3GPuu4K829gAj
        FROkT/XpWt1SHZH23P4Imp4jxYOm/ig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689662355;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/t/y/epzgmGxfN8+0Nclw0tUxGKxQ6msbvf5pN6rITY=;
        b=N0dtvTE0YJ1eC1B/YzzkfW0daALG9zpi1nhqkKWE1M0x5KAP0DGkqFKR//AhKRb5tIceXh
        WMRgZ3Wk1kWC3cCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D2C4213494;
        Tue, 18 Jul 2023 06:39:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oKYVIZEztmRBDAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 18 Jul 2023 06:39:13 +0000
Subject: [PATCH 03/14] SUNRPC: call svc_process() from svc_recv().
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 18 Jul 2023 16:38:08 +1000
Message-ID: <168966228861.11075.6512110736168003985.stgit@noble.brown>
In-Reply-To: <168966227838.11075.2974227708495338626.stgit@noble.brown>
References: <168966227838.11075.2974227708495338626.stgit@noble.brown>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

All callers of svc_recv() go on to call svc_process() on success.
Simplify callers by having svc_recv() do that for them.

This loses one call to validate_process_creds() in nfsd.  That was
debugging code added 14 years ago.  I don't think we need to keep it.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/lockd/svc.c        |    5 -----
 fs/nfs/callback.c     |    1 -
 fs/nfsd/nfssvc.c      |    2 --
 net/sunrpc/svc_xprt.c |    3 ++-
 4 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 614faa5f69cd..91ef139a7757 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -132,7 +132,6 @@ lockd(void *vrqstp)
 	 */
 	while (!kthread_should_stop()) {
 		long timeout = MAX_SCHEDULE_TIMEOUT;
-		RPC_IFDEBUG(char buf[RPC_MAX_ADDRBUFLEN]);
 
 		/* update sv_maxconn if it has changed */
 		rqstp->rq_server->sv_maxconn = nlm_max_connections;
@@ -146,10 +145,6 @@ lockd(void *vrqstp)
 		err = svc_recv(rqstp, timeout);
 		if (err == -EAGAIN || err == -EINTR)
 			continue;
-		dprintk("lockd: request from %s\n",
-				svc_print_addr(rqstp, buf, sizeof(buf)));
-
-		svc_process(rqstp);
 	}
 	if (nlmsvc_ops)
 		nlmsvc_invalidate_all();
diff --git a/fs/nfs/callback.c b/fs/nfs/callback.c
index 46a0a2d6962e..2d94384bd6a9 100644
--- a/fs/nfs/callback.c
+++ b/fs/nfs/callback.c
@@ -86,7 +86,6 @@ nfs4_callback_svc(void *vrqstp)
 		err = svc_recv(rqstp, MAX_SCHEDULE_TIMEOUT);
 		if (err == -EAGAIN || err == -EINTR)
 			continue;
-		svc_process(rqstp);
 	}
 
 	svc_exit_thread(rqstp);
diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 439fca195925..3e08cc746870 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -985,8 +985,6 @@ nfsd(void *vrqstp)
 		if (err == -EINTR)
 			break;
 		validate_process_creds();
-		svc_process(rqstp);
-		validate_process_creds();
 	}
 
 	atomic_dec(&nfsdstats.th_cnt);
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 93395606a0ba..c808f6d60c99 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -895,7 +895,8 @@ int svc_recv(struct svc_rqst *rqstp, long timeout)
 		serv->sv_stats->netcnt++;
 	percpu_counter_inc(&rqstp->rq_pool->sp_messages_arrived);
 	rqstp->rq_stime = ktime_get();
-	return len;
+	svc_process(rqstp);
+	return 0;
 out_release:
 	rqstp->rq_res.len = 0;
 	svc_xprt_release(rqstp);


