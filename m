Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27CE13FAEF7
	for <lists+linux-nfs@lfdr.de>; Mon, 30 Aug 2021 00:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234860AbhH2Whc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 29 Aug 2021 18:37:32 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:57196 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234686AbhH2Whc (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 29 Aug 2021 18:37:32 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1C7C62202C;
        Sun, 29 Aug 2021 22:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630276599; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6ERyju+YGgckczfvqFNw8PPOmwWjSJxho30DW5PrBO0=;
        b=K4ooxdP/3lxmCVrAErsqGPJ86EIL/UamBpFiSNnHJQIFeciFMKHi/34HBnfzQ+xqR+xGsa
        kqZCumxcOGbUmJGYZco4w0IeD6ITBYKaKIpKWMpcCEijEw6Pwu7l0oGAwgFnmQNLEj4LWl
        WfhAiJcSKNwpwaEGpEwpA/HehrMXTVM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630276599;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6ERyju+YGgckczfvqFNw8PPOmwWjSJxho30DW5PrBO0=;
        b=gDvfE4NVoofWJzgsB0rRSCYQwxQcH7lciZ6qPkhvnZrlZITO5A2CfdM7vz9Y3bdycN2Qu5
        SDK4mlA1/HO+Z2Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BFC1513216;
        Sun, 29 Aug 2021 22:36:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 9Q5VH/ULLGGORgAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 29 Aug 2021 22:36:37 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Mike Javorski" <mike.javorski@gmail.com>,
        "Mel Gorman" <mgorman@suse.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: [PATCH] SUNRPC: don't pause on incomplete allocation
In-reply-to: <12B831AA-4A4E-4102-ADA3-97B6FA0B119E@oracle.com>
References: <CAOv1SKCmdtchm5Z2NU80o49tkrHpAkPFaHKj4-vLDN5bZNCz-Q@mail.gmail.com>,
 <162846730406.22632.14734595494457390936@noble.neil.brown.name>,
 <CAOv1SKBZ7sGBnvG9-M+De+s=CfU=H_GBs4hJah1E4ks+NSMyPw@mail.gmail.com>,
 <CAOv1SKCUM5cGuXWAc7dsXtbmPMATqd245juC+S9gVXHWiZsvmQ@mail.gmail.com>,
 <162855893202.12431.3423894387218130632@noble.neil.brown.name>,
 <CAOv1SKAaSbfw53LWCCrvGCHESgdtCf5h275Zkzi9_uHkqnCrdg@mail.gmail.com>,
 <162882238416.1695.4958036322575947783@noble.neil.brown.name>,
 <CAOv1SKB_dsam7P9pzzh_SKCtA8uE9cyFdJ=qquEfhLT42-szPA@mail.gmail.com>,
 <CAOv1SKDDOj5UeUwztrMSNJnLgSoEgD8OU55hqtLHffHvaCQzzA@mail.gmail.com>,
 <162907681945.1695.10796003189432247877@noble.neil.brown.name>,
 <87777C39-BDDA-4E1E-83FA-5B46918A66D3@oracle.com>,
 <CAOv1SKA5ByO7PYQwvd6iBcPieWxEp=BfUZuigJ=7Hm4HAmTuMA@mail.gmail.com>,
 <162915491276.9892.7049267765583701172@noble.neil.brown.name>,
 <162941948235.9892.6790956894845282568@noble.neil.brown.name>,
 <CAOv1SKAyr0Cixc8eQf8-Fdnf=9Db_xZGsweq9K2E5AkALFqavQ@mail.gmail.com>,
 <CAOv1SKDDUFpgexZ_xYCe6c2-UCBK0+vicoG+LAtG2Zhispd_jg@mail.gmail.com>,
 <162960371884.9892.13803244995043191094@noble.neil.brown.name>,
 <CAOv1SKBePD6N-R0uETgcSPA-LZZ4895ZJDKTY7mYvhfu184OQQ@mail.gmail.com>,
 <162966962721.9892.5962616727949224286@noble.neil.brown.name>,
 <CAOv1SKB6xqyduf5L5hcXOe-xMN-UJOfFeE5eXVga3TviKuH0PA@mail.gmail.com>,
 <163001427749.7591.7281634750945934559@noble.neil.brown.name>,
 <CAOv1SKC+3LXhM+L9MwU2D03bpeof55-g+i=r3SWEjVWcPVCi8Q@mail.gmail.com>,
 <163004202961.7591.12633163545286005205@noble.neil.brown.name>,
 <CAOv1SKDTcg5WDp5zf3ZGL0enJ7K693W-9TMYKcrgweyzp6Qjhg@mail.gmail.com>,
 <163004848514.7591.2757618782251492498@noble.neil.brown.name>,
 <6CC9C852-CEE3-4657-86AD-9D5759E2BE1C@oracle.com>,
 <CAOv1SKAiPB62sQcnDCKC5vYbbmakfbe80KRu3JEVZVO7Trk8cw@mail.gmail.com>,
 <CAOv1SKATk1iP=J9r2x0CQzNuwq2VoRvN8Mkba3DsKq6W_tfrDQ@mail.gmail.com>,
 <416268C9-BEAC-483C-9392-8139340BC849@oracle.com>,
 <CAOv1SKCjvgSfUoFtufZ5-dB-quG=djnn-UHO286S410aVxrV0Q@mail.gmail.com>,
 <12B831AA-4A4E-4102-ADA3-97B6FA0B119E@oracle.com>
Date:   Mon, 30 Aug 2021 08:36:34 +1000
Message-id: <163027659478.7591.8897815399981483759@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


alloc_pages_bulk_array() attempts to allocate at least one page based on
the provided pages, and then opportunistically allocates more if that
can be done without dropping the spinlock.

So if it returns fewer than requested, that could just mean that it
needed to drop the lock.  In that case, try again immediately.

Only pause for a time if no progress could be made.

Reported-and-tested-by: Mike Javorski <mike.javorski@gmail.com>
Reported-and-tested-by: Lothar Paltins <lopa@mailbox.org>
Fixes: f6e70aab9dfe ("SUNRPC: refresh rq_pages using a bulk page allocator")
Signed-off-by: NeilBrown <neilb@suse.de>
---

I decided I would resend, as I thought the for() loops could be clearer.
This patch should perform exactly the same as the previous one.


 net/sunrpc/svc_xprt.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index d66a8e44a1ae..e74d5cf3cbb4 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -662,7 +662,7 @@ static int svc_alloc_arg(struct svc_rqst *rqstp)
 {
 	struct svc_serv *serv = rqstp->rq_server;
 	struct xdr_buf *arg = &rqstp->rq_arg;
-	unsigned long pages, filled;
+	unsigned long pages, filled, ret;
 
 	pages = (serv->sv_max_mesg + 2 * PAGE_SIZE) >> PAGE_SHIFT;
 	if (pages > RPCSVC_MAXPAGES) {
@@ -672,11 +672,12 @@ static int svc_alloc_arg(struct svc_rqst *rqstp)
 		pages = RPCSVC_MAXPAGES;
 	}
 
-	for (;;) {
-		filled = alloc_pages_bulk_array(GFP_KERNEL, pages,
-						rqstp->rq_pages);
-		if (filled == pages)
-			break;
+	for (filled = 0; filled < pages; filled = ret) {
+		ret = alloc_pages_bulk_array(GFP_KERNEL, pages,
+					     rqstp->rq_pages);
+		if (ret > filled)
+			/* Made progress, don't sleep yet */
+			continue;
 
 		set_current_state(TASK_INTERRUPTIBLE);
 		if (signalled() || kthread_should_stop()) {
-- 
2.32.0

