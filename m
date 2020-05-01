Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E66091C1A44
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2020 18:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730028AbgEAQBz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 May 2020 12:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729998AbgEAQBz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 May 2020 12:01:55 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00::f03c:91ff:fe50:41d6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28738C061A0E
        for <linux-nfs@vger.kernel.org>; Fri,  1 May 2020 09:01:55 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 077ED5F48; Fri,  1 May 2020 12:01:54 -0400 (EDT)
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-nfs@vger.kernel.org, Jeff Layton <jlayton@redhat.com>,
        David Howells <dhowells@redhat.com>, Tejun Heo <tj@kernel.org>,
        Shaohua Li <shli@fb.com>, Oleg Nesterov <oleg@redhat.com>,
        linux-kernel@vger.kernel.org,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 4/4] kthreads: allow cloning threads with different flags
Date:   Fri,  1 May 2020 12:01:52 -0400
Message-Id: <1588348912-24781-5-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588348912-24781-1-git-send-email-bfields@redhat.com>
References: <1588348912-24781-1-git-send-email-bfields@redhat.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

This is so knfsd can add CLONE_THREAD.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 include/linux/kthread.h |  3 ++-
 kernel/kthread.c        | 11 +++++++----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index a7ffdf96a3b2..7069feb6da65 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -10,11 +10,12 @@ struct kthread_group {
 	spinlock_t create_lock;
 	struct list_head create_list;
 	struct task_struct *task;
+	unsigned long flags;
 };
 
 extern struct kthread_group kthreadd_default;
 
-struct kthread_group *kthread_start_group(char *);
+struct kthread_group *kthread_start_group(unsigned long, char *);
 void kthread_stop_group(struct kthread_group *);
 
 struct task_struct *kthread_group_create_on_node(struct kthread_group *,
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 5232f6f597b5..57f6687ecec7 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -29,6 +29,7 @@ struct kthread_group kthreadd_default = {
 	.name = "kthreadd",
 	.create_lock = __SPIN_LOCK_UNLOCKED(kthreadd_default.create_lock),
 	.create_list = LIST_HEAD_INIT(kthreadd_default.create_list),
+	.flags = CLONE_FS | CLONE_FILES | SIGCHLD,
 };
 
 void wake_kthreadd(struct kthread_group *kg)
@@ -36,7 +37,7 @@ void wake_kthreadd(struct kthread_group *kg)
 	wake_up_process(kg->task);
 }
 
-struct kthread_group *kthread_start_group(char *name)
+struct kthread_group *kthread_start_group(unsigned long flags, char *name)
 {
 	struct kthread_group *new;
 	struct task_struct *task;
@@ -47,6 +48,7 @@ struct kthread_group *kthread_start_group(char *name)
 	spin_lock_init(&new->create_lock);
 	INIT_LIST_HEAD(&new->create_list);
 	new->name = name;
+	new->flags = flags;
 	task = kthread_run(kthreadd, new, name);
 	if (IS_ERR(task)) {
 		kfree(new);
@@ -314,7 +316,8 @@ int tsk_fork_get_node(struct task_struct *tsk)
 	return NUMA_NO_NODE;
 }
 
-static void create_kthread(struct kthread_create_info *create)
+static void create_kthread(struct kthread_create_info *create,
+			   unsigned long flags)
 {
 	int pid;
 
@@ -322,7 +325,7 @@ static void create_kthread(struct kthread_create_info *create)
 	current->pref_node_fork = create->node;
 #endif
 	/* We want our own signal handler (we take no signals by default). */
-	pid = kernel_thread(kthread, create, CLONE_FS | CLONE_FILES | SIGCHLD);
+	pid = kernel_thread(kthread, create, flags);
 	if (pid < 0) {
 		/* If user was SIGKILLed, I release the structure. */
 		struct completion *done = xchg(&create->done, NULL);
@@ -645,7 +648,7 @@ void kthread_do_work(struct kthread_group *kg)
 		list_del_init(&create->list);
 		spin_unlock(&kg->create_lock);
 
-		create_kthread(create);
+		create_kthread(create, kg->flags);
 
 		spin_lock(&kg->create_lock);
 	}
-- 
2.26.2

