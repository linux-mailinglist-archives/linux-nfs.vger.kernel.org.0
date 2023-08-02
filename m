Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1FA276C6FF
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Aug 2023 09:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232925AbjHBHgA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Aug 2023 03:36:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbjHBHf4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Aug 2023 03:35:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2E82102
        for <linux-nfs@vger.kernel.org>; Wed,  2 Aug 2023 00:35:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 75BDA21B1B;
        Wed,  2 Aug 2023 07:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690961728; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eALRzuehsOll+BS4UYRRQTXyePlI3qJ+Cd+V3HXsEHY=;
        b=r3l32c4Dc+lOkaHHZdFKyoCoUNikgezH78rHQJ0MblsTtbTj8Dnp3w+p1sJkQLtE46whG7
        oYJ1sjz2gxbVkvN9XjyJKf7TnBrQo838Iat7NXnx1E0dy8lHLDfsHexsgpiztcwUjl4KAu
        7pNTbbHFlIk0fNz8WBzLBlBt1L5+M2g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690961728;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eALRzuehsOll+BS4UYRRQTXyePlI3qJ+Cd+V3HXsEHY=;
        b=t321cLg04xj+dCn6yE554OZwgLPFxcJHeh6jToowVCuzuZTtjGNCE9YqTz+GW1Uo7g+Ldn
        omelGeUUZ5nVlXBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3489913909;
        Wed,  2 Aug 2023 07:35:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YsPmNT4HymQ8JAAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 02 Aug 2023 07:35:26 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 6/6] SUNRPC: discard SP_CONGESTED
Date:   Wed,  2 Aug 2023 17:34:43 +1000
Message-Id: <20230802073443.17965-7-neilb@suse.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230802073443.17965-1-neilb@suse.de>
References: <20230802073443.17965-1-neilb@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We can tell if a pool is congested by checking if the idle list is
empty.  We don't need a separate flag.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 include/linux/sunrpc/svc.h | 1 -
 net/sunrpc/svc.c           | 1 -
 net/sunrpc/svc_xprt.c      | 4 +---
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 8b93af92dd53..5ea76d432015 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -50,7 +50,6 @@ struct svc_pool {
 /* bits for sp_flags */
 enum {
 	SP_TASK_PENDING,	/* still work to do even if no xprt is queued */
-	SP_CONGESTED,		/* all threads are busy, none idle */
 	SP_NEED_VICTIM,		/* One thread needs to agree to exit */
 	SP_VICTIM_REMAINS,	/* One thread needs to actually exit */
 };
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index dce433dea1bd..5df7b4353320 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -718,7 +718,6 @@ void svc_pool_wake_idle_thread(struct svc_pool *pool)
 	}
 	rcu_read_unlock();
 
-	set_bit(SP_CONGESTED, &pool->sp_flags);
 }
 EXPORT_SYMBOL_GPL(svc_pool_wake_idle_thread);
 
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index e44efcc21b63..dd60e5810cdb 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -735,8 +735,6 @@ static void svc_rqst_wait_for_work(struct svc_rqst *rqstp)
 
 	if (rqst_should_sleep(rqstp)) {
 		set_current_state(TASK_IDLE);
-		smp_mb__before_atomic();
-		clear_bit(SP_CONGESTED, &pool->sp_flags);
 		spin_lock_bh(&pool->sp_lock);
 		list_add(&rqstp->rq_idle, &pool->sp_idle_threads);
 		spin_unlock_bh(&pool->sp_lock);
@@ -873,7 +871,7 @@ void svc_recv(struct svc_rqst *rqstp)
 		/* Normally we will wait up to 5 seconds for any required
 		 * cache information to be provided.
 		 */
-		if (test_bit(SP_CONGESTED, &pool->sp_flags))
+		if (list_empty(&pool->sp_idle_threads))
 			rqstp->rq_chandle.thread_wait = 5 * HZ;
 		else
 			rqstp->rq_chandle.thread_wait = 1 * HZ;
-- 
2.40.1

