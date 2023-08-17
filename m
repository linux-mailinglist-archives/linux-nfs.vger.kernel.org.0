Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7720377FF84
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Aug 2023 23:08:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236718AbjHQVHi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Aug 2023 17:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355175AbjHQVHM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Aug 2023 17:07:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8DD2D56
        for <linux-nfs@vger.kernel.org>; Thu, 17 Aug 2023 14:07:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F277633F6
        for <linux-nfs@vger.kernel.org>; Thu, 17 Aug 2023 21:07:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B8EC433C8;
        Thu, 17 Aug 2023 21:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692306430;
        bh=NrbQFHEoLYLUxMSClPh87DPv6jCc/l1HJ0KaWEc0W20=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=c0fmELe/1l1ua+VU9OYreEDMgq18ba8kNxzpBZ8ABTRrjmHutB3nEAApRKYcekHtB
         u2GTmNI8ZhBiLeswp9mxhiR7csPPiXj7sS1REVrP5uA3g6TW6qITBV8opHW8GAxaRx
         lhHpQSCfhSqJ7Ugwno3roZaWo8yweGF7sJrWZI+VK8NJYWCJCxi6ObYUnyKti5BeE0
         nkMWJKeduoSEizXQKWs2mqHAmmf6kdOhTUWgDxLEaaF5w03UsSt/LrPfO8lfL65VU+
         HxhhRwLOmTRdGMzSa6gnAwrVzFr+mxyToz9xVisBu2sI8336i4u2Dd2ubKZzcX8zkl
         V9eE3Y90KAqmg==
Message-ID: <7b2746692aef1725cb000faabf4db2d115279423.camel@kernel.org>
Subject: Re: xfstests results over NFS
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>,
        "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Date:   Thu, 17 Aug 2023 17:07:07 -0400
In-Reply-To: <6af7807c75e3d6110bc80661a600038f5cfb0022.camel@kernel.org>
References: <9ee56f62652c3d338aff809f70e7941dfc284bf9.camel@kernel.org>
         <7C595ADA-E841-44F7-918A-3A46A55D546B@oracle.com>
         <2fc1f9bf5fdc25acbcabaf4266584f0857bc4b19.camel@kernel.org>
         <CAFX2Jf=gq-U464_SrebSwCMOU+g0Vcx9Us7SPn8JQEoA6s27DQ@mail.gmail.com>
         <77977950a7d6a4539114fdd0d6db982143c4f9b1.camel@kernel.org>
         <0AEF7E06-E2F6-426D-B3DF-3D0ED8233082@oracle.com>
         <6af7807c75e3d6110bc80661a600038f5cfb0022.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2023-08-17 at 13:15 -0400, Jeff Layton wrote:
> On Thu, 2023-08-17 at 16:31 +0000, Chuck Lever III wrote:
> >=20
> > > On Aug 17, 2023, at 12:27 PM, Jeff Layton <jlayton@kernel.org> wrote:
> > >=20
> > > On Thu, 2023-08-17 at 11:17 -0400, Anna Schumaker wrote:
> > > > On Thu, Aug 17, 2023 at 10:22=E2=80=AFAM Jeff Layton <jlayton@kerne=
l.org> wrote:
> > > > >=20
> > > > > On Thu, 2023-08-17 at 14:04 +0000, Chuck Lever III wrote:
> > > > > >=20
> > > > > > > On Aug 17, 2023, at 7:21 AM, Jeff Layton <jlayton@kernel.org>=
 wrote:
> > > > > > >=20
> > > > > > > I finally got my kdevops (https://github.com/linux-kdevops/kd=
evops) test
> > > > > > > rig working well enough to get some publishable results. To r=
un fstests,
> > > > > > > kdevops will spin up a server and (in this case) 2 clients to=
 run
> > > > > > > xfstests' auto group. One client mounts with default options,=
 and the
