Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E08B057D33C
	for <lists+linux-nfs@lfdr.de>; Thu, 21 Jul 2022 20:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiGUSZz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 21 Jul 2022 14:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGUSZy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 21 Jul 2022 14:25:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C291D31B;
        Thu, 21 Jul 2022 11:25:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D25C61F55;
        Thu, 21 Jul 2022 18:25:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7498CC3411E;
        Thu, 21 Jul 2022 18:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658427951;
        bh=6IivW/vjozawUa25ebtVGMPUfktbfPMk9TrlB2hMIKU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=gGUdJbELJI4tNWlQf06hCA2lv3/tsycX1ul3n16uRr0ulHLStC7DqzXS8tPYLMjZX
         Ch2X96G8YRo78T1DMxvrguEu5LPrOZkf8+/k4Hn+K3xseRT11WrocETwlChx1BK2sw
         vyLUnrO4yeUzZsK9CmZCwg8oMkDJBKYqYp0mBfzVIHLWxJL+UvzKh2M5DHvVaLiDpo
         dNZPl4a2GcZRyqWQ2/uuJvpIXNiZnOd7rw7SMefMpBZwpc9yWd4kneuweCruoQl6i7
         vlmdOo3H/8IwoUIwPbhlt7ntL3xTFK2BD2u3tH1tmCN7kUukuFq0awWsO75LQLWeLu
         OzrjwRb+8qheg==
Message-ID: <ad7c2c2becfcbefba78ed88a63a02dd2d6d09d21.camel@kernel.org>
Subject: Re: [PATCH v1] generic/476: requires 27GB scratch size
From:   Jeff Layton <jlayton@kernel.org>
To:     Zorro Lang <zlang@redhat.com>,
        Chuck Lever III <chuck.lever@oracle.com>,
        linux-nfs@vger.kernel.org
