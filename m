Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3863077FC18
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Aug 2023 18:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352797AbjHQQ2Q (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Aug 2023 12:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353793AbjHQQ2M (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Aug 2023 12:28:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D8D3599
        for <linux-nfs@vger.kernel.org>; Thu, 17 Aug 2023 09:28:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9501761690
        for <linux-nfs@vger.kernel.org>; Thu, 17 Aug 2023 16:28:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45951C433C7;
        Thu, 17 Aug 2023 16:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692289682;
        bh=L5KLMX1pcOzohI/TVCr3JixSGRBC7+4XoNDGD1eB5xs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Y3J+HFvjsmx6d1az6XzRbxI0ZoDNeDAlGiiouWFHnw2vqdeCKNSph8IP3Dw3x3h1y
         FV2oMphFV+k7C/GCUkcTrGLkUM79G9ZVrFgEzNokpF42EeqEL2iCKHTW3wlcRMasM4
         Ep7PGAnVt+nzvUrqZG8OS+IlDxLWniJXJb+vqWj5UrNWAej3P8B1NDZ+8Jlge9r+PF
         rE+5SHAaTRyoPhufc8Fi/zajHnwjVMH/U7Fw6S83OZauTjDn8FMhiDXYPvusumwKjy
         oVyZzP8MMxunjtyqHa4XjxtcE0Bq05mrNCwxY3pvTo5sMEDteoj6plOBWSW4xkUOPF
         Azi2hDunPusmw==
Message-ID: <77977950a7d6a4539114fdd0d6db982143c4f9b1.camel@kernel.org>
Subject: Re: xfstests results over NFS
From:   Jeff Layton <jlayton@kernel.org>
To:     Anna Schumaker <anna@kernel.org>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Trond Myklebust <trondmy@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>,
        "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Date:   Thu, 17 Aug 2023 12:27:59 -0400
In-Reply-To: <CAFX2Jf=gq-U464_SrebSwCMOU+g0Vcx9Us7SPn8JQEoA6s27DQ@mail.gmail.com>
References: <9ee56f62652c3d338aff809f70e7941dfc284bf9.camel@kernel.org>
         <7C595ADA-E841-44F7-918A-3A46A55D546B@oracle.com>
         <2fc1f9bf5fdc25acbcabaf4266584f0857bc4b19.camel@kernel.org>
         <CAFX2Jf=gq-U464_SrebSwCMOU+g0Vcx9Us7SPn8JQEoA6s27DQ@mail.gmail.com>
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

On Thu, 2023-08-17 at 11:17 -0400, Anna Schumaker wrote:
> On Thu, Aug 17, 2023 at 10:22=E2=80=AFAM Jeff Layton <jlayton@kernel.org>=
 wrote:
> >=20
> > On Thu, 2023-08-17 at 14:04 +0000, Chuck Lever III wrote:
> > >=20
> > > > On Aug 17, 2023, at 7:21 AM, Jeff Layton <jlayton@kernel.org> wrote=
:
> > > >=20
> > > > I finally got my kdevops (https://github.com/linux-kdevops/kdevops)=
 test
> > > > rig working well enough to get some publishable results. To run fst=
ests,
> > > > kdevops will spin up a server and (in this case) 2 clients to run
> > > > xfstests' auto group. One client mounts with default options, and t=
he
> > > > other uses NFSv3.
> > > >=20
> > > > I tested 3 kernels:
> > > >=20
> > > > v6.4.0 (stock release)
> > > > 6.5.0-rc6-g4853c74bd7ab (Linus' tree as of a couple of days ago)
> > > > 6.5.0-rc6-next-20230816-gef66bf8aeb91 (linux-next as of yesterday m=
orning)
> > > >=20
> > > > Here are the results summary of all 3:
> > > >=20
> > > > KERNEL:    6.4.0
> > > > CPUS:      8
> > > >=20
> > > > nfs_v3: 727 tests, 12 failures, 569 skipped, 14863 seconds
> > > >  Failures: generic/053 generic/099 generic/105 generic/124
> > > >    generic/193 generic/258 generic/294 generic/318 generic/319
> > > >    generic/444 generic/528 generic/529
> > > > nfs_default: 727 tests, 18 failures, 452 skipped, 21899 seconds
> > > >  Failures: generic/053 generic/099 generic/105 generic/186
> > > >    generic/187 generic/193 generic/294 generic/318 generic/319
> > > >    generic/357 generic/444 generic/486 generic/513 generic/528
> > > >    generic/529 generic/578 generic/675 generic/688
> > > > Totals: 1454 tests, 1021 skipped, 30 failures, 0 errors, 35096s
> > > >=20
> > > > KERNEL:    6.5.0-rc6-g4853c74bd7ab
> > > > CPUS:      8
> > > >=20
> > > > nfs_v3: 727 tests, 9 failures, 570 skipped, 14775 seconds
> > > >  Failures: generic/053 generic/099 generic/105 generic/258
> > > >    generic/294 generic/318 generic/319 generic/444 generic/529
> > > > nfs_default: 727 tests, 16 failures, 453 skipped, 22326 seconds
> > > >  Failures: generic/053 generic/099 generic/105 generic/186
> > > >    generic/187 generic/294 generic/318 generic/319 generic/357
> > > >    generic/444 generic/486 generic/513 generic/529 generic/578
> > > >    generic/675 generic/688
> > > > Totals: 1454 tests, 1023 skipped, 25 failures, 0 errors, 35396s
> > > >=20
> > > > KERNEL:    6.5.0-rc6-next-20230816-gef66bf8aeb91
> > > > CPUS:      8
> > > >=20
> > > > nfs_v3: 727 tests, 9 failures, 570 skipped, 14657 seconds
> > > >  Failures: generic/053 generic/099 generic/105 generic/258
> > > >    generic/294 generic/318 generic/319 generic/444 generic/529
> > > > nfs_default: 727 tests, 18 failures, 453 skipped, 21757 seconds
> > > >  Failures: generic/053 generic/099 generic/105 generic/186
> > > >    generic/187 generic/294 generic/318 generic/319 generic/357
> > > >    generic/444 generic/486 generic/513 generic/529 generic/578
> > > >    generic/675 generic/683 generic/684 generic/688
> > > > Totals: 1454 tests, 1023 skipped, 27 failures, 0 errors, 34870s
>=20
> As long as we're sharing results ... here is what I'm seeing with a
> 6.5-rc6 client & server:
>=20
> anna@gouda ~ % xfstestsdb xunit list --results --runid 1741 --color=3Dnon=
e
> +------+----------------------+---------+----------+------+------+------+=
-------+
> >  run | device               | xunit   | hostname | pass | fail |
> skip |  time |
> +------+----------------------+---------+----------+------+------+------+=
-------+
> > 1741 | server:/srv/xfs/test | tcp-3   | client   |  125 |    4 |
> 464 | 447 s |
> > 1741 | server:/srv/xfs/test | tcp-4.0 | client   |  117 |   11 |
> 465 | 478 s |
> > 1741 | server:/srv/xfs/test | tcp-4.1 | client   |  119 |   12 |
> 462 | 404 s |
> > 1741 | server:/srv/xfs/test | tcp-4.2 | client   |  212 |   18 |
> 363 | 564 s |
> +------+----------------------+---------+----------+------+------+------+=
-------+
>=20
> anna@gouda ~ % xfstestsdb show --failure 1741 --color=3Dnone
> +-------------+---------+---------+---------+---------+
> >    testcase | tcp-3   | tcp-4.0 | tcp-4.1 | tcp-4.2 |
> +-------------+---------+---------+---------+---------+
> > generic/053 | passed  | failure | failure | failure |
> > generic/099 | passed  | failure | failure | failure |
> > generic/105 | passed  | failure | failure | failure |
> > generic/140 | skipped | skipped | skipped | failure |
> > generic/188 | skipped | skipped | skipped | failure |
> > generic/258 | failure | passed  | passed  | failure |
> > generic/294 | failure | failure | failure | failure |
> > generic/318 | passed  | failure | failure | failure |
> > generic/319 | passed  | failure | failure | failure |
> > generic/357 | skipped | skipped | skipped | failure |
> > generic/444 | failure | failure | failure | failure |
> > generic/465 | passed  | failure | failure | failure |
> > generic/513 | skipped | skipped | skipped | failure |
> > generic/529 | passed  | failure | failure | failure |
> > generic/604 | passed  | passed  | failure | passed  |
> > generic/675 | skipped | skipped | skipped | failure |
> > generic/688 | skipped | skipped | skipped | failure |
> > generic/697 | passed  | failure | failure | failure |
> >     nfs/002 | failure | failure | failure | failure |
> +-------------+---------+---------+---------+---------+
>=20
>=20
> > > >=20
> > > > With NFSv4.2, v6.4.0 has 2 extra failures that the current mainline
> > > > kernel doesn't:
> > > >=20
> > > >    generic/193 (some sort of setattr problem)
> > > >    generic/528 (known problem with btime handling in client that ha=
s been fixed)
> > > >=20
> > > > While I haven't investigated, I'm assuming the 193 bug is also some=
thing
> > > > that has been fixed in recent kernels. There are also 3 other NFSv3
> > > > tests that started passing since v6.4.0. I haven't looked into thos=
e.
> > > >=20
> > > > With the linux-next kernel there are 2 new regressions:
> > > >=20
> > > >    generic/683
> > > >    generic/684
> > > >=20
> > > > Both of these look like problems with setuid/setgid stripping, and =
still
> > > > need to be investigated. I have more verbose result info on the tes=
t
> > > > failures if anyone is interested.
>=20
> Interesting that I'm not seeing the 683 & 684 failures. What type of
> filesystem is your server exporting?
>=20

btrfs

You are testing linux-next? I need to go back and confirm these results
too.

> > >=20
> > > 100% awesome sauce. Out of curiosity:
> > >=20
> > > Does kdevops have a way of publishing (via an autonomous web site)
> > > and archiving these results?
> > >=20
> >=20
> > There's nothing much prewritten for this. There is some support for
> > sending emails when you run a "ci" loop. I need to do more investigatio=
n
> > here.
>=20
> xfstests has an option to generate an xunit file, which can help here.
> I use with my own archiving tool to stick everything into a sqlite
> database (https://git.nowheycreamery.com/anna/xfstestsdb).
>=20

Yeah, kdevops uses the xunit file to generate its results, AFAIU. TBH, a
lot of the automation surrounding how to collate and evaluate test
results is still something I need to look at more closely. It's not well
documented and is still under pretty heavy development.

> >=20
> > Note that there has been some parallel effort toward CI in the SMB spac=
e
> > using buildbot. It may worthwhile to consider combining efforts somehow=
.
>=20
> It might be nice to at least see what they're doing. If they have
> something that works well, then setting up something similar might be
> a good idea.
>=20

Just my gut feel is that kdevops seems to be more geared toward
"maintainer wants to see a set of results vs. particular kernels",
whereas buildbot seems to be more geared toward automation, and CI type
workloads. There are some CI-ish automation bits in kdevops, but doesn't
seem to be as straightforward as what buildbot has.
--=20
Jeff Layton <jlayton@kernel.org>
