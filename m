Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B63328E88F
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Oct 2020 23:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726662AbgJNVsn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Oct 2020 17:48:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59920 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726528AbgJNVsn (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 14 Oct 2020 17:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602712121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KVkXJTajGvIg/sHF6e9YElubXcRpAa6HR1TI2ztyg0s=;
        b=ITGH2NXEJo5JfeSUdMybWr3O+ICVeV+fsFJB58/gRO9IhuthoHFrDdN0FcX1KnyVSV1SWZ
        IvnweS4V3Ac59eeh8HAUuXmZ8/D+hLZrTWYnuRiSKarp5fcLaX5hnKIZ9x+kMNiyzAtGE6
        oHTzGn8Xwjg6LTpAMWG9vg+y4FZm6E0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-dqtaV7uOO2S_GWkxUXnuLA-1; Wed, 14 Oct 2020 17:48:39 -0400
X-MC-Unique: dqtaV7uOO2S_GWkxUXnuLA-1
Received: by mail-ej1-f70.google.com with SMTP id b17so264652ejb.20
        for <linux-nfs@vger.kernel.org>; Wed, 14 Oct 2020 14:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KVkXJTajGvIg/sHF6e9YElubXcRpAa6HR1TI2ztyg0s=;
        b=F1kzun/t/CjVNmq1ifg/yVefaeAO2q7+RSo+FS5F+5Mhsn1o75c1aDxPPDhx2HgxWW
         8kCtmFuGhmIQ0Hdz2zljVfNUJl0nsaNiXjJGW/xIdsXQe8ang5LFhfwXyY9NcYeIzzgv
         sEKvaX+OK06S8SkfwBoUL6rzKyTIjQJflhEPTPqGIXOj3djY10oYPwe8yckcwY/ombcs
         i9xh3lWili+O5wIvUboOCtX3m86op2CPuUPITDl+HtwmGfLzwsQUEb+BZmxETaPHacta
         ry+5jKqT4nTH/aKvoslwhu8PR0EHGpzzKJ+C7VoAOm21LfL467wVVCJS6qoZEe95hfrW
         S+kA==
X-Gm-Message-State: AOAM5329hqe7wnWEDcj8mhWuPH6AU2hMKGtgUCqAG6LOuP9xuNWcUXaf
        0kRE9D3RVVGN+Wg3PGkTaaaM4OXsowkwLH25hUCgnVdq8xfrWvoYxRorh9K31g7MiRgaK8jJZcO
        g/Ma5xjJWBsVS07o0wQL2uSOUVDhXpgmvn+Qh
X-Received: by 2002:a17:906:564d:: with SMTP id v13mr1210092ejr.217.1602712117688;
        Wed, 14 Oct 2020 14:48:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyOY1lbB5XHlMv2p7ktBRyjewzZmo6LeaxGMXP2gYQR38kOI0IeZzuAEgsPy7R6c0yPUE3opAf4avj2BrR9aU=
X-Received: by 2002:a17:906:564d:: with SMTP id v13mr1210077ejr.217.1602712117430;
 Wed, 14 Oct 2020 14:48:37 -0700 (PDT)
MIME-Version: 1.0
References: <959e2a4790849c226b0967ecda11f79e@talpidae.net>
 <CALF+zOnDa4cN5MKFtzKKKyyCaTZ8XM=Q_9sLhsTRK4ZM1_pfzw@mail.gmail.com> <646585853425598fd04612ab63ff4331@talpidae.net>
In-Reply-To: <646585853425598fd04612ab63ff4331@talpidae.net>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Wed, 14 Oct 2020 17:48:00 -0400
Message-ID: <CALF+zOnH9OJBy=bFbjrNtofROZxE_QS2siGRFF_KbpASbZ99vA@mail.gmail.com>
Subject: Re: Linux 5.9.0: NFS 4.1 with cachefilesd: Assertion failed (100% CPU)
To:     Jonas Zeiger <jonas.zeiger@talpidae.net>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Yep that matches the known issue.  If you apply Takashi's patch here
and rebuild, you should be good:
https://bugzilla.kernel.org/show_bug.cgi?id=208883#c5

On Wed, Oct 14, 2020 at 5:13 PM Jonas Zeiger <jonas.zeiger@talpidae.net> wrote:
>
> Hi David,
>
> root@host:/usr/src/linux-5.9# eu-addr2line -e ./vmlinux cachefiles_read_or_alloc_pages+0x9e
> fs/cachefiles/rdwr.c:715
>
> Thank you for looking into it!
>
> -Jonas
>
> On 2020-10-14 18:43, David Wysochanski wrote:
> > On Wed, Oct 14, 2020 at 9:13 AM Jonas Zeiger <jonas.zeiger@talpidae.net> wrote:
> >>
> >> Hi all,
> >>
> >> I experience failed assertions on an x86_64 KVM virtual machine (VirtIO devices) when accessing files on NFS 4 shares while having cachefilesd (0.10.7) running.
> >>
> >> Good kernel: 4.14.49
> >> Bad kernels: 5.8.14, 5.9.0
> >>
> >> The machine is rendered unusable (100% CPU) and requires a hard-reset.
> >>
> >> This is the console error report captured via serial console:
> >>
> >> CacheFiles:
> >> CacheFiles: Assertion failed
> >> invalid opcode: 0000 [#1]
> >> CPU: 0 PID: 4215 Comm: git Not tainted 5.9.0vzlinux #3
> >> RIP: 0010:cachefiles_read_or_alloc_pages+0x9e/0x5cf
> >> Code: ff 0f 0b 49 8b 46 30 48 8b 40 70 48 83 78 20 00 75 1a 48 c7 c7 20 fc e8 81 e8 cf 7a e7 ff 48 c7 c7 30 fc e8 81 e8 c3 7a e7 ff <0f> 0b 49 8b 46 28 ba 0c 00 00 00 c6 44 24 40 00 c6 44 24 41 00 c7
> >
> >
> > Can you do
> >
> > eu-addr2line -e ./vmlinux cachefiles_read_or_alloc_pages+0x9e
> >
> > That should give the line # of the assertion.
> >
> >
> >> RSP: 0000:ffffc900015cba98 EFLAGS: 00010292
> >> RAX: 000000000000001c RBX: ffffc900015cbc04 RCX: 0000000000000027
> >> RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffffffff82039340
> >> RBP: ffff88803c3469c0 R08: 0000000000000000 R09: 0000000000000000
> >> R10: 000000000001e88c R11: 000000000000003c R12: ffffc900015cbd70
> >> R13: ffff88803c3469c0 R14: ffff88802e2d2fd0 R15: ffff88802bf27000
> >> FS:  00007feea1027fc0(0000) GS:ffffffff82030000(0000) knlGS:0000000000000000
> >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> CR2: 00007feea1036000 CR3: 000000002bcbd005 CR4: 00000000001706b0
> >> Call Trace:
> >>  ? nfs_access_add_cache+0x140/0x1c5
> >>  ? slab_free_freelist_hook+0x45/0xc4
> >>  ? slab_pre_alloc_hook.isra.81+0x26/0x37
> >>  ? fscache_run_op.isra.13+0x57/0x69
> >>  __fscache_read_or_alloc_pages+0x1a6/0x1f2
> >>  __nfs_readpages_from_fscache+0x51/0xa9
> >>  nfs_readpages+0x111/0x133
> >>  ? get_page_from_freelist+0x734/0x8a1
> >>  read_pages+0x8c/0x102
> >>  ? __alloc_pages_nodemask+0xd4/0x122
> >>  ? page_cache_readahead_unbounded+0xce/0x17d
> >>  page_cache_readahead_unbounded+0xce/0x17d
> >>  filemap_fault+0x1f9/0x3d8
> >>  __do_fault+0x44/0x63
> >>  handle_mm_fault+0x70e/0xad3
> >>  exc_page_fault+0x1f0/0x311
> >>  ? asm_exc_page_fault+0x5/0x20
> >>  asm_exc_page_fault+0x1b/0x20
> >> RIP: 0033:0x7feea0991bef
> >> Code: 41 c7 45 00 1d 00 00 00 e9 1e f8 ff ff 41 8b 55 08 85 d2 0f 84 72 07 00 00 83 fb 0f 0f 87 37 14 00 00 85 ed 0f 84 83 f5 ff ff <41> 0f b6 34 24 89 d9 8d 45 ff 49 8d 7c 24 01 48 d3 e6 8d 4b 08 4c
> >> RSP: 002b:00007fffbb7d5240 EFLAGS: 00010202
> >> RAX: 00007feea0991bd2 RBX: 0000000000000000 RCX: 00000000000000d0
> >> RDX: 0000000000000001 RSI: 000055d7e1bf9c10 RDI: 00007fffbb7d52a0
> >> RBP: 00000000000000d0 R08: 0000000000000000 R09: 0000000000000000
> >> R10: 0000000000000000 R11: 00007fffbb7d5390 R12: 00007feea1036000
> >> R13: 000055d7e1bf9900 R14: 00007fffbb7d5570 R15: 0000000000000000
> >> ---[ end trace cad4b4a2dd601cdd ]---
> >> RIP: 0010:cachefiles_read_or_alloc_pages+0x9e/0x5cf
> >> Code: ff 0f 0b 49 8b 46 30 48 8b 40 70 48 83 78 20 00 75 1a 48 c7 c7 20 fc e8 81 e8 cf 7a e7 ff 48 c7 c7 30 fc e8 81 e8 c3 7a e7 ff <0f> 0b 49 8b 46 28 ba 0c 00 00 00 c6 44 24 40 00 c6 44 24 41 00 c7
> >> RSP: 0000:ffffc900015cba98 EFLAGS: 00010292
> >> RAX: 000000000000001c RBX: ffffc900015cbc04 RCX: 0000000000000027
> >> RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffffffff82039340
> >> RBP: ffff88803c3469c0 R08: 0000000000000000 R09: 0000000000000000
> >> R10: 000000000001e88c R11: 000000000000003c R12: ffffc900015cbd70
> >> R13: ffff88803c3469c0 R14: ffff88802e2d2fd0 R15: ffff88802bf27000
> >> FS:  00007feea1027fc0(0000) GS:ffffffff82030000(0000) knlGS:0000000000000000
> >> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >> CR2: 00007feea1036000 CR3: 000000002bcbd005 CR4: 00000000001706b0
> >> Kernel panic - not syncing: Fatal exception
> >> Kernel Offset: disabled
> >> ---[ end Kernel panic - not syncing: Fatal exception ]---
> >>
> >> Feel free to ask for further info or testing patches.
> >>
> >> Thank you!
> >>
> >> Regards,
> >> Jonas Zeiger
> >>
> >>
> >> Ps: I found this mail https://lkml.org/lkml/2020/3/20/399 describing a similar issue, but it may be unrelated.
> >>
>

