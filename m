Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE721D00CA
	for <lists+linux-nfs@lfdr.de>; Tue, 12 May 2020 23:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731333AbgELVYO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 12 May 2020 17:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731308AbgELVYN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 12 May 2020 17:24:13 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D78FC061A0C;
        Tue, 12 May 2020 14:24:13 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id c24so6016930qtw.7;
        Tue, 12 May 2020 14:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=lJyCmn+wrw9fOiuFD6p/GmVDOI8LWar9S6pYuPj9wAU=;
        b=tKVBeBR2OS9cNgqUcofkku1Db6+FrGUWwXRvQmy7kffHfn3DbnI5Pp1IQceC094oVM
         oHNuGPww8T2zbwO93t94DKop2+Z9+MDSJAKHjG7TFGcS87Gro0pzZQLRYvIVh5qo6u3c
         R04LtJ+I2reEG0q3xD3PqzIM28EMMp/GPEumAKoV+qcIl5JFb5fAjk9JKS2As0gT/D0z
         F1bVKaWaZ4DeQTqh5yGNcyMVVOtYbkTpzalOJZOa0XGifE+A3mKcriKPTQCMYu3Q2AIs
         nX59QZqfAQ9UV3l9zBqDmHSaJjEdFgn7THFVd4ljGC+YusGDCcBrn6HWtktHbNrpUZby
         4G5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=lJyCmn+wrw9fOiuFD6p/GmVDOI8LWar9S6pYuPj9wAU=;
        b=PYSs8qlq4mE2k7/wWaAKcfjfioO0Jd4lhR3oRMs++h1wj2JzmmM86W3M9keclmPl42
         znXfZbcMPvpmrKYHFJTzhxnhVNgEYc8wA7V2QoKpN1PjTcN1JMtYj9O3rhBzPNVkcJek
         JuPvTuHOgxDmqxeWj0C/wOQKRCjFckjnK9iCXBTWIhh+DZsJ9FntjdWi0zsFjCU6So1G
         6EHS7G/cb7rdJha9qa083OaB0VM9uE1zOTwUKIC3MK/lTDfqiUS5QOkbJ4cN0zrjpq5r
         wUGlBFFG6sxeZVPivF2nos1QNlSfNG/wxhdo3dXD77DLf2CVdPAWYE60RD2lSX4Dn6+j
         nWQw==
X-Gm-Message-State: AGi0PualdyJAuviTzZnBkuATNOt1hVjtkgmC7lIo9SXbDpQthaHRBal7
        OvMjVp5E/lODTogGOsU37FWxSLNm
X-Google-Smtp-Source: APiQypLR0RmnSR3/DuGlINlacyDQkEFa7Qlybnld98gMiWO18WLSXS1hh0PfTfXREbG2DB2R2jceiw==
X-Received: by 2002:ac8:6c23:: with SMTP id k3mr24343231qtu.107.1589318652110;
        Tue, 12 May 2020 14:24:12 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id v4sm12055938qkv.43.2020.05.12.14.24.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 May 2020 14:24:11 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 04CLOALD009948;
        Tue, 12 May 2020 21:24:10 GMT
Subject: [PATCH v2 24/29] NFSD: Add tracepoints to NFSD's duplicate reply
 cache
From:   Chuck Lever <chuck.lever@oracle.com>
To:     bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Tue, 12 May 2020 17:24:10 -0400
Message-ID: <20200512212410.5826.28992.stgit@klimt.1015granger.net>
In-Reply-To: <20200512211640.5826.77139.stgit@klimt.1015granger.net>
References: <20200512211640.5826.77139.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-31-g4b47
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Try to capture DRC failures.

Two additional clean-ups:
- Introduce Doxygen-style comments for the main entry points
- Remove a dprintk that fires for an allocation failure. This was
  the only dprintk in the REPCACHE class.

Reported-by: kbuild test robot <lkp@intel.com>
[ cel: force typecast for display of checksum values ]
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfscache.c |   57 +++++++++++++++++++++++++++++++-------------------
 fs/nfsd/trace.h    |   59 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 94 insertions(+), 22 deletions(-)

