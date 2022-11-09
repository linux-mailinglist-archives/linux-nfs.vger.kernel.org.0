Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA75623207
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Nov 2022 19:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbiKISGc (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Nov 2022 13:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKISGb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Nov 2022 13:06:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19D6FCC2;
        Wed,  9 Nov 2022 10:06:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7352561965;
        Wed,  9 Nov 2022 18:06:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8950C433D6;
        Wed,  9 Nov 2022 18:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668017189;
        bh=def/zwDwIgnLvY6DS4LJlJj5V1RwdIlh0oQC8qKGHvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SPlGxW8qPxcnuMsP4wor+EnBYavO0TH8Bg+DsY3ubPkeaTY7oTcVNgDKhqmFdx1Sy
         2YlFRuuYpuSYdzbLkg9y81/aI+bIFKpbHiYCTzN7BE8qdpwihiLf/sJbBi8AddpTRl
         Kv5p42m/t1Lq7mysiUvaD6AngIDScJrge7TnrmMwyNMU5f0FYlWgS/VHNXv3ZrOcji
         uW4w2r8UzN/WeOfa+L5sqYQ2kC/HTyLDryAOUM2VXfeAo9AhphR2h+0VNHpROvAfg+
         c2PoNOG8TdtYVIbPDf2zwd3UTWyY6IDpzsMGVXfF9UnmPzXdLqVtKXV0CVe4ZX/JQJ
         p3PzkA93X2wOw==
Date:   Wed, 9 Nov 2022 10:06:29 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Filipe Manana <fdmanana@kernel.org>
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Zorro Lang <zlang@redhat.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>,
        "djwong@vger.kernel.org" <djwong@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: generic/650 makes v6.0-rc client unusable
Message-ID: <Y2vsJc1CKuUNzGID@magnolia>
References: <3E21DFEA-8DF7-484B-8122-D578BFF7F9E0@oracle.com>
 <20220904131553.bqdsfbfhmdpuujd3@zlang-mailbox>
 <20221109041951.wlgxac3buutvettq@shindev>
 <CAL3q7H5eV9Sb1axmNgvcbG7UrgGTH3AovaibQuWMz44Jfo-8_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL3q7H5eV9Sb1axmNgvcbG7UrgGTH3AovaibQuWMz44Jfo-8_w@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Nov 09, 2022 at 10:36:04AM +0000, Filipe Manana wrote:
> On Wed, Nov 9, 2022 at 4:22 AM Shinichiro Kawasaki
> <shinichiro.kawasaki@wdc.com> wrote:
> >
> > On Sep 04, 2022 / 21:15, Zorro Lang wrote:
> > > On Sat, Sep 03, 2022 at 06:43:29PM +0000, Chuck Lever III wrote:
> > > > While investigating some of the other issues that have been
> > > > reported lately, I've found that my v6.0-rc3 NFS/TCP client
> > > > goes off the rails often (but not always) during generic/650.
> > > >
> > > > This is the test that runs a workload while offlining and
> > > > onlining CPUs. My test client has 12 physical cores.
> > > >
> > > > The test appears to start normally, but then after a bit
> > > > the NFS server workload drops to zero and the NFS mount
> > > > disappears. I can't run programs (sudo, for example) on
> > > > the client. Can't log in, even on the console. The console
> > > > has a constant stream of "can't rotate log: Input/Output
> > > > error" type messages.
> >
> > I also observe this failure when I ran fstests using btrfs on my HDDs.
> > The failure is recreated almost always.
> 
> I'm wondering what do you get in dmesg, any traces?
> 
> I've excluded the test from my runs for over an year now, due to some
> crash that I reported
> to the mm and cpu hotplug people here:
> 
> https://lore.kernel.org/linux-mm/CAL3q7H4AyrZ5erimDyO7mOVeppd5BeMw3CS=wGbzrMZrp56ktA@mail.gmail.com/
> 
> Unfortunately I had no reply from anyone who works or maintains those
> subsystems.
> 
> It didn't happen very often, and I haven't tested again with recent kernels.

I've been testing with xfs/btrfs/ext4 nightly, and haven't seen any
problems with the last two.  There's some very infrequent log accounting
problem that is probably a regression from Dave's recent round of log
refactorings, so once we're clear of the write race corruption problem,
I intend to inquire about that.

Granted I also don't have hundreds-of-cpus machines to test this kind of
stuff, so I don't know how well hotplug mania fares on a big iron.

I don't think it's valid to remove a test from the auto group because it
uncovers bugs.  If test runner folks want to put it in their own exclude
lists for their own convenience, that's fine with me.

--D

> >
> > > >
> > > > I haven't looked further into this yet. Actually I'm not
> > > > quite sure where to start looking.
> > > >
> > > > I recently switched this client from a local /home to an
> > > > NFS-mounted one, and that's where the xfstests are built
> > > > and run from, fwiw.
> > >
> > > If most of users complain generic/650, I'd like to exclude g/650 from the
> > > "auto" default run group. Any more points?
> >
> > +1. I wish to remove it from the "auto" group. Since I can not login to the test
> > machine after the failure, I suggest to put it in the "dangerous" group.
> >
> > --
> > Shin'ichiro Kawasaki
