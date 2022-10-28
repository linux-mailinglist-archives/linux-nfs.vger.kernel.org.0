Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EADD611B5A
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 22:04:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiJ1UEm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 28 Oct 2022 16:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiJ1UEm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 28 Oct 2022 16:04:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C8976BD59
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 13:04:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04F6162A4A
        for <linux-nfs@vger.kernel.org>; Fri, 28 Oct 2022 20:04:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1477DC433D6;
        Fri, 28 Oct 2022 20:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666987478;
        bh=IxowU0ZvwZsk/vbv32treX0xxaOVEynlwGXuDbwM6Rc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ka087CIvahs2IHc+tNVWidFXFB4NScJYRA7+16gRFaIWq3KCxsoofbKvgbNp1Ywqo
         /he62UbhHmdCDMFWTBYHto5x6XoLns9j1LGdSIHnswa5rEJIYk+HxJ0Wdvs1qp49cY
         gnv7oO8Ik3vcfO2xRJZS0Xsr5ZFdq7Av2C4/0AwoPldElAQrB7AfzgZj5L6xrkmN/Q
         L9gY2sxfNTV+FWb/JbeXZsiKzTxuQkTpXwa72HeHhJ4HS8fJELzoZ7hnehIIZ8jngM
         UoA32y+Y5R3RX0TJQ3g44BYliCFuVlJzMYGNmF1I+sh5ZshdiGy00tZEYdCI9OwChs
         z4PPvwpDmYquQ==
Message-ID: <aa20ef22ffa125076f35b8c1ecb508852c0bb073.camel@kernel.org>
Subject: Re: [PATCH v2 3/3] nfsd: start non-blocking writeback after adding
 nfsd_file to the LRU
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>
Date:   Fri, 28 Oct 2022 16:04:36 -0400
In-Reply-To: <2D64526B-6270-49B9-AC2C-F0118DCF2AF9@oracle.com>
References: <20221027215213.138304-1-jlayton@kernel.org>
         <20221027215213.138304-4-jlayton@kernel.org>
         <D32F829C-434C-4BA4-9057-C9769C2F4655@oracle.com>
         <ae07f54d107cf1848c0a36dd16e437185a0304c3.camel@kernel.org>
         <65194BBE-F4C7-4CD6-A618-690D1CCE235C@oracle.com>
         <cc4bfa448efedd0017fc7b20b8b7475907acbc5e.camel@kernel.org>
         <A040CDCA-5E3F-470F-8D69-8FF9DA4325FE@oracle.com>
         <098163d8067962f84a06af5d03379e2157974625.camel@kernel.org>
         <2D64526B-6270-49B9-AC2C-F0118DCF2AF9@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2022-10-28 at 18:53 +0000, Chuck Lever III wrote:
>=20
> > On Oct 28, 2022, at 1:43 PM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > On Fri, 2022-10-28 at 17:21 +0000, Chuck Lever III wrote:
> > >=20
> > > > On Oct 28, 2022, at 11:51 AM, Jeff Layton <jlayton@kernel.org> wrot=
e:
> > > >=20
> > > > On Fri, 2022-10-28 at 15:29 +0000, Chuck Lever III wrote:
> > > > >=20
> > > > > > On Oct 28, 2022, at 11:05 AM, Jeff Layton <jlayton@kernel.org> =
wrote:
> > > > > >=20
> > > > > > The problem with not calling vfs_fsync is that we might miss wr=
iteback
> > > > > > errors. The nfsd_file could get reaped before a v3 COMMIT ever =
comes in.
> > > > > > nfsd would eventually reopen the file but it could miss seeing =
the error
> > > > > > if it got opened locally in the interim.
> > > > >=20
> > > > > That helps. So we're surfacing writeback errors for local writers=
?
> > > > >=20
> > > >=20
> > > > Well for non-v3 writers anyway. I suppose you could hit the same
> > > > scenario with a mixed v3 and v4 workload if you were unlucky enough=
, or
> > > > mixed v3 and ksmbd workload, etc...
> > > >=20
> > > > > I guess I would like this flushing to interfere as little as poss=
ible
> > > > > with the server's happy zone, since it's not something clients ne=
ed to
> > > > > wait for, and an error is exceptionally rare.
> > > > >=20
> > > > > But also, we can't let writeback errors hold onto a bunch of memo=
ry
> > > > > indefinitely. How much nfsd_file and page cache memory might be b=
e
> > > > > pinned by a writeback error, and for how long?
> > > > >=20
> > > >=20
> > > > You mean if we were to stop trying to fsync out when closing? We do=
n't
> > > > keep files in the cache indefinitely, even if they have writeback
> > > > errors.
> > > >=20
> > > > In general, the kernel attempts to write things out, and if it fail=
s it
> > > > sets a writeback error in the mapping and marks the pages clean. So=
 if
