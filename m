Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9381057D186
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Jul 2022 18:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbiGUQap (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jul 2022 12:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233581AbiGUQan (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jul 2022 12:30:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DE105491C5
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jul 2022 09:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658421039;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vnPkJn5lAOvcMsC43SXQjCCrn+IxKsBMOToz0XcS8Mw=;
        b=SZMNiX4QCuV0/Q0UhoIRE7BHCR2c2+g+foVIj9DvcZkc/TmtXc9nJdoT4E12LeOghu9h/O
        d3bu1W3dgcOJL1Sa+cOiuvS2ZvhmmWbFRnwHj9nuyLu5b+35yvYoys/cknx7ZtoC0Iz6vr
        9IPHGsKRSIGzw9H7ft/Zi9TgaMB8q4M=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-589-LJkaA0zRM8qo3WvSVyupsQ-1; Thu, 21 Jul 2022 12:30:37 -0400
X-MC-Unique: LJkaA0zRM8qo3WvSVyupsQ-1
Received: by mail-qk1-f199.google.com with SMTP id de4-20020a05620a370400b006a9711bd9f8so1691036qkb.9
        for <linux-nfs@vger.kernel.org>; Thu, 21 Jul 2022 09:30:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vnPkJn5lAOvcMsC43SXQjCCrn+IxKsBMOToz0XcS8Mw=;
        b=Mb/QJqSj1maKLmGHsi2QNDLTLQaCsuvoEuz8WHByjqVgyuJRfG2kBirgytJ15Q3bZ/
         MSc291Ilun/TCP8Tn1y6XiK/wRi68RMqt/KN/JPJjNBJ5fCeALtUf9LSbi7zaDTnpQXZ
         9Re3SIc45J48O8pKv9pUpVIlJ+HQjrY+RjffAVUbVgebDbU32x3uuONeHglyC641uRKj
         EHIcFpV+IhQw9DU7jftDqPp3efy24+d5i9fkmn6kT6YgDzneEvlCM3I/fXDcaxbquSAa
         dN2RCOKX28q3lFMdhXOjjXNVCuvyPZZxfiZU3VDy+RAAx743UzyVaCR2liga/z+I+Nhs
         lIkQ==
X-Gm-Message-State: AJIora/zht8WHWD/nH8Jbu9t5BERmPhoPj9dYuHz0/suLREsGfsuAUf1
        N/58DjKFXeUZXwKN2ESEoLeIDB0en2cWEAKGXNV1EufnOyAdWkHhlBkFILyV5zBw7Ju17qy5Lu3
        i3IBAx0UFs5QKgfEAr4TN
X-Received: by 2002:a05:620a:1929:b0:6b6:19c9:462f with SMTP id bj41-20020a05620a192900b006b619c9462fmr4322221qkb.688.1658421036368;
        Thu, 21 Jul 2022 09:30:36 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tuh67TnAqRnepOKV3VKJGQhbiPTh5whFqoPvjw5w2wH8ct5kuwZXj4e2+pkGJFWxgZyebsbw==
X-Received: by 2002:a05:620a:1929:b0:6b6:19c9:462f with SMTP id bj41-20020a05620a192900b006b619c9462fmr4322189qkb.688.1658421035920;
        Thu, 21 Jul 2022 09:30:35 -0700 (PDT)
Received: from zlang-mailbox ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id cm20-20020a05622a251400b00304fc3d144esm1558083qtb.1.2022.07.21.09.30.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 09:30:35 -0700 (PDT)
Date:   Fri, 22 Jul 2022 00:30:29 +0800
From:   Zorro Lang <zlang@redhat.com>
To:     Chuck Lever III <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Cc:     Boyang Xue <bxue@redhat.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH v1] generic/476: requires 27GB scratch size
Message-ID: <20220721163029.lmyrdbf7l3fpwdwu@zlang-mailbox>
References: <20220721022959.4189726-1-bxue@redhat.com>
 <20220721152909.otn3spgou5inzhoo@zlang-mailbox>
 <C3EC5E8E-C230-4720-BFCF-6497E088EF01@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <C3EC5E8E-C230-4720-BFCF-6497E088EF01@oracle.com>
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, Jul 21, 2022 at 03:32:49PM +0000, Chuck Lever III wrote:
> 
> 
> > On Jul 21, 2022, at 11:29 AM, Zorro Lang <zlang@redhat.com> wrote:
> > 
> > On Thu, Jul 21, 2022 at 10:29:59AM +0800, bxue@redhat.com wrote:
> >> From: Boyang Xue <bxue@redhat.com>
> >> 
> >> The test requires larger scratch dev size when running on top of NFS other
> >> than ext4 and xfs. It requires at least 27GB in my test. Without this
> >> requirement, the test run never finishes on NFS, leaving 100% scratch disk
> >> space use.
> >> 
> >> Signed-off-by: Boyang Xue <bxue@redhat.com>
> >> ---
> >> Hi,
> >> 
> >> I find generic/476 easily goes into an infinite run on top of NFS. When it
> >> happens, the common pattern is 100% disk space use of SCRATCH_MNT, and
> >> `nfsiostat` shows 50% write error on SCRATCH_MNT. When I run it with a large
> >> enough SCRATCH_MNT, the problem disappears. So I post this patch to add the size
> >> requirement.
> >> 
> >> Please help review this patch. Thanks!
> >> 
> >> -Boyang
> >> 
> >> tests/generic/476 | 1 +
> >> 1 file changed, 1 insertion(+)
> >> 
> >> diff --git a/tests/generic/476 b/tests/generic/476
> >> index 212373d1..dcc7c3da 100755
> >> --- a/tests/generic/476
> >> +++ b/tests/generic/476
> >> @@ -24,6 +24,7 @@ _cleanup()
> >> _supported_fs generic
> >> 
> >> _require_scratch
> >> +_require_scratch_size $((27 * 1024 * 1024)) # 27GB
> > 
> > At first, most of other filesystems don't need this requirement, that will
> > reduce test coverage of other fs suddently. Second, there's not a clear
> > reason to prove NFS (or others) need a 27+GB device to run this test. Due to
> > the generic/476 does nothing special, except random I/Os, even running with
> > ENOSPC...
> > 
> > So one difference of running with small device or large enough device is the
> > chance to run with ENOSPC. I think the device size isn't the root cause of
> > nfs hang you hit, I doubt if it's a NFS bug with ENOSPC, or something else
> > bug which is triggered by someone random I/O operation.
> > 
> > We'd better not to skip a known generic test (from upstream fstests directly)
> > if without a clear reason. That might cause we miss bugs or test coverage,
> > better to make sure if it's a real bug at first. Then think about if we need
> > to improve the case or fix a bug.
> 
> +1
> 
> I can help troubleshoot the NFS-related aspects of this further, if needed.

Thanks Chuck, I think we'd better to cc linux-nfs list.

I can reproduce generic/476 hang on nfs[0] too, with real disk or Virtio disk,
it's not a loop device related issue. And sometimes it test passed[1], even with
a 10G loop device[2] (which I/O speed is very fast). If you or nfs forks need
full console log, I can provide. But I think it's easy to reproduce this bug
by running generic/476 on a general nfs v4.2.

Thanks,
Zorro

[0]
[173303.753434] sysrq: Show Memory 
[173303.764679] Mem-Info: 
[173303.765683] active_anon:1872 inactive_anon:22756 isolated_anon:0 
[173303.765683]  active_file:47360 inactive_file:1230085 isolated_file:0 
[173303.765683]  unevictable:0 dirty:3 writeback:0 
[173303.765683]  slab_reclaimable:108117 slab_unreclaimable:100595 
[173303.765683]  mapped:11734 shmem:7363 pagetables:544 bounce:0 
[173303.765683]  kernel_misc_reclaimable:0 
[173303.765683]  free:49561 free_pcp:5112 free_cma:0 
[173303.780542] Node 0 active_anon:7488kB inactive_anon:91024kB active_file:189440kB inactive_file:4920340kB unevictable:0kB isolated(anon):0kB isolated(file):0kB mapped:46936kB dirty:12kB writeback:0kB shmem:29452kB shmem_thp: 0kB shmem_pmdmapped: 0kB anon_thp: 18432kB writeback_tmp:0kB kernel_stack:5920kB pagetables:2176kB all_unreclaimable? no 
[173303.790519] Node 0 DMA free:14336kB boost:0kB min:160kB low:200kB high:240kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB 
[173303.799060] lowmem_reserve[]: 0 2659 6183 6183 6183 
[173303.800781] Node 0 DMA32 free:123700kB boost:0kB min:28992kB low:36240kB high:43488kB reserved_highatomic:0KB active_anon:12kB inactive_anon:1452kB active_file:61020kB inactive_file:2279284kB unevictable:0kB writepending:8kB present:3129308kB managed:2801628kB mlocked:0kB bounce:0kB free_pcp:3508kB local_pcp:768kB free_cma:0kB 
[173303.810096] lowmem_reserve[]: 0 0 3524 3524 3524 
[173303.812131] Node 0 Normal free:60208kB boost:0kB min:38424kB low:48028kB high:57632kB reserved_highatomic:2048KB active_anon:7476kB inactive_anon:89572kB active_file:128420kB inactive_file:2641056kB unevictable:0kB writepending:4kB present:5242880kB managed:3618860kB mlocked:0kB bounce:0kB free_pcp:16240kB local_pcp:4196kB free_cma:0kB 
[173303.822880] lowmem_reserve[]: 0 0 0 0 0 
[173303.824683] Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 1*2048kB (M) 3*4096kB (M) = 14336kB 
[173303.829410] Node 0 DMA32: 1385*4kB (UME) 1254*8kB (UME) 368*16kB (UME) 317*32kB (UME) 121*64kB (UM) 105*128kB (UME) 99*256kB (UM) 63*512kB (UME) 13*1024kB (UME) 0*2048kB 0*4096kB = 123700kB 
[173303.836654] Node 0 Normal: 1056*4kB (UMEH) 1027*8kB (UMEH) 400*16kB (UMEH) 287*32kB (UMEH) 105*64kB (UMEH) 71*128kB (UM) 42*256kB (M) 10*512kB (M) 0*1024kB 0*2048kB 0*4096kB = 59704kB 
[173303.843268] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB 
[173303.846232] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB 
[173303.849541] 1284815 total pagecache pages 
[173303.851713] 7 pages in swap cache 
[173303.853033] Swap cache stats: add 24, delete 17, find 0/1 
[173303.874135] Free swap  = 8257760kB 
[173303.875679] Total swap = 8258556kB 
[173303.877210] 2097045 pages RAM 
[173303.878574] 0 pages HighMem/MovableOnly 
[173303.880204] 488083 pages reserved 
[173303.881721] 0 pages cma reserved 
[173303.883181] 0 pages hwpoisoned 
[173311.514201] sysrq: Show State 
[173311.531486] task:systemd         state:S stack:23208 pid:    1 ppid:     0 flags:0x00000002 
[173311.535523] Call Trace: 
[173311.536988]  <TASK> 
[173311.537992]  __schedule+0x673/0x1540 
[173311.539782]  ? io_schedule_timeout+0x160/0x160 
[173311.541842]  schedule+0xe0/0x200 
[173311.543466]  schedule_hrtimeout_range_clock+0x2c0/0x310 
[173311.545632]  ? hrtimer_nanosleep_restart+0x170/0x170 
[173311.547948]  ? lock_downgrade+0x130/0x130 
[173311.549585]  ? lockdep_hardirqs_on_prepare.part.0+0x18c/0x370 
[173311.551686]  ep_poll+0x7db/0xa80 
[173311.552999]  ? ep_send_events+0x9f0/0x9f0 
[173311.555015]  ? pick_next_task_stop+0x250/0x250 
[173311.574734]  ? prepare_to_wait_exclusive+0x2c0/0x2c0 
[173311.576518]  ? __lock_release+0x4c1/0xa00 
[173311.579162]  do_epoll_wait+0x12f/0x160 
[173311.580973]  __x64_sys_epoll_wait+0x12e/0x250 
[173311.582599]  ? __x64_sys_epoll_pwait2+0x240/0x240 
[173311.584769]  ? lockdep_hardirqs_on_prepare.part.0+0x18c/0x370 
[173311.587348]  do_syscall_64+0x5c/0x90 
[173311.589335]  ? do_syscall_64+0x69/0x90 
[173311.591128]  ? lockdep_hardirqs_on+0x79/0x100 
[173311.593125]  ? do_syscall_64+0x69/0x90 
[173311.594805]  ? lockdep_hardirqs_on+0x79/0x100 
[173311.596598]  entry_SYSCALL_64_after_hwframe+0x63/0xcd 
[173311.598376] RIP: 0033:0x7f0a5834e7de 
[173311.599836] RSP: 002b:00007ffcee99d180 EFLAGS: 00000293 ORIG_RAX: 00000000000000e8 
[173311.603432] RAX: ffffffffffffffda RBX: 000056269d7b5b80 RCX: 00007f0a5834e7de 
[173311.605924] RDX: 00000000000000a6 RSI: 000056269da4f0d0 RDI: 0000000000000004 
[173311.608922] RBP: 000056269d7b5d10 R08: 0000000000000000 R09: 000000000000000d 
[173311.611243] R10: 00000000ffffffff R11: 0000000000000293 R12: 0000000000000226 
[173311.613741] R13: 000056269d7b5b80 R14: 00000000000000a6 R15: 0000000000000037 
[173311.626581]  </TASK> 
[173311.627500] task:kthreadd        state:S stack:27704 pid:    2 ppid:     0 flags:0x00004000 
[173311.630191] Call Trace: 
[173311.631013]  <TASK> 
[173311.631872]  __schedule+0x673/0x1540 
[173311.633147]  ? io_schedule_timeout+0x160/0x160 
[173311.634725]  schedule+0xe0/0x200 
[173311.635884]  kthreadd+0x9fb/0xd60 
[173311.637204]  ? kthread_is_per_cpu+0xc0/0xc0 
[173311.638684]  ret_from_fork+0x22/0x30 
[173311.640320]  </TASK> 
[173311.641273] task:rcu_gp          state:I stack:29336 pid:    3 ppid:     2 flags:0x00004000 
[173311.645006] Workqueue:  0x0 (rcu_gp) 
[173311.646684] Call Trace: 
[173311.647756]  <TASK> 
[173311.648895]  __schedule+0x673/0x1540 
[173311.650435]  ? io_schedule_timeout+0x160/0x160 
[173311.652317]  schedule+0xe0/0x200 
[173311.653732]  rescuer_thread+0x662/0xb80 
[173311.656494]  ? _raw_spin_unlock_irqrestore+0x59/0x70 
[173311.658779]  ? worker_thread+0xed0/0xed0 
[173311.660381]  ? __kthread_parkme+0xcc/0x200 
[173311.662276]  ? worker_thread+0xed0/0xed0 
[173311.664182]  kthread+0x2a7/0x350 
[173311.665725]  ? kthread_complete_and_exit+0x20/0x20 
[173311.667519]  ret_from_fork+0x22/0x30 
[173311.669222]  </TASK> 
[173311.670098] task:rcu_par_gp      state:I stack:30888 pid:    4 ppid:     2 flags:0x00004000 
[173311.673101] Call Trace: 
[173311.673976]  <TASK> 
[173311.674868]  __schedule+0x673/0x1540 
[173311.676197]  ? io_schedule_timeout+0x160/0x160 
[173311.677805]  schedule+0xe0/0x200 
[173311.678991]  rescuer_thread+0x662/0xb80 
[173311.680502]  ? _raw_spin_unlock_irqrestore+0x59/0x70 
[173311.682222]  ? worker_thread+0xed0/0xed0
...
(too many lines)
...
[173319.787263] Showing all locks held in the system: 
[173319.788884] no locks held by systemd-journal/517. 
[173319.789881] 1 lock held by fsstress/663798: 
[173319.790895]  #0: ffff888130b68488 (sb_writers#16){.+.+}-{0:0}, at: ksys_write+0xf9/0x1d0 
[173319.792551] 3 locks held by kworker/u8:2/666396: 
[173319.794275]  #0: ffff8881e4602f58 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x30/0x120 
[173319.795933]  #1: ffff8881e4e02f58 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x30/0x120 
[173319.797605]  #2: ffff8881009bc4f0 (&p->pi_lock){-.-.}-{2:2}, at: try_to_wake_up+0xb3/0xdd0 
[173319.799126] 3 locks held by 20_sysinfo/666628: 
[173319.799995]  #0: ffff88810c362488 (sb_writers#3){.+.+}-{0:0}, at: ksys_write+0xf9/0x1d0 
[173319.801695]  #1: ffffffff860e6dc0 (rcu_read_lock){....}-{1:2}, at: __handle_sysrq+0x4a/0xe0 
[173319.803276]  #2: ffffffff860e6dc0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire.constprop.0+0x0/0x30 
[173319.804988]  
[173319.805319] ============================================= 
[173319.805319]  
[173319.806614] Showing busy workqueues and worker pools: 
[173319.807587] workqueue events_highpri: flags=0x10 
[173319.808538]   pwq 5: cpus=2 node=0 flags=0x0 nice=-20 active=1/256 refcnt=2 
[173319.808581]     pending: mix_interrupt_randomness 
[173328.255900] sysrq: Show Blocked State 
[173328.276745] task:fsstress        state:D stack:23416 pid:663798 ppid:663797 flags:0x00004002 
[173328.279713] Call Trace: 
[173328.280646]  <TASK> 
[173328.281768]  __schedule+0x673/0x1540 
[173328.283583]  ? io_schedule_timeout+0x160/0x160 
[173328.285898]  ? pick_next_task_stop+0x250/0x250 
[173328.288286]  schedule+0xe0/0x200 
[173328.289932]  schedule_timeout+0x19e/0x250 
[173328.291845]  ? usleep_range_state+0x190/0x190 
[173328.293563]  ? mark_held_locks+0xa5/0xf0 
[173328.295072]  ? lockdep_hardirqs_on_prepare.part.0+0x18c/0x370 
[173328.297228]  ? _raw_spin_unlock_irq+0x24/0x50 
[173328.299148]  __wait_for_common+0x381/0x540 
[173328.301081]  ? usleep_range_state+0x190/0x190 
[173328.303037]  ? out_of_line_wait_on_bit_timeout+0x170/0x170 
[173328.304937]  ? up_write+0x20/0x20 
[173328.306118]  ? nfs_file_direct_write+0xaef/0x1050 [nfs] 
[173328.308327]  wait_for_completion_killable+0x20/0x40 
[173328.310146]  nfs_file_direct_write+0xb2c/0x1050 [nfs] 
[173328.312009]  ? nfs_file_direct_read+0xaa0/0xaa0 [nfs] 
[173328.313878]  ? nfs_key_timeout_notify+0x3a/0x90 [nfs] 
[173328.315651]  ? __lock_acquire+0xb72/0x1870 
[173328.317032]  ? nfs_file_write+0xed/0x8c0 [nfs] 
[173328.318716]  new_sync_write+0x2ef/0x540 
[173328.320059]  ? new_sync_read+0x530/0x530 
[173328.321447]  ? lock_acquire+0x1d8/0x620 
[173328.322839]  ? rcu_read_unlock+0x40/0x40 
[173328.324309]  vfs_write+0x62a/0x920 
[173328.325592]  ksys_write+0xf9/0x1d0 
[173328.327621]  ? __ia32_sys_read+0xa0/0xa0 
[173328.328996]  ? ktime_get_coarse_real_ts64+0x130/0x170 
[173328.330746]  do_syscall_64+0x5c/0x90 
[173328.331998]  ? do_syscall_64+0x69/0x90 
[173328.333303]  ? lockdep_hardirqs_on+0x79/0x100 
[173328.335143]  ? do_syscall_64+0x69/0x90 
[173328.336483]  ? do_syscall_64+0x69/0x90 
[173328.338093]  ? lockdep_hardirqs_on+0x79/0x100 
[173328.340276]  ? do_syscall_64+0x69/0x90 
[173328.341683]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20 
[173328.343466]  ? lockdep_hardirqs_on+0x79/0x100 
[173328.344989]  entry_SYSCALL_64_after_hwframe+0x63/0xcd 
[173328.346646] RIP: 0033:0x7f16be13e8c7 
[173328.347857] RSP: 002b:00007ffea1b02798 EFLAGS: 00000246 ORIG_RAX: 0000000000000001 
[173328.350228] RAX: ffffffffffffffda RBX: 0000000000100000 RCX: 00007f16be13e8c7 
[173328.352485] RDX: 0000000000100000 RSI: 0000000001c00000 RDI: 0000000000000003 
[173328.354769] RBP: 0000000000000003 R08: 0000000001d00000 R09: 0000000000000000 
[173328.357318] R10: 0000000000000100 R11: 0000000000000246 R12: 0000000000017de1 
[173328.359664] R13: 0000000000000000 R14: 0000000001c00000 R15: 0000000000000000 
[173328.362074]  </TASK> 
         Stopping         
/usr/bin/bash -c …j; exec ./tests/generic/476   
...

[1]
  [ 9746.410677] run fstests generic/476 at 2022-07-16 15:42:38
  [ 9803.017543] restraintd[2193]: *** Current Time: Sat Jul 16 15:43:33 2022  Localwatchdog at: Mon Jul 18 13:01:33 2022 
  [ 9863.016020] restraintd[2193]: *** Current Time: Sat Jul 16 15:44:33 2022  Localwatchdog at: Mon Jul 18 13:01:33 2022 
  [-- MARK -- Sat Jul 16 19:45:00 2022] 
  [ 9923.014409] restraintd[2193]: *** Current Time: Sat Jul 16 15:45:33 2022  Localwatchdog at: Mon Jul 18 13:01:33 2022 
  [ 9983.016088] restraintd[2193]: *** Current Time: Sat Jul 16 15:46:33 2022  Localwatchdog at: Mon Jul 18 13:01:33 2022 
  [10043.014435] restraintd[2193]: *** Current Time: Sat Jul 16 15:47:33 2022  Localwatchdog at: Mon Jul 18 13:01:33 2022 
  [10103.017105] restraintd[2193]: *** Current Time: Sat Jul 16 15:48:33 2022  Localwatchdog at: Mon Jul 18 13:01:33 2022 
  [10163.057993] restraintd[2193]: *** Current Time: Sat Jul 16 15:49:33 2022  Localwatchdog at: Mon Jul 18 13:01:33 2022 
  [-- MARK -- Sat Jul 16 19:50:00 2022] 
  [10223.018212] restraintd[2193]: *** Current Time: Sat Jul 16 15:50:33 2022  Localwatchdog at: Mon Jul 18 13:01:33 2022 
  [10283.015296] restraintd[2193]: *** Current Time: Sat Jul 16 15:51:33 2022  Localwatchdog at: Mon Jul 18 13:01:33 2022 
  [10343.014956] restraintd[2193]: *** Current Time: Sat Jul 16 15:52:33 2022  Localwatchdog at: Mon Jul 18 13:01:33 2022 
  [10403.014340] restraintd[2193]: *** Current Time: Sat Jul 16 15:53:33 2022  Localwatchdog at: Mon Jul 18 13:01:33 2022 
  [10463.016180] restraintd[2193]: *** Current Time: Sat Jul 16 15:54:33 2022  Localwatchdog at: Mon Jul 18 13:01:33 2022 
  [-- MARK -- Sat Jul 16 19:55:00 2022] 
  [10523.017423] restraintd[2193]: *** Current Time: Sat Jul 16 15:55:33 2022  Localwatchdog at: Mon Jul 18 13:01:33 2022 
  [10583.015557] restraintd[2193]: *** Current Time: Sat Jul 16 15:56:33 2022  Localwatchdog at: Mon Jul 18 13:01:33 2022 
  [10643.014811] restraintd[2193]: *** Current Time: Sat Jul 16 15:57:33 2022  Localwatchdog at: Mon Jul 18 13:01:33 2022 
  [10703.009075] restraintd[2193]: *** Current Time: Sat Jul 16 15:58:33 2022  Localwatchdog at: Mon Jul 18 13:01:33 2022 
  [10752.278563] run fstests generic/477 at 2022-07-16 15:59:23
  ...

[2]
  The 1st layer fs: xfs - SCRATCH_DEV=/dev/loop1, SCRATCH_MNT=/mnt/fstests/SCRATCH_DIR
  meta-data=/dev/loop1             isize=512    agcount=4, agsize=655360 blks
           =                       sectsz=512   attr=2, projid32bit=1
           =                       crc=1        finobt=1, sparse=1, rmapbt=0
           =                       reflink=1    bigtime=1 inobtcount=1 nrext64=0
  data     =                       bsize=4096   blocks=2621440, imaxpct=25
           =                       sunit=0      swidth=0 blks
  naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
  log      =internal log           bsize=4096   blocks=16384, version=2
           =                       sectsz=512   sunit=0 blks, lazy-count=1
  realtime =none                   extsz=4096   blocks=0, rtextents=0
  Discarding blocks...Done.
  The 2nd layer fs: nfs - SCRATCH_DEV=s390x-kvm-xxx.xxx.xxx.xxxx.redhat.com:/mnt/fstests/SCRATCH_DIR/nfs-server, SCRATCH_MNT=/mnt/fstests/SCRATCH_DIR/nfs-client


> 
> 
> > Thanks,
> > Zorro
> > 
> >> _require_command "$KILLALL_PROG" "killall"
> >> 
> >> echo "Silence is golden."
> >> -- 
> >> 2.27.0
> >> 
> > 
> 
> --
> Chuck Lever
> 
> 
> 

