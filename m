Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732FB79B4BF
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 02:02:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239749AbjIKV7E (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Sep 2023 17:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240244AbjIKOju (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Sep 2023 10:39:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 585D1CF0;
        Mon, 11 Sep 2023 07:39:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51429C433CA;
        Mon, 11 Sep 2023 14:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694443185;
        bh=WMdHXTlK/F0alepEMWR0Tsn0KrNf5+HlS3u9OgTC6Ek=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=hAz0KziwdfpN4FcKQKXqH6M4J//hyNrlyd84XO9W6PhD2igr2qtJrbIBjTiB15MVV
         i6T+QMQZl5+4IljzbFHvWJPjTTK6kUrui9qkZP0z3n8i/ebIm/TGr+3tPlur1VIdh5
         2nUKG+FpEvbZQVCQIVO3mOxEKoywJY2wP+NtKR/SF0CMtba8T73y9w+zav1DhnIIfn
         Rgu4Mv40CCXGgz+ZQsrTbYQGvSUAqma1FYAjq+aZWGPyXNGl8oDIfMzE9wNsHB+kwc
         2kRivVCxk2drPt6KDtXlpqtKelFPmYiBZBOms8Y8K7YEJnJon2O0RwE1CFBcSH5YKe
         4uaJbUuQtNKsA==
Subject: [PATCH v1 11/17] lib: add light-weight queuing mechanism.
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     NeilBrown <neilb@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org,
        Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 11 Sep 2023 10:39:43 -0400
Message-ID: <169444318342.4327.18355944158180782708.stgit@bazille.1015granger.net>
In-Reply-To: <169444233785.4327.4365499966926096681.stgit@bazille.1015granger.net>
References: <169444233785.4327.4365499966926096681.stgit@bazille.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: NeilBrown <neilb@suse.de>

lwq is a FIFO single-linked queue that only requires a spinlock
for dequeueing, which happens in process context.  Enqueueing is atomic
with no spinlock and can happen in any context.

Include a unit test for basic functionality - runs at boot time.  Does
not use kunit framework.

Signed-off-by: NeilBrown <neilb@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: David Gow <davidgow@google.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/lwq.h |  120 +++++++++++++++++++++++++++++++++++++++++
 lib/Kconfig         |    5 ++
 lib/Makefile        |    2 -
 lib/lwq.c           |  151 +++++++++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 277 insertions(+), 1 deletion(-)
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
index c686f4adc124..76fe64f933fc 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -729,6 +729,11 @@ config PARMAN
 config OBJAGG
 	tristate "objagg" if COMPILE_TEST
 
+config LWQ_TEST
+	bool "Boot-time test for lwq queuing"
+	help
+          Run boot-time test of light-weight queuing.
+
 endmenu
 
 config GENERIC_IOREMAP
diff --git a/lib/Makefile b/lib/Makefile
index 740109b6e2c8..d0c116b706e6 100644
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
index 000000000000..7fe6c7125357
--- /dev/null
+++ b/lib/lwq.c
@@ -0,0 +1,151 @@
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
+EXPORT_SYMBOL_GPL(__lwq_dequeue);
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
+EXPORT_SYMBOL_GPL(lwq_dequeue_all);
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


