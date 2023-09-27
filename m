Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B347B0ECB
	for <lists+linux-nfs@lfdr.de>; Thu, 28 Sep 2023 00:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjI0WMB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 27 Sep 2023 18:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjI0WMA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 27 Sep 2023 18:12:00 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF8710A;
        Wed, 27 Sep 2023 15:11:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D48B81F385;
        Wed, 27 Sep 2023 22:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1695852717; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ywgPMmVKMCF2OBsdPVyyMuS0V6hzCVtZvwuPzOBMAN8=;
        b=gPHuSKZaHU9KAuUuuwNiDKETwxW4fWysw5JxRtY6rOTZsQZPEmfp03uV+qRS1CV/9RSbh7
        nDBdV40djXBiaicQs+1X24AVauIhVYbo/Klfb2WGEDku1QOoJ97JQVBA/DqZJ8a/WDT/+L
        UkABx68z0TGnkWbHsHttr8yVs5La+CA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1695852717;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ywgPMmVKMCF2OBsdPVyyMuS0V6hzCVtZvwuPzOBMAN8=;
        b=3DL/6u4HVP2mdSxIrxYzOb49x4BTIzkl7HKf+hOqb0rVW9iaKRYNVu7GOxnyCSx41tGjAk
        I0UXzMBpX7CigVCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 47D8D13479;
        Wed, 27 Sep 2023 22:11:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id pPumOquoFGUELgAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 27 Sep 2023 22:11:55 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     Chuck Lever <chuck.lever@oracle.com>,
        "Dan Carpenter" <dan.carpenter@linaro.org>
Cc:     kernel-janitors@vger.kernel.org, linux-nfs@vger.kernel.org
Subject: [PATCH nfsd] SQUASH 8dc9e02aed76 lib: add light-weight queuing mechanism.
In-reply-to: <8e9f5845-0d9c-4d50-b2e4-5c1cd622a71c@moroto.mountain>
References: <8e9f5845-0d9c-4d50-b2e4-5c1cd622a71c@moroto.mountain>
Date:   Thu, 28 Sep 2023 08:11:52 +1000
Message-id: <169585271242.5939.14975098525477744646@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


Remove assumption that kmalloc never fails.

Signed-off-by: NeilBrown <neilb@suse.de>
---

Hi Chuck,
 please squash this into the relevant patch - thanks.
Hi Dan,
 thanks for the review!

NeilBrown

 lib/lwq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/lwq.c b/lib/lwq.c
index 8a723b29b39e..57d080a4d53d 100644
--- a/lib/lwq.c
+++ b/lib/lwq.c
@@ -111,6 +111,8 @@ static int lwq_test(void)
 		threads[i] = kthread_run(lwq_exercise, &q, "lwq-test-%d", i);
 	for (i = 0; i < 100; i++) {
 		t = kmalloc(sizeof(*t), GFP_KERNEL);
+		if (!t)
+			break;
 		t->i = i;
 		t->c = 0;
 		if (lwq_enqueue(&t->n, &q))
@@ -127,7 +129,8 @@ static int lwq_test(void)
 			printk(KERN_INFO " lwq: ... ");
 		}
 		t = lwq_dequeue(&q, struct tnode, n);
-		printk(KERN_CONT " %d(%d)", t->i, t->c);
+		if (t)
+			printk(KERN_CONT " %d(%d)", t->i, t->c);
 		kfree(t);
 	}
 	printk(KERN_CONT "\n");
-- 
2.42.0

