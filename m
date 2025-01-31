Return-Path: <linux-nfs+bounces-9811-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE55A24028
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Jan 2025 17:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A00AE7A2F60
	for <lists+linux-nfs@lfdr.de>; Fri, 31 Jan 2025 16:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093DB33987;
	Fri, 31 Jan 2025 16:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lo+jVQR1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D65E8467
	for <linux-nfs@vger.kernel.org>; Fri, 31 Jan 2025 16:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738340234; cv=none; b=s1xmQeVB32mVZyMcOAdeITQ4GXMZFBs0ma1KsWVgL7IFkYqj/Vgl5zyeWsaZ4uKQUzj5ucNYnIdnehtWwzFG1LpbyKER8u5wiHmujpgUH5svRWq2/zOcohBg1nX2j2WeLy06HZjMqTzathatrsgxxDiX+yciKu1SDTKFPVxHlo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738340234; c=relaxed/simple;
	bh=pKsJHpB+gPM6egoELHZ1PIBswmLRptrOYdL/N5czWTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DMvWU2oweS9slY7eqEPUdA4AI3mgcNRY6AUZnDbcm/+FKErmnxBGwNLTahejC4FU1gdX6Jgk9nwPcq6aEYnLUEPnTJtg6mJojqJX3Gk5Zh4SW8DaHYPOAbfN2TN1tJT9vJ3p/wNYg4mnJAO5aSQeV0eeS1cf9wrH9rndMVOi4ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lo+jVQR1; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5d0d32cd31aso2905204a12.0
        for <linux-nfs@vger.kernel.org>; Fri, 31 Jan 2025 08:17:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738340230; x=1738945030; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zNHwtZwrJWN/7gs6Zvkf+MuTYKwX7BtgcW1Ul8NuNEI=;
        b=lo+jVQR1Mgt6UZnwvPD6hHIoE6FXO8tXsJM3y/1VMivEpS+vu6kgXELcsx7SFTnFDD
         BXKR90fNfYXuLvouEmdaCaPQmIRfJ68jFzqj0qVLdXEuTOWIGTPIqEPsErENu4fvgURm
         yrda7bSaT0li6nNzDPfFWXbLAEPKtETEhx+99GDBrRGBIuDZk10SLNZ7PfYtv+8+GzBy
         UlteptNUw2/BJXUW3FeEJ3jLfL+BZo0EbiV3N5cdDGRBnlUIep8hKW5Dz0vXz5a86eb0
         gLatk9Au+vswGxXIbpZYeOTZvf28pWr7+EetfDnRB/Ujpu2Mu83/BPMTCKcAiG0odnUu
         3Aww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738340230; x=1738945030;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zNHwtZwrJWN/7gs6Zvkf+MuTYKwX7BtgcW1Ul8NuNEI=;
        b=w5pnVZaI8K24D8qCskEyGWC0LCGlW1RR5UKo5ZUp/+M653vqWLVTgxueCv1c2PryUT
         WHTugdWZc1veNaSpEdkc5GR+PGDlj6rbIlc+AhcWgb8XJD3w+4TMmKebblQ2tedpOaBH
         Ad4r/TUha/1F4XBwCNHXHDpWyfuYj6Z9CUMktn3GQOrxIgwsAxFOvmqbVMttT6rb13c+
         rP2qZEbHli1/4DMd0fFgCMCu2LvWYuc9CGYDdSXxLx5F5JJu+gncPymnsOMzXis9Gtth
         YfQS8YwvLu1jE5no1CcOEXJQuAtBQCf55EmOIzwlx4S+Vr/o0GuJqYmu9GmBtrS7RPOc
         dhIw==
X-Forwarded-Encrypted: i=1; AJvYcCWJwIdTE1Z47wB8ehEDKtQFMijFZng7efcjpjDwm3D3RMeYy2Kh7DDJ0HenavYLBrQ0l0PSgnTVNKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZuJnkswfva9b3FNY//si/+JlJnNgN2ozDL2IjdMur1aMnHB44
	M8zFgqQd8pYc9ToWVvHB34tclsKb4KloQTAyNiL+PevsHp2kbXPcJPNYm0RL
X-Gm-Gg: ASbGncvoIIQdC2niDnwPCS6YsuUTy9542EOgF6rMsSQ5KSxC6W52/ljHUpbqQAw8/NU
	A6HRwh7HT3Z48ZqU6IHUXdwdr5+IM178sMPQgm/Ngpx/NrVmMwKhNqVvo24znCu8XLbLkzwnKD3
	FcmcYv2Vxcgvbg4ju55qkLUs3dtpVahELnDhSZtZ9leWJZQI1JeIKtDZm33eO9rwRWa7aXiv8iS
	R9yvZJ0T715EtKRVz4gl1M1qdC3Yrt6ZL8PKQUL4N3hvI72HAljUxexjOeoIq7HcIJyECh0opKS
	5ELhxu0S0m4agKuyxhEsOp29uYsrZo7jk7cwgBPX344g9bax
