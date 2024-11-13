Return-Path: <linux-nfs+bounces-7931-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0189A9C7853
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Nov 2024 17:10:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86BD91F2578C
	for <lists+linux-nfs@lfdr.de>; Wed, 13 Nov 2024 16:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C90A515B987;
	Wed, 13 Nov 2024 16:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GY41XLhO"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE631547D4;
	Wed, 13 Nov 2024 16:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731514237; cv=none; b=Q8FP/jfXxOAFbLJ3ZeMhsCTyTTVaB5lW0t7v8OK00+jOR323+7gjWxY7yz9QSwhb27E0YQu2jB7+XWf8qrVZRvy/7+k7whkrVRRs5vzpqRixppJogHTI304R8zYu+V4cl6/10+nE4Ve7/iYbeO/TbRFHFwSYiOXATXbTVfY2mXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731514237; c=relaxed/simple;
	bh=K7W5PoLh2TImy6dsPZoMot/j0CZyQL0pSCoDiEA1sro=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f3LJLI/+6gbwkU8X/xPpZ09c1vLwBwkgrj9xnfRMRAtUr6/UgIRMv35HTD/QInymvMjnVs0XD29Y01rGDRzukKfBesGUxTJ3vbgX+/7fuzzK78ZVzxYD/rnqX6/zwknkNnX45wzXz1cumS37awO7nmdqbIJ/Kt57nAIYhX6ndYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GY41XLhO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED1FC4CEC3;
	Wed, 13 Nov 2024 16:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731514237;
	bh=K7W5PoLh2TImy6dsPZoMot/j0CZyQL0pSCoDiEA1sro=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=GY41XLhO1XWiZAKxQjFTQUt+gjS+pU50XGxLuBHgmj8D6sPgx8KfS6Atws8CJHPd7
	 7aIT9ku0OUpClIc/C+VraoSTlOEyG3nxqrQu9bjTCAOsTDJW6u8wQcPbrPCocTjBkk
	 Aj+SOap5KDmPKvqN+Pl2XR9xzelF18aAc8YIdx6s4Y6jbkI2ufIaq2KuZNJQK+LH4B
	 EtUSOsDT31QHz3nDHo7ToLG6IJ5mPx2h/nDj7RtXKcVxZZrIqm0kbNFS5NJLGiDMLz
	 HPuBTLc8BZLgf0+2xNa/i5BCgTNYAZg2nUino/+GTplqlhlLGPTQCg+lAz5rSb3lMR
	 XEkJZnpa9cIiQ==
Message-ID: <48ad2574e14c35aca27c10e68f2a1069ccb646df.camel@kernel.org>
Subject: Re: [snitzer:cel-nfsd-next-6.12-rc5] [nfsd]  b4be3ccf1c:
 fsmark.app_overhead 92.0% regression
From: Jeff Layton <jlayton@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: kernel test robot <oliver.sang@intel.com>, Mike Snitzer
 <snitzer@redhat.com>,  oe-lkp@lists.linux.dev, lkp@intel.com, Anna
 Schumaker <anna@kernel.org>, Trond Myklebust
 <trond.myklebust@primarydata.com>, Thomas Haynes <loghyr@gmail.com>, 
 linux-nfs@vger.kernel.org
Date: Wed, 13 Nov 2024 11:10:35 -0500
In-Reply-To: <ZzTKQGYJFh7PH4Fw@tissot.1015granger.net>
References: <202411071017.ddd9e9e2-oliver.sang@intel.com>
	 <4d5d966b2efc0b5b8c59ef179e99f3f8fbf792f8.camel@kernel.org>
	 <ZzTKQGYJFh7PH4Fw@tissot.1015granger.net>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-11-13 at 10:48 -0500, Chuck Lever wrote:
