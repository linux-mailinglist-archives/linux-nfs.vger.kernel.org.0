Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28BF0768C4F
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Jul 2023 08:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjGaGvp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Jul 2023 02:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjGaGvn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Jul 2023 02:51:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E561709
        for <linux-nfs@vger.kernel.org>; Sun, 30 Jul 2023 23:51:23 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 62D971F88C;
        Mon, 31 Jul 2023 06:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690786281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tm4I1cU2Bef8+Vmqf8zC97krbDEoxZLnPbol2gQK1yU=;
        b=Y/0FrLiYvvx4Np0SQrQKM/juY5cSgiE0f2lxOWuU5ANCGg7pM4zbfqlbYieCQNjvoXlC5V
        Jc+sWOhgi8K8VB9z9H2ZMH8ZUdJqlYdSGtQUZLJEARgnq+AdY2dQdXoCYq/cd2V8ZvBiBT
        FUJVXQOuurMhv347THCxK1DLmn0SuUU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690786281;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tm4I1cU2Bef8+Vmqf8zC97krbDEoxZLnPbol2gQK1yU=;
        b=yettwyUgXzfw8h+/lPtxAfjpbTcLlciSKyrAAAuWD/hFnhAquNt6YJ1TSz5Q/hb/XN90pT
        A97QfeEP7rebkMDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 202681322C;
        Mon, 31 Jul 2023 06:51:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0vjqMOdZx2SObwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 31 Jul 2023 06:51:19 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 01/12] SUNRPC: make rqst_should_sleep() idempotent()
Date:   Mon, 31 Jul 2023 16:48:28 +1000
Message-Id: <20230731064839.7729-2-neilb@suse.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230731064839.7729-1-neilb@suse.de>
References: <20230731064839.7729-1-neilb@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Based on its name you would think that rqst_should_sleep() would be
read-only, not changing anything.  But it fact it will clear
SP_TASK_PENDING if that was set.  This is surprising, and it blurs the
line between "check for work to do" and "dequeue work to do".

So change the "test_and_clear" to simple "test" and clear the bit once
the thread has decided to wake up and return to the caller.

With this, it makes sense to *always* set SP_TASK_PENDING when asked,
rather than only to set it if no thread could be woken up.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 net/sunrpc/svc_xprt.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index cd92cb54132d..380fb3caea4c 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -581,8 +581,8 @@ void svc_wake_up(struct svc_serv *serv)
 {
 	struct svc_pool *pool = &serv->sv_pools[0];
 
-	if (!svc_pool_wake_idle_thread(serv, pool))
-		set_bit(SP_TASK_PENDING, &pool->sp_flags);
+	set_bit(SP_TASK_PENDING, &pool->sp_flags);
+	svc_pool_wake_idle_thread(serv, pool);
 }
 EXPORT_SYMBOL_GPL(svc_wake_up);
 
@@ -704,7 +704,7 @@ rqst_should_sleep(struct svc_rqst *rqstp)
 	struct svc_pool		*pool = rqstp->rq_pool;
 
 	/* did someone call svc_wake_up? */
-	if (test_and_clear_bit(SP_TASK_PENDING, &pool->sp_flags))
+	if (test_bit(SP_TASK_PENDING, &pool->sp_flags))
 		return false;
 
 	/* was a socket queued? */
@@ -750,6 +750,7 @@ static struct svc_xprt *svc_get_next_xprt(struct svc_rqst *rqstp)
 
 	set_bit(RQ_BUSY, &rqstp->rq_flags);
 	smp_mb__after_atomic();
+	clear_bit(SP_TASK_PENDING, &pool->sp_flags);
 	rqstp->rq_xprt = svc_xprt_dequeue(pool);
 	if (rqstp->rq_xprt) {
 		trace_svc_pool_awoken(rqstp);
@@ -761,6 +762,7 @@ static struct svc_xprt *svc_get_next_xprt(struct svc_rqst *rqstp)
 	percpu_counter_inc(&pool->sp_threads_no_work);
 	return NULL;
 out_found:
+	clear_bit(SP_TASK_PENDING, &pool->sp_flags);
 	/* Normally we will wait up to 5 seconds for any required
 	 * cache information to be provided.
 	 */
-- 
2.40.1