X-Google-Smtp-Source: AGHT+IF/bKoCUzVnPFWpD4rnc9/4WZ2ox4VeewYssm3Au+Zb8XXDa98HnvbKPjuEQm5wQkETbfLmQw==
X-Received: by 2002:a05:6402:3511:b0:5d0:81f5:a398 with SMTP id 4fb4d7f45d1cf-5dc5efa8b65mr25999838a12.1.1738340229791;
        Fri, 31 Jan 2025 08:17:09 -0800 (PST)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e47cf8bfsm316352066b.40.2025.01.31.08.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 08:17:09 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 2C556BE2EE7; Fri, 31 Jan 2025 17:17:08 +0100 (CET)
Date: Fri, 31 Jan 2025 17:17:08 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Jeff Layton <jlayton@kernel.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	"it+linux-nfs@molgen.mpg.de" <it+linux-nfs@molgen.mpg.de>
Subject: Re: `rcu: INFO: rcu_sched self-detected stall on CPU` and spinning
 kworker `rpciod`
Message-ID: <Z5z3hBaZtUM0BQ1H@eldamar.lan>
References: <76a841e5-4e3d-4942-9a4b-24f87d6b79a5@molgen.mpg.de>
 <ZqVjVEV5IF_vz4Eq@eldamar.lan>
 <47222A7B-6B89-4260-AA16-EA7E7EAFBD68@oracle.com>
 <ZqjaX_uJqsJiCpam@eldamar.lan>
 <7ccb2a39-bb32-47f8-8366-b4d09895593f@molgen.mpg.de>
 <ZsBhuwLnejLo6iip@eldamar.lan>
 <6BEEE588-B7B0-40C0-BE91-4919A71ED052@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <6BEEE588-B7B0-40C0-BE91-4919A71ED052@oracle.com>

Hi Chuck,

