Return-Path: <linux-nfs+bounces-9530-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96023A19CC6
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 03:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 561003AB21A
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Jan 2025 02:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3FD8F7D;
	Thu, 23 Jan 2025 02:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jIdTYvOR"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76ED32914
	for <linux-nfs@vger.kernel.org>; Thu, 23 Jan 2025 02:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737598184; cv=none; b=rBY7Eko7105G6AAtl2hcbCPu/WSwPxgS1/+cbmo6mMroEtio29WF/EyVbduQHK79cdhHIKBPrRDtaobrE/nzwHLVsH+G8HAnVZ3Gu1ZznEtPw0iIdxI+tVwfnMfvcSOe88sQB0kkP9y1pqfBLh7tV8+rqSMMYqlZCfZqbdQIqHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737598184; c=relaxed/simple;
	bh=p6FP1JXEf/Pg6Ap3ul93BbXxmL3uNdAonhYDUlBEk2M=;
	h=From:Date:MIME-Version:Content-Type:To:Message-ID:In-Reply-To:
	 References:Subject; b=Ns/Vl/jVbOeugVr+pZ+TOYtxa4kdk9rVtmzXfWqjypGEbffAM7PC0FcvaHBrN43EDYG6niXUhKjwnGEIZlxqJMuJ+6nr1N4c7J7J6InXkrd6ZNZTOlFPG9Khdc5v6LJAzRAsJDUqb/70dGSj9BwoBVlnE+K0aP0XkmgjNgg8rj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jIdTYvOR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F5CC4CED2;
	Thu, 23 Jan 2025 02:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737598182;
	bh=p6FP1JXEf/Pg6Ap3ul93BbXxmL3uNdAonhYDUlBEk2M=;
	h=From:Date:To:In-Reply-To:References:Subject:From;
	b=jIdTYvORFXIpqwNWx3UMUsM52ZdAkeVWS/pvTjUaYn3WOI/U6eykHfYx2gkB6kkqe
	 j0zoKmJWTkTSAiybDBI88026dnyUgJmPPeveQ8dflejbcH1wul2JgMOv1RDVPd+6eB
	 lmLcLlC0zbbaKEvvcGogVUfvlvmtyYBlNkcYysPk3EbPVOlValjbtyVYhFGRSBAPW3
	 57oUDJ6jeq5jmxgxF4tfb1cuvcjlhBNUe2kteP7aDAiXi7hguxUB/aVY7KsGlq9hhz
	 tJ8FZNXqHi4oEnz9wNpgqfesVhs8eTNtjGoRq1UyMWZmrbq/Wgu/hWjFU6BAp78wk9
	 wRyXuNfoeWBoA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D611380AA70;
	Thu, 23 Jan 2025 02:10:08 +0000 (UTC)
From: Li Lingfeng via Bugspray Bot <bugbot@kernel.org>
Date: Thu, 23 Jan 2025 02:10:21 +0000
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: benoit.gschwind@minesparis.psl.eu, harald.dunkel@aixigo.com, 
 herzog@phys.ethz.ch, tom@talpey.com, chuck.lever@oracle.com, 
 jlayton@kernel.org, cel@kernel.org, trondmy@kernel.org, 
 baptiste.pellegrin@ac-grenoble.fr, carnil@debian.org, 
 linux-nfs@vger.kernel.org, anna@kernel.org
Message-ID: <20250123-b219710c17-c6cd701c9207@bugzilla.kernel.org>
In-Reply-To: <20250120-b219710c0-da932078cddb@bugzilla.kernel.org>
References: <20250120-b219710c0-da932078cddb@bugzilla.kernel.org>
Subject: Re: NFSD threads hang when destroying a session or client ID
X-Bugzilla-Product: File System
X-Bugzilla-Component: NFSD
X-Mailer: bugspray 0.1-dev

Li Lingfeng writes via Kernel.org Bugzilla:

