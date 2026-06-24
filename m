Return-Path: <linux-nfs+bounces-22804-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hegAJQYPPGqHjQgAu9opvQ
	(envelope-from <linux-nfs+bounces-22804-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 19:08:22 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E85E66C03BC
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 19:08:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=hammerspace.com header.s=google header.b=cwRlXGjQ;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22804-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22804-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=hammerspace.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 59C893038513
	for <lists+linux-nfs@lfdr.de>; Wed, 24 Jun 2026 17:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8620F3672B2;
	Wed, 24 Jun 2026 17:04:59 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD533793A5
	for <linux-nfs@vger.kernel.org>; Wed, 24 Jun 2026 17:04:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782320699; cv=none; b=dNROAD9zuvlujcBWSRj6Rh0oGznP04uD1bueq2lhbFQ6otLmuPK1B+/rJrzGCFyhIHTnnMMxL+RN8SvJ1tuYSTpz4rrWr6fUoD2MNEBLIAF8zg7dDoLxsROhjyIcnCA5BMHkHlkZHVrzFHPaxmhIOYMm7MOcPoG+MhAhftI0Qv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782320699; c=relaxed/simple;
	bh=a1o+gdXWenzUIIIaOXXsdcqgEzTGUTXXk/XlcAtPxyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XaQEBfdJnNXFtSE1GEWdfVJh6argtVN12vX28FIa/INaoiPnlIgP5HW72+IDAmDxWOq5d2SmY9Bh2wdEosSThrrWhdog8dwUpsCsWE1m1aOIyXnRbDpZWmyG5DTvnflAmKUo/ePEkvJMng/WL8M1UdSOlZI/A/ldUQTN9VnSnik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hammerspace.com; spf=pass smtp.mailfrom=hammerspace.com; dkim=pass (2048-bit key) header.d=hammerspace.com header.i=@hammerspace.com header.b=cwRlXGjQ; arc=none smtp.client-ip=209.85.210.44
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7e93c3f1717so599461a34.2
        for <linux-nfs@vger.kernel.org>; Wed, 24 Jun 2026 10:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=hammerspace.com; s=google; t=1782320695; x=1782925495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MWkVkmEk23+RpTR6vxK4sQw7dZSZ/i0HWPyI822C9ss=;
        b=cwRlXGjQTsmnB6dS6s2TBHVVKK9HaKvMRyvoPbM846l4dB791nB1nuMwjmrgv7spKu
         JT/ru8UfD7dERY45CFxkrIxE7MTRRT8fXno3LPQCl71WU8pZwjAalpL8L0a3/hIXd7Is
         HY3wmb0m6bAaqJD4XM0KPh6Teo/SyImkHcfdpIrFrgxsX3RxWDgtpY27X+jSbTIGtA3d
         I5ihdpdqlYlzC5+elILzAt8pEmsgWrpKaOAGoYecNY6kfKsfpDbBzMUdgEGlHfr5iZ57
         UB9mnEgp5zFDhiP4Tkby9ljB6bxRWdk2badwJTnymMO15NIaDskfFfP2rhH9cQAu2A3X
         Kshg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782320695; x=1782925495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MWkVkmEk23+RpTR6vxK4sQw7dZSZ/i0HWPyI822C9ss=;
        b=N297LKIPOuS0UR4GxsUEstrqLDTQc+mve0LQ+/QS55nk2eB0OiM71YXwJMYM1Qy4cw
         ocIMmQoI4Dj3nrQcDsZ43JbJnsrdURMi3qHfFp6D8mqTBcJf9VYxjrtQeqIx+R+EKNXb
         pMoty6ppYYU14uddZOuMIoPIzhDE0ZDeZFCHaKM2hJcZBN9JYOkQ6qtzLahHrajl/G7J
         9XW7+aqaVrUXf5P3+1ltQ1bDBJd3gY5sVvo2rrwHyFDH1kdpK3IvcO8GJ1/IjEgVby3k
         CuvrrXoweDXOu6YsAv4Td8dpEsgXYzzndkKAy6wITn6keYixMdEXte51L1tmCwZ1d5rL
         HfEw==
X-Forwarded-Encrypted: i=1; AFNElJ9vl/flqumGCJgkKzyEa7C9a9uqdXQ+UNqSx4SkStgy+WpwReX9FvfyLWkQpL+hXme4lmyNiQJzUdw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7fJ6yjyVGprxPVPc3Z0zozWH/0lhq5T7PvHl7moYb/s/foI4q
	X4x4l4igS+agXJd+IH2JAbhvD5SG1EpNB5TTj2LjHMmKgipL33OyVpc/CL9/wJ3lv80=
X-Gm-Gg: AfdE7cngFDA+W9ppPUqIvXbKDneGBBQ8Xgz3vC5AKPQBfkKu61nBVEULS9wYy6+xX5O
	Kw3OxhlHwiup6CKH/Pzdz20H4di/tNQtdWGCzD7uBs7sskPqYwnYgy1GaumwrirYdKp3o59T5+G
	1dCjpRFkRm5drQTxSzbdfO4nr3WwpKZpV/gVe0zCiSsx7V+9mRX6qLZDctwYoEDMXFiBLZrTzU3
	F0behqb+xFYXkqzcIBAHCqy38WnE/qnfJVmhojNGJst7hVmM60Hy4+576E2eo87qlEmaInp9Tpu
	C1WPFV2BR1lusNiP6fbQGJT70ZSQSHeFLt6oh3sXc/MH2U+CSYx6TAHex/jZF//tYmq0CosY0g2
	ymZ7rDeOJgM23WBUBeF8xWM09ReUxzE5V8BJxLHeOLs+q82eDln24uaN8czzmxrsrV3SD+lL7YJ
	BTpVahFj/urXg0FVmDUOkQ13kUjRxECdkh5ZO1kdneJKSsLzLi
X-Received: by 2002:a05:6830:d02:b0:7dc:dbe4:3f21 with SMTP id 46e09a7af769-7e9792eb9c9mr5749314a34.1.1782320694973;
        Wed, 24 Jun 2026 10:04:54 -0700 (PDT)
Received: from bcodding.csb.hammerspace.com ([66.97.168.37])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e94429a031sm11959103a34.23.2026.06.24.10.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 10:04:54 -0700 (PDT)
From: Benjamin Coddington <ben.coddington@hammerspace.com>
X-Google-Original-From: Benjamin Coddington <bcodding@hammerspace.com>
To: Chuck Lever <cel@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@ownmail.net>,
	Olga Kornievskaia <okorniev@redhat.com>,
	Dai Ngo <Dai.Ngo@oracle.com>,
	Tom Talpey <tom@talpey.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>
Cc: Daire Byrne <daire@dneg.com>,
	linux-nfs@vger.kernel.org
Subject: [PATCH RFC 2/3] SUNRPC: dispatch idle transports ahead of backlogged ones
Date: Wed, 24 Jun 2026 13:04:49 -0400
Message-ID: <8b65b751a62984fa08797b18be7dfaf16bdb3721.1782314746.git.bcodding@hammerspace.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1782314746.git.bcodding@hammerspace.com>
References: <cover.1782314746.git.bcodding@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[hammerspace.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[hammerspace.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-22804-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:cel@kernel.org,m:jlayton@kernel.org,m:neilb@ownmail.net,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:daire@dneg.com,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,ownmail.net,redhat.com,oracle.com,talpey.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[hammerspace.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben.coddington@hammerspace.com,linux-nfs@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hammerspace.com:dkim,hammerspace.com:email,hammerspace.com:mid,hammerspace.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E85E66C03BC

A pool dispatches ready transports in FIFO order, so a connection that
already has requests in flight sits in the same queue, on equal terms,
as one that has been idle.  A client driving many concurrent requests
therefore delays the next request of an interactive client whose
previous reply has already completed: the interactive request waits
behind the busy client's backlog even though servicing it costs a
single round trip.

Route a transport with no requests in flight onto the new high-priority
queue, sp_xprts_hi, and drain that queue ahead of sp_xprts.  xpt_nr_rqsts
is incremented when a thread reserves a request slot and decremented when
the reply completes, so at enqueue time it counts the transport's prior
in-flight work, not the request that just arrived: a flow whose last
reply has completed reads zero and jumps the queue, while a flow with
requests still in flight stays in the bulk queue.  The classification
needs no client identity and no lock -- each queue is an independent lwq
with its own ordering, so svc_thread_should_sleep() simply tests both.

This gives an idle flow's request a latency floor that a backlogged flow
cannot push it below.  It is starvation avoidance, not proportional
fairness: under sustained load across many idle flows the bulk queue can
wait, and bounding that is left to later work.

Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
---
 net/sunrpc/svc_xprt.c | 44 +++++++++++++++++++++++++++----------------
 1 file changed, 28 insertions(+), 16 deletions(-)

diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index 63d1002e63e7..ec4c05094e9a 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -523,7 +523,10 @@ void svc_xprt_enqueue(struct svc_xprt *xprt)
 
 	percpu_counter_inc(&pool->sp_sockets_queued);
 	xprt->xpt_qtime = ktime_get();
-	lwq_enqueue(&xprt->xpt_ready, &pool->sp_xprts);
+	if (atomic_read(&xprt->xpt_nr_rqsts))
+		lwq_enqueue(&xprt->xpt_ready, &pool->sp_xprts);
+	else
+		lwq_enqueue(&xprt->xpt_ready, &pool->sp_xprts_hi);
 
 	svc_pool_wake_idle_thread(pool);
 }
@@ -536,7 +539,9 @@ static struct svc_xprt *svc_xprt_dequeue(struct svc_pool *pool)
 {
 	struct svc_xprt	*xprt = NULL;
 
-	xprt = lwq_dequeue(&pool->sp_xprts, struct svc_xprt, xpt_ready);
+	xprt = lwq_dequeue(&pool->sp_xprts_hi, struct svc_xprt, xpt_ready);
+	if (!xprt)
+		xprt = lwq_dequeue(&pool->sp_xprts, struct svc_xprt, xpt_ready);
 	if (xprt)
 		svc_xprt_get(xprt);
 	return xprt;
@@ -759,7 +764,7 @@ svc_thread_should_sleep(struct svc_rqst *rqstp)
 		return false;
 
 	/* was a socket queued? */
-	if (!lwq_empty(&pool->sp_xprts))
+	if (!lwq_empty(&pool->sp_xprts_hi) || !lwq_empty(&pool->sp_xprts))
 		return false;
 
 	/* are we shutting down? */
@@ -1183,26 +1188,33 @@ static int svc_close_list(struct svc_serv *serv, struct list_head *xprt_list, st
 	return ret;
 }
 
-static void svc_clean_up_xprts(struct svc_serv *serv, struct net *net)
+static void svc_clean_up_queue(struct lwq *queue, struct net *net)
 {
 	struct svc_xprt *xprt;
+	struct llist_node *q, **t1, *t2;
+
+	q = lwq_dequeue_all(queue);
+	lwq_for_each_safe(xprt, t1, t2, &q, xpt_ready) {
+		if (xprt->xpt_net == net) {
+			set_bit(XPT_CLOSE, &xprt->xpt_flags);
+			svc_delete_xprt(xprt);
+			xprt = NULL;
+		}
+	}
+
+	if (q)
+		lwq_enqueue_batch(q, queue);
+}
+
+static void svc_clean_up_xprts(struct svc_serv *serv, struct net *net)
+{
 	int i;
 
 	for (i = 0; i < serv->sv_nrpools; i++) {
 		struct svc_pool *pool = &serv->sv_pools[i];
-		struct llist_node *q, **t1, *t2;
-
-		q = lwq_dequeue_all(&pool->sp_xprts);
-		lwq_for_each_safe(xprt, t1, t2, &q, xpt_ready) {
-			if (xprt->xpt_net == net) {
-				set_bit(XPT_CLOSE, &xprt->xpt_flags);
-				svc_delete_xprt(xprt);
-				xprt = NULL;
-			}
-		}
 
-		if (q)
-			lwq_enqueue_batch(q, &pool->sp_xprts);
+		svc_clean_up_queue(&pool->sp_xprts_hi, net);
+		svc_clean_up_queue(&pool->sp_xprts, net);
 	}
 }
 
-- 
2.53.0


