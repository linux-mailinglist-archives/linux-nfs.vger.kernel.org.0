Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C5E7D284E
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Oct 2023 04:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbjJWCL4 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 22 Oct 2023 22:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjJWCLz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 22 Oct 2023 22:11:55 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ABAA8E
        for <linux-nfs@vger.kernel.org>; Sun, 22 Oct 2023 19:11:52 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 004A31FD8E;
        Mon, 23 Oct 2023 02:11:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1698027111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=29Y+6+lN91+ttI9zymDHVFSaeYXd6uip7j1l91qeT0M=;
        b=gdTAY0Wi0V3pNBOQ/TPizjQn7BVUayD3J/dg21GDwoPQQ3bvwP2rehiIzmXrvP6cGZ2a3F
        Oznv9GJ843tLHV1giq3ooLMNaMwKCw7zhwCQTTfMeFKBrOZrDeaXxKKMl8FpE+Gwlp+6iW
        FWT55DVuJvGh7yhb2noLaY2aumxyPaI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1698027111;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=29Y+6+lN91+ttI9zymDHVFSaeYXd6uip7j1l91qeT0M=;
        b=sZ5Sl/JxZvJoBbqPfyyLhUvoL3asCXv4jc2dkpBTDX6FQ1Q1pY8KhWBKrQpUwlKMmrwdTV
        5Wl1bkt/5WjgmFCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C75DB132FD;
        Mon, 23 Oct 2023 02:11:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0iljL2TWNWVwbwAAMHmgww
        (envelope-from <neilb@suse.de>); Mon, 23 Oct 2023 02:11:48 +0000
From:   NeilBrown <neilb@suse.de>
To:     Steve Dickson <steved@redhat.com>
Cc:     linux-nfs@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: [PATCH 3/6] export: move cache_open() before workers are forked.
Date:   Mon, 23 Oct 2023 12:58:33 +1100
Message-ID: <20231023021052.5258-4-neilb@suse.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023021052.5258-1-neilb@suse.de>
References: <20231023021052.5258-1-neilb@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: 0.90
X-Spamd-Result: default: False [0.90 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[3];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         R_MISSING_CHARSET(2.50)[];
         BROKEN_CONTENT_TYPE(1.50)[];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         MID_CONTAINS_FROM(1.00)[];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-0.00)[39.91%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

If each worker has a separate open on a cache channel, then each worker
will potentially receive every upcall request resulting in duplicated
work.

A worker will only not see a request that another worker sees if that
other worker answers the request before this worker gets a chance to
read it.

To avoid duplicate effort between threads and so get maximum benefit
from multiple threads, open the cache channels before forking.

Note that the kernel provides locking so that only one thread can be
reading to writing to any channel at any given moment.

Fixes: 5fc3bac9e0c3 ("mountd: Ensure we don't share cache file descriptors among processes.")
Signed-off-by: NeilBrown <neilb@suse.de>
---
 utils/exportd/exportd.c | 8 ++++++--
 utils/mountd/mountd.c   | 8 ++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/utils/exportd/exportd.c b/utils/exportd/exportd.c
index 2dd12cb6015b..6f866445efc2 100644
--- a/utils/exportd/exportd.c
+++ b/utils/exportd/exportd.c
@@ -289,12 +289,16 @@ main(int argc, char **argv)
 	else if (num_threads > MAX_THREADS)
 		num_threads = MAX_THREADS;
 
+	/* Open cache channel files BEFORE forking so each upcall is
+	 * only handled by one thread.  Kernel provides locking for both
+	 * read and write.
+	 */
+	cache_open();
+
 	if (num_threads > 1)
 		fork_workers();
 
 
-	/* Open files now to avoid sharing descriptors among forked processes */
-	cache_open();
 	v4clients_init();
 
 	/* Process incoming upcalls */
diff --git a/utils/mountd/mountd.c b/utils/mountd/mountd.c
index bcf749fabbb3..f9c62cded66c 100644
--- a/utils/mountd/mountd.c
+++ b/utils/mountd/mountd.c
@@ -916,12 +916,16 @@ main(int argc, char **argv)
 	else if (num_threads > MAX_THREADS)
 		num_threads = MAX_THREADS;
 
+	/* Open cache channel files BEFORE forking so each upcall is
+	 * only handled by one thread.  Kernel provides locking for both
+	 * read and write.
+	 */
+	cache_open();
+
 	if (num_threads > 1)
 		fork_workers();
 
 	nfsd_path_init();
-	/* Open files now to avoid sharing descriptors among forked processes */
-	cache_open();
 	v4clients_init();
 
 	xlog(L_NOTICE, "Version " VERSION " starting");
-- 
2.42.0

