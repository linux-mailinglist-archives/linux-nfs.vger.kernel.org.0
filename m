Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B43C878037A
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Aug 2023 03:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357097AbjHRBqL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Aug 2023 21:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357103AbjHRBpo (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Aug 2023 21:45:44 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A52F42D44
        for <linux-nfs@vger.kernel.org>; Thu, 17 Aug 2023 18:45:42 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6A21F21874;
        Fri, 18 Aug 2023 01:45:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692323141; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9AngTSxZzQJoRGchO9q/ZniY/0Ajt71vxXHfEmBZFwI=;
        b=NaNCOMvaMThO+O4tdjg8vRBfj2kp6y6CQh2NjH0HolbtzCjLFcDPelFswP/0RCAJUFx6Or
        r0vtB+d6MzSjLlwjSaxpUmJqEhcpXjS0r7C28T4dlVl1jypRt3itWnk36fg6kMfZ62aSpb
        zlViApltK0sIIxPqwnXsrQqfbELxlvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692323141;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9AngTSxZzQJoRGchO9q/ZniY/0Ajt71vxXHfEmBZFwI=;
        b=OAkEzSiZzvqV3fEFta5GbEtZPU7olmy3Cbm6AAuqKMviPxdwShPujamPM5VaQ9v/IfVUds
        hX1oKY+iwgo0tYBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1DAC51353E;
        Fri, 18 Aug 2023 01:45:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id caVyMEPN3mSCZAAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 18 Aug 2023 01:45:39 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/7] SUNRPC/svc: add light-weight queuing mechanism.
Date:   Fri, 18 Aug 2023 11:45:08 +1000
Message-Id: <20230818014512.26880-4-neilb@suse.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230818014512.26880-1-neilb@suse.de>
References: <20230818014512.26880-1-neilb@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

lwq is a FIFO single-linked queue that only requires a spinlock
for dequeueing, which happens in process context.  Enqueueing is atomic
with no spinlock and can happen in any context.

Include a unit test for basic functionality - runs a boot/module-load
time.  Does not use kunit framework.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 include/linux/sunrpc/svc_lwq.h |  80 +++++++++++++++++++
 net/sunrpc/Kconfig             |   6 ++
 net/sunrpc/Makefile            |   2 +-
 net/sunrpc/svc_lwq.c           | 141 +++++++++++++++++++++++++++++++++
 4 files changed, 228 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/sunrpc/svc_lwq.h
 create mode 100644 net/sunrpc/svc_lwq.c

diff --git a/include/linux/sunrpc/svc_lwq.h b/include/linux/sunrpc/svc_lwq.h
new file mode 100644
index 000000000000..e5ffd25584ad
--- /dev/null
+++ b/include/linux/sunrpc/svc_lwq.h
@@ -0,0 +1,80 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef SUNRPC_SVC_LWQ_H
+#define SUNRPC_SVC_LWQ_H
+
+/*
+ * light-weight single linked queue
+ *
+ * Entries can be enqueued from any context with no locking.
+ * Entries can be dequeued from process context with integrated locking.
+ *
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
+static inline void lwq_init(struct lwq *q)
+{
+	spin_lock_init(&q->lock);
+	q->ready = NULL;
+	init_llist_head(&q->new);
+}
+
+static inline bool lwq_empty(struct lwq *q)
+{
+	return smp_load_acquire(&q->ready) == NULL && llist_empty(&q->new);
+}
+
+struct llist_node *__lwq_dequeue(struct lwq *q);
+#define lwq_dequeue(_q, _type, _member)					\
+	({ struct llist_node *_n = __lwq_dequeue(_q);			\
+	  _n ? container_of(_n, _type, _member.node) : NULL; })
+
+struct llist_node *lwq_dequeue_all(struct lwq *q);
+
+/**
+ * lwq_for_each_safe: iterate over detached queue allowing deletion
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
+static inline bool lwq_enqueue(struct lwq_node *n, struct lwq *q)
+{
+	return llist_add(&n->node, &q->new) &&
+		smp_load_acquire(&q->ready) == NULL;
+}
+
+static inline bool lwq_enqueue_batch(struct llist_node *n, struct lwq *q)
+{
+	struct llist_node *e = n;
+
+	return llist_add_batch(llist_reverse_order(n), e, &q->new) &&
+		smp_load_acquire(&q->ready) == NULL;
+}
+
+#endif /* SUNRPC_SVC_LWQ_H */
diff --git a/net/sunrpc/Kconfig b/net/sunrpc/Kconfig
index 2d8b67dac7b5..5de87d005962 100644
--- a/net/sunrpc/Kconfig
+++ b/net/sunrpc/Kconfig
@@ -115,3 +115,9 @@ config SUNRPC_XPRT_RDMA
 
 	  If unsure, or you know there is no RDMA capability on your
 	  hardware platform, say N.
+
+config SUNRPC_LWQ_TEST
+	bool "RPC: enable boot-time test for lwq queuing"
+	depends on SUNRPC
+	help
+          Enable boot-time test of lwq functionality.
diff --git a/net/sunrpc/Makefile b/net/sunrpc/Makefile
index f89c10fe7e6a..b224cba1d0da 100644
--- a/net/sunrpc/Makefile
+++ b/net/sunrpc/Makefile
@@ -10,7 +10,7 @@ obj-$(CONFIG_SUNRPC_XPRT_RDMA) += xprtrdma/
 
 sunrpc-y := clnt.o xprt.o socklib.o xprtsock.o sched.o \
 	    auth.o auth_null.o auth_tls.o auth_unix.o \
-	    svc.o svcsock.o svcauth.o svcauth_unix.o \
+	    svc.o svc_lwq.o svcsock.o svcauth.o svcauth_unix.o \
 	    addr.o rpcb_clnt.o timer.o xdr.o \
 	    sunrpc_syms.o cache.o rpc_pipe.o sysfs.o \
 	    svc_xprt.o \
diff --git a/net/sunrpc/svc_lwq.c b/net/sunrpc/svc_lwq.c
new file mode 100644
index 000000000000..9c10c68e3a21
--- /dev/null
+++ b/net/sunrpc/svc_lwq.c
@@ -0,0 +1,141 @@
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
+#include <linux/sunrpc/svc_lwq.h>
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
+		smp_store_release(&q->ready, (void*)1);
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
+#if IS_ENABLED(CONFIG_SUNRPC_LWQ_TEST)
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
+		threads[i] = kthread_run(lwq_exercise, &q, "lwq_test-%d", i);
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
+#endif /* CONFIG_SUNRPC_LWQ_TEST*/
-- 
2.40.1

