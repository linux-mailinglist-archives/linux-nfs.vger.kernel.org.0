Return-Path: <linux-nfs+bounces-17514-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA4ACFA70B
	for <lists+linux-nfs@lfdr.de>; Tue, 06 Jan 2026 20:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6E9453052EE8
	for <lists+linux-nfs@lfdr.de>; Tue,  6 Jan 2026 19:01:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C586357A58;
	Tue,  6 Jan 2026 19:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y2daEpsW"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13ADB357736;
	Tue,  6 Jan 2026 19:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767726015; cv=none; b=c79zVKUjykT5z1KJdoclwX0ndYAhQ0IL5gBYfWO6yAcVwc6RsXvmV1y7qvY4oohhzw+8fEvZ5f0WZlhyrfShs29SVZcYh40gI8JfHatVet5zekxzM2LMgvDkDo01rmjFU8Ps5CczLrxi7v07THVu1+UJIGdQ81+hSSgtUTHPiQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767726015; c=relaxed/simple;
	bh=pA53B5dIKVvRePOcS2b6U1lFd0qO4apudIX5oSVrz+g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YO/NYhwdF2b4wCEvZIbT74stOJedECren6IHYw6VpGbyBlqLs9cD2LevXm3vKfMVFvKBxEYt/tm2zt53m4Uyk+DcVfQceZvmWPHcsMTwR1TUiZTKlVSP6WzvhimS7efn2X0si6ocgdj8S7CaKSdxtF1XjOBI4QR/01dDn9ElytE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y2daEpsW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A10ACC19422;
	Tue,  6 Jan 2026 19:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767726014;
	bh=pA53B5dIKVvRePOcS2b6U1lFd0qO4apudIX5oSVrz+g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Y2daEpsWIzMtWf71UvOTF35tPQJIn/A+1Zhp3BBVH05swTka1G+1jZgCF60ojT3Cm
	 A4Jmg06u8kDtxnXj2tjcc1pGqVw/w5d0MMsIlPdEfZdqmsoYP5YC0BA3hz6KcHpcNC
	 1u2EfhT9A03v+UjXBDEP0w9yW01WMAqPZ3iTJ/ypC5Q2eRJlA2lYTUlFP85whiEYB7
	 KOsabITAueXWB6YKOxtAsko129XigdU8bAf0+c/H9nyIYAGR8p2gKGnzK4cM5Xt8WP
	 bgBcjHdOvwspHtnyZGP9eIqvp5RbS8mWVeF+o+33hlCRkuZWOax7PAQY0q5mpBhfAS
	 DFbDcxKith3+w==
From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 06 Jan 2026 13:59:49 -0500
Subject: [PATCH v2 7/8] nfsd: adjust number of running nfsd threads based
 on activity
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-nfsd-dynathread-v2-7-416e5f27b2b6@kernel.org>
References: <20260106-nfsd-dynathread-v2-0-416e5f27b2b6@kernel.org>
In-Reply-To: <20260106-nfsd-dynathread-v2-0-416e5f27b2b6@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4692; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=pA53B5dIKVvRePOcS2b6U1lFd0qO4apudIX5oSVrz+g=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpXVu0ANcYFrz4ApbeYJWgx3c1EWRkP0bsB6WX6
 j3Vo1zgIkqJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaV1btAAKCRAADmhBGVaC
 FYC4EAC9wym3QpoJTEgDcmLCQrgQqOsZ9TeY7eBFZIuU5FGxReZH69HxwTVNpG0IESKaI0/6cIm
 jn8jAwS+ogqz9nMsWK7jPcS9ycAS3DdKsUgt9Va3aVXkL/mHsIESTP4J9qGGsIlTk5wdqsJ0V6X
 dKl3AC+ANJU/hJI/JF+fqllhkkRgb1aKBNptdgjc3Ps14Tctfd6GeNd8aIvwsLCNcr9CvaowTq3
 UyT+5fHZxZGhGE4cr7ZJzny4tGb1Sjly0jSaAi4q2Id4C0SLSZ02EmaVvl1pmgbqcSjvjmTReEI
 9vbxxLGFmUfj6Yg2Ll3KkLo0uDFmkXl+LaMDAoCQ1Gf9gLWAG6lGqJ3QtVIP1VAxJy4vrpE1bvs
 UGGbojJ6UIamBmyQ8w8VFHs7uCgFN0f9JdVKBsqG4dPKJEZyeiScoBezJaJsWsifVxVaTlV2/jN
 W3bOaOe3gO6NkvtXTBHdKQyIDsC+4p89AcsAiA0NOj4lblBlPiH3DB5ncdyIXskeA1RgrfDPreQ
 isEOU37IwULV21zTLK7Yb4foJuw6srTKN8990PdalKBxTMY/9yXyL+ZYFrbh2haWsdqJimcMaHN
 5BYsp2BKBDG2+J8CwrQrDwHmtMu/7ikYw00Gcv0xpUIGm98sscIGg2BV6K9Do8jdXvHSitrZMr1
 rSMrpDXZKDzvRBQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215

nfsd() is changed to pass a timeout to svc_recv() when there is a min
number of threads set, and to handle error returns from it:

In the case of -ETIMEDOUT, if the service mutex can be taken (via
trylock), the thread becomes an RQ_VICTIM so that it will exit,
providing that the actual number of threads is above pool->sp_nrthrmin.

In the case of -EBUSY, if the actual number of threads is below
pool->sp_nrthrmax, it will attempt to start a new thread. This attempt
is gated on a new SP_TASK_STARTING pool flag that serializes thread
creation attempts within a pool, and further by mutex_trylock().

