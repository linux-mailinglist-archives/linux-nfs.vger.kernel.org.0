Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428A1792820
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Sep 2023 18:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjIEQF2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 5 Sep 2023 12:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244977AbjIEBkw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 4 Sep 2023 21:40:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7137CC5
        for <linux-nfs@vger.kernel.org>; Mon,  4 Sep 2023 18:40:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 82D7C21850;
        Tue,  5 Sep 2023 01:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693878047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VjccyfIbUBpHg120mqmn5EIK1r/ysxaJ5q/b2jkUkkQ=;
        b=P6dVW/2dmSMNm3QXHK/wnEPpz2AbqT+F08pEsd12DGNfx22ZEPRsXqAG/8Xt0zXBQGlxDq
        04k6Fw6wu3FXOX7vfU9Vf0B5Z8WNOAZjVGJBTsKXfKCEPLWRg3BOZyDSYkwrkT0I3Byse/
        lHOAOcGyS4LNn4R9YXK3BReiXUU8Fsc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693878047;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VjccyfIbUBpHg120mqmn5EIK1r/ysxaJ5q/b2jkUkkQ=;
        b=2JyT9v1Y+if9sgNFDHuS1lAAvnZn50XoxMZWXfOoGVGJoKi245Au9ifVBzh+8vdBF6shqu
        u/w2QfeptURgLgDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 47A9213499;
        Tue,  5 Sep 2023 01:40:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id q9b0Oh2H9mSuUwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 05 Sep 2023 01:40:45 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 2/3] SUNRPC: rename some functions from rqst_ to svc_thread_
Date:   Tue,  5 Sep 2023 11:38:12 +1000
Message-ID: <20230905014011.25472-3-neilb@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230905014011.25472-1-neilb@suse.de>
References: <20230905014011.25472-1-neilb@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Functions which directly manipulate a 'struct rqst', such as
svc_rqst_alloc() or svc_rqst_release_pages(), can reasonably
have "rqst" in there name.
However functions that act on the running thread, such as
XX_should_sleep() or XX_wait_for_work() should seem more
natural with a "svc_thread_" prefix.

So make those changes.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 net/sunrpc/svc_xprt.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 17c43bde35c9..1b300a7889eb 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -699,7 +699,7 @@ static bool svc_alloc_arg(struct svc_rqst *rqstp)
 }
 
 static bool
-rqst_should_sleep(struct svc_rqst *rqstp)
+svc_thread_should_sleep(struct svc_rqst *rqstp)
 {
 	struct svc_pool		*pool = rqstp->rq_pool;
 
@@ -725,15 +725,15 @@ rqst_should_sleep(struct svc_rqst *rqstp)
 	return true;
 }
 
-static void svc_rqst_wait_for_work(struct svc_rqst *rqstp)
+static void svc_thread_wait_for_work(struct svc_rqst *rqstp)
 {
 	struct svc_pool *pool = rqstp->rq_pool;
 
-	if (rqst_should_sleep(rqstp)) {
+	if (svc_thread_should_sleep(rqstp)) {
 		set_current_state(TASK_IDLE | TASK_FREEZABLE);
 		llist_add(&rqstp->rq_idle, &pool->sp_idle_threads);
 
-		if (unlikely(!rqst_should_sleep(rqstp)))
+		if (unlikely(!svc_thread_should_sleep(rqstp)))
 			/* Work just became available.  This thread cannot simply
 			 * choose not to sleep as it *must* wait until removed.
 			 * So wake the first waiter - whether it is this
@@ -850,7 +850,7 @@ void svc_recv(struct svc_rqst *rqstp)
 	if (!svc_alloc_arg(rqstp))
 		return;
 
-	svc_rqst_wait_for_work(rqstp);
+	svc_thread_wait_for_work(rqstp);
 
 	clear_bit(SP_TASK_PENDING, &pool->sp_flags);
 
-- 
2.41.0

