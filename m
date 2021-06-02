Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F074399245
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Jun 2021 20:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbhFBSPZ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 2 Jun 2021 14:15:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31393 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229468AbhFBSPZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 2 Jun 2021 14:15:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622657621;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=JkRszhYoou2p+9Lm790fOJAlQQXDw3V1dWx3L/C7GdQ=;
        b=e9e9j/bx1LpsgBSZwh12vON98Litw+fh5XDuvo95e5/5iS6uphZbLELgKYQ9dzh3YAZ5zt
        hlQluxw17MgeoRqDon2scYhhmpfwhu7ao94kKVIXzKv+jRIXV3wPx9N82MCC6hGLh3AFe9
        a26C19aBfoPke1fd2OkE7/Y5GraDgig=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-9j07ZdUdNQSzPK5mVV-rCw-1; Wed, 02 Jun 2021 14:13:40 -0400
X-MC-Unique: 9j07ZdUdNQSzPK5mVV-rCw-1
Received: by mail-yb1-f197.google.com with SMTP id g9-20020a25ae490000b029052f9e5b7d3fso4102547ybe.4
        for <linux-nfs@vger.kernel.org>; Wed, 02 Jun 2021 11:13:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=JkRszhYoou2p+9Lm790fOJAlQQXDw3V1dWx3L/C7GdQ=;
        b=clIVNsM/dNebuTvBlr9mCNtnu8yMRhbdLGqrIC9bc38eaM/SXugYSfZx5OMwBoXbph
         sMDxtbZUO0drBqpZJ2XPhnGLRDrrLDm5n9sLxllUoIyc2DYRWAhlUPjacA3Yz24QCJVo
         cVrPOo3M81z+BN1SbF44AOnKHFaxnsnBKiW72qDc6XYaDvr1cUtzgiChb6Vzd14ABDPT
         vhUkRGYqB0PPujjga/hxR1X2NfNLgrXRnCo6tjXQ+dQqy9NMHW0510MaHXvGCoKRk6VT
         29dVwx6GlT1+Y429vN+Cf59wfhlzW6w2IgIXVDfw+N9UE0ydIemfiO9dhvkLPR3Ed9Xy
         /dIg==
X-Gm-Message-State: AOAM5331eEKIyLfbp62SK0+NeKH8Ps6xunShPjFzUQnGNVVQmWIXV5I0
        Z0Tfm/3yhdsldI4/YopRZcTCJH4fLQraQDCltVpTdHlrFjn1t5lgdcFhcplRfAcc1F47cifzsRB
        tgjAZ5+LXCcqMqSG7CqHAQVtFA3cc95AX3gfz
X-Received: by 2002:a25:6c8a:: with SMTP id h132mr48527922ybc.454.1622657619395;
        Wed, 02 Jun 2021 11:13:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx88fyt5CMTIBKVkHe0IimkHWuxE5SkQbVPl1AsIFMpT1fn92/3M8rW1ZtsXXNmKgtIwuPbJaKhrIPgYY2D13o=
X-Received: by 2002:a25:6c8a:: with SMTP id h132mr48527897ybc.454.1622657619167;
 Wed, 02 Jun 2021 11:13:39 -0700 (PDT)
MIME-Version: 1.0
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Wed, 2 Jun 2021 14:13:02 -0400
Message-ID: <CALF+zOnw_6i2M0gv4rZYURdZgO8e84ja8u_7yEMnMz=3n+hKJg@mail.gmail.com>
Subject: BUG: KASAN: use-after-free in find_clp_in_name_tree.isra.0+0x13e/0x190
 [nfsd]
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Bruce,

I was testing your nfsd-next branch (plus my modified v3 callback
address and state patch I just sent) and saw this on console after a
simple test of mount, umount, mount cycle of a NFSv4.1 mount.


