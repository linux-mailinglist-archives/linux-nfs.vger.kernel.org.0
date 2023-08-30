Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3C2978D240
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Aug 2023 04:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235449AbjH3C6u (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Aug 2023 22:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234124AbjH3C6V (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Aug 2023 22:58:21 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B33E185
        for <linux-nfs@vger.kernel.org>; Tue, 29 Aug 2023 19:58:19 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 1FAAB1F461;
        Wed, 30 Aug 2023 02:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693364298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y8jphQss9HeYy7fr6607tDpyIo8Hc3AHgFDPPac0GpA=;
        b=hqaNSsonP4tWNLuT+HHELqoxn4J7Lz8tUbH+t2UDwpiAypOEFLgorafAW0i3WUdpnx9XCx
        4OIk2fjwCjiIqvXkSQ0U1lRAHWXkLD4zIcux7HTeIO/z/mx3W6SJDu/uQXq0iEb6x8U1rN
        aYd2lDAujBHPY8V3YzrZilRyERZs23I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693364298;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y8jphQss9HeYy7fr6607tDpyIo8Hc3AHgFDPPac0GpA=;
        b=6gR6xs8jAK6aX9RKGRzmjQVNsyf2C56ur+7vg+RwG/8zlMyTPaMBXuZeMHsb6q9cOEwoBZ
        91U8GQaqOCA00ECQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D565213301;
        Wed, 30 Aug 2023 02:58:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id w0bXIUiw7mTZYwAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 30 Aug 2023 02:58:16 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 01/10] SQUASH: revise comments in SUNRPC: change service idle list to be an llist
Date:   Wed, 30 Aug 2023 12:54:44 +1000
Message-ID: <20230830025755.21292-2-neilb@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230830025755.21292-1-neilb@suse.de>
References: <20230830025755.21292-1-neilb@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Revise some comments to hopefully make the more clear and less verbose.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 include/linux/sunrpc/svc.h |  6 +++---
 net/sunrpc/svc_xprt.c      | 20 +++++++-------------
 2 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 5216f95411e3..ed20a2ea1f81 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -271,7 +271,7 @@ enum {
  * @rqstp: the thread which is now busy
  *
  * By convention a thread is busy if rq_idle.next points to rq_idle.
- * This ensures it is not on the idle list.
+ * This will never be the case for threads on the idle list.
  */
 static inline void svc_thread_set_busy(struct svc_rqst *rqstp)
 {
@@ -283,9 +283,9 @@ static inline void svc_thread_set_busy(struct svc_rqst *rqstp)
  * @rqstp: the thread which might be busy
  *
  * By convention a thread is busy if rq_idle.next points to rq_idle.
- * This ensures it is not on the idle list.
+ * This will never be the case for threads on the idle list.
  */
-static inline bool svc_thread_busy(struct svc_rqst *rqstp)
+static inline bool svc_thread_busy(const struct svc_rqst *rqstp)
 {
 	return rqstp->rq_idle.next == &rqstp->rq_idle;
 }
diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 81327001e074..17c43bde35c9 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -734,22 +734,16 @@ static void svc_rqst_wait_for_work(struct svc_rqst *rqstp)
 		llist_add(&rqstp->rq_idle, &pool->sp_idle_threads);
 
 		if (unlikely(!rqst_should_sleep(rqstp)))
-			/* maybe there were no idle threads when some work
-			 * became ready and so nothing was woken.  We've just
-			 * become idle so someone can to the work - maybe us.
-			 * But we cannot reliably remove ourselves from the
-			 * idle list - we can only remove the first task which
-			 * might be us, and might not.
-			 * So remove and wake it, then schedule().  If it was
-			 * us, we won't sleep.  If it is some other thread, they
-			 * will do the work.
+			/* Work just became available.  This thread cannot simply
+			 * choose not to sleep as it *must* wait until removed.
+			 * So wake the first waiter - whether it is this
+			 * thread or some other, it will get the work done.
 			 */
 			svc_pool_wake_idle_thread(pool);
 
-		/* We mustn't continue while on the idle list, and we
-		 * cannot remove outselves reliably.  The only "work"
-		 * we can do while on the idle list is to freeze.
-		 * So loop until someone removes us
+		/* Since a thread cannot remove itself from an llist,
+		 * schedule until someone else removes @rqstp from
+		 * the idle list.
 		 */
 		while (!svc_thread_busy(rqstp)) {
 			schedule();
-- 
2.41.0

