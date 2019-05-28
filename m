Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8FC2C978
	for <lists+linux-nfs@lfdr.de>; Tue, 28 May 2019 17:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfE1PEO (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 May 2019 11:04:14 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38629 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbfE1PEL (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 May 2019 11:04:11 -0400
Received: by mail-wm1-f66.google.com with SMTP id t5so3259847wmh.3
        for <linux-nfs@vger.kernel.org>; Tue, 28 May 2019 08:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BO6qcCIdVItRgnFAIO4UpEDugeGgaAhJvK0LG/yEDE4=;
        b=Sw0n5z6g10H0RGh63kgjMTMdKy7BpefCkuDasZXqku0IJAZ4YZ0OTeqElsUlZCVQjg
         APNHurluZY8Lu0id21UNr8d23JuESW62csrrzXeQ447N07E1qpihzVE/hc4vddO+HHjI
         SRqxugwYpuhxXlNXLmkYRHUvZBupfStOYUQZRgqsvYQs0bgii0jIe+4/1j0hI4OzSXwc
         V4dAFRtaX6cuXTNsDI9/dAy42HXUFL/kJLIM1aY4f8dwo2Mf9WHIMJVto5sdCrPneat8
         hJJicETzXKQethqT9dRkRL80bfsv15/hafnImMWforgRpQ0+3Hy/99/0PRT/Jx2cMtKN
         m/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BO6qcCIdVItRgnFAIO4UpEDugeGgaAhJvK0LG/yEDE4=;
        b=VEMp8h7HzskU/WUyWdY5moo8VmtUaZidfHjrlyySjOdNF6cwBSJ3V3Rz0wgrtldywo
         RK9pquEsB45lwlP4U6ldEbb+98NGyy9RAjPdBUeELdWDdJAYtFajOiOZ0ktMxLjEIPn5
         /RYv6/Q9B5q2HnVXs7VehJMn0YklbFZvKafp+Gvo+5bBSN8JqSyuAXbdsptK8yHIQV/e
         MaOg0GKvI9xgWtFkk+bTn1mJ8u0D573z38OWelbV/pQ8K701JLhUm1N7NxgSe5k4p6BG
         TwuBFcWF/sGHJ4TVO9lREeH1hhrbDQTlWlTCWXHeZgSGYxRyqF7UlXwvLHV3zBpk5GCX
         dIXA==
X-Gm-Message-State: APjAAAV9RLFOfiEw1zvsbC2+uH5gY6kZURZtZ1PAHPM7TuP61vnD0KZ1
        50p2gu5WDVZaLcC5Kid1fvXvtUxHq25PvjCKlV6WZw==
X-Google-Smtp-Source: APXvYqzcjI5noeJQqLLrOZhH5ke+p8d56g+o6Q7QbjePlaH6QIH8II18V9Uf5GOGPfS77vExz2X88nfCrqBI9PaNe/s=
X-Received: by 2002:a1c:407:: with SMTP id 7mr3047282wme.113.1559055849508;
 Tue, 28 May 2019 08:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190524192238.20719-1-olga.kornievskaia@gmail.com>
 <ef3dcdc241d4b729c5b4aea51ff85cc62e319cb6.camel@hammerspace.com> <CAN-5tyGVw8=P+2ED1LCoZbkTagYHjv0KYKkOWWEWL0SXJJuLWg@mail.gmail.com>
In-Reply-To: <CAN-5tyGVw8=P+2ED1LCoZbkTagYHjv0KYKkOWWEWL0SXJJuLWg@mail.gmail.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Tue, 28 May 2019 11:03:57 -0400
Message-ID: <CAN-5tyGrwCXa1WO1qiv6P66=7bNtJ5f0BznqoK=f5fG=sf4mUA@mail.gmail.com>
Subject: Re: [PATCH 1/1] SUNRPC: don't retry a gss destroy rpc if task was killed
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, May 28, 2019 at 10:36 AM Olga Kornievskaia
<olga.kornievskaia@gmail.com> wrote:
>
> On Sat, May 25, 2019 at 11:40 AM Trond Myklebust
> <trondmy@hammerspace.com> wrote:
> >
> > On Fri, 2019-05-24 at 15:22 -0400, Olga Kornievskaia wrote:
> > > From: Olga Kornievskaia <kolga@netapp.com>
> > >
> > > It's possible that on an umount we send a NULL call to destroy
> > > a gss context and a failure occurs on the reply. Since it's possible
> > > that in that case the rpc client and auth structure are going away
> > > don't retry. Otherwise, the kernel hits the following oops.
> > >
> > > [37247.291617] BUG: unable to handle kernel NULL pointer dereference
> > > at 0000000000000098
> > > [37247.296200] #PF error: [normal kernel read fault]
> > > [37247.298110] PGD 0 P4D 0
> > > [37247.299264] Oops: 0000 [#1] SMP PTI
> > > [37247.300729] CPU: 1 PID: 23870 Comm: kworker/u256:1 Not tainted
> > > 5.1.0+ #172
> > > [37247.303547] Hardware name: VMware, Inc. VMware Virtual
> > > Platform/440BX Desktop Reference Platform, BIOS 6.00 04/13/2018
> > > [37247.311770] Workqueue: rpciod rpc_async_schedule [sunrpc]
> > > [37247.313958] RIP: 0010:xprt_adjust_timeout+0x9/0x110 [sunrpc]
> > > [37247.316220] Code: c7 c7 20 0d 50 c0 31 c0 e8 68 00 e2 fc 41 c7 45
> > > 04 f4 ff ff ff eb c9 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 41
> > > 54 55 53 <48> 8b 87 98 00 00 00 48 89 fb 4c 8b 27 48 8b 80 a8 00 00
> > > 00
> > > 48 8b
> > > [37247.323625] RSP: 0018:ffffb0ab84f5fd68 EFLAGS: 00010207
> > > [37247.325676] RAX: 00000000fffffff5 RBX: ffff9e0ff1042800 RCX:
> > > 0000000000000003
> > > [37247.328433] RDX: ffff9e0ff11baac0 RSI: 00000000fffffe01 RDI:
> > > 0000000000000000
> > > [37247.331206] RBP: ffff9e0fe20cb200 R08: ffff9e0ff11baac0 R09:
> > > ffff9e0ff11baac0
> > > [37247.334038] R10: ffff9e0ff11baab8 R11: 0000000000000003 R12:
> > > ffff9e1039b55050
> > > [37247.337098] R13: ffff9e0ff1042830 R14: 0000000000000000 R15:
> > > 0000000000000001
> > > [37247.339966] FS:  0000000000000000(0000) GS:ffff9e103bc40000(0000)
> > > knlGS:0000000000000000
> > > [37247.343261] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > [37247.345669] CR2: 0000000000000098 CR3: 000000007603a002 CR4:
> > > 00000000001606e0
> > > [37247.348564] Call Trace:
> > > [37247.351034]  rpc_check_timeout+0x1d/0x140 [sunrpc]
> > > [37247.353005]  call_decode+0x13e/0x1f0 [sunrpc]
> > > [37247.354893]  ? rpc_check_timeout+0x140/0x140 [sunrpc]
> > > [37247.357143]  __rpc_execute+0x7e/0x3d0 [sunrpc]
> > > [37247.359104]  rpc_async_schedule+0x29/0x40 [sunrpc]
> > > [37247.362565]  process_one_work+0x16b/0x370
> > > [37247.365598]  worker_thread+0x49/0x3f0
> > > [37247.367164]  kthread+0xf5/0x130
> > > [37247.368453]  ? max_active_store+0x80/0x80
> > > [37247.370087]  ? kthread_bind+0x10/0x10
> > > [37247.372505]  ret_from_fork+0x1f/0x30
> > > [37247.374695] Modules linked in: nfsv3 cts rpcsec_gss_krb5 nfsv4
> > > dns_resolver nfs rfcomm fuse ip6t_rpfilter ipt_REJECT nf_reject_ipv4
> > > ip6t_REJECT nf_reject_ipv6 xt_conntrack nf_conntrack nf_defrag_ipv6
> > > nf_defrag_ipv4 ebtable_nat ebtable_broute bridge stp llc
> > > ip6table_mangle ip6table_security ip6table_raw iptable_mangle
> > > iptable_security iptable_raw ebtable_filter ebtables ip6table_filter
> > > ip6_tables iptable_filter bnep snd_seq_midi snd_seq_midi_event
> > > crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel
> > > crypto_simd cryptd glue_helper vmw_balloon snd_ens1371 snd_ac97_codec
> > > uvcvideo ac97_bus snd_seq pcspkr btusb btrtl btbcm videobuf2_vmalloc
> > > snd_pcm videobuf2_memops btintel videobuf2_v4l2 videodev bluetooth
> > > snd_timer snd_rawmidi vmw_vmci snd_seq_device rfkill videobuf2_common
> > > snd ecdh_generic i2c_piix4 soundcore nfsd nfs_acl lockd auth_rpcgss
> > > grace sunrpc ip_tables xfs libcrc32c sr_mod cdrom sd_mod ata_generic
> > > pata_acpi vmwgfx drm_kms_helper syscopyarea sysfillrect sysimgblt
> > > fb_sys_fops
> > > [37247.389774]  ttm crc32c_intel drm serio_raw ahci ata_piix libahci
> > > libata mptspi scsi_transport_spi e1000 mptscsih mptbase i2c_core
> > > dm_mirror dm_region_hash dm_log dm_mod
> > > [37247.437859] CR2: 0000000000000098
> > > [37247.462263] ---[ end trace 0d9a85f0df2cef9e ]---
> > >
> > > Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
> > > ---
> > >  net/sunrpc/clnt.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
> > > index 8ff11dc..8928f93 100644
> > > --- a/net/sunrpc/clnt.c
> > > +++ b/net/sunrpc/clnt.c
> > > @@ -2487,7 +2487,7 @@ void rpc_force_rebind(struct rpc_clnt *clnt)
> > >
> > >  out_garbage:
> > >       clnt->cl_stats->rpcgarbage++;
> > > -     if (task->tk_garb_retry) {
> > > +     if (task->tk_garb_retry && !(task->tk_flags & RPC_TASK_KILLED))
> > > {
> > >               task->tk_garb_retry--;
> > >               task->tk_action = call_encode;
> > >               return -EAGAIN;
> > > @@ -2541,7 +2541,7 @@ void rpc_force_rebind(struct rpc_clnt *clnt)
> > >       case rpc_autherr_badcred:
> > >       case rpc_autherr_badverf:
> > >               /* possibly garbled cred/verf? */
> > > -             if (!task->tk_garb_retry)
> > > +             if (!task->tk_garb_retry || task->tk_flags &
> > > RPC_TASK_KILLED)
> > >                       break;
> > >               task->tk_garb_retry--;
> > >               trace_rpc__bad_creds(task);
> >
> >
> > Hmm... The RPC_TASK_KILLED flag was changed in 5.2-rc1 in order to try
> > to fix a few atomicity issues with it, so the above patch will not
> > apply to the current codebase.
> >
> > The new behaviour will actually check the new flag in __rpc_execute()
> > itself (see the check of RPC_SIGNALLED()). I'd therefore be very
> > interested to see if the bug is still reproducible with the newest 5.2-
> > rcX.
>
> With 5.2-rcX, the umount hangs (but on the plus side it doesn't oops).

Also to clarify, this is generic (sec) umount that hangs (not even
using the bad verifier trigger).

>
> >
> > --
> > Trond Myklebust
> > Linux NFS client maintainer, Hammerspace
> > trond.myklebust@hammerspace.com
> >
> >
