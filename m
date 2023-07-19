Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7476B75A2D3
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Jul 2023 01:27:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjGSX1b (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Jul 2023 19:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGSX1a (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Jul 2023 19:27:30 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B800F9D
        for <linux-nfs@vger.kernel.org>; Wed, 19 Jul 2023 16:27:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 78B7D20258;
        Wed, 19 Jul 2023 23:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689809248; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y/OWWRwPvO0YlLnKu6AOus6tzg3z5Bp2WSJOuutaJSc=;
        b=mnv32iXxFX4fWhQ5HlitCRSudqlMEKpRZ0qi0gGY256RnCD+RgnRqSH9aP0AxDv43cw0hP
        QTYyyK/vvcYUtYzehRYvK80Zxe0NAXfUB0Xz/mmsTmw+DrHxnA7O02tzxmXI5WW8fh6vVx
        VQ+a2rudhzl3Aj5J1aChMlyrgynaiVY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689809248;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y/OWWRwPvO0YlLnKu6AOus6tzg3z5Bp2WSJOuutaJSc=;
        b=kYANUlmA26BhVunKROeGttW1rrV5XtahmtVtNYTKv3xDIF26q30C0gvTCPNmS8I37QXdXR
        TdwffzvRCoXEMaCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5043813460;
        Wed, 19 Jul 2023 23:27:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id hkZoAV5xuGQxQAAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 19 Jul 2023 23:27:26 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Chuck Lever III" <chuck.lever@oracle.com>
Cc:     "Chuck Lever" <cel@kernel.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        "Jeff Layton" <jlayton@redhat.com>,
        "david@fromorbit.com" <david@fromorbit.com>
Subject: Re: [PATCH v3 5/9] SUNRPC: Count pool threads that were awoken but
 found no work to do
In-reply-to: <3FF89A33-6C7C-4BC2-9973-A20E46A8A339@oracle.com>
References: <168900729243.7514.15141312295052254929.stgit@manet.1015granger.net>,
 <168900734678.7514.887270657845753276.stgit@manet.1015granger.net>,
 <168902815363.8939.4838920400288577480@noble.neil.brown.name>,
 <D20E4286-30D2-461D-B856-41D3C53C756C@oracle.com>,
 <168972716973.11078.4474704978173049217@noble.neil.brown.name>,
 <3FF89A33-6C7C-4BC2-9973-A20E46A8A339@oracle.com>
Date:   Thu, 20 Jul 2023 09:27:23 +1000
Message-id: <168980924309.11078.8450297121939615798@noble.neil.brown.name>
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
> > On Jul 18, 2023, at 8:39 PM, NeilBrown <neilb@suse.de> wrote:
> > 
> > On Tue, 11 Jul 2023, Chuck Lever III wrote:
> >> 
> >>> On Jul 10, 2023, at 6:29 PM, NeilBrown <neilb@suse.de> wrote:
> >>> 
> >>> On Tue, 11 Jul 2023, Chuck Lever wrote:
> >>>> From: Chuck Lever <chuck.lever@oracle.com>
> >>>> 
> >>>> Measure a source of thread scheduling inefficiency -- count threads
> >>>> that were awoken but found that the transport queue had already been
> >>>> emptied.
> >>>> 
> >>>> An empty transport queue is possible when threads that run between
> >>>> the wake_up_process() call and the woken thread returning from the
> >>>> scheduler have pulled all remaining work off the transport queue
> >>>> using the first svc_xprt_dequeue() in svc_get_next_xprt().
> >>> 
> >>> I'm in two minds about this.  The data being gathered here is
> >>> potentially useful
> >> 
> >> It's actually pretty shocking: I've measured more than
> >> 15% of thread wake-ups find no work to do.
> > 
> > I'm now wondering if that is a reliable statistic.
> > 
> > This counter as implemented doesn't count "pool threads that were awoken
> > but found no work to do".  Rather, it counts "pool threads that found no
> > work to do, either after having been awoken, or having just completed
> > some other request".
> 
> In the current code, the only way to get to "return -EAGAIN;" is if the
> thread calls schedule_timeout() (ie, it actually sleeps), then the
> svc_rqst was specifically selected and awoken, and the schedule_timeout()
> did not time out.
> 
> I don't see a problem.
> 

Yeah - I don't either any more.  Sorry for the noise.


> 
> > And it doesn't even really count that is it doesn't notice that lockd
> > "retry blocked" work (or the NFSv4.1 callback work, but we don't count
> > that at all I think).
> > 
> > Maybe we should only update the count if we had actually been woken up
> > recently.
> 
> So this one can be dropped for now since it's currently of value only
> for working on the scheduler changes. If the thread scheduler were to
> change such that a work item was actually assigned to a thread before
> it is awoken (a la, a work queue model) then this counter would be
> truly meaningless. I think we can wait for a bit.
> 

We used to assign a workitem to a thread before it was woken.  I find
that model to be aesthetically pleasing.
Trond changed that in
  Commit: 22700f3c6df5 ("SUNRPC: Improve ordering of transport processing")

claiming that the wake-up time for a sleeping thread could result in
poorer throughput.  No data given but I find the reasoning quite
credible.

Thanks,
NeilBrown

> 
> --
> Chuck Lever
> 
> 
> 