On Sat, Aug 17, 2024 at 02:52:38PM +0000, Chuck Lever III wrote:
>=20
>=20
> > On Aug 17, 2024, at 4:39=E2=80=AFAM, Salvatore Bonaccorso <carnil@debia=
n.org> wrote:
> >=20
> > Hi,
> >=20
> > On Tue, Jul 30, 2024 at 02:52:47PM +0200, Paul Menzel wrote:
> >> Dear Salvatore, dear Chuck,
> >>=20
> >>=20
> >> Thank you for your messages.
> >>=20
> >>=20
> >> Am 30.07.24 um 14:19 schrieb Salvatore Bonaccorso:
> >>=20
> >>> On Sat, Jul 27, 2024 at 09:19:24PM +0000, Chuck Lever III wrote:
> >>>>=20
> >>>>> On Jul 27, 2024, at 5:15=E2=80=AFPM, Salvatore Bonaccorso <carnil@d=
ebian.org> wrote:
> >>=20
> >>>>> On Wed, Jul 17, 2024 at 07:33:24AM +0200, Paul Menzel wrote:
> >>=20
> >>>>>> Using Linux 5.15.160 on a Dell PowerEdge T440/021KCD, BIOS 2.11.2
> >>>>>> 04/22/2021, a mount from another server hung. Linux logs:
> >>>>>>=20
> >>>>>> ```
> >>>>>> $ dmesg -T
> >>>>>> [Wed Jul  3 16:39:34 2024] Linux version 5.15.160.mx64.476(root@th=
einternet.molgen.mpg.de) (gcc (GCC) 12.3.0, GNU ld (GNU Binutils) 2.41) #1 =
SMP Wed Jun 5 12:24:15 CEST 2024
> >>>>>> [Wed Jul  3 16:39:34 2024] Command line: root=3DLABEL=3Droot ro cr=
ashkernel=3D64G-:256M console=3DttyS0,115200n8 console=3Dtty0 init=3D/bin/s=
ystemd audit=3D0 random.trust_cpu=3Don systemd.unified_cgroup_hierarchy
> >>>>>> [=E2=80=A6]
> >>>>>> [Wed Jul  3 16:39:34 2024] DMI: Dell Inc. PowerEdge T440/021KCD, B=
IOS 2.11.2 04/22/2021
> >>>>>> [=E2=80=A6]
> >>>>>> [Tue Jul 16 06:00:10 2024] md: md3: data-check interrupted.
> >>>>>> [Tue Jul 16 11:06:01 2024] receive_cb_reply: Got unrecognized repl=
y: calldir 0x1 xpt_bc_xprt 00000000ee580afa xid 6890a3d2
> >>>>>> [Tue Jul 16 11:06:01 2024] receive_cb_reply: Got unrecognized repl=
y: calldir 0x1 xpt_bc_xprt 00000000d4d84570 xid 3ca4017a
> >>=20
> >> [=E2=80=A6]
> >>=20
> >>>>>> [Tue Jul 16 11:35:59 2024] receive_cb_reply: Got unrecognized repl=
y: calldir 0x1 xpt_bc_xprt 0000000028481e8f xid b682b676
> >>>>>> [Tue Jul 16 11:35:59 2024] receive_cb_reply: Got unrecognized repl=
y: calldir 0x1 xpt_bc_xprt 00000000c384ff38 xid b5d5dbf5
> >>>>>> [Tue Jul 16 11:36:40 2024] rcu: INFO: rcu_sched self-detected stal=
l on CPU
> >>>>>> [Tue Jul 16 11:36:40 2024] rcu:  13-....: (20997 ticks this GP) id=
le=3D54f/1/0x4000000000000000 softirq=3D31904928/31904928 fqs=3D4433
> >>>>>> [Tue Jul 16 11:36:40 2024]  (t=3D21017 jiffies g=3D194958993 q=3D5=
715)
> >>>>>> [Tue Jul 16 11:36:40 2024] Task dump for CPU 13:
> >>>>>> [Tue Jul 16 11:36:40 2024] task:kworker/u34:2   state:R  running t=
ask stack:    0 pid:30413 ppid:     2 flags:0x00004008
> >>>>>> [Tue Jul 16 11:36:40 2024] Workqueue: rpciod rpc_async_schedule [s=
unrpc]
> >>>>>> [Tue Jul 16 11:36:40 2024] Call Trace:
> >>>>>> [Tue Jul 16 11:36:40 2024]  <IRQ>
> >>>>>> [Tue Jul 16 11:36:40 2024]  sched_show_task.cold+0xc2/0xda
> >>>>>> [Tue Jul 16 11:36:40 2024]  rcu_dump_cpu_stacks+0xa1/0xd3
> >>>>>> [Tue Jul 16 11:36:40 2024]  rcu_sched_clock_irq.cold+0xc7/0x1e7
> >>>>>> [Tue Jul 16 11:36:40 2024]  ? trigger_load_balance+0x6d/0x300
> >>>>>> [Tue Jul 16 11:36:40 2024]  ? scheduler_tick+0xda/0x260
> >>>>>> [Tue Jul 16 11:36:40 2024]  update_process_times+0xa1/0xe0
> >>>>>> [Tue Jul 16 11:36:40 2024]  tick_sched_timer+0x8e/0xa0
> >>>>>> [Tue Jul 16 11:36:40 2024]  ? tick_sched_do_timer+0x90/0x90
> >>>>>> [Tue Jul 16 11:36:40 2024]  __hrtimer_run_queues+0x139/0x2a0
> >>>>>> [Tue Jul 16 11:36:40 2024]  hrtimer_interrupt+0xf4/0x210
> >>>>>> [Tue Jul 16 11:36:40 2024]  __sysvec_apic_timer_interrupt+0x5f/0xe0
> >>>>>> [Tue Jul 16 11:36:40 2024]  sysvec_apic_timer_interrupt+0x69/0x90
> >>>>>> [Tue Jul 16 11:36:40 2024]  </IRQ>
> >>>>>> [Tue Jul 16 11:36:40 2024]  <TASK>
> >>>>>> [Tue Jul 16 11:36:40 2024]  asm_sysvec_apic_timer_interrupt+0x16/0=
x20
> >>>>>> [Tue Jul 16 11:36:40 2024] RIP: 0010:read_tsc+0x3/0x20
> >>>>>> [Tue Jul 16 11:36:40 2024] Code: cc cc cc cc cc cc cc 8b 05 56 ab =
72 01 c3 cc cc cc cc 0f 1f 44 00 00 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 =
00 00 00 0f 01 f9 <66> 90 48 c1 e2 20 48 09 d0 c3 cc cc cc cc 66 66 2e 0f 1=
f 84 00 00
> >>>>>> [Tue Jul 16 11:36:40 2024] RSP: 0018:ffffc900087cfe00 EFLAGS: 0000=
0246
> >>>>>> [Tue Jul 16 11:36:40 2024] RAX: 00000000226dc8b8 RBX: 000000003f3c=
079e RCX: 000000000000100d
> >>>>>> [Tue Jul 16 11:36:40 2024] RDX: 00000000004535c4 RSI: 000000000000=
0046 RDI: ffffffff82435600
> >>>>>> [Tue Jul 16 11:36:40 2024] RBP: 0003ed08d3641da3 R08: ffffffffa012=
c770 R09: ffffffffa012c788
> >>>>>> [Tue Jul 16 11:36:40 2024] R10: 0000000000000003 R11: 000000000000=
0283 R12: 0000000000000000
> >>>>>> [Tue Jul 16 11:36:40 2024] R13: 0000000000000001 R14: ffff88909311=
c000 R15: ffff88909311c005
> >>>>>> [Tue Jul 16 11:36:40 2024]  ktime_get+0x38/0xa0
> >>>>>> [Tue Jul 16 11:36:40 2024]  ? rpc_sleep_on_priority+0x70/0x70 [sun=
rpc]
> >>>>>> [Tue Jul 16 11:36:40 2024]  rpc_exit_task+0x9a/0x100 [sunrpc]
> >>>>>> [Tue Jul 16 11:36:40 2024]  __rpc_execute+0x6e/0x410 [sunrpc]
> >>>>>> [Tue Jul 16 11:36:40 2024]  rpc_async_schedule+0x29/0x40 [sunrpc]
> >>>>>> [Tue Jul 16 11:36:40 2024]  process_one_work+0x1d7/0x3a0
> >>>>>> [Tue Jul 16 11:36:40 2024]  worker_thread+0x4a/0x3c0
> >>>>>> [Tue Jul 16 11:36:40 2024]  ? process_one_work+0x3a0/0x3a0
> >>>>>> [Tue Jul 16 11:36:40 2024]  kthread+0x115/0x140
> >>>>>> [Tue Jul 16 11:36:40 2024]  ? set_kthread_struct+0x50/0x50
> >>>>>> [Tue Jul 16 11:36:40 2024]  ret_from_fork+0x1f/0x30
> >>>>>> [Tue Jul 16 11:36:40 2024]  </TASK>
> >>>>>> [Tue Jul 16 11:37:19 2024] rcu: INFO: rcu_sched self-detected stal=
l on CPU
> >>>>>> [Tue Jul 16 11:37:19 2024] rcu:  7-....: (21000 ticks this GP) idl=
e=3D5b1/1/0x4000000000000000 softirq=3D29984492/29984492 fqs=3D5159
> >>>>>> [Tue Jul 16 11:37:19 2024]  (t=3D21017 jiffies g=3D194959001 q=3D2=
008)
> >>>>>> [Tue Jul 16 11:37:19 2024] Task dump for CPU 7:
> >>>>>> [Tue Jul 16 11:37:19 2024] task:kworker/u34:2   state:R  running t=
ask stack:    0 pid:30413 ppid:     2 flags:0x00004008
> >>>>>> [Tue Jul 16 11:37:19 2024] Workqueue: rpciod rpc_async_schedule [s=
unrpc]
> >>>>>> [Tue Jul 16 11:37:19 2024] Call Trace:
> >>>>>> [Tue Jul 16 11:37:19 2024]  <IRQ>
> >>>>>> [Tue Jul 16 11:37:19 2024]  sched_show_task.cold+0xc2/0xda
> >>>>>> [Tue Jul 16 11:37:19 2024]  rcu_dump_cpu_stacks+0xa1/0xd3
> >>>>>> [Tue Jul 16 11:37:19 2024]  rcu_sched_clock_irq.cold+0xc7/0x1e7
> >>>>>> [Tue Jul 16 11:37:19 2024]  ? trigger_load_balance+0x6d/0x300
> >>>>>> [Tue Jul 16 11:37:19 2024]  ? scheduler_tick+0xda/0x260
> >>>>>> [Tue Jul 16 11:37:19 2024]  update_process_times+0xa1/0xe0
> >>>>>> [Tue Jul 16 11:37:19 2024]  tick_sched_timer+0x8e/0xa0
> >>>>>> [Tue Jul 16 11:37:19 2024]  ? tick_sched_do_timer+0x90/0x90
> >>>>>> [Tue Jul 16 11:37:19 2024]  __hrtimer_run_queues+0x139/0x2a0
> >>>>>> [Tue Jul 16 11:37:19 2024]  hrtimer_interrupt+0xf4/0x210
> >>>>>> [Tue Jul 16 11:37:19 2024]  __sysvec_apic_timer_interrupt+0x5f/0xe0
> >>>>>> [Tue Jul 16 11:37:19 2024]  sysvec_apic_timer_interrupt+0x69/0x90
> >>>>>> [Tue Jul 16 11:37:19 2024]  </IRQ>
> >>>>>> [Tue Jul 16 11:37:19 2024]  <TASK>
> >>>>>> [Tue Jul 16 11:37:19 2024]  asm_sysvec_apic_timer_interrupt+0x16/0=
x20
> >>>>>> [Tue Jul 16 11:37:19 2024] RIP: 0010:_raw_spin_lock+0x10/0x20
> >>>>>> [Tue Jul 16 11:37:19 2024] Code: b8 00 02 00 00 f0 0f c1 07 a9 ff =
01 00 00 75 05 c3 cc cc cc cc e9 f0 05 59 ff 0f 1f 44 00 00 31 c0 ba 01 00 =
00 00 f0 0f b1 17 <75> 05 c3 cc cc cc cc 89 c6 e9 62 02 59 ff 66 90 0f 1f 4=
4 00 00 fa
> >>>>>> [Tue Jul 16 11:37:19 2024] RSP: 0018:ffffc900087cfe30 EFLAGS: 0000=
0246
> >>>>>> [Tue Jul 16 11:37:19 2024] RAX: 0000000000000000 RBX: ffff88997131=
a500 RCX: 0000000000000001
> >>>>>> [Tue Jul 16 11:37:19 2024] RDX: 0000000000000001 RSI: ffff88997131=
a500 RDI: ffffffffa012c700
> >>>>>> [Tue Jul 16 11:37:19 2024] RBP: ffffffffa012c700 R08: ffffffffa012=
c770 R09: ffffffffa012c788
> >>>>>> [Tue Jul 16 11:37:19 2024] R10: 0000000000000003 R11: 000000000000=
0283 R12: ffff88997131a530
> >>>>>> [Tue Jul 16 11:37:19 2024] R13: 0000000000000001 R14: ffff88909311=
c000 R15: ffff88909311c005
> >>>>>> [Tue Jul 16 11:37:19 2024]  __rpc_execute+0x95/0x410 [sunrpc]
> >>>>>> [Tue Jul 16 11:37:19 2024]  rpc_async_schedule+0x29/0x40 [sunrpc]
> >>>>>> [Tue Jul 16 11:37:19 2024]  process_one_work+0x1d7/0x3a0
> >>>>>> [Tue Jul 16 11:37:19 2024]  worker_thread+0x4a/0x3c0
> >>>>>> [Tue Jul 16 11:37:19 2024]  ? process_one_work+0x3a0/0x3a0
> >>>>>> [Tue Jul 16 11:37:19 2024]  kthread+0x115/0x140
> >>>>>> [Tue Jul 16 11:37:19 2024]  ? set_kthread_struct+0x50/0x50
> >>>>>> [Tue Jul 16 11:37:19 2024]  ret_from_fork+0x1f/0x30
> >>>>>> [Tue Jul 16 11:37:19 2024]  </TASK>
> >>>>>> [Tue Jul 16 11:37:57 2024] rcu: INFO: rcu_sched self-detected stal=
l on CPU
> >>>>>> [=E2=80=A6]
> >>>>>> ```
> >>>>>=20
> >>>>> FWIW, on one NFS server occurence we are seeing something very close
> >>>>> to the above but in the 5.10.y case for the Debian kernel after
> >>>>> updating to 5.10.218-1 to 5.10.221-1, so kernel after which had the
> >>>>> big NFS related stack backported.
> >>>>>=20
> >>>>> One backtrace we were able to catch was
> >>>>>=20
> >>>>> [...]
> >>>>> Jul 27 15:24:52 nfsserver kernel: receive_cb_reply: Got unrecognize=
d reply: calldir 0x1 xpt_bc_xprt 000000003d26f7ec xid b172e1c6
> >>>>> Jul 27 15:24:52 nfsserver kernel: receive_cb_reply: Got unrecognize=
d reply: calldir 0x1 xpt_bc_xprt 0000000017f1552a xid a90d7751
> >>>>> Jul 27 15:24:52 nfsserver kernel: receive_cb_reply: Got unrecognize=
d reply: calldir 0x1 xpt_bc_xprt 000000006337c521 xid 8e5e58bd
> >>>>> Jul 27 15:24:54 nfsserver kernel: receive_cb_reply: Got unrecognize=
d reply: calldir 0x1 xpt_bc_xprt 00000000cbf89319 xid c2da3c73
> >>>>> Jul 27 15:24:54 nfsserver kernel: receive_cb_reply: Got unrecognize=
d reply: calldir 0x1 xpt_bc_xprt 00000000e2588a21 xid a01bfec6
> >>>>> Jul 27 15:24:54 nfsserver kernel: receive_cb_reply: Got unrecognize=
d reply: calldir 0x1 xpt_bc_xprt 000000005fda63ca xid c2eeeaa6
> >>>>> [...]
> >>>>> Jul 27 15:25:15 nfsserver kernel: rcu: INFO: rcu_sched self-detecte=
d stall on CPU
> >>>>> Jul 27 15:25:15 nfsserver kernel: rcu:         15-....: (5250 ticks=
 this GP) idle=3D74e/1/0x4000000000000000 softirq=3D3160997/3161006 fqs=3D2=
