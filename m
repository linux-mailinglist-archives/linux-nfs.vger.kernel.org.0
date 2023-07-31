Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 826D1768C50
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Jul 2023 08:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjGaGvs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Jul 2023 02:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjGaGvr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Jul 2023 02:51:47 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D036CE68
        for <linux-nfs@vger.kernel.org>; Sun, 30 Jul 2023 23:51:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 5C98D22427;
        Mon, 31 Jul 2023 06:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690786286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/exWp4MbE5xclwWmabWYmuVH+wPBLpgzCDBP1j4pM8s=;
        b=uT4EBg8+BtHNv2wLbop6a991XubzH7gBLtYtoLVW/5UaFZNIMKROXSPIa5xUeCuq7T/W2Q
        rLWlqoLhTVz9fy3bI5PAvv6YZk/t7y7pTgcA7iBI3FtISXvI3eT9cEwuUChhU1x6oYmQqZ
        GLiZjDkodiZZMvdi/OyYCTSTU5+hzA4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690786286;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/exWp4MbE5xclwWmabWYmuVH+wPBLpgzCDBP1j4pM8s=;
        b=Kb1RAWXtez3LkcZCkOdsMhvCSbvJlUg6W/6OVMORTP8esNON+8SpG5wt3T2idtnGMyrveC
        cPP2aTabEu36wpDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1FBDB1322C;
        Mon, 31 Jul 2023 06:51:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gmsAMexZx2SgbwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 31 Jul 2023 06:51:24 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 02/12] FIXUP: SUNRPC: Deduplicate thread wake-up code
Date:   Mon, 31 Jul 2023 16:48:29 +1000
Message-Id: <20230731064839.7729-3-neilb@suse.de>
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

The returned value is not used (any more), so don't return it.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 include/linux/sunrpc/svc.h | 2 +-
 net/sunrpc/svc.c           | 8 ++------
 2 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index c3f7726fc9f2..110f4560be38 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -434,7 +434,7 @@ int		   svc_register(const struct svc_serv *, struct net *, const int,
 
 void		   svc_wake_up(struct svc_serv *);
 void		   svc_reserve(struct svc_rqst *rqstp, int space);
-bool		   svc_pool_wake_idle_thread(struct svc_serv *serv,
+void		   svc_pool_wake_idle_thread(struct svc_serv *serv,
 					     struct svc_pool *pool);
 struct svc_pool   *svc_pool_for_cpu(struct svc_serv *serv);
 char *		   svc_print_addr(struct svc_rqst *, char *, size_t);
diff --git a/net/sunrpc/svc.c b/net/sunrpc/svc.c
index deb40d527b32..cbfd4ac02a4d 100644
--- a/net/sunrpc/svc.c
+++ b/net/sunrpc/svc.c
@@ -701,11 +701,8 @@ svc_prepare_thread(struct svc_serv *serv, struct svc_pool *pool, int node)
  * service thread and marking it BUSY is atomic with respect to
  * other calls to svc_pool_wake_idle_thread().
  *
- * Return value:
- *   %true: An idle thread was awoken
- *   %false: No idle thread was found
  */
-bool svc_pool_wake_idle_thread(struct svc_serv *serv, struct svc_pool *pool)
+void svc_pool_wake_idle_thread(struct svc_serv *serv, struct svc_pool *pool)
 {
 	struct svc_rqst	*rqstp;
 
@@ -719,14 +716,13 @@ bool svc_pool_wake_idle_thread(struct svc_serv *serv, struct svc_pool *pool)
 		rcu_read_unlock();
 		percpu_counter_inc(&pool->sp_threads_woken);
 		trace_svc_wake_up(rqstp);
-		return true;
+		return;
 	}
 	rcu_read_unlock();
 
 	trace_svc_pool_starved(serv, pool);
 	percpu_counter_inc(&pool->sp_threads_starved);
 	set_bit(SP_CONGESTED, &pool->sp_flags);
-	return false;
 }
 
 static struct svc_pool *
-- 
2.40.1