(In reply to Chuck Lever from comment #0)
> On recent v6.1.y, intermittently, NFSD threads wait forever for NFSv4
> callback to shutdown. The wait is in __flush_workqueue(). A server system
> reboot is necessary to recover.
> 
> On new kernels, similar symptoms but the indefinite wait is in the "destroy
> client" path, waiting for NFSv4 callback shutdown. The wait is on the
> wait_var_event() in nfsd41_cb_inflight_wait_complete().

Hi, I've had a similar problem recently.
And I've also done some analysis.

[ 6526.031343] INFO: task bash:846259 blocked for more than 606 seconds.
[ 6526.032060]       Not tainted 6.6.0-gfbf24d352c28-dirty #22
[ 6526.032635] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 6526.033404] task:bash            state:D stack:0     pid:846259 ppid:838395 flags:0x0000020d
[ 6526.034226] Call trace:
[ 6526.034527]  __switch_to+0x218/0x3e0
[ 6526.034925]  __schedule+0x734/0x11a8
[ 6526.035323]  schedule+0xa8/0x200
[ 6526.035731]  nfsd4_shutdown_callback+0x24c/0x2f0
[ 6526.036228]  __destroy_client+0x414/0x680
[ 6526.036663]  nfs4_state_destroy_net+0x144/0x448
[ 6526.037152]  nfs4_state_shutdown_net+0x2c8/0x450
[ 6526.037640]  nfsd_shutdown_net+0x100/0x2e0
[ 6526.038078]  nfsd_last_thread+0x190/0x330
[ 6526.038518]  nfsd_svc+0x3cc/0x4a0
[ 6526.038892]  write_threads+0x15c/0x2f0
[ 6526.039301]  nfsctl_transaction_write+0x90/0xd0
[ 6526.039836]  vfs_write+0x110/0x688
[ 6526.040221]  ksys_write+0xd0/0x188
[ 6526.040607]  __arm64_sys_write+0x4c/0x68
[ 6526.041035]  invoke_syscall+0x68/0x198
[ 6526.041455]  el0_svc_common.constprop.0+0x11c/0x150
[ 6526.041967]  do_el0_svc+0x38/0x50
[ 6526.042353]  el0_svc+0x5c/0x240
[ 6526.042723]  el0t_64_sync_handler+0x100/0x130
[ 6526.043186]  el0t_64_sync+0x188/0x190
[ 6526.051007] INFO: task cat:846265 blocked for more than 606 seconds.

1) Check cl_cb_inflight
crash> nfs4_client.cl_cb_inflight ffff000012338f08
  cl_cb_inflight = {
    counter = 1
  },
crash>

2) No work is associated with nfsd
Only two works unrelated to NFSD.
crash> p callback_wq
callback_wq = $1 = (struct workqueue_struct *) 0xffff0000c30a1400
crash>
crash> workqueue_struct.cpu_pwq 0xffff0000c30a1400
  cpu_pwq = 0xccfe9cb5d8d0
crash> kmem -o
PER-CPU OFFSET VALUES:
  CPU 0: ffff2f015341c000
  CPU 1: ffff2f0153442000
  CPU 2: ffff2f0153468000
  CPU 3: ffff2f015348e000
crash>
// ffff2f015341c000 + ccfe9cb5d8d0  = FFFFFBFFEFF798D0
crash> rd FFFFFBFFEFF798D0
fffffbffeff798d0:  ffff0000d3488d00                    ..H.....
crash>
// ffff2f0153442000 + ccfe9cb5d8d0 = FFFFFBFFEFF9F8D0
crash> rd FFFFFBFFEFF9F8D0
fffffbffeff9f8d0:  ffff0000d3488d00                    ..H.....
crash>
// ffff2f0153468000 + ccfe9cb5d8d0 = FFFFFBFFEFFC58D0
crash> rd FFFFFBFFEFFC58D0
fffffbffeffc58d0:  ffff0000d3488d00                    ..H.....
crash>
// ffff2f015348e000 + ccfe9cb5d8d0 = FFFFFBFFEFFEB8D0
crash> rd FFFFFBFFEFFEB8D0
fffffbffeffeb8d0:  ffff0000d3488d00                    ..H.....
crash>
crash> pool_workqueue.pool ffff0000d3488d00
  pool = 0xffff0000c01b6800,
crash>
crash> worker_pool.worklist 0xffff0000c01b6800
  worklist = {
    next = 0xffff0000c906c4a8,
    prev = 0xffffd0ff8944fc68 <stats_flush_dwork+8>
  },
