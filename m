Return-Path: <linux-nfs+bounces-8835-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C789FDBD3
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Dec 2024 19:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7C9B3A1201
	for <lists+linux-nfs@lfdr.de>; Sat, 28 Dec 2024 18:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B63A18DF62;
	Sat, 28 Dec 2024 18:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TuLO0PGX"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFC82AE84;
	Sat, 28 Dec 2024 18:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735409870; cv=none; b=iKF0T4JCRLnkn0MtUeKs6bVqvzpb830ZMuksU80r6YVdwOQ10mk3/8xY5MueKgRdFxmUZUW8At++TQkLRfjzHcdI7msoDHnFxQ1szHfLuVDhaWFnb1gNFogs65WGB72Wz5q0iaIvZEblgKCkSG6PjmAwMmLVU7sqY9wNqdQ36wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735409870; c=relaxed/simple;
	bh=IdiWpsLMI9av2C3qkFh+du3EYoTbaOU7HXnDvRe+v1A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fTVAprthS6xGAi4G4Voa0GUk7fbL9SazDeu2a3cVJNyXTBFCy4JOQ6/SkZlTLyiE0B7eogvc+m2TpNRAjZUczmWEwELvmSwDWF4ddRs5/2oVApN7MHlKnpn6QNhOrWxb3EVb+3SJzW/tOASqMFGywjQy+NCCVSxRJ8rPDfNssaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TuLO0PGX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37659C4CECD;
	Sat, 28 Dec 2024 18:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735409869;
	bh=IdiWpsLMI9av2C3qkFh+du3EYoTbaOU7HXnDvRe+v1A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=TuLO0PGXwjAPLCU/I2YGb2pFBCSANfKQVGay+CawuSxsnhmtgf90EMfIAzeQomKhx
	 ue3kMD/8yKAYeerPogGx8L1LQJhz4GC5aaMf1pP4e5DPIvIiQYjlpT2Gsdhyk1f9YS
	 cJ9N2gpOKhb1Md2HZyk7AfMzkRpMXlt4M8k4FDZ5myaeZbiBLzkxauCbPnA227SY16
	 Hg7BnVnUTcWylX0kuhKivsBz6RUezhPX5NBOfxjTEK09k2hYWTFC7sQy49BZoog2D2
	 mTMc2lqZ8/vfhuMI6JEk07uy61qfJItP8zEoYLSGS0ej77SpQ1hyDn5J2Fy3ogs1bX
	 SfwB7tb7gcDQw==
Message-ID: <08a1b23e09df6d78975fe034652795b136342a37.camel@kernel.org>
Subject: Re: [cel:nfsd-testing] [nfsd] ab62726202: fsmark.app_overhead
 186.4% regression
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>, kernel test robot
	 <oliver.sang@intel.com>, NeilBrown <neilb@suse.de>
Cc: oe-lkp@lists.linux.dev, lkp@intel.com, linux-nfs@vger.kernel.org
Date: Sat, 28 Dec 2024 13:17:47 -0500
In-Reply-To: <eafd5b52-694c-4abb-8c2d-84094def4751@oracle.com>
References: <202412271641.cfba5666-lkp@intel.com>
	 <eafd5b52-694c-4abb-8c2d-84094def4751@oracle.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2024-12-28 at 12:32 -0500, Chuck Lever wrote:
> On 12/27/24 4:13 AM, kernel test robot wrote:
> >=20
> >=20
> > Hello,
> >=20
> > kernel test robot noticed a 186.4% regression of fsmark.app_overhead on=
:
> > (but no diff for fsmark.files_per_sec as below (a))
>=20
> Hello Oliver -
>=20
> I have questions about this test result.
>=20
> Is this https://github.com/josefbacik/fs_mark ?
>=20
> I don't understand what "app_overhead" is measuring. Is this "think
> time"?
>=20
> A more concerning regression might be:
>=20
>         13.03 =C2=B1170%    +566.0%      86.78 =C2=B1 77%
>=20
> perf-sched.wait_and_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.c=
onstprop.0.svc_tcp_sendto
>=20
> But these metrics look like they improved:
>=20
>          0.03 =C2=B1 56%     -73.4%       0.01 =C2=B1149%
> perf-sched.sch_delay.avg.ms.btrfs_commit_transaction.btrfs_sync_file.nfsd=
_commit.nfsd4_commit
>          0.05 =C2=B1 60%     -72.1%       0.02 =C2=B1165%
> perf-sched.sch_delay.max.ms.btrfs_commit_transaction.btrfs_sync_file.nfsd=
_commit.nfsd4_commit
>=20
> This is a quite mixed result, IMO -- I'm not convinced it's actionable.
> Can someone help explain/analyze the metrics?
>=20