diff --git a/fs/nfsd/nfscache.c b/fs/nfsd/nfscache.c
index 96352ab7bd81..945d2f5e760e 100644
--- a/fs/nfsd/nfscache.c
+++ b/fs/nfsd/nfscache.c
@@ -20,8 +20,7 @@
 
 #include "nfsd.h"
 #include "cache.h"
-
-#define NFSDDBG_FACILITY	NFSDDBG_REPCACHE
+#include "trace.h"
 
 /*
  * We use this value to determine the number of hash buckets from the max
@@ -323,8 +322,10 @@ nfsd_cache_key_cmp(const struct svc_cacherep *key,
 			const struct svc_cacherep *rp, struct nfsd_net *nn)
 {
 	if (key->c_key.k_xid == rp->c_key.k_xid &&
-	    key->c_key.k_csum != rp->c_key.k_csum)
+	    key->c_key.k_csum != rp->c_key.k_csum) {
 		++nn->payload_misses;
+		trace_nfsd_drc_mismatch(nn, key, rp);
+	}
 
 	return memcmp(&key->c_key, &rp->c_key, sizeof(key->c_key));
 }
@@ -377,15 +378,22 @@ nfsd_cache_insert(struct nfsd_drc_bucket *b, struct svc_cacherep *key,
 	return ret;
 }
 
-/*
+/**
+ * nfsd_cache_lookup - Find an entry in the duplicate reply cache
+ * @rqstp: Incoming Call to find
+ *
  * Try to find an entry matching the current call in the cache. When none
  * is found, we try to grab the oldest expired entry off the LRU list. If
  * a suitable one isn't there, then drop the cache_lock and allocate a
  * new one, then search again in case one got inserted while this thread
  * didn't hold the lock.
+ *
+ * Return values:
+ *   %RC_DOIT: Process the request normally
+ *   %RC_REPLY: Reply from cache
+ *   %RC_DROPIT: Do not process the request further
  */
-int
-nfsd_cache_lookup(struct svc_rqst *rqstp)
+int nfsd_cache_lookup(struct svc_rqst *rqstp)
 {
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 	struct svc_cacherep	*rp, *found;
@@ -399,7 +407,7 @@ nfsd_cache_lookup(struct svc_rqst *rqstp)
 	rqstp->rq_cacherep = NULL;
 	if (type == RC_NOCACHE) {
 		nfsdstats.rcnocache++;
-		return rtn;
+		goto out;
 	}
 
 	csum = nfsd_cache_csum(rqstp);
@@ -409,10 +417,8 @@ nfsd_cache_lookup(struct svc_rqst *rqstp)
 	 * preallocate an entry.
 	 */
 	rp = nfsd_reply_cache_alloc(rqstp, csum, nn);
-	if (!rp) {
-		dprintk("nfsd: unable to allocate DRC entry!\n");
-		return rtn;
-	}
+	if (!rp)
+		goto out;
 
 	spin_lock(&b->cache_lock);
 	found = nfsd_cache_insert(b, rp, nn);
@@ -431,8 +437,10 @@ nfsd_cache_lookup(struct svc_rqst *rqstp)
 
 	/* go ahead and prune the cache */
 	prune_bucket(b, nn);
- out:
+
+out_unlock:
 	spin_unlock(&b->cache_lock);
+out:
 	return rtn;
 
 found_entry:
@@ -442,13 +450,13 @@ nfsd_cache_lookup(struct svc_rqst *rqstp)
 
 	/* Request being processed */
 	if (rp->c_state == RC_INPROG)
-		goto out;
+		goto out_trace;
 
 	/* From the hall of fame of impractical attacks:
 	 * Is this a user who tries to snoop on the cache? */
 	rtn = RC_DOIT;
 	if (!test_bit(RQ_SECURE, &rqstp->rq_flags) && rp->c_secure)
-		goto out;
+		goto out_trace;
 
 	/* Compose RPC reply header */
 	switch (rp->c_type) {
@@ -460,7 +468,7 @@ nfsd_cache_lookup(struct svc_rqst *rqstp)
 		break;
 	case RC_REPLBUFF:
 		if (!nfsd_cache_append(rqstp, &rp->c_replvec))
-			goto out;	/* should not happen */
+			goto out_unlock; /* should not happen */
 		rtn = RC_REPLY;
 		break;
 	default:
@@ -468,13 +476,19 @@ nfsd_cache_lookup(struct svc_rqst *rqstp)
 		nfsd_reply_cache_free_locked(b, rp, nn);
 	}
 
-	goto out;
+out_trace:
+	trace_nfsd_drc_found(nn, rqstp, rtn);
+	goto out_unlock;
 }
 
