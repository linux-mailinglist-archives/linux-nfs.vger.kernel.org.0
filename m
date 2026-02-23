Return-Path: <linux-nfs+bounces-19142-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJwgEg2LnGl8JQQAu9opvQ
	(envelope-from <linux-nfs+bounces-19142-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 18:14:53 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 663EB17A870
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 18:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7FF1C306ED01
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Feb 2026 17:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C423532ED46;
	Mon, 23 Feb 2026 17:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LwU/bjxy"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6672832B99C;
	Mon, 23 Feb 2026 17:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771866622; cv=none; b=oTH78BhmDCI3RlhSmObsGDW6JLI1cXoSewNGyxcNJdWY1qVLArsNc1yytgMBmPMq6chkuD6MTSQWuX5Ic0iuloVwbxGaGFaD4VgfhvIboAUb5BLlXEC6n/FyiVBUoBCppTuNJNvQcPVD1Q8T86gELqViPWLqKx58Rixlfl1NVSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771866622; c=relaxed/simple;
	bh=dNeT2z5g6QrxREtVSzcWt3Mo1ZrVqGJUQrUAUu9NNCQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W1egBMcT/lqjuuRqyxFypW21qDSppBBWYA1l+eUEEZjcwF13dxq/7451YT0UWGIN4Gngu+0mbfvkOHEUmxpizW958b88guoPfa1Tcr2yQVgnwXI/k30bXZJDXAjYyftkxLPSNDPijA7ADVWu2SIVZAn60XGAS8umDSS7Q210yCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LwU/bjxy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D2D2C2BC9E;
	Mon, 23 Feb 2026 17:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771866622;
	bh=dNeT2z5g6QrxREtVSzcWt3Mo1ZrVqGJUQrUAUu9NNCQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LwU/bjxyxwSJgXwMY1nlBUz4A8FR1A++tb9HfqVpKfS+LUt9rn/bNGOoV/wxeT5iO
	 HLcaWVaokCjMUgd+Awe7NbxwMrJc/EQ9lVFKYfVMDawdnVWP8ouE+5ge5thBsj+pRZ
	 h9ULPxPPa7manV1NB8145ApgdqReVlyXZ252NDfyr0JYCEYw4eqmgCXu8U4ZU8i09k
	 GNVuk/GedNgRJvxHZjYnvXkzHoZOPDgmF90XaNDyhpMVxo4aM2MOih7+2G9wrE3U19
	 ZgKc2msZ/3/WM91GL4+vcDpKlUj/heUh0b3lDyM93rExrqS30irDIf/qriU8F6Wup7
	 z4/GerCAK8nVQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Mon, 23 Feb 2026 12:10:01 -0500
Subject: [PATCH v2 4/4] sunrpc: split cache_detail queue into request and
 reader lists
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260223-sunrpc-cache-v2-4-91fc827c4d33@kernel.org>
References: <20260223-sunrpc-cache-v2-0-91fc827c4d33@kernel.org>
In-Reply-To: <20260223-sunrpc-cache-v2-0-91fc827c4d33@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=10533; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=dNeT2z5g6QrxREtVSzcWt3Mo1ZrVqGJUQrUAUu9NNCQ=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBpnIn4UyxP/JnnMn9p7NxFBK3u7lDwZ6/sVNmkC
 lc+lZUZzhSJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaZyJ+AAKCRAADmhBGVaC
 FYK/EACurrSZplxEceCB+FxBYZwFi9i/HJoXHcGHARCKDSSVdtfvVZjz35hcK1VgLIoV268mZAL
 OcQX7pYJM7GX9siNoA9Y0Soz71SZkzQGhQu77zSOBmEwxPy4iu6+bqUvTa3/4v6ML+/FnFnu5So
 RSBQdA9f/A3xdq3saqs9bEFChFBPX8UHAvISZkiz3pAsrb2eq5eacOchs0p3hurWUn0ezNy0bSJ
 eJEBuRF1ak02xRcF2Fd6S4v4QMmoA09aTmTtJz627yghfYzxqHh3kMTHzMyChtBmdHjflqUENqw
 PfcQS61BfY0fjIgkUIvrBv+cXaBXHOsoiC+RavkNtLkLIUcFffJyZtGtigbRqoVZ9bA9GvTRCfI
 VLVUfSxxm268bldIOOStUL+V5g4KCg6a+Gfx3IEqVfIifA1AzRmY2EPESUA7RpQ77bpNBHiq9FR
 lqcUmiv5xZ6urdBVG+zHhFztUccul431sPraiPI8Y43qBojNqVb5Dls7/lAZDNGrvgI5+766E6Z
 PTlE3zft0nW0lYGoD97qrfUd2E4852bE2QYZBduJlHX8N3HRHMyMzXFIq1MujkMTToRHwnWz2S3
 C6T/FcC7bJzvCm30HxXboTlC44gKuaRuxdxwX4v1pMl9HwvAMr8slJMqAOxeuYjw26Fo0Ojns5U
 b8XOCJaMYhJkWwQ==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19142-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 663EB17A870
X-Rspamd-Action: no action

Replace the single interleaved queue (which mixed cache_request and
cache_reader entries distinguished by a ->reader flag) with two
dedicated lists: cd->requests for upcall requests and cd->readers
for open file handles.

Readers now track their position via a monotonically increasing
sequence number (next_seqno) rather than by their position in the
shared list. Each cache_request is assigned a seqno when enqueued,
and a new cache_next_request() helper finds the next request at or
after a given seqno.

This eliminates the cache_queue wrapper struct entirely, simplifies
the reader-skipping loops in cache_read/cache_poll/cache_ioctl/
cache_release, and makes the data flow easier to reason about.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/sunrpc/cache.h |   4 +-
 net/sunrpc/cache.c           | 143 ++++++++++++++++++-------------------------
 2 files changed, 62 insertions(+), 85 deletions(-)

diff --git a/include/linux/sunrpc/cache.h b/include/linux/sunrpc/cache.h
index 031379efba24d40f64ce346cf1032261d4b98d05..b1e595c2615bd4be4d9ad19f71a8f4d08bd74a9b 100644
--- a/include/linux/sunrpc/cache.h
+++ b/include/linux/sunrpc/cache.h
@@ -113,9 +113,11 @@ struct cache_detail {
 	int			entries;
 
 	/* fields for communication over channel */
-	struct list_head	queue;
+	struct list_head	requests;
+	struct list_head	readers;
 	spinlock_t		queue_lock;
 	wait_queue_head_t	queue_wait;
+	u64			next_seqno;
 
 	atomic_t		writers;		/* how many time is /channel open */
 	time64_t		last_close;		/* if no writers, when did last close */
diff --git a/net/sunrpc/cache.c b/net/sunrpc/cache.c
index fd02dca1f07afec2f09c591037bac3ea3e8d7e17..7081c1214e6c3226f8ac82c8bc7ff6c36f598744 100644
--- a/net/sunrpc/cache.c
+++ b/net/sunrpc/cache.c
@@ -399,9 +399,11 @@ static struct delayed_work cache_cleaner;
 void sunrpc_init_cache_detail(struct cache_detail *cd)
 {
 	spin_lock_init(&cd->hash_lock);
-	INIT_LIST_HEAD(&cd->queue);
+	INIT_LIST_HEAD(&cd->requests);
+	INIT_LIST_HEAD(&cd->readers);
 	spin_lock_init(&cd->queue_lock);
 	init_waitqueue_head(&cd->queue_wait);
+	cd->next_seqno = 0;
 	spin_lock(&cache_list_lock);
 	cd->nextcheck = 0;
 	cd->entries = 0;
@@ -796,29 +798,20 @@ void cache_clean_deferred(void *owner)
  * On read, you get a full request, or block.
  * On write, an update request is processed.
  * Poll works if anything to read, and always allows write.
- *
- * Implemented by linked list of requests.  Each open file has
- * a ->private that also exists in this list.  New requests are added
- * to the end and may wakeup and preceding readers.
- * New readers are added to the head.  If, on read, an item is found with
- * CACHE_UPCALLING clear, we free it from the list.
- *
  */
 
-struct cache_queue {
-	struct list_head	list;
-	int			reader;	/* if 0, then request */
-};
 struct cache_request {
-	struct cache_queue	q;
+	struct list_head	list;
 	struct cache_head	*item;
-	char			* buf;
+	char			*buf;
 	int			len;
 	int			readers;
+	u64			seqno;
 };
 struct cache_reader {
-	struct cache_queue	q;
+	struct list_head	list;
 	int			offset;	/* if non-0, we have a refcnt on next request */
+	u64			next_seqno;
 };
 
 static int cache_request(struct cache_detail *detail,
@@ -833,6 +826,17 @@ static int cache_request(struct cache_detail *detail,
 	return PAGE_SIZE - len;
 }
 
+static struct cache_request *
+cache_next_request(struct cache_detail *cd, u64 seqno)
+{
+	struct cache_request *rq;
+
+	list_for_each_entry(rq, &cd->requests, list)
+		if (rq->seqno >= seqno)
+			return rq;
+	return NULL;
+}
+
 static ssize_t cache_read(struct file *filp, char __user *buf, size_t count,
 			  loff_t *ppos, struct cache_detail *cd)
 {
@@ -849,20 +853,13 @@ static ssize_t cache_read(struct file *filp, char __user *buf, size_t count,
  again:
 	spin_lock(&cd->queue_lock);
 	/* need to find next request */
-	while (rp->q.list.next != &cd->queue &&
-	       list_entry(rp->q.list.next, struct cache_queue, list)
-	       ->reader) {
-		struct list_head *next = rp->q.list.next;
-		list_move(&rp->q.list, next);
-	}
-	if (rp->q.list.next == &cd->queue) {
+	rq = cache_next_request(cd, rp->next_seqno);
+	if (!rq) {
 		spin_unlock(&cd->queue_lock);
 		inode_unlock(inode);
 		WARN_ON_ONCE(rp->offset);
 		return 0;
 	}
-	rq = container_of(rp->q.list.next, struct cache_request, q.list);
-	WARN_ON_ONCE(rq->q.reader);
 	if (rp->offset == 0)
 		rq->readers++;
 	spin_unlock(&cd->queue_lock);
@@ -876,9 +873,7 @@ static ssize_t cache_read(struct file *filp, char __user *buf, size_t count,
 
 	if (rp->offset == 0 && !test_bit(CACHE_PENDING, &rq->item->flags)) {
 		err = -EAGAIN;
-		spin_lock(&cd->queue_lock);
-		list_move(&rp->q.list, &rq->q.list);
-		spin_unlock(&cd->queue_lock);
+		rp->next_seqno = rq->seqno + 1;
 	} else {
 		if (rp->offset + count > rq->len)
 			count = rq->len - rp->offset;
@@ -888,9 +883,7 @@ static ssize_t cache_read(struct file *filp, char __user *buf, size_t count,
 		rp->offset += count;
 		if (rp->offset >= rq->len) {
 			rp->offset = 0;
-			spin_lock(&cd->queue_lock);
-			list_move(&rp->q.list, &rq->q.list);
-			spin_unlock(&cd->queue_lock);
+			rp->next_seqno = rq->seqno + 1;
 		}
 		err = 0;
 	}
@@ -901,7 +894,7 @@ static ssize_t cache_read(struct file *filp, char __user *buf, size_t count,
 		rq->readers--;
 		if (rq->readers == 0 &&
 		    !test_bit(CACHE_PENDING, &rq->item->flags)) {
-			list_del(&rq->q.list);
+			list_del(&rq->list);
 			spin_unlock(&cd->queue_lock);
 			cache_put(rq->item, cd);
 			kfree(rq->buf);
@@ -976,7 +969,6 @@ static __poll_t cache_poll(struct file *filp, poll_table *wait,
 {
 	__poll_t mask;
 	struct cache_reader *rp = filp->private_data;
-	struct cache_queue *cq;
 
 	poll_wait(filp, &cd->queue_wait, wait);
 
@@ -988,12 +980,8 @@ static __poll_t cache_poll(struct file *filp, poll_table *wait,
 
 	spin_lock(&cd->queue_lock);
 
-	for (cq= &rp->q; &cq->list != &cd->queue;
-	     cq = list_entry(cq->list.next, struct cache_queue, list))
-		if (!cq->reader) {
-			mask |= EPOLLIN | EPOLLRDNORM;
-			break;
-		}
+	if (cache_next_request(cd, rp->next_seqno))
+		mask |= EPOLLIN | EPOLLRDNORM;
 	spin_unlock(&cd->queue_lock);
 	return mask;
 }
@@ -1004,7 +992,7 @@ static int cache_ioctl(struct inode *ino, struct file *filp,
 {
 	int len = 0;
 	struct cache_reader *rp = filp->private_data;
-	struct cache_queue *cq;
+	struct cache_request *rq;
 
 	if (cmd != FIONREAD || !rp)
 		return -EINVAL;
@@ -1014,14 +1002,9 @@ static int cache_ioctl(struct inode *ino, struct file *filp,
 	/* only find the length remaining in current request,
 	 * or the length of the next request
 	 */
-	for (cq= &rp->q; &cq->list != &cd->queue;
-	     cq = list_entry(cq->list.next, struct cache_queue, list))
-		if (!cq->reader) {
-			struct cache_request *cr =
-				container_of(cq, struct cache_request, q);
-			len = cr->len - rp->offset;
-			break;
-		}
+	rq = cache_next_request(cd, rp->next_seqno);
+	if (rq)
+		len = rq->len - rp->offset;
 	spin_unlock(&cd->queue_lock);
 
 	return put_user(len, (int __user *)arg);
@@ -1042,10 +1025,10 @@ static int cache_open(struct inode *inode, struct file *filp,
 			return -ENOMEM;
 		}
 		rp->offset = 0;
-		rp->q.reader = 1;
+		rp->next_seqno = 0;
 
 		spin_lock(&cd->queue_lock);
-		list_add(&rp->q.list, &cd->queue);
+		list_add(&rp->list, &cd->readers);
 		spin_unlock(&cd->queue_lock);
 	}
 	if (filp->f_mode & FMODE_WRITE)
@@ -1064,26 +1047,21 @@ static int cache_release(struct inode *inode, struct file *filp,
 
 		spin_lock(&cd->queue_lock);
 		if (rp->offset) {
-			struct cache_queue *cq;
-			for (cq = &rp->q; &cq->list != &cd->queue;
-			     cq = list_entry(cq->list.next,
-					     struct cache_queue, list))
-				if (!cq->reader) {
-					struct cache_request *cr =
-						container_of(cq,
-						struct cache_request, q);
-					cr->readers--;
-					if (cr->readers == 0 &&
-					    !test_bit(CACHE_PENDING,
-						      &cr->item->flags)) {
-						list_del(&cr->q.list);
-						rq = cr;
-					}
-					break;
+			struct cache_request *cr;
+
+			cr = cache_next_request(cd, rp->next_seqno);
+			if (cr) {
+				cr->readers--;
+				if (cr->readers == 0 &&
+				    !test_bit(CACHE_PENDING,
+					      &cr->item->flags)) {
+					list_del(&cr->list);
+					rq = cr;
 				}
+			}
 			rp->offset = 0;
 		}
-		list_del(&rp->q.list);
+		list_del(&rp->list);
 		spin_unlock(&cd->queue_lock);
 
 		if (rq) {
@@ -1107,27 +1085,24 @@ static int cache_release(struct inode *inode, struct file *filp,
 
 static void cache_dequeue(struct cache_detail *detail, struct cache_head *ch)
 {
-	struct cache_queue *cq, *tmp;
-	struct cache_request *cr;
+	struct cache_request *cr, *tmp;
 	LIST_HEAD(dequeued);
 
 	spin_lock(&detail->queue_lock);
-	list_for_each_entry_safe(cq, tmp, &detail->queue, list)
-		if (!cq->reader) {
-			cr = container_of(cq, struct cache_request, q);
-			if (cr->item != ch)
-				continue;
-			if (test_bit(CACHE_PENDING, &ch->flags))
-				/* Lost a race and it is pending again */
-				break;
-			if (cr->readers != 0)
-				continue;
-			list_move(&cr->q.list, &dequeued);
-		}
+	list_for_each_entry_safe(cr, tmp, &detail->requests, list) {
+		if (cr->item != ch)
+			continue;
+		if (test_bit(CACHE_PENDING, &ch->flags))
+			/* Lost a race and it is pending again */
+			break;
+		if (cr->readers != 0)
+			continue;
+		list_move(&cr->list, &dequeued);
+	}
 	spin_unlock(&detail->queue_lock);
 	while (!list_empty(&dequeued)) {
-		cr = list_entry(dequeued.next, struct cache_request, q.list);
-		list_del(&cr->q.list);
+		cr = list_entry(dequeued.next, struct cache_request, list);
+		list_del(&cr->list);
 		cache_put(cr->item, detail);
 		kfree(cr->buf);
 		kfree(cr);
@@ -1245,14 +1220,14 @@ static int cache_pipe_upcall(struct cache_detail *detail, struct cache_head *h)
 		return -EAGAIN;
 	}
 
-	crq->q.reader = 0;
 	crq->buf = buf;
 	crq->len = 0;
 	crq->readers = 0;
 	spin_lock(&detail->queue_lock);
 	if (test_bit(CACHE_PENDING, &h->flags)) {
 		crq->item = cache_get(h);
-		list_add_tail(&crq->q.list, &detail->queue);
+		crq->seqno = detail->next_seqno++;
+		list_add_tail(&crq->list, &detail->requests);
 		trace_cache_entry_upcall(detail, h);
 	} else
 		/* Lost a race, no longer PENDING, so don't enqueue */

-- 
2.53.0


