Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46F7EBD10E
	for <lists+linux-nfs@lfdr.de>; Tue, 24 Sep 2019 19:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730857AbfIXRzt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Sep 2019 13:55:49 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46261 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727969AbfIXRzt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Sep 2019 13:55:49 -0400
Received: by mail-lf1-f65.google.com with SMTP id t8so2081755lfc.13
        for <linux-nfs@vger.kernel.org>; Tue, 24 Sep 2019 10:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/r1Ox1HaUNEqtVgrmFb1/GGjtNfzbbc4+q0M4VudREo=;
        b=N1uc+TgblCkDknoajsOMb4SZCnbSainEtZu7hCTMQZnbluTMxdBYvcvmT9G4i8hfQN
         t1ggQffkYtkeaBTezsqOOjKuZfmHk45k3inXjKTi1oRqHAwgphn7g7yqX4IFnUiKDkut
         RrosWfAzluCxeebdEYgyjW5JPti0vZF4FVpdD5eK7SUhBzwBsDPvePqcekO2NDBFnvp3
         o/dcMQTwuD2a/7cOwG45eGIhd5Ca3IvsvgMcjoqOYYTjf0UV2zcplMHZTFYQn6nbsUv9
         uH2xQ8bMtPeFLOlhqvfs7yv6UHrsLjU4/BalxR1ATXHaSfgrUGbOK9qX5LEEzLuPJ2JT
         WmXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/r1Ox1HaUNEqtVgrmFb1/GGjtNfzbbc4+q0M4VudREo=;
        b=HB7jC9tG00P5Tas1R2oK34mLtShpvZ+rlhez5CW5dWMfo7ZBVkEDYNqhKGspFYVO2N
         TSafUIraukQ69eC9d7U9b6IOT2u3P2BAcaQT2jlfgS5dVMMlxsQFHhvb1y0i0pt3xHyj
         Zs441KmL0lg7ny7oXFehbJHYNCud5Vl/LPg2rwOhmUhplbxfFvTLrlQY86B3liJrzaPl
         5XVjQsWun2YSOyiE2uUF+hdF48NSQESuBcd3pUejst6Fvh5TWuVCx17/v6T25L224WFt
         weP9ORnmDu5Ciszp7OyIlb3iWxwoGbX5xYtTYElk3hiloRYYHCqQYx0qyVvKmsDkRvTg
         U0Ww==
X-Gm-Message-State: APjAAAX6gb4Op3CUxbnyTahwhRsfwrX63mQWiqixdEoG5wltjhaSwClB
        AyiV2Z88CDuIAoPmfuYEKS+xM54KsZ+Wcy6Cm3KusQ==
X-Google-Smtp-Source: APXvYqyRuJn3gRCKEVFwyujDwDqG/FW1jOsR5O1fKRf0rNBhQwHbxuv776nK2xHyjobXU6QuDR7uU+sOr0+wH6Ac6LQ=
X-Received: by 2002:a05:6512:512:: with SMTP id o18mr2747198lfb.153.1569347746105;
 Tue, 24 Sep 2019 10:55:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:534c:0:0:0:0:0 with HTTP; Tue, 24 Sep 2019 10:55:45
 -0700 (PDT)
X-Originating-IP: [162.243.96.244]
In-Reply-To: <CADyTPEwUjbV3icj7YD1a5fgzE_t0fpF0Mj9v-fLKywPwKki+Mg@mail.gmail.com>
References: <CADyTPExOnxS+FS6Uqoxu3jNWRy93SQri4Xo1+00aiiVru8XDkg@mail.gmail.com>
 <c573ebd9d835e2bf2d2b2a4dcb682b6d913b0c5e.camel@hammerspace.com> <CADyTPEwUjbV3icj7YD1a5fgzE_t0fpF0Mj9v-fLKywPwKki+Mg@mail.gmail.com>
