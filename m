Return-Path: <linux-nfs+bounces-5195-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02A7B9411B0
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jul 2024 14:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABF36285010
	for <lists+linux-nfs@lfdr.de>; Tue, 30 Jul 2024 12:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA0C91990C4;
	Tue, 30 Jul 2024 12:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9oaOyZ1"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6791957F0
	for <linux-nfs@vger.kernel.org>; Tue, 30 Jul 2024 12:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722341990; cv=none; b=MhGMH2gSsUVN6y17x/1/CLqyqgF6iDm2+Mm+Hp2xBeYSyAIPUmip9H9FSwwhL7L8DYvSmf2PslvDZwn9LJSE5YgQCa9gJ/G2LrPRuxn6G4zYfm1iaBBhuUdsNNeY0z1u+Y42ecZYEWbppt9phE0L5V2XtLcBDEUTlu8Uh2hN7mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722341990; c=relaxed/simple;
	bh=H+EfkB6cQJcWDuUgBVxeQ5uRzlmdcnhTEmaKUybTzxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVzbSq4pG43J3uYsNe9iF7kpXBGkNUT+wYQm10WTIpkD9sh50RoTMw6c+9cTezqrp8dhLxCPEvLQDc+a0oc7ivH1lclBvoR0mb4QkrTJDUOgognDPupc8ZxzsSAqlJKCryotCYD2KPqjMCS2jbRG2ng1AxdB4/gR72UYeObtkfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9oaOyZ1; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5af51684d52so4491980a12.1
        for <linux-nfs@vger.kernel.org>; Tue, 30 Jul 2024 05:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722341987; x=1722946787; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eb4lTAxixiHGK2otBW89hJ9oRWFKh01cXn3xEcmxAss=;
        b=K9oaOyZ12xf83Wm8hWRx9Yx5JHKU6A0hr/HyZexwJ5FDp7wYsqQX1ZNmgoCPgwfkKN
         veost4mclKfcEBzrp7SoOdbKE1Jlf7cKnI6RT1Jf2FjIUm687jy7UQDyHkvjBOP5sh9U
         W8UjGyb1/dwHdBSxWCIdyrhrbjuzBus/QOwkbvO6RSrjlJOy/3A7p6QEnAYkK0oqyTlQ
         ll3Tn/plqFtHhEAOBVjWJM0ksvh5eaQDlztzShBJ4teZ/Gm9dxyo+V8Gl5v5qVvTwqUl
         77isbImVE/kIjfDFxh+Wj5fMUIbdk1TwrypEybvZoHjEn/5ZdfkqNsJ2z7ou0IrFneoL
         cXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722341987; x=1722946787;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Eb4lTAxixiHGK2otBW89hJ9oRWFKh01cXn3xEcmxAss=;
        b=HLzh4VAX+MVz6/vBak4DOjpW9OqmhwDSfRLaz/QWBhvFpuNh6MD3liK4+x/Nhhfnyu
         6hzgunfW5n/IB5BlRksl0uIhDgUnJ6Nsi9BzL5xnBSrnyhzCi5Qs3Lv+FpMxzefeGZS3
         HjXp1tBcYFnaeFBZJO5do2VP4IAkW/cqXXitsWASb02kLuYatX7DJkLp/8a7PLXL1lAN
         kKhzD6m7OBGOBqHUBdp801ysHQBHDYL4A8fy3Z3qee9doNth54lG0yhJkfJzCNgKGQ7g
         uI+HubmjyN0uJg5TVBjWqIrh9tg26Q+UltHzy/pTMY/IIEiJKDjS7ATVLDlp2c047hzR
         9kLw==
X-Forwarded-Encrypted: i=1; AJvYcCXdqjHHha5tvzc3oUbPY4/YAGq5YXS3iNyjs6p5W110HE3UXteO/pFPyXB+eWkF6+oF6KBCE/69VCoau9MP24qRxE1bSGkyahRk
X-Gm-Message-State: AOJu0YwbAwdwqJ761/zNkdK7mQZnY2vclCz45gm7rVj7APVHrXEecFM6
	oSd/8BP8rNRQpiSzpOZUFJeUNIpVVaiJTheHW9/h9nT8izT/fEgi
