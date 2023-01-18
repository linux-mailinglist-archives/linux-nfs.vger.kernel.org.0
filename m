Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B59E6724AE
	for <lists+linux-nfs@lfdr.de>; Wed, 18 Jan 2023 18:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbjARRSO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 18 Jan 2023 12:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjARRSJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 18 Jan 2023 12:18:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D316F58651
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 09:18:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6405DB81CE6
        for <linux-nfs@vger.kernel.org>; Wed, 18 Jan 2023 17:18:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672DFC433D2;
        Wed, 18 Jan 2023 17:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674062285;
        bh=7kosCrmMRRUqlGbjm0BasH6laRTkp7QpxMA4UjWvMug=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=WaHikSNmXIQoJIz4j78Li/PazeBXK2T1d4fgBafCnmSwj5xyimjv+nWb0aWKxwifb
         +O5JTStzvr7JWKZlhBkeSVZ6spp+BqS1tksWHWKryJ8SG12zXxHROV/g5AI1nc2MXT
         85sHAnS5kHdO7Uc/lLoYCPL1UdndhxtOUbRMLRRCqfCHt/I8NVgkSar3+5A/cvFEHV
         w1jH+0baO8fW/KIJLsBDCj3MNI0q6vCNahi7ytDnF8IBncSusnvyXXzQd9PNO2kD2a
         u/BGsKcg9wAGoxx2Q1L/x/oRNmn/WKyiG9+DUMnPSq3jocoaOg0xbEYu1ZCna7DXAp
         9KMruBgqEZUyw==
Message-ID: <a2c70d7d715b11c84612a119048d1c15b2dba83f.camel@kernel.org>
Subject: Re: [PATCH v5 3/5] nfsd: rework refcounting in filecache
From:   Jeff Layton <jlayton@kernel.org>
To:     Shachar Kagan <skagan@nvidia.com>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Yishai Hadas <yishaih@nvidia.com>,
        Itay Aveksis <itayav@nvidia.com>, Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Wed, 18 Jan 2023 12:18:03 -0500
In-Reply-To: <MN2PR12MB4486E3A2E31CC6E8674E7059B9C79@MN2PR12MB4486.namprd12.prod.outlook.com>
References: <20221101144647.136696-1-jlayton@kernel.org>
         <20221101144647.136696-4-jlayton@kernel.org> <Y8a766ypSbKbevTJ@nvidia.com>
         <9CAD601F-C323-405F-840A-9CBAF520948B@oracle.com>
         <d69c0c643c23c56408640c4b7d4fc2acac4bc66f.camel@kernel.org>
         <MN2PR12MB4486E3A2E31CC6E8674E7059B9C79@MN2PR12MB4486.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2023-01-18 at 16:48 +0000, Shachar Kagan wrote:
