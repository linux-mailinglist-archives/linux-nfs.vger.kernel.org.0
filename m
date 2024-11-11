Return-Path: <linux-nfs+bounces-7852-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 804F99C3F05
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 14:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D2C2EB244D5
	for <lists+linux-nfs@lfdr.de>; Mon, 11 Nov 2024 13:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FD61A0731;
	Mon, 11 Nov 2024 12:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VezTGup1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA3C1A01C3
	for <linux-nfs@vger.kernel.org>; Mon, 11 Nov 2024 12:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731329841; cv=none; b=s/oM1rArDsMHiaYB7u4dzvSWntBKEzzjkoV+09MWMAwLzKRJDet0Rc7iHNhNKf/Gd5W7tHj1HYYB7ETtXh4UCkv3mss1MVo9VJD4GhwQYJOfAcDaWBuzfn3h+5rXkvjkk2odKeQirU6cZkynlv+zcAPpGfT6apPc3dHB3zYV4L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731329841; c=relaxed/simple;
	bh=JEpcaQ4tBMI3u+rX11vBPeRHcs3AalKPfd1llmSE/sE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=K197LNZeu/wL9K8LgKJJ/8CUKbxEiBZ41GYmNge+eOgbiky1qcdWLpT6AHJD54rbwp1HgcrMMLXMRYKY5n6dMqRhe33t5YeC4tVQzn3DL7lWNW3rl2L/rwOXD6AAiId5v8ZxFcqiuT603OIbebtjY0j8CxERClR40sfDZdZgK4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VezTGup1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731329838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=wLgvK3HJdREObUzvhg3Atsq1Mr45OgpyqoVu171YWrs=;
	b=VezTGup15Ch8xVYoKfsv8wFrOlw9IUYSqfl4EETB89eQpKkpu8DyV2XsUOcETxqR9Oo7JT
	rvZty5CyKj371Na4ueizTESUc1g5SAxvdh5rXxMnpsb5ex+F3s+1l5qhT91WJL80OzvaQu
	IAko2CITIM9rEHdq18Ps8fzQlbNRT/I=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-o5_7E-utOlyWL1f_T9Ad3A-1; Mon, 11 Nov 2024 07:57:16 -0500
X-MC-Unique: o5_7E-utOlyWL1f_T9Ad3A-1
X-Mimecast-MFC-AGG-ID: o5_7E-utOlyWL1f_T9Ad3A
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-71e6c5fbebfso4566312b3a.3
        for <linux-nfs@vger.kernel.org>; Mon, 11 Nov 2024 04:57:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731329835; x=1731934635;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wLgvK3HJdREObUzvhg3Atsq1Mr45OgpyqoVu171YWrs=;
        b=WEgWFvtmC9X149nlZ4WFai7X2vlyp/gpxxeH4/kdrqBDvJeXoHUdTemZ9MrVQ8tn7L
         U5yU8eL2/9BKFSl0lZoHvMFy6ScrQOrkEbLlCB5x7mIMuRtcWJFwYya7erDxhrt9Pas5
         3Os0JBU0E/0HT2S3q1nn2t55dH3C0rsEEdrZQhHEKl+UOwm5FdSKtOB9LCT7cDQynMl7
         /B8waY2xf4rD8mwR6wlJIkAEzPcYOnmKDutmsR6h0XN78zbdGHUS1aCdoGZGFMNOCvaz
         HTJXFLGoB1anjgeKyQUhgDoGEgnx90XrOqPwqcL04EbXpyLcXH59DfyKDcverZh1cBGg
         R8jg==
X-Gm-Message-State: AOJu0YxxsEkjM61iJt+wuAVk5zxEOpzdavu66lGNKNAcrsXjdtv4Cw4L
	VX8JaGYAlCp8PjJo3IiSqJn6EYlBKYjERwhU1YvRv/JwaSFlnVR9CdFCeDqPvx/6FOs1+072SEk
	dPU7jstiwvAKYM/A/3CW+lO8f+gwVi+K+W6ERm0wFkxxhObS+mdWxSQl0tsW7fK98IsTwtuB6f3
	cBfsa0ujn8+Pm5u0jaXllEvlu1L7O+yDuZgGRGEh2C
X-Received: by 2002:a05:6a00:1901:b0:71e:744a:3fbc with SMTP id d2e1a72fcca58-72413386f01mr17217537b3a.21.1731329835146;
        Mon, 11 Nov 2024 04:57:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdv9e9dW3F3oP2I6lesx3ZxDfliF2OfVZGkA8v3Q1JhoMddyrvvU8YvJUbDRABg9k7skk61A==
X-Received: by 2002:a05:6a00:1901:b0:71e:744a:3fbc with SMTP id d2e1a72fcca58-72413386f01mr17217505b3a.21.1731329834400;
        Mon, 11 Nov 2024 04:57:14 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724079a413dsm8933319b3a.118.2024.11.11.04.57.13
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 04:57:14 -0800 (PST)
Date: Mon, 11 Nov 2024 20:57:11 +0800
From: Zorro Lang <zlang@redhat.com>
To: linux-nfs@vger.kernel.org
Subject: [bug report from fstests] BUG: sleeping function called from invalid
 context at fs/nfsd/filecache.c:360
Message-ID: <20241111125711.7ux6eywuk7nxo5hl@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Lots of fstests cases fail on nfs, e.g. [1]. The dmesg output as [2].
I tested on linux v6.12-rc6+, with HEAD=da4373fbcf006deda90e5e6a87c499e0ff747572

Thanks,
Zorro


[1]
FSTYP         -- nfs
PLATFORM      -- Linux/aarch64 hpe-apollo-cn99xx-14-vm-04 6.12.0-rc6+ #1 SMP PREEMPT_DYNAMIC Sat Nov  9 16:18:01 EST 2024
MKFS_OPTIONS  -- hpe-apollo-cn99xx-14-vm-04.khw.eng.rdu2.dc.redhat.com:/mnt/xfstests/scratch/nfs-server
MOUNT_OPTIONS -- -o vers=4.2 -o context=system_u:object_r:root_t:s0 hpe-apollo-cn99xx-14-vm-04.khw.eng.rdu2.dc.redhat.com:/mnt/xfstests/scratch/nfs-server /mnt/xfstests/scratch/nfs-client

generic/001       _check_dmesg: something found in dmesg (see /var/lib/xfstests/results//generic/001.dmesg)

Ran: generic/001
Failures: generic/001
Failed 1 of 1 tests

[2]
#cat /var/lib/xfstests/results//generic/001.dmesg
[  637.512336] run fstests generic/001 at 2024-11-09 13:32:14
[  638.266054] BUG: sleeping function called from invalid context at fs/nfsd/filecache.c:360
[  638.274310] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 233, name: kworker/u128:23
[  638.282860] preempt_count: 0, expected: 0
[  638.286897] RCU nest depth: 1, expected: 0
[  638.291023] 3 locks held by kworker/u128:23/233:
[  638.295666]  #0: ff110001a2e64958 ((wq_completion)nfslocaliod){+.+.}-{0:0}, at: process_one_work+0x7f0/0x1340
[  638.305619]  #1: ffa000000161fd90 ((work_completion)(&iocb->work)){+.+.}-{0:0}, at: process_one_work+0xd27/0x1340
[  638.315901]  #2: ffffffff9c935ec0 (rcu_read_lock){....}-{1:2}, at: nfs_local_pgio_release+0x6e/0x2c0 [nfs]
[  638.325645] CPU: 13 UID: 0 PID: 233 Comm: kworker/u128:23 Kdump: loaded Not tainted 6.12.0-rc6+ #1
[  638.334615] Hardware name: Dell Inc. PowerEdge R660/0R5JJC, BIOS 2.1.5 03/14/2024
[  638.342113] Workqueue: nfslocaliod nfs_local_call_write [nfs]
[  638.347909] Call Trace:
[  638.350364]  <TASK>
[  638.352490]  ? nfs_local_call_write+0x649/0xd90 [nfs]
[  638.357589]  dump_stack_lvl+0x6f/0xb0
[  638.361277]  __might_resched.cold+0x1ec/0x232
[  638.365651]  ? __pfx___might_resched+0x10/0x10
[  638.370123]  nfsd_file_put+0x27/0x220 [nfsd]
[  638.374476]  nfsd_file_put_local+0x35/0x50 [nfsd]
[  638.379244]  nfs_local_pgio_release+0xe0/0x2c0 [nfs]
[  638.384261]  nfs_local_call_write+0x572/0xd90 [nfs]
[  638.389189]  ? __pfx_nfs_local_call_write+0x10/0x10 [nfs]
[  638.394635]  ? trace_lock_acquire+0x1b9/0x280
[  638.399016]  ? rcu_is_watching+0x15/0xb0
[  638.402967]  process_one_work+0xd70/0x1340
[  638.407098]  ? __pfx_process_one_work+0x10/0x10
[  638.411655]  ? assign_work+0x16c/0x240
[  638.415428]  worker_thread+0x5e6/0xfc0
[  638.419207]  ? __pfx_worker_thread+0x10/0x10
[  638.423492]  kthread+0x2d2/0x3a0
[  638.426744]  ? _raw_spin_unlock_irq+0x28/0x50
[  638.431119]  ? __pfx_kthread+0x10/0x10
[  638.434894]  ret_from_fork+0x31/0x70
[  638.438487]  ? __pfx_kthread+0x10/0x10
[  638.442258]  ret_from_fork_asm+0x1a/0x30
[  638.446206]  </TASK>
[  639.282949] BUG: sleeping function called from invalid context at fs/nfsd/filecache.c:360
[  639.291169] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 233, name: kworker/u128:23
[  639.299722] preempt_count: 0, expected: 0
[  639.303764] RCU nest depth: 1, expected: 0
[  639.307889] 3 locks held by kworker/u128:23/233:
[  639.312533]  #0: ff110001a2e64958 ((wq_completion)nfslocaliod){+.+.}-{0:0}, at: process_one_work+0x7f0/0x1340
[  639.322500]  #1: ffa000000161fd90 ((work_completion)(&iocb->work)){+.+.}-{0:0}, at: process_one_work+0xd27/0x1340
[  639.332797]  #2: ffffffff9c935ec0 (rcu_read_lock){....}-{1:2}, at: nfs_local_pgio_release+0x6e/0x2c0 [nfs]
[  639.342546] CPU: 14 UID: 0 PID: 233 Comm: kworker/u128:23 Kdump: loaded Tainted: G        W          6.12.0-rc6+ #1
[  639.352989] Tainted: [W]=WARN
[  639.355979] Hardware name: Dell Inc. PowerEdge R660/0R5JJC, BIOS 2.1.5 03/14/2024
[  639.363477] Workqueue: nfslocaliod nfs_local_call_write [nfs]
[  639.369273] Call Trace:
[  639.371746]  <TASK>
[  639.373869]  ? nfs_local_call_write+0x649/0xd90 [nfs]
[  639.378964]  dump_stack_lvl+0x6f/0xb0
[  639.382650]  __might_resched.cold+0x1ec/0x232
[  639.387025]  ? __pfx___might_resched+0x10/0x10
[  639.391497]  nfsd_file_put+0x27/0x220 [nfsd]
[  639.395851]  nfsd_file_put_local+0x35/0x50 [nfsd]
[  639.400615]  nfs_local_pgio_release+0xe0/0x2c0 [nfs]
[  639.405636]  nfs_local_call_write+0x572/0xd90 [nfs]
[  639.410569]  ? __pfx_nfs_local_call_write+0x10/0x10 [nfs]
[  639.416017]  ? trace_lock_acquire+0x1b9/0x280
[  639.420398]  ? rcu_is_watching+0x15/0xb0
[  639.424349]  process_one_work+0xd70/0x1340
[  639.428470]  ? __pfx_process_one_work+0x10/0x10
[  639.433028]  ? assign_work+0x16c/0x240
[  639.436804]  worker_thread+0x5e6/0xfc0
[  639.440589]  ? __pfx_worker_thread+0x10/0x10
[  639.444876]  kthread+0x2d2/0x3a0
[  639.448126]  ? _raw_spin_unlock_irq+0x28/0x50
[  639.452503]  ? __pfx_kthread+0x10/0x10
[  639.456275]  ret_from_fork+0x31/0x70
[  639.459868]  ? __pfx_kthread+0x10/0x10
[  639.463641]  ret_from_fork_asm+0x1a/0x30
[  639.467596]  </TASK>
[  642.895946] BUG: sleeping function called from invalid context at fs/nfsd/filecache.c:360
[  642.904217] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 219, name: kworker/u128:9
[  642.912679] preempt_count: 0, expected: 0
[  642.916715] RCU nest depth: 1, expected: 0
[  642.920840] 3 locks held by kworker/u128:9/219:
[  642.925400]  #0: ff110001a2e64958 ((wq_completion)nfslocaliod){+.+.}-{0:0}, at: process_one_work+0x7f0/0x1340
[  642.935350]  #1: ffa000000153fd90 ((work_completion)(&iocb->work)#2){+.+.}-{0:0}, at: process_one_work+0xd27/0x1340
[  642.945809]  #2: ffffffff9c935ec0 (rcu_read_lock){....}-{1:2}, at: nfs_local_pgio_release+0x6e/0x2c0 [nfs]
[  642.955555] CPU: 15 UID: 0 PID: 219 Comm: kworker/u128:9 Kdump: loaded Tainted: G        W          6.12.0-rc6+ #1
[  642.965909] Tainted: [W]=WARN
[  642.968897] Hardware name: Dell Inc. PowerEdge R660/0R5JJC, BIOS 2.1.5 03/14/2024
[  642.976395] Workqueue: nfslocaliod nfs_local_call_read [nfs]
[  642.982107] Call Trace:
[  642.984577]  <TASK>
[  642.986702]  ? __up_read+0x111/0x730
[  642.990296]  dump_stack_lvl+0x6f/0xb0
[  642.993983]  __might_resched.cold+0x1ec/0x232
[  642.998358]  ? __pfx___might_resched+0x10/0x10
[  643.002822]  ? trace_xfs_iunlock+0x185/0x200 [xfs]
[  643.007929]  nfsd_file_put+0x27/0x220 [nfsd]
[  643.012296]  nfsd_file_put_local+0x35/0x50 [nfsd]
[  643.017063]  nfs_local_pgio_release+0xe0/0x2c0 [nfs]
[  643.022090]  nfs_local_call_read+0x427/0x770 [nfs]
[  643.026937]  ? __pfx_nfs_local_call_read+0x10/0x10 [nfs]
[  643.032297]  ? trace_lock_acquire+0x1b9/0x280
[  643.036679]  ? rcu_is_watching+0x15/0xb0
[  643.040630]  process_one_work+0xd70/0x1340
[  643.044753]  ? __pfx_process_one_work+0x10/0x10
[  643.049308]  ? assign_work+0x16c/0x240
[  643.053084]  worker_thread+0x5e6/0xfc0
[  643.056861]  ? __pfx_worker_thread+0x10/0x10
[  643.061149]  kthread+0x2d2/0x3a0
[  643.064398]  ? _raw_spin_unlock_irq+0x28/0x50
[  643.068768]  ? __pfx_kthread+0x10/0x10
[  643.072539]  ret_from_fork+0x31/0x70
[  643.076142]  ? __pfx_kthread+0x10/0x10
[  643.079913]  ret_from_fork_asm+0x1a/0x30
[  643.083871]  </TASK>
[  646.734835] BUG: sleeping function called from invalid context at fs/nfsd/filecache.c:360
[  646.743060] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 235, name: kworker/u128:25
[  646.751615] preempt_count: 0, expected: 0
[  646.755655] RCU nest depth: 1, expected: 0
[  646.759779] 3 locks held by kworker/u128:25/235:
[  646.764424]  #0: ff110001a2e64958 ((wq_completion)nfslocaliod){+.+.}-{0:0}, at: process_one_work+0x7f0/0x1340
[  646.774374]  #1: ffa000000163fd90 ((work_completion)(&iocb->work)#2){+.+.}-{0:0}, at: process_one_work+0xd27/0x1340
[  646.784837]  #2: ffffffff9c935ec0 (rcu_read_lock){....}-{1:2}, at: nfs_local_pgio_release+0x6e/0x2c0 [nfs]
[  646.794592] CPU: 19 UID: 0 PID: 235 Comm: kworker/u128:25 Kdump: loaded Tainted: G        W          6.12.0-rc6+ #1
[  646.805039] Tainted: [W]=WARN
[  646.808028] Hardware name: Dell Inc. PowerEdge R660/0R5JJC, BIOS 2.1.5 03/14/2024
[  646.815508] Workqueue: nfslocaliod nfs_local_call_read [nfs]
[  646.821220] Call Trace:
[  646.823691]  <TASK>
[  646.825799]  ? __up_read+0x111/0x730
[  646.829402]  dump_stack_lvl+0x6f/0xb0
[  646.833088]  __might_resched.cold+0x1ec/0x232
[  646.837462]  ? __pfx___might_resched+0x10/0x10
[  646.841928]  ? trace_xfs_iunlock+0x185/0x200 [xfs]
[  646.847072]  nfsd_file_put+0x27/0x220 [nfsd]
[  646.851445]  nfsd_file_put_local+0x35/0x50 [nfsd]
[  646.856220]  nfs_local_pgio_release+0xe0/0x2c0 [nfs]
[  646.861254]  nfs_local_call_read+0x427/0x770 [nfs]
[  646.866103]  ? __pfx_nfs_local_call_read+0x10/0x10 [nfs]
[  646.871464]  ? trace_lock_acquire+0x1b9/0x280
[  646.875847]  ? rcu_is_watching+0x15/0xb0
[  646.879795]  process_one_work+0xd70/0x1340
[  646.883929]  ? __pfx_process_one_work+0x10/0x10
[  646.888485]  ? assign_work+0x16c/0x240
[  646.892260]  worker_thread+0x5e6/0xfc0
[  646.896046]  ? __pfx_worker_thread+0x10/0x10
[  646.900332]  kthread+0x2d2/0x3a0
[  646.903579]  ? _raw_spin_unlock_irq+0x28/0x50
[  646.907957]  ? __pfx_kthread+0x10/0x10
[  646.911731]  ret_from_fork+0x31/0x70
[  646.915334]  ? __pfx_kthread+0x10/0x10
[  646.919105]  ret_from_fork_asm+0x1a/0x30
[  646.923066]  </TASK>
[  650.538851] BUG: sleeping function called from invalid context at fs/nfsd/filecache.c:360
[  650.547069] in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 235, name: kworker/u128:25
[  650.555616] preempt_count: 0, expected: 0
[  650.559649] RCU nest depth: 1, expected: 0
[  650.563775] 3 locks held by kworker/u128:25/235:
[  650.568425]  #0: ff110001a2e64958 ((wq_completion)nfslocaliod){+.+.}-{0:0}, at: process_one_work+0x7f0/0x1340
[  650.578372]  #1: ffa000000163fd90 ((work_completion)(&iocb->work)#2){+.+.}-{0:0}, at: process_one_work+0xd27/0x1340
[  650.588832]  #2: ffffffff9c935ec0 (rcu_read_lock){....}-{1:2}, at: nfs_local_pgio_release+0x6e/0x2c0 [nfs]
[  650.598579] CPU: 19 UID: 0 PID: 235 Comm: kworker/u128:25 Kdump: loaded Tainted: G        W          6.12.0-rc6+ #1
[  650.609026] Tainted: [W]=WARN
[  650.612015] Hardware name: Dell Inc. PowerEdge R660/0R5JJC, BIOS 2.1.5 03/14/2024
[  650.619513] Workqueue: nfslocaliod nfs_local_call_read [nfs]
[  650.625233] Call Trace:
[  650.627702]  <TASK>
[  650.629830]  ? __up_read+0x111/0x730
[  650.633432]  dump_stack_lvl+0x6f/0xb0
[  650.637117]  __might_resched.cold+0x1ec/0x232
[  650.641494]  ? __pfx___might_resched+0x10/0x10
[  650.645957]  ? trace_xfs_iunlock+0x185/0x200 [xfs]
[  650.651032]  nfsd_file_put+0x27/0x220 [nfsd]
[  650.655388]  nfsd_file_put_local+0x35/0x50 [nfsd]
[  650.660153]  nfs_local_pgio_release+0xe0/0x2c0 [nfs]
[  650.665182]  nfs_local_call_read+0x427/0x770 [nfs]
[  650.670029]  ? __pfx_nfs_local_call_read+0x10/0x10 [nfs]
[  650.675388]  ? trace_lock_acquire+0x1b9/0x280
[  650.679774]  ? rcu_is_watching+0x15/0xb0
[  650.683725]  process_one_work+0xd70/0x1340
[  650.687854]  ? __pfx_process_one_work+0x10/0x10
[  650.692409]  ? assign_work+0x16c/0x240
[  650.696184]  worker_thread+0x5e6/0xfc0
[  650.699961]  ? __pfx_worker_thread+0x10/0x10
[  650.704247]  kthread+0x2d2/0x3a0
[  650.707499]  ? _raw_spin_unlock_irq+0x28/0x50