crash>
crash> list 0xffff0000c906c4a8
ffff0000c906c4a8
ffffd0ff8944fc68
ffff0000c01b6860
crash>
crash> work_struct.func ffff0000c906c4a0
  func = 0xffffd0ff84fae128 <wb_update_bandwidth_workfn>,
crash> work_struct.func 0xffffd0ff8944fc60
  func = 0xffffd0ff8510b258 <flush_memcg_stats_dwork>,
crash>

3) No running kworker
I checked vmcore by "foreach bt" and find all kworker are as follows.
PID: 62       TASK: ffff0000c31d0040  CPU: 1    COMMAND: "kworker/R-nfsio"
 #0 [ffff800080c27b80] __switch_to at ffffd0ff866297dc
 #1 [ffff800080c27bd0] __schedule at ffffd0ff8662a180
 #2 [ffff800080c27d00] schedule at ffffd0ff8662ac9c
 #3 [ffff800080c27d40] rescuer_thread at ffffd0ff84b418e4
 #4 [ffff800080c27e60] kthread at ffffd0ff84b52e14
PID: 94       TASK: ffff0000c74ba080  CPU: 0    COMMAND: "kworker/0:1H"
 #0 [ffff800080e07c00] __switch_to at ffffd0ff866297dc
 #1 [ffff800080e07c50] __schedule at ffffd0ff8662a180
 #2 [ffff800080e07d80] schedule at ffffd0ff8662ac9c
 #3 [ffff800080e07dc0] worker_thread at ffffd0ff84b40f94
 #4 [ffff800080e07e60] kthread at ffffd0ff84b52e14

4) Check works releated to nfsd4_run_cb_work
crash> p nfsd4_run_cb_work
nfsd4_run_cb_work = $5 =
 {void (struct work_struct *)} 0xffffd0ff855691e0 <nfsd4_run_cb_work>
crash> search ffffd0ff855691e0
ffff000010474138: ffffd0ff855691e0
ffff0000104750f8: ffffd0ff855691e0
ffff0000104752f0: ffffd0ff855691e0
ffff0000104756e0: ffffd0ff855691e0
ffff000012338388: ffffd0ff855691e0
ffff000012339288: ffffd0ff855691e0
ffff00001233a908: ffffd0ff855691e0
ffff00001233b808: ffffd0ff855691e0
ffff0000c745d038: ffffd0ff855691e0
ffff0000c86499f8: ffffd0ff855691e0
ffff0000c8649b30: ffffd0ff855691e0
ffff0000c9ff8dc8: ffffd0ff855691e0
crash>
ffff000010474138 --> (work) ffff000010474120
ffff0000104750f8 --> (work) ffff0000104750e0
ffff0000104752f0 --> (work) ffff0000104752d8
ffff0000104756e0 --> (work) ffff0000104756c8
ffff000012338388 --> (work) ffff000012338370
ffff000012339288 --> (work) ffff000012339270
ffff00001233a908 --> (work) ffff00001233a8f0
ffff00001233b808 --> (work) ffff00001233b7f0
ffff0000c745d038 --> (work) ffff0000c745d020
ffff0000c86499f8 --> (work) ffff0000c86499e0
ffff0000c8649b30 --> (work) ffff0000c8649b18
ffff0000c9ff8dc8 --> (work) ffff0000c9ff8db0
crash> work_struct.data ffff0000104750e0
  data = {
    counter = 68719476704 // FFFFFFFE0 bit0~5 are 0
  },
crash>
crash> work_struct.data ffff0000c9ff8db0
  data = {
    counter = 256 // 0x100
  },
crash>

I have added some debug information and am trying to reproduce it.
Could you please provide more information you got?
Or any suggestions about this?

Thanks.
> 
> In some cases, clients suspend (inactivity). The server converts them to
> courteous clients. The NFSv4 callback shutdown workqueue item for that
> client appears to be stuck waiting in rpc_shutdown_client().
> 
> Let's collect data under this bug report.

View: https://bugzilla.kernel.org/show_bug.cgi?id=219710#c17
You can reply to this message to join the discussion.
-- 
Deet-doot-dot, I am a bot.
Kernel.org Bugzilla (bugspray 0.1-dev)


