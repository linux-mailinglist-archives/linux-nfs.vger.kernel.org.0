Return-Path: <linux-nfs+bounces-16714-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AB24BC858F5
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Nov 2025 15:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B7AB4ECAC3
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Nov 2025 14:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C37C17C211;
	Tue, 25 Nov 2025 14:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GHsY2S4m";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SAzgIjSS"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9708132D0D5
	for <linux-nfs@vger.kernel.org>; Tue, 25 Nov 2025 14:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764081922; cv=none; b=kKM7qf9HfLP4Eef53IkhdH8lPef+tr8xO+dTRWSgqOzGBGLCLkGZUho14TNgGV0bjgv8jcY8D7mPt7x5IbbtT1DtMmPAj8ZZKcv7u7bNTsjaRbruFoDsYpXmBjG09M6raYNDci+UrITOHF5e2GLSwp6lF5ngOKwIRvxSEP3OwZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764081922; c=relaxed/simple;
	bh=sg/ei5H0YGNpQIRYIanCsI3TYNEtYV72zqrD5npkOo0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hw7bdeAkVGr8tdN/8H+MoXR0PSn4BSxUplOp2/akWcJzUyRZASBeRrBQCB7MXyHjv+eOlTIr6pYCodq9r9x/l3iw+wy4FRmmBXSBTv8o3Kx5sDxpTOXSnupbqjKglz8kDwH97AOiEHr7k51WyjSF0/z9e83L/IcEr2zoiqM4PIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GHsY2S4m; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SAzgIjSS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764081918;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kbxbfMkdEbkubfTju7fOWa0ANsNT1mNhH/ApY6f2G+g=;
	b=GHsY2S4mnsjJwadrl9Ui/xCevGEMNSlw+CmhSZgllRh6G1MdP0X5sv5EnidHyV6P2K1Z3q
	QFmyqg+YdZrqKLEKozeF/6Cx6vcvj0/dwQAkb2ZSBd6dmRWDXSzOpjVYw0XybzL3EeywMN
	JlJl8ByKkQGIfodXihpVgCD9dvgwH5k=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-zgc_riIFOemwoutjJQyPSA-1; Tue, 25 Nov 2025 09:45:17 -0500
X-MC-Unique: zgc_riIFOemwoutjJQyPSA-1
X-Mimecast-MFC-AGG-ID: zgc_riIFOemwoutjJQyPSA_1764081916
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2982dec5ccbso119186625ad.3
        for <linux-nfs@vger.kernel.org>; Tue, 25 Nov 2025 06:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764081915; x=1764686715; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kbxbfMkdEbkubfTju7fOWa0ANsNT1mNhH/ApY6f2G+g=;
        b=SAzgIjSSuCay/0IArNy+A7s8BQsnhmSJhRGSr7/pQGmdifImAcyEuo+gmSflWsVmHh
         UvNBQ7XZhsk2suXorMSYQPhlpqljPkTGyEo9+ub39WlNVmNz6cqGow7WbpKYdqvcCKyc
         HY3hTUzlghA3y5M24q2dtxk+tLTCTMQ3FM/dUf5IKmEGYb6QB2qDYouwoCXyp1pCdnP5
         yi29OJeQdyro2/fjFVdRCOv4RVxLm+PxSfZFsmaNBIrVP3dv74QkjO1ypywTwUIoPjER
         ky349U2GCPwgwQNRkbs7cy59xQYnlMg2yHOqlgF3SQRmq3sVQyjG9xbkpCYFnW1rxhEb
         gLmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764081915; x=1764686715;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kbxbfMkdEbkubfTju7fOWa0ANsNT1mNhH/ApY6f2G+g=;
        b=oKYeTgewOS6qQcQNG7FRXYwRs0t9VkSkWZl+2VzGi9wmCOWN3R8LSrjIe4Ub/aadU2
         skt+gz9swUqclx0ZX1pcDhsRAbb8PPn7lRjEcieSRYoID0j5QJaIpeVp/VPDmPA1t9Hr
         dJtE/k1IWUu8M/DDsTU9nw5ZgzLBkyANij+u0GMb5tZVB7+pDBNCgAYNNshopk2Fqu5e
         rX6xGNGzf8WPbnzoX7ql0Ay69fVsqh4QV+ocjhMZIpa19P+RPkw+HqqlwjTNjIq1kUqx
         QQ5R8GtSjhfg+DH/MtLkW3PKggGCBpVtEvcBmGxaVQzajJR8Ds7zBY4CK4/86gqqY2wr
         9G1Q==
X-Gm-Message-State: AOJu0Yw4tvTdMj5dQm06IGWDJzT9tx07E+bTb2I/Ikw8mpgFA59lCBpz
	RFBWMocTL00pgLj8Nqlc/+sq2YyaPLmijVNFvT86mplY/S+3hme6ELepDumU0knFZi7Cq6/hQiC
	KNLz6O/9bO22YVv61UxG/uCbnW2lbzjMqm8DYf/zca1vGzS6xAK7NS2B5m/vT/brx7uc2hByvJU
	rFpo8u60z91bmKcmdrod8Df1eDalgaYowO7e24L/mDCQ==
