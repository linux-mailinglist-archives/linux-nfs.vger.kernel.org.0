Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14A9619CD27
	for <lists+linux-nfs@lfdr.de>; Fri,  3 Apr 2020 00:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389425AbgDBWwm (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 Apr 2020 18:52:42 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37529 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387919AbgDBWwm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 2 Apr 2020 18:52:42 -0400
Received: by mail-wm1-f67.google.com with SMTP id j19so5616816wmi.2
        for <linux-nfs@vger.kernel.org>; Thu, 02 Apr 2020 15:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=n+e1/GaIbbAVa0H1IU6BhjwSlT1cNtqChu9AM8R4knw=;
        b=Gefv/2mSJegvxTwNBiCJl6JNRLrEOnXVs5mfotun6cQ0++3yygCfauJc2ZgkvwHTeI
         85zxclGcjmN6sXyfbxZszCAs9Mbf+Ipur+VQ4rUwAjBDr5WLB00w70U+B8RMOnNXXkn6
         w+UxrRoZ8qIQ7D8XThMSbLTsPyqgX5kv0jEyOK/ziKz3T60p8Eep8V0TXmaYR5smMkF0
         xGgHP/EcYZCc0eIobbqTnMzRJGHJKaakPQS/yr7oWX+3C0y6ZLkCv3AV/AiJh2SdDmQo
         o7mJgMm8FS8VS4kM0BR6FcqcBEKHLn1+CueKVYFXtFnVOcBOD/5T33Samd8us2fqSXcu
         4E3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n+e1/GaIbbAVa0H1IU6BhjwSlT1cNtqChu9AM8R4knw=;
        b=OVCEfe3Rrc6/VE275gOnth/nnE4Mz0KSWfbM0qO/ngt0clRjN6HFOcP/X/whMJva9z
         iWETqRCHEImKJjNWzqFzmdHllsDt0iqs+WG/09xdF68OsTJ625smaGP+8oMnZTJjxW4a
         ok+hKjIQnTkB9evVqxPirftCrdHrA5wmbgSSTfYLpjxUyg6B1lmttzyrkLXJWS8EQMiZ
         1yE0dDFB4ykgT69hGYomOxvprYmtyN5a96zk6FbpaQwqCXwpcSWMkGtDIVM1o4FrWKo6
         MLWXzxygvdxEhPM5W5rcOeEoXjLwepixqiNP9NtDGjEuqxf6Y//OSd8t4wt6L6qE/16c
         KjpQ==
X-Gm-Message-State: AGi0Pua4UhjlZ/7fqDcJouhHd/ltybSfCL7+aAaN2cTW5K4pZtnF3Kz8
        l7HIsxe8xpIgifQOkz2VzWVqubJ2ZU5509PdMLU=
X-Google-Smtp-Source: APiQypItR2X8vbckdMpiOYrk6hFYLbsvfanbsBzZAha2EWWWI+BSEmUecOAdGhVDtxMxsn993iLJ4ck7Hxhfqci4zbA=
X-Received: by 2002:a1c:6608:: with SMTP id a8mr5419608wmc.113.1585867959842;
 Thu, 02 Apr 2020 15:52:39 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyEdabKDZLRJ1kSF2-epLGKwMX5s76OLgQMPOy5ccXFRbQ@mail.gmail.com>
 <2a088f5f4a25ce3ee548b0e32ae2c181ef90b98e.camel@hammerspace.com> <20200402211844.GA4386@aion.usersys.redhat.com>
In-Reply-To: <20200402211844.GA4386@aion.usersys.redhat.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Thu, 2 Apr 2020 18:52:28 -0400
Message-ID: <CAN-5tyHNFGibLmcwjsxQybENmPk=_8gsyEfXv9mG61VAhEH5+Q@mail.gmail.com>
Subject: Re: oops in 5.6-rc
To:     Scott Mayhew <smayhew@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Apr 2, 2020 at 5:18 PM Scott Mayhew <smayhew@redhat.com> wrote:
>
> On Thu, 02 Apr 2020, Trond Myklebust wrote:
>
> > On Thu, 2020-04-02 at 12:41 -0400, Olga Kornievskaia wrote:
> > > Is this known ops, reproducible 100% with garbage args to mount:
> > > mount -o vers=4.0,sec=shs <serverip>:/<mount> /mnt
> > > My kernel is commit: 0fecfcb9d4d2803079048df7946019463544414e
> > > I haven't bisets but seems to be a recent. My 5.5 kernel works.
> > >
> > > localhost login: [  103.982099] BUG: unable to handle page fault for
> > > address: 0000000000020000
> > > [  103.987970] #PF: supervisor read access in kernel mode
> > > [  103.990835] #PF: error_code(0x0000) - not-present page
> > > [  103.993721] PGD 0 P4D 0
> > > [  103.995291] Oops: 0000 [#1] SMP PTI
> > > [  103.997256] CPU: 0 PID: 3059 Comm: mount.nfs Not tainted 5.6.0-
> > > rc5+ #295
> > > [  104.000946] Hardware name: VMware, Inc. VMware Virtual
> > > Platform/440BX Desktop Reference Platform, BIOS 6.00 04/13/2018
> > > [  104.007360] RIP: 0010:strcmp+0xc/0x30
> > > [  104.009416] Code: 75 f7 48 83 c6 01 0f b6 4e ff 48 83 c2 01 84 c9
> > > 88 4a ff 75 ed f3 c3 0f 1f 80 00 00 00 00 48 83 c7 01 0f b6 47 ff 48
> > > 83 c6 01 <3a> 46 ff 75 07 84 c0 75 eb 31 c0 c3 19 c0 83 c8 01 0f 1f
> > > 00
> > > c3 0f
> > > [  104.019756] RSP: 0018:ffffc2a0c2207d50 EFLAGS: 00010202
> > > [  104.022659] RAX: 0000000000000073 RBX: ffffffffc0a4f1d0 RCX:
> > > 0000000000000000
> > > [  104.026742] RDX: 00000000ffffffff RSI: 0000000000020001 RDI:
> > > ffff9ffcabf71df9
> > > [  104.031161] RBP: ffff9ffcabf71df8 R08: 0000000000000000 R09:
> > > ffff9ffcabf71dfb
> > > [  104.035410] R10: 000000000000003a R11: 657261687373666e R12:
> > > ffff9ffcabf71df8
> > > [  104.039755] R13: ffffc2a0c2207d80 R14: ffff9ffc22037834 R15:
> > > 0000000000000020
> > > [  104.044001] FS:  00007f8735790880(0000) GS:ffff9ffcb9e00000(0000)
> > > knlGS:0000000000000000
> > > [  104.048952] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [  104.053260] CR: 0000000000020000 CR3: 0000000135210001 CR4:
> > > 00000000001606f0
> > > [  104.057233] Call Trace:
> > > [  104.058646]  __lookup_constant+0x2b/0x40
> > > [  104.060839]  lookup_constant+0xd/0x20
> > > [  104.062928]  nfs_fs_context_parse_param+0x1e9/0x920 [nfs]
> > > [  104.065989]  vfs_parse_fs_param+0xd3/0x190
> > > [  104.068303]  vfs_parse_fs_string+0x75/0xb0
> > > [  104.070590]  generic_parse_monolithic+0x8f/0xc0
> > > [  104.073155]  nfs_fs_context_parse_monolithic+0x22b/0x670 [nfs]
> > > [  104.076437]  do_mount+0x626/0x970
> > > [  104.078655]  __x64_sys_mount+0x86/0xd0
> > > [  104.081118]  do_syscall_64+0x55/0x1f0
> > > [  104.083592]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > > [  104.086903] RIP: 0033:0x7f8734e57aaa
> > > [  104.089072] Code: 48 8b 0d e1 33 2c 00 f7 d8 64 89 01 48 83 c8 ff
> > > c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00
> > > 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ae 33 2c 00 f7 d8 64
> > > 89
> > > 01 48
> > > [  104.099612] RSP: 002b:00007ffe33f17ba8 EFLAGS: 00000246 ORIG_RAX:
> > > 00000000000000a5
> > > [  104.103917] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
> > > 00007f8734e57aaa
> > > [  104.107913] RDX: 000056270a7cb260 RSI: 000056270a7cb240 RDI:
> > > 000056270a7cb280
> > > [  104.111876] RBP: 00007ffe33f17d20 R08: 000056270a7cb7c0 R09:
> > > 000000000000003b
> > > [  104.115864] R10: 0000000000000000 R11: 0000000000000246 R12:
> > > 00007ffe33f17d20
> > > [  104.119811] R13: 000056270a7cb520 R14: 0000000000000010 R15:
> > > 00007ffe33f17c30
> > > [  104.124019] Modules linked in: nfs rfcomm fuse bridge stp llc
> > > ip6t_rpfilter ipt_REJECT nf_reject_ipv4 ip6t_REJECT nf_reject_ipv6
> > > xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ebtable_nat
> > > ebtable_broute ip6table_mangle ip6table_security ip6table_raw
> > > iptable_mangle iptable_security iptable_raw ebtable_filter ebtables
> > > ip6table_filter ip6_tables iptable_filter bnep snd_seq_midi
> > > snd_seq_midi_event crct10dif_pclmul crc32_pclmul ghash_clmulni_intel
> > > btusb btrtl btbcm btintel bluetooth snd_ens1371 uvcvideo
> > > snd_ac97_codec aesni_intel ac97_bus glue_helper snd_seq crypto_simd
> > > cryptd videobuf2_vmalloc videobuf2_memops snd_pcm videobuf2_v4l2
> > > vmw_balloon videodev vmw_vmci snd_timer snd_rawmidi pcspkr
> > > snd_seq_device snd videobuf2_common rfkill ecdh_generic i2c_piix4 ecc
> > > soundcore nfsd nfs_acl lockd auth_rpcgss grace sunrpc ip_tables xfs
> > > libcrc32c vmwgfx sr_mod sd_mod cdrom t10_pi ata_generic pata_acpi
> > > drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm drm
> > > ahci libahci ata_piix
> > > [  104.124052]  libata e1000 mptspi scsi_transport_spi i2c_core
> > > mptscsih crc32c_intel mptbase serio_raw dm_mirror dm_region_hash
> > > dm_log dm_mod
> > > [  104.190925] CR2: 0000000000020000
> > > [  104.192989] ---[ end trace 870843230151cfc0 ]---
> >
> > That is the mount code rewrite that went into 5.6.
>
> Doh!  Patch incoming.

Thanks Scott  :-)

>
> -Scott
> >
> > --
> > Trond Myklebust
> > Linux NFS client maintainer, Hammerspace
> > trond.myklebust@hammerspace.com
> >
> >
>