From:   Nick Bowler <nbowler@draconx.ca>
Date:   Tue, 24 Sep 2019 13:55:45 -0400
Message-ID: <CADyTPExGSaUdzyyHGv1f26N4SX_mvdB7qiKp4bKcewW3DLG93w@mail.gmail.com>
Subject: Re: PROBLEM: nfs? crash in Linux 5.3 (possible regression)
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 9/20/19, Nick Bowler <nbowler@draconx.ca> wrote:
> On 9/20/19, Trond Myklebust <trondmy@hammerspace.com> wrote:
>> On Fri, 2019-09-20 at 14:23 -0400, Nick Bowler wrote:
>>> Not sure how reproducible this is.  Since I've never seen a crash
>>> like this before it may be a regression compared to, say, Linux 4.19
>>> but I am not certain because this particular machine is brand new so
>>> I don't have experience with older kernels on it...
>
> So it actually seems pretty reliably reproducible, 4 attempts to compile
> Linux on Linux 5.3 and all four crash the same way, although there's
> definitely some randomness here...
>
> On the other hand, I cannot reproduce if I install Linux 5.2 so it does
> seem like a regression in 5.3.  I will see how well bisecting goes...

Not well I guess?  I'm not sure what it's doing but for some reason git
bisect does not seem to be converging towards any solution.  I run for
several hours before marking 'good' and it only seems to be reducing the
'# of revisions left to test' by a tiny amount, not the ~half like
I'd expect so bleh...

Any ideas what could be wrong?  Hints on how to reproduce faster?

git bisect start
# bad: [4d856f72c10ecb060868ed10ff1b1453943fc6c8] Linux 5.3
git bisect bad 4d856f72c10ecb060868ed10ff1b1453943fc6c8
# good: [0ecfebd2b52404ae0c54a878c872bb93363ada36] Linux 5.2
git bisect good 0ecfebd2b52404ae0c54a878c872bb93363ada36
# skip: [c236b6dd48dcf2ae6ed14b9068830eccc3e181e6] Merge tag
'keys-request-20190626' of
git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs
git bisect skip c236b6dd48dcf2ae6ed14b9068830eccc3e181e6
# skip: [028db3e290f15ac509084c0fc3b9d021f668f877] Revert "Merge tag
'keys-acl-20190703' of
git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs"
git bisect skip 028db3e290f15ac509084c0fc3b9d021f668f877
# bad: [002c5f73c508f7df5681bda339831c27f3c1aef4] KVM: x86/mmu:
Reintroduce fast invalidate/zap for flushing memslot
git bisect bad 002c5f73c508f7df5681bda339831c27f3c1aef4
# bad: [d3464ccd105b42f87302572ee1f097e6e0b432c6] Merge tag
'dmaengine-fix-5.3' of git://git.infradead.org/users/vkoul/slave-dma
git bisect bad d3464ccd105b42f87302572ee1f097e6e0b432c6
# bad: [0445971000375859008414f87e7c72fa0d809cf8] Merge tag
'mmc-v5.3-rc7' of
git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc
git bisect bad 0445971000375859008414f87e7c72fa0d809cf8
# bad: [046ddeed0461b5d270470c253cbb321103d048b6] KVM: Check
preempted_in_kernel for involuntary preemption
git bisect bad 046ddeed0461b5d270470c253cbb321103d048b6
# skip: [8f6ccf6159aed1f04c6d179f61f6fb2691261e84] Merge tag
'clone3-v5.3' of
git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux
git bisect skip 8f6ccf6159aed1f04c6d179f61f6fb2691261e84
# good: [d84f6269ce24eb4c468e246b24fc0fdce34ab6f6] crypto: ccree -
check that cryptocell reset completed
git bisect good d84f6269ce24eb4c468e246b24fc0fdce34ab6f6
# good: [5f92229d184b80712a8b94d098318960171ae749] ASoC: mxs:
mxs-sgtl5000: don't select unnecessary Platform
git bisect good 5f92229d184b80712a8b94d098318960171ae749
# good: [a2928d28643e3c064ff41397281d20c445525032] r8169: use paged
versions of phylib MDIO access functions
git bisect good a2928d28643e3c064ff41397281d20c445525032
# good: [1b2fc358ddfb1b0915922e441182cda7043f5116] perf tools: Add
missing util.h to pick up 'page_size' variable
git bisect good 1b2fc358ddfb1b0915922e441182cda7043f5116
# good: [a011b49f4ed7813777a15da12a426ab939c58f14] net/mlx5e: Consider
XSK in XDP MTU limit calculation
git bisect good a011b49f4ed7813777a15da12a426ab939c58f14
# good: [89a237aa84c7047cafba99f5dc81983ed0c40704] staging: kpc2000:
Use '%llx' for printing 'long long int' type
git bisect good 89a237aa84c7047cafba99f5dc81983ed0c40704
# good: [60e8523e2ea18dc0c0cea69d6c1d69a065019062] ocxl: Allow
contexts to be attached with a NULL mm
git bisect good 60e8523e2ea18dc0c0cea69d6c1d69a065019062
# good: [452181936931f0f08923aba5e04e1e9ef58c389f] afs: Trace afs_server usage
git bisect good 452181936931f0f08923aba5e04e1e9ef58c389f
# good: [78ff751f8e6a9446e9fb26b2bff0b8d3f8974cbd] scsi: mac_scsi: Fix
pseudo DMA implementation, take 2
git bisect good 78ff751f8e6a9446e9fb26b2bff0b8d3f8974cbd
# good: [5315f9d40191f98abcd3164e632a8a8f737b1cf0] rtlwifi: remove
redundant assignment to variable badworden
git bisect good 5315f9d40191f98abcd3164e632a8a8f737b1cf0
# good: [65dc5416d4e02d80ce140078c7c1f4e6c8400396] Merge tag
'batadv-next-for-davem-20190627v2' of
git://git.open-mesh.org/linux-merge
git bisect good 65dc5416d4e02d80ce140078c7c1f4e6c8400396
# skip: [0248a8be6d21dad72b9ce80a7565cf13c11509d8] Merge tag
'gfs2-for-5.3' of
git://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2
git bisect skip 0248a8be6d21dad72b9ce80a7565cf13c11509d8
# good: [aa0bfcd939c30617385ffa28682c062d78050eba] mm: add
filemap_fdatawait_range_keep_errors()
git bisect good aa0bfcd939c30617385ffa28682c062d78050eba
# good: [15a98fb2fc287bbfe430e854d56dcfc86eae21db] media:
dvb_frontend: split dvb_frontend_handle_ioctl function
git bisect good 15a98fb2fc287bbfe430e854d56dcfc86eae21db
# good: [d17adf7d3f5be74bdfda89ceed7bff3910ffb6d4] regulator:
max77802: Drop unused includes
git bisect good d17adf7d3f5be74bdfda89ceed7bff3910ffb6d4

