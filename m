Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E0C75A2B2
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jul 2023 01:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjGSXUg (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Jul 2023 19:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjGSXUf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Jul 2023 19:20:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03520E53
        for <linux-nfs@vger.kernel.org>; Wed, 19 Jul 2023 16:20:30 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 99C362024F;
        Wed, 19 Jul 2023 23:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689808824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4b1vBg50KuKttMWwDL5XRNrYR5tS1+N2W1FVh3mAhv4=;
        b=eXw2UJEANrHhWwEqTtmIttMaB/8sGznULQ1bF9QrsPIKS1gxVRCSx+F+c8Y9TGJzSx7R2c
        y+dvvo9o87yvU5qQvlwhCeagti2AehlLnkfeLyrpmCuT8Jfn95cAouUnLp6C2cG+nksRNB
        YA464z+Tcq8p1tlLbLwo49hld8Tlaro=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689808824;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4b1vBg50KuKttMWwDL5XRNrYR5tS1+N2W1FVh3mAhv4=;
        b=4UMCn/BHPZXuT4YadcTOCiDPGMcIzzZELJMB5VTXZriOpYSGvhmft9sk3+ZBaH4TPJTdPI
        1vkstYwuycF4wnBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 145D313460;
        Wed, 19 Jul 2023 23:20:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id T9tuLrZvuGSWPQAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 19 Jul 2023 23:20:22 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Chuck Lever" <cel@kernel.org>, "Jeff Layton" <jlayton@kernel.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 10/14] SUNRPC: change svc_pool_wake_idle_thread() to
 return nothing.
In-reply-to: <9EEE82A6-6D25-4939-A4F5-BAC8E9986FF3@oracle.com>
References: <168966227838.11075.2974227708495338626.stgit@noble.brown>,
 <168966228866.11075.18415964365983945832.stgit@noble.brown>,
 <ZLaagzqpB9MsQ5yb@bazille.1015granger.net>,
 <168972938409.11078.8409356274248659649@noble.neil.brown.name>,
 <9EEE82A6-6D25-4939-A4F5-BAC8E9986FF3@oracle.com>
Date:   Thu, 20 Jul 2023 09:20:18 +1000
Message-id: <168980881867.11078.6059884952065090216@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 19 Jul 2023, Chuck Lever III wrote:
> 
> > On Jul 18, 2023, at 9:16 PM, NeilBrown <neilb@suse.de> wrote:
> > 
> > On Tue, 18 Jul 2023, Chuck Lever wrote:
> >> On Tue, Jul 18, 2023 at 04:38:08PM +1000, NeilBrown wrote:
> >>> No callers of svc_pool_wake_idle_thread() care which thread was woken -
> >>> except one that wants to trace the wakeup.  For now we drop that
> >>> tracepoint.
> >> 
> >> That's an important tracepoint, IMO.
> >> 
> >> It might be better to have svc_pool_wake_idle_thread() return void
> >> right from it's introduction, and move the tracepoint into that
> >> function. I can do that and respin if you agree.
> > 
> > Mostly I agree.
> > 
> > It isn't clear to me how you would handle trace_svc_xprt_enqueue(),
> > as there would be no code that can see both the trigger xprt, and the
> > woken rqst.
> > 
> > I also wonder if having the trace point when the wake-up is requested
> > makes any sense, as there is no guarantee that thread with handle that
> > xprt.
> > 
> > Maybe the trace point should report when the xprt is dequeued.  i.e.
> > maybe trace_svc_pool_awoken() should report the pid, and we could have
> > trace_svc_xprt_enqueue() only report the xprt, not the rqst.
> 
> I'll come up with something that rearranges the tracepoints so that
> svc_pool_wake_idle_thread() can return void.

My current draft code has svc_pool_wake_idle_thread() returning bool -
if it found something to wake up - purely for logging.
I think it is worth logging whether an event triggered a wake up or not,
and which event did that.  I'm less you that the pid is relevant.  But
as you say - this will probably become clearer as the code settles down.

Thanks,
NeilBrown


> 
> svc_pool_wake_idle_thread() can save the waker's PID in svc_rqst
> somewhere, for example. The dequeue tracepoint can then report that
> (if it's still interesting when we're all done with this work).
> 
> 
> --
> Chuck Lever
> 
> 
> 

