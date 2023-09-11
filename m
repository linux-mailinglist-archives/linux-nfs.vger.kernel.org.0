Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C2779B1A8
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 01:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239522AbjIKV7j (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Sep 2023 17:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240239AbjIKOjm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Sep 2023 10:39:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F6BCF0
        for <linux-nfs@vger.kernel.org>; Mon, 11 Sep 2023 07:39:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA350C433CA;
        Mon, 11 Sep 2023 14:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694443178;
        bh=EBv3p5nNdDv/rUPIWRAu36qCgt6Xr7C8unfPt5OZtT8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=M2j7br8BTRIp/0ruh44qHF0cRoRbeXhNa6km3iSq6eteKv3T1tG9CAqIw0k++tYwH
         JnPWDdZ/2VjXEiKpK4cuJ049Hz3rv9Yq7dr3kWrw5ANZc4eNhg6SjGmrJUwLPhk+xx
         P8SRMDdyPC0hLiH9wBz6XEnT/VAJWOgFF5J8QbaKVyg2ts8o6AdfPgn7BirrIAoxgG
         q4gUdHDEPMROdU03z5CIjBdHmDgOUVnk74VjHO02OC+iNgUbhUna6aQ/9nuozbDSb0
         1/JtRTR25Jne2TuR0gKTy5CtRXHIW4A95A3Y9pwGdbALw/6UCZVMKqaTA6ohMkPj/y
         Y7FCu70aLPQ/A==
Subject: [PATCH v1 10/17] llist: add llist_del_first_this()
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 11 Sep 2023 10:39:37 -0400
Message-ID: <169444317699.4327.11310525480458883526.stgit@bazille.1015granger.net>
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

llist_del_first_this() deletes a specific entry from an llist, providing
it is at the head of the list.  Multiple threads can call this
concurrently providing they each offer a different entry.

This can be uses for a set of worker threads which are on the llist when
they are idle.  The head can always be woken, and when it is woken it
can remove itself, and possibly wake the next if there is an excess of
work to do.

Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/llist.h |    4 ++++
 lib/llist.c           |   28 ++++++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/linux/llist.h b/include/linux/llist.h
index dcb91e3bac1c..2c982ff7475a 100644
--- a/include/linux/llist.h
+++ b/include/linux/llist.h
@@ -291,6 +291,10 @@ static inline struct llist_node *llist_del_first_init(struct llist_head *head)
 		init_llist_node(n);
 	return n;
 }
+
+extern bool llist_del_first_this(struct llist_head *head,
+				 struct llist_node *this);
+
 struct llist_node *llist_reverse_order(struct llist_node *head);
 
 #endif /* LLIST_H */
diff --git a/lib/llist.c b/lib/llist.c
index 6e668fa5a2c6..f21d0cfbbaaa 100644
--- a/lib/llist.c
+++ b/lib/llist.c
@@ -65,6 +65,34 @@ struct llist_node *llist_del_first(struct llist_head *head)
 }
 EXPORT_SYMBOL_GPL(llist_del_first);
 
+/**
+ * llist_del_first_this - delete given entry of lock-less list if it is first
+ * @head:	the head for your lock-less list
+ * @this:	a list entry.
+ *
+ * If head of the list is given entry, delete and return %true else
+ * return %false.
+ *
+ * Multiple callers can safely call this concurrently with multiple
+ * llist_add() callers, providing all the callers offer a different @this.
+ */
+bool llist_del_first_this(struct llist_head *head,
+			  struct llist_node *this)
+{
+	struct llist_node *entry, *next;
+
+	/* acquire ensures orderig wrt try_cmpxchg() is llist_del_first() */
+	entry = smp_load_acquire(&head->first);
+	do {
+		if (entry != this)
+			return false;
+		next = READ_ONCE(entry->next);
+	} while (!try_cmpxchg(&head->first, &entry, next));
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(llist_del_first_this);
+
 /**
  * llist_reverse_order - reverse order of a llist chain
  * @head:	first item of the list to be reversed


