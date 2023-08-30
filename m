Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 435A478D241
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Aug 2023 04:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234124AbjH3C6u (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Aug 2023 22:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239380AbjH3C60 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Aug 2023 22:58:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FDE4185
        for <linux-nfs@vger.kernel.org>; Tue, 29 Aug 2023 19:58:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 169FC1F461;
        Wed, 30 Aug 2023 02:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693364303; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p/rjT0WyrDuNAK7/O2cc5TCZ/nbr9qia158n5WxZS+c=;
        b=i+f7rPFT6IFxmpb5z0IVt0jdNUOA17QovWRjCgyzSYW2RdY9vZcdCxe7FxXpvrqpZELZg7
        sugtaJQrYoUeoUgmrC98Lrk+1vD/qqpnZoZxDoJF3tPxMzjapPzSViyRCTj3kxCmxk8qkW
        sD1rKIMyTS66xbeQFAu7dtk7THx7gvw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693364303;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p/rjT0WyrDuNAK7/O2cc5TCZ/nbr9qia158n5WxZS+c=;
        b=K7C1pi1NeIaSgB0WV1xUfgk9rDNSZLQgid1wUAmp8xzIRnpBt0JY/rd7LJ+wVu+zl5LGa6
        zLkqkDBrGCjRwbAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C90FF13301;
        Wed, 30 Aug 2023 02:58:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6h+LHk2w7mTjYwAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 30 Aug 2023 02:58:21 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 02/10] llist: add interface to check if a node is on a list.
Date:   Wed, 30 Aug 2023 12:54:45 +1000
Message-ID: <20230830025755.21292-3-neilb@suse.de>
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
---
 include/linux/llist.h | 42 ++++++++++++++++++++++++++++++++++++++++++
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
-- 
2.41.0

