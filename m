Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE09876F480
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Aug 2023 23:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbjHCVMX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Aug 2023 17:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231576AbjHCVMW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Aug 2023 17:12:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734E044BC
        for <linux-nfs@vger.kernel.org>; Thu,  3 Aug 2023 14:12:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 661D41F74D;
        Thu,  3 Aug 2023 21:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1691097129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bHn31x6FcoiyRSO6Xq+pHroSeKad5av5RSlioxXZ2zQ=;
        b=YcQ6KBee789bZUpC8YwwAJpOeHkf4nfqR62hu3h4Ib0SxJLzDPGx19VH9/Ip9s1YwvDTYF
        XU/rAxM4bSjM94ufpIZAPfCfAryvJrvMBJXZippqW00MfVRTZ/IxyrdLz7xBvptFHg+iQn
        /yiNJel68EuUUvoPQal44MORG9e2TnI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1691097129;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bHn31x6FcoiyRSO6Xq+pHroSeKad5av5RSlioxXZ2zQ=;
        b=GA7KrAV0a0S8cEXTn23uGLmSB0aNYb4MCz5HlrUc0aJr5IH1e7Jy4zEDiMMu1s5kuBO47Q
        YCAZN2djL2wYuEAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1DE5B1333C;
        Thu,  3 Aug 2023 21:12:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6LzRMCcYzGS0UgAAMHmgww
        (envelope-from <neilb@suse.de>); Thu, 03 Aug 2023 21:12:07 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/6] SUNRPC: rename and refactor svc_get_next_xprt()
In-reply-to: <ZMv5S7k4iCQgYXZ4@tissot.1015granger.net>
References: <20230802073443.17965-1-neilb@suse.de>,
 <20230802073443.17965-3-neilb@suse.de>,
 <ZMv5S7k4iCQgYXZ4@tissot.1015granger.net>
Date:   Fri, 04 Aug 2023 07:12:03 +1000
Message-id: <169109712368.32308.6546907686830224026@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 04 Aug 2023, Chuck Lever wrote:
> On Wed, Aug 02, 2023 at 05:34:39PM +1000, NeilBrown wrote:
> > svc_get_next_xprt() does a lot more than just get an xprt.  It also
> > decides if it needs to sleep, depending not only on the availability of
> > xprts but also on the need to exit or handle external work.
> > 
> > So rename it to svc_rqst_wait_for_work() and only do the testing and
> > waiting.  Move all the waiting-related code out of svc_recv() into the
> > new svc_rqst_wait_for_work().
> > 
> > Move the dequeueing code out of svc_get_next_xprt() into svc_recv().
> > 
> > Previously svc_xprt_dequeue() would be called twice, once before waiting
> > and possibly once after.  Now instead rqst_should_sleep() is called
> > twice.  Once to decide if waiting is needed, and once to check against
> > after setting the task state do see if we might have missed a wakeup.
> > 
> > signed-off-by: NeilBrown <neilb@suse.de>
> 
> I've tested and applied this one and the previous one to the thread
> scheduling branch, with a few minor fix-ups. Apologies for how long
> this took, I'm wrestling with a SATA/block bug on the v6.6 test
> system that is being very sassy and hard to nail down.

I'm happy that we are making progress and the series is getting improved
along the way.  Good lock with the block bug.

> 
> I need to dive into the backchannel patch next. I'm trying to think
> of how I want to test that one.
> 

I think lock-grant call backs should be easiest to trigger.
However I just tried mounting the filesystem twice with nosharecache,
and the locking that same file on both mounts.  I expected one to block
and hoped I would see the callback when the first lock was dropped.
However the second lock didn't block! That's a bug.
I haven't dug very deep yet, but I think the client is getting a
delegation for the first open (O_RDWR) so the server doesn't see the
lock.
Then when the lock arrives on the second mount, there is no conflicting
lock and the write delegation maybe isn't treated as a conflict?

I'll try to look more early next week.

NeilBrown

