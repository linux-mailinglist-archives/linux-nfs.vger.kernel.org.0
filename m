Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5421C1A45
	for <lists+linux-nfs@lfdr.de>; Fri,  1 May 2020 18:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbgEAQBz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 1 May 2020 12:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729975AbgEAQBz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 1 May 2020 12:01:55 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00::f03c:91ff:fe50:41d6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEB1C061A0C
        for <linux-nfs@vger.kernel.org>; Fri,  1 May 2020 09:01:55 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id D94141504; Fri,  1 May 2020 12:01:53 -0400 (EDT)
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-nfs@vger.kernel.org, Jeff Layton <jlayton@redhat.com>,
        David Howells <dhowells@redhat.com>, Tejun Heo <tj@kernel.org>,
        Shaohua Li <shli@fb.com>, Oleg Nesterov <oleg@redhat.com>,
        linux-kernel@vger.kernel.org,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 1/4] kthreads: minor kthreadd refactoring
Date:   Fri,  1 May 2020 12:01:49 -0400
Message-Id: <1588348912-24781-2-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1588348912-24781-1-git-send-email-bfields@redhat.com>
References: <1588348912-24781-1-git-send-email-bfields@redhat.com>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

Trivial refactoring, no change in behavior.

Not really necessary, a separate function for the inner loop just seems
a little nicer to me.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 kernel/kthread.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index bfbfa481be3a..4217fded891a 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -578,6 +578,24 @@ int kthread_stop(struct task_struct *k)
 }
 EXPORT_SYMBOL(kthread_stop);
 
+void kthread_do_work(void)
+{
+	spin_lock(&kthread_create_lock);
+	while (!list_empty(&kthread_create_list)) {
+		struct kthread_create_info *create;
+
+		create = list_entry(kthread_create_list.next,
+				    struct kthread_create_info, list);
+		list_del_init(&create->list);
+		spin_unlock(&kthread_create_lock);
+
+		create_kthread(create);
+
+		spin_lock(&kthread_create_lock);
+	}
+	spin_unlock(&kthread_create_lock);
+}
+
 int kthreadd(void *unused)
 {
 	struct task_struct *tsk = current;
@@ -597,20 +615,7 @@ int kthreadd(void *unused)
 			schedule();
 		__set_current_state(TASK_RUNNING);
 
-		spin_lock(&kthread_create_lock);
-		while (!list_empty(&kthread_create_list)) {
-			struct kthread_create_info *create;
-
-			create = list_entry(kthread_create_list.next,
-					    struct kthread_create_info, list);
-			list_del_init(&create->list);
-			spin_unlock(&kthread_create_lock);
-
-			create_kthread(create);
-
-			spin_lock(&kthread_create_lock);
-		}
-		spin_unlock(&kthread_create_lock);
+		kthread_do_work();
 	}
 
 	return 0;
-- 
2.26.2

