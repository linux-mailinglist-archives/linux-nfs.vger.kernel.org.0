Return-Path: <linux-nfs+bounces-19140-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHcsBPCKnGl8JQQAu9opvQ
	(envelope-from <linux-nfs+bounces-19140-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 18:14:24 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A7717A859
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 18:14:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2E53B30639DB
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 17:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CDB32E6A3;
	Mon, 23 Feb 2026 17:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPwdRWdm"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA33328B7F;
	Mon, 23 Feb 2026 17:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771866620; cv=none; b=U3qxHtkZ++lVRZDVpZD6H9kzeQy0NnqQjq8CqEq3XJHEtj2eVrl0tneAQAICHOkcjLaKN/ZzFveFSZqVb/7HLf23naJtqYlZvpo5DZOKD4q9Xtih3iM/KZTD1WG7/WRZMFLjV5VxxNQxJOMSRodIANKs8cvOLP1N2b8MiueZIOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771866620; c=relaxed/simple;
	bh=33/7X3KkyPQB6+MoF02KVKFM3QLZsp57v/whKSIPst0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p+6PgjSXjw5r8BEZOIeNUTsnrLsXVXGc6lHJ30dwowRfF/6Hi4f+kaIcyKHh+IGhIfK+ozOLBccfjYjuEaSwFl04TC9KwjuWZla+LN0Ty5oqXsuRiNMc4HIUhLOEBj8/k5iS1X0+zQswKVQ3iyrEuXVmFiS54zSHHHZxmwS8/j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPwdRWdm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC97C2BCAF;
	Mon, 23 Feb 2026 17:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771866619;
	bh=33/7X3KkyPQB6+MoF02KVKFM3QLZsp57v/whKSIPst0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OPwdRWdmHM6Y/nRVj4OygNpTkDUUbmZ4waDUHA2OVR2ErtK9AlyPbSZqioGkXDUhh
	 TI+78SWwWNbu3NlBF5U1qKS43ySR2rfEdkCYHI/h8J7QRCyqSEaRw3JLdJpKeWS6w/
	 pNWT/ZBhL7dLbW+UawrYX9Tm9w90Nh5b/j5UZQ6R6QcR6Sc+wA4RSipajfiDQnUA37
	 MqnEazRVItnx5eUnX0GOUQQ596slmGkKXZ6cvpBBspCTvnxMlLtZZwmN/39o6mSG/x
	 SPfFlOheJRDY+ZRhO8SMCqwR4PEPtcJo32QKciSVCjfooG61iFQqVIU5lF+cf+cAQl
	 r4Qok67jCLoHQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 23 Feb 2026 12:09:59 -0500
Subject: [PATCH v2 2/4] sunrpc: convert queue_lock from global spinlock to
 per-cache-detail lock
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-sunrpc-cache-v2-2-91fc827c4d33@kernel.org>
References: <20260223-sunrpc-cache-v2-0-91fc827c4d33@kernel.org>
In-Reply-To: <20260223-sunrpc-cache-v2-0-91fc827c4d33@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7368; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=33/7X3KkyPQB6+MoF02KVKFM3QLZsp57v/whKSIPst0=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpnIn33oRpa7h3/u6/pYHwD8V4gO4D3dnAv6rXK
 YcP1KReqfWJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaZyJ9wAKCRAADmhBGVaC
 FY8ZD/9b/cH/Sciv4JTaVlZsY1wejPTdT5BZoenzdsDL9h2lmRDzyb3cKLN/Rx4qLKengGJh3kQ
 hQ/zM50eYDPKpXer57wnxuAp2AQY0NwUWQ7FizdFni2SamJgJvAjPZiGx93rD0/EK+MXxwTGEOQ
 KDnfrSpzBvJ8mPDPlkMoE9ZMRr2jvLOZACfg/9I6gDiBtH5xDtmXD4mGzQlhFb7GpnoWuE13D8H
 0Qt+iKs285doqN6vVfat8u5qVH+5PEgZI0uPBJ9ApSFMmqwts1+tKDl7GonoTee6NPhyHCcxy9O
 Y6udBjkKPmlEI6fCrKmFIiOx9l8XhbyCzkklKNE7yDnt/HjHwdrxZln3G0BWwx2Z6NNUoPQ5IDR
 VcLKYN42hTXV8qUscA3X8qZb4bQ5hgtysmqA/209YGRJYdr+vK79aKqZQkdFYecIvtpkpngZj5H
 fLQj/sECeiXBiWu0tOv45R2K0mevEAyGZjucT+yQXzhWRvK773DI43Y0sdeiFK8EzB726QjxzaK
 qUmMM8Jj2cdgC7MJoQN9YY4lZOP4ftb2HVQg+8rhU4Fv4va9lz3NzZlsq3wtJRlhvDSw6w3IrXu
 OslOZrugR7fkNUluMZmxzFwLyAgYpNYVaekDpfDopeBL8e4hd0hJqFytMtoBuQsLcRPbxdDKK3b
 eAybM6b1wISHWbg==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19140-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jlayton@kernel.org,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 42A7717A859
X-Rspamd-Action: no action

The global queue_lock serializes all upcall queue operations across
every cache_detail instance. Convert it to a per-cache-detail spinlock
so that different caches (e.g. auth.unix.ip vs nfsd.fh) no longer
contend with each other on queue operations.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/sunrpc/cache.h |  1 +
 net/sunrpc/cache.c           | 47 ++++++++++++++++++++++----------------------
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/include/linux/sunrpc/cache.h b/include/linux/sunrpc/cache.h
index e783132e481ff2593fdc5d323f7b3a08f85d4cd8..3d32dd1f7b05d35562d2064fed69877b3950fb51 100644
--- a/include/linux/sunrpc/cache.h
+++ b/include/linux/sunrpc/cache.h
@@ -113,6 +113,7 @@ struct cache_detail {
 
 	/* fields for communication over channel */
 	struct list_head	queue;
+	spinlock_t		queue_lock;
 
 	atomic_t		writers;		/* how many time is /channel open */
 	time64_t		last_close;		/* if no writers, when did last close */
diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index 86b3fd5a429d77f7f917f398a02cb7a5ff8dd1e0..1cfaae488c6c67a9797511804e4bbba16bcc70ae 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -400,6 +400,7 @@ void sunrpc_init_cache_detail(struct cache_detail *cd)
 {
 	spin_lock_init(&cd->hash_lock);
 	INIT_LIST_HEAD(&cd->queue);
+	spin_lock_init(&cd->queue_lock);
 	spin_lock(&cache_list_lock);
 	cd->nextcheck = 0;
 	cd->entries = 0;
@@ -803,8 +804,6 @@ void cache_clean_deferred(void *owner)
  *
  */
 
-static DEFINE_SPINLOCK(queue_lock);
-
 struct cache_queue {
 	struct list_head	list;
 	int			reader;	/* if 0, then request */
@@ -847,7 +846,7 @@ static ssize_t cache_read(struct file *filp, char __user *buf, size_t count,
 	inode_lock(inode); /* protect against multiple concurrent
 			      * readers on this file */
  again:
-	spin_lock(&queue_lock);
+	spin_lock(&cd->queue_lock);
 	/* need to find next request */
 	while (rp->q.list.next != &cd->queue &&
 	       list_entry(rp->q.list.next, struct cache_queue, list)
@@ -856,7 +855,7 @@ static ssize_t cache_read(struct file *filp, char __user *buf, size_t count,
 		list_move(&rp->q.list, next);
 	}
 	if (rp->q.list.next == &cd->queue) {
-		spin_unlock(&queue_lock);
+		spin_unlock(&cd->queue_lock);
 		inode_unlock(inode);
 		WARN_ON_ONCE(rp->offset);
 		return 0;
@@ -865,7 +864,7 @@ static ssize_t cache_read(struct file *filp, char __user *buf, size_t count,
 	WARN_ON_ONCE(rq->q.reader);
 	if (rp->offset == 0)
 		rq->readers++;
-	spin_unlock(&queue_lock);
+	spin_unlock(&cd->queue_lock);
 
 	if (rq->len == 0) {
 		err = cache_request(cd, rq);
@@ -876,9 +875,9 @@ static ssize_t cache_read(struct file *filp, char __user *buf, size_t count,
 
 	if (rp->offset == 0 && !test_bit(CACHE_PENDING, &rq->item->flags)) {
 		err = -EAGAIN;
-		spin_lock(&queue_lock);
+		spin_lock(&cd->queue_lock);
 		list_move(&rp->q.list, &rq->q.list);
-		spin_unlock(&queue_lock);
+		spin_unlock(&cd->queue_lock);
 	} else {
 		if (rp->offset + count > rq->len)
 			count = rq->len - rp->offset;
@@ -888,26 +887,26 @@ static ssize_t cache_read(struct file *filp, char __user *buf, size_t count,
 		rp->offset += count;
 		if (rp->offset >= rq->len) {
 			rp->offset = 0;
-			spin_lock(&queue_lock);
+			spin_lock(&cd->queue_lock);
 			list_move(&rp->q.list, &rq->q.list);
-			spin_unlock(&queue_lock);
+			spin_unlock(&cd->queue_lock);
 		}
 		err = 0;
 	}
  out:
 	if (rp->offset == 0) {
 		/* need to release rq */
-		spin_lock(&queue_lock);
+		spin_lock(&cd->queue_lock);
 		rq->readers--;
 		if (rq->readers == 0 &&
 		    !test_bit(CACHE_PENDING, &rq->item->flags)) {
 			list_del(&rq->q.list);
-			spin_unlock(&queue_lock);
+			spin_unlock(&cd->queue_lock);
 			cache_put(rq->item, cd);
 			kfree(rq->buf);
 			kfree(rq);
 		} else
-			spin_unlock(&queue_lock);
+			spin_unlock(&cd->queue_lock);
 	}
 	if (err == -EAGAIN)
 		goto again;
@@ -988,7 +987,7 @@ static __poll_t cache_poll(struct file *filp, poll_table *wait,
 	if (!rp)
 		return mask;
 
-	spin_lock(&queue_lock);
+	spin_lock(&cd->queue_lock);
 
 	for (cq= &rp->q; &cq->list != &cd->queue;
 	     cq = list_entry(cq->list.next, struct cache_queue, list))
@@ -996,7 +995,7 @@ static __poll_t cache_poll(struct file *filp, poll_table *wait,
 			mask |= EPOLLIN | EPOLLRDNORM;
 			break;
 		}
-	spin_unlock(&queue_lock);
+	spin_unlock(&cd->queue_lock);
 	return mask;
 }
 
@@ -1011,7 +1010,7 @@ static int cache_ioctl(struct inode *ino, struct file *filp,
 	if (cmd != FIONREAD || !rp)
 		return -EINVAL;
 
-	spin_lock(&queue_lock);
+	spin_lock(&cd->queue_lock);
 
 	/* only find the length remaining in current request,
 	 * or the length of the next request
@@ -1024,7 +1023,7 @@ static int cache_ioctl(struct inode *ino, struct file *filp,
 			len = cr->len - rp->offset;
 			break;
 		}
-	spin_unlock(&queue_lock);
+	spin_unlock(&cd->queue_lock);
 
 	return put_user(len, (int __user *)arg);
 }
@@ -1046,9 +1045,9 @@ static int cache_open(struct inode *inode, struct file *filp,
 		rp->offset = 0;
 		rp->q.reader = 1;
 
-		spin_lock(&queue_lock);
+		spin_lock(&cd->queue_lock);
 		list_add(&rp->q.list, &cd->queue);
-		spin_unlock(&queue_lock);
+		spin_unlock(&cd->queue_lock);
 	}
 	if (filp->f_mode & FMODE_WRITE)
 		atomic_inc(&cd->writers);
@@ -1064,7 +1063,7 @@ static int cache_release(struct inode *inode, struct file *filp,
 	if (rp) {
 		struct cache_request *rq = NULL;
 
-		spin_lock(&queue_lock);
+		spin_lock(&cd->queue_lock);
 		if (rp->offset) {
 			struct cache_queue *cq;
 			for (cq = &rp->q; &cq->list != &cd->queue;
@@ -1086,7 +1085,7 @@ static int cache_release(struct inode *inode, struct file *filp,
 			rp->offset = 0;
 		}
 		list_del(&rp->q.list);
-		spin_unlock(&queue_lock);
+		spin_unlock(&cd->queue_lock);
 
 		if (rq) {
 			cache_put(rq->item, cd);
@@ -1113,7 +1112,7 @@ static void cache_dequeue(struct cache_detail *detail, struct cache_head *ch)
 	struct cache_request *cr;
 	LIST_HEAD(dequeued);
 
-	spin_lock(&queue_lock);
+	spin_lock(&detail->queue_lock);
 	list_for_each_entry_safe(cq, tmp, &detail->queue, list)
 		if (!cq->reader) {
 			cr = container_of(cq, struct cache_request, q);
@@ -1126,7 +1125,7 @@ static void cache_dequeue(struct cache_detail *detail, struct cache_head *ch)
 				continue;
 			list_move(&cr->q.list, &dequeued);
 		}
-	spin_unlock(&queue_lock);
+	spin_unlock(&detail->queue_lock);
 	while (!list_empty(&dequeued)) {
 		cr = list_entry(dequeued.next, struct cache_request, q.list);
 		list_del(&cr->q.list);
@@ -1251,7 +1250,7 @@ static int cache_pipe_upcall(struct cache_detail *detail, struct cache_head *h)
 	crq->buf = buf;
 	crq->len = 0;
 	crq->readers = 0;
-	spin_lock(&queue_lock);
+	spin_lock(&detail->queue_lock);
 	if (test_bit(CACHE_PENDING, &h->flags)) {
 		crq->item = cache_get(h);
 		list_add_tail(&crq->q.list, &detail->queue);
@@ -1259,7 +1258,7 @@ static int cache_pipe_upcall(struct cache_detail *detail, struct cache_head *h)
 	} else
 		/* Lost a race, no longer PENDING, so don't enqueue */
 		ret = -EAGAIN;
-	spin_unlock(&queue_lock);
+	spin_unlock(&detail->queue_lock);
 	wake_up(&queue_wait);
 	if (ret == -EAGAIN) {
 		kfree(buf);

-- 
2.53.0


