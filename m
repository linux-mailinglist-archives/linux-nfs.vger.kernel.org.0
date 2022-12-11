Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC9F264946D
	for <lists+linux-nfs@lfdr.de>; Sun, 11 Dec 2022 14:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiLKN04 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 11 Dec 2022 08:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbiLKN0y (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 11 Dec 2022 08:26:54 -0500
Received: from mail.valinux.co.jp (mail.valinux.co.jp [210.128.90.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DDFFD00
        for <linux-nfs@vger.kernel.org>; Sun, 11 Dec 2022 05:26:52 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.valinux.co.jp (Postfix) with ESMTP id B43E0A898C;
        Sun, 11 Dec 2022 22:26:49 +0900 (JST)
X-Virus-Scanned: Debian amavisd-new at valinux.co.jp
Received: from mail.valinux.co.jp ([127.0.0.1])
        by localhost (mail.valinux.co.jp [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Qoop031r9msT; Sun, 11 Dec 2022 22:26:49 +0900 (JST)
Received: from brer (vagw.valinux.co.jp [210.128.90.14])
        by mail.valinux.co.jp (Postfix) with ESMTP id 7E18EA8918;
        Sun, 11 Dec 2022 22:26:49 +0900 (JST)
From:   =?iso-2022-jp?B?TUlOT1VSQSBNYWtvdG8gLyAbJEJMJzE6GyhCIBskQj8/GyhC?= 
        <minoura@valinux.co.jp>
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     Hiroshi Shimamoto <h-shimamoto@nec.com>,
        "linux-nfs\@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] SUNRPC: serialize gss upcalls for the same uid
References: <20221209003032.3211581-1-h-shimamoto@nec.com>
        <17D036AA-5F8A-497B-9D66-879E9D201BDD@hammerspace.com>
Date:   Sun, 11 Dec 2022 22:26:49 +0900
In-Reply-To: <17D036AA-5F8A-497B-9D66-879E9D201BDD@hammerspace.com> (Trond
        Myklebust's message of "Sat, 10 Dec 2022 19:04:39 +0000")
Message-ID: <kk5sfhmdqau.fsf@brer.local.valinux.co.jp>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_SORBS_DUL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


Thanks for your comment.

> > On Dec 8, 2022, at 19:30, Hiroshi Shimamoto <h-shimamoto@nec.com> wrote:
> > 
> > From: minoura <minoura@valinux.co.jp>
> > 
> > Commit 9130b8dbc6ac ("SUNRPC: allow for upcalls for the same uid
> > but different gss service") introduced `auth` argument to
> > __gss_find_upcall(), but in gss_pipe_downcall() it was left as NULL
> > since it (and auth->service) was not (yet) determined.
> > 
> > When multiple upcalls with the same uid and different service are
> > ongoing, it could happen that __gss_find_upcall(), which returns the
> > first match found in the pipe->in_downcall list, could not find the
> > correct gss_msg corresponding to the downcall we are looking for due
> > to two reasons:
> > 
> > - the order of the msgs in pipe->in_downcall and those in pipe->pipe
> >  (that is, the order of the upcalls sent to rpc.gssd) might be
> >  different because pipe->lock is dropped between adding one to each
> >  list.
> > - rpc.gssd uses threads to write responses, which means we cannot
> >  guarantee the order of responses.
> > 
> > We could see mount.nfs process hung in D state with multiple mount.nfs
> > are executed in parallel.  The call trace below is of CentOS 7.9
> > kernel-3.10.0-1160.24.1.el7.x86_64 but we observed the same hang w/
> > elrepo kernel-ml-6.0.7-1.el7.
> > 
> > PID: 71258  TASK: ffff91ebd4be0000  CPU: 36  COMMAND: "mount.nfs"
> > #0 [ffff9203ca3234f8] __schedule at ffffffffa3b8899f
> > #1 [ffff9203ca323580] schedule at ffffffffa3b88eb9
> > #2 [ffff9203ca323590] gss_cred_init at ffffffffc0355818 [auth_rpcgss]
> > #3 [ffff9203ca323658] rpcauth_lookup_credcache at ffffffffc0421ebc [sunrpc]
> > #4 [ffff9203ca3236d8] gss_lookup_cred at ffffffffc0353633 [auth_rpcgss]
> > #5 [ffff9203ca3236e8] rpcauth_lookupcred at ffffffffc0421581 [sunrpc]
> > #6 [ffff9203ca323740] rpcauth_refreshcred at ffffffffc04223d3 [sunrpc]
> > #7 [ffff9203ca3237a0] call_refresh at ffffffffc04103dc [sunrpc]
> > #8 [ffff9203ca3237b8] __rpc_execute at ffffffffc041e1c9 [sunrpc]
> > #9 [ffff9203ca323820] rpc_execute at ffffffffc0420a48 [sunrpc]
> > 
> > The scenario is like this. Let's say there are two upcalls for
> > services A and B, A -> B in pipe->in_downcall, B -> A in pipe->pipe.
> > 
> > When rpc.gssd reads pipe to get the upcall msg corresponding to
> > service B from pipe->pipe and then writes the response, in
> > gss_pipe_downcall the msg corresponding to service A will be picked
> > because only uid is used to find the msg and it is before the one for
> > B in pipe->in_downcall.  And the process waiting for the msg
> > corresponding to service A will be woken up.

> Wait a minute… The ‘service’ here is one of krb5, krb5i, or
> krb5p. What is being pushed down from user space is a RPCSEC_GSS
> context that can be used for any one of those services. So the
> ordering of A and B is not supposed to matter. Any one of those
> requests can take the context and make use of it.

> However once the context has been used with one of the krb5, krb5i or
> krb5p services then it cannot be used with any of the others. This is
> why commit 9130b8dbc6ac that you referenced above separates the
> services in gss_add_msg().

Right.  (BTW I am wondering why we do not have to compare
->service in gss_match(), during looking up the cred cache...)

> > 
> > Actual scheduing of that process might be after rpc.gssd processes the
> > next msg.  In rpc_pipe_generic_upcall it clears msg->errno (for A).
> > The process is scheduled to see gss_msg->ctx == NULL and
> > gss_msg->msg.errno == 0, therefore it cannot break the loop in
> > gss_create_upcall and is never woken up after that.
> > 
> > This patch introduces wait and retry at gss_add_msg() to serialize
> > when requests with the same uid but different service comes.

> As long as rpc.gssd returns one context downcall for each upcall (or
> it breaks the connection in order to force a retransmission) then we
> shouldn’t have to serialise anything.

> However what we could do to fix the race you appear to be describing
> is to check if the upcall has completed yet before we accept the
> message as a candidate for the downcall. That could be just a simple
> check for (msg->copied != 0 && list_empty(&msg->list)). Maybe add a
> helper for that in include/linux/sunrpc/rpc_pipe_fs.h?

This makes perfect sense.  The race occurs because downcall
(mistakingly) picks a msg which is not sent to gssd yet, and
it can be distinguished with that condition.  Will revise
the patch. Thanks!

> _________________________________
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com