X-Gm-Gg: ASbGncu3KRMCS3aIWBrK/K5EUMEgZZvj315LCT5KlSzQPqCRf0ussrFJgIjrDj97VRk
	W8KXm39hyagWVZarGh0QzSTwFsa4CkoDGpZ6xJgc0pyRp3hxOc5LBxJ9O7jJ24cqT1RohywgCjs
	xeJi3p0WIWBpUL/oBI0upj5/F+jEPI7loJ0ll8CMs5qY1R8PavK0m3SoR3fKPfvt0mlsXW4J3VO
	ytxDKLfCIhTBqyw28rJwiG+HpmelW4wc53sFklmXl+KXB3oBLSx1gNhMAqTc2mQ88YWiJshn1FG
	XH7pxehbAUI8yZxE9NtT0CzQF+5ILQC741ngAwTTH97b1vW3LLbQ4g8flp7obqFqTRZj/0IArbl
	Rhqa4/Q9ves2ibgaQ0Vjty4QtmY5FwgLPVdijdtRlFDbgPDos/A==
X-Received: by 2002:a17:902:e5c8:b0:295:8db9:3059 with SMTP id d9443c01a7336-29b6c6871c4mr188420365ad.38.1764081914492;
        Tue, 25 Nov 2025 06:45:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKSUoWD1r6sWveUK6L3xHB7yTUwLwvHdDXY4eXIN0X628C07qfJ0Xa/exV7egxc7rSQ8JZpQ==
X-Received: by 2002:a17:902:e5c8:b0:295:8db9:3059 with SMTP id d9443c01a7336-29b6c6871c4mr188419745ad.38.1764081913664;
        Tue, 25 Nov 2025 06:45:13 -0800 (PST)
Received: from dell-per750-06-vm-08.rhts.eng.pek2.redhat.com ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b2bb7c1sm169554055ad.99.2025.11.25.06.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 06:45:13 -0800 (PST)
Date: Tue, 25 Nov 2025 22:45:08 +0800
From: Zorro Lang <zlang@redhat.com>
To: linux-nfs@vger.kernel.org
Cc: snitzer@redhat.com, linux-kernel@vger.kernel.org
Subject: [Bug][xfstests crash on nfs] kernel BUG at kernel/cred.c:104!
Message-ID: <20251125144508.rxepvtwrubbuhzxs@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I reported 2 nfs bugs recently:

The 1st one [1] which triggers a KASAN bug has been fixed on v6.18-rc7.
The 2nd one [2], "generic/751 hang on nfs" is still there [3] (not fixed).

Now I started to hit a kernel crash on nfs testing [3][4]. I hit it several
times, there's not a specific xfstests case to trigger this crash. I hit
the linux v6.18-rc7 crashed on different xfstests cases (e.g. generic/091 [=
3]
and generic/241 [4]).

Thanks,
Zorro

[1]
https://lore.kernel.org/linux-nfs/20251020134249.g3efj4otvzoy32ky@dell-per7=
50-06-vm-08.rhts.eng.pek2.redhat.com/T/#u

[2]
https://lore.kernel.org/linux-nfs/20251021051408.lv7dye5wywxhl3dg@dell-per7=
50-06-vm-08.rhts.eng.pek2.redhat.com/T/#u