> > > > > > > other uses NFSv3.
> > > > > > >=20
> > > > > > > I tested 3 kernels:
> > > > > > >=20
> > > > > > > v6.4.0 (stock release)
> > > > > > > 6.5.0-rc6-g4853c74bd7ab (Linus' tree as of a couple of days a=
go)
> > > > > > > 6.5.0-rc6-next-20230816-gef66bf8aeb91 (linux-next as of yeste=
rday morning)
> > > > > > >=20
> > > > > > > Here are the results summary of all 3:
> > > > > > >=20
> > > > > > > KERNEL:    6.4.0
> > > > > > > CPUS:      8
> > > > > > >=20
> > > > > > > nfs_v3: 727 tests, 12 failures, 569 skipped, 14863 seconds
> > > > > > > Failures: generic/053 generic/099 generic/105 generic/124
> > > > > > >   generic/193 generic/258 generic/294 generic/318 generic/319
> > > > > > >   generic/444 generic/528 generic/529
> > > > > > > nfs_default: 727 tests, 18 failures, 452 skipped, 21899 secon=
ds
> > > > > > > Failures: generic/053 generic/099 generic/105 generic/186
> > > > > > >   generic/187 generic/193 generic/294 generic/318 generic/319
> > > > > > >   generic/357 generic/444 generic/486 generic/513 generic/528
> > > > > > >   generic/529 generic/578 generic/675 generic/688
> > > > > > > Totals: 1454 tests, 1021 skipped, 30 failures, 0 errors, 3509=
6s
> > > > > > >=20
> > > > > > > KERNEL:    6.5.0-rc6-g4853c74bd7ab
> > > > > > > CPUS:      8
> > > > > > >=20
> > > > > > > nfs_v3: 727 tests, 9 failures, 570 skipped, 14775 seconds
> > > > > > > Failures: generic/053 generic/099 generic/105 generic/258
> > > > > > >   generic/294 generic/318 generic/319 generic/444 generic/529
> > > > > > > nfs_default: 727 tests, 16 failures, 453 skipped, 22326 secon=
ds
> > > > > > > Failures: generic/053 generic/099 generic/105 generic/186
> > > > > > >   generic/187 generic/294 generic/318 generic/319 generic/357
> > > > > > >   generic/444 generic/486 generic/513 generic/529 generic/578
> > > > > > >   generic/675 generic/688
> > > > > > > Totals: 1454 tests, 1023 skipped, 25 failures, 0 errors, 3539=
6s
> > > > > > >=20
> > > > > > > KERNEL:    6.5.0-rc6-next-20230816-gef66bf8aeb91
> > > > > > > CPUS:      8
> > > > > > >=20
> > > > > > > nfs_v3: 727 tests, 9 failures, 570 skipped, 14657 seconds
> > > > > > > Failures: generic/053 generic/099 generic/105 generic/258
> > > > > > >   generic/294 generic/318 generic/319 generic/444 generic/529
> > > > > > > nfs_default: 727 tests, 18 failures, 453 skipped, 21757 secon=
ds
> > > > > > > Failures: generic/053 generic/099 generic/105 generic/186
> > > > > > >   generic/187 generic/294 generic/318 generic/319 generic/357
> > > > > > >   generic/444 generic/486 generic/513 generic/529 generic/578
> > > > > > >   generic/675 generic/683 generic/684 generic/688
> > > > > > > Totals: 1454 tests, 1023 skipped, 27 failures, 0 errors, 3487=
0s
> > > >=20
> > > > As long as we're sharing results ... here is what I'm seeing with a
> > > > 6.5-rc6 client & server:
> > > >=20
> > > > anna@gouda ~ % xfstestsdb xunit list --results --runid 1741 --color=
=3Dnone
> > > > +------+----------------------+---------+----------+------+------+-=
-----+-------+
> > > > > run | device               | xunit   | hostname | pass | fail |
> > > > skip |  time |
> > > > +------+----------------------+---------+----------+------+------+-=
-----+-------+
> > > > > 1741 | server:/srv/xfs/test | tcp-3   | client   |  125 |    4 |
> > > > 464 | 447 s |
> > > > > 1741 | server:/srv/xfs/test | tcp-4.0 | client   |  117 |   11 |
> > > > 465 | 478 s |
> > > > > 1741 | server:/srv/xfs/test | tcp-4.1 | client   |  119 |   12 |
> > > > 462 | 404 s |
> > > > > 1741 | server:/srv/xfs/test | tcp-4.2 | client   |  212 |   18 |
> > > > 363 | 564 s |
> > > > +------+----------------------+---------+----------+------+------+-=
-----+-------+
> > > >=20
> > > > anna@gouda ~ % xfstestsdb show --failure 1741 --color=3Dnone
> > > > +-------------+---------+---------+---------+---------+
> > > > >   testcase | tcp-3   | tcp-4.0 | tcp-4.1 | tcp-4.2 |
> > > > +-------------+---------+---------+---------+---------+
> > > > > generic/053 | passed  | failure | failure | failure |
> > > > > generic/099 | passed  | failure | failure | failure |
> > > > > generic/105 | passed  | failure | failure | failure |
> > > > > generic/140 | skipped | skipped | skipped | failure |
> > > > > generic/188 | skipped | skipped | skipped | failure |
> > > > > generic/258 | failure | passed  | passed  | failure |
> > > > > generic/294 | failure | failure | failure | failure |
> > > > > generic/318 | passed  | failure | failure | failure |
> > > > > generic/319 | passed  | failure | failure | failure |
> > > > > generic/357 | skipped | skipped | skipped | failure |
> > > > > generic/444 | failure | failure | failure | failure |
> > > > > generic/465 | passed  | failure | failure | failure |
> > > > > generic/513 | skipped | skipped | skipped | failure |
> > > > > generic/529 | passed  | failure | failure | failure |
> > > > > generic/604 | passed  | passed  | failure | passed  |
> > > > > generic/675 | skipped | skipped | skipped | failure |
> > > > > generic/688 | skipped | skipped | skipped | failure |
> > > > > generic/697 | passed  | failure | failure | failure |
> > > > >    nfs/002 | failure | failure | failure | failure |
> > > > +-------------+---------+---------+---------+---------+
> > > >=20
> > > >=20
> > > > > > >=20
> > > > > > > With NFSv4.2, v6.4.0 has 2 extra failures that the current ma=
inline
> > > > > > > kernel doesn't:
> > > > > > >=20
> > > > > > >   generic/193 (some sort of setattr problem)
> > > > > > >   generic/528 (known problem with btime handling in client th=
at has been fixed)
> > > > > > >=20
> > > > > > > While I haven't investigated, I'm assuming the 193 bug is als=
o something
> > > > > > > that has been fixed in recent kernels. There are also 3 other=
 NFSv3