>>> [  796.050025] BUG: kernel NULL pointer dereference, address:
>>> 0000000000000014
>>> [  796.051280] #PF: supervisor read access in kernel mode
>>> [  796.053063] #PF: error_code(0x0000) - not-present page
>>> [  796.054636] PGD 0 P4D 0
>>> [  796.055688] Oops: 0000 [#1] PREEMPT SMP
>>> [  796.056768] CPU: 2 PID: 190 Comm: kworker/2:2 Tainted: G        W
>>>       5.3.0 #6
>>> [  796.057953] Hardware name: To Be Filled By O.E.M. To Be Filled By
>>> O.E.M./B450 Gaming-ITX/ac, BIOS P3.30 05/17/2019
>>> [  796.059329] Workqueue: events key_garbage_collector
>>> [  796.060623] RIP: 0010:keyring_gc_check_iterator+0x27/0x30
>>
>> That would be the keyring garbage collector, not NFS.
>>
>> Cced keyrings@vger.kernel.org
>>
>>
>>> [  796.061845] Code: 44 00 00 48 83 e7 fc b8 01 00 00 00 f6 87 80 00
>>> 00 00 21 75 19 48 8b 57 58 48 39 16 7c 05 48 85 d2 7f 0b 48 8b 87 a0
>>> 00 00 00 <0f> b6 40 14 c3 0f 1f 40 00 48 83 e7 fc e9 27 eb ff ff 0f
>>> 1f
>>> 80 00
>>> [  796.064638] RSP: 0018:ffffb40fc0757df8 EFLAGS: 00010282
>>> [  796.066058] RAX: 0000000000000000 RBX: ffffa14338caed80 RCX:
>>> ffffb40fc0757e40
>>> [  796.067531] RDX: ffffa1433ae85558 RSI: ffffb40fc0757e40 RDI:
>>> ffffa1433ae85500
>>> [  796.069014] RBP: ffffb40fc0757e40 R08: 0000000000000000 R09:
>>> 000000000000000f
>>> [  796.070513] R10: 8080808080808080 R11: 0000000000000001 R12:
>>> ffffffffa4cd6180
>>> [  796.072025] R13: ffffa14338caee10 R14: ffffa14338caedf0 R15:
>>> ffffa1433ffeff00
>>> [  796.073567] FS:  0000000000000000(0000) GS:ffffa14340480000(0000)
>>> knlGS:0000000000000000
>>> [  796.075171] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [  796.076785] CR2: 0000000000000014 CR3: 0000000747ce6000 CR4:
>>> 00000000003406e0
>>> [  796.078445] Call Trace:
>>> [  796.080091]  assoc_array_subtree_iterate+0x55/0x100
>>> [  796.081770]  keyring_gc+0x3f/0x80
>>> [  796.083447]  key_garbage_collector+0x330/0x3d0
>>> [  796.085155]  process_one_work+0x1cb/0x320
>>> [  796.086869]  worker_thread+0x28/0x3c0
>>> [  796.088603]  ? process_one_work+0x320/0x320
>>> [  796.090335]  kthread+0x106/0x120
>>> [  796.092053]  ? kthread_create_on_node+0x40/0x40
>>> [  796.093810]  ret_from_fork+0x1f/0x30
>>> [  796.095569] Modules linked in: sha1_ssse3 sha1_generic cbc cts
>>> rpcsec_gss_krb5 auth_rpcgss nfsv4 nfs lockd grace ext4 crc16 mbcache
>>> jbd2 iwlmvm mac80211 libarc4 amdgpu iwlwifi snd_hda_codec_realtek
>>> snd_hda_codec_generic kvm_amd gpu_sched kvm snd_hda_codec_hdmi
>>> drm_kms_helper irqbypass k10temp syscopyarea sysfillrect sysimgblt
>>> fb_sys_fops video ttm cfg80211 snd_hda_intel snd_hda_codec drm
>>> snd_hwdep rfkill snd_hda_core backlight snd_pcm evdev snd_timer snd
>>> soundcore efivarfs dm_crypt hid_generic igb hwmon i2c_algo_bit sr_mod
>>> cdrom sunrpc dm_mod
>>> [  796.104033] CR2: 0000000000000014
>>> [  796.106304] ---[ end trace 695aee10f9202347 ]---
>>> [  796.108585] RIP: 0010:keyring_gc_check_iterator+0x27/0x30
>>> [  796.110894] Code: 44 00 00 48 83 e7 fc b8 01 00 00 00 f6 87 80 00
>>> 00 00 21 75 19 48 8b 57 58 48 39 16 7c 05 48 85 d2 7f 0b 48 8b 87 a0
>>> 00 00 00 <0f> b6 40 14 c3 0f 1f 40 00 48 83 e7 fc e9 27 eb ff ff 0f
>>> 1f
>>> 80 00
>>> [  796.115773] RSP: 0018:ffffb40fc0757df8 EFLAGS: 00010282
>>> [  796.118209] RAX: 0000000000000000 RBX: ffffa14338caed80 RCX:
>>> ffffb40fc0757e40
>>> [  796.120683] RDX: ffffa1433ae85558 RSI: ffffb40fc0757e40 RDI:
>>> ffffa1433ae85500
>>> [  796.123176] RBP: ffffb40fc0757e40 R08: 0000000000000000 R09:
>>> 000000000000000f
>>> [  796.125668] R10: 8080808080808080 R11: 0000000000000001 R12:
>>> ffffffffa4cd6180
>>> [  796.128104] R13: ffffa14338caee10 R14: ffffa14338caedf0 R15:
>>> ffffa1433ffeff00
>>> [  796.130493] FS:  0000000000000000(0000) GS:ffffa14340480000(0000)
>>> knlGS:0000000000000000
>>> [  796.132923] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>> [  796.135266] CR2: 0000000000000014 CR3: 0000000747ce6000 CR4:
>>> 00000000003406e0
