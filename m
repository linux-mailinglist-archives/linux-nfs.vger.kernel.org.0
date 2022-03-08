Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 312424D0E14
	for <lists+linux-nfs@lfdr.de>; Tue,  8 Mar 2022 03:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238785AbiCHCnU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 7 Mar 2022 21:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234531AbiCHCnT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 7 Mar 2022 21:43:19 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C4A13F36
        for <linux-nfs@vger.kernel.org>; Mon,  7 Mar 2022 18:42:23 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A1442210EF;
        Tue,  8 Mar 2022 02:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1646707342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=O3oTS4wkEJ5cRW9Q6QnensCFywZupj63h/gY7Fji9iM=;
        b=ONtnvnjpwbzBh/NodPHepIYl6k+opXwR7Ilhl19GX8udAgxIkC8D4maKZhZv1vvZIINoCs
        YB0ZqCOvSQ5llHoOo9QBXI/wuthQm/8Nw5lbDAQ10piYgT3ZFwSYxGuA+b4/bQhCS+fviT
        tZXlUSkfp/HriM3tp/3wLEDEr6nlHGQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1646707342;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=O3oTS4wkEJ5cRW9Q6QnensCFywZupj63h/gY7Fji9iM=;
        b=AvSfvUCs5rQqV1DMyl+EDeXWLZ5EU/bXgS19ING9RaCXrHzhERLx7e/4IwJrXk3WQQxojH
        UIUHNq4Qm8IF+4AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8645813C09;
        Tue,  8 Mar 2022 02:42:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jkhTEY3CJmKlHwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 08 Mar 2022 02:42:21 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   NeilBrown <neilb@suse.de>
Subject: [PATCH] SUNRPC: avoid race between mod_timer() and del_timer_sync()
To:     Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Tue, 08 Mar 2022 13:42:17 +1100
Message-id: <164670733789.31932.14711754930977072270@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


xprt_destory() claims XPRT_LOCKED and then calls del_timer_sync().
Both xprt_unlock_connect() and xprt_release() call
 ->release_xprt()
which drops XPRT_LOCKED and *then* xprt_schedule_autodisconnect()
which calls mod_timer().

This may result in mod_timer() being called *after* del_timer_sync().
When this happens, the timer may fire long after the xprt has been freed,
and run_timer_softirq() will probably crash.

The pairing of ->release_xprt() and xprt_schedule_autodisconnect() is
always called under ->transport_lock.  So if we take ->transport_lock to
call del_timer_sync(), we can be sure that mod_timer() will run first
(if it runs at all).

Cc: stable@vger.kernel.org
Signed-off-by: NeilBrown <neilb@suse.de>
---
 net/sunrpc/xprt.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/net/sunrpc/xprt.c b/net/sunrpc/xprt.c
index a02de2bddb28..5388263f8fc8 100644
--- a/net/sunrpc/xprt.c
+++ b/net/sunrpc/xprt.c
@@ -2112,7 +2112,14 @@ static void xprt_destroy(struct rpc_xprt *xprt)
 	 */
 	wait_on_bit_lock(&xprt->state, XPRT_LOCKED, TASK_UNINTERRUPTIBLE);
 
+	/*
+	 * xprt_schedule_autodisconnect() can run after XPRT_LOCKED
+	 * is cleared.  We use ->transport_lock to ensure the mod_timer()
+	 * can only run *before* del_time_sync(), never after.
+	 */
+	spin_lock(&xprt->transport_lock);
 	del_timer_sync(&xprt->timer);
+	spin_unlock(&xprt->transport_lock);
 
 	/*
 	 * Destroy sockets etc from the system workqueue so they can
-- 
2.35.1

