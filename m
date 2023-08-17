Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4634977F8C0
	for <lists+linux-nfs@lfdr.de>; Thu, 17 Aug 2023 16:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351836AbjHQOXB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 17 Aug 2023 10:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351847AbjHQOWi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 17 Aug 2023 10:22:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6A02D79
        for <linux-nfs@vger.kernel.org>; Thu, 17 Aug 2023 07:22:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B23064CA8
        for <linux-nfs@vger.kernel.org>; Thu, 17 Aug 2023 14:22:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 207D6C433C7;
        Thu, 17 Aug 2023 14:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692282155;
        bh=Xp1G9kdHHkjWMaabOcvxCBqge9wtw/aHu27fcHmwS6U=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=a5PhSNyc1i8NiWf0QGmfgSpx9LskyBgm8LRGvYwWwFECRIry/ezNbwgcB2yp3OS6y
         vXI+IRxc06K2rmNDhoDe5XmiBAitg2Bahxk2ov/72ArnQ2esgHSokIHIGFJminJyN2
         kTWf97ROC4hifpHMqi1CESunHW/Mfci/nAW9kCR+1wCwUsyAEW/d2CfvIBP66B+OSE
         DUwvbGyAo35DmNQl8tWDm5nxqWIbwQ8m4NBzPCEAfDk4wnOrLT+Mf/asUZ3JZy962z
         HkZoTm5f7TailLbDwe/TJ7YzNtokM/jaHazqcdgXn0c9ChIsx3+YfRRjtUKOQX9MoM
         0IU3u29cF/2MA==
Message-ID: <2fc1f9bf5fdc25acbcabaf4266584f0857bc4b19.camel@kernel.org>
Subject: Re: xfstests results over NFS
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Trond Myklebust <trondmy@gmail.com>,
        Anna Schumaker <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Neil Brown <neilb@suse.de>,
        "Kornievskaia, Olga" <Olga.Kornievskaia@netapp.com>,
        Dai Ngo <dai.ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Date:   Thu, 17 Aug 2023 10:22:33 -0400
In-Reply-To: <7C595ADA-E841-44F7-918A-3A46A55D546B@oracle.com>
References: <9ee56f62652c3d338aff809f70e7941dfc284bf9.camel@kernel.org>
         <7C595ADA-E841-44F7-918A-3A46A55D546B@oracle.com>
Content-Type: text/plain; charset="ISO-8859-15"
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

On Thu, 2023-08-17 at 14:04 +0000, Chuck Lever III wrote:
>=20
> > On Aug 17, 2023, at 7:21 AM, Jeff Layton <jlayton@kernel.org> wrote:
> >=20
> > I finally got my kdevops (https://github.com/linux-kdevops/kdevops) tes=
t
> > rig working well enough to get some publishable results. To run fstests=
,
> > kdevops will spin up a server and (in this case) 2 clients to run
> > xfstests' auto group. One client mounts with default options, and the
> > other uses NFSv3.
> >=20
> > I tested 3 kernels:
> >=20
> > v6.4.0 (stock release)
> > 6.5.0-rc6-g4853c74bd7ab (Linus' tree as of a couple of days ago)
> > 6.5.0-rc6-next-20230816-gef66bf8aeb91 (linux-next as of yesterday morni=
ng)
> >=20
> > Here are the results summary of all 3:
> >=20
> > KERNEL:    6.4.0
> > CPUS:      8
> >=20
> > nfs_v3: 727 tests, 12 failures, 569 skipped, 14863 seconds
> >  Failures: generic/053 generic/099 generic/105 generic/124=20
> >    generic/193 generic/258 generic/294 generic/318 generic/319=20
> >    generic/444 generic/528 generic/529=20
> > nfs_default: 727 tests, 18 failures, 452 skipped, 21899 seconds
> >  Failures: generic/053 generic/099 generic/105 generic/186=20
> >    generic/187 generic/193 generic/294 generic/318 generic/319=20
> >    generic/357 generic/444 generic/486 generic/513 generic/528=20
> >    generic/529 generic/578 generic/675 generic/688=20
> > Totals: 1454 tests, 1021 skipped, 30 failures, 0 errors, 35096s
> >=20
> > KERNEL:    6.5.0-rc6-g4853c74bd7ab
> > CPUS:      8
> >=20
> > nfs_v3: 727 tests, 9 failures, 570 skipped, 14775 seconds
> >  Failures: generic/053 generic/099 generic/105 generic/258=20
> >    generic/294 generic/318 generic/319 generic/444 generic/529=20
> > nfs_default: 727 tests, 16 failures, 453 skipped, 22326 seconds
> >  Failures: generic/053 generic/099 generic/105 generic/186=20
> >    generic/187 generic/294 generic/318 generic/319 generic/357=20
> >    generic/444 generic/486 generic/513 generic/529 generic/578=20
> >    generic/675 generic/688=20
> > Totals: 1454 tests, 1023 skipped, 25 failures, 0 errors, 35396s
> >=20
> > KERNEL:    6.5.0-rc6-next-20230816-gef66bf8aeb91
> > CPUS:      8
> >=20
> > nfs_v3: 727 tests, 9 failures, 570 skipped, 14657 seconds
> >  Failures: generic/053 generic/099 generic/105 generic/258=20
> >    generic/294 generic/318 generic/319 generic/444 generic/529=20
> > nfs_default: 727 tests, 18 failures, 453 skipped, 21757 seconds
> >  Failures: generic/053 generic/099 generic/105 generic/186=20
> >    generic/187 generic/294 generic/318 generic/319 generic/357=20
> >    generic/444 generic/486 generic/513 generic/529 generic/578=20
> >    generic/675 generic/683 generic/684 generic/688=20
> > Totals: 1454 tests, 1023 skipped, 27 failures, 0 errors, 34870s
> >=20
> > With NFSv4.2, v6.4.0 has 2 extra failures that the current mainline
> > kernel doesn't:
> >=20
> >    generic/193 (some sort of setattr problem)
> >    generic/528 (known problem with btime handling in client that has be=
en fixed)
> >=20
> > While I haven't investigated, I'm assuming the 193 bug is also somethin=
g
> > that has been fixed in recent kernels. There are also 3 other NFSv3
> > tests that started passing since v6.4.0. I haven't looked into those.
> >=20
> > With the linux-next kernel there are 2 new regressions:
> >=20
> >    generic/683
> >    generic/684
> >=20
> > Both of these look like problems with setuid/setgid stripping, and stil=
l
> > need to be investigated. I have more verbose result info on the test
> > failures if anyone is interested.
>=20
> 100% awesome sauce. Out of curiosity:
>=20
> Does kdevops have a way of publishing (via an autonomous web site)
> and archiving these results?
>=20

There's nothing much prewritten for this. There is some support for
sending emails when you run a "ci" loop. I need to do more investigation
here.

Note that there has been some parallel effort toward CI in the SMB space
using buildbot. It may worthwhile to consider combining efforts somehow.

> Does the "auto" group include tests that require a SCRATCH_DEV?
>=20

Yes. The nfs server is configured with 2 exported fs', so I have it
mounting a directory under one as "test" and the other as "scratch".
--=20
Jeff Layton <jlayton@kernel.org>