Cc:     Boyang Xue <bxue@redhat.com>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Date:   Thu, 21 Jul 2022 14:25:48 -0400
In-Reply-To: <20220721163029.lmyrdbf7l3fpwdwu@zlang-mailbox>
References: <20220721022959.4189726-1-bxue@redhat.com>
         <20220721152909.otn3spgou5inzhoo@zlang-mailbox>
         <C3EC5E8E-C230-4720-BFCF-6497E088EF01@oracle.com>
         <20220721163029.lmyrdbf7l3fpwdwu@zlang-mailbox>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 (3.44.3-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, 2022-07-22 at 00:30 +0800, Zorro Lang wrote:
> On Thu, Jul 21, 2022 at 03:32:49PM +0000, Chuck Lever III wrote:
> >=20
> >=20
> > > On Jul 21, 2022, at 11:29 AM, Zorro Lang <zlang@redhat.com> wrote:
> > >=20
> > > On Thu, Jul 21, 2022 at 10:29:59AM +0800, bxue@redhat.com wrote:
> > > > From: Boyang Xue <bxue@redhat.com>
> > > >=20
> > > > The test requires larger scratch dev size when running on top of NF=
S other
> > > > than ext4 and xfs. It requires at least 27GB in my test. Without th=
is
> > > > requirement, the test run never finishes on NFS, leaving 100% scrat=
ch disk
> > > > space use.
> > > >=20
> > > > Signed-off-by: Boyang Xue <bxue@redhat.com>
> > > > ---
> > > > Hi,
> > > >=20
> > > > I find generic/476 easily goes into an infinite run on top of NFS. =
When it
> > > > happens, the common pattern is 100% disk space use of SCRATCH_MNT, =
and
> > > > `nfsiostat` shows 50% write error on SCRATCH_MNT. When I run it wit=
h a large
> > > > enough SCRATCH_MNT, the problem disappears. So I post this patch to=
 add the size
> > > > requirement.
> > > >=20
> > > > Please help review this patch. Thanks!
> > > >=20
> > > > -Boyang
> > > >=20
> > > > tests/generic/476 | 1 +
> > > > 1 file changed, 1 insertion(+)
> > > >=20
> > > > diff --git a/tests/generic/476 b/tests/generic/476
> > > > index 212373d1..dcc7c3da 100755
> > > > --- a/tests/generic/476
> > > > +++ b/tests/generic/476
> > > > @@ -24,6 +24,7 @@ _cleanup()
> > > > _supported_fs generic
> > > >=20
> > > > _require_scratch
> > > > +_require_scratch_size $((27 * 1024 * 1024)) # 27GB
> > >=20
> > > At first, most of other filesystems don't need this requirement, that=
 will
> > > reduce test coverage of other fs suddently. Second, there's not a cle=
ar
> > > reason to prove NFS (or others) need a 27+GB device to run this test.=
 Due to
> > > the generic/476 does nothing special, except random I/Os, even runnin=
g with
> > > ENOSPC...
> > >=20
> > > So one difference of running with small device or large enough device=
 is the
> > > chance to run with ENOSPC. I think the device size isn't the root cau=
se of
> > > nfs hang you hit, I doubt if it's a NFS bug with ENOSPC, or something=
 else
> > > bug which is triggered by someone random I/O operation.
> > >=20
> > > We'd better not to skip a known generic test (from upstream fstests d=
irectly)
> > > if without a clear reason. That might cause we miss bugs or test cove=
rage,
> > > better to make sure if it's a real bug at first. Then think about if =
we need
> > > to improve the case or fix a bug.
> >=20
> > +1
> >=20
> > I can help troubleshoot the NFS-related aspects of this further, if nee=
ded.
>=20
> Thanks Chuck, I think we'd better to cc linux-nfs list.
>=20
> I can reproduce generic/476 hang on nfs[0] too, with real disk or Virtio =
disk,
> it's not a loop device related issue. And sometimes it test passed[1], ev=
en with
> a 10G loop device[2] (which I/O speed is very fast). If you or nfs forks =
need
> full console log, I can provide. But I think it's easy to reproduce this =
bug
> by running generic/476 on a general nfs v4.2.
>=20
> Thanks,
> Zorro
>=20
> [0]
> [173303.753434] sysrq: Show Memory=20
> [173303.764679] Mem-Info:=20
> [173303.765683] active_anon:1872 inactive_anon:22756 isolated_anon:0=20
> [173303.765683]  active_file:47360 inactive_file:1230085 isolated_file:0=
=20
> [173303.765683]  unevictable:0 dirty:3 writeback:0=20
> [173303.765683]  slab_reclaimable:108117 slab_unreclaimable:100595=20
> [173303.765683]  mapped:11734 shmem:7363 pagetables:544 bounce:0=20
> [173303.765683]  kernel_misc_reclaimable:0=20
> [173303.765683]  free:49561 free_pcp:5112 free_cma:0=20
> [173303.780542] Node 0 active_anon:7488kB inactive_anon:91024kB active_fi=
le:189440kB inactive_file:4920340kB unevictable:0kB isolated(anon):0kB isol=
ated(file):0kB mapped:46936kB dirty:12kB writeback:0kB shmem:29452kB shmem_=
thp: 0kB shmem_pmdmapped: 0kB anon_thp: 18432kB writeback_tmp:0kB kernel_st=
ack:5920kB pagetables:2176kB all_unreclaimable? no=20
> [173303.790519] Node 0 DMA free:14336kB boost:0kB min:160kB low:200kB hig=
h:240kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_fi=
le:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15992kB m=
anaged:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0=
kB=20
> [173303.799060] lowmem_reserve[]: 0 2659 6183 6183 6183=20
> [173303.800781] Node 0 DMA32 free:123700kB boost:0kB min:28992kB low:3624=
0kB high:43488kB reserved_highatomic:0KB active_anon:12kB inactive_anon:145=
2kB active_file:61020kB inactive_file:2279284kB unevictable:0kB writependin=
g:8kB present:3129308kB managed:2801628kB mlocked:0kB bounce:0kB free_pcp:3=
508kB local_pcp:768kB free_cma:0kB=20
> [173303.810096] lowmem_reserve[]: 0 0 3524 3524 3524=20
> [173303.812131] Node 0 Normal free:60208kB boost:0kB min:38424kB low:4802=
8kB high:57632kB reserved_highatomic:2048KB active_anon:7476kB inactive_ano=
n:89572kB active_file:128420kB inactive_file:2641056kB unevictable:0kB writ=
epending:4kB present:5242880kB managed:3618860kB mlocked:0kB bounce:0kB fre=
e_pcp:16240kB local_pcp:4196kB free_cma:0kB=20
> [173303.822880] lowmem_reserve[]: 0 0 0 0 0=20
> [173303.824683] Node 0 DMA: 0*4kB 0*8kB 0*16kB 0*32kB 0*64kB 0*128kB 0*25=
6kB 0*512kB 0*1024kB 1*2048kB (M) 3*4096kB (M) =3D 14336kB=20
> [173303.829410] Node 0 DMA32: 1385*4kB (UME) 1254*8kB (UME) 368*16kB (UME=
) 317*32kB (UME) 121*64kB (UM) 105*128kB (UME) 99*256kB (UM) 63*512kB (UME)=
 13*1024kB (UME) 0*2048kB 0*4096kB =3D 123700kB=20
