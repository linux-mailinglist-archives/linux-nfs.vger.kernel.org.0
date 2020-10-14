Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C47028E4B2
	for <lists+linux-nfs@lfdr.de>; Wed, 14 Oct 2020 18:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgJNQoS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 14 Oct 2020 12:44:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36861 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727559AbgJNQoR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 14 Oct 2020 12:44:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602693855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mcYfcXbyIcG5Hh6iRlSH4CyHcqxBdOljCBEFJjUrc2Q=;
        b=JDn5qiHJ5NnlipGIVME2dm1rppEQ7qmsNmXAlvzkKhlpTqA29qdg6EYTzvlC9fKYQOKw05
        b2ZWp4sx3EE4MlZvTvTSH1yF4feBUirKRXKhHRGrLoMPVs/Bl9WIwdJ7M68Qfv2wLaIQLw
        Sf7lkoneMxBdUetK1kLxva0K8gmR9xk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-wq7rM2O_M-qXphfNLaO71A-1; Wed, 14 Oct 2020 12:44:13 -0400
X-MC-Unique: wq7rM2O_M-qXphfNLaO71A-1
Received: by mail-ed1-f72.google.com with SMTP id e14so102865edk.2
        for <linux-nfs@vger.kernel.org>; Wed, 14 Oct 2020 09:44:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mcYfcXbyIcG5Hh6iRlSH4CyHcqxBdOljCBEFJjUrc2Q=;
        b=ia7Xtic4oCQDzXCOcz2+ZiQ7kpe6DLXbUwi7E/fajUzfxtzUjby0xURJhOJ8BMsyrl
         hb08C9CIxX2wbJutZSn0IYanlY5dhhOFNT/kmTrI4RJSfu7JsM+YcuDYKUrr6NC9f8ef
         6ACTsBkqP3ki1m+eQuuyru3L31kclOhXsTfgxcjnWmc0tS/ZDAXGQ6qvWhNC58X02MWi
         pjE8N3rCXYNLbghzg+1Ct7FW+Qkn2EI8sjlsLEvfeWZjP9jZiU7HLMq2rFx71yhS0Mdu
         G83cWrwfIE50cKWPp95ISebMHaYYtwX4opXN9CKxrE3xNsiNNQhJmxfMxlMmaARi30/V
         /5jg==
X-Gm-Message-State: AOAM533YZY8mH9gTQwCH0EeAeGhr1OCDMawS1OMAi6S+Hf91RodFLhj5
        ttGzRCGJq2bWNHYUTE3NtxtvsZFI087cIH41daeIhGO6pG2B4BFMXMa4cAEpQGECNEhhkGZe8Ce
        vnRbRHlgg6wvyc+TRmSZij8GL0i51xPd7T/n2
X-Received: by 2002:aa7:de82:: with SMTP id j2mr6583871edv.3.1602693851610;
        Wed, 14 Oct 2020 09:44:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZr1/TARDpNCnBhkK8IKOSCEMpVFoys8uur0CFQ30TGk0jxLx2yLGpewA6m/lq7cLFDRuaKoAglJYyxo4BOP8=
X-Received: by 2002:aa7:de82:: with SMTP id j2mr6583854edv.3.1602693851373;
 Wed, 14 Oct 2020 09:44:11 -0700 (PDT)