> > > > we're talking about files that are no longer being used (since they=
're
> > > > being GC'ed), we only block reaping them for as long as writeback i=
s in
> > > > progress.
> > > >=20
> > > > Once writeback ends and it's eligible for reaping, we'll call vfs_f=
sync
> > > > a final time, grab the error and reset the write verifier when it's
> > > > non-zero.
> > > >=20
> > > > If we stop doing fsyncs, then that model sort of breaks down. I'm n=
ot
> > > > clear on what you'd like to do instead.
> > >=20
> > > I'm not clear either. I think I just have some hand-wavy requirements=
.
> > >=20
> > > I think keeping the flushes in the nfsd threads and away from single-
> > > threaded garbage collection makes sense. Keep I/O in nfsd context, no=
t
> > > in the filecache garbage collector. I'm not sure that's guaranteed
> > > if the garbage collection thread does an nfsd_file_put() that flushes=
.
> > >=20
> >=20
> > The garbage collector doesn't call nfsd_file_put directly, though it
> > will call nfsd_file_free, which now does a vfs_fsync.
>=20
> OK, thought I saw some email fly by that suggested using nfsd_file_put
> in the garbage collector. But... the vfs_fsync you mention can possibly
> trigger I/O and wait for it (it's not the SYNC_NONE flush) in the GC
> thread. Rare, but I'd rather not have even that possibility if we can
> avoid it.
>=20
>=20
> > > But, back to the topic of this patch: my own experiments with backgro=
und
> > > syncing showed that it introduces significant overhead and it wasn't
> > > really worth the trouble. Basically, on intensive workloads, the garb=
age
> > > collector must not stall or live-lock because it's walking through
> > > millions of pages trying to figure out which ones are dirty.
> > >=20
> >=20
> > If this is what you want, then kicking off SYNC_NONE writeback when we
> > put it on the LRU is the right thing to do.
> >=20
> > We want to ensure that when the thing is reaped from the LRU, that the
> > final vfs_fsync has to write nothing back. The penultimate put that add=
s
> > it to the LRU is almost certainly going to come in the context of an
> > nfsd thread, so kicking off background writeback at that point seems
> > reasonable.
>=20
> IIUC the opposing idea is to do a synchronous writeback in nfsd_file_put
> and then nothing in nfsd_file_free. Why isn't that adequate to achieve
> the same result ?
>=20

To make sure I understand:

For the GC case (v3), you basically want to do a vfs_fsync after we put
it onto the LRU list? We'd also do a vfs_fsync after the refcount goes
to 0 in nfsd_file_put.

That seems...worse than what I'm proposing. We'll end up with a bunch of
blocked nfsd threads for no reason. The writeback in most cases could
proceed asynchronously, and we'll be idling an nfsd thread for the sole
purpose of getting the result of that writeback.

I see no need to block an nfsd thread for this. If we kick off
WB_SYNC_NONE writeback when we put it on the list, then by the time we
get around to calling vfs_fsync for reaping the thing, it'll basically
be a no-op. PAGECACHE_TAG_DIRTY should be clear and vfs_fsync will just
scrape the wb error code and return without walking anything.

I get the goal of not idling the garbage collector for too long, but
some of that may just be unavoidable. Tearing down a nfsd_file can just
take a significant amount of time, between flushing data and close.

> Thinking aloud:
>=20
> - Suppose a client does some UNSTABLE NFSv3 WRITEs to a file
> - The client then waits long enough for the nfsd_file to get aged out
>   of the filecache
> - A local writer on the server triggers a writeback error on the file
> - The error is cleared by other activity
> - The client sends a COMMIT
>=20
> Wouldn't the server miss the chance to bump its write verifier in that
> case?
>=20

Yep. That is the danger.

>=20
> > Only files that aren't touched again get reaped off the LRU eventually,
> > so there should be no danger of nfsd redirtying it again.
>=20
> At the risk of rat-holing... IIUC the only case we should care about
> is if there are outstanding NFSv3 WRITEs that haven't been COMMITed.
> Seems like NFSv3-specific code, and not the filecache, should deal
> with that case, and leave nfsd_file_put/free out of it...? Again, no
> clear idea how it would, but just thinking about the layering here.
>=20

No idea how we'd do that. The filecache is what gives us persistent
"state" across disparate RPCs with v3. I think this is where the
solution has to be handled.


>=20
> > By the time we
> > get to reaping it, everything should be written back and the inode will
> > be ready to close with little delay.
>=20
>=20
>=20
> --
> Chuck Lever
>=20
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>
