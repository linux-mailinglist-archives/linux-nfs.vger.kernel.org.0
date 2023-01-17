Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AB7266E2EC
	for <lists+linux-nfs@lfdr.de>; Tue, 17 Jan 2023 16:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjAQP7J (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 17 Jan 2023 10:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjAQP7I (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 17 Jan 2023 10:59:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3258E2B291
        for <linux-nfs@vger.kernel.org>; Tue, 17 Jan 2023 07:59:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DD44BB816E6
        for <linux-nfs@vger.kernel.org>; Tue, 17 Jan 2023 15:59:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD582C433F0;
        Tue, 17 Jan 2023 15:59:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673971144;
        bh=AvPqXc+sSC8bQyPGC+VkK62UiNvbhTNbzxpX1DoudFo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=smt6hFE0i6+i5W3XLxECbmJj8or8/v65mMq5vlCOmUoREzlMAELeChoe4ub4pPS21
         i/I3ppIy5hO7mqNLDwxhjXHcwFuGIDZwnQVIEzkMMUoMYqWJFzk9y9oNxegHrC13tr
         YqnbtwHfpQztcMCiOLWqkdb+wbN12icy6PCERwRz3jhrEXSux/14kddU0ilwIG4L/2
         mat6IJN/T3KOvaAa6Qa1bdvTpw2K0BncAy+6dJ9X6n5eLDRZkEHI8Er8C4xUNXqLkO
         IMJsQ1cvpIfblkHR3wpnRKnfBeIX4OZCMeua5SDeIYSxzQ1l47l/3JaEyPwSPZYxvv
         YldxtjFSQ762A==
Message-ID: <d69c0c643c23c56408640c4b7d4fc2acac4bc66f.camel@kernel.org>
Subject: Re: [PATCH v5 3/5] nfsd: rework refcounting in filecache
From:   Jeff Layton <jlayton@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Yishai Hadas <yishaih@nvidia.com>,
        Shachar Kagan <skagan@nvidia.com>,
        Itay Aveksis <itayav@nvidia.com>, Neil Brown <neilb@suse.de>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Tue, 17 Jan 2023 10:59:02 -0500
In-Reply-To: <9CAD601F-C323-405F-840A-9CBAF520948B@oracle.com>
References: <20221101144647.136696-1-jlayton@kernel.org>
         <20221101144647.136696-4-jlayton@kernel.org> <Y8a766ypSbKbevTJ@nvidia.com>
         <9CAD601F-C323-405F-840A-9CBAF520948B@oracle.com>
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

On Tue, 2023-01-17 at 15:22 +0000, Chuck Lever III wrote:
>=20
> > On Jan 17, 2023, at 10:16 AM, Jason Gunthorpe <jgg@nvidia.com> wrote:
> >=20
> > On Tue, Nov 01, 2022 at 10:46:45AM -0400, Jeff Layton wrote:
> > > The filecache refcounting is a bit non-standard for something searcha=
ble
> > > by RCU, in that we maintain a sentinel reference while it's hashed. T=
his
> > > in turn requires that we have to do things differently in the "put"
> > > depending on whether its hashed, which we believe to have led to race=
s.
> > >=20
> > > There are other problems in here too. nfsd_file_close_inode_sync can =
end
> > > up freeing an nfsd_file while there are still outstanding references =
to
> > > it, and there are a number of subtle ToC/ToU races.
> > >=20
> > > Rework the code so that the refcount is what drives the lifecycle. Wh=
en
> > > the refcount goes to zero, then unhash and rcu free the object.
> > >=20
> > > With this change, the LRU carries a reference. Take special care to
> > > deal with it when removing an entry from the list.
> > >=20
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> >=20
> > Our test team is getting crashes that bisection pointed at this
> > patch. It seems like there are multiple parallel crash reports so the
> > whole thing is a mess to read:
> >=20
> > [  875.548965] BUG: kernel NULL pointer dereference, address: 000000000=
00000d0
> > [  875.548968] ------------[ cut here ]------------
> > [  875.548972] refcount_t: underflow; use-after-free.
> > [  875.548992] WARNING: CPU: 4 PID: 12145 at lib/refcount.c:28 refcount=
_warn_saturate+0xd8/0xe0
> > [  875.549851] #PF: supervisor read access in kernel mode
> > [  875.550158] Modules linked in:
> > [  875.550752] #PF: error_code(0x0000) - not-present page
> > [  875.551269]  nfsd
> > [  875.551878] PGD 0
> > [  875.552069]  iptable_raw
> > [  875.552677] P4D 0
> > [  875.552824]  bonding mlx5_vfio_pci
> > [  875.553095]
> > [  875.553255]  rdma_ucm ipip
> > [  875.553525] Oops: 0000 [#1] SMP
> > [  875.553733]  tunnel4
> > [  875.553941] CPU: 0 PID: 12147 Comm: nfsd Not tainted 6.1.0-rc7_ac3a2=
585f018 #1
> > [  875.554109]  ip_gre ib_umad
> > [  875.554517] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS=
 rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> > [  875.554656]  nf_tables vfio_pci
> > [  875.555508] RIP: 0010:vfs_setlease+0x27/0x70
> > [  875.555695]  vfio_pci_core vfio_virqfd
> > [  875.557015] Code: ff ff 90 0f 1f 44 00 00 41 54 49 89 d4 55 48 89 fd=
 48 83 ec 10 48 85 d2 74 06 48 83 fe 02 75 1f 48 8b 45 28 4c 89 e2 48 89 ef=
 <48> 8b 80 d0 00 00 00 48 85 c0 74 2c 48 83 c4 10 5d 41 5c ff e0 48
> > [  875.557209]  vfio_iommu_type1
> > [  875.557406] RSP: 0018:ffff88810378bdb0 EFLAGS: 00010246
> > [  875.557634]  mlx5_ib
> > [  875.558446]
> > [  875.558628]  vfio
> > [  875.558862] RAX: 0000000000000000 RBX: ffff88824866c000 RCX: ffff888=
10378bdd8
> > [  875.559006]  ib_uverbs
> > [  875.559092] RDX: 0000000000000000 RSI: 0000000000000002 RDI: ffff888=
12560a200
> > [  875.559218]  ib_ipoib
> > [  875.559557] RBP: ffff88812560a200 R08: ffff8881da5ecf00 R09: fffffff=
f824064e0
> > [  875.559704]  mlx5_core
> > [  875.560021] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000=
000000000
> > [  875.560165]  ip6_gre
> > [  875.560488] R13: ffff8881da5ecf00 R14: ffff888110e62028 R15: ffff888=
110e621a0
> > [  875.560634]  gre
> > [  875.560959] FS:  0000000000000000(0000) GS:ffff88852c800000(0000) kn=
lGS:0000000000000000
> > [  875.561108]  ip6_tunnel
> > [  875.561432] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  875.561554]  tunnel6
> > [  875.561928] CR2: 00000000000000d0 CR3: 00000001ca27d001 CR4: 0000000=
000372eb0
> > [  875.562084]  geneve
> > [  875.562349] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
> > [  875.562493]  nfnetlink_cttimeout
> > [  875.562822] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000=
000000400
> > [  875.562962]  openvswitch
> > [  875.563292] Call Trace:
> > [  875.563298]  <TASK>
> > [  875.563503]  nsh
> > [  875.563839]  destroy_unhashed_deleg+0x58/0xc0 [nfsd]
>=20
> We are aware of this failure mode. Actually this started well before
> that particular commit.
>=20
> Our problem has been that no one has been able to provide a reliable
> reproducer, so we can't figure out why it's happening. If you have a
> way to reproduce this failure reliably, can you capture a vmcore or
> enable KASAN and get a little more information?
>=20

It's possible that this crash may be related to the problem that was
fixed here:

    commit 0b3a551fa58b4da941efeb209b3770868e2eddd7
    Author: Jeff Layton <jlayton@kernel.org>
    Date:   Thu Jan 5 14:55:56 2023 -0500

        nfsd: fix handling of cached open files in nfsd4_open codepath
   =20
Unfortunately, that hasn't trickled into v6.1 kernels so far.
--=20
Jeff Layton <jlayton@kernel.org>