233
> >>>>> Jul 27 15:25:15 nfsserver kernel:         (t=3D5255 jiffies g=3D838=
1377 q=3D106333)
> >>>>> Jul 27 15:25:15 nfsserver kernel: NMI backtrace for cpu 15
> >>>>> Jul 27 15:25:15 nfsserver kernel: CPU: 15 PID: 3725556 Comm: kworke=
r/u42:4 Not tainted 5.10.0-31-amd64 #1 Debian 5.10.221-1
> >>>>> Jul 27 15:25:15 nfsserver kernel: Hardware name: DALCO AG S2600WFT/=
S2600WFT, BIOS SE5C620.86B.02.01.0008.031920191559 03/19/2019
> >>>>> Jul 27 15:25:15 nfsserver kernel: Workqueue: rpciod rpc_async_sched=
ule [sunrpc]
> >>>>> Jul 27 15:25:15 nfsserver kernel: Call Trace:
> >>>>> Jul 27 15:25:15 nfsserver kernel:  <IRQ>
> >>>>> Jul 27 15:25:15 nfsserver kernel:  dump_stack+0x6b/0x83
> >>>>> Jul 27 15:25:15 nfsserver kernel:  nmi_cpu_backtrace.cold+0x32/0x69
> >>>>> Jul 27 15:25:15 nfsserver kernel:  ? lapic_can_unplug_cpu+0x80/0x80
> >>>>> Jul 27 15:25:15 nfsserver kernel:  nmi_trigger_cpumask_backtrace+0x=
df/0xf0
> >>>>> Jul 27 15:25:15 nfsserver kernel:  rcu_dump_cpu_stacks+0xa5/0xd7
> >>>>> Jul 27 15:25:15 nfsserver kernel:  rcu_sched_clock_irq.cold+0x202/0=
x3d9
> >>>>> Jul 27 15:25:15 nfsserver kernel:  ? trigger_load_balance+0x5a/0x220
> >>>>> Jul 27 15:25:15 nfsserver kernel:  update_process_times+0x8c/0xc0
> >>>>> Jul 27 15:25:15 nfsserver kernel:  tick_sched_handle+0x22/0x60
> >>>>> Jul 27 15:25:15 nfsserver kernel:  tick_sched_timer+0x65/0x80
> >>>>> Jul 27 15:25:15 nfsserver kernel:  ? tick_sched_do_timer+0x90/0x90
> >>>>> Jul 27 15:25:15 nfsserver kernel:  __hrtimer_run_queues+0x127/0x280
> >>>>> Jul 27 15:25:15 nfsserver kernel:  hrtimer_interrupt+0x110/0x2c0
> >>>>> Jul 27 15:25:15 nfsserver kernel:  __sysvec_apic_timer_interrupt+0x=
5c/0xe0
> >>>>> Jul 27 15:25:15 nfsserver kernel:  asm_call_irq_on_stack+0xf/0x20
> >>>>> Jul 27 15:25:15 nfsserver kernel:  </IRQ>
> >>>>> Jul 27 15:25:15 nfsserver kernel:  sysvec_apic_timer_interrupt+0x72=
/0x80
> >>>>> Jul 27 15:25:15 nfsserver kernel:  asm_sysvec_apic_timer_interrupt+=
0x12/0x20
> >>>>> Jul 27 15:25:15 nfsserver kernel: RIP: 0010:mod_delayed_work_on+0x5=
d/0x90
> >>>>> Jul 27 15:25:15 nfsserver kernel: Code: 00 4c 89 e7 e8 34 fe ff ff =
89 c3 83 f8 f5 74 e9 85 c0 78 1b 89 ef 4c 89 f1 4c 89 e2 4c 89 ee e8 f9 fc =
ff ff 48 8b 3c 24 57 9d <0f> 1f 44 >
> >>>>> Jul 27 15:25:15 nfsserver kernel: RSP: 0018:ffffb5efe356fd90 EFLAGS=
: 00000246
> >>>>> Jul 27 15:25:15 nfsserver kernel: RAX: 0000000000000000 RBX: 000000=
0000000000 RCX: 000000003820000f
> >>>>> Jul 27 15:25:15 nfsserver kernel: RDX: 0000000038000000 RSI: 000000=
0000000046 RDI: 0000000000000246
> >>>>> Jul 27 15:25:15 nfsserver kernel: RBP: 0000000000002000 R08: ffffff=
ffc0884430 R09: ffffffffc0884448
> >>>>> Jul 27 15:25:15 nfsserver kernel: R10: 0000000000000003 R11: 000000=
0000000003 R12: ffffffffc0884428
> >>>>> Jul 27 15:25:15 nfsserver kernel: R13: ffff8c89d0f6b800 R14: 000000=
00000001f4 R15: 0000000000000000
> >>>>> Jul 27 15:25:15 nfsserver kernel:  __rpc_sleep_on_priority_timeout+=
0x111/0x120 [sunrpc]
> >>>>> Jul 27 15:25:15 nfsserver kernel:  rpc_delay+0x56/0x90 [sunrpc]
> >>>>> Jul 27 15:25:15 nfsserver kernel:  rpc_exit_task+0x5a/0x140 [sunrpc]
> >>>>> Jul 27 15:25:15 nfsserver kernel:  ? __rpc_do_wake_up_task_on_wq+0x=
1e0/0x1e0 [sunrpc]
> >>>>> Jul 27 15:25:15 nfsserver kernel:  __rpc_execute+0x6d/0x410 [sunrpc]
> >>>>> Jul 27 15:25:15 nfsserver kernel:  rpc_async_schedule+0x29/0x40 [su=
nrpc]
> >>>>> Jul 27 15:25:15 nfsserver kernel:  process_one_work+0x1b3/0x350
> >>>>> Jul 27 15:25:15 nfsserver kernel:  worker_thread+0x53/0x3e0
> >>>>> Jul 27 15:25:15 nfsserver kernel:  ? process_one_work+0x350/0x350
> >>>>> Jul 27 15:25:15 nfsserver kernel:  kthread+0x118/0x140
> >>>>> Jul 27 15:25:15 nfsserver kernel:  ? __kthread_bind_mask+0x60/0x60
> >>>>> Jul 27 15:25:15 nfsserver kernel:  ret_from_fork+0x1f/0x30
> >>>>> [...]
> >>>>>=20
> >>>>> Is there anything which could help debug this issue?
> >>>>=20
> >>>> The backtrace suggests an issue in the RPC client code; the
> >>>> server's NFSv4.1 backchannel would use that to send callbacks.
> >>>>=20
> >>>> Since 5.10.218 and 5.10.221 are only about a thousand commits
> >>>> apart, a bisect should be quick and narrow down the issue to
> >>>> one or two commits.
> >>>=20
> >>> Yes indeed. Unfortunately was yet unable to reproduce the issue in
> >>> more syntentic way on test environment, and the affected server in
> >>> particular is a production system.
> >>>=20
> >>> Paul, is your case in some way reproducible in a testing environment
> >>> so that a bisection might be give enough hints on the problem?
> >> We hit this issue once more on the same server with Linux 5.15.160, an=
d had
> >> to hard reboot it.
> >>=20
> >> Unfortunately we did not have time yet to set up a test system to find=
 a
