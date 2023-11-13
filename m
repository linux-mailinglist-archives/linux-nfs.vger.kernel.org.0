Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758317E9D85
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Nov 2023 14:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjKMNpN (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Nov 2023 08:45:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjKMNpM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Nov 2023 08:45:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1D81735
        for <linux-nfs@vger.kernel.org>; Mon, 13 Nov 2023 05:45:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4995C433B9
        for <linux-nfs@vger.kernel.org>; Mon, 13 Nov 2023 13:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699883108;
        bh=yKcFJU/vPtKHDD5SMX8MmE7sfK0DFs2mkMh2h8n5Nkk=;
        h=Subject:From:To:Date:From;
        b=V9rsp0uurh6a6cVCP2I1THbx5x8pzyFJqglZzDw0/yu2Z9AQHkosViNy7nHA3PU3R
         MJKyD8fBBDEejuWK5J9lJmGsn+VNuOkhg1pOGZRulD8zoT0iZWWqpkkpJ7hlbgBGpT
         D383lMULzhkkaTDZrm47LLRmZPAlc9tNTe9N3P/Wa9OtVC6RguozeuzMOHKK0rwIuL
         NgtBWjA/97Ov1Ar5KvwUYXAvJp+CZnF1sKL4I62IgrV2EKNZDxFcqufL9IbGdHlKhx
         qXg3ZPRFFjQXVJtjLGGlfBgUOZTZD9OF3X/btjxtntQ0JRJnxI2o5WBGgvg7MBVNKR
         8BNRQTRAcMCKA==
Subject: [PATCH] NFSD: Remove nfsd_drc_gc() tracepoint
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Date:   Mon, 13 Nov 2023 08:45:07 -0500
Message-ID: <169988310782.6735.4291667629997514072.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

This trace point was for debugging the DRC's garbage collection. In
the field it's just noise.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfscache.c |    6 +-----
 fs/nfsd/trace.h    |   22 ----------------------
 2 files changed, 1 insertion(+), 27 deletions(-)

diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index fd56a52aa5fb..4d2055c7898a 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -364,8 +364,6 @@ nfsd_reply_cache_scan(struct shrinker *shrink, struct shrink_control *sc)
 		if (freed > sc->nr_to_scan)
 			break;
 	}
-
-	trace_nfsd_drc_gc(nn, freed);
 	return freed;
 }
 
@@ -486,7 +484,6 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp, struct nfsd_cacherep **cacherep)
 	__wsum			csum;
 	struct nfsd_drc_bucket	*b;
 	int type = rqstp->rq_cachetype;
-	unsigned long freed;
 	LIST_HEAD(dispose);
 	int rtn = RC_DOIT;
 
@@ -516,8 +513,7 @@ int nfsd_cache_lookup(struct svc_rqst *rqstp, struct nfsd_cacherep **cacherep)
 	nfsd_prune_bucket_locked(nn, b, 3, &dispose);
 	spin_unlock(&b->cache_lock);
 
-	freed = nfsd_cacherep_dispose(&dispose);
-	trace_nfsd_drc_gc(nn, freed);
+	nfsd_cacherep_dispose(&dispose);
 
 	nfsd_stats_rc_misses_inc();
 	atomic_inc(&nn->num_drc_entries);
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index fbc0ccb40424..d1e8cf079b0f 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -1262,28 +1262,6 @@ TRACE_EVENT(nfsd_drc_mismatch,
 		__entry->ingress)
 );
 
-TRACE_EVENT_CONDITION(nfsd_drc_gc,
-	TP_PROTO(
-		const struct nfsd_net *nn,
-		unsigned long freed
-	),
-	TP_ARGS(nn, freed),
-	TP_CONDITION(freed > 0),
-	TP_STRUCT__entry(
-		__field(unsigned long long, boot_time)
-		__field(unsigned long, freed)
-		__field(int, total)
-	),
-	TP_fast_assign(
-		__entry->boot_time = nn->boot_time;
-		__entry->freed = freed;
-		__entry->total = atomic_read(&nn->num_drc_entries);
-	),
-	TP_printk("boot_time=%16llx total=%d freed=%lu",
-		__entry->boot_time, __entry->total, __entry->freed
-	)
-);
-
 TRACE_EVENT(nfsd_cb_args,
 	TP_PROTO(
 		const struct nfs4_client *clp,


