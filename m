Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369B978D244
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Aug 2023 04:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240275AbjH3C6v (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 29 Aug 2023 22:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241795AbjH3C6h (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 29 Aug 2023 22:58:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37ED5193
        for <linux-nfs@vger.kernel.org>; Tue, 29 Aug 2023 19:58:34 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EF21F211E2;
        Wed, 30 Aug 2023 02:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693364312; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2n1lVgi8MIilrPJpoy6Sl1Kb9nOLArpLGPX+tGvwaVA=;
        b=gM2S22vJMMgTHXGwij/WL9up04z4il/Vj0gD/+GEH9R5X0Z+b+7Mlsm0EvV9XM0Pf5T9CK
        9sipZZE1go1M69F/2D/gxbiOEdBAtvlg12cMFXmMnv/BSXDV4WNcIjw9e4YDLFRLkBmBCD
        dYZk6DB2SZ2w01ScWpFZdb1sSPkP0l0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693364312;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2n1lVgi8MIilrPJpoy6Sl1Kb9nOLArpLGPX+tGvwaVA=;
        b=Upo7kO5pgngzIYHpRuxy2eYOkXH8FLroMXZJBsmrhsJ6E1maOfro9ZSj/DvUAG3AZtmltl
        HE9btvV3x2g66PBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AFF2413301;
        Wed, 30 Aug 2023 02:58:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NxLCGFew7mT2YwAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 30 Aug 2023 02:58:31 +0000
From:   NeilBrown <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>
Cc:     linux-nfs@vger.kernel.org
Subject: [PATCH 04/10] llist: add llist_del_first_this()
Date:   Wed, 30 Aug 2023 12:54:47 +1000
Message-ID: <20230830025755.21292-5-neilb@suse.de>
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

llist_del_first_this() deletes a specific entry from an llist, providing
it is at the head of the list.  Multiple threads can call this
concurrently providing they each offer a different entry.

This can be uses for a set of worker threads which are on the llist when
they are idle.  The head can always be woken, and when it is woken it
can remove itself, and possibly wake the next if there is an excess of
work to do.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 include/linux/llist.h |  4 ++++
 lib/llist.c           | 28 ++++++++++++++++++++++++++++
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
-- 
2.41.0