[3]
[  753.869951] run fstests generic/751 at 2025-11-24 16:26:14=20
[-- MARK -- Mon Nov 24 21:30:00 2025]=20
[ 1109.308274] INFO: task kworker/u128:11:72598 blocked for more than 122 s=
econds.=20
[ 1109.315702]       Tainted: G S                  6.18.0-rc7 #1=20
[ 1109.321499] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this message.=20
[ 1109.329358] task:kworker/u128:11 state:D stack:25064 pid:72598 tgid:7259=
8 ppid:2      task_flags:0x4208060 flags:0x00080000=20
[ 1109.340603] Workqueue: writeback wb_workfn (flush-0:56)=20
[ 1109.345908] Call Trace:=20
[ 1109.348435]  <TASK>=20
[ 1109.350567]  __schedule+0x838/0x1890=20
[ 1109.354180]  ? __pfx___schedule+0x10/0x10=20
[ 1109.358218]  ? __blk_flush_plug+0x27b/0x4d0=20
[ 1109.362431]  ? find_held_lock+0x32/0x90=20
[ 1109.366303]  ? __lock_release.isra.0+0x1a4/0x2c0=20
[ 1109.370951]  schedule+0xd4/0x260=20
[ 1109.374216]  io_schedule+0x8f/0xf0=20
[ 1109.377643]  folio_wait_bit_common+0x2d9/0x780=20
[ 1109.382119]  ? folio_wait_bit_common+0x1dd/0x780=20
[ 1109.386770]  ? __pfx_folio_wait_bit_common+0x10/0x10=20
[ 1109.391774]  ? __pfx_wake_page_function+0x10/0x10=20
[ 1109.396509]  ? __pfx___might_resched+0x10/0x10=20
[ 1109.400991]  writeback_get_folio+0x3f9/0x500=20
[ 1109.405298]  writeback_iter+0x136/0x720=20
[ 1109.409154]  ? kasan_save_track+0x14/0x30=20
[ 1109.413200]  nfs_writepages+0x4f8/0x9b0 [nfs]=20
[ 1109.417639]  ? unwind_next_frame+0x3fa/0x1f10=20
[ 1109.422025]  ? __pfx_nfs_writepages+0x10/0x10 [nfs]=20
[ 1109.426975]  ? __lock_acquire+0x57c/0xbd0=20
[ 1109.431035]  do_writepages+0x21f/0x560=20
[ 1109.434816]  ? __pfx_do_writepages+0x10/0x10=20
[ 1109.439116]  ? rcu_is_watching+0x15/0xb0=20
[ 1109.443079]  __writeback_single_inode+0xe2/0x5f0=20
[ 1109.447730]  ? __lock_release.isra.0+0x1a4/0x2c0=20
[ 1109.452373]  ? __pfx___writeback_single_inode+0x10/0x10=20
[ 1109.457623]  ? writeback_sb_inodes+0x416/0xd00=20
[ 1109.462099]  writeback_sb_inodes+0x535/0xd00=20
[ 1109.466406]  ? __pfx_writeback_sb_inodes+0x10/0x10=20
[ 1109.471248]  ? lock_acquire+0x10b/0x150=20
[ 1109.475114]  ? down_read_trylock+0x4b/0x60=20
[ 1109.479245]  __writeback_inodes_wb+0xf4/0x270=20
[ 1109.483640]  ? __pfx___writeback_inodes_wb+0x10/0x10=20
[ 1109.488634]  ? queue_io+0x329/0x510=20
[ 1109.492155]  wb_writeback+0x70a/0x9c0=20
[ 1109.495855]  ? __pfx_wb_writeback+0x10/0x10=20
[ 1109.500075]  ? get_nr_dirty_inodes+0xcb/0x180=20
[ 1109.504465]  wb_do_writeback+0x586/0x8e0=20
[ 1109.508428]  ? __pfx_wb_do_writeback+0x10/0x10=20
[ 1109.512900]  ? set_worker_desc+0x16e/0x190=20
[ 1109.517028]  ? __pfx_set_worker_desc+0x10/0x10=20
[ 1109.521510]  wb_workfn+0x7c/0x200=20
[ 1109.524850]  process_one_work+0xd8b/0x1320=20
[ 1109.528986]  ? __pfx_process_one_work+0x10/0x10=20
[ 1109.533551]  ? assign_work+0x16c/0x240=20
[ 1109.537338]  worker_thread+0x5f3/0xfe0=20
[ 1109.541123]  ? __kthread_parkme+0xb4/0x200=20
[ 1109.545249]  ? __pfx_worker_thread+0x10/0x10=20
[ 1109.549551]  kthread+0x3b4/0x770=20
[ 1109.552808]  ? local_clock_noinstr+0xd/0xe0=20
[ 1109.557026]  ? __pfx_kthread+0x10/0x10=20
[ 1109.560802]  ? __lock_release.isra.0+0x1a4/0x2c0=20
[ 1109.565452]  ? rcu_is_watching+0x15/0xb0=20
[ 1109.569414]  ? __pfx_kthread+0x10/0x10=20
[ 1109.573200]  ret_from_fork+0x393/0x480=20
[ 1109.576987]  ? __pfx_kthread+0x10/0x10=20
[ 1109.580780]  ? __pfx_kthread+0x10/0x10=20
[ 1109.584565]  ret_from_fork_asm+0x1a/0x30=20
[ 1109.588529]  </TASK>=20
[ 1109.590762] =20
[ 1109.590762] Showing all locks held in the system:=20
[ 1109.596995] 1 lock held by khungtaskd/244:=20
[ 1109.601118]  #0: ffffffff93130ee0 (rcu_read_lock){....}-{1:3}, at: rcu_l=
ock_acquire.constprop.0+0x7/0x30=20
[ 1109.610665] 2 locks held by 751/71037:=20
[ 1109.614438]  #0: ff110001093ec440 (sb_writers#17){.+.+}-{0:0}, at: ksys_=
write+0xf9/0x1d0=20
[ 1109.622567]  #1: ffffffff9339a070 (split_debug_mutex){+.+.}-{4:4}, at: s=
plit_huge_pages_write+0x124/0x430=20
[ 1109.632177] 1 lock held by fio/71083:=20
[ 1109.635861]  #0: ff110001df650440 (sb_writers#16){.+.+}-{0:0}, at: __x64=
_sys_pwrite64+0x18a/0x1f0=20
[ 1109.644765] 1 lock held by fio/71085:=20
[ 1109.648454]  #0: ff110001df650440 (sb_writers#16){.+.+}-{0:0}, at: __x64=
_sys_pwrite64+0x18a/0x1f0=20
[ 1109.657356] 1 lock held by fio/71086:=20
[ 1109.661048]  #0: ff110001df650440 (sb_writers#16){.+.+}-{0:0}, at: __x64=
_sys_pwrite64+0x18a/0x1f0=20
[ 1109.669950] 1 lock held by fio/71087:=20
[ 1109.673641]  #0: ff110001df650440 (sb_writers#16){.+.+}-{0:0}, at: __x64=
_sys_pwrite64+0x18a/0x1f0=20
[ 1109.682542] 1 lock held by fio/71088:=20
[ 1109.686226]  #0: ff110001df650440 (sb_writers#16){.+.+}-{0:0}, at: __x64=
_sys_pwrite64+0x18a/0x1f0=20
[ 1109.695126] 1 lock held by fio/71089:=20
[ 1109.698808]  #0: ff110001df650440 (sb_writers#16){.+.+}-{0:0}, at: __x64=
_sys_pwrite64+0x18a/0x1f0=20
[ 1109.707711] 1 lock held by fio/71092:=20
[ 1109.711402]  #0: ff110001df650440 (sb_writers#16){.+.+}-{0:0}, at: __x64=
_sys_pwrite64+0x18a/0x1f0=20
[ 1109.720303] 1 lock held by fio/71094:=20
[ 1109.723995]  #0: ff110001df650440 (sb_writers#16){.+.+}-{0:0}, at: __x64=
_sys_pwrite64+0x18a/0x1f0=20
[ 1109.732897] 1 lock held by fio/71107:=20
[ 1109.736588]  #0: ff110001df650440 (sb_writers#16){.+.+}-{0:0}, at: __x64=
_sys_pwrite64+0x18a/0x1f0=20
[ 1109.745495] 2 locks held by kworker/u128:19/71617:=20
[ 1109.750310]  #0: ff11000820a043d8 (&rq->__lock){-.-.}-{2:2}, at: raw_spi=
n_rq_lock_nested+0x2e/0x130=20
[ 1109.759380]  #1: ffffffff93130ee0 (rcu_read_lock){....}-{1:3}, at: __upd=
ate_idle_core+0x60/0x4b0=20
[ 1109.768195] 2 locks held by kworker/u128:39/71816:=20
[ 1109.773004]  #0: ff110001d74c8158 ((wq_completion)nfsiod){+.+.}-{0:0}, a=
t: process_one_work+0x7f5/0x1320=20
[ 1109.782505]  #1: ffa000002e98fd10 ((work_completion)(&ctx->work)){+.+.}-=
{0:0}, at: process_one_work+0xd3f/0x1320=20
[ 1109.792705] 2 locks held by kworker/u128:41/71837:=20
[ 1109.797517]  #0: ff110001d74c8158 ((wq_completion)nfsiod){+.+.}-{0:0}, a=
t: process_one_work+0x7f5/0x1320=20
[ 1109.807024]  #1: ffa000002e5efd10 ((work_completion)(&ctx->work)){+.+.}-=
{0:0}, at: process_one_work+0xd3f/0x1320=20
[ 1109.817225] 2 locks held by kworker/u128:45/71874:=20
[ 1109.822043]  #0: ff110001d74c8158 ((wq_completion)nfsiod){+.+.}-{0:0}, a=
t: process_one_work+0x7f5/0x1320=20
[ 1109.831542]  #1: ffa000002d52fd10 ((work_completion)(&ctx->work)){+.+.}-=
{0:0}, at: process_one_work+0xd3f/0x1320=20
[ 1109.841747] 2 locks held by kworker/u128:54/71970:=20
[ 1109.846561]  #0: ff110001d74c8158 ((wq_completion)nfsiod){+.+.}-{0:0}, a=
t: process_one_work+0x7f5/0x1320=20
[ 1109.856068]  #1: ffa000003448fd10 ((work_completion)(&ctx->work)){+.+.}-=
{0:0}, at: process_one_work+0xd3f/0x1320=20
[ 1109.866263] 2 locks held by kworker/u128:65/72081:=20
[ 1109.871078]  #0: ff110001d74c8158 ((wq_completion)nfsiod){+.+.}-{0:0}, a=
t: process_one_work+0x7f5/0x1320=20
[ 1109.880579]  #1: ffffffff93130ee0 (rcu_read_lock){....}-{1:3}, at: __upd=
ate_idle_core+0x60/0x4b0=20
[ 1109.889405] 2 locks held by kworker/u128:92/72349:=20
[ 1109.894218]  #0: ff110001d74c8158 ((wq_completion)nfsiod){+.+.}-{0:0}, a=
t: process_one_work+0x7f5/0x1320=20
[ 1109.903721]  #1: ffa000002c4dfd10 ((work_completion)(&ctx->work)){+.+.}-=
{0:0}, at: process_one_work+0xd3f/0x1320=20
[ 1109.913931] 3 locks held by kworker/u128:11/72598:=20
[ 1109.918748]  #0: ff11000109719158 ((wq_completion)writeback){+.+.}-{0:0}=
, at: process_one_work+0x7f5/0x1320=20
[ 1109.928514]  #1: ffa00000361bfd10 ((work_completion)(&(&wb->dwork)->work=
)){+.+.}-{0:0}, at: process_one_work+0xd3f/0x1320=20
[ 1109.939486]  #2: ff110001df6500e8 (&type->s_umount_key#68){++++}-{4:4}, =
at: super_trylock_shared+0x1c/0xa0=20
[ 1109.949173] =20
[ 1109.950693] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=20
[ 1109.950693] =20
[ 1232.188373] INFO: task kworker/u128:11:72598 blocked for more than 245 s=
econds.=20
[ 1232.195767]       Tainted: G S                  6.18.0-rc7 #1=20
[ 1232.201533] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables =
this message.=20
[ 1232.209383] task:kworker/u128:11 state:D stack:25064 pid:72598 tgid:7259=
8 ppid:2      task_flags:0x4208060 flags:0x00080000=20
[ 1232.220529] Workqueue: writeback wb_workfn (flush-0:56)=20
[ 1232.225791] Call Trace:=20
[ 1232.228268]  <TASK>=20
[ 1232.230397]  __schedule+0x838/0x1890=20
[ 1232.234010]  ? __pfx___schedule+0x10/0x10=20
[ 1232.238047]  ? __blk_flush_plug+0x27b/0x4d0=20
[ 1232.242261]  ? find_held_lock+0x32/0x90=20
[ 1232.246122]  ? __lock_release.isra.0+0x1a4/0x2c0=20
[ 1232.250777]  schedule+0xd4/0x260=20
[ 1232.254037]  io_schedule+0x8f/0xf0=20
[ 1232.257467]  folio_wait_bit_common+0x2d9/0x780=20
[ 1232.261940]  ? folio_wait_bit_common+0x1dd/0x780=20
[ 1232.266588]  ? __pfx_folio_wait_bit_common+0x10/0x10=20
[ 1232.271582]  ? __pfx_wake_page_function+0x10/0x10=20
[ 1232.276310]  ? __pfx___might_resched+0x10/0x10=20
[ 1232.280785]  writeback_get_folio+0x3f9/0x500=20
[ 1232.285084]  writeback_iter+0x136/0x720=20
[ 1232.288945]  ? kasan_save_track+0x14/0x30=20
[ 1232.292986]  nfs_writepages+0x4f8/0x9b0 [nfs]=20
[ 1232.297427]  ? unwind_next_frame+0x3fa/0x1f10=20
[ 1232.301807]  ? __pfx_nfs_writepages+0x10/0x10 [nfs]=20
[ 1232.306753]  ? __lock_acquire+0x57c/0xbd0=20
[ 1232.310802]  do_writepages+0x21f/0x560=20
[ 1232.314588]  ? __pfx_do_writepages+0x10/0x10=20
[ 1232.318880]  ? rcu_is_watching+0x15/0xb0=20
[ 1232.322838]  __writeback_single_inode+0xe2/0x5f0=20
[ 1232.327479]  ? __lock_release.isra.0+0x1a4/0x2c0=20
[ 1232.332124]  ? __pfx___writeback_single_inode+0x10/0x10=20
[ 1232.337374]  ? writeback_sb_inodes+0x416/0xd00=20
[ 1232.341855]  writeback_sb_inodes+0x535/0xd00=20
[ 1232.346164]  ? __pfx_writeback_sb_inodes+0x10/0x10=20
[ 1232.351007]  ? lock_acquire+0x10b/0x150=20
[ 1232.354875]  ? down_read_trylock+0x4b/0x60=20
[ 1232.359003]  __writeback_inodes_wb+0xf4/0x270=20
[ 1232.363389]  ? __pfx___writeback_inodes_wb+0x10/0x10=20
[ 1232.368377]  ? queue_io+0x329/0x510=20
[ 1232.371897]  wb_writeback+0x70a/0x9c0=20
[ 1232.375594]  ? __pfx_wb_writeback+0x10/0x10=20
[ 1232.379809]  ? get_nr_dirty_inodes+0xcb/0x180=20
[ 1232.384197]  wb_do_writeback+0x586/0x8e0=20
[ 1232.388153]  ? __pfx_wb_do_writeback+0x10/0x10=20
[ 1232.392618]  ? set_worker_desc+0x16e/0x190=20
[ 1232.396742]  ? __pfx_set_worker_desc+0x10/0x10=20
[ 1232.401225]  wb_workfn+0x7c/0x200=20
[ 1232.404571]  process_one_work+0xd8b/0x1320=20
[ 1232.408703]  ? __pfx_process_one_work+0x10/0x10=20
[ 1232.413269]  ? assign_work+0x16c/0x240=20
[ 1232.417044]  worker_thread+0x5f3/0xfe0=20
[ 1232.420822]  ? __kthread_parkme+0xb4/0x200=20
[ 1232.424950]  ? __pfx_worker_thread+0x10/0x10=20
[ 1232.429243]  kthread+0x3b4/0x770=20
[ 1232.432503]  ? local_clock_noinstr+0xd/0xe0=20
[ 1232.436719]  ? __pfx_kthread+0x10/0x10=20
[ 1232.440491]  ? __lock_release.isra.0+0x1a4/0x2c0=20
[ 1232.445134]  ? rcu_is_watching+0x15/0xb0=20
[ 1232.449083]  ? __pfx_kthread+0x10/0x10=20
[ 1232.452863]  ret_from_fork+0x393/0x480=20
[ 1232.456640]  ? __pfx_kthread+0x10/0x10=20
[ 1232.460420]  ? __pfx_kthread+0x10/0x10=20
[ 1232.464200]  ret_from_fork_asm+0x1a/0x30=20
[ 1232.468162]  </TASK>=20
[ 1232.470396] =20
[ 1232.470396] Showing all locks held in the system:=20
[ 1232.476634] 1 lock held by khungtaskd/244:=20
[ 1232.480759]  #0: ffffffff93130ee0 (rcu_read_lock){....}-{1:3}, at: rcu_l=
ock_acquire.constprop.0+0x7/0x30=20
[ 1232.490280] 1 lock held by systemd-journal/823:=20
[ 1232.494845] 2 locks held by kworker/u128:1/22928:=20
[ 1232.499576]  #0: ff110001d74c8158 ((wq_completion)nfsiod){+.+.}-{0:0}, a=
t: process_one_work+0x7f5/0x1320=20
[ 1232.509083]  #1: ffffffff93130ee0 (rcu_read_lock){....}-{1:3}, at: __upd=
ate_idle_core+0x60/0x4b0=20
[ 1232.517903] 2 locks held by 751/71037:=20
[ 1232.521675]  #0: ff110001093ec440 (sb_writers#17){.+.+}-{0:0}, at: ksys_=
write+0xf9/0x1d0=20
[ 1232.529797]  #1: ffffffff9339a070 (split_debug_mutex){+.+.}-{4:4}, at: s=
plit_huge_pages_write+0x124/0x430=20
[ 1232.539390] 1 lock held by fio/71083:=20
[ 1232.543081]  #0: ff110001df650440 (sb_writers#16){.+.+}-{0:0}, at: __x64=
_sys_pwrite64+0x18a/0x1f0=20


