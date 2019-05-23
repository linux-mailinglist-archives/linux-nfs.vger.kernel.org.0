Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46DFC2801E
	for <lists+linux-nfs@lfdr.de>; Thu, 23 May 2019 16:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730850AbfEWOqM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 23 May 2019 10:46:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44980 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730782AbfEWOqM (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 23 May 2019 10:46:12 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id EF9EE8110E;
        Thu, 23 May 2019 14:46:11 +0000 (UTC)
Received: from bcodding.csb (ovpn-66-2.rdu2.redhat.com [10.10.66.2])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B24532E047;
        Thu, 23 May 2019 14:46:11 +0000 (UTC)
Received: by bcodding.csb (Postfix, from userid 24008)
        id D6CDC109C3D0; Thu, 23 May 2019 10:45:48 -0400 (EDT)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     "J . Bruce Fields" <bfields@redhat.com>, jlayton@kernel.org
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 3/5] lockd: Remove lm_compare_owner and lm_owner_key
Date:   Thu, 23 May 2019 10:45:46 -0400
Message-Id: <8e88b4a4b619280bd005a71a90568aa56e597e2e.1558622651.git.bcodding@redhat.com>
In-Reply-To: <cover.1558622651.git.bcodding@redhat.com>
References: <cover.1558622651.git.bcodding@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Thu, 23 May 2019 14:46:12 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Now that the NLM server allocates an nlm_lockowner for fl_owner, there's
no need for special hashing or comparison.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
---
 fs/lockd/svclock.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.c
index 34c6ee85274e..637c50687fd7 100644
--- a/fs/lockd/svclock.c
+++ b/fs/lockd/svclock.c
@@ -788,25 +788,7 @@ nlmsvc_notify_blocked(struct file_lock *fl)
 	printk(KERN_WARNING "lockd: notification for unknown block!\n");
 }
 
-static int nlmsvc_same_owner(struct file_lock *fl1, struct file_lock *fl2)
-{
-	return fl1->fl_owner == fl2->fl_owner && fl1->fl_pid == fl2->fl_pid;
-}
-
-/*
- * Since NLM uses two "keys" for tracking locks, we need to hash them down
- * to one for the blocked_hash. Here, we're just xor'ing the host address
- * with the pid in order to create a key value for picking a hash bucket.
- */
-static unsigned long
-nlmsvc_owner_key(struct file_lock *fl)
-{
-	return (unsigned long)fl->fl_owner ^ (unsigned long)fl->fl_pid;
-}
-
 const struct lock_manager_operations nlmsvc_lock_operations = {
-	.lm_compare_owner = nlmsvc_same_owner,
-	.lm_owner_key = nlmsvc_owner_key,
 	.lm_notify = nlmsvc_notify_blocked,
 	.lm_grant = nlmsvc_grant_deferred,
 };
-- 
2.20.1