I've spent some time staring at fs_mark [1] with the similar regression
reported due to the OPEN_XOR_DELEGATION patches.

It forks a bunch of processes and does a bunch of create/write/fsync,
etc. in a directory hierarchy, based on the command-line options.

"App overhead" in that program consists of this:

        total_file_ops =3D
            creat_usec + total_write_usec + fsync_usec + avg_sync_usec +
            close_usec;
        app_overhead_usec =3D loop_usecs - total_file_ops;

IOW, it measures the timing of various calls into the kernel and
tallies the time they took. It then subtracts the total of those from
the total time in the loop, and that's the "App overhead".

The problem I had was that the "App overhead" covers quite a bit of the
code (some of which does kernel syscalls too!). My effort at bracketing
where the increase came from didn't give me reliable results. I meant
to get back to it, but haven't had the time recently.

[1]: https://github.com/josefbacik/fs_mark

>=20
> > commit: ab627262022ed8c6a68e619ed03a14e47acf2e39 ("nfsd: allocate new s=
ession-based DRC slots on demand.")
> > https://git.kernel.org/cgit/linux/kernel/git/cel/linux nfsd-testing
> >=20
> > testcase: fsmark
> > config: x86_64-rhel-9.4
> > compiler: gcc-12
> > test machine: 64 threads 2 sockets Intel(R) Xeon(R) Gold 6346 CPU @ 3.1=
0GHz (Ice Lake) with 256G memory
> > parameters:
> >=20
> > 	iterations: 1x
> > 	nr_threads: 32t
> > 	disk: 1HDD
> > 	fs: btrfs
> > 	fs2: nfsv4
> > 	filesize: 16MB
> > 	test_size: 15G
> > 	sync_method: NoSync
> > 	nr_directories: 16d
> > 	nr_files_per_directory: 256fpd
> > 	cpufreq_governor: performance
> >=20
> >=20
> >=20
> >=20
> > If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> > the same patch/commit), kindly add following tags
> > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > Closes: https://lore.kernel.org/oe-lkp/202412271641.cfba5666-lkp@inte=
l.com
> >=20
> >=20
> > Details are as below:
> > -----------------------------------------------------------------------=
--------------------------->
> >=20
> >=20
> > The kernel config and materials to reproduce are available at:
> > https://download.01.org/0day-ci/archive/20241227/202412271641.cfba5666-=
lkp@intel.com
> >=20
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > compiler/cpufreq_governor/disk/filesize/fs2/fs/iterations/kconfig/nr_di=
rectories/nr_files_per_directory/nr_threads/rootfs/sync_method/tbox_group/t=
est_size/testcase:
> >    gcc-12/performance/1HDD/16MB/nfsv4/btrfs/1x/x86_64-rhel-9.4/16d/256f=
pd/32t/debian-12-x86_64-20240206.cgz/NoSync/lkp-icl-2sp7/15G/fsmark
> >=20
> > commit:
> >    ccd01c7601 ("nfsd: add session slot count to /proc/fs/nfsd/clients/*=
/info")
> >    ab62726202 ("nfsd: allocate new session-based DRC slots on demand.")
> >=20
> > ccd01c76017847d1 ab627262022ed8c6a68e619ed03
> > ---------------- ---------------------------
> >           %stddev     %change         %stddev
> >               \          |                \
> >        5.48 =C2=B1  9%     +24.9%       6.85 =C2=B1 14%  sched_debug.cp=
u.nr_uninterruptible.stddev
> >       12489           +11.1%      13876        uptime.idle
> >   3.393e+08 =C2=B1 16%    +186.4%  9.717e+08 =C2=B1  9%  fsmark.app_ove=
rhead
> >        6.40            +0.0%       6.40        fsmark.files_per_sec    =
 <-------- (a)
> >        6.00           +27.8%       7.67 =C2=B1  6%  fsmark.time.percent=
_of_cpu_this_job_got
> >       72.33           +15.8%      83.79        iostat.cpu.idle
> >       25.91 =C2=B1  3%     -44.3%      14.42 =C2=B1 11%  iostat.cpu.iow=
ait
> >       72.08           +11.6       83.64        mpstat.cpu.all.idle%
> >       26.18 =C2=B1  3%     -11.6       14.58 =C2=B1 11%  mpstat.cpu.all=
.iowait%
> >      153772 =C2=B1  5%     +19.1%     183126 =C2=B1  8%  meminfo.Direct=
Map4k
> >      156099           +19.5%     186594        meminfo.Dirty
> >      467358           -12.9%     406910 =C2=B1  2%  meminfo.Writeback
> >       72.35           +15.8%      83.79        vmstat.cpu.id
> >       25.90 =C2=B1  3%     -44.3%      14.41 =C2=B1 11%  vmstat.cpu.wa
> >       17.61 =C2=B1  3%     -45.8%       9.55 =C2=B1 10%  vmstat.procs.b
> >        5909 =C2=B1  2%      -6.2%       5545        vmstat.system.in
> >        0.03 =C2=B1 56%     -73.4%       0.01 =C2=B1149%  perf-sched.sch=
_delay.avg.ms.btrfs_commit_transaction.btrfs_sync_file.nfsd_commit.nfsd4_co=
mmit
> >        0.05 =C2=B1 60%     -72.1%       0.02 =C2=B1165%  perf-sched.sch=
_delay.max.ms.btrfs_commit_transaction.btrfs_sync_file.nfsd_commit.nfsd4_co=
mmit
> >        0.07 =C2=B1 41%     +36.1%       0.10 =C2=B1  8%  perf-sched.sch=
_delay.max.ms.schedule_preempt_disabled.rwsem_down_read_slowpath.down_read.=
btrfs_tree_read_lock_nested
> >       13.03 =C2=B1170%    +566.0%      86.78 =C2=B1 77%  perf-sched.wai=
t_and_delay.avg.ms.schedule_preempt_disabled.__mutex_lock.constprop.0.svc_t=
cp_sendto
> >      206.83 =C2=B1 14%     -31.5%     141.67 =C2=B1  6%  perf-sched.wai=
t_and_delay.count.rpc_wait_bit_killable.__wait_on_bit.out_of_line_wait_on_b=
it.__rpc_execute
> >        0.30 =C2=B1 62%     -82.1%       0.05 =C2=B1110%  perf-sched.wai=
t_time.avg.ms.handle_reserve_ticket.__reserve_bytes.btrfs_reserve_data_byte=
s.btrfs_check_data_free_space
> >        7.37 =C2=B1  4%     -15.8%       6.20 =C2=B1  4%  perf-stat.i.MP=
KI
> >       44.13 =C2=B1  2%      -2.9       41.25 =C2=B1  2%  perf-stat.i.ca=
che-miss-rate%
> >      103.65 =C2=B1  2%     +17.9%     122.17 =C2=B1  8%  perf-stat.i.cp=
u-migrations
> >      627.67 =C2=B1  3%     +25.4%     787.18 =C2=B1  6%  perf-stat.i.cy=
cles-between-cache-misses
> >        0.67            +3.7%       0.70        perf-stat.i.ipc
> >        1.35            +2.2%       1.38        perf-stat.overall.cpi
> >      373.39            +4.1%     388.79        perf-stat.overall.cycles=
-between-cache-misses
> >        0.74            -2.1%       0.73        perf-stat.overall.ipc
> >      102.89 =C2=B1  2%     +17.9%     121.32 =C2=B1  8%  perf-stat.ps.c=
pu-migrations
> >       39054           +19.0%      46460 =C2=B1  2%  proc-vmstat.nr_dirt=
y
> >       15139            +2.2%      15476        proc-vmstat.nr_kernel_st=
ack
> >       45710            +1.9%      46570        proc-vmstat.nr_slab_unre=
claimable
> >      116900           -13.5%     101162        proc-vmstat.nr_writeback
> >       87038           -18.2%      71185 =C2=B1  2%  proc-vmstat.nr_zone=
_write_pending
> >     6949807            -3.8%    6688660        proc-vmstat.numa_hit
> >     6882153            -3.8%    6622312        proc-vmstat.numa_local
> >    13471776            -2.0%   13204489        proc-vmstat.pgalloc_norm=
al
> >      584292            +3.8%     606391 =C2=B1  3%  proc-vmstat.pgfault
> >       25859            +9.8%      28392 =C2=B1  9%  proc-vmstat.pgreuse
> >        2.02 =C2=B1  8%      -0.3        1.71 =C2=B1  5%  perf-profile.c=
alltrace.cycles-pp.asm_sysvec_apic_timer_interrupt.cpuidle_enter_state.cpui=
dle_enter.cpuidle_idle_call.do_idle
> >        1.86 =C2=B1  8%      -0.3        1.58 =C2=B1  6%  perf-profile.c=
alltrace.cycles-pp.sysvec_apic_timer_interrupt.asm_sysvec_apic_timer_interr=
upt.cpuidle_enter_state.cpuidle_enter.cpuidle_idle_call
> >        3.42 =C2=B1  5%      -0.6        2.87 =C2=B1  5%  perf-profile.c=
hildren.cycles-pp.asm_sysvec_apic_timer_interrupt
> >        2.96 =C2=B1  4%      -0.4        2.55 =C2=B1  5%  perf-profile.c=
hildren.cycles-pp.sysvec_apic_timer_interrupt
> >        0.35 =C2=B1 45%      -0.2        0.14 =C2=B1 71%  perf-profile.c=
hildren.cycles-pp.khugepaged
> >        0.34 =C2=B1 46%      -0.2        0.14 =C2=B1 71%  perf-profile.c=
hildren.cycles-pp.hpage_collapse_scan_pmd
> >        0.34 =C2=B1 46%      -0.2        0.14 =C2=B1 71%  perf-profile.c=
hildren.cycles-pp.khugepaged_scan_mm_slot
> >        0.34 =C2=B1 47%      -0.2        0.14 =C2=B1 72%  perf-profile.c=
hildren.cycles-pp.collapse_huge_page
> >        1.21 =C2=B1 10%      -0.2        1.01 =C2=B1  8%  perf-profile.c=
hildren.cycles-pp.__hrtimer_run_queues
> >        0.82 =C2=B1  9%      -0.1        0.68 =C2=B1 10%  perf-profile.c=
hildren.cycles-pp.update_process_times
> >        0.41 =C2=B1  8%      -0.1        0.29 =C2=B1 22%  perf-profile.c=
hildren.cycles-pp.btrfs_check_data_free_space
> >        0.21 =C2=B1  7%      -0.1        0.11 =C2=B1 73%  perf-profile.c=
hildren.cycles-pp.copy_mc_enhanced_fast_string
> >        0.55 =C2=B1 11%      -0.1        0.46 =C2=B1 14%  perf-profile.c=
hildren.cycles-pp.__set_extent_bit
> >        0.33 =C2=B1  9%      -0.1        0.28 =C2=B1  8%  perf-profile.c=
hildren.cycles-pp.nfs_request_add_commit_list
> >        0.17 =C2=B1  9%      -0.0        0.13 =C2=B1 16%  perf-profile.c=
hildren.cycles-pp.readn
> >        0.08 =C2=B1 13%      -0.0        0.06 =C2=B1 14%  perf-profile.c=
hildren.cycles-pp.load_elf_interp
> >        1.00 =C2=B1 16%      +1.2        2.18 =C2=B1 53%  perf-profile.c=
hildren.cycles-pp.folio_batch_move_lru
> >        0.21 =C2=B1  8%      -0.1        0.11 =C2=B1 73%  perf-profile.s=
elf.cycles-pp.copy_mc_enhanced_fast_string
> >        0.05 =C2=B1 49%      +0.1        0.15 =C2=B1 61%  perf-profile.s=
elf.cycles-pp.nfs_update_folio
> >        0.94 =C2=B1  5%      +0.2        1.11 =C2=B1  4%  perf-profile.s=
elf.cycles-pp._raw_spin_lock_irqsave
> >        0.25 =C2=B1 17%      +0.4        0.63 =C2=B1 61%  perf-profile.s=
elf.cycles-pp.nfs_page_async_flush
> >=20
> >=20
> >=20
> >=20
> > Disclaimer:
> > Results have been estimated based on internal Intel analysis and are pr=
ovided
> > for informational purposes only. Any difference in system hardware or s=
oftware
> > design or configuration may affect actual performance.
> >=20
> >=20
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