[4]
[ 1914.416377] run fstests generic/091 at 2025-11-24 16:39:20=20
[ 1924.254098] ------------[ cut here ]------------=20
[ 1924.258831] kernel BUG at kernel/cred.c:104!=20
[ 1924.263135] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI=20
[ 1924.268729] CPU: 15 UID: 0 PID: 123850 Comm: kworker/u128:11 Kdump: load=
ed Tainted: G S                  6.18.0-rc7 #1 PREEMPT(voluntary) =20
[ 1924.281164] Tainted: [S]=3DCPU_OUT_OF_SPEC=20
[ 1924.285100] Hardware name: Dell Inc. PowerEdge R660/0R5JJC, BIOS 2.1.5 0=
3/14/2024=20
[ 1924.292580] Workqueue: nfslocaliod nfs_local_call_write [nfs]=20
[ 1924.298419] RIP: 0010:__put_cred+0xea/0x120=20
[ 1924.302622] Code: 2d 8b 83 a8 00 00 00 85 c0 74 0b 48 83 c4 08 5b 5d e9 =
fa fb ff ff 48 83 c4 08 48 c7 c6 90 5b f7 9c 5b 5d e9 b8 bd 1d 00 0f 0b <0f=
> 0b 0f 0b 48 89 3c 24 e8 b9 2b 9f 00 48 8b 3c 24 eb c4 48 89 df=20
[ 1924.321385] RSP: 0018:ffa000002e657820 EFLAGS: 00010246=20
[ 1924.326631] RAX: dffffc0000000000 RBX: ff110001d65e9e00 RCX: ffffffff9cf=
75edc=20
[ 1924.333762] RDX: 1fe220003b5f81a2 RSI: 0000000000000008 RDI: ff110001daf=
c0d10=20
[ 1924.340896] RBP: ff110001dafc0000 R08: 0000000000000000 R09: ffe21c003ac=
bd3c0=20
[ 1924.348029] R10: ff110001d65e9e07 R11: 0000000000000001 R12: 00000000000=
00000=20
[ 1924.355161] R13: ff110001c2672008 R14: ff110001c2671fe8 R15: ff110001c26=
71f80=20
[ 1924.362294] FS:  0000000000000000(0000) GS:ff1100087b2bf000(0000) knlGS:=
0000000000000000=20
[ 1924.370379] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033=20
[ 1924.376128] CR2: 00007f767afefea0 CR3: 00000001a7c76001 CR4: 0000000000f=
73ef0=20
[ 1924.383260] PKRU: 55555554=20
[ 1924.385973] Call Trace:=20
[ 1924.388424]  <TASK>=20
[ 1924.390533]  __fput+0x61e/0xaa0=20
[ 1924.393696]  nfsd_file_free+0x1a1/0x3e0 [nfsd]=20
[ 1924.398252]  nfsd_file_put_local+0x4c/0x60 [nfsd]=20
[ 1924.403038]  nfs_close_local_fh+0x272/0x980 [nfs_localio]=20
[ 1924.408454]  ? __pfx_nfs_close_local_fh+0x10/0x10 [nfs_localio]=20
[ 1924.414392]  ? rcu_is_watching+0x15/0xb0=20
[ 1924.418335]  ? kfree+0x423/0x6b0=20
[ 1924.421585]  ? put_rpccred.part.0+0x216/0x890 [sunrpc]=20
[ 1924.426828]  __put_nfs_open_context+0x380/0x500 [nfs]=20
[ 1924.431943]  nfs_pgio_header_free+0x41/0xe0 [nfs]=20
[ 1924.436707]  nfs_write_completion+0x13c/0x890 [nfs]=20
[ 1924.441650]  ? nfs_writeback_done.part.0+0xfa/0x400 [nfs]=20
[ 1924.447109]  ? __pfx_nfs_write_completion+0x10/0x10 [nfs]=20
[ 1924.452568]  ? __pfx_nfs_writeback_done.part.0+0x10/0x10 [nfs]=20
[ 1924.458462]  ? __pfx_nfs_writeback_result+0x10/0x10 [nfs]=20
[ 1924.463920]  ? nfs_writeback_done+0xec/0x130 [nfs]=20
[ 1924.468766]  nfs_local_pgio_release+0x264/0x3b0 [nfs]=20
[ 1924.473880]  ? __pfx_nfs_local_pgio_release+0x10/0x10 [nfs]=20
[ 1924.479513]  ? xfs_file_write_iter+0x21a/0xbb0 [xfs]=20
[ 1924.484837]  ? nfs_local_pgio_done+0x156/0x230 [nfs]=20
[ 1924.489872]  nfs_local_call_write+0x3e0/0x930 [nfs]=20
[ 1924.494811]  process_one_work+0xd8b/0x1320=20
[ 1924.498930]  ? __pfx_process_one_work+0x10/0x10=20
[ 1924.503478]  ? assign_work+0x16c/0x240=20
[ 1924.507231]  worker_thread+0x5f3/0xfe0=20
[ 1924.511001]  ? __pfx_worker_thread+0x10/0x10=20
[ 1924.515289]  kthread+0x3b4/0x770=20
[ 1924.518522]  ? local_clock_noinstr+0xd/0xe0=20
[ 1924.522725]  ? __pfx_kthread+0x10/0x10=20
[ 1924.526479]  ? __lock_release.isra.0+0x1a4/0x2c0=20
[ 1924.531099]  ? rcu_is_watching+0x15/0xb0=20
[ 1924.535041]  ? __pfx_kthread+0x10/0x10=20
[ 1924.538794]  ret_from_fork+0x393/0x480=20
[ 1924.542565]  ? __pfx_kthread+0x10/0x10=20
[ 1924.546317]  ? __pfx_kthread+0x10/0x10=20
[ 1924.550070]  ret_from_fork_asm+0x1a/0x30=20
[ 1924.554016]  </TASK>=20
[ 1924.556223] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver nfs ne=
tfs rpcrdma rdma_cm iw_cm ib_cm ib_core nfsd auth_rpcgss nfs_acl lockd grac=
e nfs_localio rfkill intel_rapl_msr intel_rapl_common intel_uncore_frequenc=
y intel_uncore_frequency_common intel_ifs i10nm_edac skx_edac_common nfit x=
86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm dax_hmem cxl_ac=
pi cxl_port pmt_telemetry irqbypass iTCO_wdt pmt_discovery cxl_core rapl iT=
CO_vendor_support pmt_class platform_profile intel_sdsi dell_smbios mei_me =
ipmi_ssif vfat intel_cstate isst_if_mmio isst_if_mbox_pci ses fat dcdbas in=
tel_uncore dell_wmi_descriptor wmi_bmof enclosure einj pcspkr isst_if_commo=
n mgag200 intel_vsec i2c_i801 mei i2c_ismt i2c_smbus acpi_power_meter ipmi_=
si acpi_ipmi ipmi_devintf ipmi_msghandler sg fuse loop xfs sd_mod iaa_crypt=
o igb ahci mpt3sas libahci ghash_clmulni_intel i2c_algo_bit raid_class idxd=
 tg3 libata dca scsi_transport_sas idxd_bus wmi pinctrl_emmitsburg sunrpc d=
