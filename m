Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AFE274EDE5
	for <lists+linux-nfs@lfdr.de>; Tue, 11 Jul 2023 14:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjGKMRX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 11 Jul 2023 08:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjGKMRW (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 11 Jul 2023 08:17:22 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9909DE55
        for <linux-nfs@vger.kernel.org>; Tue, 11 Jul 2023 05:17:21 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 578711FD70;
        Tue, 11 Jul 2023 12:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1689077840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4IfSkK2HG9QQlBrdX2adPbgj8HunnKoeRU26w+Uj10Q=;
        b=OdJXkgowmR3tDqSERwn2NNdIgFKDoSv6TtanWJcNeZ5DBeD5fZ4UJPy5/lCf58GQkEFLii
        WoDTLUhTz+Dy5Isr9M6K8MpgdcwGNIMsDBJVd+bqFBJxb8m/wufOk4oi637GzAsYzheSg1
        IYPbvtXriE7vX55obYg2jGNpyOrCW34=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1689077840;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4IfSkK2HG9QQlBrdX2adPbgj8HunnKoeRU26w+Uj10Q=;
        b=20IS7eIBfWojoNXd/3OWYedxv8WC/24jHWgUc9KZAfay+b3jxsTFpXmTKYxlwEq1JPPx8h
        4KVaoofPoIAJLiCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2D87C1391C;
        Tue, 11 Jul 2023 12:17:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id F8FxNE1IrWR3NQAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 11 Jul 2023 12:17:17 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Jeff Layton" <jlayton@redhat.com>
Cc:     "Chuck Lever III" <chuck.lever@oracle.com>,
        "Chuck Lever" <cel@kernel.org>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        "lorenzo@kernel.org" <lorenzo@kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>
Subject: Re: [PATCH v3 5/9] SUNRPC: Count pool threads that were awoken but
 found no work to do
In-reply-to: <18061cab9338b08da691e8651e75f8fe8e88b830.camel@redhat.com>
References: <168900729243.7514.15141312295052254929.stgit@manet.1015granger.net>,
 <168900734678.7514.887270657845753276.stgit@manet.1015granger.net>,
 <168902815363.8939.4838920400288577480@noble.neil.brown.name>,
 <D20E4286-30D2-461D-B856-41D3C53C756C@oracle.com>,
 <168906929382.8939.6551236368797730920@noble.neil.brown.name>,
 <18061cab9338b08da691e8651e75f8fe8e88b830.camel@redhat.com>
Date:   Tue, 11 Jul 2023 22:17:14 +1000
Message-id: <168907783478.8939.2524484078705916909@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 11 Jul 2023, Jeff Layton wrote:
> On Tue, 2023-07-11 at 19:54 +1000, NeilBrown wrote:
> > On Tue, 11 Jul 2023, Chuck Lever III wrote:
> > >=20
> > > > On Jul 10, 2023, at 6:29 PM, NeilBrown <neilb@suse.de> wrote:
> > > >=20
> > > > On Tue, 11 Jul 2023, Chuck Lever wrote:
> > > > > From: Chuck Lever <chuck.lever@oracle.com>
> > > > >=20
> > > > > Measure a source of thread scheduling inefficiency -- count threads
> > > > > that were awoken but found that the transport queue had already been
> > > > > emptied.
> > > > >=20
> > > > > An empty transport queue is possible when threads that run between
> > > > > the wake_up_process() call and the woken thread returning from the
> > > > > scheduler have pulled all remaining work off the transport queue
> > > > > using the first svc_xprt_dequeue() in svc_get_next_xprt().
> > > >=20
> > > > I'm in two minds about this.  The data being gathered here is
> > > > potentially useful
> > >=20
> > > It's actually pretty shocking: I've measured more than
> > > 15% of thread wake-ups find no work to do.
> >=20
> > That is a bigger number than I would have guessed!
> >=20
>=20
> I'm guessing the idea is that the receiver is waking a thread to do the
> work, and that races with one that's already running? I'm sure there are
> ways we can fix that, but it really does seem like we're trying to
> reinvent workqueues here.

True.  But then workqueues seem to reinvent themselves every so often
too.  Once gets the impression they are trying to meet an enormous
variety of needs.
I'm not against trying to see if nfsd could work well in a workqueue
environment, but I'm not certain it is a good idea.  Maintaining control
of our own thread pools might be safer.

I have a vague memory of looking into this in more detail once and
deciding that it wasn't a good fit, but I cannot recall or easily deduce
the reason.  Obviously we would have to give up SIGKILL, but we want to
do that anyway.

Would we want unbound work queues - so they can be scheduled across
different CPUs?  Are NFSD threads cpu-intensive or not?  I'm not sure.

I would be happy to explore a credible attempt at a conversion.

NeilBrown


>=20
> > >=20
> > >=20
> > > > - but who it is useful to?
> > > > I think it is primarily useful for us - to understand the behaviour of
> > > > the implementation so we can know what needs to be optimised.
> > > > It isn't really of any use to a sysadmin who wants to understand how
> > > > their system is performing.
> > > >=20
> > > > But then .. who are tracepoints for?  Developers or admins?
> > > > I guess that fact that we feel free to modify them whenever we need
> > > > means they are primarily for developers?  In which case this is a good
> > > > patch, and maybe we'll revert the functionality one day if it turns o=
ut
> > > > that we can change the implementation so that a thread is never woken
> > > > when there is no work to do ....
> > >=20
> > > A reasonable question to ask. The new "starved" metric
> > > is similar: possibly useful while we are developing the
> > > code, but not particularly valuable for system
> > > administrators.
> > >=20
> > > How are the pool_stats used by administrators?
> >=20
> > That is a fair question.  Probably not much.
> > Once upon a time we had stats which could show a histogram how thread
> > usage.  I used that to decided if the load justified more threads.
> > But we removed it because it was somewhat expensive and it was argued it
> > may not be all that useful...
> > I haven't really looked at any other stats in my work.  Almost always it
> > is a packet capture that helps me see what is happening when I have an
> > issue to address.
> >=20
> > Maybe I should just accept that stats are primarily for developers and
> > they can be incredible useful for that purpose, and not worry if admins
> > might ever need them.
> >=20
> > >=20
> > > (And, why are they in /proc/fs/nfsd/ rather than under
> > > something RPC-related?)
> >=20
> > Maybe because we "owned" /proc/fs/nfsd/, but the RPC-related stuff is
> > under "net" and we didn't feel so comfortable sticking new stuff there.
> > Or maybe not.
> >=20
>=20
> --=20
> Jeff Layton <jlayton@redhat.com>
>=20
>=20

