Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCF4E6FD2E9
	for <lists+linux-nfs@lfdr.de>; Wed, 10 May 2023 01:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbjEIXAx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 9 May 2023 19:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbjEIXAw (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 9 May 2023 19:00:52 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0176A4EE8
        for <linux-nfs@vger.kernel.org>; Tue,  9 May 2023 16:00:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id ADDD121A04;
        Tue,  9 May 2023 23:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683673249; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W5ZYMOe2Fpogi11yQEuWpeo5bSSvmGsXaTGdRZdiNGo=;
        b=b8ViCKFNn8vPUa66u7b8TJxk1JZU70JJPK5GEhEanVKnhh4Tzk5sp4H15gGnuLeR83H5gi
        Ej3nz9C22LfeEyHhXLMGq327W1BpmJ+VxpUflowr/HnmP9pu3tj/+Uxgx7wkVh3gefXUP7
        H0kZLLA3dQW24ra865PTd+U3untNxao=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683673249;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W5ZYMOe2Fpogi11yQEuWpeo5bSSvmGsXaTGdRZdiNGo=;
        b=EjOOl7jZWW8NRirjx+BgDY4hflWi2AKGxRrZ1fOEpcBHmyFVu0fXDsaPDExMAvCkJ9b/ah
        KMooibUav7nXqpAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E3839139B3;
        Tue,  9 May 2023 23:00:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id P99SJZ7QWmR0fwAAMHmgww
        (envelope-from <neilb@suse.de>); Tue, 09 May 2023 23:00:46 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "Nikita Yushchenko" <nikita.yoush@cogentembedded.com>
Cc:     "Petr Vorel" <pvorel@suse.cz>, "Jeff Layton" <jlayton@kernel.org>,
        ltp@lists.linux.it, "Cyril Hrubis" <chrubis@suse.cz>,
        linux-nfs@vger.kernel.org, "Steve Dickson" <steved@redhat.com>,
        "Alexey Kodanev" <aleksei.kodanev@bell-sw.com>
Subject: Re: [PATCH 1/1] nfslock01.sh: Don't test on NFS v3 on TCP
In-reply-to: <81826e4f-aa4c-1213-8b2e-28ef57caf1a3@cogentembedded.com>
References: <20230502075921.3614794-1-pvorel@suse.cz>,
 <d441b9f9dfcbb4719d97c7b3b5950dfeeb8913d2.camel@kernel.org>,
 <20230502134146.GA3654451@pevik>,
 <81826e4f-aa4c-1213-8b2e-28ef57caf1a3@cogentembedded.com>
Date:   Wed, 10 May 2023 09:00:43 +1000
Message-id: <168367324318.15152.8314945101964061099@noble.neil.brown.name>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 08 May 2023, Nikita Yushchenko wrote:
> >> rpcbind was obviously written in a time before namespaces were even a
> >> thought to anyone. I wonder if there is something we can do in rpcbind
> >> itself to guard against these sorts of shenanigans? Probably not, I
> >> guess...
> >=20
> > Maybe Steve or Neil have some idea.
> >=20
> >> Is /var shared between namespaces in this test for some particular
> >> reason?
> >=20
> > I hope I got , we talk about /var/run/netns/ltp_ns, which is symlink to
> > /proc/$pid/ns/net. Or is it really about /run/rpcbind.sock vs
> > /var/run/rpcbind.sock?
>=20
> The overall picture is:
>=20
> - by design, filesystem namespaces and network namespaces are independent, =
it is pretty ok for two=20
> processes to share filesystem namespace and be in different network namespa=
ces, or vice versa.
>=20
> - the code in question, while being in the kernel for ages, is breaking thi=
s basic design, by using=20
> filesystem path to contact a network service,

Not just in the kernel, but also in user-space.  The kernel contacts
rpcbind to find how to talk to statd.  statd talks to rpcbind to tell it
how it where it can be reached.  As you say - it has been this way for
"ages".

So maybe the bug is that something creates a network namespace without
also creating a filesystem namespace.  Certainly the kernel allows this
as it should because the kernel doesn't set policy.
But using the freedom to create a setup that doesn't actually work is
foolish.  If ltp creates a network namespace without creating a matching
filesystem name space, and expects NFSv3 to work - then that is a bug in
ltp.

Now I agree that using path names seems not ideal in this case, and it
would be a valuable enhancement to make it easy to avoid that.  But it
is an enhancement, not a bugfix.

>=20
> - thus the fix is: just not do that.

Surely the fix is to do something else, not just to do nothing :-)

>=20
> I consider kernel contacting rpcbind via AF_UNIX being a bug in the kernel =
namespace implementation. So=20
> this is a rare case when a test suite (LTP) helped to find a non-obvious ke=
rnel bug. Just need to fix=20
> that bug, if not yet.

There is good reason to use use AF_UNIX for the kernel to contact
rpcbind.

In fact the kernel has only been using AF_UNIX to contact rpcbind for
about 12 years.

Commit 7402ab19cdd5 ("SUNRPC: Use AF_LOCAL for rpcbind upcalls")
gives some of the reasons for the change.  They are still good reasons.

Fortunately Linux provides "abstract" AF_UNIX names, which provide all
the benefits that we want of AF_UNIX, but doesn't depend on the
filesystem and keeps the bindings private to the network namespace - the
best of both worlds.

To fully implement this we need changes to libtirpc and to the kernel.
Not big changes, but not entirely trivial either.

>=20
> Rpcbind listens both via AF_INET and via AP_UNIX, and did so for ages.
> It is even not possible to disable AF_INET listening without patching code.=
 By stopping contacting it=20
> via AF_UNIX, it is virtually impossible to break anything.

Check that commit for what can break.

For testing, you can change /usr/lib/rpcbind.sock to listen on
/run/NOT-rpcbind.sock instead. of /run/rpcbind.sock

It must listen on at least one AF_UNIX socket as you noted,
but it doesn't have to listen on one that any tool will talk to.  This
will cause all code (user-space and kernel) to fall-back on IPv6 or IPv4
to contact rpcbind.
So maybe you can work-around the bug in ltp that way.  You could even
just "rm -f /var/run/rpcbind.sock" after starting rpcbind, and before
running the test.

Meanwhile I'll post some patches which enhancements to the kernel and to
libtirpc to use abstract AF_UNIX socket when available.

Thanks,
NeilBrown
