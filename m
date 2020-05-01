Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 067C91C1B93
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2020 19:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgEARWQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 May 2020 13:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729018AbgEARWQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 May 2020 13:22:16 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962A9C061A0C
        for <linux-nfs@vger.kernel.org>; Fri,  1 May 2020 10:22:14 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id n14so1821446qke.8
        for <linux-nfs@vger.kernel.org>; Fri, 01 May 2020 10:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Kx/KkkXJ8idJ9EMolTQVtT7lvDcvWms3NGMGInn8HPw=;
        b=SfcsuIXU690AZQgeatt+MeahZzTIwNiRt34orxtfDi3EfSl1qy1I9/DFjk/+/PzHx9
         gFw0FOu+op4uXhKqtMeI3MNK4A2WJbPQGPmzOw6OZ3SkkDyyD/xw/QiyHu7w8Nk0nYos
         84SG6mwXP+Ww8v9DFkmuINB6q6QGe97n2oBdR2fHqrxrjjnXJMJfEGDe84aZuOt0bLsg
         T6Tkd2r7T682WFt3CRBfCp4GqEe1tjk0Vm+Bh6gH5PAB1cU8bAFjVkp4S0Bej840Z4p8
         5FP/zDM80B3WLYNxkZJf1TBooKXaADenULu6EYGUXiVKjepX3F29bjWJUm0K29wQjrHT
         z7SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=Kx/KkkXJ8idJ9EMolTQVtT7lvDcvWms3NGMGInn8HPw=;
        b=mkA6DJDyoTnDLsvlMMDt4x2xgKoMhwW15GKHhjYq3AkOkdBx9FcotSzQNmBlA/BugN
         jPh2YdPnd30nPxlY46phURLNQI8sblxpn1ctKKeabPfxQxyam2O4rZXxoNhpl1phFgQR
         tC6euQKN2VOW2CWb25eTYOni/mY0DKB9K0r0cH3jPaIK++z3Ck4bD78wT2T9GYp7xfTs
         w+0iq/LboeNBpUunUFQIMfJe56o1cHDLvwEmReJv58NUVRXovamxUWd2kin4x5T2N4ix
         fdBPyGZH4pAVdvubXyMno6OnP3DRvGvf8Erp0LjNaaPxY8hJTDMjLHGVZLuR1kvrb0x9
         OosQ==
X-Gm-Message-State: AGi0PuYoZbOqdqq9o+IwqzwHoGECRzpLaUqyZpza23pnYgor8EhTyYfO
        EG0yfzL07pIZbdAVKoHT7AVpDkYx
X-Google-Smtp-Source: APiQypJnbWEsJmEXunyySbGtwh3PfaW8kcdjRK9Ltrz/1baNKiqXVmDe/qH6dupuFQ9Hk6wnEckDSg==
X-Received: by 2002:a37:e10c:: with SMTP id c12mr4529295qkm.483.1588353733500;
        Fri, 01 May 2020 10:22:13 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id s15sm3180944qtc.31.2020.05.01.10.22.12
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2020 10:22:13 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 041HMB0P026675
        for <linux-nfs@vger.kernel.org>; Fri, 1 May 2020 17:22:11 GMT
Subject: [PATCH v1 1/4] NFSD: Add tracepoints to NFSD's duplicate reply cache
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org
Date:   Fri, 01 May 2020 13:22:11 -0400
Message-ID: <20200501172211.3764.75939.stgit@klimt.1015granger.net>
In-Reply-To: <20200501171750.3764.7676.stgit@klimt.1015granger.net>
References: <20200501171750.3764.7676.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-20-geafe
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
index 78c574251c60..68b9f5014a6d 100644
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
+		__entry->cached = key->c_key.k_csum;
+		__entry->ingress = rp->c_key.k_csum;
+	),
+	TP_printk("boot_time=%16llx xid=0x%08x cached-csum=0x%08x ingress-csum=0x%08x",
+		__entry->boot_time, __entry->xid, __entry->cached,
+		__entry->ingress)
+);
+
 #endif /* _NFSD_TRACE_H */
 
 #undef TRACE_INCLUDE_PATH

