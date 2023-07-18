Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2524757461
	for <lists+linux-nfs@lfdr.de>; Tue, 18 Jul 2023 08:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjGRGjK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 18 Jul 2023 02:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjGRGjI (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 18 Jul 2023 02:39:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2541B1
        for <linux-nfs@vger.kernel.org>; Mon, 17 Jul 2023 23:39:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 4ACBD1FDBC;
        Tue, 18 Jul 2023 06:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689662345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rWCEP/Mc5gojphRKRm4FHtda4qY/sWmT7/WQI2pi3JY=;
        b=yodBiJR5ZbNz6eoem7bgtu/6k5onBxhKs5GtU+TT80pCROHvgqAY+Jv7JDb9Gz/jPzWA7l
        8kYGVFCJ0lLzt1znojtoh2lo2YdxuQ21ty9Vk/1vQHmk1RuCNiEsBJ68uxBz0qOzNMENX0
        d+lJotJxjNTgq4fgXrfsNB0GI94M7WQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689662345;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rWCEP/Mc5gojphRKRm4FHtda4qY/sWmT7/WQI2pi3JY=;
        b=Ei+rBEUoH+g0Nd9NYEg5hWWe8BpZ7KlEts0SDVZA6whZdnt709cHQPr1btOJBV9Xek98iX
        aErOze4ktU55J+CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 093DF13494;
        Tue, 18 Jul 2023 06:39:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id SIBiK4cztmQjDAAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 18 Jul 2023 06:39:03 +0000
Subject: [PATCH 01/14] lockd: remove SIGKILL handling.
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Date:   Tue, 18 Jul 2023 16:38:08 +1000
Message-ID: <168966228859.11075.13570585046156408745.stgit@noble.brown>
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

lockd allows SIGKILL and responds by dropping all locks and restarting
the grace period.  This functionality has been present since 2.1.32 when
lockd was added to Linux.

This functionality is undocumented and most liked added as a useful
debug aid.  When there is a need to drop locks, the best approach is
using /proc/fs/nfsd/unlock_*.

This patch removes the handling of SIGKILL as part of preparation for
removing all signal handling from sunrpc service threads.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/lockd/svc.c |   24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/fs/lockd/svc.c b/fs/lockd/svc.c
index 22d3ff3818f5..614faa5f69cd 100644
--- a/fs/lockd/svc.c
+++ b/fs/lockd/svc.c
@@ -45,7 +45,6 @@
 
 #define NLMDBG_FACILITY		NLMDBG_SVC
 #define LOCKD_BUFSIZE		(1024 + NLMSVC_XDRSIZE)
-#define ALLOWED_SIGS		(sigmask(SIGKILL))
 
 static struct svc_program	nlmsvc_program;
 
@@ -111,19 +110,6 @@ static void set_grace_period(struct net *net)
 	schedule_delayed_work(&ln->grace_period_end, grace_period);
 }
 
-static void restart_grace(void)
-{
-	if (nlmsvc_ops) {
-		struct net *net = &init_net;
-		struct lockd_net *ln = net_generic(net, lockd_net_id);
-
-		cancel_delayed_work_sync(&ln->grace_period_end);
-		locks_end_grace(&ln->lockd_manager);
-		nlmsvc_invalidate_all();
-		set_grace_period(net);
-	}
-}
-
 /*
  * This is the lockd kernel thread
  */
@@ -138,9 +124,6 @@ lockd(void *vrqstp)
 	/* try_to_freeze() is called from svc_recv() */
 	set_freezable();
 
-	/* Allow SIGKILL to tell lockd to drop all of its locks */
-	allow_signal(SIGKILL);
-
 	dprintk("NFS locking service started (ver " LOCKD_VERSION ").\n");
 
 	/*
@@ -154,12 +137,6 @@ lockd(void *vrqstp)
 		/* update sv_maxconn if it has changed */
 		rqstp->rq_server->sv_maxconn = nlm_max_connections;
 
-		if (signalled()) {
-			flush_signals(current);
-			restart_grace();
-			continue;
-		}
-
 		timeout = nlmsvc_retry_blocked();
 
 		/*
@@ -174,7 +151,6 @@ lockd(void *vrqstp)
 
 		svc_process(rqstp);
 	}
-	flush_signals(current);
 	if (nlmsvc_ops)
 		nlmsvc_invalidate_all();
 	nlm_shutdown_hosts();


