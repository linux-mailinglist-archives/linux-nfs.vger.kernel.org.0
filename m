Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D42A61C1A46
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2020 18:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729981AbgEAQBz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 May 2020 12:01:55 -0400
Received: from fieldses.org ([173.255.197.46]:40336 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729625AbgEAQBy (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Fri, 1 May 2020 12:01:54 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id E6D1E4F42; Fri,  1 May 2020 12:01:53 -0400 (EDT)
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-nfs@vger.kernel.org, Jeff Layton <jlayton@redhat.com>,
        David Howells <dhowells@redhat.com>, Tejun Heo <tj@kernel.org>,
        Shaohua Li <shli@fb.com>, Oleg Nesterov <oleg@redhat.com>,
        linux-kernel@vger.kernel.org,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 2/4] kthreads: Simplify tsk_fork_get_node
Date:   Fri,  1 May 2020 12:01:50 -0400
Message-Id: <1588348912-24781-3-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588348912-24781-1-git-send-email-bfields@redhat.com>
References: <1588348912-24781-1-git-send-email-bfields@redhat.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

This will also simplify a following patch that allows multiple
kthreadd's.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 init/init_task.c | 3 +++
 kernel/fork.c    | 4 ++++
 kernel/kthread.c | 3 +--
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/init/init_task.c b/init/init_task.c
index bd403ed3e418..fdd760393760 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -154,6 +154,9 @@ struct task_struct init_task
 	.vtime.starttime = 0,
 	.vtime.state	= VTIME_SYS,
 #endif
+#ifdef CONFIG_NUMA
+	.pref_node_fork = NUMA_NO_NODE,
+#endif
 #ifdef CONFIG_NUMA_BALANCING
 	.numa_preferred_nid = NUMA_NO_NODE,
 	.numa_group	= NULL,
diff --git a/kernel/fork.c b/kernel/fork.c
index 8c700f881d92..fa35890534d5 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -942,6 +942,10 @@ static struct task_struct *dup_task_struct(struct task_struct *orig, int node)
 	tsk->fail_nth = 0;
 #endif
 
+#ifdef CONFIG_NUMA
+	tsk->pref_node_fork = NUMA_NO_NODE;
+#endif
+
 #ifdef CONFIG_BLK_CGROUP
 	tsk->throttle_queue = NULL;
 	tsk->use_memdelay = 0;
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 4217fded891a..483bee57a9c8 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -274,8 +274,7 @@ static int kthread(void *_create)
 int tsk_fork_get_node(struct task_struct *tsk)
 {
 #ifdef CONFIG_NUMA
-	if (tsk == kthreadd_task)
-		return tsk->pref_node_fork;
+	return tsk->pref_node_fork;
 #endif
 	return NUMA_NO_NODE;
 }
-- 
2.26.2

