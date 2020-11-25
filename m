Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF442C42C5
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Nov 2020 16:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730107AbgKYPUb (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Nov 2020 10:20:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33249 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729738AbgKYPUb (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Nov 2020 10:20:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606317628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=aS8HKgbFeBC2ZienKeiDC5TAWtYZ1gaJR91j/zUs7zc=;
        b=XjgaEB4YhQg3HzwfMHpJXUkTvdW4F6ovQljOQW1UxIkvUWwVhrebQCIhsV3kCl9Y2PvK9Y
        qwdUNwIlkfnIblq8y4Wl+bNKCCjamE2Psk9vda2qBBys6yHL8++oqdXrWcuP7NhTAVHXsr
        z1o7BeLHHw6mKd+PGLOiTf/qrDrU2dU=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-ox32ccxCOG-cBfFSQG8mbg-1; Wed, 25 Nov 2020 10:20:26 -0500
X-MC-Unique: ox32ccxCOG-cBfFSQG8mbg-1
Received: by mail-ej1-f70.google.com with SMTP id gx12so851308ejb.18
        for <linux-nfs@vger.kernel.org>; Wed, 25 Nov 2020 07:20:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aS8HKgbFeBC2ZienKeiDC5TAWtYZ1gaJR91j/zUs7zc=;
        b=mgN8HF3tZGmLNd3lcKFfNNMHtIiZZeFg638FWYuSDgw4ecRQsp5GkyINxFZ4/y8KCD
         X/DRV/OOES0LSe7m+/Dk4aBApGR1Z9sFqC5YP+b8rkz9oiKrnlUFABiCjMcPJeS20w1n
         bL0+wIRsAem4vv5TUOMy3L7vTF3nlIM8UkW0lm7O89suFub+Q2bGdsdct3/QtYRnodMS
         MiEAF6qkhAyAEM1seLvycZB4KeVejBNVFz93ebdmspkYG3D5iXHek00D9vl74QFAb1b7
         IPvlxgVrfBFM9NKW3tXKdA3u+fwWfGSRU7d4pRGecrzVbMwjJ/X55pi9K9cJDVtw0EKr
         LAEA==
X-Gm-Message-State: AOAM531xuxaZT/Q+5XTlNAzhO2GS1hAyZy9c2LL9LG49eubGBzXPyB0u
        L+kPvDNWEvJpZhlQsGdvqez5iR1BcxDQabwoNXHdU1qrFu3U+PmagEEEGaybvlc6ZIjun4etwJQ
        mlB149FQLn9puKHO0tzS6Ykzg3P+kqIARsYWz
X-Received: by 2002:a17:906:2f87:: with SMTP id w7mr3625786eji.83.1606317622191;
        Wed, 25 Nov 2020 07:20:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx1Z2bS4ZKe09aclLr43XG6vlCW+Kj0lVWyVTNrmaqvTu7S3wMZLt6An9FWHZOeOAuyZvNcugUfYgbHko0OQ5E=
X-Received: by 2002:a17:906:2f87:: with SMTP id w7mr3625590eji.83.1606317615521;
 Wed, 25 Nov 2020 07:20:15 -0800 (PST)
MIME-Version: 1.0
References: <CALF+zOntimx8nyiAUyN5Y58T9_-PztLpUU2vpYgOzQkcK7C09w@mail.gmail.com>
 <4f3a2c0de91ff3117ada740cc9b1a22eabb1375d.camel@hammerspace.com>
 <CALF+zOkEWrpo=NKL2ncoierFRKmsLqG56qKdsOHBC1k79Yqxhw@mail.gmail.com>
 <6c158409f81a82c6176d1c7156e229051a98f9b2.camel@hammerspace.com>
 <CALF+zOnYbN2VghyB+Kj_YcBc_dCdVB6FTdQ+affrAWV6BKqtRw@mail.gmail.com> <4e7d645996294262c738a05a3c2707aa20424f79.camel@hammerspace.com>
In-Reply-To: <4e7d645996294262c738a05a3c2707aa20424f79.camel@hammerspace.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Wed, 25 Nov 2020 10:19:39 -0500
Message-ID: <CALF+zOmYk6Mk19mj5rfmqRuydEBZ-EecFBrUYsznS3CH41Gbdw@mail.gmail.com>
Subject: Re: NFS failure with generic/074 when lockdep is enabled - BUG:
 Invalid wait context
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Nov 24, 2020 at 8:47 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Tue, 2020-11-24 at 20:43 -0500, David Wysochanski wrote:
> > On Tue, Nov 24, 2020 at 8:33 PM Trond Myklebust
> > <trondmy@hammerspace.com> wrote:
> > >
> > > On Tue, 2020-11-24 at 20:28 -0500, David Wysochanski wrote:
> > > > On Tue, Nov 24, 2020 at 8:07 PM Trond Myklebust <
> > > > trondmy@hammerspace.com> wrote:
> > > > >
> > > > > On Tue, 2020-11-24 at 16:56 -0500, David Wysochanski wrote:
> > > > > > I've started seeing this failure since testing 5.10-rc4 -
> > > > > > this
> > > > > > does
> > > > > > not happen on 5.9
> > > > > >
> > > > > >
> > > > > > f31-node1 login: [  124.055768] FS-Cache: Netfs 'nfs'
> > > > > > registered
> > > > > > for
> > > > > > caching
> > > > > > [  125.046104] Key type dns_resolver registered
> > > > > > [  125.770354] NFS: Registering the id_resolver key type
> > > > > > [  125.780599] Key type id_resolver registered
> > > > > > [  125.782440] Key type id_legacy registered
> > > > > > [  126.563717] run fstests generic/074 at 2020-11-24 11:23:49
> > > > > > [  178.736479]
> > > > > > [  178.751380] =============================
> > > > > > [  178.753249] [ BUG: Invalid wait context ]
> > > > > > [  178.754886] 5.10.0-rc4 #127 Not tainted
> > > > > > [  178.756423] -----------------------------
> > > > > > [  178.758055] kworker/1:2/848 is trying to lock:
> > > > > > [  178.759866] ffff8947fffd33d8 (&zone->lock){..-.}-{3:3},
> > > > > > at:
> > > > > > get_page_from_freelist+0x897/0x2190
> > > > > > [  178.763333] other info that might help us debug this:
> > > > > > [  178.765354] context-{5:5}
> > > > > > [  178.766437] 3 locks held by kworker/1:2/848:
> > > > > > [  178.768158]  #0: ffff8946ce825538
> > > > > > ((wq_completion)nfsiod){+.+.}-{0:0}, at:
> > > > > > process_one_work+0x1be/0x540
> > > > > > [  178.771871]  #1: ffff9e6b408f7e58
> > > > > > ((work_completion)(&task->u.tk_work)#2){+.+.}-{0:0}, at:
> > > > > > process_one_work+0x1be/0x540
> > > > > > [  178.776562]  #2: ffff8947f7c5b2b0 (krc.lock){..-.}-{2:2},
> > > > > > at:
> > > > > > kvfree_call_rcu+0x69/0x230
> > > > > > [  178.779803] stack backtrace:
> > > > > > [  178.780996] CPU: 1 PID: 848 Comm: kworker/1:2 Kdump:
> > > > > > loaded
> > > > > > Not
> > > > > > tainted 5.10.0-rc4 #127
> > > > > > [  178.784374] Hardware name: Red Hat KVM, BIOS 0.5.1
> > > > > > 01/01/2011
> > > > > > [  178.787071] Workqueue: nfsiod rpc_async_release [sunrpc]
> > > > > > [  178.789308] Call Trace:
> > > > > > [  178.790386]  dump_stack+0x8d/0xb5
> > > > > > [  178.791816]  __lock_acquire.cold+0x20b/0x2c8
> > > > > > [  178.793605]  lock_acquire+0xca/0x380
> > > > > > [  178.795113]  ? get_page_from_freelist+0x897/0x2190
> > > > > > [  178.797116]  _raw_spin_lock+0x2c/0x40
> > > > > > [  178.798638]  ? get_page_from_freelist+0x897/0x2190
> > > > > > [  178.800620]  get_page_from_freelist+0x897/0x2190
> > > > > > [  178.802537]  __alloc_pages_nodemask+0x1b4/0x460
> > > > > > [  178.804416]  __get_free_pages+0xd/0x30
> > > > > > [  178.805987]  kvfree_call_rcu+0x168/0x230
> > > > > > [  178.807687]  nfs_free_request+0xab/0x180 [nfs]
> > > > > > [  178.809547]  nfs_page_group_destroy+0x41/0x80 [nfs]
> > > > > > [  178.811588]  nfs_read_completion+0x129/0x1f0 [nfs]
> > > > > > [  178.813633]  rpc_free_task+0x39/0x60 [sunrpc]
> > > > > > [  178.815481]  rpc_async_release+0x29/0x40 [sunrpc]
> > > > > > [  178.817451]  process_one_work+0x23e/0x540
> > > > > > [  178.819136]  worker_thread+0x50/0x3a0
> > > > > > [  178.820657]  ? process_one_work+0x540/0x540
> > > > > > [  178.822427]  kthread+0x10f/0x150
> > > > > > [  178.823805]  ? kthread_park+0x90/0x90
> > > > > > [  178.825339]  ret_from_fork+0x22/0x30
> > > > > >
> > > > >
> > > > > I can't think of any changes that might have caused this. Is
> > > > > this
> > > > > NFSv3, v4 or other? I haven't been seeing any of this.
> > > > >
> > > >
> > > > It is NFSv4.1 or NFS4.2.  I am running the xfstests NFS client
> > > > against
> > > > an older server, RHEL7 based (3.10.0-1127.8.2.el7.x86_64) though
> > > > not
> > > > sure if that matters.
> > > > My config has these:
> > > > CONFIG_LOCK_DEBUGGING_SUPPORT=y
> > > > CONFIG_PROVE_LOCKING=y
> > > > CONFIG_PROVE_RAW_LOCK_NESTING=y
> > > > CONFIG_DEBUG_SPINLOCK=y
> > > > CONFIG_DEBUG_LOCK_ALLOC=y
> > > > CONFIG_LOCKDEP=y
> > > >
> > > That helps. It means we can't blame the new READ_PLUS code, since
> > > it
> > > would be completely disabled here.
> > > Are you using any special rsize values? Also, could pNFS be
> > > involved
> > > (e.g. the pNFS block/scsi code)?
> > >
> >
> > No special rsize values or pNFS should be involved - here's most of
> > the /proc/mounts
> >  /mnt/test nfs4
> > rw,context=system_u:object_r:root_t:s0,relatime,vers=4.1,rsize=524288
> > ,wsize=524288,namlen=255,hard,proto=tcp,timeo=600,retrans=2,sec=sys
> >
> > If you want I can try against a later server and maybe loopback on
> > the
> > same 5.10-rc4 kernel and see if it reproduces?
> >
> > >
> >
> > FWIW, I've also seen at least once NFS4.1 produces something slightly
> > different:
> >
> > $ cat nfs41-fail-074-different-backtrace.txt
> > [   60.125028] run fstests generic/074 at 2020-11-24 11:57:51
> > [   62.281576]
> > [   62.300548] =============================
> > [   62.302205] [ BUG: Invalid wait context ]
> > [   62.303812] 5.10.0-rc4 #127 Not tainted
> > [   62.305351] -----------------------------
> > [   62.306954] fstest/2035 is trying to lock:
> > [   62.308588] ffff8fe4bffd23d8 (&zone->lock){..-.}-{3:3}, at:
> > get_page_from_freelist+0x897/0x2190
> > [   62.312079] other info that might help us debug this:
> > [   62.314105] context-{5:5}
> > [   62.315166] 3 locks held by fstest/2035:
> > [   62.316722]  #0: ffff8fe3b3d78448 (sb_writers#16){.+.+}-{0:0}, at:
> > do_syscall_64+0x33/0x40
> > [   62.320040]  #1: ffff8fe3d8f48488
> > (&sb->s_type->i_mutex_key#21){++++}-{4:4}, at: do_truncate+0x69/0xd0
> > [   62.323706]  #2: ffff8fe4b7c9b2b0 (krc.lock){..-.}-{2:2}, at:
> > kvfree_call_rcu+0x69/0x230
> > [   62.326974] stack backtrace:
> > [   62.328151] CPU: 2 PID: 2035 Comm: fstest Kdump: loaded Not
> > tainted
> > 5.10.0-rc4 #127
> > [   62.331172] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
> > [   62.333449] Call Trace:
> > [   62.334504]  dump_stack+0x8d/0xb5
> > [   62.335880]  __lock_acquire.cold+0x20b/0x2c8
> > [   62.337621]  ? find_get_entries+0x2c7/0x5b0
> > [   62.339316]  lock_acquire+0xca/0x380
> > [   62.340795]  ? get_page_from_freelist+0x897/0x2190
> > [   62.342722]  _raw_spin_lock+0x2c/0x40
> > [   62.344224]  ? get_page_from_freelist+0x897/0x2190
> > [   62.346123]  get_page_from_freelist+0x897/0x2190
> > [   62.347979]  ? __lock_acquire+0x3b1/0x25d0
> > [   62.349625]  __alloc_pages_nodemask+0x1b4/0x460
> > [   62.351437]  __get_free_pages+0xd/0x30
> > [   62.352942]  kvfree_call_rcu+0x168/0x230
> > [   62.354562]  nfs4_do_setattr+0x1f6/0x4e0 [nfsv4]
> > [   62.356455]  nfs4_proc_setattr+0xb0/0x160 [nfsv4]
> > [   62.358380]  nfs_setattr+0x102/0x2c0 [nfs]
> > [   62.360069]  notify_change+0x340/0x4d0
> > [   62.361587]  ? do_truncate+0x76/0xd0
> > [   62.363034]  do_truncate+0x76/0xd0
> > [   62.364413]  do_sys_ftruncate+0x14a/0x230
> > [   62.366037]  do_syscall_64+0x33/0x40
> > [   62.367481]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > [   62.369489] RIP: 0033:0x7f23c70c2abb
> > [   62.370927] Code: 77 05 c3 0f 1f 40 00 48 8b 15 c9 73 0c 00 f7 d8
> > 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 4d 00 00
> > 00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 99 73 0c
> > 00
> > f7 d8
> > [   62.378219] RSP: 002b:00007ffd0780e788 EFLAGS: 00000202 ORIG_RAX:
> > 000000000000004d
> > [   62.381208] RAX: ffffffffffffffda RBX: 0000000000002000 RCX:
> > 00007f23c70c2abb
> > [   62.384031] RDX: 0000000000000242 RSI: 0000000000a00000 RDI:
> > 0000000000000003
> > [   62.386851] RBP: 00000000017022b0 R08: 0000000000000000 R09:
> > 000000000000001f
> > [   62.389677] R10: 00000000000001a4 R11: 0000000000000202 R12:
> > 0000000000000003
> > [   62.392493] R13: 0000000000000000 R14: 0000000000a00000 R15:
> > 0000000000000001
> >
>
> Hmm... Both suggest a use-after-free situation. Would you be able to
> run the test with KASAN enabled? That might help finger the real
> culprit.
>

Trying to get something out of KASAN but so far no luck.
Could this be a junk report from lockdep?