> > > > > > > tests that started passing since v6.4.0. I haven't looked int=
o those.
> > > > > > >=20
> > > > > > > With the linux-next kernel there are 2 new regressions:
> > > > > > >=20
> > > > > > >   generic/683
> > > > > > >   generic/684
> > > > > > >=20
> > > > > > > Both of these look like problems with setuid/setgid stripping=
, and still
> > > > > > > need to be investigated. I have more verbose result info on t=
he test
> > > > > > > failures if anyone is interested.
> > > >=20
> > > > Interesting that I'm not seeing the 683 & 684 failures. What type o=
f
> > > > filesystem is your server exporting?
> > > >=20
> > >=20
> > > btrfs
> > >=20
> > > You are testing linux-next? I need to go back and confirm these resul=
ts
> > > too.
> >=20
> > IMO linux-next is quite important : we keep hitting bugs that
> > appear only after integration -- block and network changes in
> > other trees especially can impact the NFS drivers.
> >=20
>=20
> Indeed, I suspect this is probably something from the vfs tree (though
> we definitely need to confirm that). Today I'm testing:
>=20
>     6.5.0-rc6-next-20230817-g47762f086974
>=20

Nope, I was wrong. I ran a bisect and it landed here. I confirmed it by
turning off leases on the nfs server and the test started passing. I
probably won't have the cycles to chase this down further.

The capture looks something like this:

OPEN (get a write delegation
WRITE
CLOSE
SETATTR (mode 06666)

...then presumably a task on the client opens the file again, but the
setuid bits don't get stripped.

I think either the client will need to strip these bits on a delegated
open, or we'll need to recall write delegations from the client when it
tries to do a SETATTR with a mode that could later end up needing to be
stripped on a subsequent open:

66ce3e3b98a7a9e970ea463a7f7dc0575c0a244b is the first bad commit
commit 66ce3e3b98a7a9e970ea463a7f7dc0575c0a244b
Author: Dai Ngo <dai.ngo@oracle.com>
Date:   Thu Jun 29 18:52:40 2023 -0700

    NFSD: Enable write delegation support