X-Google-Smtp-Source: AGHT+IGf7Lr5Sim+NY89CVRsszaZKIJjDw/C6Zp3o4ocMoPgIUxoRw8nDgg3ZI8fIJ9blmwL54Zadw==
X-Received: by 2002:a17:907:849:b0:a72:8d2f:859c with SMTP id a640c23a62f3a-a7d40043ebamr636561066b.33.1722341986199;
        Tue, 30 Jul 2024 05:19:46 -0700 (PDT)
Received: from eldamar.lan (host-79-40-60-99.business.telecomitalia.it. [79.40.60.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab2339fsm638297966b.24.2024.07.30.05.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 05:19:44 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 60F69BE2DE0; Tue, 30 Jul 2024 14:19:43 +0200 (CEST)
Date: Tue, 30 Jul 2024 14:19:43 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Jeff Layton <jlayton@kernel.org>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	"it+linux-nfs@molgen.mpg.de" <it+linux-nfs@molgen.mpg.de>
Subject: Re: `rcu: INFO: rcu_sched self-detected stall on CPU` and spinning
 kworker `rpciod`
Message-ID: <ZqjaX_uJqsJiCpam@eldamar.lan>
References: <76a841e5-4e3d-4942-9a4b-24f87d6b79a5@molgen.mpg.de>
 <ZqVjVEV5IF_vz4Eq@eldamar.lan>
 <47222A7B-6B89-4260-AA16-EA7E7EAFBD68@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <47222A7B-6B89-4260-AA16-EA7E7EAFBD68@oracle.com>

Hi Chuck,

On Sat, Jul 27, 2024 at 09:19:24PM +0000, Chuck Lever III wrote:
> 
> 
> > On Jul 27, 2024, at 5:15 PM, Salvatore Bonaccorso <carnil@debian.org> wrote:
> > 
> > Hi,
> > 
> > On Wed, Jul 17, 2024 at 07:33:24AM +0200, Paul Menzel wrote:
> >> Dear Linux folks,
> >> 
> >> 
> >> Using Linux 5.15.160 on a Dell PowerEdge T440/021KCD, BIOS 2.11.2
> >> 04/22/2021, a mount from another server hung. Linux logs:
> >> 
> >> ```
> >> $ dmesg -T
> >> [Wed Jul  3 16:39:34 2024] Linux version 5.15.160.mx64.476
> >> (root@theinternet.molgen.mpg.de) (gcc (GCC) 12.3.0, GNU ld (GNU Binutils)
> >> 2.41) #1 SMP Wed Jun 5 12:24:15 CEST 2024
> >> [Wed Jul  3 16:39:34 2024] Command line: root=LABEL=root ro
> >> crashkernel=64G-:256M console=ttyS0,115200n8 console=tty0 init=/bin/systemd
> >> audit=0 random.trust_cpu=on systemd.unified_cgroup_hierarchy
> >> […]
> >> [Wed Jul  3 16:39:34 2024] DMI: Dell Inc. PowerEdge T440/021KCD, BIOS 2.11.2
> >> 04/22/2021
> >> […]
> >> [Tue Jul 16 06:00:10 2024] md: md3: data-check interrupted.
> >> [Tue Jul 16 11:06:01 2024] receive_cb_reply: Got unrecognized reply: calldir
> >> 0x1 xpt_bc_xprt 00000000ee580afa xid 6890a3d2
> >> [Tue Jul 16 11:06:01 2024] receive_cb_reply: Got unrecognized reply: calldir
> >> 0x1 xpt_bc_xprt 00000000d4d84570 xid 3ca4017a
> >> [Tue Jul 16 11:06:01 2024] receive_cb_reply: Got unrecognized reply: calldir
> >> 0x1 xpt_bc_xprt 00000000aeeb49cf xid b6f12d96
> >> [Tue Jul 16 11:06:01 2024] receive_cb_reply: Got unrecognized reply: calldir
> >> 0x1 xpt_bc_xprt 0000000056d1aff1 xid 6ad5584a
> >> [Tue Jul 16 11:06:01 2024] receive_cb_reply: Got unrecognized reply: calldir
> >> 0x1 xpt_bc_xprt 0000000008075849 xid 406ed865
> >> [Tue Jul 16 11:06:01 2024] receive_cb_reply: Got unrecognized reply: calldir
> >> 0x1 xpt_bc_xprt 0000000028481e8f xid 7f81b676
> >> [Tue Jul 16 11:06:01 2024] receive_cb_reply: Got unrecognized reply: calldir
> >> 0x1 xpt_bc_xprt 00000000155c8644 xid 26099b1f
> >> [Tue Jul 16 11:06:01 2024] receive_cb_reply: Got unrecognized reply: calldir
> >> 0x1 xpt_bc_xprt 00000000c384ff38 xid 7ed4dbf5
> >> [Tue Jul 16 11:06:01 2024] receive_cb_reply: Got unrecognized reply: calldir
> >> 0x1 xpt_bc_xprt 000000001bba6d7e xid a930d2bf
> >> [Tue Jul 16 11:11:04 2024] receive_cb_reply: Got unrecognized reply: calldir
> >> 0x1 xpt_bc_xprt 00000000155c8644 xid 5b099b1f
> >> [Tue Jul 16 11:11:04 2024] receive_cb_reply: Got unrecognized reply: calldir
> >> 0x1 xpt_bc_xprt 00000000c384ff38 xid b3d4dbf5
> >> [Tue Jul 16 11:11:04 2024] receive_cb_reply: Got unrecognized reply: calldir
> >> 0x1 xpt_bc_xprt 000000001bba6d7e xid de30d2bf
> >> [Tue Jul 16 11:20:21 2024] receive_cb_reply: Got unrecognized reply: calldir
> >> 0x1 xpt_bc_xprt 000000001bba6d7e xid 4431d2bf
> >> [Tue Jul 16 11:35:58 2024] receive_cb_reply: Got unrecognized reply: calldir
> >> 0x1 xpt_bc_xprt 000000007ce5d717 xid 2c364663
> >> [Tue Jul 16 11:35:58 2024] receive_cb_reply: Got unrecognized reply: calldir
> >> 0x1 xpt_bc_xprt 000000001bba6d7e xid df31d2bf
> >> [Tue Jul 16 11:35:58 2024] receive_cb_reply: Got unrecognized reply: calldir
> >> 0x1 xpt_bc_xprt 000000000be8f11f xid acdab0f5
> >> [Tue Jul 16 11:35:58 2024] receive_cb_reply: Got unrecognized reply: calldir
> >> 0x1 xpt_bc_xprt 00000000d6d182c4 xid 3d172cb9
> >> [Tue Jul 16 11:35:58 2024] receive_cb_reply: Got unrecognized reply: calldir
> >> 0x1 xpt_bc_xprt 00000000976cd55a xid a6cb0a18
> >> [Tue Jul 16 11:35:58 2024] receive_cb_reply: Got unrecognized reply: calldir
> >> 0x1 xpt_bc_xprt 00000000e11f40dd xid 35f006fd
> >> [Tue Jul 16 11:35:58 2024] receive_cb_reply: Got unrecognized reply: calldir
> >> 0x1 xpt_bc_xprt 0000000042906e77 xid d9415db0
> >> [Tue Jul 16 11:35:58 2024] receive_cb_reply: Got unrecognized reply: calldir
> >> 0x1 xpt_bc_xprt 00000000bc03be29 xid eed92785
> >> [Tue Jul 16 11:35:58 2024] receive_cb_reply: Got unrecognized reply: calldir
> >> 0x1 xpt_bc_xprt 0000000056d1aff1 xid a1d6584a
> >> [Tue Jul 16 11:35:58 2024] receive_cb_reply: Got unrecognized reply: calldir
> >> 0x1 xpt_bc_xprt 0000000008075849 xid 776fd865
> >> [Tue Jul 16 11:35:58 2024] receive_cb_reply: Got unrecognized reply: calldir
> >> 0x1 xpt_bc_xprt 00000000aeeb49cf xid edf22d96
> >> [Tue Jul 16 11:35:58 2024] receive_cb_reply: Got unrecognized reply: calldir
> >> 0x1 xpt_bc_xprt 000000009327f72c xid 12b9ab32
> >> [Tue Jul 16 11:35:58 2024] receive_cb_reply: Got unrecognized reply: calldir
> >> 0x1 xpt_bc_xprt 00000000b55d160f xid 0e3dd152
> >> [Tue Jul 16 11:35:58 2024] receive_cb_reply: Got unrecognized reply: calldir
> >> 0x1 xpt_bc_xprt 00000000976cd55a xid a7cb0a18
> >> [Tue Jul 16 11:35:58 2024] receive_cb_reply: Got unrecognized reply: calldir
> >> 0x1 xpt_bc_xprt 0000000042906e77 xid da415db0
> >> [Tue Jul 16 11:35:58 2024] receive_cb_reply: Got unrecognized reply: calldir
> >> 0x1 xpt_bc_xprt 00000000bc03be29 xid efd92785
> >> [Tue Jul 16 11:35:58 2024] receive_cb_reply: Got unrecognized reply: calldir
> >> 0x1 xpt_bc_xprt 0000000008075849 xid 786fd865
> >> [Tue Jul 16 11:35:58 2024] receive_cb_reply: Got unrecognized reply: calldir
> >> 0x1 xpt_bc_xprt 00000000aeeb49cf xid eef22d96
> >> [Tue Jul 16 11:35:58 2024] receive_cb_reply: Got unrecognized reply: calldir
> >> 0x1 xpt_bc_xprt 00000000ee580afa xid 9f91a3d2
> >> [Tue Jul 16 11:35:58 2024] receive_cb_reply: Got unrecognized reply: calldir
> >> 0x1 xpt_bc_xprt 0000000060d5bb55 xid 3aea57c8
> >> [Tue Jul 16 11:35:58 2024] receive_cb_reply: Got unrecognized reply: calldir
> >> 0x1 xpt_bc_xprt 00000000d4d84570 xid 73a5017a
> >> [Tue Jul 16 11:35:58 2024] receive_cb_reply: Got unrecognized reply: calldir
> >> 0x1 xpt_bc_xprt 00000000155c8644 xid 5d0a9b1f
> >> [Tue Jul 16 11:35:59 2024] receive_cb_reply: Got unrecognized reply: calldir
> >> 0x1 xpt_bc_xprt 0000000028481e8f xid b682b676
> >> [Tue Jul 16 11:35:59 2024] receive_cb_reply: Got unrecognized reply: calldir
> >> 0x1 xpt_bc_xprt 00000000c384ff38 xid b5d5dbf5
> >> [Tue Jul 16 11:36:40 2024] rcu: INFO: rcu_sched self-detected stall on CPU
> >> [Tue Jul 16 11:36:40 2024] rcu:  13-....: (20997 ticks this GP)
> >> idle=54f/1/0x4000000000000000 softirq=31904928/31904928 fqs=4433
> >> [Tue Jul 16 11:36:40 2024]  (t=21017 jiffies g=194958993 q=5715)
> >> [Tue Jul 16 11:36:40 2024] Task dump for CPU 13:
> >> [Tue Jul 16 11:36:40 2024] task:kworker/u34:2   state:R  running task
> >> stack:    0 pid:30413 ppid:     2 flags:0x00004008
> >> [Tue Jul 16 11:36:40 2024] Workqueue: rpciod rpc_async_schedule [sunrpc]
> >> [Tue Jul 16 11:36:40 2024] Call Trace:
> >> [Tue Jul 16 11:36:40 2024]  <IRQ>
> >> [Tue Jul 16 11:36:40 2024]  sched_show_task.cold+0xc2/0xda
> >> [Tue Jul 16 11:36:40 2024]  rcu_dump_cpu_stacks+0xa1/0xd3
> >> [Tue Jul 16 11:36:40 2024]  rcu_sched_clock_irq.cold+0xc7/0x1e7
> >> [Tue Jul 16 11:36:40 2024]  ? trigger_load_balance+0x6d/0x300
> >> [Tue Jul 16 11:36:40 2024]  ? scheduler_tick+0xda/0x260
> >> [Tue Jul 16 11:36:40 2024]  update_process_times+0xa1/0xe0
> >> [Tue Jul 16 11:36:40 2024]  tick_sched_timer+0x8e/0xa0
> >> [Tue Jul 16 11:36:40 2024]  ? tick_sched_do_timer+0x90/0x90
> >> [Tue Jul 16 11:36:40 2024]  __hrtimer_run_queues+0x139/0x2a0
> >> [Tue Jul 16 11:36:40 2024]  hrtimer_interrupt+0xf4/0x210
> >> [Tue Jul 16 11:36:40 2024]  __sysvec_apic_timer_interrupt+0x5f/0xe0
> >> [Tue Jul 16 11:36:40 2024]  sysvec_apic_timer_interrupt+0x69/0x90
> >> [Tue Jul 16 11:36:40 2024]  </IRQ>
> >> [Tue Jul 16 11:36:40 2024]  <TASK>
> >> [Tue Jul 16 11:36:40 2024]  asm_sysvec_apic_timer_interrupt+0x16/0x20
> >> [Tue Jul 16 11:36:40 2024] RIP: 0010:read_tsc+0x3/0x20
> >> [Tue Jul 16 11:36:40 2024] Code: cc cc cc cc cc cc cc 8b 05 56 ab 72 01 c3
> >> cc cc cc cc 0f 1f 44 00 00 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00
> >> 0f 01 f9 <66> 90 48 c1 e2 20 48 09 d0 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00
> >> [Tue Jul 16 11:36:40 2024] RSP: 0018:ffffc900087cfe00 EFLAGS: 00000246
> >> [Tue Jul 16 11:36:40 2024] RAX: 00000000226dc8b8 RBX: 000000003f3c079e RCX:
> >> 000000000000100d
> >> [Tue Jul 16 11:36:40 2024] RDX: 00000000004535c4 RSI: 0000000000000046 RDI:
> >> ffffffff82435600
> >> [Tue Jul 16 11:36:40 2024] RBP: 0003ed08d3641da3 R08: ffffffffa012c770 R09:
> >> ffffffffa012c788
> >> [Tue Jul 16 11:36:40 2024] R10: 0000000000000003 R11: 0000000000000283 R12:
> >> 0000000000000000
> >> [Tue Jul 16 11:36:40 2024] R13: 0000000000000001 R14: ffff88909311c000 R15:
> >> ffff88909311c005
> >> [Tue Jul 16 11:36:40 2024]  ktime_get+0x38/0xa0
> >> [Tue Jul 16 11:36:40 2024]  ? rpc_sleep_on_priority+0x70/0x70 [sunrpc]
> >> [Tue Jul 16 11:36:40 2024]  rpc_exit_task+0x9a/0x100 [sunrpc]
> >> [Tue Jul 16 11:36:40 2024]  __rpc_execute+0x6e/0x410 [sunrpc]
> >> [Tue Jul 16 11:36:40 2024]  rpc_async_schedule+0x29/0x40 [sunrpc]
> >> [Tue Jul 16 11:36:40 2024]  process_one_work+0x1d7/0x3a0
> >> [Tue Jul 16 11:36:40 2024]  worker_thread+0x4a/0x3c0
> >> [Tue Jul 16 11:36:40 2024]  ? process_one_work+0x3a0/0x3a0
> >> [Tue Jul 16 11:36:40 2024]  kthread+0x115/0x140
> >> [Tue Jul 16 11:36:40 2024]  ? set_kthread_struct+0x50/0x50
> >> [Tue Jul 16 11:36:40 2024]  ret_from_fork+0x1f/0x30
> >> [Tue Jul 16 11:36:40 2024]  </TASK>
> >> [Tue Jul 16 11:37:19 2024] rcu: INFO: rcu_sched self-detected stall on CPU
> >> [Tue Jul 16 11:37:19 2024] rcu:  7-....: (21000 ticks this GP)
> >> idle=5b1/1/0x4000000000000000 softirq=29984492/29984492 fqs=5159
> >> [Tue Jul 16 11:37:19 2024]  (t=21017 jiffies g=194959001 q=2008)
> >> [Tue Jul 16 11:37:19 2024] Task dump for CPU 7:
> >> [Tue Jul 16 11:37:19 2024] task:kworker/u34:2   state:R  running task
> >> stack:    0 pid:30413 ppid:     2 flags:0x00004008
> >> [Tue Jul 16 11:37:19 2024] Workqueue: rpciod rpc_async_schedule [sunrpc]
> >> [Tue Jul 16 11:37:19 2024] Call Trace:
> >> [Tue Jul 16 11:37:19 2024]  <IRQ>
> >> [Tue Jul 16 11:37:19 2024]  sched_show_task.cold+0xc2/0xda
> >> [Tue Jul 16 11:37:19 2024]  rcu_dump_cpu_stacks+0xa1/0xd3
> >> [Tue Jul 16 11:37:19 2024]  rcu_sched_clock_irq.cold+0xc7/0x1e7
> >> [Tue Jul 16 11:37:19 2024]  ? trigger_load_balance+0x6d/0x300
> >> [Tue Jul 16 11:37:19 2024]  ? scheduler_tick+0xda/0x260
> >> [Tue Jul 16 11:37:19 2024]  update_process_times+0xa1/0xe0
> >> [Tue Jul 16 11:37:19 2024]  tick_sched_timer+0x8e/0xa0
> >> [Tue Jul 16 11:37:19 2024]  ? tick_sched_do_timer+0x90/0x90
> >> [Tue Jul 16 11:37:19 2024]  __hrtimer_run_queues+0x139/0x2a0
> >> [Tue Jul 16 11:37:19 2024]  hrtimer_interrupt+0xf4/0x210
> >> [Tue Jul 16 11:37:19 2024]  __sysvec_apic_timer_interrupt+0x5f/0xe0
> >> [Tue Jul 16 11:37:19 2024]  sysvec_apic_timer_interrupt+0x69/0x90
> >> [Tue Jul 16 11:37:19 2024]  </IRQ>
> >> [Tue Jul 16 11:37:19 2024]  <TASK>
> >> [Tue Jul 16 11:37:19 2024]  asm_sysvec_apic_timer_interrupt+0x16/0x20
> >> [Tue Jul 16 11:37:19 2024] RIP: 0010:_raw_spin_lock+0x10/0x20
> >> [Tue Jul 16 11:37:19 2024] Code: b8 00 02 00 00 f0 0f c1 07 a9 ff 01 00 00
> >> 75 05 c3 cc cc cc cc e9 f0 05 59 ff 0f 1f 44 00 00 31 c0 ba 01 00 00 00 f0
> >> 0f b1 17 <75> 05 c3 cc cc cc cc 89 c6 e9 62 02 59 ff 66 90 0f 1f 44 00 00 fa
> >> [Tue Jul 16 11:37:19 2024] RSP: 0018:ffffc900087cfe30 EFLAGS: 00000246
> >> [Tue Jul 16 11:37:19 2024] RAX: 0000000000000000 RBX: ffff88997131a500 RCX:
> >> 0000000000000001
> >> [Tue Jul 16 11:37:19 2024] RDX: 0000000000000001 RSI: ffff88997131a500 RDI:
> >> ffffffffa012c700
> >> [Tue Jul 16 11:37:19 2024] RBP: ffffffffa012c700 R08: ffffffffa012c770 R09:
> >> ffffffffa012c788
> >> [Tue Jul 16 11:37:19 2024] R10: 0000000000000003 R11: 0000000000000283 R12:
> >> ffff88997131a530
> >> [Tue Jul 16 11:37:19 2024] R13: 0000000000000001 R14: ffff88909311c000 R15:
> >> ffff88909311c005
> >> [Tue Jul 16 11:37:19 2024]  __rpc_execute+0x95/0x410 [sunrpc]
> >> [Tue Jul 16 11:37:19 2024]  rpc_async_schedule+0x29/0x40 [sunrpc]
> >> [Tue Jul 16 11:37:19 2024]  process_one_work+0x1d7/0x3a0
> >> [Tue Jul 16 11:37:19 2024]  worker_thread+0x4a/0x3c0
> >> [Tue Jul 16 11:37:19 2024]  ? process_one_work+0x3a0/0x3a0
> >> [Tue Jul 16 11:37:19 2024]  kthread+0x115/0x140
> >> [Tue Jul 16 11:37:19 2024]  ? set_kthread_struct+0x50/0x50
> >> [Tue Jul 16 11:37:19 2024]  ret_from_fork+0x1f/0x30
> >> [Tue Jul 16 11:37:19 2024]  </TASK>
> >> [Tue Jul 16 11:37:57 2024] rcu: INFO: rcu_sched self-detected stall on CPU
> >> […]
> >> ```
> > 
> > FWIW, on one NFS server occurence we are seeing something very close
> > to the above but in the 5.10.y case for the Debian kernel after
> > updating to 5.10.218-1 to 5.10.221-1, so kernel after which had the
> > big NFS related stack backported.
> > 
> > One backtrace we were able to catch was
> > 
> > [...]
> > Jul 27 15:24:52 nfsserver kernel: receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 000000003d26f7ec xid b172e1c6
> > Jul 27 15:24:52 nfsserver kernel: receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 0000000017f1552a xid a90d7751
> > Jul 27 15:24:52 nfsserver kernel: receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 000000006337c521 xid 8e5e58bd
> > Jul 27 15:24:54 nfsserver kernel: receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000cbf89319 xid c2da3c73
> > Jul 27 15:24:54 nfsserver kernel: receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 00000000e2588a21 xid a01bfec6
> > Jul 27 15:24:54 nfsserver kernel: receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 000000005fda63ca xid c2eeeaa6
> > [...]
> > Jul 27 15:25:15 nfsserver kernel: rcu: INFO: rcu_sched self-detected stall on CPU
> > Jul 27 15:25:15 nfsserver kernel: rcu:         15-....: (5250 ticks this GP) idle=74e/1/0x4000000000000000 softirq=3160997/3161006 fqs=2233 
> > Jul 27 15:25:15 nfsserver kernel:         (t=5255 jiffies g=8381377 q=106333)
> > Jul 27 15:25:15 nfsserver kernel: NMI backtrace for cpu 15
> > Jul 27 15:25:15 nfsserver kernel: CPU: 15 PID: 3725556 Comm: kworker/u42:4 Not tainted 5.10.0-31-amd64 #1 Debian 5.10.221-1
> > Jul 27 15:25:15 nfsserver kernel: Hardware name: DALCO AG S2600WFT/S2600WFT, BIOS SE5C620.86B.02.01.0008.031920191559 03/19/2019
> > Jul 27 15:25:15 nfsserver kernel: Workqueue: rpciod rpc_async_schedule [sunrpc]
> > Jul 27 15:25:15 nfsserver kernel: Call Trace:
> > Jul 27 15:25:15 nfsserver kernel:  <IRQ>
> > Jul 27 15:25:15 nfsserver kernel:  dump_stack+0x6b/0x83
> > Jul 27 15:25:15 nfsserver kernel:  nmi_cpu_backtrace.cold+0x32/0x69
> > Jul 27 15:25:15 nfsserver kernel:  ? lapic_can_unplug_cpu+0x80/0x80
> > Jul 27 15:25:15 nfsserver kernel:  nmi_trigger_cpumask_backtrace+0xdf/0xf0
> > Jul 27 15:25:15 nfsserver kernel:  rcu_dump_cpu_stacks+0xa5/0xd7
> > Jul 27 15:25:15 nfsserver kernel:  rcu_sched_clock_irq.cold+0x202/0x3d9
> > Jul 27 15:25:15 nfsserver kernel:  ? trigger_load_balance+0x5a/0x220
> > Jul 27 15:25:15 nfsserver kernel:  update_process_times+0x8c/0xc0
> > Jul 27 15:25:15 nfsserver kernel:  tick_sched_handle+0x22/0x60
> > Jul 27 15:25:15 nfsserver kernel:  tick_sched_timer+0x65/0x80
> > Jul 27 15:25:15 nfsserver kernel:  ? tick_sched_do_timer+0x90/0x90
> > Jul 27 15:25:15 nfsserver kernel:  __hrtimer_run_queues+0x127/0x280
> > Jul 27 15:25:15 nfsserver kernel:  hrtimer_interrupt+0x110/0x2c0
> > Jul 27 15:25:15 nfsserver kernel:  __sysvec_apic_timer_interrupt+0x5c/0xe0
> > Jul 27 15:25:15 nfsserver kernel:  asm_call_irq_on_stack+0xf/0x20
> > Jul 27 15:25:15 nfsserver kernel:  </IRQ>
> > Jul 27 15:25:15 nfsserver kernel:  sysvec_apic_timer_interrupt+0x72/0x80
> > Jul 27 15:25:15 nfsserver kernel:  asm_sysvec_apic_timer_interrupt+0x12/0x20
> > Jul 27 15:25:15 nfsserver kernel: RIP: 0010:mod_delayed_work_on+0x5d/0x90
> > Jul 27 15:25:15 nfsserver kernel: Code: 00 4c 89 e7 e8 34 fe ff ff 89 c3 83 f8 f5 74 e9 85 c0 78 1b 89 ef 4c 89 f1 4c 89 e2 4c 89 ee e8 f9 fc ff ff 48 8b 3c 24 57 9d <0f> 1f 44 >
> > Jul 27 15:25:15 nfsserver kernel: RSP: 0018:ffffb5efe356fd90 EFLAGS: 00000246
> > Jul 27 15:25:15 nfsserver kernel: RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000003820000f
> > Jul 27 15:25:15 nfsserver kernel: RDX: 0000000038000000 RSI: 0000000000000046 RDI: 0000000000000246
> > Jul 27 15:25:15 nfsserver kernel: RBP: 0000000000002000 R08: ffffffffc0884430 R09: ffffffffc0884448
> > Jul 27 15:25:15 nfsserver kernel: R10: 0000000000000003 R11: 0000000000000003 R12: ffffffffc0884428
> > Jul 27 15:25:15 nfsserver kernel: R13: ffff8c89d0f6b800 R14: 00000000000001f4 R15: 0000000000000000
> > Jul 27 15:25:15 nfsserver kernel:  __rpc_sleep_on_priority_timeout+0x111/0x120 [sunrpc]
> > Jul 27 15:25:15 nfsserver kernel:  rpc_delay+0x56/0x90 [sunrpc]
> > Jul 27 15:25:15 nfsserver kernel:  rpc_exit_task+0x5a/0x140 [sunrpc]
> > Jul 27 15:25:15 nfsserver kernel:  ? __rpc_do_wake_up_task_on_wq+0x1e0/0x1e0 [sunrpc]
> > Jul 27 15:25:15 nfsserver kernel:  __rpc_execute+0x6d/0x410 [sunrpc]
> > Jul 27 15:25:15 nfsserver kernel:  rpc_async_schedule+0x29/0x40 [sunrpc]
> > Jul 27 15:25:15 nfsserver kernel:  process_one_work+0x1b3/0x350
> > Jul 27 15:25:15 nfsserver kernel:  worker_thread+0x53/0x3e0
> > Jul 27 15:25:15 nfsserver kernel:  ? process_one_work+0x350/0x350
> > Jul 27 15:25:15 nfsserver kernel:  kthread+0x118/0x140
> > Jul 27 15:25:15 nfsserver kernel:  ? __kthread_bind_mask+0x60/0x60
> > Jul 27 15:25:15 nfsserver kernel:  ret_from_fork+0x1f/0x30
> > [...]
> > 
> > Is there anything which could help debug this issue?
> 
> The backtrace suggests an issue in the RPC client code; the
> server's NFSv4.1 backchannel would use that to send callbacks.
> 
> Since 5.10.218 and 5.10.221 are only about a thousand commits
> apart, a bisect should be quick and narrow down the issue to
> one or two commits.

Yes indeed. Unfortunately was yet unable to reproduce the issue in
more syntentic way on test environment, and the affected server in
particular is a production system.

Paul, is your case in some way reproducible in a testing environment
so that a bisection might be give enough hints on the problem?

Regards,
Salvatore