> >> reproducer. In our cases a lot of compute servers seem to have accesse=
d the
> >> NFS server. A lot of the many processes were `zstd` on a first glance.
> >=20
> > So we neither, due to the nature of the server (production system) and
> > unability to reproduce the issue under some more controlled way and on
> > test environment.
> >=20
> > In our case users seems to cause workloads involving use of wandb.
> >=20
> > What we tried is to boot the recent kernel from 5.10.y series avaiable
> > (5.10.223-1). Then the issue showed up still. Since we disabled
> > fs.leases-enable the situation seems to be more stable). While this
> > is/might not be the solution, does that gives some additional hits?
>=20
> The problem is backchannel-related, and disabling delegation
> will reduce the number of backchannel operations. Your finding
> comports with our current theory, but I can't think of how it
> narrows the field of suspects.
>=20
> Is the server running short on memory, perhaps? One backchannel
> operation that was added in v5.10.220 is CB_RECALL_ANY, which
> is triggered on memory exhaustion. But that should be a fairly
> harmless addition unless there is a bug in there somewhere.
>=20
> If your NFS server does not have any NFS mounts, then we could
> provide instructions for enabling client-side tracing to watch
> the details of callback traffic.

The NFS server acts as well as NFS client, so tracing more
back-channel related will I guess just load the tracing more.

