Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C82E9768C54
	for <lists+linux-nfs@lfdr.de>; Mon, 31 Jul 2023 08:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbjGaGwE (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 31 Jul 2023 02:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjGaGvw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 31 Jul 2023 02:51:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3117510EC
        for <linux-nfs@vger.kernel.org>; Sun, 30 Jul 2023 23:51:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E5B501F460;
        Mon, 31 Jul 2023 06:51:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1690786298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aUoIN+bi6OHz8LNJYb3xb9EMGlBqAwyg+UUoyZPhaCw=;
        b=oXGeaw6ERXDHFuNCqUSJh7NHr0RrL/bqW278uYzQzb/yq7pNQSmC6kTTB+877nMaOWqnIG
        uwoCNlw31WPBU/GWw12szWeIr9qmsdF076btcPywqtyVMukEJPL7K2Y2MvcReB3tYB+BnM
        2vBMEvp81dvimE2TMMTNXp5StkmgLRs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1690786298;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aUoIN+bi6OHz8LNJYb3xb9EMGlBqAwyg+UUoyZPhaCw=;
        b=gN4PApoi3/6zMowT9mPY/zZQf2NOdNCnwWuD+vvMPcSevdiZDWDdFm0qwS+E42040I2rR4
        Yyrd1sCydMEwGbDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A4F4B1322C;
        Mon, 31 Jul 2023 06:51:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Fi3XFflZx2SzbwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 31 Jul 2023 06:51:37 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 04/12] nfsd: Simplify code around svc_exit_thread() call in nfsd()
Date:   Mon, 31 Jul 2023 16:48:31 +1000
Message-Id: <20230731064839.7729-5-neilb@suse.de>
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

Previously a thread could exit asynchronously (due to a signal) so some
care was needed to hold nfsd_mutex over the last svc_put() call.  Now a
thread can only exit when svc_set_num_thread() is called, and this is
always called under nfsd_mutex.  So no care is needed.

Not only is it the mutex held when a thread exits now, but the svc
refcount is elevated, so the svc_put() in svc_exit_thread() will never
be a final put, so the mutex isn't even needed at this point in the
code.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 fs/nfsd/nfssvc.c           | 23 -----------------------
 include/linux/sunrpc/svc.h | 13 -------------
 2 files changed, 36 deletions(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index 82e272707d2f..33a80725e14e 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -982,31 +982,8 @@ nfsd(void *vrqstp)
 	atomic_dec(&nfsdstats.th_cnt);
 
 out:
-	/* Take an extra ref so that the svc_put in svc_exit_thread()
-	 * doesn't call svc_destroy()
-	 */
-	svc_get(nn->nfsd_serv);
-
 	/* Release the thread */
 	svc_exit_thread(rqstp);
-
-	/* We need to drop a ref, but may not drop the last reference
-	 * without holding nfsd_mutex, and we cannot wait for nfsd_mutex as that
-	 * could deadlock with nfsd_shutdown_threads() waiting for us.
-	 * So three options are:
-	 * - drop a non-final reference,
-	 * - get the mutex without waiting
-	 * - sleep briefly andd try the above again
-	 */
-	while (!svc_put_not_last(nn->nfsd_serv)) {
-		if (mutex_trylock(&nfsd_mutex)) {
-			nfsd_put(net);
-			mutex_unlock(&nfsd_mutex);
-			break;
-		}
-		msleep(20);
-	}
-
 	return 0;
 }
 
diff --git a/include/linux/sunrpc/svc.h b/include/linux/sunrpc/svc.h
index 110f4560be38..db3de4ea33f9 100644
--- a/include/linux/sunrpc/svc.h
+++ b/include/linux/sunrpc/svc.h
@@ -125,19 +125,6 @@ static inline void svc_put(struct svc_serv *serv)
 	kref_put(&serv->sv_refcnt, svc_destroy);
 }
 
-/**
- * svc_put_not_last - decrement non-final reference count on SUNRPC serv
- * @serv:  the svc_serv to have count decremented
- *
- * Returns: %true is refcount was decremented.
- *
- * If the refcount is 1, it is not decremented and instead failure is reported.
- */
-static inline bool svc_put_not_last(struct svc_serv *serv)
-{
-	return refcount_dec_not_one(&serv->sv_refcnt.refcount);
-}
-
 /*
  * Maximum payload size supported by a kernel RPC server.
  * This is use to determine the max number of pages nfsd is
-- 
2.40.1

