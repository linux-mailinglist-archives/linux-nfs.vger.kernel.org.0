Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDB077FA8D
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Aug 2023 17:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353076AbjHQPSC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Aug 2023 11:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353111AbjHQPRp (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Aug 2023 11:17:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468482722
        for <linux-nfs@vger.kernel.org>; Thu, 17 Aug 2023 08:17:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C3A346743A
        for <linux-nfs@vger.kernel.org>; Thu, 17 Aug 2023 15:17:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34CCCC433CA
        for <linux-nfs@vger.kernel.org>; Thu, 17 Aug 2023 15:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692285461;
        bh=kM+qmXOR0I9hFc/lqYsInxLWatGevJgHNrXR7VcGwKA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LbWHAQRYoh08WEl4a8JbOV76uWNF5Mq/qNiFN1cWEoAikPGtSmbB/bSiKeLVxD12e
         mLsD7KsRHNfs5dfo3+SyQS0cLT7V2sOezbkYgRx1iENBJ/j4yxBl6xn57eTsa5rUu+
         yuJ3T5S2+we2ctBnujzU8U0sNhzg2aygCvh04of4ElAQesPCw495ALTE/paWpMk+7j
         IhDk78Lv8OlDJcsssCYCvgEq/2tHpapZdr5YR6nA/u3zFZGfQP/SL2vcnREAw7/DJq
         y16aSn8Xzsski825bem608b9HfnuMqc/x4r8ddAfKCeUC1FwYaFX/nbnu4N/qsD3Lj
         oSBPaYN+etUBw==
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4085ee5b1e6so5046771cf.0
        for <linux-nfs@vger.kernel.org>; Thu, 17 Aug 2023 08:17:41 -0700 (PDT)
X-Gm-Message-State: AOJu0YzcFb83dSBPlYikW6IaPoKlPDVCRqocNT9b4YwsIiT4l+aAH2aI
        tW/Kyyw6e47oS21xqIei4rPEVOAGIhZDkJtGs/M=
X-Google-Smtp-Source: AGHT+IGrvJeQ+z2i4ZyZSrDuIthq4wt0G+C/DcvlNo2Z0s3LHxErxiZTWcw9xZmM1W3Ce9aXK4jQ3MBLEptAlpNGw/U=
X-Received: by 2002:a05:622a:130a:b0:3f8:2a37:20f with SMTP id
 v10-20020a05622a130a00b003f82a37020fmr3774175qtk.34.1692285460245; Thu, 17
 Aug 2023 08:17:40 -0700 (PDT)
MIME-Version: 1.0
References: <9ee56f62652c3d338aff809f70e7941dfc284bf9.camel@kernel.org>
 <7C595ADA-E841-44F7-918A-3A46A55D546B@oracle.com> <2fc1f9bf5fdc25acbcabaf4266584f0857bc4b19.camel@kernel.org>
In-Reply-To: <2fc1f9bf5fdc25acbcabaf4266584f0857bc4b19.camel@kernel.org>
From:   Anna Schumaker <anna@kernel.org>
Date:   Thu, 17 Aug 2023 11:17:24 -0400
X-Gmail-Original-Message-ID: <CAFX2Jf=gq-U464_SrebSwCMOU+g0Vcx9Us7SPn8JQEoA6s27DQ@mail.gmail.com>
Message-ID: <CAFX2Jf=gq-U464_SrebSwCMOU+g0Vcx9Us7SPn8JQEoA6s27DQ@mail.gmail.com>
Subject: Re: xfstests results over NFS
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Trond Myklebust <trondmy@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>,
        "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Aug 17, 2023 at 10:22=E2=80=AFAM Jeff Layton <jlayton@kernel.org> w=
rote:
>
> On Thu, 2023-08-17 at 14:04 +0000, Chuck Lever III wrote:
> >
> > > On Aug 17, 2023, at 7:21 AM, Jeff Layton <jlayton@kernel.org> wrote:
> > >
> > > I finally got my kdevops (https://github.com/linux-kdevops/kdevops) t=
est
> > > rig working well enough to get some publishable results. To run fstes=
ts,
> > > kdevops will spin up a server and (in this case) 2 clients to run
> > > xfstests' auto group. One client mounts with default options, and the
> > > other uses NFSv3.
> > >
> > > I tested 3 kernels:
> > >
> > > v6.4.0 (stock release)
> > > 6.5.0-rc6-g4853c74bd7ab (Linus' tree as of a couple of days ago)
> > > 6.5.0-rc6-next-20230816-gef66bf8aeb91 (linux-next as of yesterday mor=
ning)
> > >
> > > Here are the results summary of all 3:
> > >
> > > KERNEL:    6.4.0
> > > CPUS:      8
> > >
> > > nfs_v3: 727 tests, 12 failures, 569 skipped, 14863 seconds
> > >  Failures: generic/053 generic/099 generic/105 generic/124
> > >    generic/193 generic/258 generic/294 generic/318 generic/319
> > >    generic/444 generic/528 generic/529
> > > nfs_default: 727 tests, 18 failures, 452 skipped, 21899 seconds
> > >  Failures: generic/053 generic/099 generic/105 generic/186
> > >    generic/187 generic/193 generic/294 generic/318 generic/319
> > >    generic/357 generic/444 generic/486 generic/513 generic/528
> > >    generic/529 generic/578 generic/675 generic/688
> > > Totals: 1454 tests, 1021 skipped, 30 failures, 0 errors, 35096s
> > >
> > > KERNEL:    6.5.0-rc6-g4853c74bd7ab
> > > CPUS:      8
> > >
> > > nfs_v3: 727 tests, 9 failures, 570 skipped, 14775 seconds
> > >  Failures: generic/053 generic/099 generic/105 generic/258
> > >    generic/294 generic/318 generic/319 generic/444 generic/529
> > > nfs_default: 727 tests, 16 failures, 453 skipped, 22326 seconds
> > >  Failures: generic/053 generic/099 generic/105 generic/186
> > >    generic/187 generic/294 generic/318 generic/319 generic/357
> > >    generic/444 generic/486 generic/513 generic/529 generic/578
> > >    generic/675 generic/688
> > > Totals: 1454 tests, 1023 skipped, 25 failures, 0 errors, 35396s
> > >
> > > KERNEL:    6.5.0-rc6-next-20230816-gef66bf8aeb91
> > > CPUS:      8
> > >
> > > nfs_v3: 727 tests, 9 failures, 570 skipped, 14657 seconds
> > >  Failures: generic/053 generic/099 generic/105 generic/258
> > >    generic/294 generic/318 generic/319 generic/444 generic/529
> > > nfs_default: 727 tests, 18 failures, 453 skipped, 21757 seconds
> > >  Failures: generic/053 generic/099 generic/105 generic/186
> > >    generic/187 generic/294 generic/318 generic/319 generic/357
> > >    generic/444 generic/486 generic/513 generic/529 generic/578
> > >    generic/675 generic/683 generic/684 generic/688
> > > Totals: 1454 tests, 1023 skipped, 27 failures, 0 errors, 34870s

As long as we're sharing results ... here is what I'm seeing with a
6.5-rc6 client & server:

anna@gouda ~ % xfstestsdb xunit list --results --runid 1741 --color=3Dnone
+------+----------------------+---------+----------+------+------+------+--=
-----+
|  run | device               | xunit   | hostname | pass | fail |
skip |  time |
+------+----------------------+---------+----------+------+------+------+--=
-----+
| 1741 | server:/srv/xfs/test | tcp-3   | client   |  125 |    4 |
464 | 447 s |
| 1741 | server:/srv/xfs/test | tcp-4.0 | client   |  117 |   11 |
465 | 478 s |
| 1741 | server:/srv/xfs/test | tcp-4.1 | client   |  119 |   12 |
462 | 404 s |
| 1741 | server:/srv/xfs/test | tcp-4.2 | client   |  212 |   18 |
363 | 564 s |
+------+----------------------+---------+----------+------+------+------+--=
-----+

anna@gouda ~ % xfstestsdb show --failure 1741 --color=3Dnone
+-------------+---------+---------+---------+---------+
|    testcase | tcp-3   | tcp-4.0 | tcp-4.1 | tcp-4.2 |
+-------------+---------+---------+---------+---------+
| generic/053 | passed  | failure | failure | failure |
| generic/099 | passed  | failure | failure | failure |
| generic/105 | passed  | failure | failure | failure |
| generic/140 | skipped | skipped | skipped | failure |
| generic/188 | skipped | skipped | skipped | failure |
| generic/258 | failure | passed  | passed  | failure |
| generic/294 | failure | failure | failure | failure |
| generic/318 | passed  | failure | failure | failure |
| generic/319 | passed  | failure | failure | failure |
| generic/357 | skipped | skipped | skipped | failure |
| generic/444 | failure | failure | failure | failure |
| generic/465 | passed  | failure | failure | failure |
| generic/513 | skipped | skipped | skipped | failure |
| generic/529 | passed  | failure | failure | failure |
| generic/604 | passed  | passed  | failure | passed  |
| generic/675 | skipped | skipped | skipped | failure |
| generic/688 | skipped | skipped | skipped | failure |
| generic/697 | passed  | failure | failure | failure |
|     nfs/002 | failure | failure | failure | failure |
+-------------+---------+---------+---------+---------+


> > >
> > > With NFSv4.2, v6.4.0 has 2 extra failures that the current mainline
> > > kernel doesn't:
> > >
> > >    generic/193 (some sort of setattr problem)
> > >    generic/528 (known problem with btime handling in client that has =
been fixed)
> > >
> > > While I haven't investigated, I'm assuming the 193 bug is also someth=
ing
> > > that has been fixed in recent kernels. There are also 3 other NFSv3
> > > tests that started passing since v6.4.0. I haven't looked into those.
> > >
> > > With the linux-next kernel there are 2 new regressions:
> > >
> > >    generic/683
> > >    generic/684
> > >
> > > Both of these look like problems with setuid/setgid stripping, and st=
ill
> > > need to be investigated. I have more verbose result info on the test
> > > failures if anyone is interested.

Interesting that I'm not seeing the 683 & 684 failures. What type of
filesystem is your server exporting?

> >
> > 100% awesome sauce. Out of curiosity:
> >
> > Does kdevops have a way of publishing (via an autonomous web site)
> > and archiving these results?
> >
>
> There's nothing much prewritten for this. There is some support for
> sending emails when you run a "ci" loop. I need to do more investigation
> here.

xfstests has an option to generate an xunit file, which can help here.
I use with my own archiving tool to stick everything into a sqlite
database (https://git.nowheycreamery.com/anna/xfstestsdb).

>
> Note that there has been some parallel effort toward CI in the SMB space
> using buildbot. It may worthwhile to consider combining efforts somehow.

It might be nice to at least see what they're doing. If they have
something that works well, then setting up something similar might be
a good idea.

Anna

>
> > Does the "auto" group include tests that require a SCRATCH_DEV?
> >
>
> Yes. The nfs server is configured with 2 exported fs', so I have it
> mounting a directory under one as "test" and the other as "scratch".
> --
> Jeff Layton <jlayton@kernel.org>