> [173303.836654] Node 0 Normal: 1056*4kB (UMEH) 1027*8kB (UMEH) 400*16kB (=
UMEH) 287*32kB (UMEH) 105*64kB (UMEH) 71*128kB (UM) 42*256kB (M) 10*512kB (=
M) 0*1024kB 0*2048kB 0*4096kB =3D 59704kB=20
> [173303.843268] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_s=
urp=3D0 hugepages_size=3D1048576kB=20
> [173303.846232] Node 0 hugepages_total=3D0 hugepages_free=3D0 hugepages_s=
urp=3D0 hugepages_size=3D2048kB=20
> [173303.849541] 1284815 total pagecache pages=20
> [173303.851713] 7 pages in swap cache=20
> [173303.853033] Swap cache stats: add 24, delete 17, find 0/1=20
> [173303.874135] Free swap  =3D 8257760kB=20
> [173303.875679] Total swap =3D 8258556kB=20
> [173303.877210] 2097045 pages RAM=20
> [173303.878574] 0 pages HighMem/MovableOnly=20
> [173303.880204] 488083 pages reserved=20
> [173303.881721] 0 pages cma reserved=20
> [173303.883181] 0 pages hwpoisoned=20
> [173311.514201] sysrq: Show State=20
> [173311.531486] task:systemd         state:S stack:23208 pid:    1 ppid: =
    0 flags:0x00000002=20
