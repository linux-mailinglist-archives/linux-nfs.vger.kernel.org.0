Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB00078017C
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Aug 2023 01:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347571AbjHQXIh (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Aug 2023 19:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237276AbjHQXIM (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Aug 2023 19:08:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7402112
        for <linux-nfs@vger.kernel.org>; Thu, 17 Aug 2023 16:08:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 948D1632B3
        for <linux-nfs@vger.kernel.org>; Thu, 17 Aug 2023 23:08:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9D0C433C7;
        Thu, 17 Aug 2023 23:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692313689;
        bh=/fOZg2yg8LK2Fg8dJ8dB0j4U9co+J3gvEcf98tKQdgk=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=eZTg6ygAzsOkhNbXc4P0KOnvL6g66cq/BJQjAVF114RceSuaO/SMt6ajLClf5tmuJ
         frIUXoLLV/bTe95dgBrBcNYmft8/JWVimHy+cW5fvjvPzcf/mFXeyTkKELKaXigVr9
         3/9W8xM8eSfr6fOlOyltPEny2M3LrGsK1QqXAbaXB0Izy+47tOr5JFonZdhd1kcLON
         V2UGQOIaiM9DXZuUDC8FTuIfrpV8ryw3pphUShLopgq4AK6vH4fUXoOF5tXgPQFxFV
         p9P7hQdbp296GpcrfEi8ZKk+oyWJ58XAhHgVDTDrxTT5u0F901kXzwWHQTJbOcF/FZ
         chiu6U67rv88g==
Message-ID: <cd592a05c13226c5e1fb4f390eb2473ba20024ad.camel@kernel.org>
Subject: Re: xfstests results over NFS
From:   Jeff Layton <jlayton@kernel.org>
To:     dai.ngo@oracle.com, Chuck Lever III <chuck.lever@oracle.com>
Cc:     Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>,
        "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>,
        Tom Talpey <tom@talpey.com>
Date:   Thu, 17 Aug 2023 19:08:06 -0400
In-Reply-To: <b535fccd-acd2-8fca-71ac-6aa17ee84708@oracle.com>
References: <9ee56f62652c3d338aff809f70e7941dfc284bf9.camel@kernel.org>
         <7C595ADA-E841-44F7-918A-3A46A55D546B@oracle.com>
         <2fc1f9bf5fdc25acbcabaf4266584f0857bc4b19.camel@kernel.org>
         <CAFX2Jf=gq-U464_SrebSwCMOU+g0Vcx9Us7SPn8JQEoA6s27DQ@mail.gmail.com>
         <77977950a7d6a4539114fdd0d6db982143c4f9b1.camel@kernel.org>
         <0AEF7E06-E2F6-426D-B3DF-3D0ED8233082@oracle.com>
         <6af7807c75e3d6110bc80661a600038f5cfb0022.camel@kernel.org>
         <7b2746692aef1725cb000faabf4db2d115279423.camel@kernel.org>
         <25bc018a-00a7-1634-9535-9d01328264d3@oracle.com>
         <b535fccd-acd2-8fca-71ac-6aa17ee84708@oracle.com>
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

On Thu, 2023-08-17 at 15:59 -0700, dai.ngo@oracle.com wrote:
> On 8/17/23 3:23 PM, dai.ngo@oracle.com wrote:
> >=20
> > On 8/17/23 2:07 PM, Jeff Layton wrote:
> > > On Thu, 2023-08-17 at 13:15 -0400, Jeff Layton wrote:
> > > > On Thu, 2023-08-17 at 16:31 +0000, Chuck Lever III wrote:
> > > > > > On Aug 17, 2023, at 12:27 PM, Jeff Layton <jlayton@kernel.org> =
wrote:
> > > > > >=20
> > > > > > On Thu, 2023-08-17 at 11:17 -0400, Anna Schumaker wrote:
> > > > > > > On Thu, Aug 17, 2023 at 10:22=E2=80=AFAM Jeff Layton <jlayton=
@kernel.org>=20
> > > > > > > wrote:
> > > > > > > > On Thu, 2023-08-17 at 14:04 +0000, Chuck Lever III wrote:
> > > > > > > > > > On Aug 17, 2023, at 7:21 AM, Jeff Layton <jlayton@kerne=
l.org>=20
> > > > > > > > > > wrote:
> > > > > > > > > >=20
> > > > > > > > > > I finally got my kdevops=20
> > > > > > > > > > (https://github.com/linux-kdevops/kdevops) test
> > > > > > > > > > rig working well enough to get some publishable results=
. To=20
> > > > > > > > > > run fstests,
> > > > > > > > > > kdevops will spin up a server and (in this case) 2 clie=
nts to run
> > > > > > > > > > xfstests' auto group. One client mounts with default op=
tions,=20
> > > > > > > > > > and the
> > > > > > > > > > other uses NFSv3.
> > > > > > > > > >=20
> > > > > > > > > > I tested 3 kernels:
> > > > > > > > > >=20
> > > > > > > > > > v6.4.0 (stock release)
> > > > > > > > > > 6.5.0-rc6-g4853c74bd7ab (Linus' tree as of a couple of =
days ago)
> > > > > > > > > > 6.5.0-rc6-next-20230816-gef66bf8aeb91 (linux-next as of=
=20
> > > > > > > > > > yesterday morning)
> > > > > > > > > >=20
> > > > > > > > > > Here are the results summary of all 3:
> > > > > > > > > >=20
> > > > > > > > > > KERNEL:=C2=A0=C2=A0=C2=A0 6.4.0
> > > > > > > > > > CPUS:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8
> > > > > > > > > >=20
> > > > > > > > > > nfs_v3: 727 tests, 12 failures, 569 skipped, 14863 seco=
nds
> > > > > > > > > > Failures: generic/053 generic/099 generic/105 generic/1=
24
> > > > > > > > > > =C2=A0=C2=A0 generic/193 generic/258 generic/294 generi=
c/318 generic/319
> > > > > > > > > > =C2=A0=C2=A0 generic/444 generic/528 generic/529
> > > > > > > > > > nfs_default: 727 tests, 18 failures, 452 skipped, 21899=
 seconds
> > > > > > > > > > Failures: generic/053 generic/099 generic/105 generic/1=
86
> > > > > > > > > > =C2=A0=C2=A0 generic/187 generic/193 generic/294 generi=
c/318 generic/319
> > > > > > > > > > =C2=A0=C2=A0 generic/357 generic/444 generic/486 generi=
c/513 generic/528
> > > > > > > > > > =C2=A0=C2=A0 generic/529 generic/578 generic/675 generi=
c/688
> > > > > > > > > > Totals: 1454 tests, 1021 skipped, 30 failures, 0 errors=
, 35096s
> > > > > > > > > >=20
> > > > > > > > > > KERNEL:=C2=A0=C2=A0=C2=A0 6.5.0-rc6-g4853c74bd7ab
> > > > > > > > > > CPUS:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8
> > > > > > > > > >=20
> > > > > > > > > > nfs_v3: 727 tests, 9 failures, 570 skipped, 14775 secon=
ds
> > > > > > > > > > Failures: generic/053 generic/099 generic/105 generic/2=
58
> > > > > > > > > > =C2=A0=C2=A0 generic/294 generic/318 generic/319 generi=
c/444 generic/529
> > > > > > > > > > nfs_default: 727 tests, 16 failures, 453 skipped, 22326=
 seconds
> > > > > > > > > > Failures: generic/053 generic/099 generic/105 generic/1=
86
> > > > > > > > > > =C2=A0=C2=A0 generic/187 generic/294 generic/318 generi=
c/319 generic/357
> > > > > > > > > > =C2=A0=C2=A0 generic/444 generic/486 generic/513 generi=
c/529 generic/578
> > > > > > > > > > =C2=A0=C2=A0 generic/675 generic/688
> > > > > > > > > > Totals: 1454 tests, 1023 skipped, 25 failures, 0 errors=
, 35396s
> > > > > > > > > >=20
> > > > > > > > > > KERNEL:=C2=A0=C2=A0=C2=A0 6.5.0-rc6-next-20230816-gef66=
bf8aeb91
> > > > > > > > > > CPUS:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8
> > > > > > > > > >=20
> > > > > > > > > > nfs_v3: 727 tests, 9 failures, 570 skipped, 14657 secon=
ds
> > > > > > > > > > Failures: generic/053 generic/099 generic/105 generic/2=
58
> > > > > > > > > > =C2=A0=C2=A0 generic/294 generic/318 generic/319 generi=
c/444 generic/529
> > > > > > > > > > nfs_default: 727 tests, 18 failures, 453 skipped, 21757=
 seconds
> > > > > > > > > > Failures: generic/053 generic/099 generic/105 generic/1=
86
> > > > > > > > > > =C2=A0=C2=A0 generic/187 generic/294 generic/318 generi=
c/319 generic/357
> > > > > > > > > > =C2=A0=C2=A0 generic/444 generic/486 generic/513 generi=
c/529 generic/578
> > > > > > > > > > =C2=A0=C2=A0 generic/675 generic/683 generic/684 generi=
c/688
> > > > > > > > > > Totals: 1454 tests, 1023 skipped, 27 failures, 0 errors=
, 34870s
> > > > > > > As long as we're sharing results ... here is what I'm seeing =
with a
> > > > > > > 6.5-rc6 client & server:
> > > > > > >=20
> > > > > > > anna@gouda ~ % xfstestsdb xunit list --results --runid 1741=
=20
> > > > > > > --color=3Dnone
> > > > > > > +------+----------------------+---------+----------+------+--=
----+------+-------+=20
> > > > > > >=20
> > > > > > > > run | device=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | xunit=C2=A0=C2=A0 | hostname | pa=
ss | fail |
> > > > > > > skip |=C2=A0 time |
> > > > > > > +------+----------------------+---------+----------+------+--=
----+------+-------+=20
> > > > > > >=20
> > > > > > > > 1741 | server:/srv/xfs/test | tcp-3=C2=A0=C2=A0 | client=C2=
=A0=C2=A0 |=C2=A0 125 |=C2=A0=C2=A0=C2=A0 4 |
> > > > > > > 464 | 447 s |
> > > > > > > > 1741 | server:/srv/xfs/test | tcp-4.0 | client=C2=A0=C2=A0 =
|=C2=A0 117 |=C2=A0=C2=A0 11 |
> > > > > > > 465 | 478 s |
> > > > > > > > 1741 | server:/srv/xfs/test | tcp-4.1 | client=C2=A0=C2=A0 =
|=C2=A0 119 |=C2=A0=C2=A0 12 |
> > > > > > > 462 | 404 s |
> > > > > > > > 1741 | server:/srv/xfs/test | tcp-4.2 | client=C2=A0=C2=A0 =
|=C2=A0 212 |=C2=A0=C2=A0 18 |
> > > > > > > 363 | 564 s |
> > > > > > > +------+----------------------+---------+----------+------+--=
----+------+-------+=20
> > > > > > >=20
> > > > > > >=20
> > > > > > > anna@gouda ~ % xfstestsdb show --failure 1741 --color=3Dnone
> > > > > > > +-------------+---------+---------+---------+---------+
> > > > > > > > =C2=A0=C2=A0 testcase | tcp-3=C2=A0=C2=A0 | tcp-4.0 | tcp-4=
.1 | tcp-4.2 |
> > > > > > > +-------------+---------+---------+---------+---------+
> > > > > > > > generic/053 | passed=C2=A0 | failure | failure | failure |
> > > > > > > > generic/099 | passed=C2=A0 | failure | failure | failure |
> > > > > > > > generic/105 | passed=C2=A0 | failure | failure | failure |
> > > > > > > > generic/140 | skipped | skipped | skipped | failure |
> > > > > > > > generic/188 | skipped | skipped | skipped | failure |
> > > > > > > > generic/258 | failure | passed=C2=A0 | passed=C2=A0 | failu=
re |
> > > > > > > > generic/294 | failure | failure | failure | failure |
> > > > > > > > generic/318 | passed=C2=A0 | failure | failure | failure |
> > > > > > > > generic/319 | passed=C2=A0 | failure | failure | failure |
> > > > > > > > generic/357 | skipped | skipped | skipped | failure |
> > > > > > > > generic/444 | failure | failure | failure | failure |
> > > > > > > > generic/465 | passed=C2=A0 | failure | failure | failure |
> > > > > > > > generic/513 | skipped | skipped | skipped | failure |
> > > > > > > > generic/529 | passed=C2=A0 | failure | failure | failure |
> > > > > > > > generic/604 | passed=C2=A0 | passed=C2=A0 | failure | passe=
d=C2=A0 |
> > > > > > > > generic/675 | skipped | skipped | skipped | failure |
> > > > > > > > generic/688 | skipped | skipped | skipped | failure |
> > > > > > > > generic/697 | passed=C2=A0 | failure | failure | failure |
> > > > > > > > =C2=A0=C2=A0=C2=A0 nfs/002 | failure | failure | failure | =
failure |
> > > > > > > +-------------+---------+---------+---------+---------+
> > > > > > >=20
> > > > > > >=20
> > > > > > > > > > With NFSv4.2, v6.4.0 has 2 extra failures that the curr=
ent=20
> > > > > > > > > > mainline
> > > > > > > > > > kernel doesn't:
> > > > > > > > > >=20
> > > > > > > > > > =C2=A0=C2=A0 generic/193 (some sort of setattr problem)
> > > > > > > > > > =C2=A0=C2=A0 generic/528 (known problem with btime hand=
ling in client=20
> > > > > > > > > > that has been fixed)
> > > > > > > > > >=20
> > > > > > > > > > While I haven't investigated, I'm assuming the 193 bug =
is also=20
> > > > > > > > > > something
> > > > > > > > > > that has been fixed in recent kernels. There are also 3=
 other=20
> > > > > > > > > > NFSv3
> > > > > > > > > > tests that started passing since v6.4.0. I haven't look=
ed into=20
> > > > > > > > > > those.
> > > > > > > > > >=20
> > > > > > > > > > With the linux-next kernel there are 2 new regressions:
> > > > > > > > > >=20
> > > > > > > > > > =C2=A0=C2=A0 generic/683
> > > > > > > > > > =C2=A0=C2=A0 generic/684
> > > > > > > > > >=20
> > > > > > > > > > Both of these look like problems with setuid/setgid str=
ipping,=20
> > > > > > > > > > and still
> > > > > > > > > > need to be investigated. I have more verbose result inf=
o on=20
> > > > > > > > > > the test
> > > > > > > > > > failures if anyone is interested.
> > > > > > > Interesting that I'm not seeing the 683 & 684 failures. What =
type of
> > > > > > > filesystem is your server exporting?
> > > > > > >=20
> > > > > > btrfs
> > > > > >=20
> > > > > > You are testing linux-next? I need to go back and confirm these=
=20
> > > > > > results
> > > > > > too.
> > > > > IMO linux-next is quite important : we keep hitting bugs that
> > > > > appear only after integration -- block and network changes in
> > > > > other trees especially can impact the NFS drivers.
> > > > >=20
> > > > Indeed, I suspect this is probably something from the vfs tree (tho=
ugh
> > > > we definitely need to confirm that). Today I'm testing:
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0 6.5.0-rc6-next-20230817-g47762f086974
> > > >=20
> > > Nope, I was wrong. I ran a bisect and it landed here. I confirmed it =
by
> > > turning off leases on the nfs server and the test started passing. I
> > > probably won't have the cycles to chase this down further.
> > >=20
> > > The capture looks something like this:
> > >=20
> > > OPEN (get a write delegation
> > > WRITE
> > > CLOSE
> > > SETATTR (mode 06666)
> > >=20
> > > ...then presumably a task on the client opens the file again, but the
> > > setuid bits don't get stripped.
> > >=20
> > > I think either the client will need to strip these bits on a delegate=
d
> > > open, or we'll need to recall write delegations from the client when =
it
> > > tries to do a SETATTR with a mode that could later end up needing to =
be
> > > stripped on a subsequent open:
> > >=20
> > > 66ce3e3b98a7a9e970ea463a7f7dc0575c0a244b is the first bad commit
> > > commit 66ce3e3b98a7a9e970ea463a7f7dc0575c0a244b
> > > Author: Dai Ngo <dai.ngo@oracle.com>
> > > Date:=C2=A0=C2=A0 Thu Jun 29 18:52:40 2023 -0700
> > >=20
> > > =C2=A0=C2=A0=C2=A0=C2=A0 NFSD: Enable write delegation support
> >=20
> > The SETATTR should cause the delegation to be recalled. However, I thin=
k
> > there is an optimization on server that skips the recall if the SETATTR
> > comes from the same client that has the delegation.
>=20
> The optimization on the server was done by this commit:
>=20
> 28df3d1539de nfsd: clients don't need to break their own delegations
>=20
> Perhaps we should allow this optimization for read delegation only?
>=20
> Or should the NFS client be responsible for handling the SETATTR and
> and local OPEN on the file that has write delegation granted?
>

I think that setuid/setgid files are really a special case.

We already avoid giving out delegations on setuid/gid files. What we're
not doing currently is revoking the write delegation if the holder tries
to set a mode that involves a setuid/gid bit. If we add that, then that
should close the hole, I think.

--=20
Jeff Layton <jlayton@kernel.org>