> On Thu, Nov 07, 2024 at 06:35:11AM -0500, Jeff Layton wrote:
> > On Thu, 2024-11-07 at 12:55 +0800, kernel test robot wrote:
> > > hi, Jeff Layton,
> > >=20
> > > in commit message, it is mentioned the change is expected to solve th=
e
> > > "App Overhead" on the fs_mark test we reported in
> > > https://lore.kernel.org/oe-lkp/202409161645.d44bced5-oliver.sang@inte=
l.com/
> > >=20
> > > however, in our tests, there is sill similar regression. at the same
> > > time, there is still no performance difference for fsmark.files_per_s=
ec
> > >=20
> > >    2015880 =C2=B1  3%     +92.0%    3870164        fsmark.app_overhea=
d
> > >      18.57            +0.0%      18.57        fsmark.files_per_sec
> > >=20
> > >=20
> > > another thing is our bot bisect to this commit in repo/branch as belo=
w detail
> > > information. if there is a more porper repo/branch to test the patch,=
 could
> > > you let us know? thanks a lot!
> > >=20
> > >=20
> > >=20
> > > Hello,
> > >=20
> > > kernel test robot noticed a 92.0% regression of fsmark.app_overhead o=
n:
> > >=20
> > >=20
> > > commit: b4be3ccf1c251cbd3a3cf5391a80fe3a5f6f075e ("nfsd: implement OP=
EN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_DELEGATION")
> > > https://git.kernel.org/cgit/linux/kernel/git/snitzer/linux.git cel-nf=
sd-next-6.12-rc5
> > >=20
> > >=20
> > > testcase: fsmark
> > > config: x86_64-rhel-8.3
> > > compiler: gcc-12
> > > test machine: 128 threads 2 sockets Intel(R) Xeon(R) Platinum 8358 CP=
U @ 2.60GHz (Ice Lake) with 128G memory
> > > parameters:
> > >=20
> > > 	iterations: 1x
> > > 	nr_threads: 1t
> > > 	disk: 1HDD
> > > 	fs: btrfs
> > > 	fs2: nfsv4
> > > 	filesize: 4K
> > > 	test_size: 40M
> > > 	sync_method: fsyncBeforeClose
> > > 	nr_files_per_directory: 1fpd
> > > 	cpufreq_governor: performance
> > >=20
> > >=20
> > >=20
> > >=20
> > > If you fix the issue in a separate patch/commit (i.e. not just a new =
version of
> > > the same patch/commit), kindly add following tags
> > > > Reported-by: kernel test robot <oliver.sang@intel.com>
> > > > Closes: https://lore.kernel.org/oe-lkp/202411071017.ddd9e9e2-oliver=
.sang@intel.com
> > >=20
> > >=20
> > > Details are as below:
> > > ---------------------------------------------------------------------=
----------------------------->
> > >=20
> > >=20
> > > The kernel config and materials to reproduce are available at:
> > > https://download.01.org/0day-ci/archive/20241107/202411071017.ddd9e9e=
2-oliver.sang@intel.com
> > >=20
> > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > compiler/cpufreq_governor/disk/filesize/fs2/fs/iterations/kconfig/nr_=
files_per_directory/nr_threads/rootfs/sync_method/tbox_group/test_size/test=
case:
> > >   gcc-12/performance/1HDD/4K/nfsv4/btrfs/1x/x86_64-rhel-8.3/1fpd/1t/d=
ebian-12-x86_64-20240206.cgz/fsyncBeforeClose/lkp-icl-2sp6/40M/fsmark
> > >=20
> > > commit:=20
> > >   37f27b20cd ("nfsd: add support for FATTR4_OPEN_ARGUMENTS")
> > >   b4be3ccf1c ("nfsd: implement OPEN_ARGS_SHARE_ACCESS_WANT_OPEN_XOR_D=
ELEGATION")
> > >=20
> > > 37f27b20cd64e2e0 b4be3ccf1c251cbd3a3cf5391a8=20
> > > ---------------- ---------------------------=20
> > >          %stddev     %change         %stddev
> > >              \          |                \ =20
> > >      97.33 =C2=B1  9%     -16.3%      81.50 =C2=B1  9%  perf-c2c.HITM=
.local
> > >       3788 =C2=B1101%    +147.5%       9377 =C2=B1  6%  sched_debug.c=
fs_rq:/.load_avg.max
> > >       2936            -6.2%       2755        vmstat.system.cs
> > >    2015880 =C2=B1  3%     +92.0%    3870164        fsmark.app_overhea=
d
> > >      18.57            +0.0%      18.57        fsmark.files_per_sec
> > >      53420           -17.3%      44185        fsmark.time.voluntary_c=
ontext_switches
> > >       1.50 =C2=B1  7%     +13.4%       1.70 =C2=B1  3%  perf-sched.wa=
it_time.avg.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
> > >       3.00 =C2=B1  7%     +13.4%       3.40 =C2=B1  3%  perf-sched.wa=
it_time.max.ms.devkmsg_read.vfs_read.ksys_read.do_syscall_64
> > >    1756957            -2.1%    1720536        proc-vmstat.numa_hit
> > >    1624496            -2.2%    1588039        proc-vmstat.numa_local
> > >       1.28 =C2=B1  4%      -8.2%       1.17 =C2=B1  3%  perf-stat.i.M=
PKI
> > >       2916            -6.2%       2735        perf-stat.i.context-swi=
tches
> > >       1529 =C2=B1  4%      +8.2%       1655 =C2=B1  3%  perf-stat.i.c=
ycles-between-cache-misses
> > >       2910            -6.2%       2729        perf-stat.ps.context-sw=
itches
> > >       0.67 =C2=B1 15%      -0.4        0.27 =C2=B1100%  perf-profile.=
calltrace.cycles-pp._Fork
> > >       0.95 =C2=B1 15%      +0.3        1.26 =C2=B1 11%  perf-profile.=
calltrace.cycles-pp.__sched_setaffinity.sched_setaffinity.__x64_sys_sched_s=
etaffinity.do_syscall_64.entry_SYSCALL_64_after_hwframe
> > >       0.70 =C2=B1 47%      +0.3        1.04 =C2=B1  9%  perf-profile.=
calltrace.cycles-pp._nohz_idle_balance.do_idle.cpu_startup_entry.start_seco=
ndary.common_startup_64
> > >       0.52 =C2=B1 45%      +0.3        0.86 =C2=B1 15%  perf-profile.=
calltrace.cycles-pp.seq_read_iter.vfs_read.ksys_read.do_syscall_64.entry_SY=
SCALL_64_after_hwframe
> > >       0.72 =C2=B1 50%      +0.4        1.12 =C2=B1 18%  perf-profile.=
calltrace.cycles-pp.link_path_walk.path_openat.do_filp_open.do_sys_openat2.=
__x64_sys_openat
> > >       1.22 =C2=B1 26%      +0.4        1.67 =C2=B1 12%  perf-profile.=
calltrace.cycles-pp.sched_setaffinity.evlist_cpu_iterator__next.read_counte=
rs.process_interval.dispatch_events
> > >       2.20 =C2=B1 11%      +0.6        2.78 =C2=B1 13%  perf-profile.=
calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.read
> > >       2.20 =C2=B1 11%      +0.6        2.82 =C2=B1 12%  perf-profile.=
calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.read
> > >       2.03 =C2=B1 13%      +0.6        2.67 =C2=B1 13%  perf-profile.=
calltrace.cycles-pp.ksys_read.do_syscall_64.entry_SYSCALL_64_after_hwframe.=
read
> > >       0.68 =C2=B1 15%      -0.2        0.47 =C2=B1 19%  perf-profile.=
children.cycles-pp._Fork
> > >       0.56 =C2=B1 15%      -0.1        0.42 =C2=B1 16%  perf-profile.=
children.cycles-pp.tcp_v6_do_rcv
> > >       0.46 =C2=B1 13%      -0.1        0.35 =C2=B1 16%  perf-profile.=
children.cycles-pp.alloc_pages_mpol_noprof
> > >       0.10 =C2=B1 75%      +0.2        0.29 =C2=B1 19%  perf-profile.=
children.cycles-pp.refresh_cpu_vm_stats
> > >       0.28 =C2=B1 33%      +0.2        0.47 =C2=B1 16%  perf-profile.=
children.cycles-pp.show_stat
> > >       0.34 =C2=B1 32%      +0.2        0.54 =C2=B1 16%  perf-profile.=
children.cycles-pp.fold_vm_numa_events
> > >       0.37 =C2=B1 11%      +0.3        0.63 =C2=B1 23%  perf-profile.=
children.cycles-pp.setup_items_for_insert
> > >       0.88 =C2=B1 15%      +0.3        1.16 =C2=B1 12%  perf-profile.=
children.cycles-pp.__set_cpus_allowed_ptr
> > >       0.37 =C2=B1 14%      +0.3        0.67 =C2=B1 61%  perf-profile.=
children.cycles-pp.btrfs_writepages
> > >       0.37 =C2=B1 14%      +0.3        0.67 =C2=B1 61%  perf-profile.=
children.cycles-pp.extent_write_cache_pages
> > >       0.64 =C2=B1 19%      +0.3        0.94 =C2=B1 15%  perf-profile.=
children.cycles-pp.btrfs_insert_empty_items
> > >       0.38 =C2=B1 12%      +0.3        0.68 =C2=B1 58%  perf-profile.=
children.cycles-pp.btrfs_fdatawrite_range
> > >       0.32 =C2=B1 23%      +0.3        0.63 =C2=B1 64%  perf-profile.=
children.cycles-pp.extent_writepage
> > >       0.97 =C2=B1 14%      +0.3        1.31 =C2=B1 10%  perf-profile.=
children.cycles-pp.__sched_setaffinity
> > >       1.07 =C2=B1 16%      +0.4        1.44 =C2=B1 10%  perf-profile.=
children.cycles-pp.__x64_sys_sched_setaffinity
> > >       1.39 =C2=B1 18%      +0.5        1.90 =C2=B1 12%  perf-profile.=
children.cycles-pp.seq_read_iter
> > >       0.34 =C2=B1 30%      +0.2        0.52 =C2=B1 16%  perf-profile.=
self.cycles-pp.fold_vm_numa_events
> > >=20
> > >=20
> > >=20
> > >=20
> > > Disclaimer:
> > > Results have been estimated based on internal Intel analysis and are =
provided
> > > for informational purposes only. Any difference in system hardware or=
 software
> > > design or configuration may affect actual performance.
> > >=20
> > >=20
> >=20
> > This patch (b4be3ccf1c) is exceedingly simple, so I doubt it's causing
> > a performance regression in the server. The only thing I can figure
> > here is that this test is causing the server to recall the delegation
> > that it hands out, and then the client has to go and establish a new
> > open stateid in order to return it. That would likely be slower than
> > just handing out both an open and delegation stateid in the first
> > place.
> >=20
> > I don't think there is anything we can do about that though, since the
> > feature seems to is working as designed.
>=20
> We seem to have hit this problem before. That makes me wonder
> whether it is actually worth supporting the XOR flag at all. After
> all, the client sends the CLOSE asynchronously; applications are not
> being held up while the unneeded state ID is returned.
>=20
> Can XOR support be disabled for now? I don't want to add an
> administrative interface for that, but also, "no regressions" is
> ringing in my ears, and 92% is a mighty noticeable one.
>=20
>=20

To be clear, this increase is for the "App Overhead" which is all of
the operations between the stuff that is being measured in this test. I
did run this test for a bit and got similar results, but was never able
to nail down where the overhead came from. My speculation is that it's
the recall and reestablishment of an open stateid that slows things
down, but I never could fully confirm it.

My issue with disabling this is that the decision of whether to set
OPEN_XOR_DELEGATION is up to the client. The server in this case is
just doing what the client asks. ISTM that if we were going to disable
(or throttle) this anywhere, that should be done by the client.

--=20
Jeff Layton <jlayton@kernel.org>