Neil says: "I think we want memory pressure to be able to push a thread
into returning -ETIMEDOUT.  That can come later."

Signed-off-by: NeilBrown <neil@brown.name>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/nfsd/nfssvc.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 fs/nfsd/trace.h  | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/nfssvc.c b/fs/nfsd/nfssvc.c
index e3f647efc4c7b7b329bbd88899090ce070539aa7..55a4caaea97633670ffea1144ce4ac810b82c2ab 100644
--- a/fs/nfsd/nfssvc.c
+++ b/fs/nfsd/nfssvc.c
@@ -882,9 +882,11 @@ static int
 nfsd(void *vrqstp)
 {
 	struct svc_rqst *rqstp = (struct svc_rqst *) vrqstp;
+	struct svc_pool *pool = rqstp->rq_pool;
 	struct svc_xprt *perm_sock = list_entry(rqstp->rq_server->sv_permsocks.next, typeof(struct svc_xprt), xpt_list);
 	struct net *net = perm_sock->xpt_net;
 	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
+	bool have_mutex = false;
 
 	/* At this point, the thread shares current->fs
 	 * with the init process. We need to create files with the
@@ -902,7 +904,43 @@ nfsd(void *vrqstp)
 	 * The main request loop
 	 */
 	while (!svc_thread_should_stop(rqstp)) {
-		svc_recv(rqstp, 0);
+		switch (svc_recv(rqstp, 5 * HZ)) {
+		case -ETIMEDOUT:
+			/* Nothing to do */
+			if (mutex_trylock(&nfsd_mutex)) {
+				if (pool->sp_nrthreads > pool->sp_nrthrmin) {
+					trace_nfsd_dynthread_kill(net, pool);
+					set_bit(RQ_VICTIM, &rqstp->rq_flags);
+					have_mutex = true;
+				} else
+					mutex_unlock(&nfsd_mutex);
+			} else {
+				trace_nfsd_dynthread_trylock_fail(net, pool);
+			}
+			break;
+		case -EBUSY:
+			/* Too much to do */
+			if (pool->sp_nrthreads < pool->sp_nrthrmax) {
+				if (mutex_trylock(&nfsd_mutex)) {
+					if (pool->sp_nrthreads < pool->sp_nrthrmax) {
+						int ret;
+
+						trace_nfsd_dynthread_start(net, pool);
+						ret = svc_new_thread(rqstp->rq_server, pool);
+						if (ret)
+							pr_notice_ratelimited("%s: unable to spawn new thread: %d\n",
+									      __func__, ret);
+					}
+					mutex_unlock(&nfsd_mutex);
+				} else {
+					trace_nfsd_dynthread_trylock_fail(net, pool);
+				}
+			}
+			clear_bit(SP_TASK_STARTING, &pool->sp_flags);
+			break;
+		default:
+			break;
+		}
 		nfsd_file_net_dispose(nn);
 	}
 
@@ -910,6 +948,8 @@ nfsd(void *vrqstp)
 
 	/* Release the thread */
 	svc_exit_thread(rqstp);
+	if (have_mutex)
+		mutex_unlock(&nfsd_mutex);
 	return 0;
 }
 
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 5ae2a611e57f4b4e51a4d9eb6e0fccb66ad8d288..8885fd9bead98ebf55379d68ab9c3701981a5150 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -91,6 +91,41 @@ DEFINE_EVENT(nfsd_xdr_err_class, nfsd_##name##_err, \
 DEFINE_NFSD_XDR_ERR_EVENT(garbage_args);
 DEFINE_NFSD_XDR_ERR_EVENT(cant_encode);
 
+DECLARE_EVENT_CLASS(nfsd_dynthread_class,
+	TP_PROTO(
+		const struct net *net,
+		const struct svc_pool *pool
+	),
+	TP_ARGS(net, pool),
+	TP_STRUCT__entry(
+		__field(unsigned int, netns_ino)
+		__field(unsigned int, pool_id)
+		__field(unsigned int, nrthreads)
+		__field(unsigned int, nrthrmin)
+		__field(unsigned int, nrthrmax)
+	),
+	TP_fast_assign(
+		__entry->netns_ino = net->ns.inum;
+		__entry->pool_id = pool->sp_id;
+		__entry->nrthreads = pool->sp_nrthreads;
+		__entry->nrthrmin = pool->sp_nrthrmin;
+		__entry->nrthrmax = pool->sp_nrthrmax;
+	),
+	TP_printk("pool=%u nrthreads=%u nrthrmin=%u nrthrmax=%u",
+		__entry->pool_id, __entry->nrthreads,
+		__entry->nrthrmin, __entry->nrthrmax
+	)
+);
+
+#define DEFINE_NFSD_DYNTHREAD_EVENT(name) \
+DEFINE_EVENT(nfsd_dynthread_class, nfsd_dynthread_##name, \
+	TP_PROTO(const struct net *net, const struct svc_pool *pool), \
+	TP_ARGS(net, pool))
+
+DEFINE_NFSD_DYNTHREAD_EVENT(start);
+DEFINE_NFSD_DYNTHREAD_EVENT(kill);
+DEFINE_NFSD_DYNTHREAD_EVENT(trylock_fail);
+
 #define show_nfsd_may_flags(x)						\
 	__print_flags(x, "|",						\
 		{ NFSD_MAY_EXEC,		"EXEC" },		\

-- 
2.52.0