MIME-Version: 1.0
References: <959e2a4790849c226b0967ecda11f79e@talpidae.net>
In-Reply-To: <959e2a4790849c226b0967ecda11f79e@talpidae.net>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Wed, 14 Oct 2020 12:43:35 -0400
Message-ID: <CALF+zOnDa4cN5MKFtzKKKyyCaTZ8XM=Q_9sLhsTRK4ZM1_pfzw@mail.gmail.com>
Subject: Re: Linux 5.9.0: NFS 4.1 with cachefilesd: Assertion failed (100% CPU)
To:     Jonas Zeiger <jonas.zeiger@talpidae.net>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Oct 14, 2020 at 9:13 AM Jonas Zeiger <jonas.zeiger@talpidae.net> wrote:
>
> Hi all,
>
> I experience failed assertions on an x86_64 KVM virtual machine (VirtIO devices) when accessing files on NFS 4 shares while having cachefilesd (0.10.7) running.
>
> Good kernel: 4.14.49
> Bad kernels: 5.8.14, 5.9.0
>
> The machine is rendered unusable (100% CPU) and requires a hard-reset.
>
> This is the console error report captured via serial console:
>
> CacheFiles:
> CacheFiles: Assertion failed
> invalid opcode: 0000 [#1]
> CPU: 0 PID: 4215 Comm: git Not tainted 5.9.0vzlinux #3
> RIP: 0010:cachefiles_read_or_alloc_pages+0x9e/0x5cf
> Code: ff 0f 0b 49 8b 46 30 48 8b 40 70 48 83 78 20 00 75 1a 48 c7 c7 20 fc e8 81 e8 cf 7a e7 ff 48 c7 c7 30 fc e8 81 e8 c3 7a e7 ff <0f> 0b 49 8b 46 28 ba 0c 00 00 00 c6 44 24 40 00 c6 44 24 41 00 c7


Can you do

eu-addr2line -e ./vmlinux cachefiles_read_or_alloc_pages+0x9e

That should give the line # of the assertion.


> RSP: 0000:ffffc900015cba98 EFLAGS: 00010292
> RAX: 000000000000001c RBX: ffffc900015cbc04 RCX: 0000000000000027
> RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffffffff82039340
> RBP: ffff88803c3469c0 R08: 0000000000000000 R09: 0000000000000000
> R10: 000000000001e88c R11: 000000000000003c R12: ffffc900015cbd70
> R13: ffff88803c3469c0 R14: ffff88802e2d2fd0 R15: ffff88802bf27000
> FS:  00007feea1027fc0(0000) GS:ffffffff82030000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007feea1036000 CR3: 000000002bcbd005 CR4: 00000000001706b0
> Call Trace:
>  ? nfs_access_add_cache+0x140/0x1c5
>  ? slab_free_freelist_hook+0x45/0xc4
>  ? slab_pre_alloc_hook.isra.81+0x26/0x37
>  ? fscache_run_op.isra.13+0x57/0x69
>  __fscache_read_or_alloc_pages+0x1a6/0x1f2
>  __nfs_readpages_from_fscache+0x51/0xa9
>  nfs_readpages+0x111/0x133
>  ? get_page_from_freelist+0x734/0x8a1
>  read_pages+0x8c/0x102
>  ? __alloc_pages_nodemask+0xd4/0x122
>  ? page_cache_readahead_unbounded+0xce/0x17d
>  page_cache_readahead_unbounded+0xce/0x17d
>  filemap_fault+0x1f9/0x3d8
>  __do_fault+0x44/0x63
>  handle_mm_fault+0x70e/0xad3
>  exc_page_fault+0x1f0/0x311
>  ? asm_exc_page_fault+0x5/0x20
>  asm_exc_page_fault+0x1b/0x20
> RIP: 0033:0x7feea0991bef
> Code: 41 c7 45 00 1d 00 00 00 e9 1e f8 ff ff 41 8b 55 08 85 d2 0f 84 72 07 00 00 83 fb 0f 0f 87 37 14 00 00 85 ed 0f 84 83 f5 ff ff <41> 0f b6 34 24 89 d9 8d 45 ff 49 8d 7c 24 01 48 d3 e6 8d 4b 08 4c
> RSP: 002b:00007fffbb7d5240 EFLAGS: 00010202
> RAX: 00007feea0991bd2 RBX: 0000000000000000 RCX: 00000000000000d0
> RDX: 0000000000000001 RSI: 000055d7e1bf9c10 RDI: 00007fffbb7d52a0
> RBP: 00000000000000d0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 00007fffbb7d5390 R12: 00007feea1036000
> R13: 000055d7e1bf9900 R14: 00007fffbb7d5570 R15: 0000000000000000
> ---[ end trace cad4b4a2dd601cdd ]---
> RIP: 0010:cachefiles_read_or_alloc_pages+0x9e/0x5cf
> Code: ff 0f 0b 49 8b 46 30 48 8b 40 70 48 83 78 20 00 75 1a 48 c7 c7 20 fc e8 81 e8 cf 7a e7 ff 48 c7 c7 30 fc e8 81 e8 c3 7a e7 ff <0f> 0b 49 8b 46 28 ba 0c 00 00 00 c6 44 24 40 00 c6 44 24 41 00 c7
> RSP: 0000:ffffc900015cba98 EFLAGS: 00010292
> RAX: 000000000000001c RBX: ffffc900015cbc04 RCX: 0000000000000027
> RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffffffff82039340
> RBP: ffff88803c3469c0 R08: 0000000000000000 R09: 0000000000000000
> R10: 000000000001e88c R11: 000000000000003c R12: ffffc900015cbd70
> R13: ffff88803c3469c0 R14: ffff88802e2d2fd0 R15: ffff88802bf27000
> FS:  00007feea1027fc0(0000) GS:ffffffff82030000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007feea1036000 CR3: 000000002bcbd005 CR4: 00000000001706b0
> Kernel panic - not syncing: Fatal exception
> Kernel Offset: disabled
> ---[ end Kernel panic - not syncing: Fatal exception ]---
>
> Feel free to ask for further info or testing patches.
>
> Thank you!
>
> Regards,
> Jonas Zeiger
>
>
> Ps: I found this mail https://lkml.org/lkml/2020/3/20/399 describing a similar issue, but it may be unrelated.
>

