Return-Path: <linux-nfs+bounces-19061-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEsVAvtSmGk1GQMAu9opvQ
	(envelope-from <linux-nfs+bounces-19061-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Feb 2026 13:26:35 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 886BC1677B8
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Feb 2026 13:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82C1730626D0
	for <lists+linux-nfs@lfdr.de>; Fri, 20 Feb 2026 12:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEDA34403A;
	Fri, 20 Feb 2026 12:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LQ8UB1WR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591E0344030;
	Fri, 20 Feb 2026 12:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771590379; cv=none; b=PrGOPY3QJUe2YdMgMTbjq+y72F/dAcsMck9OX761a9a7ZEvzFUkovAkTg1susJdyx/ZbYfrA4Z4I64zYTjYUaOlDyGtYwkF/OoLeDjXTByqFFJzgOYYHo2zeoulf3Jcn9dW20KMGDKncD4PwjpY1zlK/HbbHaK/xyH4peQU5m3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771590379; c=relaxed/simple;
	bh=m1c8dJhQxsPdS1HZ45hz/jGJrNNSoR81GQDVypuwaNE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bFkpgviVv0b9PYbjn+7/dRTjMd+MvYSPdsPgTPIWWVZYKLZULo0NQ53W2+xitcXUMaTsGiNYF/vyarFlxNmDX4hQ0tFrRo+rOhu9DamCg79q3/dFHpuP0WkjM4SgQy6JVGlmygo+qxyDA5hqxBj7jxxyAWPAqF0079oZwgU7YYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LQ8UB1WR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54B8DC116D0;
	Fri, 20 Feb 2026 12:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771590379;
	bh=m1c8dJhQxsPdS1HZ45hz/jGJrNNSoR81GQDVypuwaNE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LQ8UB1WRQ9hSOJJww9QnQhOpAtg9AFnRcF1SvhV0ALhT7QSK6EwNI3EFEtDtPHE9b
	 McxPHggVSZ2j8tRro75nwcHsu0t30SqItmX52oMnIQ2ED7ufUvHFK2n1eZaVIfzzm/
	 AwAMpKQw8feWB8Y1X2jRrpyNMDjSg22QwkTkI4R7j7OuewGy5aSkNtKMvsAvl6LCaZ
	 X1SI+5+lwq8FsFLbb7Lc//8UA8LvSIENA+YmHWOB5HittfuZdG9d1TTRs95hBJfuWo
	 RsSRWI6qwOOt2tDBN5mylwBRGV0hHa4npQktbKjoRCKC5ZLyGNl7fKJpv5YbtrVTA0
	 Ej/1U2MV3hLEQ==
From: Jeff Layton <jlayton@kernel.org>
Date: Fri, 20 Feb 2026 07:26:03 -0500
Subject: [PATCH 1/3] sunrpc: convert queue_lock from global spinlock to
 per-cache_detail lock
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260220-sunrpc-cache-v1-1-47d04014c245@kernel.org>
References: <20260220-sunrpc-cache-v1-0-47d04014c245@kernel.org>
In-Reply-To: <20260220-sunrpc-cache-v1-0-47d04014c245@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, 
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>, 
 Anna Schumaker <anna@kernel.org>
Cc: linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Layton <jlayton@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7381; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=m1c8dJhQxsPdS1HZ45hz/jGJrNNSoR81GQDVypuwaNE=;
 b=kA0DAAoBAA5oQRlWghUByyZiAGmYUuiiozk78cE9mBaz/DRpzSO/YrWNR8yN2072G6z/dhI1E
 4kCMwQAAQoAHRYhBEvA17JEcbKhhOr10wAOaEEZVoIVBQJpmFLoAAoJEAAOaEEZVoIVjGoQAKAL
 Iq4fJFDFUWAaEt+A6N3DaL/CeTzmrvTGteqjjRNXIUE+12jA1/ygUibi8lSbytuuRGNwKF9sqPN
 aXYTxRbCh81RaepK2iSC8ofdBMFezCSydqOmTru34RecuAJoX8Nio07zQdDVavYkh2WmCyKQaDI
 cr1D2f1czPdp5PhWDha9WhpR420izQOiPq6fB47NxQa37PoM23gCmVFb08ot2Ira7Nwj9kZMI9T
 V7x+TvEbxmneQvf1fWaljes06jugRkvfgAR6MTII2jEgEF0mL/AgSa0rSO7UwS4c+0Tdr8hO8wB
 ZkaIaPfoceAZbxTL6TJZspjBqfP0/+riyA4GT1e3BKFSiHKQtu2eAtIomyA9IriCGgDl/lXTvpF
 qG7WJU4RsRQDVGM3SPbrlSlD76y5sUWW5vgKkA2VXc+Sp6BE7ze28q9T9Z5iHfqqcyEBPyh/maJ
 T6nLXmIoUFRTWVwm6zqW+Scp31Zu/0L5l7fDP8An4mrrQAUk5I8Cg7RlhwS/eY4tpjaTkRxAEo2
 Wdi6/GAzIGJc/Nb/wNMTGHxjkp+XkzmwJZUjCvXFkelWsy1/Ne6TxLG48V67ZmqRbXHWcPxa7gI
 Jz/1kj1gfGjHO/ny/wCTlTb9sYB9Z6VR5Lnval+bshRNWj7+tZZ6U+DcCec7SEhU6FsJWMs2stW
 PijiS
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19061-lists,linux-nfs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 886BC1677B8
X-Rspamd-Action: no action

The global queue_lock serializes all upcall queue operations across
every cache_detail instance. Convert it to a per-cache_detail spinlock
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
index 7c73d1c39687343db02d1f1423b58213b7a35f42..6add2fe311425dc3aec63efce2c4bed06a3d3ba5 100644
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
@@ -1062,7 +1061,7 @@ static int cache_release(struct inode *inode, struct file *filp,
 	struct cache_reader *rp = filp->private_data;
 
 	if (rp) {
-		spin_lock(&queue_lock);
+		spin_lock(&cd->queue_lock);
 		if (rp->offset) {
 			struct cache_queue *cq;
 			for (cq= &rp->q; &cq->list != &cd->queue;
@@ -1075,7 +1074,7 @@ static int cache_release(struct inode *inode, struct file *filp,
 			rp->offset = 0;
 		}
 		list_del(&rp->q.list);
-		spin_unlock(&queue_lock);
+		spin_unlock(&cd->queue_lock);
 
 		filp->private_data = NULL;
 		kfree(rp);
@@ -1097,7 +1096,7 @@ static void cache_dequeue(struct cache_detail *detail, struct cache_head *ch)
 	struct cache_request *cr;
 	LIST_HEAD(dequeued);
 
-	spin_lock(&queue_lock);
+	spin_lock(&detail->queue_lock);
 	list_for_each_entry_safe(cq, tmp, &detail->queue, list)
 		if (!cq->reader) {
 			cr = container_of(cq, struct cache_request, q);
@@ -1110,7 +1109,7 @@ static void cache_dequeue(struct cache_detail *detail, struct cache_head *ch)
 				continue;
 			list_move(&cr->q.list, &dequeued);
 		}
-	spin_unlock(&queue_lock);
+	spin_unlock(&detail->queue_lock);
 	while (!list_empty(&dequeued)) {
 		cr = list_entry(dequeued.next, struct cache_request, q.list);
 		list_del(&cr->q.list);
@@ -1235,7 +1234,7 @@ static int cache_pipe_upcall(struct cache_detail *detail, struct cache_head *h)
 	crq->buf = buf;
 	crq->len = 0;
 	crq->readers = 0;
-	spin_lock(&queue_lock);
+	spin_lock(&detail->queue_lock);
 	if (test_bit(CACHE_PENDING, &h->flags)) {
 		crq->item = cache_get(h);
 		list_add_tail(&crq->q.list, &detail->queue);
@@ -1243,7 +1242,7 @@ static int cache_pipe_upcall(struct cache_detail *detail, struct cache_head *h)
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