But we got "lucky" and we were able to trigger the issue twice in last
days, once NFSv4 delegations were enabled again and some users started
to cause more load on the specific server as well.

I did issue=20

	rpcdebug -m rpc -c

before rebooting/resetting the server  which is

Jan 30 05:27:05 nfsserver kernel: 26407 2281   -512 3d1fdb92        0      =
  0 79bc1aa5 nfs4_cbv1 CB_RECALL_ANY a:rpc_exit_task [sunrpc] q:delayq

and the first RPC related soft lookup slapt in the log/journal I was
able to gather is:

Jan 29 22:34:05 nfsserver kernel: watchdog: BUG: soft lockup - CPU#11 stuck=
 for 23s! [kworker/u42:3:705574]
Jan 29 22:34:05 nfsserver kernel: Modules linked in: binfmt_misc rpcsec_gss=
_krb5 nfsv4 dns_resolver nfs fscache bonding quota_v2 quota_tree ipmi_ssif =
intel_rapl_msr intel_rapl_common skx_edac skx_edac_common nfit libnvdimm x8=
6_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass ghash_=
clmulni_intel aesni_intel libaes crypto_simd cryptd ast glue_helper drm_vra=
m_helper drm_ttm_helper rapl acpi_ipmi ttm iTCO_wdt intel_cstate ipmi_si in=
tel_pmc_bxt drm_kms_helper mei_me iTCO_vendor_support ipmi_devintf cec ioat=
dma intel_uncore pcspkr evdev joydev sg i2c_algo_bit watchdog mei dca ipmi_=
msghandler acpi_power_meter acpi_pad button fuse drm configfs nfsd auth_rpc=
gss nfs_acl lockd grace sunrpc ip_tables x_tables autofs4 ext4 crc16 mbcach=
e jbd2 raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor asy=
nc_tx xor raid6_pq libcrc32c crc32c_generic raid1 raid0 multipath linear md=
_mod dm_mod hid_generic usbhid hid sd_mod t10_pi crc_t10dif crct10dif_gener=
ic xhci_pci ahci xhci_hcd libahci i40e libata
Jan 29 22:34:05 nfsserver kernel:  crct10dif_pclmul arcmsr crct10dif_common=
 ptp crc32_pclmul usbcore crc32c_intel scsi_mod pps_core i2c_i801 lpc_ich i=