-/*
- * Update a cache entry. This is called from nfsd_dispatch when
- * the procedure has been executed and the complete reply is in
- * rqstp->rq_res.
+/**
+ * nfsd_cache_update - Update an entry in the duplicate reply cache.
+ * @rqstp: svc_rqst with a finished Reply
+ * @cachetype: which cache to update
+ * @statp: Reply's status code
+ *
+ * This is called from nfsd_dispatch when the procedure has been
+ * executed and the complete reply is in rqstp->rq_res.
  *
  * We're copying around data here rather than swapping buffers because
  * the toplevel loop requires max-sized buffers, which would be a waste
@@ -487,8 +501,7 @@ nfsd_cache_lookup(struct svc_rqst *rqstp)
  * nfsd failed to encode a reply that otherwise would have been cached.
  * In this case, nfsd_cache_update is called with statp == NULL.
  */
-void
-nfsd_cache_update(struct svc_rqst *rqstp, int cachetype, __be32 *statp)
+void nfsd_cache_update(struct svc_rqst *rqstp, int cachetype, __be32 *statp)
 {
 	struct nfsd_net *nn = net_generic(SVC_NET(rqstp), nfsd_net_id);
 	struct svc_cacherep *rp = rqstp->rq_cacherep;
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 78c574251c60..371dc198d28e 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -432,6 +432,65 @@ TRACE_EVENT(nfsd_file_fsnotify_handle_event,
 			__entry->nlink, __entry->mode, __entry->mask)
 );
 
+#include "cache.h"
+
+TRACE_DEFINE_ENUM(RC_DROPIT);
+TRACE_DEFINE_ENUM(RC_REPLY);
+TRACE_DEFINE_ENUM(RC_DOIT);
+
+#define show_drc_retval(x)						\
+	__print_symbolic(x,						\
+		{ RC_DROPIT, "DROPIT" },				\
+		{ RC_REPLY, "REPLY" },					\
+		{ RC_DOIT, "DOIT" })
+
+TRACE_EVENT(nfsd_drc_found,
+	TP_PROTO(
+		const struct nfsd_net *nn,
+		const struct svc_rqst *rqstp,
+		int result
+	),
+	TP_ARGS(nn, rqstp, result),
+	TP_STRUCT__entry(
+		__field(unsigned long long, boot_time)
+		__field(unsigned long, result)
+		__field(u32, xid)
+	),
+	TP_fast_assign(
+		__entry->boot_time = nn->boot_time;
+		__entry->result = result;
+		__entry->xid = be32_to_cpu(rqstp->rq_xid);
+	),
+	TP_printk("boot_time=%16llx xid=0x%08x result=%s",
+		__entry->boot_time, __entry->xid,
+		show_drc_retval(__entry->result))
+
+);
+
+TRACE_EVENT(nfsd_drc_mismatch,
+	TP_PROTO(
+		const struct nfsd_net *nn,
+		const struct svc_cacherep *key,
+		const struct svc_cacherep *rp
+	),
+	TP_ARGS(nn, key, rp),
+	TP_STRUCT__entry(
+		__field(unsigned long long, boot_time)
+		__field(u32, xid)
+		__field(u32, cached)
+		__field(u32, ingress)
+	),
+	TP_fast_assign(
+		__entry->boot_time = nn->boot_time;
+		__entry->xid = be32_to_cpu(key->c_key.k_xid);
+		__entry->cached = (__force u32)key->c_key.k_csum;
+		__entry->ingress = (__force u32)rp->c_key.k_csum;
+	),
+	TP_printk("boot_time=%16llx xid=0x%08x cached-csum=0x%08x ingress-csum=0x%08x",
+		__entry->boot_time, __entry->xid, __entry->cached,
+		__entry->ingress)
+);
+
 #endif /* _NFSD_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH

