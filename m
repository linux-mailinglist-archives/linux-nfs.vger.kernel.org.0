Return-Path: <linux-nfs+bounces-7854-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7D89C4027
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 15:02:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 037F1B21B01
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 14:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA4B19E97E;
	Mon, 11 Nov 2024 14:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mpylOUx3"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874EC19E960
	for <linux-nfs@vger.kernel.org>; Mon, 11 Nov 2024 14:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731333760; cv=none; b=G3zUhVvfzYn+BfJ3kWhrXHAZkS2O/z2tyOZYSQfNL6CvQf47fwPq/O4mWdGVx7Y7XX4/WFqMVGjF7TdsHdfn32KCULTz8UvVlfiEBFKX8nKT9StTQdUbuh08ywnODE6YAdY/OM3squcE2JINjnqxrNbIfBO1YedQA/kMhDd7laU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731333760; c=relaxed/simple;
	bh=Fk37S/b79nqM2vPZIaVy3Rq+19MyVKOv1VY35YwQvW8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uopSQg8oe7HCxFhwHdqujTdERgOoS7W1otfyzhzfOiy2b/deUDgD0aKihws/NIFunfWx89t0oYg8Pv8t357012o9OspP1j47t52MoWQgjZJGfstkdQkV0CBbLziTY3Xt+0KwWdWmlOaQb9cA/ww653Ci6Tg3S3w5jqa4k2sD12k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mpylOUx3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98381C4CED7;
	Mon, 11 Nov 2024 14:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731333760;
	bh=Fk37S/b79nqM2vPZIaVy3Rq+19MyVKOv1VY35YwQvW8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=mpylOUx3D7TYZ2C1mI8Fb8hxWgNPauFGB+TCc+KBDk+Zh3UfDFztqENsyvqJBCm0S
	 z9lFp94iK+p9QRR6sqflfuYsTY8hsSOHUaLSyT7BC0I1qlNMxLGUoWAhy9EyLfAE6R
	 618b+kQ1EI9hBHP9zjaSWQ7AewOdm3Udkalb+K3Ner5XToxtlPq3d49isDlta1f322
	 GF1Ay0xRU0FXRS4YfUX/mzg6Q7gU5WZLJ6dTUPIqJ/fChvbQe7cLlED0rj2fu1dok3
	 aH6HhD5XqCMCS5lDZVcTpHGjedr2cPqksERPhOcKSoZgVs1O2a3m4nIs5I5UJyti0R
	 9YBEk78AsCvJQ==
Message-ID: <d6dcf462ab4cb1fa3fd8393bb607ad2205d4ff09.camel@kernel.org>
Subject: Re: [bug report from fstests] BUG: sleeping function called from
 invalid context at fs/nfsd/filecache.c:360
From: Jeff Layton <jlayton@kernel.org>
To: Zorro Lang <zlang@redhat.com>, linux-nfs@vger.kernel.org
Cc: Mike Snitzer <snitzer@kernel.org>, Chuck Lever <chuck.lever@oracle.com>
Date: Mon, 11 Nov 2024 09:02:38 -0500
In-Reply-To: <20241111125711.7ux6eywuk7nxo5hl@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
References: 
	<20241111125711.7ux6eywuk7nxo5hl@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41app1) 
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-11-11 at 20:57 +0800, Zorro Lang wrote:
> Lots of fstests cases fail on nfs, e.g. [1]. The dmesg output as [2].
> I tested on linux v6.12-rc6+, with HEAD=3Dda4373fbcf006deda90e5e6a87c499e=
0ff747572
>=20
> Thanks,
> Zorro
>=20

This looks wrong:

static inline void nfs_to_nfsd_file_put_local(struct nfsd_file *localio)   =
                        =20
{                                                                          =
                        =20
        /*                                                                 =
                        =20
         * Once reference to nfsd_serv is dropped, NFSD could be           =
                        =20
         * unloaded, so ensure safe return from nfsd_file_put_local()      =
                        =20
         * by always taking RCU.                                           =
                        =20
         */                                                                =
                        =20
        rcu_read_lock();                                                   =
                        =20
        nfs_to->nfsd_file_put_local(localio);                              =
                        =20
        rcu_read_unlock();                                                 =
                        =20
}   =20

nfsd_file_put_local() calls nfsd_file_put, which can sleep. What
exactly is the scenario that you're guarding against with the RCU read
lock?


>=20
> [1]
> FSTYP         -- nfs
> PLATFORM      -- Linux/aarch64 hpe-apollo-cn99xx-14-vm-04 6.12.0-rc6+ #1 =
SMP PREEMPT_DYNAMIC Sat Nov  9 16:18:01 EST 2024
> MKFS_OPTIONS  -- hpe-apollo-cn99xx-14-vm-04.khw.eng.rdu2.dc.redhat.com:/m=
nt/xfstests/scratch/nfs-server
> MOUNT_OPTIONS -- -o vers=3D4.2 -o context=3Dsystem_u:object_r:root_t:s0 h=
pe-apollo-cn99xx-14-vm-04.khw.eng.rdu2.dc.redhat.com:/mnt/xfstests/scratch/=
nfs-server /mnt/xfstests/scratch/nfs-client
>=20
> generic/001       _check_dmesg: something found in dmesg (see /var/lib/xf=
stests/results//generic/001.dmesg)
>=20
> Ran: generic/001
> Failures: generic/001
> Failed 1 of 1 tests
>=20
> [2]
> #cat /var/lib/xfstests/results//generic/001.dmesg
> [  637.512336] run fstests generic/001 at 2024-11-09 13:32:14
> [  638.266054] BUG: sleeping function called from invalid context at fs/n=
fsd/filecache.c:360
> [  638.274310] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 233=
, name: kworker/u128:23
> [  638.282860] preempt_count: 0, expected: 0
> [  638.286897] RCU nest depth: 1, expected: 0
> [  638.291023] 3 locks held by kworker/u128:23/233:
> [  638.295666]  #0: ff110001a2e64958 ((wq_completion)nfslocaliod){+.+.}-{=
0:0}, at: process_one_work+0x7f0/0x1340
> [  638.305619]  #1: ffa000000161fd90 ((work_completion)(&iocb->work)){+.+=
.}-{0:0}, at: process_one_work+0xd27/0x1340
> [  638.315901]  #2: ffffffff9c935ec0 (rcu_read_lock){....}-{1:2}, at: nfs=
_local_pgio_release+0x6e/0x2c0 [nfs]
> [  638.325645] CPU: 13 UID: 0 PID: 233 Comm: kworker/u128:23 Kdump: loade=
d Not tainted 6.12.0-rc6+ #1
> [  638.334615] Hardware name: Dell Inc. PowerEdge R660/0R5JJC, BIOS 2.1.5=
 03/14/2024
> [  638.342113] Workqueue: nfslocaliod nfs_local_call_write [nfs]
> [  638.347909] Call Trace:
> [  638.350364]  <TASK>
> [  638.352490]  ? nfs_local_call_write+0x649/0xd90 [nfs]
> [  638.357589]  dump_stack_lvl+0x6f/0xb0
> [  638.361277]  __might_resched.cold+0x1ec/0x232
> [  638.365651]  ? __pfx___might_resched+0x10/0x10
> [  638.370123]  nfsd_file_put+0x27/0x220 [nfsd]
> [  638.374476]  nfsd_file_put_local+0x35/0x50 [nfsd]
> [  638.379244]  nfs_local_pgio_release+0xe0/0x2c0 [nfs]
> [  638.384261]  nfs_local_call_write+0x572/0xd90 [nfs]
> [  638.389189]  ? __pfx_nfs_local_call_write+0x10/0x10 [nfs]
> [  638.394635]  ? trace_lock_acquire+0x1b9/0x280
> [  638.399016]  ? rcu_is_watching+0x15/0xb0
> [  638.402967]  process_one_work+0xd70/0x1340
> [  638.407098]  ? __pfx_process_one_work+0x10/0x10
> [  638.411655]  ? assign_work+0x16c/0x240
> [  638.415428]  worker_thread+0x5e6/0xfc0
> [  638.419207]  ? __pfx_worker_thread+0x10/0x10
> [  638.423492]  kthread+0x2d2/0x3a0
> [  638.426744]  ? _raw_spin_unlock_irq+0x28/0x50
> [  638.431119]  ? __pfx_kthread+0x10/0x10
> [  638.434894]  ret_from_fork+0x31/0x70
> [  638.438487]  ? __pfx_kthread+0x10/0x10
> [  638.442258]  ret_from_fork_asm+0x1a/0x30
> [  638.446206]  </TASK>
> [  639.282949] BUG: sleeping function called from invalid context at fs/n=
fsd/filecache.c:360
> [  639.291169] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 233=
, name: kworker/u128:23
> [  639.299722] preempt_count: 0, expected: 0
> [  639.303764] RCU nest depth: 1, expected: 0
> [  639.307889] 3 locks held by kworker/u128:23/233:
> [  639.312533]  #0: ff110001a2e64958 ((wq_completion)nfslocaliod){+.+.}-{=
0:0}, at: process_one_work+0x7f0/0x1340
> [  639.322500]  #1: ffa000000161fd90 ((work_completion)(&iocb->work)){+.+=
.}-{0:0}, at: process_one_work+0xd27/0x1340
> [  639.332797]  #2: ffffffff9c935ec0 (rcu_read_lock){....}-{1:2}, at: nfs=
_local_pgio_release+0x6e/0x2c0 [nfs]
> [  639.342546] CPU: 14 UID: 0 PID: 233 Comm: kworker/u128:23 Kdump: loade=
d Tainted: G        W          6.12.0-rc6+ #1
> [  639.352989] Tainted: [W]=3DWARN
> [  639.355979] Hardware name: Dell Inc. PowerEdge R660/0R5JJC, BIOS 2.1.5=
 03/14/2024
> [  639.363477] Workqueue: nfslocaliod nfs_local_call_write [nfs]
> [  639.369273] Call Trace:
> [  639.371746]  <TASK>
> [  639.373869]  ? nfs_local_call_write+0x649/0xd90 [nfs]
> [  639.378964]  dump_stack_lvl+0x6f/0xb0
> [  639.382650]  __might_resched.cold+0x1ec/0x232
> [  639.387025]  ? __pfx___might_resched+0x10/0x10
> [  639.391497]  nfsd_file_put+0x27/0x220 [nfsd]
> [  639.395851]  nfsd_file_put_local+0x35/0x50 [nfsd]
> [  639.400615]  nfs_local_pgio_release+0xe0/0x2c0 [nfs]
> [  639.405636]  nfs_local_call_write+0x572/0xd90 [nfs]
> [  639.410569]  ? __pfx_nfs_local_call_write+0x10/0x10 [nfs]
> [  639.416017]  ? trace_lock_acquire+0x1b9/0x280
> [  639.420398]  ? rcu_is_watching+0x15/0xb0
> [  639.424349]  process_one_work+0xd70/0x1340
> [  639.428470]  ? __pfx_process_one_work+0x10/0x10
> [  639.433028]  ? assign_work+0x16c/0x240
> [  639.436804]  worker_thread+0x5e6/0xfc0
> [  639.440589]  ? __pfx_worker_thread+0x10/0x10
> [  639.444876]  kthread+0x2d2/0x3a0
> [  639.448126]  ? _raw_spin_unlock_irq+0x28/0x50
> [  639.452503]  ? __pfx_kthread+0x10/0x10
> [  639.456275]  ret_from_fork+0x31/0x70
> [  639.459868]  ? __pfx_kthread+0x10/0x10
> [  639.463641]  ret_from_fork_asm+0x1a/0x30
> [  639.467596]  </TASK>
> [  642.895946] BUG: sleeping function called from invalid context at fs/n=
fsd/filecache.c:360
> [  642.904217] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 219=
, name: kworker/u128:9
> [  642.912679] preempt_count: 0, expected: 0
> [  642.916715] RCU nest depth: 1, expected: 0
> [  642.920840] 3 locks held by kworker/u128:9/219:
> [  642.925400]  #0: ff110001a2e64958 ((wq_completion)nfslocaliod){+.+.}-{=
0:0}, at: process_one_work+0x7f0/0x1340
> [  642.935350]  #1: ffa000000153fd90 ((work_completion)(&iocb->work)#2){+=
.+.}-{0:0}, at: process_one_work+0xd27/0x1340
> [  642.945809]  #2: ffffffff9c935ec0 (rcu_read_lock){....}-{1:2}, at: nfs=
_local_pgio_release+0x6e/0x2c0 [nfs]
> [  642.955555] CPU: 15 UID: 0 PID: 219 Comm: kworker/u128:9 Kdump: loaded=
 Tainted: G        W          6.12.0-rc6+ #1
> [  642.965909] Tainted: [W]=3DWARN
> [  642.968897] Hardware name: Dell Inc. PowerEdge R660/0R5JJC, BIOS 2.1.5=
 03/14/2024
> [  642.976395] Workqueue: nfslocaliod nfs_local_call_read [nfs]
> [  642.982107] Call Trace:
> [  642.984577]  <TASK>
> [  642.986702]  ? __up_read+0x111/0x730
> [  642.990296]  dump_stack_lvl+0x6f/0xb0
> [  642.993983]  __might_resched.cold+0x1ec/0x232
> [  642.998358]  ? __pfx___might_resched+0x10/0x10
> [  643.002822]  ? trace_xfs_iunlock+0x185/0x200 [xfs]
> [  643.007929]  nfsd_file_put+0x27/0x220 [nfsd]
> [  643.012296]  nfsd_file_put_local+0x35/0x50 [nfsd]
> [  643.017063]  nfs_local_pgio_release+0xe0/0x2c0 [nfs]
> [  643.022090]  nfs_local_call_read+0x427/0x770 [nfs]
> [  643.026937]  ? __pfx_nfs_local_call_read+0x10/0x10 [nfs]
> [  643.032297]  ? trace_lock_acquire+0x1b9/0x280
> [  643.036679]  ? rcu_is_watching+0x15/0xb0
> [  643.040630]  process_one_work+0xd70/0x1340
> [  643.044753]  ? __pfx_process_one_work+0x10/0x10
> [  643.049308]  ? assign_work+0x16c/0x240
> [  643.053084]  worker_thread+0x5e6/0xfc0
> [  643.056861]  ? __pfx_worker_thread+0x10/0x10
> [  643.061149]  kthread+0x2d2/0x3a0
> [  643.064398]  ? _raw_spin_unlock_irq+0x28/0x50
> [  643.068768]  ? __pfx_kthread+0x10/0x10
> [  643.072539]  ret_from_fork+0x31/0x70
> [  643.076142]  ? __pfx_kthread+0x10/0x10
> [  643.079913]  ret_from_fork_asm+0x1a/0x30
> [  643.083871]  </TASK>
> [  646.734835] BUG: sleeping function called from invalid context at fs/n=
fsd/filecache.c:360
> [  646.743060] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 235=
, name: kworker/u128:25
> [  646.751615] preempt_count: 0, expected: 0
> [  646.755655] RCU nest depth: 1, expected: 0
> [  646.759779] 3 locks held by kworker/u128:25/235:
> [  646.764424]  #0: ff110001a2e64958 ((wq_completion)nfslocaliod){+.+.}-{=
0:0}, at: process_one_work+0x7f0/0x1340
> [  646.774374]  #1: ffa000000163fd90 ((work_completion)(&iocb->work)#2){+=
.+.}-{0:0}, at: process_one_work+0xd27/0x1340
> [  646.784837]  #2: ffffffff9c935ec0 (rcu_read_lock){....}-{1:2}, at: nfs=
_local_pgio_release+0x6e/0x2c0 [nfs]
> [  646.794592] CPU: 19 UID: 0 PID: 235 Comm: kworker/u128:25 Kdump: loade=
d Tainted: G        W          6.12.0-rc6+ #1
> [  646.805039] Tainted: [W]=3DWARN
> [  646.808028] Hardware name: Dell Inc. PowerEdge R660/0R5JJC, BIOS 2.1.5=
 03/14/2024
