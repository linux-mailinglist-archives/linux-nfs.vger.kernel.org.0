Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4773F94EA
	for <lists+linux-nfs@lfdr.de>; Fri, 27 Aug 2021 09:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbhH0HPk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 27 Aug 2021 03:15:40 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60716 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235220AbhH0HPk (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 27 Aug 2021 03:15:40 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id F13621FD62;
        Fri, 27 Aug 2021 07:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1630048490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l8bUHNF93l4HK6nI24dJxe1OqxCNDBDlivbp2wNUqQA=;
        b=0MPt8GiGzv+/aghDsiq4BDHiNcOuXjWqb3uMzfqLeY9s97TYv9V8afS7zB+sZaWYct85tU
        qxxBV5VvSPy0RNeeLe59ME3B8ptCelyZI2ASwBbFGe1GtgHxuwNuvCL6XEEqmwgDPuI3L2
        JHaEO8OosLny2BUjjwTICxADvCmaQ+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1630048490;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l8bUHNF93l4HK6nI24dJxe1OqxCNDBDlivbp2wNUqQA=;
        b=UykMyiFKmu8OHAsDE2z4yDknCNuPAAG5VA1S10QF0J+4u2iTmIjmY/xmaMWG43hL6lqDj4
        64mPV1iCDl+bkCDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1E8B514549;
        Fri, 27 Aug 2021 07:14:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id JWi0LOiQKGHBEAAAMHmgww
        (envelope-from <neilb@suse.de>); Fri, 27 Aug 2021 07:14:48 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Mike Javorski" <mike.javorski@gmail.com>
Cc:     "Mel Gorman" <mgorman@suse.com>,
        "Chuck Lever III" <chuck.lever@oracle.com>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: NFS server regression in kernel 5.13 (tested w/ 5.13.9)
In-reply-to: <CAOv1SKDTcg5WDp5zf3ZGL0enJ7K693W-9TMYKcrgweyzp6Qjhg@mail.gmail.com>
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
 <CAOv1SKDTcg5WDp5zf3ZGL0enJ7K693W-9TMYKcrgweyzp6Qjhg@mail.gmail.com>
Date:   Fri, 27 Aug 2021 17:14:45 +1000
Message-id: <163004848514.7591.2757618782251492498@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 27 Aug 2021, Mike Javorski wrote:
> Neil:
> 
> I am actually compiling a 5.13.13 kernel with the patch that Chuck
> suggested earlier right now. I am doing the full compile matching the
> distro compile as I don't have a targeted kernel config ready to go
> (it's been years), and I want to test like for like anyway. It should
> be ready to install in the AM, my time, so I will test with that first
> tomorrow and see if it resolves the issue, if not, I will report back
> and then try your revert suggestion. On the issue of memory though, my
> server has 16GB of memory (and free currently shows ~1GB unused, and
> ~11GB in buffers/caches), so this really shouldn't be an available
> memory issue, but I guess we'll find out.
> 
> Thanks for the info.

Take your time.

Just FYI, the fix Chuck identified doesn't match your symptoms.
That bug can only occur if
   /sys/module/sunrpc/parameters/svc_rpc_per_connection_limit
is non-zero.  When it does occur, the TCP connection completely
freezes - no further traffic.  IT won't even close.

I took a break and got some fresh air and now I understand the problem.
Please try the patch below, not the revert I suggested.
The pause can, I think, be caused by fragmented memory - not just low
memory.  If only 1/16 of your memory is free, it could easily be
fragmented.

Thanks,
NeilBrown

Subject: [PATCH] SUNRPC: don't pause on incomplete allocation

alloc_pages_bulk_array() attempts to allocate at least one page based on
the provided pages, and then opportunistically allocates more if that
can be done without dropping the spinlock.

So if it returns fewer than requested, that could just mean that it
needed to drop the lock.  In that case, try again immediately.

Only pause for a time if no progress could be made.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 net/sunrpc/svc_xprt.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/sunrpc/svc_xprt.c b/net/sunrpc/svc_xprt.c
index d66a8e44a1ae..99268dd95519 100644
--- a/net/sunrpc/svc_xprt.c
+++ b/net/sunrpc/svc_xprt.c
@@ -662,7 +662,7 @@ static int svc_alloc_arg(struct svc_rqst *rqstp)
 {
 	struct svc_serv *serv = rqstp->rq_server;
 	struct xdr_buf *arg = &rqstp->rq_arg;
-	unsigned long pages, filled;
+	unsigned long pages, filled, prev;
 
 	pages = (serv->sv_max_mesg + 2 * PAGE_SIZE) >> PAGE_SHIFT;
 	if (pages > RPCSVC_MAXPAGES) {
@@ -672,11 +672,14 @@ static int svc_alloc_arg(struct svc_rqst *rqstp)
 		pages = RPCSVC_MAXPAGES;
 	}
 
-	for (;;) {
+	for (prev = 0;; prev = filled) {
 		filled = alloc_pages_bulk_array(GFP_KERNEL, pages,
 						rqstp->rq_pages);
 		if (filled == pages)
 			break;
+		if (filled > prev)
+			/* Made progress, don't sleep yet */
+			continue;
 
 		set_current_state(TASK_INTERRUPTIBLE);
 		if (signalled() || kthread_should_stop()) {