> [173311.535523] Call Trace:=20
> [173311.536988]  <TASK>=20
> [173311.537992]  __schedule+0x673/0x1540=20
> [173311.539782]  ? io_schedule_timeout+0x160/0x160=20
> [173311.541842]  schedule+0xe0/0x200=20
> [173311.543466]  schedule_hrtimeout_range_clock+0x2c0/0x310=20
> [173311.545632]  ? hrtimer_nanosleep_restart+0x170/0x170=20
> [173311.547948]  ? lock_downgrade+0x130/0x130=20
> [173311.549585]  ? lockdep_hardirqs_on_prepare.part.0+0x18c/0x370=20
> [173311.551686]  ep_poll+0x7db/0xa80=20
> [173311.552999]  ? ep_send_events+0x9f0/0x9f0=20
> [173311.555015]  ? pick_next_task_stop+0x250/0x250=20
> [173311.574734]  ? prepare_to_wait_exclusive+0x2c0/0x2c0=20
> [173311.576518]  ? __lock_release+0x4c1/0xa00=20
> [173311.579162]  do_epoll_wait+0x12f/0x160=20
> [173311.580973]  __x64_sys_epoll_wait+0x12e/0x250=20
> [173311.582599]  ? __x64_sys_epoll_pwait2+0x240/0x240=20
> [173311.584769]  ? lockdep_hardirqs_on_prepare.part.0+0x18c/0x370=20
> [173311.587348]  do_syscall_64+0x5c/0x90=20
> [173311.589335]  ? do_syscall_64+0x69/0x90=20
> [173311.591128]  ? lockdep_hardirqs_on+0x79/0x100=20
> [173311.593125]  ? do_syscall_64+0x69/0x90=20
> [173311.594805]  ? lockdep_hardirqs_on+0x79/0x100=20
> [173311.596598]  entry_SYSCALL_64_after_hwframe+0x63/0xcd=20
> [173311.598376] RIP: 0033:0x7f0a5834e7de=20
> [173311.599836] RSP: 002b:00007ffcee99d180 EFLAGS: 00000293 ORIG_RAX: 000=
00000000000e8=20
> [173311.603432] RAX: ffffffffffffffda RBX: 000056269d7b5b80 RCX: 00007f0a=
5834e7de=20
> [173311.605924] RDX: 00000000000000a6 RSI: 000056269da4f0d0 RDI: 00000000=
00000004=20
> [173311.608922] RBP: 000056269d7b5d10 R08: 0000000000000000 R09: 00000000=
0000000d=20
> [173311.611243] R10: 00000000ffffffff R11: 0000000000000293 R12: 00000000=
00000226=20
> [173311.613741] R13: 000056269d7b5b80 R14: 00000000000000a6 R15: 00000000=
00000037=20
> [173311.626581]  </TASK>=20
> [173311.627500] task:kthreadd        state:S stack:27704 pid:    2 ppid: =
    0 flags:0x00004000=20
> [173311.630191] Call Trace:=20
> [173311.631013]  <TASK>=20
> [173311.631872]  __schedule+0x673/0x1540=20
> [173311.633147]  ? io_schedule_timeout+0x160/0x160=20
> [173311.634725]  schedule+0xe0/0x200=20
> [173311.635884]  kthreadd+0x9fb/0xd60=20
> [173311.637204]  ? kthread_is_per_cpu+0xc0/0xc0=20
> [173311.638684]  ret_from_fork+0x22/0x30=20
> [173311.640320]  </TASK>=20
> [173311.641273] task:rcu_gp          state:I stack:29336 pid:    3 ppid: =
    2 flags:0x00004000=20
> [173311.645006] Workqueue:  0x0 (rcu_gp)=20
> [173311.646684] Call Trace:=20
> [173311.647756]  <TASK>=20
> [173311.648895]  __schedule+0x673/0x1540=20
> [173311.650435]  ? io_schedule_timeout+0x160/0x160=20
> [173311.652317]  schedule+0xe0/0x200=20
> [173311.653732]  rescuer_thread+0x662/0xb80=20
> [173311.656494]  ? _raw_spin_unlock_irqrestore+0x59/0x70=20
> [173311.658779]  ? worker_thread+0xed0/0xed0=20
> [173311.660381]  ? __kthread_parkme+0xcc/0x200=20
> [173311.662276]  ? worker_thread+0xed0/0xed0=20
> [173311.664182]  kthread+0x2a7/0x350=20
> [173311.665725]  ? kthread_complete_and_exit+0x20/0x20=20
> [173311.667519]  ret_from_fork+0x22/0x30=20
> [173311.669222]  </TASK>=20
> [173311.670098] task:rcu_par_gp      state:I stack:30888 pid:    4 ppid: =
    2 flags:0x00004000=20
