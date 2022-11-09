Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09A4622890
	for <lists+linux-nfs@lfdr.de>; Wed,  9 Nov 2022 11:36:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiKIKgp (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 9 Nov 2022 05:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbiKIKgn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 9 Nov 2022 05:36:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D962C19C15;
        Wed,  9 Nov 2022 02:36:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 675E46190F;
        Wed,  9 Nov 2022 10:36:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD062C433D6;
        Wed,  9 Nov 2022 10:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667990201;
        bh=EZN+bucgSCncTbUChCqJU3pLyG23nkFP4VgBICU1Bro=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WWgbHNbZOPbmab1+kb94N0AOYgPwHiZTFtqeJZAc36pkSD15ZcyWf+qPnkkHi+zHx
         5D0J5yCH/FPR0RG9UTX8p1YOLC0CUtE31rZrIViTSdvXl9s1pnF7D+PjGOllRW5Yqy
         OMp0973M4DinvvfJd28wf9nM/Gm7cjWhPc3jCCP9PA/mmPPF92Q7gr99FIgn+4oaFe
         fMdXZzeqIDuKyxFFYxlNO/uaZrOxXllsffinAImWyD5MTykb9j/0umdQRHoHN8w6Hq
         TooZeNpio8+bJU0XWLsR++e/W1/bGuKdq9CeaO4jlrAMDDojeAVo706TtXRrOzsOly
         MJJtuB3ipq12Q==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-13ae8117023so19160333fac.9;
        Wed, 09 Nov 2022 02:36:41 -0800 (PST)
X-Gm-Message-State: ACrzQf3yS1T3zhTL18DfLcDYecldPuZTzZn+01UgDSa/4oAEGTRlKnoI
        iKZeU8JFUWpZYZOd1t7Uu6ihifPR5HFFemVP7iY=
X-Google-Smtp-Source: AMsMyM4N+KhWKZerEhlVcbom9YLzJ1VSJWSTjKt/pg1gK7cgcpMBY8qJlVPTddlprhevGiKxkK3I86bQs6VfA+viujM=
X-Received: by 2002:a05:6870:2052:b0:132:7b2:2fe6 with SMTP id
 l18-20020a056870205200b0013207b22fe6mr35805370oad.98.1667990200947; Wed, 09
 Nov 2022 02:36:40 -0800 (PST)
MIME-Version: 1.0
References: <3E21DFEA-8DF7-484B-8122-D578BFF7F9E0@oracle.com>
 <20220904131553.bqdsfbfhmdpuujd3@zlang-mailbox> <20221109041951.wlgxac3buutvettq@shindev>
In-Reply-To: <20221109041951.wlgxac3buutvettq@shindev>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Wed, 9 Nov 2022 10:36:04 +0000
X-Gmail-Original-Message-ID: <CAL3q7H5eV9Sb1axmNgvcbG7UrgGTH3AovaibQuWMz44Jfo-8_w@mail.gmail.com>
Message-ID: <CAL3q7H5eV9Sb1axmNgvcbG7UrgGTH3AovaibQuWMz44Jfo-8_w@mail.gmail.com>
Subject: Re: generic/650 makes v6.0-rc client unusable
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Zorro Lang <zlang@redhat.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Chuck Lever III <chuck.lever@oracle.com>,
        "djwong@vger.kernel.org" <djwong@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Nov 9, 2022 at 4:22 AM Shinichiro Kawasaki
<shinichiro.kawasaki@wdc.com> wrote:
>
> On Sep 04, 2022 / 21:15, Zorro Lang wrote:
> > On Sat, Sep 03, 2022 at 06:43:29PM +0000, Chuck Lever III wrote:
> > > While investigating some of the other issues that have been
> > > reported lately, I've found that my v6.0-rc3 NFS/TCP client
> > > goes off the rails often (but not always) during generic/650.
> > >
> > > This is the test that runs a workload while offlining and
> > > onlining CPUs. My test client has 12 physical cores.
> > >
> > > The test appears to start normally, but then after a bit
> > > the NFS server workload drops to zero and the NFS mount
> > > disappears. I can't run programs (sudo, for example) on
> > > the client. Can't log in, even on the console. The console
> > > has a constant stream of "can't rotate log: Input/Output
> > > error" type messages.
>
> I also observe this failure when I ran fstests using btrfs on my HDDs.
> The failure is recreated almost always.

I'm wondering what do you get in dmesg, any traces?

I've excluded the test from my runs for over an year now, due to some
crash that I reported
to the mm and cpu hotplug people here:

https://lore.kernel.org/linux-mm/CAL3q7H4AyrZ5erimDyO7mOVeppd5BeMw3CS=wGbzrMZrp56ktA@mail.gmail.com/

Unfortunately I had no reply from anyone who works or maintains those
subsystems.

It didn't happen very often, and I haven't tested again with recent kernels.

>
> > >
> > > I haven't looked further into this yet. Actually I'm not
> > > quite sure where to start looking.
> > >
> > > I recently switched this client from a local /home to an
> > > NFS-mounted one, and that's where the xfstests are built
> > > and run from, fwiw.
> >
> > If most of users complain generic/650, I'd like to exclude g/650 from the
> > "auto" default run group. Any more points?
>
> +1. I wish to remove it from the "auto" group. Since I can not login to the test
> machine after the failure, I suggest to put it in the "dangerous" group.
>
> --
> Shin'ichiro Kawasaki
