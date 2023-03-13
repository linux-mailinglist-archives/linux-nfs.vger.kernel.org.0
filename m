Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9F56B81A0
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Mar 2023 20:20:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjCMTUk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 13 Mar 2023 15:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbjCMTUe (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 13 Mar 2023 15:20:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E7C5D45D
        for <linux-nfs@vger.kernel.org>; Mon, 13 Mar 2023 12:20:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06088614AC
        for <linux-nfs@vger.kernel.org>; Mon, 13 Mar 2023 19:19:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6DEFC433EF;
        Mon, 13 Mar 2023 19:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678735194;
        bh=AeEB/afJt1easpj3W3kPgswfgr/E3HOwxH80BcPkVXY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=JuR0Dsu2wMLeUs0Vc1WR9iA/OcIRNHEegR2X0+KReYQ0e4T2w5LG4yUZ60QfHrADj
         87DvhGyLgpbjEfPeEyi5Y3lukzXzh2zWmH5vYdjUEyC/V+2d1mbeq2NVkATYsIlHKp
         MbKZ2dNVZ4FT3d/LV9slKk5nb1BmPltwNWzVKAK2DvnQRKIno9CLLY0CZTAEtYSRbk
         kuHzV2yC3bBhO6muSPSo6rDDKWP3LjdMz3M0D7np/eu/DdFOahtLe5t4XZgZVHM3XV
         UEAzmIaUkS15Vy3SqU3XIQhJaQAoIOgSmDhY27dR66gdpTgRTnPtXGFJZkTO7IrW2u
         Q/PiYhSZv6HrQ==
Message-ID: <1538df6baedec8ed465c3902aebebe60d560f859.camel@kernel.org>
Subject: Re: [PATCH 0/7] lockd: fix races that can result in stuck filelocks
From:   Jeff Layton <jlayton@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "yoyang@redhat.com" <yoyang@redhat.com>
Date:   Mon, 13 Mar 2023 15:19:52 -0400
In-Reply-To: <CAOQ4uxhFf=k+7Zm-Go=a+MJs0hYHrD+KrxOXw2mLXMcz4xACMQ@mail.gmail.com>
References: <20230303121603.132103-1-jlayton@kernel.org>
         <0FC66364-4F59-4590-9211-EB54E918C97D@oracle.com>
         <CAOQ4uxhwN9Lgzn0_YB33Jfzy1idRene2=tBrr4s9T5PYefJm_Q@mail.gmail.com>
         <7b70e66ec03fecd9f0d93f77c737393fa4ab7fb5.camel@kernel.org>
         <CAOQ4uxhFf=k+7Zm-Go=a+MJs0hYHrD+KrxOXw2mLXMcz4xACMQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, 2023-03-13 at 17:14 +0200, Amir Goldstein wrote:
> On Mon, Mar 13, 2023 at 12:45=E2=80=AFPM Jeff Layton <jlayton@kernel.org>=
 wrote:
> >=20
> > On Sun, 2023-03-12 at 17:33 +0200, Amir Goldstein wrote:
> > > On Fri, Mar 3, 2023 at 4:54=E2=80=AFPM Chuck Lever III <chuck.lever@o=
racle.com> wrote:
> > > >=20
> > > >=20
> > > >=20
> > > > > On Mar 3, 2023, at 7:15 AM, Jeff Layton <jlayton@kernel.org> wrot=
e:
> > > > >=20
> > > > > I sent the first patch in this series the other day, but didn't g=
et any
> > > > > responses.
> > > >=20
> > > > We'll have to work out who will take which patches in this set.
> > > > Once fully reviewed, I can take the set if the client maintainers
> > > > send Acks for 2-4 and 6-7.
> > > >=20
> > > > nfsd-next for v6.4 is not yet open. I can work on setting that up
> > > > today.
> > > >=20
> > > >=20
> > > > > Since then I've had time to follow up on the client-side part
> > > > > of this problem, which eventually also pointed out yet another bu=
g on
> > > > > the server side. There are also a couple of cleanup patches in he=
re too,
> > > > > and a patch to add some tracepoints that I found useful while dia=
gnosing
> > > > > this.
> > > > >=20
> > > > > With this set on both client and server, I'm now able to run Yong=
cheng's
> > > > > test for an hour straight with no stuck locks.
> > >=20
> > > My nfstest_lock test occasionally gets into an endless wait loop for =
the lock in
> > > one of the optests.
>=20
> I forgot to mention that the regression is only with nfsversion=3D3!
> Is anyone else running nfstest_lock with nfsversion=3D3?
>=20
> > >=20
> > > AFAIK, this started happening after I upgraded my client machine to v=
5.15.88.
> > > Does this seem related to the client bug fixes in this patch set?
> > >=20
> > > If so, is this bug a regression? and why are the fixes aimed for v6.4=
?
> > >=20
> >=20
> > Most of this (lockd) code hasn't changed in well over a decade, so if
> > this is a regression then it's a very old one. I suppose it's possible
> > that this regressed after the BKL was removed from this code, but that
> > was a long time ago now and I'm not sure I can identify a commit that
> > this fixes.
> >=20
> > I'm fine with this going in sooner than v6.4, but given that this has
> > been broken so long, I didn't see the need to rush.
> >=20
>=20
> I don't know what is the relation of the optest regression that I am
> experiencing and the client and server bugs mentioned in this patch set.
> I just re-tested optest01 with several combinations of client-server kern=
els.
> I rebooted both client and server before each test.
> The results are a bit odd:
>=20
> client           server      optest01 result
> ------------------------------------------------------
> 5.10.109     5.10.109  optest01 completes successfully after <30s
> 5.15.88       5.15.88    optest01 never completes (see attached log)
> 5.15.88       5.10.109  optest01 never completes
> 5.15.88+ [*] 5.15.88   optest01 never completes
> 5.15.88+     5.10.109  optest01 never completes
> 5.15.88+     5.15.88+  optest01 completes successfully after ~300s [**]
>=20
> Unless I missed something with the tests, it looks like
> 1.a. There was a regressions in client from 5.10.109..5.15.88
> 1.b. The regression is manifested with both 5.10 and 5.15 servers
> 2.a. The patches improve the situation (from infinite to 30s per wait)...
> 2.b. ...but only when applied to both client and server and...
> 2.c. The situation is still a lot worse than 5.10 client with 5.10 server
>=20
> Attached also the NFS[D] Kconfig which is identical for the tested
> 5.10 and 5.15 kernels.
>=20
> Do you need me to provide any traces or any other info?
>=20
> Thanks,
> Amir.
>=20
> [*] 5.15.88+ stands for 5.15.88 + the patches in this set, which all
> apply cleanly
> [**] The test takes 300s because every single 30s wait takes the entire 3=
0s:
>=20
>     DBG1: 15:21:47.118095 - Unlock file (F_UNLCK, F_SETLK) off=3D0 len=3D=
0
> range(0, 18446744073709551615)
>     DBG3: 15:21:47.119832 - Wait up to 30 secs to check if blocked
> lock has been granted @253.87
>     DBG3: 15:21:48.121296 - Check if blocked lock has been granted @254.8=
7
> ...
>     DBG3: 15:22:14.158314 - Check if blocked lock has been granted @280.9=
0
>     DBG3: 15:22:15.017594 - Getting results from blocked lock @281.76
>     DBG1: 15:22:15.017832 - Unlock file (F_UNLCK, F_SETLK) off=3D0 len=3D=
0
> range(0, 18446744073709551615) on second process @281.76
>     PASS: Locking byte range (72 passed, 0 failed)

This sounds like a different problem than what this patchset fixes. This
patchset is really all about signal handling during the wait for a lock.
That sounds more like the wait is just not completing?

I just kicked off this test in nfstests with vers=3D3 and I think I see
the same 30s stalls. Coincidentally:

    #define NLMCLNT_POLL_TIMEOUT    (30*HZ)                           =20

So it does look like something may be going wrong with the lock granting
mechanism. I'll need to do a bit of investigation to figure out what's
going on.

--=20
Jeff Layton <jlayton@kernel.org>