m_mirror dm_region_hash dm_log dm_mod nfnetlink=20
[-- MARK -- Mon Nov 24 21:40:00 2025]


[5]
[ 7694.795725] run fstests generic/241 at 2025-11-24 19:00:19=20
[ 7720.894613] ------------[ cut here ]------------=20
[ 7720.894637] kernel BUG at kernel/cred.c:104!=20
[ 7720.894775] Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP=20
[ 7720.895900] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver nfs ne=
tfs rpcrdma rdma_cm iw_cm ib_cm ib_core nfsd auth_rpcgss nfs_acl lockd grac=
e nfs_localio rfkill vfat fat fuse loop vsock_loopback vmw_vsock_virtio_tra=
nsport_common vmw_vsock_vmci_transport vmw_vmci vsock xfs virtio_console vi=
rtio_net ghash_ce net_failover failover virtio_blk sunrpc dm_mirror dm_regi=
on_hash dm_log dm_mod nfnetlink=20
[ 7720.898447] CPU: 0 UID: 0 PID: 353166 Comm: kworker/u32:2 Kdump: loaded =
Not tainted 6.18.0-rc7 #1 PREEMPT(voluntary) =20
[ 7720.899197] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/20=
15=20
[ 7720.899746] Workqueue: nfslocaliod nfs_local_call_write [nfs]=20
[ 7720.900226] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=
=3D--)=20
[ 7720.900727] pc : __put_cred+0xf0/0x130=20
[ 7720.901009] lr : __put_cred+0x24/0x130=20
[ 7720.901288] sp : ffff800091db7560=20
[ 7720.901535] x29: ffff800091db7560 x28: ffff000107575880 x27: ffff0001075=
75910=20
[ 7720.902065] x26: ffff0001075758e8 x25: ffff0001075758c8 x24: 1fffe00020e=
aeb21=20
[ 7720.902591] x23: ffff000107575908 x22: 1fffe00020eaeb1d x21: 000000000c4=
f809f=20
[ 7720.903113] x20: ffff000939ea33c0 x19: ffff000360046500 x18: 00000000000=
00000=20
[ 7720.903634] x17: 010000001d170000 x16: ffffa986b3adc680 x15: ffffa9866dd=
a0ad4=20
[ 7720.904159] x14: ffffa9866ddba6f8 x13: ffffa9866dda0ad4 x12: ffff60006c0=
08ca1=20
[ 7720.904696] x11: 1fffe0006c008ca0 x10: ffff60006c008ca0 x9 : dfff8000000=
00000=20
[ 7720.905221] x8 : 00009fff93ff7360 x7 : ffff000360046507 x6 : 00000000000=
00001=20
[ 7720.905751] x5 : ffff000360046500 x4 : ffff60006c008ca1 x3 : ffffa986b39=
3b1ec=20
[ 7720.906276] x2 : 1fffe001273d47da x1 : 0000000000000000 x0 : ffff0003600=
46500=20
[ 7720.906798] Call trace:=20
[ 7720.906985]  __put_cred+0xf0/0x130 (P)=20
[ 7720.907273]  __fput+0x558/0x978=20
[ 7720.907509]  __fput_sync+0x118/0x160=20
[ 7720.907777]  nfsd_filp_close+0x50/0xc0 [nfsd]=20
[ 7720.908187]  nfsd_file_free+0x278/0x3b0 [nfsd]=20
[ 7720.908588]  nfsd_file_put+0xd0/0x188 [nfsd]=20
[ 7720.908981]  nfsd_file_put_local+0x68/0x98 [nfsd]=20
[ 7720.909398]  nfs_close_local_fh+0x22c/0x870 [nfs_localio]=20
[ 7720.909804]  __put_nfs_open_context+0x2e4/0x460 [nfs]=20
[ 7720.910243]  put_nfs_open_context+0x1c/0x30 [nfs]=20
[ 7720.910657]  nfs_pgio_header_free+0x40/0xf0 [nfs]=20
[ 7720.911059]  nfs_write_completion+0x100/0x738 [nfs]=20
[ 7720.911476]  nfs_pgio_release+0x5c/0x90 [nfs]=20
[ 7720.911859]  nfs_local_pgio_release+0x224/0x350 [nfs]=20
[ 7720.912285]  nfs_local_call_write+0x434/0xa70 [nfs]=20
[ 7720.912702]  process_one_work+0x774/0x12d0=20
[ 7720.913011]  worker_thread+0x434/0xca0=20
[ 7720.913293]  kthread+0x2ec/0x390=20
[ 7720.913543]  ret_from_fork+0x10/0x20=20
[ 7720.913814] Code: a8c37bfd d50323bf d65f03c0 d4210000 (d4210000) =20
[ 7720.914263] SMP: stopping secondary CPUs=20
[ 7720.915563] Starting crashdump kernel...=20
[ 7720.915856] Bye!=20
UEFI firmware starting.=20


