Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30C177173B
	for <lists+linux-nfs@lfdr.de>; Mon,  7 Aug 2023 01:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbjHFXHT (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 6 Aug 2023 19:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbjHFXHS (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 6 Aug 2023 19:07:18 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7228170B
        for <linux-nfs@vger.kernel.org>; Sun,  6 Aug 2023 16:07:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DE806218A0;
        Sun,  6 Aug 2023 23:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1691363234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5JbeU5aRaj3Z/fM7IotePGXj9YX4ItnBvXHWwy/+qUo=;
        b=Xs3ZX1jdelC1iJsnVRLssB77IEgl+tMp7XJFWpVJxajAwDt5O85Iqc68Zd/cnv2XS2Jxfr
        Vidp2jFTJLD98aHYMja6yPdumbj9ulz+k5tD/Jc/5BBHcpwHGaI1NJVaUglka+LY7q0qR0
        eJNMsqJDbPK2NQ/y6uAJFR9HTqpVbGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1691363234;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5JbeU5aRaj3Z/fM7IotePGXj9YX4ItnBvXHWwy/+qUo=;
        b=S/pV6XPsufkBq+CRNJAy5vd98oxc+uQQzpu/vHoxXciMFSiV+leEG3918N7f4N3qp48UhS
        MM8lS+ca7ZPA/lCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A256F13421;
        Sun,  6 Aug 2023 23:07:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hoCRFaEn0GSBMAAAMHmgww
        (envelope-from <neilb@suse.de>); Sun, 06 Aug 2023 23:07:13 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     "Jeff Layton" <jlayton@kernel.org>, linux-nfs@vger.kernel.org
Subject: Re: [PATCH 2/6] SUNRPC: rename and refactor svc_get_next_xprt()
In-reply-to: <169109712368.32308.6546907686830224026@noble.neil.brown.name>
References: <20230802073443.17965-1-neilb@suse.de>,
 <20230802073443.17965-3-neilb@suse.de>,
 <ZMv5S7k4iCQgYXZ4@tissot.1015granger.net>,
 <169109712368.32308.6546907686830224026@noble.neil.brown.name>
Date:   Mon, 07 Aug 2023 09:07:07 +1000
Message-id: <169136322726.32308.17877125734879515633@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 04 Aug 2023, NeilBrown wrote:
> On Fri, 04 Aug 2023, Chuck Lever wrote:
> > On Wed, Aug 02, 2023 at 05:34:39PM +1000, NeilBrown wrote:
> > > svc_get_next_xprt() does a lot more than just get an xprt.  It also
> > > decides if it needs to sleep, depending not only on the availability of
> > > xprts but also on the need to exit or handle external work.
> > > 
> > > So rename it to svc_rqst_wait_for_work() and only do the testing and
> > > waiting.  Move all the waiting-related code out of svc_recv() into the
> > > new svc_rqst_wait_for_work().
> > > 
> > > Move the dequeueing code out of svc_get_next_xprt() into svc_recv().
> > > 
> > > Previously svc_xprt_dequeue() would be called twice, once before waiting
> > > and possibly once after.  Now instead rqst_should_sleep() is called
> > > twice.  Once to decide if waiting is needed, and once to check against
> > > after setting the task state do see if we might have missed a wakeup.
> > > 
> > > signed-off-by: NeilBrown <neilb@suse.de>
> > 
> > I've tested and applied this one and the previous one to the thread
> > scheduling branch, with a few minor fix-ups. Apologies for how long
> > this took, I'm wrestling with a SATA/block bug on the v6.6 test
> > system that is being very sassy and hard to nail down.
> 
> I'm happy that we are making progress and the series is getting improved
> along the way.  Good lock with the block bug.
> 
> > 
> > I need to dive into the backchannel patch next. I'm trying to think
> > of how I want to test that one.
> > 
> 
> I think lock-grant call backs should be easiest to trigger.
> However I just tried mounting the filesystem twice with nosharecache,
> and the locking that same file on both mounts.  I expected one to block
> and hoped I would see the callback when the first lock was dropped.
> However the second lock didn't block! That's a bug.
> I haven't dug very deep yet, but I think the client is getting a
> delegation for the first open (O_RDWR) so the server doesn't see the
> lock.
> Then when the lock arrives on the second mount, there is no conflicting
> lock and the write delegation maybe isn't treated as a conflict?
> 
> I'll try to look more early next week.

The bug appears to be client-side.
When I mount the same filesystem twice using nosharecache the client
only creates a single session.  One of the mounts opens the file and
gets a write delegation.  The other mount opens the same file but this
doesn't trigger a delegation recall as the server thinks it is the same
client as it is using the same session.  But the client is caching the
two mounts separately and not sharing the delegation.
So when the second mount locks the file the server allows it, even
though the first mount thinks it holds a lock thanks to the delegation.

I think nosharecache needs to use a separate identity and create a
separate session.

I repeated the test using network namespaces to create a genuinely
separate clients so the server now sees two clients opening the same file
and trying to lock it.  I now see both CB_RECALL and CB_NOTIFY_LOCK
callbacks being handled correctly.

NeilBrown