> On Wend, 2023-01-18 at 18:45 +0000, Chuck Lever III wrote:
>=20
> > On Tue, 2023-01-17 at 15:22 +0000, Chuck Lever III wrote:
> > >=20
> > > > On Jan 17, 2023, at 10:16 AM, Jason Gunthorpe <jgg@nvidia.com> wrot=
e:
> > > >=20
> > > > On Tue, Nov 01, 2022 at 10:46:45AM -0400, Jeff Layton wrote:
> > > > > The filecache refcounting is a bit non-standard for something=20
> > > > > searchable by RCU, in that we maintain a sentinel reference while=
=20
> > > > > it's hashed. This in turn requires that we have to do things diff=
erently in the "put"
> > > > > depending on whether its hashed, which we believe to have led to =
races.
> > > > >=20
> > > > > There are other problems in here too. nfsd_file_close_inode_sync=
=20
> > > > > can end up freeing an nfsd_file while there are still outstanding=
=20
> > > > > references to it, and there are a number of subtle ToC/ToU races.
> > > > >=20
> > > > > Rework the code so that the refcount is what drives the lifecycle=
.=20
> > > > > When the refcount goes to zero, then unhash and rcu free the obje=
ct.
> > > > >=20
> > > > > With this change, the LRU carries a reference. Take special care=
=20
> > > > > to deal with it when removing an entry from the list.
> > > > >=20
> > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > >=20
> > > > Our test team is getting crashes that bisection pointed at this=20
> > > > patch. It seems like there are multiple parallel crash reports so=
=20
> > > > the whole thing is a mess to read:
> > > >=20
> > > > [  875.548965] BUG: kernel NULL pointer dereference, address:=20
> > > > 00000000000000d0 [  875.548968] ------------[ cut here ]-----------=
-=20
> > > > [  875.548972] refcount_t: underflow; use-after-free.
> > > > [  875.548992] WARNING: CPU: 4 PID: 12145 at lib/refcount.c:28=20
> > > > refcount_warn_saturate+0xd8/0xe0 [  875.549851] #PF: supervisor rea=
d=20
> > > > access in kernel mode [  875.550158] Modules linked in:
> > > > [  875.550752] #PF: error_code(0x0000) - not-present page [ =20
> > > > 875.551269]  nfsd [  875.551878] PGD 0 [  875.552069]  iptable_raw =
[ =20
> > > > 875.552677] P4D 0 [  875.552824]  bonding mlx5_vfio_pci [ =20
> > > > 875.553095] [  875.553255]  rdma_ucm ipip [  875.553525] Oops: 0000=
=20
> > > > [#1] SMP [  875.553733]  tunnel4 [  875.553941] CPU: 0 PID: 12147=
=20
> > > > Comm: nfsd Not tainted 6.1.0-rc7_ac3a2585f018 #1 [  875.554109] =
=20
> > > > ip_gre ib_umad [  875.554517] Hardware name: QEMU Standard PC (Q35 =
+=20
> > > > ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org=20
> > > > 04/01/2014 [  875.554656]  nf_tables vfio_pci [  875.555508] RIP:=
=20
> > > > 0010:vfs_setlease+0x27/0x70 [  875.555695]  vfio_pci_core=20
> > > > vfio_virqfd [  875.557015] Code: ff ff 90 0f 1f 44 00 00 41 54 49 8=
9=20
> > > > d4 55 48 89 fd 48 83 ec 10 48 85 d2 74 06 48 83 fe 02 75 1f 48 8b 4=
5=20
> > > > 28 4c 89 e2 48 89 ef <48> 8b 80 d0 00 00 00 48 85 c0 74 2c 48 83 c4=
=20
> > > > 10 5d 41 5c ff e0 48 [  875.557209]  vfio_iommu_type1 [  875.557406=
]=20
> > > > RSP: 0018:ffff88810378bdb0 EFLAGS: 00010246 [  875.557634]  mlx5_ib=
=20
> > > > [  875.558446] [  875.558628]  vfio [  875.558862] RAX:=20
> > > > 0000000000000000 RBX: ffff88824866c000 RCX: ffff88810378bdd8 [ =20
> > > > 875.559006]  ib_uverbs [  875.559092] RDX: 0000000000000000 RSI:=
=20
> > > > 0000000000000002 RDI: ffff88812560a200 [  875.559218]  ib_ipoib [ =
=20
> > > > 875.559557] RBP: ffff88812560a200 R08: ffff8881da5ecf00 R09:=20
> > > > ffffffff824064e0 [  875.559704]  mlx5_core [  875.560021] R10:=20
> > > > 0000000000000000 R11: 0000000000000000 R12: 0000000000000000 [ =20
> > > > 875.560165]  ip6_gre [  875.560488] R13: ffff8881da5ecf00 R14:=20
> > > > ffff888110e62028 R15: ffff888110e621a0 [  875.560634]  gre [ =20
> > > > 875.560959] FS:  0000000000000000(0000) GS:ffff88852c800000(0000)=
=20
> > > > knlGS:0000000000000000 [  875.561108]  ip6_tunnel [  875.561432] CS=
: =20
> > > > 0010 DS: 0000 ES: 0000 CR0: 0000000080050033 [  875.561554]  tunnel=
6=20
> > > > [  875.561928] CR2: 00000000000000d0 CR3: 00000001ca27d001 CR4:=20
> > > > 0000000000372eb0 [  875.562084]  geneve [  875.562349] DR0:=20
> > > > 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000 [ =20
> > > > 875.562493]  nfnetlink_cttimeout [  875.562822] DR3:=20
> > > > 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400 [ =20
> > > > 875.562962]  openvswitch [  875.563292] Call Trace:
> > > > [  875.563298]  <TASK>
> > > > [  875.563503]  nsh
> > > > [  875.563839]  destroy_unhashed_deleg+0x58/0xc0 [nfsd]
> > >=20
> > > We are aware of this failure mode. Actually this started well before=
=20
> > > that particular commit.
> > >=20
> > > Our problem has been that no one has been able to provide a reliable=
=20
> > > reproducer, so we can't figure out why it's happening. If you have a=
=20
> > > way to reproduce this failure reliably, can you capture a vmcore or=
=20
> > > enable KASAN and get a little more information?
> > >=20
> >=20
> > It's possible that this crash may be related to the problem that was fi=
xed here:
> >=20
> >    commit 0b3a551fa58b4da941efeb209b3770868e2eddd7
> >    Author: Jeff Layton <jlayton@kernel.org>
> >    Date:   Thu Jan 5 14:55:56 2023 -0500
> >=20
> >        nfsd: fix handling of cached open files in nfsd4_open codepath
> >=20
> > Unfortunately, that hasn't trickled into v6.1 kernels so far.
>=20
> This commit is in my working tree, but this commit doesn't fix the issue =
since I still face the crash.
> We are working on v6.2-rc3

Thanks for testing it. That patch fixes a real bug, just not the one
you're hitting apparently.

If you're comfortable working with bleeding edge kernels, you may just
want to pull in Chuck's for-rc and for-next branches. Those have a few
other patches that I wouldn't expect to change this, but might still be
worth testing to see.

If it's happening regularly, you could also try disabling leases on the
machine, at the expense of some performance. We suspect this is related
to delegation handling, but we just haven't been able to nail it down
yet. If you do that, and it seems to fix it for you, let us know as that
would be an interesting datapoint.

Thanks!
--=20
Jeff Layton <jlayton@kernel.org>
