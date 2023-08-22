Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0BC784822
	for <lists+linux-nfs@lfdr.de>; Tue, 22 Aug 2023 19:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237969AbjHVRCO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 22 Aug 2023 13:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232822AbjHVRCO (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 22 Aug 2023 13:02:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20952D7
        for <linux-nfs@vger.kernel.org>; Tue, 22 Aug 2023 10:02:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9BB7F6381D
        for <linux-nfs@vger.kernel.org>; Tue, 22 Aug 2023 17:02:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46EEDC433C7;
        Tue, 22 Aug 2023 17:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692723731;
        bh=JAQdNJn3xmqNKCWIRDgxAfQrUNuRm6nCY9cfiyfMn7A=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Lm19f44Ik7yOFWRJ0W0T/ajky08DaHA0Y7j5MiYxnAPbZwmmpLoXiREGGwLg9I9I+
         1l7Gk4uJwITiqclRAjXv+2/O6DSn2gsYaEfa58tJpD196yEPC1pqUcdXue0GLAIRgd
         SmZHiBM0okIa5/TUdZVWWOR/nRvMA8AfkziJQLtBHy7XBPl5o+yXOnwHsFh0BFWevk
         N2Xh1glGPc2ulE8kUV/L7brPHPo5DG+CYnsjK9M6moX5djW8/6TAzfx7VpT6ARbizV
         r4Is+16ByRVvUCDFEYWJWtbcrqqNmDFW9OC84x3Bl3MC4hw6ui2wUpNaMnOT6oPW1Y
         UIM48Xp0/veJA==
Message-ID: <b4b86f10702503b0d056014e77e6d77827f309d1.camel@kernel.org>
Subject: Re: xfstests results over NFS
From:   Jeff Layton <jlayton@kernel.org>
To:     dai.ngo@oracle.com, Chuck Lever III <chuck.lever@oracle.com>
Cc:     Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>,
        "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>,
        Tom Talpey <tom@talpey.com>
Date:   Tue, 22 Aug 2023 13:02:09 -0400
In-Reply-To: <9d1ffe71-83b2-a9c7-861f-0d3f8d715e70@oracle.com>
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
         <cd592a05c13226c5e1fb4f390eb2473ba20024ad.camel@kernel.org>
         <9d1ffe71-83b2-a9c7-861f-0d3f8d715e70@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, 2023-08-22 at 09:07 -0700, dai.ngo@oracle.com wrote:
> On 8/17/23 4:08 PM, Jeff Layton wrote:
> > On Thu, 2023-08-17 at 15:59 -0700, dai.ngo@oracle.com wrote:
> > > On 8/17/23 3:23 PM, dai.ngo@oracle.com wrote:
> > > > On 8/17/23 2:07 PM, Jeff Layton wrote:
> > > > > On Thu, 2023-08-17 at 13:15 -0400, Jeff Layton wrote:
> > > > > > On Thu, 2023-08-17 at 16:31 +0000, Chuck Lever III wrote:
> > > > > > > > On Aug 17, 2023, at 12:27 PM, Jeff Layton <jlayton@kernel.o=
rg> wrote:
> > > > > > > >=20
> > > > > > > > On Thu, 2023-08-17 at 11:17 -0400, Anna Schumaker wrote:
> > > > > > > > > On Thu, Aug 17, 2023 at 10:22=E2=80=AFAM Jeff Layton <jla=
yton@kernel.org>
> > > > > > > > > wrote:
> > > > > > > > > > On Thu, 2023-08-17 at 14:04 +0000, Chuck Lever III wrot=
e:
> > > > > > > > > > > > On Aug 17, 2023, at 7:21 AM, Jeff Layton <jlayton@k=
ernel.org>
> > > > > > > > > > > > wrote:
> > > > > > > > > > > >=20
> > > > > > > > > > > > I finally got my kdevops
> > > > > > > > > > > > (https://github.com/linux-kdevops/kdevops) test
> > > > > > > > > > > > rig working well enough to get some publishable res=
ults. To
> > > > > > > > > > > > run fstests,
> > > > > > > > > > > > kdevops will spin up a server and (in this case) 2 =
clients to run
> > > > > > > > > > > > xfstests' auto group. One client mounts with defaul=
t options,
> > > > > > > > > > > > and the
> > > > > > > > > > > > other uses NFSv3.
> > > > > > > > > > > >=20
> > > > > > > > > > > > I tested 3 kernels:
> > > > > > > > > > > >=20
> > > > > > > > > > > > v6.4.0 (stock release)
> > > > > > > > > > > > 6.5.0-rc6-g4853c74bd7ab (Linus' tree as of a couple=
 of days ago)
> > > > > > > > > > > > 6.5.0-rc6-next-20230816-gef66bf8aeb91 (linux-next a=
s of
> > > > > > > > > > > > yesterday morning)
> > > > > > > > > > > >=20
> > > > > > > > > > > > Here are the results summary of all 3:
> > > > > > > > > > > >=20
> > > > > > > > > > > > KERNEL:=C2=A0=C2=A0=C2=A0 6.4.0
> > > > > > > > > > > > CPUS:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8
> > > > > > > > > > > >=20
> > > > > > > > > > > > nfs_v3: 727 tests, 12 failures, 569 skipped, 14863 =
seconds
> > > > > > > > > > > > Failures: generic/053 generic/099 generic/105 gener=
ic/124
> > > > > > > > > > > >  =C2=A0=C2=A0 generic/193 generic/258 generic/294 g=
eneric/318 generic/319
> > > > > > > > > > > >  =C2=A0=C2=A0 generic/444 generic/528 generic/529
> > > > > > > > > > > > nfs_default: 727 tests, 18 failures, 452 skipped, 2=
1899 seconds
> > > > > > > > > > > > Failures: generic/053 generic/099 generic/105 gener=
ic/186
> > > > > > > > > > > >  =C2=A0=C2=A0 generic/187 generic/193 generic/294 g=
eneric/318 generic/319
> > > > > > > > > > > >  =C2=A0=C2=A0 generic/357 generic/444 generic/486 g=
eneric/513 generic/528
> > > > > > > > > > > >  =C2=A0=C2=A0 generic/529 generic/578 generic/675 g=
eneric/688
> > > > > > > > > > > > Totals: 1454 tests, 1021 skipped, 30 failures, 0 er=
rors, 35096s
> > > > > > > > > > > >=20
> > > > > > > > > > > > KERNEL:=C2=A0=C2=A0=C2=A0 6.5.0-rc6-g4853c74bd7ab
> > > > > > > > > > > > CPUS:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8
> > > > > > > > > > > >=20
> > > > > > > > > > > > nfs_v3: 727 tests, 9 failures, 570 skipped, 14775 s=
econds
> > > > > > > > > > > > Failures: generic/053 generic/099 generic/105 gener=
ic/258
> > > > > > > > > > > >  =C2=A0=C2=A0 generic/294 generic/318 generic/319 g=
eneric/444 generic/529
> > > > > > > > > > > > nfs_default: 727 tests, 16 failures, 453 skipped, 2=
2326 seconds
> > > > > > > > > > > > Failures: generic/053 generic/099 generic/105 gener=
ic/186
> > > > > > > > > > > >  =C2=A0=C2=A0 generic/187 generic/294 generic/318 g=
eneric/319 generic/357
> > > > > > > > > > > >  =C2=A0=C2=A0 generic/444 generic/486 generic/513 g=
eneric/529 generic/578
> > > > > > > > > > > >  =C2=A0=C2=A0 generic/675 generic/688
> > > > > > > > > > > > Totals: 1454 tests, 1023 skipped, 25 failures, 0 er=
rors, 35396s
> > > > > > > > > > > >=20
> > > > > > > > > > > > KERNEL:=C2=A0=C2=A0=C2=A0 6.5.0-rc6-next-20230816-g=
ef66bf8aeb91
> > > > > > > > > > > > CPUS:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 8
> > > > > > > > > > > >=20
> > > > > > > > > > > > nfs_v3: 727 tests, 9 failures, 570 skipped, 14657 s=
econds
> > > > > > > > > > > > Failures: generic/053 generic/099 generic/105 gener=
ic/258
> > > > > > > > > > > >  =C2=A0=C2=A0 generic/294 generic/318 generic/319 g=
eneric/444 generic/529
> > > > > > > > > > > > nfs_default: 727 tests, 18 failures, 453 skipped, 2=
1757 seconds
> > > > > > > > > > > > Failures: generic/053 generic/099 generic/105 gener=
ic/186
> > > > > > > > > > > >  =C2=A0=C2=A0 generic/187 generic/294 generic/318 g=
eneric/319 generic/357
> > > > > > > > > > > >  =C2=A0=C2=A0 generic/444 generic/486 generic/513 g=
eneric/529 generic/578
> > > > > > > > > > > >  =C2=A0=C2=A0 generic/675 generic/683 generic/684 g=
eneric/688
> > > > > > > > > > > > Totals: 1454 tests, 1023 skipped, 27 failures, 0 er=
rors, 34870s
> > > > > > > > > As long as we're sharing results ... here is what I'm see=
ing with a
> > > > > > > > > 6.5-rc6 client & server:
> > > > > > > > >=20
> > > > > > > > > anna@gouda ~ % xfstestsdb xunit list --results --runid 17=
41
> > > > > > > > > --color=3Dnone
> > > > > > > > > +------+----------------------+---------+----------+-----=
-+------+------+-------+
> > > > > > > > >=20
> > > > > > > > > > run | device=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | xunit=C2=A0=C2=A0 | hostname |=
 pass | fail |
> > > > > > > > > skip |=C2=A0 time |
> > > > > > > > > +------+----------------------+---------+----------+-----=
-+------+------+-------+
> > > > > > > > >=20
> > > > > > > > > > 1741 | server:/srv/xfs/test | tcp-3=C2=A0=C2=A0 | clien=
t=C2=A0=C2=A0 |=C2=A0 125 |=C2=A0=C2=A0=C2=A0 4 |
> > > > > > > > > 464 | 447 s |
> > > > > > > > > > 1741 | server:/srv/xfs/test | tcp-4.0 | client=C2=A0=C2=
=A0 |=C2=A0 117 |=C2=A0=C2=A0 11 |
> > > > > > > > > 465 | 478 s |
> > > > > > > > > > 1741 | server:/srv/xfs/test | tcp-4.1 | client=C2=A0=C2=
=A0 |=C2=A0 119 |=C2=A0=C2=A0 12 |
> > > > > > > > > 462 | 404 s |
> > > > > > > > > > 1741 | server:/srv/xfs/test | tcp-4.2 | client=C2=A0=C2=
=A0 |=C2=A0 212 |=C2=A0=C2=A0 18 |
> > > > > > > > > 363 | 564 s |
> > > > > > > > > +------+----------------------+---------+----------+-----=
-+------+------+-------+
> > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > anna@gouda ~ % xfstestsdb show --failure 1741 --color=3Dn=
one
> > > > > > > > > +-------------+---------+---------+---------+---------+
> > > > > > > > > >  =C2=A0=C2=A0 testcase | tcp-3=C2=A0=C2=A0 | tcp-4.0 | =
tcp-4.1 | tcp-4.2 |
> > > > > > > > > +-------------+---------+---------+---------+---------+
> > > > > > > > > > generic/053 | passed=C2=A0 | failure | failure | failur=
e |
> > > > > > > > > > generic/099 | passed=C2=A0 | failure | failure | failur=
e |
> > > > > > > > > > generic/105 | passed=C2=A0 | failure | failure | failur=
e |
> > > > > > > > > > generic/140 | skipped | skipped | skipped | failure |
> > > > > > > > > > generic/188 | skipped | skipped | skipped | failure |
> > > > > > > > > > generic/258 | failure | passed=C2=A0 | passed=C2=A0 | f=
ailure |
> > > > > > > > > > generic/294 | failure | failure | failure | failure |
> > > > > > > > > > generic/318 | passed=C2=A0 | failure | failure | failur=
e |
> > > > > > > > > > generic/319 | passed=C2=A0 | failure | failure | failur=
e |
> > > > > > > > > > generic/357 | skipped | skipped | skipped | failure |
> > > > > > > > > > generic/444 | failure | failure | failure | failure |
> > > > > > > > > > generic/465 | passed=C2=A0 | failure | failure | failur=
e |
> > > > > > > > > > generic/513 | skipped | skipped | skipped | failure |
> > > > > > > > > > generic/529 | passed=C2=A0 | failure | failure | failur=
e |
> > > > > > > > > > generic/604 | passed=C2=A0 | passed=C2=A0 | failure | p=
assed=C2=A0 |
> > > > > > > > > > generic/675 | skipped | skipped | skipped | failure |
> > > > > > > > > > generic/688 | skipped | skipped | skipped | failure |
> > > > > > > > > > generic/697 | passed=C2=A0 | failure | failure | failur=
e |
> > > > > > > > > >  =C2=A0=C2=A0=C2=A0 nfs/002 | failure | failure | failu=
re | failure |
> > > > > > > > > +-------------+---------+---------+---------+---------+
> > > > > > > > >=20
> > > > > > > > >=20
> > > > > > > > > > > > With NFSv4.2, v6.4.0 has 2 extra failures that the =
current
> > > > > > > > > > > > mainline
> > > > > > > > > > > > kernel doesn't:
> > > > > > > > > > > >=20
> > > > > > > > > > > >  =C2=A0=C2=A0 generic/193 (some sort of setattr pro=
blem)
> > > > > > > > > > > >  =C2=A0=C2=A0 generic/528 (known problem with btime=
 handling in client
> > > > > > > > > > > > that has been fixed)
> > > > > > > > > > > >=20
> > > > > > > > > > > > While I haven't investigated, I'm assuming the 193 =
bug is also
> > > > > > > > > > > > something
> > > > > > > > > > > > that has been fixed in recent kernels. There are al=
so 3 other
> > > > > > > > > > > > NFSv3
> > > > > > > > > > > > tests that started passing since v6.4.0. I haven't =
looked into
> > > > > > > > > > > > those.
> > > > > > > > > > > >=20
> > > > > > > > > > > > With the linux-next kernel there are 2 new regressi=
ons:
> > > > > > > > > > > >=20
> > > > > > > > > > > >  =C2=A0=C2=A0 generic/683
> > > > > > > > > > > >  =C2=A0=C2=A0 generic/684
> > > > > > > > > > > >=20
> > > > > > > > > > > > Both of these look like problems with setuid/setgid=
 stripping,
> > > > > > > > > > > > and still
> > > > > > > > > > > > need to be investigated. I have more verbose result=
 info on
> > > > > > > > > > > > the test
> > > > > > > > > > > > failures if anyone is interested.
> > > > > > > > > Interesting that I'm not seeing the 683 & 684 failures. W=
hat type of
> > > > > > > > > filesystem is your server exporting?
> > > > > > > > >=20
> > > > > > > > btrfs
> > > > > > > >=20
> > > > > > > > You are testing linux-next? I need to go back and confirm t=
hese
> > > > > > > > results
> > > > > > > > too.
> > > > > > > IMO linux-next is quite important : we keep hitting bugs that
> > > > > > > appear only after integration -- block and network changes in
> > > > > > > other trees especially can impact the NFS drivers.
> > > > > > >=20
> > > > > > Indeed, I suspect this is probably something from the vfs tree =
(though
> > > > > > we definitely need to confirm that). Today I'm testing:
> > > > > >=20
> > > > > >  =C2=A0=C2=A0=C2=A0=C2=A0 6.5.0-rc6-next-20230817-g47762f086974
> > > > > >=20
> > > > > Nope, I was wrong. I ran a bisect and it landed here. I confirmed=
 it by
> > > > > turning off leases on the nfs server and the test started passing=
. I
> > > > > probably won't have the cycles to chase this down further.
> > > > >=20
> > > > > The capture looks something like this:
> > > > >=20
> > > > > OPEN (get a write delegation
> > > > > WRITE
> > > > > CLOSE
> > > > > SETATTR (mode 06666)
> > > > >=20
> > > > > ...then presumably a task on the client opens the file again, but=
 the
> > > > > setuid bits don't get stripped.
>=20
> OPEN (get a write delegation
> WRITE
> CLOSE
> SETATTR (mode 06666)
>=20
> The client continues with:
>=20
> (ALLOCATE,GETATTR)  <<=3D=3D=3D  this is when the server stripped the SUI=
D and SGID bit
> READDIR             =3D=3D=3D=3D>  file mode shows 0666  (SUID & SGID wer=
e stripped)
> READDIR             =3D=3D=3D=3D>  file mode shows 0666  (SUID & SGID wer=
e stripped)
> DELERETURN
>=20
> Here is stack trace of ALLOCATE when the SUID & SGID were stripped:
>=20
> **** start of notify_change, notice the i_mode bits, SUID & SGID were set=
:
> [notify_change]: d_iname[a] ia_valid[0x1a00] ia_mode[0x0] i_mode[0x8db6] =
[nfsd:2409:Mon Aug 21 23:05:31 2023]
>                          KILL[0] KILL_SUID[1] KILL_SGID[1]
>=20
> **** end of notify_change, notice the i_mode bits, SUID & SGID were strip=
ped:
> [notify_change]: RET[0] d_iname[a] ia_valid[0x1a01] ia_mode[0x81b6] i_mod=
e[0x81b6] [nfsd:2409:Mon Aug 21 23:05:31 2023]
>=20
> **** stack trace of notify_change comes from ALLOCATE:
> Returning from:  0xffffffffb726e764 : notify_change+0x4/0x500 [kernel]
> Returning to  :  0xffffffffb726bf99 : __file_remove_privs+0x119/0x170 [ke=
rnel]
>   0xffffffffb726cfad : file_modified_flags+0x4d/0x110 [kernel]
>   0xffffffffc0a2330b : xfs_file_fallocate+0xfb/0x490 [xfs]
>   0xffffffffb723e7d8 : vfs_fallocate+0x158/0x380 [kernel]
>   0xffffffffc0ddc30a : nfsd4_vfs_fallocate+0x4a/0x70 [nfsd]
>   0xffffffffc0def7f2 : nfsd4_allocate+0x72/0xc0 [nfsd]
>   0xffffffffc0df2663 : nfsd4_proc_compound+0x3d3/0x730 [nfsd]
>   0xffffffffc0dd633b : nfsd_dispatch+0xab/0x1d0 [nfsd]
>   0xffffffffc0bda476 : svc_process_common+0x306/0x6e0 [sunrpc]
>   0xffffffffc0bdb081 : svc_process+0x131/0x180 [sunrpc]
>   0xffffffffc0dd4864 : nfsd+0x84/0xd0 [nfsd]
>   0xffffffffb6f0bfd6 : kthread+0xe6/0x120 [kernel]
>   0xffffffffb6e587d4 : ret_from_fork+0x34/0x50 [kernel]
>   0xffffffffb6e03a3b : ret_from_fork_asm+0x1b/0x30 [kernel]
>=20
> I think the problem here is that the client does not update the file
> attribute after ALLOCATE. The GETATTR in the ALLOCATE compound does
> not include the mode bits.
>=20

Oh, interesting! Have you tried adding the FATTR4_MODE to that GETATTR
call on the client? Does it also fix this?

> The READDIR's reply show the test file's mode has the SUID & SGID bit
> stripped (0666) but apparently these were not used o update the file
> attribute.
>=20
> The test passes when server does not grant write delegation because:
>=20
> OPEN
> WRITE
> CLOSE
> SETATTR (06666)
> OPEN (CLAIM_FH, NOCREATE)
> ALLOCATE        <<=3D=3D=3D server clear SUID & SGID
> GETATTR, CLOSE  <<=3D=3D=3D GETATTR has mode bit as 0666, client updates =
file attribute
> READDIR
> READDIR
>=20
> As expected, if the server recalls the write delegation when SETATTR
> with SUID/SGID set then the test passes. This is because it forces the
> client to send the 2nd OPEN with CLAIM_FH, NOCREATE and then the
> (GETATTR, CLOSE) which cause the client to update the file attribute.
>=20

What's your sense of the best way to fix this? The stripping of mode
bits isn't covered by the NFSv4 spec, so this will ultimately come down
to a judgment call.
--=20
Jeff Layton <jlayton@kernel.org>
