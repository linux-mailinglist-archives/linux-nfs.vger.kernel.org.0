Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F8078D243
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Aug 2023 04:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241795AbjH3C6w (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Aug 2023 22:58:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241800AbjH3C6m (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Aug 2023 22:58:42 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F22CC9
        for <linux-nfs@vger.kernel.org>; Tue, 29 Aug 2023 19:58:39 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E0A28211E2;
        Wed, 30 Aug 2023 02:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693364317; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zrpGcNIXY/c9eUBbtJHrWJaLj28atrQ28uD8aoEE9Wo=;
        b=FJs6yieYEbVfO5jkm5qL8FPMvqZNABcXYRzxDP1rf+9AEuNuMehF4fsCTxJe4yc7K5J6V3
        k6EO8Co2QFZCBBiDxPI9ecuMpBwo/ddsKroK+EtcSCZypaRLoiBISTOrQr6M2MQEosvpu0
        ABwqXMTocv44PULYPQxOtCt8+SfsYdg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693364317;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zrpGcNIXY/c9eUBbtJHrWJaLj28atrQ28uD8aoEE9Wo=;
        b=JSOrCS/n+1mDd+gwRYoH+2N/4Lt4885Rahz7QJ+XWD7sIDscbwj+0RAelP5NAbeVwkxR86
        yMEF0tgCkTbcinBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A3C4913301;
        Wed, 30 Aug 2023 02:58:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id e6zKFVyw7mQBZAAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 30 Aug 2023 02:58:36 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 05/10] lib: add light-weight queuing mechanism.
Date:   Wed, 30 Aug 2023 12:54:48 +1000
Message-ID: <20230830025755.21292-6-neilb@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230830025755.21292-1-neilb@suse.de>
References: <20230830025755.21292-1-neilb@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

lwq is a FIFO single-linked queue that only requires a spinlock
for dequeueing, which happens in process context.  Enqueueing is atomic
with no spinlock and can happen in any context.

Include a unit test for basic functionality - runs at boot time.  Does
not use kunit framework.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 include/linux/lwq.h | 120 +++++++++++++++++++++++++++++++++++
 lib/Kconfig         |   5 ++
 lib/Makefile        |   2 +-
 lib/lwq.c           | 149 ++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 275 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/lwq.h
 create mode 100644 lib/lwq.c

diff --git a/include/linux/lwq.h b/include/linux/lwq.h
new file mode 100644
index 000000000000..52b9c81b493a
--- /dev/null
+++ b/include/linux/lwq.h
@@ -0,0 +1,120 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef LWQ_H
+#define LWQ_H
+/*
+ * light-weight single-linked queue built from llist
+ *
+ * Entries can be enqueued from any context with no locking.
+ * Entries can be dequeued from process context with integrated locking.
+ */
+#include <linux/container_of.h>
+#include <linux/spinlock.h>
+#include <linux/llist.h>
+
+struct lwq_node {
+	struct llist_node node;
+};
+
+struct lwq {
+	spinlock_t		lock;
+	struct llist_node	*ready;		/* entries to be dequeued */
+	struct llist_head	new;		/* entries being enqueued */
+};
+
+/**
+ * lwq_init - initialise a lwq
+ * @q:	the lwq object
+ */
+static inline void lwq_init(struct lwq *q)
+{
+	spin_lock_init(&q->lock);
+	q->ready = NULL;
+	init_llist_head(&q->new);
+}
+
+/**
+ * lwq_empty - test if lwq contains any entry
+ * @q:	the lwq object
+ *
+ * This empty test contains an acquire barrier so that if a wakeup
+ * is sent when lwq_dequeue returns true, it is safe to go to sleep after
+ * a test on lwq_empty().
+ */
+static inline bool lwq_empty(struct lwq *q)
+{
+	/* acquire ensures ordering wrt lwq_enqueue() */
+	return smp_load_acquire(&q->ready) == NULL && llist_empty(&q->new);
+}
+
+struct llist_node *__lwq_dequeue(struct lwq *q);
+/**
+ * lwq_dequeue - dequeue first (oldest) entry from lwq
+ * @q:		the queue to dequeue from
+ * @type:	the type of object to return
+ * @member:	them member in returned object which is an lwq_node.
+ *
+ * Remove a single object from the lwq and return it.  This will take
+ * a spinlock and so must always be called in the same context, typcially
+ * process contet.
+ */
+#define lwq_dequeue(q, type, member)					\
+	({ struct llist_node *_n = __lwq_dequeue(q);			\
+	  _n ? container_of(_n, type, member.node) : NULL; })
+
+struct llist_node *lwq_dequeue_all(struct lwq *q);
+
+/**
+ * lwq_for_each_safe - iterate over detached queue allowing deletion
+ * @_n:		iterator variable
+ * @_t1:	temporary struct llist_node **
+ * @_t2:	temporary struct llist_node *
+ * @_l:		address of llist_node pointer from lwq_dequeue_all()
+ * @_member:	member in _n where lwq_node is found.
+ *
+ * Iterate over members in a dequeued list.  If the iterator variable
+ * is set to NULL, the iterator removes that entry from the queue.
+ */
+#define lwq_for_each_safe(_n, _t1, _t2, _l, _member)			\
+	for (_t1 = (_l);						\
+	     *(_t1) ? (_n = container_of(*(_t1), typeof(*(_n)), _member.node),\
+		       _t2 = ((*_t1)->next),				\
+		       true)						\
+	     : false;							\
+	     (_n) ? (_t1 = &(_n)->_member.node.next, 0)			\
+	     : ((*(_t1) = (_t2)),  0))
+
+/**
+ * lwq_enqueue - add a new item to the end of the queue
+ * @n	- the lwq_node embedded in the item to be added
+ * @q	- the lwq to append to.
+ *
+ * No locking is needed to append to the queue so this can
+ * be called from any context.
+ * Return %true is the list may have previously been empty.
+ */
+static inline bool lwq_enqueue(struct lwq_node *n, struct lwq *q)
+{
+	/* acquire enqures ordering wrt lwq_dequeue */
+	return llist_add(&n->node, &q->new) &&
+		smp_load_acquire(&q->ready) == NULL;
+}
+
+/**
+ * lwq_enqueue_batch - add a list of new items to the end of the queue
+ * @n	- the lwq_node embedded in the first item to be added
+ * @q	- the lwq to append to.
+ *
+ * No locking is needed to append to the queue so this can
+ * be called from any context.
+ * Return %true is the list may have previously been empty.
+ */
+static inline bool lwq_enqueue_batch(struct llist_node *n, struct lwq *q)
+{
+	struct llist_node *e = n;
+
+	/* acquire enqures ordering wrt lwq_dequeue */
+	return llist_add_batch(llist_reverse_order(n), e, &q->new) &&
+		smp_load_acquire(&q->ready) == NULL;
+}
+#endif /* LWQ_H */
diff --git a/lib/Kconfig b/lib/Kconfig
index 5c2da561c516..6620bdba4f94 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -763,3 +763,8 @@ config ASN1_ENCODER
 
 config POLYNOMIAL
        tristate
+
+config LWQ_TEST
+	bool "RPC: enable boot-time test for lwq queuing"
+	help
+          Enable boot-time test of lwq functionality.
diff --git a/lib/Makefile b/lib/Makefile
index 1ffae65bb7ee..4b67c2d6af62 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -45,7 +45,7 @@ obj-y	+= lockref.o
 obj-y += bcd.o sort.o parser.o debug_locks.o random32.o \
 	 bust_spinlocks.o kasprintf.o bitmap.o scatterlist.o \
 	 list_sort.o uuid.o iov_iter.o clz_ctz.o \
-	 bsearch.o find_bit.o llist.o memweight.o kfifo.o \
+	 bsearch.o find_bit.o llist.o lwq.o memweight.o kfifo.o \
 	 percpu-refcount.o rhashtable.o base64.o \
 	 once.o refcount.o rcuref.o usercopy.o errseq.o bucket_locks.o \
 	 generic-radix-tree.o
diff --git a/lib/lwq.c b/lib/lwq.c
new file mode 100644
index 000000000000..d6be6dda3867
--- /dev/null
+++ b/lib/lwq.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Light weight single-linked queue.
+ *
+ * Entries are enqueued to the head of an llist, with no blocking.
+ * This can happen in any context.
+ *
+ * Entries are dequeued using a spinlock to protect against
+ * multiple access.  The llist is staged in reverse order, and refreshed
+ * from the llist when it exhausts.
+ */
+#include <linux/rcupdate.h>
+#include <linux/lwq.h>
+
+struct llist_node *__lwq_dequeue(struct lwq *q)
+{
+	struct llist_node *this;
+
+	if (lwq_empty(q))
+		return NULL;
+	spin_lock(&q->lock);
+	this = q->ready;
+	if (!this && !llist_empty(&q->new)) {
+		/* ensure queue doesn't appear transiently lwq_empty */
+		smp_store_release(&q->ready, (void *)1);
+		this = llist_reverse_order(llist_del_all(&q->new));
+		if (!this)
+			q->ready = NULL;
+	}
+	if (this)
+		q->ready = llist_next(this);
+	spin_unlock(&q->lock);
+	return this;
+}
+
+/**
+ * lwq_dequeue_all - dequeue all currently enqueued objects
+ * @q:	the queue to dequeue from
+ *
+ * Remove and return a linked list of llist_nodes of all the objects that were
+ * in the queue. The first on the list will be the object that was least
+ * recently enqueued.
+ */
+struct llist_node *lwq_dequeue_all(struct lwq *q)
+{
+	struct llist_node *r, *t, **ep;
+
+	if (lwq_empty(q))
+		return NULL;
+
+	spin_lock(&q->lock);
+	r = q->ready;
+	q->ready = NULL;
+	t = llist_del_all(&q->new);
+	spin_unlock(&q->lock);
+	ep = &r;
+	while (*ep)
+		ep = &(*ep)->next;
+	*ep = llist_reverse_order(t);
+	return r;
+}
+
+#if IS_ENABLED(CONFIG_LWQ_TEST)
+
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/wait_bit.h>
+#include <linux/kthread.h>
+#include <linux/delay.h>
+struct tnode {
+	struct lwq_node n;
+	int i;
+	int c;
+};
+
+static int lwq_exercise(void *qv)
+{
+	struct lwq *q = qv;
+	int cnt;
+	struct tnode *t;
+
+	for (cnt = 0; cnt < 10000; cnt++) {
+		wait_var_event(q, (t = lwq_dequeue(q, struct tnode, n)) != NULL);
+		t->c++;
+		if (lwq_enqueue(&t->n, q))
+			wake_up_var(q);
+	}
+	while (!kthread_should_stop())
+		schedule_timeout_idle(1);
+	return 0;
+}
+
+static int lwq_test(void)
+{
+	int i;
+	struct lwq q;
+	struct llist_node *l, **t1, *t2;
+	struct tnode *t;
+	struct task_struct *threads[8];
+
+	printk(KERN_INFO "testing lwq....\n");
+	lwq_init(&q);
+	printk(KERN_INFO " lwq: run some threads\n");
+	for (i = 0; i < ARRAY_SIZE(threads); i++)
+		threads[i] = kthread_run(lwq_exercise, &q, "lwq-test-%d", i);
+	for (i = 0; i < 100; i++) {
+		t = kmalloc(sizeof(*t), GFP_KERNEL);
+		t->i = i;
+		t->c = 0;
+		if (lwq_enqueue(&t->n, &q))
+			wake_up_var(&q);
+	};
+	/* wait for threads to exit */
+	for (i = 0; i < ARRAY_SIZE(threads); i++)
+		if (!IS_ERR_OR_NULL(threads[i]))
+			kthread_stop(threads[i]);
+	printk(KERN_INFO " lwq: dequeue first 50:");
+	for (i = 0; i < 50 ; i++) {
+		if (i && (i % 10) == 0) {
+			printk(KERN_CONT "\n");
+			printk(KERN_INFO " lwq: ... ");
+		}
+		t = lwq_dequeue(&q, struct tnode, n);
+		printk(KERN_CONT " %d(%d)", t->i, t->c);
+		kfree(t);
+	}
+	printk(KERN_CONT "\n");
+	l = lwq_dequeue_all(&q);
+	printk(KERN_INFO " lwq: delete the multiples of 3 (test lwq_for_each_safe())\n");
+	lwq_for_each_safe(t, t1, t2, &l, n) {
+		if ((t->i % 3) == 0) {
+			t->i = -1;
+			kfree(t);
+			t = NULL;
+		}
+	}
+	if (l)
+		lwq_enqueue_batch(l, &q);
+	printk(KERN_INFO " lwq: dequeue remaining:");
+	while ((t = lwq_dequeue(&q, struct tnode, n)) != NULL) {
+		printk(KERN_CONT " %d", t->i);
+		kfree(t);
+	}
+	printk(KERN_CONT "\n");
+	return 0;
+}
+
+module_init(lwq_test);
+#endif /* CONFIG_LWQ_TEST*/
-- 
2.41.0

