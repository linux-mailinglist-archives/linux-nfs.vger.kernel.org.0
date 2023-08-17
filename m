Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B0877FCD1
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Aug 2023 19:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239273AbjHQRPw (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Aug 2023 13:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353950AbjHQRPj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Aug 2023 13:15:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D1F11F
        for <linux-nfs@vger.kernel.org>; Thu, 17 Aug 2023 10:15:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A559660F30
        for <linux-nfs@vger.kernel.org>; Thu, 17 Aug 2023 17:15:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49654C433C7;
        Thu, 17 Aug 2023 17:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692292537;
        bh=47khGxcMC/zwP18nsyd/vdp3hKreRP6Yyio8H8IjEqE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=tf2ZY7C2/fShAU+JlOv/X52qaZ9v7kprWu5ei4p98hauN7bJKeXGOpA8WJI8PncKi
         HoMCzdM4ubUOfonsTH5osH1SDdqTzY+H8w+g1cyQ28+hu+FsrtTgw61Gnx1mAPxECp
         hnkT+fw8N2PCRjs8jQgvd7kXbOFsI/XwPftNVAFfxdglXreio9dTdIEsz2IH6+en38
         bNiUTqJNbLtpSgPIRvQAQY+pgsWZmCsz6UxUJgRDcMX6mw/gV4g3fLxb/AuY/X4ZfD
         TuLLargNAAaHKjUabVJgkBikveozC2i610xYRZhCHqZWit2fV4CO6lHBgVJ8Y/04Cn
         TuTFrUr4hWCeg==
Message-ID: <6af7807c75e3d6110bc80661a600038f5cfb0022.camel@kernel.org>
Subject: Re: xfstests results over NFS
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>,
        "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Date:   Thu, 17 Aug 2023 13:15:35 -0400
In-Reply-To: <0AEF7E06-E2F6-426D-B3DF-3D0ED8233082@oracle.com>
References: <9ee56f62652c3d338aff809f70e7941dfc284bf9.camel@kernel.org>
         <7C595ADA-E841-44F7-918A-3A46A55D546B@oracle.com>
         <2fc1f9bf5fdc25acbcabaf4266584f0857bc4b19.camel@kernel.org>
         <CAFX2Jf=gq-U464_SrebSwCMOU+g0Vcx9Us7SPn8JQEoA6s27DQ@mail.gmail.com>
         <77977950a7d6a4539114fdd0d6db982143c4f9b1.camel@kernel.org>
         <0AEF7E06-E2F6-426D-B3DF-3D0ED8233082@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2023-08-17 at 16:31 +0000, Chuck Lever III wrote:
>=20
> > On Aug 17, 2023, at 12:27 PM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > On Thu, 2023-08-17 at 11:17 -0400, Anna Schumaker wrote:
> > > On Thu, Aug 17, 2023 at 10:22=E2=80=AFAM Jeff Layton <jlayton@kernel.=
org> wrote:
> > > >=20
> > > > On Thu, 2023-08-17 at 14:04 +0000, Chuck Lever III wrote:
> > > > >=20
> > > > > > On Aug 17, 2023, at 7:21 AM, Jeff Layton <jlayton@kernel.org> w=
rote:
> > > > > >=20
> > > > > > I finally got my kdevops (https://github.com/linux-kdevops/kdev=
ops) test
> > > > > > rig working well enough to get some publishable results. To run=
 fstests,
> > > > > > kdevops will spin up a server and (in this case) 2 clients to r=
un
> > > > > > xfstests' auto group. One client mounts with default options, a=
nd the
> > > > > > other uses NFSv3.
> > > > > >=20
> > > > > > I tested 3 kernels:
> > > > > >=20
> > > > > > v6.4.0 (stock release)
> > > > > > 6.5.0-rc6-g4853c74bd7ab (Linus' tree as of a couple of days ago=
)
> > > > > > 6.5.0-rc6-next-20230816-gef66bf8aeb91 (linux-next as of yesterd=
ay morning)
> > > > > >=20
> > > > > > Here are the results summary of all 3:
> > > > > >=20
> > > > > > KERNEL:    6.4.0
> > > > > > CPUS:      8
> > > > > >=20
> > > > > > nfs_v3: 727 tests, 12 failures, 569 skipped, 14863 seconds
> > > > > > Failures: generic/053 generic/099 generic/105 generic/124
> > > > > >   generic/193 generic/258 generic/294 generic/318 generic/319
> > > > > >   generic/444 generic/528 generic/529
> > > > > > nfs_default: 727 tests, 18 failures, 452 skipped, 21899 seconds
> > > > > > Failures: generic/053 generic/099 generic/105 generic/186
> > > > > >   generic/187 generic/193 generic/294 generic/318 generic/319
> > > > > >   generic/357 generic/444 generic/486 generic/513 generic/528
> > > > > >   generic/529 generic/578 generic/675 generic/688
> > > > > > Totals: 1454 tests, 1021 skipped, 30 failures, 0 errors, 35096s
> > > > > >=20
> > > > > > KERNEL:    6.5.0-rc6-g4853c74bd7ab
> > > > > > CPUS:      8
> > > > > >=20
> > > > > > nfs_v3: 727 tests, 9 failures, 570 skipped, 14775 seconds
> > > > > > Failures: generic/053 generic/099 generic/105 generic/258
> > > > > >   generic/294 generic/318 generic/319 generic/444 generic/529
> > > > > > nfs_default: 727 tests, 16 failures, 453 skipped, 22326 seconds
> > > > > > Failures: generic/053 generic/099 generic/105 generic/186
> > > > > >   generic/187 generic/294 generic/318 generic/319 generic/357
> > > > > >   generic/444 generic/486 generic/513 generic/529 generic/578
> > > > > >   generic/675 generic/688
> > > > > > Totals: 1454 tests, 1023 skipped, 25 failures, 0 errors, 35396s
> > > > > >=20
> > > > > > KERNEL:    6.5.0-rc6-next-20230816-gef66bf8aeb91
> > > > > > CPUS:      8
> > > > > >=20
> > > > > > nfs_v3: 727 tests, 9 failures, 570 skipped, 14657 seconds
> > > > > > Failures: generic/053 generic/099 generic/105 generic/258
> > > > > >   generic/294 generic/318 generic/319 generic/444 generic/529
> > > > > > nfs_default: 727 tests, 18 failures, 453 skipped, 21757 seconds
> > > > > > Failures: generic/053 generic/099 generic/105 generic/186
> > > > > >   generic/187 generic/294 generic/318 generic/319 generic/357
> > > > > >   generic/444 generic/486 generic/513 generic/529 generic/578
> > > > > >   generic/675 generic/683 generic/684 generic/688
> > > > > > Totals: 1454 tests, 1023 skipped, 27 failures, 0 errors, 34870s
> > >=20
> > > As long as we're sharing results ... here is what I'm seeing with a
> > > 6.5-rc6 client & server:
> > >=20
> > > anna@gouda ~ % xfstestsdb xunit list --results --runid 1741 --color=
=3Dnone
> > > +------+----------------------+---------+----------+------+------+---=
---+-------+
> > > > run | device               | xunit   | hostname | pass | fail |
> > > skip |  time |
> > > +------+----------------------+---------+----------+------+------+---=
---+-------+
> > > > 1741 | server:/srv/xfs/test | tcp-3   | client   |  125 |    4 |
> > > 464 | 447 s |
> > > > 1741 | server:/srv/xfs/test | tcp-4.0 | client   |  117 |   11 |
> > > 465 | 478 s |
> > > > 1741 | server:/srv/xfs/test | tcp-4.1 | client   |  119 |   12 |
> > > 462 | 404 s |
> > > > 1741 | server:/srv/xfs/test | tcp-4.2 | client   |  212 |   18 |
> > > 363 | 564 s |
> > > +------+----------------------+---------+----------+------+------+---=
---+-------+
> > >=20
> > > anna@gouda ~ % xfstestsdb show --failure 1741 --color=3Dnone
> > > +-------------+---------+---------+---------+---------+
> > > >   testcase | tcp-3   | tcp-4.0 | tcp-4.1 | tcp-4.2 |
> > > +-------------+---------+---------+---------+---------+
> > > > generic/053 | passed  | failure | failure | failure |
> > > > generic/099 | passed  | failure | failure | failure |
> > > > generic/105 | passed  | failure | failure | failure |
> > > > generic/140 | skipped | skipped | skipped | failure |
> > > > generic/188 | skipped | skipped | skipped | failure |
> > > > generic/258 | failure | passed  | passed  | failure |
> > > > generic/294 | failure | failure | failure | failure |
> > > > generic/318 | passed  | failure | failure | failure |
> > > > generic/319 | passed  | failure | failure | failure |
> > > > generic/357 | skipped | skipped | skipped | failure |
> > > > generic/444 | failure | failure | failure | failure |
> > > > generic/465 | passed  | failure | failure | failure |
> > > > generic/513 | skipped | skipped | skipped | failure |
> > > > generic/529 | passed  | failure | failure | failure |
> > > > generic/604 | passed  | passed  | failure | passed  |
> > > > generic/675 | skipped | skipped | skipped | failure |
> > > > generic/688 | skipped | skipped | skipped | failure |
> > > > generic/697 | passed  | failure | failure | failure |
> > > >    nfs/002 | failure | failure | failure | failure |
> > > +-------------+---------+---------+---------+---------+
> > >=20
> > >=20
> > > > > >=20
> > > > > > With NFSv4.2, v6.4.0 has 2 extra failures that the current main=
line
> > > > > > kernel doesn't:
> > > > > >=20
> > > > > >   generic/193 (some sort of setattr problem)
> > > > > >   generic/528 (known problem with btime handling in client that=
 has been fixed)
> > > > > >=20
> > > > > > While I haven't investigated, I'm assuming the 193 bug is also =
something
> > > > > > that has been fixed in recent kernels. There are also 3 other N=
FSv3
> > > > > > tests that started passing since v6.4.0. I haven't looked into =
those.
> > > > > >=20
> > > > > > With the linux-next kernel there are 2 new regressions:
> > > > > >=20
> > > > > >   generic/683
> > > > > >   generic/684
> > > > > >=20
> > > > > > Both of these look like problems with setuid/setgid stripping, =
and still
> > > > > > need to be investigated. I have more verbose result info on the=
 test
> > > > > > failures if anyone is interested.
> > >=20
> > > Interesting that I'm not seeing the 683 & 684 failures. What type of
> > > filesystem is your server exporting?
> > >=20
> >=20
> > btrfs
> >=20
> > You are testing linux-next? I need to go back and confirm these results
> > too.
>=20
> IMO linux-next is quite important : we keep hitting bugs that
> appear only after integration -- block and network changes in
> other trees especially can impact the NFS drivers.
>=20

Indeed, I suspect this is probably something from the vfs tree (though
we definitely need to confirm that). Today I'm testing:

    6.5.0-rc6-next-20230817-g47762f086974

[vagrant@kdevops-nfs-default xfstests]$ sudo ./check generic/683
generic/684
SECTION       -- default
FSTYP         -- nfs
PLATFORM      -- Linux/x86_64 kdevops-nfs-default 6.5.0-rc6-next-20230817-g=
47762f086974 #37 SMP PREEMPT_DYNAMIC Thu Aug 17 10:17:27 EDT 2023
MKFS_OPTIONS  -- kdevops-nfsd:/export/1/fstests/kdevops-nfs-default
MOUNT_OPTIONS -- kdevops-nfsd:/export/1/fstests/kdevops-nfs-default /media/=
scratch

generic/683       - output mismatch (see /data/fstests-install/xfstests/res=
ults/kdevops-nfs-default/6.5.0-rc6-next-20230817-g47762f086974/default/gene=
ric/683.out.bad)
    --- tests/generic/683.out   2023-08-17 15:50:52.428385413 +0000
    +++ /data/fstests-install/xfstests/results/kdevops-nfs-default/6.5.0-rc=
6-next-20230817-g47762f086974/default/generic/683.out.bad    2023-08-17 17:=
10:05.017250750 +0000
    @@ -1,19 +1,19 @@
     QA output created by 683
     Test 1 - qa_user, non-exec file falloc
     6666 -rwSrwSrw- TEST_DIR/683/a
    -666 -rw-rw-rw- TEST_DIR/683/a
    +6666 -rwSrwSrw- TEST_DIR/683/a
    =20
     Test 2 - qa_user, group-exec file falloc
    ...
    (Run 'diff -u /data/fstests-install/xfstests/tests/generic/683.out /dat=
a/fstests-install/xfstests/results/kdevops-nfs-default/6.5.0-rc6-next-20230=
817-g47762f086974/default/generic/683.out.bad'  to see the entire diff)
generic/684       - output mismatch (see /data/fstests-install/xfstests/res=
ults/kdevops-nfs-default/6.5.0-rc6-next-20230817-g47762f086974/default/gene=
ric/684.out.bad)
    --- tests/generic/684.out   2023-08-17 15:50:52.456385413 +0000
    +++ /data/fstests-install/xfstests/results/kdevops-nfs-default/6.5.0-rc=
6-next-20230817-g47762f086974/default/generic/684.out.bad    2023-08-17 17:=
10:11.409250750 +0000
    @@ -1,19 +1,19 @@
     QA output created by 684
     Test 1 - qa_user, non-exec file fpunch
     6666 -rwSrwSrw- TEST_DIR/684/a
    -666 -rw-rw-rw- TEST_DIR/684/a
    +6666 -rwSrwSrw- TEST_DIR/684/a
    =20
     Test 2 - qa_user, group-exec file fpunch
    ...
    (Run 'diff -u /data/fstests-install/xfstests/tests/generic/684.out /dat=
a/fstests-install/xfstests/results/kdevops-nfs-default/6.5.0-rc6-next-20230=
817-g47762f086974/default/generic/684.out.bad'  to see the entire diff)
Ran: generic/683 generic/684
Failures: generic/683 generic/684
Failed 2 of 2 tests

SECTION       -- default
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Ran: generic/683 generic/684
Failures: generic/683 generic/684
Failed 2 of 2 tests