> [173311.673101] Call Trace:=20
> [173311.673976]  <TASK>=20
> [173311.674868]  __schedule+0x673/0x1540=20
> [173311.676197]  ? io_schedule_timeout+0x160/0x160=20
> [173311.677805]  schedule+0xe0/0x200=20
> [173311.678991]  rescuer_thread+0x662/0xb80=20
> [173311.680502]  ? _raw_spin_unlock_irqrestore+0x59/0x70=20
> [173311.682222]  ? worker_thread+0xed0/0xed0
> ...
> (too many lines)
> ...
> [173319.787263] Showing all locks held in the system:=20
> [173319.788884] no locks held by systemd-journal/517.=20
> [173319.789881] 1 lock held by fsstress/663798:=20
> [173319.790895]  #0: ffff888130b68488 (sb_writers#16){.+.+}-{0:0}, at: ks=
ys_write+0xf9/0x1d0=20
> [173319.792551] 3 locks held by kworker/u8:2/666396:=20
> [173319.794275]  #0: ffff8881e4602f58 (&rq->__lock){-.-.}-{2:2}, at: raw_=
spin_rq_lock_nested+0x30/0x120=20
> [173319.795933]  #1: ffff8881e4e02f58 (&rq->__lock){-.-.}-{2:2}, at: raw_=
spin_rq_lock_nested+0x30/0x120=20
> [173319.797605]  #2: ffff8881009bc4f0 (&p->pi_lock){-.-.}-{2:2}, at: try_=
to_wake_up+0xb3/0xdd0=20
> [173319.799126] 3 locks held by 20_sysinfo/666628:=20
> [173319.799995]  #0: ffff88810c362488 (sb_writers#3){.+.+}-{0:0}, at: ksy=
s_write+0xf9/0x1d0=20
> [173319.801695]  #1: ffffffff860e6dc0 (rcu_read_lock){....}-{1:2}, at: __=
handle_sysrq+0x4a/0xe0=20
> [173319.803276]  #2: ffffffff860e6dc0 (rcu_read_lock){....}-{1:2}, at: rc=
u_lock_acquire.constprop.0+0x0/0x30=20
> [173319.804988] =20
> [173319.805319] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=20
> [173319.805319] =20
> [173319.806614] Showing busy workqueues and worker pools:=20
> [173319.807587] workqueue events_highpri: flags=3D0x10=20
> [173319.808538]   pwq 5: cpus=3D2 node=3D0 flags=3D0x0 nice=3D-20 active=
=3D1/256 refcnt=3D2=20
> [173319.808581]     pending: mix_interrupt_randomness=20
> [173328.255900] sysrq: Show Blocked State=20
> [173328.276745] task:fsstress        state:D stack:23416 pid:663798 ppid:=
663797 flags:0x00004002=20
> [173328.279713] Call Trace:=20
> [173328.280646]  <TASK>=20
> [173328.281768]  __schedule+0x673/0x1540=20
> [173328.283583]  ? io_schedule_timeout+0x160/0x160=20
> [173328.285898]  ? pick_next_task_stop+0x250/0x250=20
> [173328.288286]  schedule+0xe0/0x200=20
> [173328.289932]  schedule_timeout+0x19e/0x250=20
> [173328.291845]  ? usleep_range_state+0x190/0x190=20
> [173328.293563]  ? mark_held_locks+0xa5/0xf0=20
> [173328.295072]  ? lockdep_hardirqs_on_prepare.part.0+0x18c/0x370=20
> [173328.297228]  ? _raw_spin_unlock_irq+0x24/0x50=20
> [173328.299148]  __wait_for_common+0x381/0x540=20
> [173328.301081]  ? usleep_range_state+0x190/0x190=20
> [173328.303037]  ? out_of_line_wait_on_bit_timeout+0x170/0x170=20
> [173328.304937]  ? up_write+0x20/0x20=20
> [173328.306118]  ? nfs_file_direct_write+0xaef/0x1050 [nfs]=20
> [173328.308327]  wait_for_completion_killable+0x20/0x40=20
> [173328.310146]  nfs_file_direct_write+0xb2c/0x1050 [nfs]=20
> [173328.312009]  ? nfs_file_direct_read+0xaa0/0xaa0 [nfs]=20
> [173328.313878]  ? nfs_key_timeout_notify+0x3a/0x90 [nfs]=20
> [173328.315651]  ? __lock_acquire+0xb72/0x1870=20
> [173328.317032]  ? nfs_file_write+0xed/0x8c0 [nfs]=20
> [173328.318716]  new_sync_write+0x2ef/0x540=20
> [173328.320059]  ? new_sync_read+0x530/0x530=20
> [173328.321447]  ? lock_acquire+0x1d8/0x620=20
> [173328.322839]  ? rcu_read_unlock+0x40/0x40=20
> [173328.324309]  vfs_write+0x62a/0x920=20
> [173328.325592]  ksys_write+0xf9/0x1d0=20
> [173328.327621]  ? __ia32_sys_read+0xa0/0xa0=20
> [173328.328996]  ? ktime_get_coarse_real_ts64+0x130/0x170=20
> [173328.330746]  do_syscall_64+0x5c/0x90=20
> [173328.331998]  ? do_syscall_64+0x69/0x90=20
> [173328.333303]  ? lockdep_hardirqs_on+0x79/0x100=20
> [173328.335143]  ? do_syscall_64+0x69/0x90=20
> [173328.336483]  ? do_syscall_64+0x69/0x90=20
> [173328.338093]  ? lockdep_hardirqs_on+0x79/0x100=20
> [173328.340276]  ? do_syscall_64+0x69/0x90=20
> [173328.341683]  ? asm_sysvec_apic_timer_interrupt+0x16/0x20=20
> [173328.343466]  ? lockdep_hardirqs_on+0x79/0x100=20
> [173328.344989]  entry_SYSCALL_64_after_hwframe+0x63/0xcd=20
> [173328.346646] RIP: 0033:0x7f16be13e8c7=20
> [173328.347857] RSP: 002b:00007ffea1b02798 EFLAGS: 00000246 ORIG_RAX: 000=
0000000000001=20
> [173328.350228] RAX: ffffffffffffffda RBX: 0000000000100000 RCX: 00007f16=
be13e8c7=20
> [173328.352485] RDX: 0000000000100000 RSI: 0000000001c00000 RDI: 00000000=
00000003=20
> [173328.354769] RBP: 0000000000000003 R08: 0000000001d00000 R09: 00000000=
00000000=20
> [173328.357318] R10: 0000000000000100 R11: 0000000000000246 R12: 00000000=
00017de1=20
> [173328.359664] R13: 0000000000000000 R14: 0000000001c00000 R15: 00000000=
00000000=20
> [173328.362074]  </TASK>=20
>          Stopping        =20
> /usr/bin/bash -c =E2=80=A6j; exec ./tests/generic/476  =20
> ...
>=20
> [1]
>   [ 9746.410677] run fstests generic/476 at 2022-07-16 15:42:38
>   [ 9803.017543] restraintd[2193]: *** Current Time: Sat Jul 16 15:43:33 =
2022  Localwatchdog at: Mon Jul 18 13:01:33 2022=20
>   [ 9863.016020] restraintd[2193]: *** Current Time: Sat Jul 16 15:44:33 =
2022  Localwatchdog at: Mon Jul 18 13:01:33 2022=20
>   [-- MARK -- Sat Jul 16 19:45:00 2022]=20
>   [ 9923.014409] restraintd[2193]: *** Current Time: Sat Jul 16 15:45:33 =
2022  Localwatchdog at: Mon Jul 18 13:01:33 2022=20
>   [ 9983.016088] restraintd[2193]: *** Current Time: Sat Jul 16 15:46:33 =
2022  Localwatchdog at: Mon Jul 18 13:01:33 2022=20
>   [10043.014435] restraintd[2193]: *** Current Time: Sat Jul 16 15:47:33 =
2022  Localwatchdog at: Mon Jul 18 13:01:33 2022=20
>   [10103.017105] restraintd[2193]: *** Current Time: Sat Jul 16 15:48:33 =
2022  Localwatchdog at: Mon Jul 18 13:01:33 2022=20
>   [10163.057993] restraintd[2193]: *** Current Time: Sat Jul 16 15:49:33 =
2022  Localwatchdog at: Mon Jul 18 13:01:33 2022=20
>   [-- MARK -- Sat Jul 16 19:50:00 2022]=20
>   [10223.018212] restraintd[2193]: *** Current Time: Sat Jul 16 15:50:33 =
2022  Localwatchdog at: Mon Jul 18 13:01:33 2022=20
>   [10283.015296] restraintd[2193]: *** Current Time: Sat Jul 16 15:51:33 =
2022  Localwatchdog at: Mon Jul 18 13:01:33 2022=20
>   [10343.014956] restraintd[2193]: *** Current Time: Sat Jul 16 15:52:33 =
2022  Localwatchdog at: Mon Jul 18 13:01:33 2022=20
>   [10403.014340] restraintd[2193]: *** Current Time: Sat Jul 16 15:53:33 =
2022  Localwatchdog at: Mon Jul 18 13:01:33 2022=20
>   [10463.016180] restraintd[2193]: *** Current Time: Sat Jul 16 15:54:33 =
2022  Localwatchdog at: Mon Jul 18 13:01:33 2022=20
>   [-- MARK -- Sat Jul 16 19:55:00 2022]=20
>   [10523.017423] restraintd[2193]: *** Current Time: Sat Jul 16 15:55:33 =
2022  Localwatchdog at: Mon Jul 18 13:01:33 2022=20
>   [10583.015557] restraintd[2193]: *** Current Time: Sat Jul 16 15:56:33 =
2022  Localwatchdog at: Mon Jul 18 13:01:33 2022=20
>   [10643.014811] restraintd[2193]: *** Current Time: Sat Jul 16 15:57:33 =
2022  Localwatchdog at: Mon Jul 18 13:01:33 2022=20
>   [10703.009075] restraintd[2193]: *** Current Time: Sat Jul 16 15:58:33 =
2022  Localwatchdog at: Mon Jul 18 13:01:33 2022=20
>   [10752.278563] run fstests generic/477 at 2022-07-16 15:59:23
>   ...
>=20
> [2]
>   The 1st layer fs: xfs - SCRATCH_DEV=3D/dev/loop1, SCRATCH_MNT=3D/mnt/fs=
tests/SCRATCH_DIR
>   meta-data=3D/dev/loop1             isize=3D512    agcount=3D4, agsize=
=3D655360 blks
>            =3D                       sectsz=3D512   attr=3D2, projid32bit=
=3D1
>            =3D                       crc=3D1        finobt=3D1, sparse=3D=
1, rmapbt=3D0
>            =3D                       reflink=3D1    bigtime=3D1 inobtcoun=
t=3D1 nrext64=3D0
>   data     =3D                       bsize=3D4096   blocks=3D2621440, ima=
xpct=3D25
>            =3D                       sunit=3D0      swidth=3D0 blks
>   naming   =3Dversion 2              bsize=3D4096   ascii-ci=3D0, ftype=
=3D1
>   log      =3Dinternal log           bsize=3D4096   blocks=3D16384, versi=
on=3D2
>            =3D                       sectsz=3D512   sunit=3D0 blks, lazy-=
count=3D1
>   realtime =3Dnone                   extsz=3D4096   blocks=3D0, rtextents=
=3D0
>   Discarding blocks...Done.
>   The 2nd layer fs: nfs - SCRATCH_DEV=3Ds390x-kvm-xxx.xxx.xxx.xxxx.redhat=
.com:/mnt/fstests/SCRATCH_DIR/nfs-server, SCRATCH_MNT=3D/mnt/fstests/SCRATC=
H_DIR/nfs-client
>=20
>=20
>=20
>=20

Thanks Zorro. I'm having a look at this now:

https://bugzilla.redhat.com/show_bug.cgi?id=3D2028370

I'm pretty sure this is a client error handling bug of some sort. It
looks like the server is doing the right thing, but the client keeps
trying to reissue the same write over and over.
--=20
Jeff Layton <jlayton@kernel.org>
