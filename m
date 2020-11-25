Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 388A32C363B
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Nov 2020 02:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgKYB2w (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 24 Nov 2020 20:28:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58082 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726874AbgKYB2v (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 24 Nov 2020 20:28:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1606267729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MKSRg6aBd38SSTtyjY6YZGlXtz76bilrGrpSrjdNzYc=;
        b=eKjjTWziSSlDqch115UNw9RNIlVcJEH2xszJpNf+wdoSIZvh1P6aRMhs55D3JpocEjdyrk
        YLDtVD4uj6ZsG07DIW9uqsaoIwHZ6blwO/4wAnxT7WkosFXaccQbHWYtP9iiULwW1Mibxu
        HHdeWMoZrHkQYczbiKdoaFR81ibbFdY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-d86Vaj9WOOui0ps41zhcbw-1; Tue, 24 Nov 2020 20:28:47 -0500
X-MC-Unique: d86Vaj9WOOui0ps41zhcbw-1
Received: by mail-ed1-f70.google.com with SMTP id h11so374723edw.14
        for <linux-nfs@vger.kernel.org>; Tue, 24 Nov 2020 17:28:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MKSRg6aBd38SSTtyjY6YZGlXtz76bilrGrpSrjdNzYc=;
        b=CAK7Wmiau3MMZtBXfAaMcjauzNhZC0DxYaxpphzFkw8pRLuLeLjP3jRXdiDbH4ALk7
         5ctshpI6BusLoBAPWjPB2Ot/xctE5nZR1QDlPaqXqpCNQn5/+dpabRknNpVn4FKgMDZJ
         My4Zzd09VVCePHoSjUK+i0BOEU1HB4bi9lMuzJ2HFUW/MgpArLYbRiO/guW8Ofygt8eT
         z6YUFfqwiDli/iukoOwpr0Zi8D28f13OGmvvqr9+QnUdI5mrNpmlEtmDojaBs2sOPclX
         L+H2anG2ZnVMzT6M9bEF/hIvSOgJ5H0xIKcZiFQClfoNVMzwQDRO7JkYFO+1m/YWfQ6Y
         oZ4w==
X-Gm-Message-State: AOAM532Xt1aaimIpA72gAT3lYRDMjnDcKCcUeofg1lc2MifqM1oxFXI/
        wql2/7GBwD1SAR2V7DEFA2VXX9zbF7DldCN0seFuhO151YTZF5iLFMa2nOLc4oXSfpYHVASXXiY
        X6XkdPBl2kudO8nvBGmV41A4geRkgiavj5G5Z
X-Received: by 2002:a05:6402:b08:: with SMTP id bm8mr1304135edb.29.1606267726408;
        Tue, 24 Nov 2020 17:28:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxvX/6FPg6g5dYZYZ8XvZSmzUy0GZX1YR8CKvTiTDb6YTZSlMvopWjlo2Q2hQYJAmd9EtqCYwpqmRDoov7eXag=
X-Received: by 2002:a05:6402:b08:: with SMTP id bm8mr1304126edb.29.1606267726147;
 Tue, 24 Nov 2020 17:28:46 -0800 (PST)
MIME-Version: 1.0
References: <CALF+zOntimx8nyiAUyN5Y58T9_-PztLpUU2vpYgOzQkcK7C09w@mail.gmail.com>
 <4f3a2c0de91ff3117ada740cc9b1a22eabb1375d.camel@hammerspace.com>
In-Reply-To: <4f3a2c0de91ff3117ada740cc9b1a22eabb1375d.camel@hammerspace.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Tue, 24 Nov 2020 20:28:10 -0500
Message-ID: <CALF+zOkEWrpo=NKL2ncoierFRKmsLqG56qKdsOHBC1k79Yqxhw@mail.gmail.com>
Subject: Re: NFS failure with generic/074 when lockdep is enabled - BUG:
 Invalid wait context
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Nov 24, 2020 at 8:07 PM Trond Myklebust <trondmy@hammerspace.com> wrote:
>
> On Tue, 2020-11-24 at 16:56 -0500, David Wysochanski wrote:
> > I've started seeing this failure since testing 5.10-rc4 - this does
> > not happen on 5.9
> >
> >
> > f31-node1 login: [  124.055768] FS-Cache: Netfs 'nfs' registered for
> > caching
> > [  125.046104] Key type dns_resolver registered
> > [  125.770354] NFS: Registering the id_resolver key type
> > [  125.780599] Key type id_resolver registered
> > [  125.782440] Key type id_legacy registered
> > [  126.563717] run fstests generic/074 at 2020-11-24 11:23:49
> > [  178.736479]
> > [  178.751380] =============================
> > [  178.753249] [ BUG: Invalid wait context ]
> > [  178.754886] 5.10.0-rc4 #127 Not tainted
> > [  178.756423] -----------------------------
> > [  178.758055] kworker/1:2/848 is trying to lock:
> > [  178.759866] ffff8947fffd33d8 (&zone->lock){..-.}-{3:3}, at:
> > get_page_from_freelist+0x897/0x2190
> > [  178.763333] other info that might help us debug this:
> > [  178.765354] context-{5:5}
> > [  178.766437] 3 locks held by kworker/1:2/848:
> > [  178.768158]  #0: ffff8946ce825538
> > ((wq_completion)nfsiod){+.+.}-{0:0}, at: process_one_work+0x1be/0x540
> > [  178.771871]  #1: ffff9e6b408f7e58
> > ((work_completion)(&task->u.tk_work)#2){+.+.}-{0:0}, at:
> > process_one_work+0x1be/0x540
> > [  178.776562]  #2: ffff8947f7c5b2b0 (krc.lock){..-.}-{2:2}, at:
> > kvfree_call_rcu+0x69/0x230
> > [  178.779803] stack backtrace:
> > [  178.780996] CPU: 1 PID: 848 Comm: kworker/1:2 Kdump: loaded Not
> > tainted 5.10.0-rc4 #127
> > [  178.784374] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
> > [  178.787071] Workqueue: nfsiod rpc_async_release [sunrpc]
> > [  178.789308] Call Trace:
> > [  178.790386]  dump_stack+0x8d/0xb5
> > [  178.791816]  __lock_acquire.cold+0x20b/0x2c8
> > [  178.793605]  lock_acquire+0xca/0x380
> > [  178.795113]  ? get_page_from_freelist+0x897/0x2190
> > [  178.797116]  _raw_spin_lock+0x2c/0x40
> > [  178.798638]  ? get_page_from_freelist+0x897/0x2190
> > [  178.800620]  get_page_from_freelist+0x897/0x2190
> > [  178.802537]  __alloc_pages_nodemask+0x1b4/0x460
> > [  178.804416]  __get_free_pages+0xd/0x30
> > [  178.805987]  kvfree_call_rcu+0x168/0x230
> > [  178.807687]  nfs_free_request+0xab/0x180 [nfs]
> > [  178.809547]  nfs_page_group_destroy+0x41/0x80 [nfs]
> > [  178.811588]  nfs_read_completion+0x129/0x1f0 [nfs]
> > [  178.813633]  rpc_free_task+0x39/0x60 [sunrpc]
> > [  178.815481]  rpc_async_release+0x29/0x40 [sunrpc]
> > [  178.817451]  process_one_work+0x23e/0x540
> > [  178.819136]  worker_thread+0x50/0x3a0
> > [  178.820657]  ? process_one_work+0x540/0x540
> > [  178.822427]  kthread+0x10f/0x150
> > [  178.823805]  ? kthread_park+0x90/0x90
> > [  178.825339]  ret_from_fork+0x22/0x30
> >
>
> I can't think of any changes that might have caused this. Is this
> NFSv3, v4 or other? I haven't been seeing any of this.
>

It is NFSv4.1 or NFS4.2.  I am running the xfstests NFS client against
an older server, RHEL7 based (3.10.0-1127.8.2.el7.x86_64) though not
sure if that matters.
My config has these:
CONFIG_LOCK_DEBUGGING_SUPPORT=y
CONFIG_PROVE_LOCKING=y
CONFIG_PROVE_RAW_LOCK_NESTING=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_LOCKDEP=y