2c_smbus wmi usb_common
Jan 29 22:34:05 nfsserver kernel: CPU: 11 PID: 705574 Comm: kworker/u42:3 N=
ot tainted 5.10.0-33-amd64 #1 Debian 5.10.226-1
Jan 29 22:34:05 nfsserver kernel: Hardware name: DALCO AG S2600WFT/S2600WFT=
, BIOS SE5C620.86B.02.01.0008.031920191559 03/19/2019
Jan 29 22:34:05 nfsserver kernel: Workqueue: rpciod rpc_async_schedule [sun=
rpc]
Jan 29 22:34:05 nfsserver kernel: RIP: 0010:ktime_get+0x7b/0xa0
Jan 29 22:34:05 nfsserver kernel: Code: d1 e9 48 f7 d1 48 89 c2 48 85 c1 8b=
 05 ae 2c a5 02 8b 0d ac 2c a5 02 48 0f 45 d5 8b 35 7e 2c a5 02 41 39 f4 75=
 9e 48 0f af c2 <48> 01 f8 48 d3 e8 48 01 d8 5b 5d 41 5c c3 cc cc cc cc f3 =
90 eb 84
Jan 29 22:34:05 nfsserver kernel: RSP: 0018:ffffa1aca9227e00 EFLAGS: 000002=
02
Jan 29 22:34:05 nfsserver kernel: RAX: 0000371a545e1910 RBX: 000005fce82a43=
72 RCX: 0000000000000018
Jan 29 22:34:05 nfsserver kernel: RDX: 000000000078efbe RSI: 000000000031f2=
38 RDI: 00385c1353c92824
Jan 29 22:34:05 nfsserver kernel: RBP: 0000000000000000 R08: ffffffffc081f4=
10 R09: ffffffffc081f410
Jan 29 22:34:05 nfsserver kernel: R10: 0000000000000003 R11: 00000000000000=
03 R12: 000000000031f238
Jan 29 22:34:05 nfsserver kernel: R13: ffff8ed42bf34830 R14: 00000000000000=
01 R15: 0000000000000000
Jan 29 22:34:05 nfsserver kernel: FS:  0000000000000000(0000) GS:ffff8ee94f=
880000(0000) knlGS:0000000000000000
Jan 29 22:34:05 nfsserver kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 00000000=
80050033
Jan 29 22:34:05 nfsserver kernel: CR2: 00007ffddf306080 CR3: 00000017c420a0=
02 CR4: 00000000007706e0
Jan 29 22:34:05 nfsserver kernel: DR0: 0000000000000000 DR1: 00000000000000=
00 DR2: 0000000000000000
Jan 29 22:34:05 nfsserver kernel: DR3: 0000000000000000 DR6: 00000000fffe0f=
f0 DR7: 0000000000000400
Jan 29 22:34:05 nfsserver kernel: PKRU: 55555554
Jan 29 22:34:05 nfsserver kernel: Call Trace:
Jan 29 22:34:05 nfsserver kernel:  <IRQ>
Jan 29 22:34:05 nfsserver kernel:  ? watchdog_timer_fn+0x1bb/0x210
Jan 29 22:34:05 nfsserver kernel:  ? lockup_detector_update_enable+0x50/0x50
Jan 29 22:34:05 nfsserver kernel:  ? __hrtimer_run_queues+0x127/0x280
Jan 29 22:34:05 nfsserver kernel:  ? hrtimer_interrupt+0x110/0x2c0
Jan 29 22:34:05 nfsserver kernel:  ? __sysvec_apic_timer_interrupt+0x5c/0xe0
Jan 29 22:34:05 nfsserver kernel:  ? asm_call_irq_on_stack+0xf/0x20
Jan 29 22:34:05 nfsserver kernel:  </IRQ>
Jan 29 22:34:05 nfsserver kernel:  ? sysvec_apic_timer_interrupt+0x72/0x80
Jan 29 22:34:05 nfsserver kernel:  ? asm_sysvec_apic_timer_interrupt+0x12/0=
x20
Jan 29 22:34:05 nfsserver kernel:  ? ktime_get+0x7b/0xa0
Jan 29 22:34:05 nfsserver kernel:  rpc_exit_task+0x96/0x140 [sunrpc]
Jan 29 22:34:05 nfsserver kernel:  ? __rpc_do_wake_up_task_on_wq+0x1e0/0x1e=
0 [sunrpc]
Jan 29 22:34:05 nfsserver kernel:  __rpc_execute+0x6d/0x410 [sunrpc]
Jan 29 22:34:05 nfsserver kernel:  rpc_async_schedule+0x29/0x40 [sunrpc]
Jan 29 22:34:05 nfsserver kernel:  process_one_work+0x1b3/0x350
Jan 29 22:34:05 nfsserver kernel:  worker_thread+0x53/0x3e0
Jan 29 22:34:05 nfsserver kernel:  ? process_one_work+0x350/0x350
Jan 29 22:34:05 nfsserver kernel:  kthread+0x118/0x140
Jan 29 22:34:05 nfsserver kernel:  ? __kthread_bind_mask+0x60/0x60
Jan 29 22:34:05 nfsserver kernel:  ret_from_fork+0x1f/0x30

I can try to pick on top of the kernel the change Chuck mentioned to
me offlist, which is the posting of
https://lore.kernel.org/linux-nfs/1738271066-6727-1-git-send-email-dai.ngo@=
oracle.com/,
and in fact this could be interesting. If the users keep doing the
same kind of load, this might help understanding more the issue.

As we suspect that the issue is more frequently triggered after the
switch of 5.10.118 -> 5.10.221, this enforces more the above, which
says it fixes 66af25799940 ("NFSD: add courteous server support for
thread with only delegation"), which is in 5.19-rc1, but got
backported to 5.15.154 and 5.10.220 as well.

Thanks for all your help,

Regards,
Salvatore

