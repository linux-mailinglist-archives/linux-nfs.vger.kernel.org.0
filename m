Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9113674EB2F
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jul 2023 11:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjGKJzG (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jul 2023 05:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjGKJzF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jul 2023 05:55:05 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45DBBE
        for <linux-nfs@vger.kernel.org>; Tue, 11 Jul 2023 02:55:00 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9B09D204E5;
        Tue, 11 Jul 2023 09:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689069299; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gzsWLRuhdeSOLUDx/pcf9/+vveFAeHPZQ7ic84kwCcU=;
        b=m1tWvUaoJw6Lgl6TO0qE4llB6BVZQflI94ORGXTW/lAbaYL0KlFo11gTSDkCsqITFGC1XW
        m6ONrqF8n1R4TKoxgYCHYpAfMW2gn3bPfrn9d0NUE7Uuf4q6w4Z5eeL20I6+brxmMMQOV0
        n/rU7hEpce9rplv+7C5MUqsv3qQyNws=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689069299;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gzsWLRuhdeSOLUDx/pcf9/+vveFAeHPZQ7ic84kwCcU=;
        b=xNkXATdB2hjG5cAH3hzrt+BV4iYVR6md4qsoU12vJd3DRa2rIcUmzLB9XKWxv22+wDCXM0
        3Ur2xB/MZ1J8X/BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7238D1391C;
        Tue, 11 Jul 2023 09:54:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id IX42CfEmrWTQZwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 11 Jul 2023 09:54:57 +0000
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
In-reply-to: <D20E4286-30D2-461D-B856-41D3C53C756C@oracle.com>
References: <168900729243.7514.15141312295052254929.stgit@manet.1015granger.net>,
 <168900734678.7514.887270657845753276.stgit@manet.1015granger.net>,
 <168902815363.8939.4838920400288577480@noble.neil.brown.name>,
 <D20E4286-30D2-461D-B856-41D3C53C756C@oracle.com>
Date:   Tue, 11 Jul 2023 19:54:53 +1000
Message-id: <168906929382.8939.6551236368797730920@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 11 Jul 2023, Chuck Lever III wrote:
> 
> > On Jul 10, 2023, at 6:29 PM, NeilBrown <neilb@suse.de> wrote:
> > 
> > On Tue, 11 Jul 2023, Chuck Lever wrote:
> >> From: Chuck Lever <chuck.lever@oracle.com>
> >> 
> >> Measure a source of thread scheduling inefficiency -- count threads
> >> that were awoken but found that the transport queue had already been
> >> emptied.
> >> 
> >> An empty transport queue is possible when threads that run between
> >> the wake_up_process() call and the woken thread returning from the
> >> scheduler have pulled all remaining work off the transport queue
> >> using the first svc_xprt_dequeue() in svc_get_next_xprt().
> > 
> > I'm in two minds about this.  The data being gathered here is
> > potentially useful
> 
> It's actually pretty shocking: I've measured more than
> 15% of thread wake-ups find no work to do.

That is a bigger number than I would have guessed!

> 
> 
> > - but who it is useful to?
> > I think it is primarily useful for us - to understand the behaviour of
> > the implementation so we can know what needs to be optimised.
> > It isn't really of any use to a sysadmin who wants to understand how
> > their system is performing.
> > 
> > But then .. who are tracepoints for?  Developers or admins?
> > I guess that fact that we feel free to modify them whenever we need
> > means they are primarily for developers?  In which case this is a good
> > patch, and maybe we'll revert the functionality one day if it turns out
> > that we can change the implementation so that a thread is never woken
> > when there is no work to do ....
> 
> A reasonable question to ask. The new "starved" metric
> is similar: possibly useful while we are developing the
> code, but not particularly valuable for system
> administrators.
> 
> How are the pool_stats used by administrators?

That is a fair question.  Probably not much.
Once upon a time we had stats which could show a histogram how thread
usage.  I used that to decided if the load justified more threads.
But we removed it because it was somewhat expensive and it was argued it
may not be all that useful...
I haven't really looked at any other stats in my work.  Almost always it
is a packet capture that helps me see what is happening when I have an
issue to address.

Maybe I should just accept that stats are primarily for developers and
they can be incredible useful for that purpose, and not worry if admins
might ever need them.

> 
> (And, why are they in /proc/fs/nfsd/ rather than under
> something RPC-related?)

Maybe because we "owned" /proc/fs/nfsd/, but the RPC-related stuff is
under "net" and we didn't feel so comfortable sticking new stuff there.
Or maybe not.

Thanks,
NeilBrown