> [  646.815508] Workqueue: nfslocaliod nfs_local_call_read [nfs]
> [  646.821220] Call Trace:
> [  646.823691]  <TASK>
> [  646.825799]  ? __up_read+0x111/0x730
> [  646.829402]  dump_stack_lvl+0x6f/0xb0
> [  646.833088]  __might_resched.cold+0x1ec/0x232
> [  646.837462]  ? __pfx___might_resched+0x10/0x10
> [  646.841928]  ? trace_xfs_iunlock+0x185/0x200 [xfs]
> [  646.847072]  nfsd_file_put+0x27/0x220 [nfsd]
> [  646.851445]  nfsd_file_put_local+0x35/0x50 [nfsd]
> [  646.856220]  nfs_local_pgio_release+0xe0/0x2c0 [nfs]
> [  646.861254]  nfs_local_call_read+0x427/0x770 [nfs]
> [  646.866103]  ? __pfx_nfs_local_call_read+0x10/0x10 [nfs]
> [  646.871464]  ? trace_lock_acquire+0x1b9/0x280
> [  646.875847]  ? rcu_is_watching+0x15/0xb0
> [  646.879795]  process_one_work+0xd70/0x1340
> [  646.883929]  ? __pfx_process_one_work+0x10/0x10
> [  646.888485]  ? assign_work+0x16c/0x240
> [  646.892260]  worker_thread+0x5e6/0xfc0
> [  646.896046]  ? __pfx_worker_thread+0x10/0x10
> [  646.900332]  kthread+0x2d2/0x3a0
> [  646.903579]  ? _raw_spin_unlock_irq+0x28/0x50
> [  646.907957]  ? __pfx_kthread+0x10/0x10
> [  646.911731]  ret_from_fork+0x31/0x70
> [  646.915334]  ? __pfx_kthread+0x10/0x10
> [  646.919105]  ret_from_fork_asm+0x1a/0x30
> [  646.923066]  </TASK>
> [  650.538851] BUG: sleeping function called from invalid context at fs/n=
fsd/filecache.c:360
> [  650.547069] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 235=
, name: kworker/u128:25
> [  650.555616] preempt_count: 0, expected: 0
> [  650.559649] RCU nest depth: 1, expected: 0
> [  650.563775] 3 locks held by kworker/u128:25/235:
> [  650.568425]  #0: ff110001a2e64958 ((wq_completion)nfslocaliod){+.+.}-{=
0:0}, at: process_one_work+0x7f0/0x1340
> [  650.578372]  #1: ffa000000163fd90 ((work_completion)(&iocb->work)#2){+=
.+.}-{0:0}, at: process_one_work+0xd27/0x1340
> [  650.588832]  #2: ffffffff9c935ec0 (rcu_read_lock){....}-{1:2}, at: nfs=
_local_pgio_release+0x6e/0x2c0 [nfs]
> [  650.598579] CPU: 19 UID: 0 PID: 235 Comm: kworker/u128:25 Kdump: loade=
d Tainted: G        W          6.12.0-rc6+ #1
> [  650.609026] Tainted: [W]=3DWARN
> [  650.612015] Hardware name: Dell Inc. PowerEdge R660/0R5JJC, BIOS 2.1.5=
 03/14/2024
> [  650.619513] Workqueue: nfslocaliod nfs_local_call_read [nfs]
> [  650.625233] Call Trace:
> [  650.627702]  <TASK>
> [  650.629830]  ? __up_read+0x111/0x730
> [  650.633432]  dump_stack_lvl+0x6f/0xb0
> [  650.637117]  __might_resched.cold+0x1ec/0x232
> [  650.641494]  ? __pfx___might_resched+0x10/0x10
> [  650.645957]  ? trace_xfs_iunlock+0x185/0x200 [xfs]
> [  650.651032]  nfsd_file_put+0x27/0x220 [nfsd]
> [  650.655388]  nfsd_file_put_local+0x35/0x50 [nfsd]
> [  650.660153]  nfs_local_pgio_release+0xe0/0x2c0 [nfs]
> [  650.665182]  nfs_local_call_read+0x427/0x770 [nfs]
> [  650.670029]  ? __pfx_nfs_local_call_read+0x10/0x10 [nfs]
> [  650.675388]  ? trace_lock_acquire+0x1b9/0x280
> [  650.679774]  ? rcu_is_watching+0x15/0xb0
> [  650.683725]  process_one_work+0xd70/0x1340
> [  650.687854]  ? __pfx_process_one_work+0x10/0x10
> [  650.692409]  ? assign_work+0x16c/0x240
> [  650.696184]  worker_thread+0x5e6/0xfc0
> [  650.699961]  ? __pfx_worker_thread+0x10/0x10
> [  650.704247]  kthread+0x2d2/0x3a0
> [  650.707499]  ? _raw_spin_unlock_irq+0x28/0x50
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

