Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F7BC2CD891
	for <lists+linux-nfs@lfdr.de>; Thu,  3 Dec 2020 15:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729965AbgLCOIt (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 3 Dec 2020 09:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728727AbgLCOIs (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 3 Dec 2020 09:08:48 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28141C061A51
        for <linux-nfs@vger.kernel.org>; Thu,  3 Dec 2020 06:08:08 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id cw27so2215860edb.5
        for <linux-nfs@vger.kernel.org>; Thu, 03 Dec 2020 06:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=maAh6CQQmEXTrSkmcbKxtL5NzoOIAeVLgomiRebxWno=;
        b=SODl8WDXGpsAYOKsuWpexF2+JA9rMLwIvCJXRouQHUP4nFYgZv76ObFUmeWbBKrK/T
         JPVJUYRfaoEWMxiw5DLe1PUlzFvFC5Prc8pSUM79O1Meai7ac/AzQm8nLc4dQ+28h6bE
         uMalKdCUtKxbssQps6I9OYTrll+s6S+MRp4G6YgIpIvxIqIPXdekXrBOu0HpBjuTtUwg
         RiQM2IWz9zdF7buJbWZm8nDnX4/9vZqB2fOvbsJGo72Em5+JESrLvu4WMVJOqWqMnLtJ
         pIashAIYumXogolN2HPu3XqNf7e92bGdW4HTxG8SvDTIMNCBRrn2WKSfHKUF9pkwwStg
         e4PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=maAh6CQQmEXTrSkmcbKxtL5NzoOIAeVLgomiRebxWno=;
        b=WTLzhuz0E1ckLsq4CBq115KyaKR/oYy8N2y8HoEIvVF073vfTKghhruhh59eEgyULt
         xWE9QOXpfuuQGCrxOqrQQGrPyr2Vl2GNnB0GZjUCI3U1erMzt1A2a6eqn7v8QPv0dwur
         TO/cmC7/ScPqLaRigMhnxs38omlD+9+ufP5s0yqkuYdntoGL5pndtonY4d7bLk4CVWPv
         PJGc8vFEMhXJQo4PbD3TxAukFRfvyPec/Rdu3vDMH1cGI63nORzibdTXJVHsfStBidie
         AxYW75ollan0yteAYb5Ox888sJiSYMrMPvMVkHZ7RRcLVioqjCg7S3B6ewPZ7Cm360OR
         B7pA==
X-Gm-Message-State: AOAM530kLoEhaWZy0GlTfNWz8okjvFyAkXEtL2ADfDMl0b9EKe66wfkx
        i9OsddlWSHRC/brZF2jNs/S+pHlVgZazFxw0BNmliih+VOs=
X-Google-Smtp-Source: ABdhPJxOlslgOh+iO5W9jhLS2gpfiO6e2uUwjuUzv+zLUAEWR6h4CHUof60w3Q7AQ+4wFLdqopS0FF7q+9F7WsCz2Bk=
X-Received: by 2002:a50:e68a:: with SMTP id z10mr2967260edm.28.1607004486501;
 Thu, 03 Dec 2020 06:08:06 -0800 (PST)
MIME-Version: 1.0
References: <2137763922.1852883.1606983653611.JavaMail.zimbra@desy.de>
In-Reply-To: <2137763922.1852883.1606983653611.JavaMail.zimbra@desy.de>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 3 Dec 2020 09:07:55 -0500
Message-ID: <CAN-5tyEWYqXiqLdJE-DLH2b+LrVfPkviJDGQY=MyitS5aW4bJw@mail.gmail.com>
Subject: Re: Kernel OPS when using xattr
To:     "Mkrtchyan, Tigran" <tigran.mkrtchyan@desy.de>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>,
        trondmy <trondmy@hammerspace.com>,
        Frank van der Linden <fllinden@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Dec 3, 2020 at 3:22 AM Mkrtchyan, Tigran
<tigran.mkrtchyan@desy.de> wrote:
>
>
> Dear NFS folk,
>
> this is I got while accessing xattrs over NFS with 5.10.0-rc6 kernel
> from Trond's testing tree (8102e956f22e710eecb3913cdd236282213812cf).
> The 5.9 kernel works as expected.

Is that with Frank's getxattr patch?
https://www.spinics.net/lists/linux-nfs/msg81183.html

>
> Tigran.
>
> [ 2803.765467] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Regi=
stering...
> [59837.811426] general protection fault, probably for non-canonical addre=
ss 0x5088000000ffc: 0000 [#1] SMP PTI
> [59837.811433] CPU: 3 PID: 3858 Comm: attr Not tainted 5.10.0-rc6+ #60
> [59837.811435] Hardware name: Dell Inc. Latitude E6520/0J4TFW, BIOS A06 0=
7/11/2011
> [59837.811442] RIP: 0010:__memmove+0xe2/0x1a0
> [59837.811445] Code: 1f 84 00 00 00 00 00 90 48 83 fa 20 72 50 48 81 fa a=
8 02 00 00 72 05 40 38 fe 74 bc 48 01 d6 48 01 d7 48 83 ea 20 48 83 ea 20 <=
4c> 8b 5e f8 4c 8b 56 f0 4c 8b 4e e8 4c 8b 46 e0 48 8d 76 e0 4c 89
> [59837.811447] RSP: 0018:ffffc90002b4f870 EFLAGS: 00010202
> [59837.811451] RAX: 0005088000000004 RBX: 0000000000000000 RCX: 000000000=
000fffc
> [59837.811453] RDX: 0000000000000fbc RSI: 0005088000000ffc RDI: 000508800=
0001000
> [59837.811455] RBP: ffff88810be80000 R08: 0005088000000ffc R09: ffff88823=
5aec550
> [59837.811457] R10: 0000000000000356 R11: 000000000000016c R12: 000000000=
0000004
> [59837.811459] R13: 000000000000fffc R14: ffff88810be80000 R15: ffffc9000=
2b4fc58
> [59837.811462] FS:  00007fd9303ff740(0000) GS:ffff888235ac0000(0000) knlG=
S:0000000000000000
> [59837.811465] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [59837.811467] CR2: 00007fd9305d2000 CR3: 000000011fc10005 CR4: 000000000=
00606e0
> [59837.811469] Call Trace:
> [59837.811505]  _shift_data_right_pages+0x11e/0x150 [sunrpc]
> [59837.811531]  xdr_shrink_bufhead+0x151/0x170 [sunrpc]
> [59837.811555]  xdr_realign_pages+0x4c/0xa0 [sunrpc]
> [59837.811578]  xdr_align_pages+0x49/0x120 [sunrpc]
> [59837.811601]  xdr_read_pages+0x23/0xb0 [sunrpc]
> [59837.811626]  nfs4_xdr_dec_getxattr+0xfa/0x120 [nfsv4]
> [59837.811643]  call_decode+0x199/0x1f0 [sunrpc]
> [59837.811659]  ? rpc_decode_header+0x4e0/0x4e0 [sunrpc]
> [59837.811678]  __rpc_execute+0x71/0x420 [sunrpc]
> [59837.811700]  ? xprt_iter_default_rewind+0x10/0x10 [sunrpc]
> [59837.811721]  ? xprt_iter_get_next+0x4a/0x60 [sunrpc]
> [59837.811737]  rpc_run_task+0x14c/0x180 [sunrpc]
> [59837.811756]  nfs4_do_call_sync+0x6e/0xb0 [nfsv4]
> [59837.811785]  _nfs42_proc_getxattr+0xb7/0x170 [nfsv4]
> [59837.811809]  ? xprt_iter_get_next+0x4a/0x60 [sunrpc]
> [59837.811830]  nfs42_proc_getxattr+0x86/0xb0 [nfsv4]
> [59837.811844]  nfs4_xattr_get_nfs4_user+0xc9/0xe0 [nfsv4]
> [59837.811849]  vfs_getxattr+0x161/0x1a0
> [59837.811852]  getxattr+0x14f/0x230
> [59837.811856]  ? filename_lookup+0x123/0x1b0
> [59837.811861]  ? _cond_resched+0x16/0x40
> [59837.811864]  ? kmem_cache_alloc+0x3c4/0x4b0
> [59837.811866]  ? getname_flags.part.0+0x45/0x1a0
> [59837.811869]  path_getxattr+0x62/0xb0
> [59837.811873]  do_syscall_64+0x33/0x40
> [59837.811876]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [59837.811879] RIP: 0033:0x7fd93050162e
> [59837.811883] Code: 48 8b 0d 4d 48 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 6=
6 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 c0 00 00 00 0f 05 <=
48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 1a 48 0c 00 f7 d8 64 89 01 48
> [59837.811884] RSP: 002b:00007ffe178ad1c8 EFLAGS: 00000202 ORIG_RAX: 0000=
0000000000c0
> [59837.811887] RAX: ffffffffffffffda RBX: 00007ffe178ad330 RCX: 00007fd93=
050162e
> [59837.811889] RDX: 0000000000000000 RSI: 00007ffe178ad330 RDI: 00007ffe1=
78bf525
> [59837.811890] RBP: 0000000000000000 R08: 00007ffe178ad210 R09: 000000000=
0000000
> [59837.811892] R10: 0000000000000000 R11: 0000000000000202 R12: 000000000=
0000001
> [59837.811894] R13: 00007ffe178ad210 R14: 00007ffe178bf525 R15: 000000000=
0000000
> [59837.811896] Modules linked in: nfs_layout_flexfiles rpcsec_gss_krb5 au=
th_rpcgss nfsv4 dns_resolver nfs lockd grace nfs_ssc fscache nf_conntrack_n=
etbios_ns nf_conntrack_broadcast nft_ct nf_tables ebtable_nat ebtable_brout=
e ip6table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat n=
f_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_mangle iptable_raw=
 iptable_security ip_set nfnetlink ebtable_filter ebtables ip6table_filter =
ip6_tables sunrpc snd_hda_codec_idt snd_hda_codec_generic ledtrig_audio nou=
veau i915 iwldvm mac80211 btrfs snd_hda_codec_hdmi snd_hda_intel snd_intel_=
ds