==================================================================
[ 8523.413808] BUG: KASAN: use-after-free in
find_clp_in_name_tree.isra.0+0x13e/0x190 [nfsd]
[ 8523.417537] Read of size 4 at addr ffff888117a6cee8 by task nfsd/1132
[ 8523.420320]
[ 8523.421012] CPU: 7 PID: 1132 Comm: nfsd Kdump: loaded Not tainted
5.13.0-rc2-bfields-nfsd+ #16
[ 8523.424499] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011
[ 8523.426785] Call Trace:
[ 8523.427880]  dump_stack+0x9c/0xcf
[ 8523.429375]  print_address_description.constprop.0+0x18/0x130
[ 8523.431756]  ? find_clp_in_name_tree.isra.0+0x13e/0x190 [nfsd]
[ 8523.434160]  kasan_report.cold+0x7f/0x111
[ 8523.435795]  ? find_clp_in_name_tree.isra.0+0x13e/0x190 [nfsd]
[ 8523.438207]  find_clp_in_name_tree.isra.0+0x13e/0x190 [nfsd]
[ 8523.440519]  ? _raw_write_lock_bh+0xb0/0xb0
[ 8523.442284]  nfsd4_exchange_id+0x7f5/0x1730 [nfsd]
[ 8523.444290]  ? nfsd4_mach_creds_match+0x210/0x210 [nfsd]
[ 8523.446479]  ? svcauth_unix_set_client+0xab8/0x1370 [sunrpc]
[ 8523.449121]  nfsd4_proc_compound+0xc83/0x1f20 [nfsd]
[ 8523.451187]  nfsd_dispatch+0x4fd/0xa30 [nfsd]
[ 8523.453053]  ? svc_reserve+0x10c/0x220 [sunrpc]
[ 8523.454986]  svc_process_common+0xcca/0x2310 [sunrpc]
[ 8523.457119]  ? svc_set_num_threads+0x440/0x440 [sunrpc]
[ 8523.459318]  ? nfsd_svc+0x9a0/0x9a0 [nfsd]
[ 8523.461044]  ? svc_xprt_release+0x2fd/0x720 [sunrpc]
[ 8523.463135]  svc_process+0x353/0x4f0 [sunrpc]
[ 8523.464998]  nfsd+0x2a1/0x410 [nfsd]
[ 8523.466526]  ? __kthread_parkme+0x85/0x100
[ 8523.468251]  ? nfsd_shutdown_threads+0x1f0/0x1f0 [nfsd]
[ 8523.470409]  kthread+0x31c/0x3e0
[ 8523.471725]  ? __kthread_bind_mask+0x90/0x90
[ 8523.473440]  ret_from_fork+0x22/0x30
[ 8523.474924]
[ 8523.475571] Allocated by task 1132:
[ 8523.477010]  kasan_save_stack+0x1b/0x40
[ 8523.478564]  __kasan_slab_alloc+0x61/0x80
[ 8523.480185]  kmem_cache_alloc+0xec/0x250
[ 8523.481795]  create_client+0x1bf/0xe00 [nfsd]
[ 8523.483639]  nfsd4_exchange_id+0x2b8/0x1730 [nfsd]
[ 8523.485646]  nfsd4_proc_compound+0xc83/0x1f20 [nfsd]
[ 8523.487677]  nfsd_dispatch+0x4fd/0xa30 [nfsd]
[ 8523.489487]  svc_process_common+0xcca/0x2310 [sunrpc]
[ 8523.491608]  svc_process+0x353/0x4f0 [sunrpc]
[ 8523.493564]  nfsd+0x2a1/0x410 [nfsd]
[ 8523.507991]  kthread+0x31c/0x3e0
[ 8523.509297]  ret_from_fork+0x22/0x30
[ 8523.510734]
[ 8523.511358] Last potentially related work creation:
[ 8523.513263]  kasan_save_stack+0x1b/0x40
[ 8523.514771]  kasan_record_aux_stack+0xa5/0xb0
[ 8523.516476]  insert_work+0x4a/0x350
[ 8523.517852]  __queue_work+0x4db/0xc20
[ 8523.519288]  queue_work_on+0x59/0x80
[ 8523.520707]  nfsd4_run_cb+0x51/0x80 [nfsd]
[ 8523.522799]  nfsd4_shutdown_callback+0xbf/0x2a0 [nfsd]
[ 8523.524889]  __destroy_client+0x48a/0x6d0 [nfsd]
[ 8523.526738]  nfsd4_destroy_clientid+0x2da/0x4c0 [nfsd]
[ 8523.528823]  nfsd4_proc_compound+0xc83/0x1f20 [nfsd]
[ 8523.530826]  nfsd_dispatch+0x4fd/0xa30 [nfsd]
[ 8523.532594]  svc_process_common+0xcca/0x2310 [sunrpc]
[ 8523.534988]  svc_process+0x353/0x4f0 [sunrpc]
[ 8523.536774]  nfsd+0x2a1/0x410 [nfsd]
[ 8523.538258]  kthread+0x31c/0x3e0
[ 8523.539539]  ret_from_fork+0x22/0x30
[ 8523.540949]
[ 8523.541571] Second to last potentially related work creation:
[ 8523.543778]  kasan_save_stack+0x1b/0x40
[ 8523.545281]  kasan_record_aux_stack+0xa5/0xb0
[ 8523.546992]  insert_work+0x4a/0x350
[ 8523.548352]  __queue_work+0x4db/0xc20
[ 8523.549778]  queue_work_on+0x59/0x80
[ 8523.551178]  nfsd4_run_cb+0x51/0x80 [nfsd]
[ 8523.552830]  nfsd4_probe_callback_sync+0xa/0x20 [nfsd]
[ 8523.554900]  nfsd4_destroy_session+0x658/0x920 [nfsd]
[ 8523.556956]  nfsd4_proc_compound+0xc83/0x1f20 [nfsd]
[ 8523.558949]  nfsd_dispatch+0x4fd/0xa30 [nfsd]
[ 8523.560707]  svc_process_common+0xcca/0x2310 [sunrpc]
[ 8523.562777]  svc_process+0x353/0x4f0 [sunrpc]
[ 8523.564587]  nfsd+0x2a1/0x410 [nfsd]
[ 8523.566065]  kthread+0x31c/0x3e0
[ 8523.567338]  ret_from_fork+0x22/0x30
[ 8523.568747]
[ 8523.569405] The buggy address belongs to the object at ffff888117a6ce50
[ 8523.569405]  which belongs to the cache nfsd4_clients of size 1304
[ 8523.574309] The buggy address is located 152 bytes inside of
[ 8523.574309]  1304-byte region [ffff888117a6ce50, ffff888117a6d368)
[ 8523.578794] The buggy address belongs to the page:
[ 8523.580661] page:000000005a8edc90 refcount:1 mapcount:0
mapping:0000000000000000 index:0xffff888117a6ce50 pfn:0x117a68
[ 8523.584734] head:000000005a8edc90 order:3 compound_mapcount:0
compound_pincount:0
[ 8523.587613] flags:
0x17ffffc0010200(slab|head|node=0|zone=2|lastcpupid=0x1fffff)
[ 8523.590475] raw: 0017ffffc0010200 dead000000000100 dead000000000122
ffff88810ca21180
[ 8523.593442] raw: ffff888117a6ce50 0000000080160015 00000001ffffffff
0000000000000000
[ 8523.596406] page dumped because: kasan: bad access detected
[ 8523.598551]
[ 8523.599168] Memory state around the buggy address:
[ 8523.601043]  ffff888117a6cd80: fc fc fc fc fc fc fc fc fc fc fc fc
fc fc fc fc
[ 8523.603798]  ffff888117a6ce00: fc fc fc fc fc fc fc fc fc fc fb fb
fb fb fb fb
[ 8523.614732] >ffff888117a6ce80: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[ 8523.617540]                                                           ^
[ 8523.620077]  ffff888117a6cf00: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[ 8523.622826]  ffff888117a6cf80: fb fb fb fb fb fb fb fb fb fb fb fb
fb fb fb fb
[ 8523.625586] ==================================================================
[ 8523.628381] Disabling lock debugging due to kernel taint

