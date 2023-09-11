Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0355C79AFAB
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Sep 2023 01:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236069AbjIKV7K (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 11 Sep 2023 17:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240228AbjIKOj3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 11 Sep 2023 10:39:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A748FCF0
        for <linux-nfs@vger.kernel.org>; Mon, 11 Sep 2023 07:39:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 149B4C433C7;
        Mon, 11 Sep 2023 14:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694443165;
        bh=ky9TbQdqLHqBeVz4xp9zUAV5m8jRJ9G9ubNCJZ0V+fA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mWt19FuRoFNmgBa9k+JT1ag+hdF2kfsY9l0Ijb1BU8YzH3l5pM54SRtAwu1CwCLbu
         kVuVj6dcwP7yb/YT2afm7UbcfUHql1eUS1/ZSwJx+yvaQ1qm1LH6r13sy7ukFuYXBT
         5YiUkTI9YZiHyJbieeBAkCAXg8luI0KQYy0dP/t0c02L5Z2ub0+BpEe9vrNOpxtdbC
         gyr03+SAdRvA2yGUfX3y/72scH/KQA2DE2eevtp9V5Onwj6m7189KDTYWHaFpzldFS
         kBO5lfoxwSYs5OfYv8t+0GeaDmZ68VvROjU7rlTeKCWcg+plcRDeh1Du10Ava604FD
         qFc9aqVDHCWyg==
Subject: [PATCH v1 08/17] llist: add interface to check if a node is on a
 list.
From:   Chuck Lever <cel@kernel.org>
To:     linux-nfs@vger.kernel.org
Cc:     NeilBrown <neilb@suse.de>, Chuck Lever <chuck.lever@oracle.com>
Date:   Mon, 11 Sep 2023 10:39:24 -0400
Message-ID: <169444316412.4327.17559564827280562621.stgit@bazille.1015granger.net>
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

With list.h lists, it is easy to test if a node is on a list, providing
it was initialised and that it is removed with list_del_init().

This patch provides similar functionality for llist.h lists.

 init_llist_node()
marks a node as being not-on-any-list be setting the ->next pointer to
the node itself.
 llist_on_list()
tests if the node is on any list.
 llist_del_first_init()
remove the first element from a llist, and marks it as being off-list.

Signed-off-by: NeilBrown <neilb@suse.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/llist.h |   42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/include/linux/llist.h b/include/linux/llist.h
index 85bda2d02d65..dcb91e3bac1c 100644
--- a/include/linux/llist.h
+++ b/include/linux/llist.h
@@ -73,6 +73,33 @@ static inline void init_llist_head(struct llist_head *list)
 	list->first = NULL;
 }
 
+/**
+ * init_llist_node - initialize lock-less list node
+ * @node:	the node to be initialised
+ *
+ * In cases where there is a need to test if a node is on
+ * a list or not, this initialises the node to clearly
+ * not be on any list.
+ */
+static inline void init_llist_node(struct llist_node *node)
+{
+	node->next = node;
+}
+
+/**
+ * llist_on_list - test if a lock-list list node is on a list
+ * @node:	the node to test
+ *
+ * When a node is on a list the ->next pointer will be NULL or
+ * some other node.  It can never point to itself.  We use that
+ * in init_llist_node() to record that a node is not on any list,
+ * and here to test whether it is on any list.
+ */
+static inline bool llist_on_list(const struct llist_node *node)
+{
+	return node->next != node;
+}
+
 /**
  * llist_entry - get the struct of this entry
  * @ptr:	the &struct llist_node pointer.
@@ -249,6 +276,21 @@ static inline struct llist_node *__llist_del_all(struct llist_head *head)
 
 extern struct llist_node *llist_del_first(struct llist_head *head);
 
+/**
+ * llist_del_first_init - delete first entry from lock-list and mark is as being off-list
+ * @head:	the head of lock-less list to delete from.
+ *
+ * This behave the same as llist_del_first() except that llist_init_node() is called
+ * on the returned node so that llist_on_list() will report false for the node.
+ */
+static inline struct llist_node *llist_del_first_init(struct llist_head *head)
+{
+	struct llist_node *n = llist_del_first(head);
+
+	if (n)
+		init_llist_node(n);
+	return n;
+}
 struct llist_node *llist_reverse_order(struct llist_node *head);
 
 #endif /* LLIST_H */


