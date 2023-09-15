Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECEC7A13CC
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Sep 2023 04:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231438AbjIOCYO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 14 Sep 2023 22:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjIOCYO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 14 Sep 2023 22:24:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5131C2130;
        Thu, 14 Sep 2023 19:24:10 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 889D82183F;
        Fri, 15 Sep 2023 02:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1694744643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lRhO5Usk0tWo8ZTx91/qTeniCJK8iZhQwKtez0oWKNI=;
        b=IEvMveqRwkUSLtnNpuEc/3mI3EuLIDvJkQkS6zRouGGAPbmuTakqQTLTeAGdRIVQ+BCjln
        RaSxF4GJE47uB6ZBgOnNlTrKfKRywkCawzjEvATxUSUFHDyGQeR9vvPB320LVSXQfiHyhV
        1KkljTisSXHWaBAfNnhmkTxLGCalNVs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1694744643;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lRhO5Usk0tWo8ZTx91/qTeniCJK8iZhQwKtez0oWKNI=;
        b=hENIJPQHFR8kj/UMR6GFExr5ladvIWq3xMzpEmaHQAAyO5zfAjp0Dizjh/mLDXGRcPz99M
        6khArsxN8tpdKcBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BB9EB1358A;
        Fri, 15 Sep 2023 02:24:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id eHqfG0DAA2W5HgAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 15 Sep 2023 02:24:00 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Andrew Morton" <akpm@linux-foundation.org>,
        "Chuck Lever" <chuck.lever@oracle.com>
Cc:     "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        "Liam Howlett" <liam.howlett@oracle.com>,
        "Kees Cook" <keescook@chromium.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "David Gow" <davidgow@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH 11/17 SQUASH and replace commit message] lib: add light-weight
 queuing mechanism.
In-reply-to: <20230911183025.5f808a70a62df79a3a1e349e@linux-foundation.org>
References: <169444233785.4327.4365499966926096681.stgit@bazille.1015granger.net>,
 <169444318342.4327.18355944158180782708.stgit@bazille.1015granger.net>,
 <20230911111333.4d1a872330e924a00acb905b@linux-foundation.org>,
 <4D5C2693-40E9-467D-9F2F-59D92CBE9D3B@oracle.com>,
 <20230911140439.b273bf9e120881f038da0de7@linux-foundation.org>,
 <169447439989.19905.9386812394578844629@noble.neil.brown.name>,
 <20230911183025.5f808a70a62df79a3a1e349e@linux-foundation.org>
Date:   Fri, 15 Sep 2023 12:22:36 +1000
Message-id: <169474455669.8274.9157028681960361538@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


lwq is a FIFO single-linked queue that only requires a spinlock
for dequeueing, which happens in process context.  Enqueueing is atomic
with no spinlock and can happen in any context.

This is particularly useful when work items are queued from BH or IRQ
context, and when they are handled one at a time by dedicated threads.

Avoiding any locking when enqueueing means there is no need to disable
BH or interrupts, which is generally best avoided (particularly when
there are any RT tasks on the machine).

This solution is superior to using "list_head" links because we need
half as many pointers in the data structures, and because list_head
lists would need locking to add items to the queue.

This solution is superior to a bespoke solution as all locking and
container_of casting is integrated, so the interface is simple.

Despite the similar name, this solution meets a distinctly different
need to kfifo.  kfifo provides a fixed sized circular buffer to which
data can be added at one end and removed at the other, and does not
provide any locking.  lwq does not have any size limit and works with
data structures (objects?) rather than data (bytes).

A unit test for basic functionality, which runs at boot time, is included.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 include/linux/lwq.h | 4 ++++
 lib/lwq.c           | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/lwq.h b/include/linux/lwq.h
index 52b9c81b493a..c4148fe1cf72 100644
--- a/include/linux/lwq.h
+++ b/include/linux/lwq.h
@@ -7,6 +7,10 @@
  *
  * Entries can be enqueued from any context with no locking.
  * Entries can be dequeued from process context with integrated locking.
+ *
+ * This is particularly suitable when work items are queued in
+ * BH or IRQ context, and where work items are handled one at a time
+ * by dedicated threads.
  */
 #include <linux/container_of.h>
 #include <linux/spinlock.h>
diff --git a/lib/lwq.c b/lib/lwq.c
index 7fe6c7125357..eb8324225309 100644
--- a/lib/lwq.c
+++ b/lib/lwq.c
@@ -8,6 +8,10 @@
  * Entries are dequeued using a spinlock to protect against
  * multiple access.  The llist is staged in reverse order, and refreshed
  * from the llist when it exhausts.
+ * 
+ * This is particularly suitable when work items are queued in
+ * BH or IRQ context, and where work items are handled one at a time
+ * by dedicated threads.
  */
 #include <linux/rcupdate.h>
 #include <linux/lwq.h>
-- 
2.42.0

