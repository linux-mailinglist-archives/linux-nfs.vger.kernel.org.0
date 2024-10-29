Return-Path: <linux-nfs+bounces-7563-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D1D9B530A
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Oct 2024 21:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AF971F238FB
	for <lists+linux-nfs@lfdr.de>; Tue, 29 Oct 2024 20:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87CE9205E1C;
	Tue, 29 Oct 2024 20:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GpcK1hSI"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6190F202631
	for <linux-nfs@vger.kernel.org>; Tue, 29 Oct 2024 20:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730232270; cv=none; b=RUmUUa3C+GiJ9AYAPzGf20Hh49gg6xHG/QDWmFLDhnFrDNKw6IkCzLm/oCoYFC1cz37lMVDQCtBs8rkkbtLmbjQZ8exYeHocDjxEd0zgBmJMzgfcVlD4+R54+IkeTae2s4uwtFfNm2LNdF8zqTivoKM0f7qDd8ZjvOfvZvzgLWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730232270; c=relaxed/simple;
	bh=ypfWHDAVHrdUurMpFE062FkJEUrrBmWkng1u1D5UuQc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FEDeddVbh/jlYRgIiZF2b8U3CU/gZbo1GGmcfinrHHu6TayHN9ES7C4OjDP0/c9OIMk+4IDHglzhljTnBOLp2ZhRT9iEzpqVuWLeCBt5ys+1E4QPZnakoT4stSw8TnMF//pKECYi32XAK6bKufXML2PWljDQfoWvIzNnHY9Szxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GpcK1hSI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72394C4CECD;
	Tue, 29 Oct 2024 20:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730232269;
	bh=ypfWHDAVHrdUurMpFE062FkJEUrrBmWkng1u1D5UuQc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=GpcK1hSIUVLmpVFH2KKS9b2yioxlQedrgHy7CN8/DzRTZ8VN2cYsBJaMTKMkUXOuI
	 bUnVzBWhFOOZJceXO7rEbdobqLP24HxOrnE77LzRjUHhSh8uF2Rz7bAfJsCoPPQNst
	 sy8fU5rCvF7JS5VOo+K9wNMoIQIiXkDsnupLE7Qr3Of5eMxbwQori+e9UFlm0QTvKg
	 dY6EauvBfjvatHt0pDUD4iChj1RDylgCGRiWf7vMUGgC6CvraSYbh96C9g5RkZP2Te
	 vCZHKWYobxukpRQb6EgbKWm4Vkm2HXfTXV0gKCppkf6XIeqP5d/vVmVRjwHBSI9ihP
	 nNgBtNABq4f9w==
Message-ID: <853bd2973f751e681476d320f23d47332d2bf41a.camel@kernel.org>
Subject: Re: nfsd stuck in D (disk sleep) state
From: Jeff Layton <jlayton@kernel.org>
To: Tom Talpey <tom@talpey.com>, =?ISO-8859-1?Q?Beno=EEt?= Gschwind
 <benoit.gschwind@minesparis.psl.eu>, Chuck Lever III
 <chuck.lever@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date: Tue, 29 Oct 2024 16:04:28 -0400
In-Reply-To: <4cf67d2f79f3ccb1a81875adb2f98f4e04b9fd1d.camel@kernel.org>
References: 
	<1cbdfe5e604d1e39a12bc5cca098684500f6a509.camel@minesparis.psl.eu>
	 <4A9BFCA9-7A15-4CA7-B198-0A15C3A24D11@oracle.com>
	 <f7aec65eab6180cf5e97bbfd3fad2a6b633d4613.camel@minesparis.psl.eu>
	 <509abdda-9143-40da-bbf2-9bfdf8044d4c@talpey.com>
	 <3301c899e4d57f5a988373d76fdceb9ec2bee8af.camel@kernel.org>
	 <4cf67d2f79f3ccb1a81875adb2f98f4e04b9fd1d.camel@kernel.org>
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

On Tue, 2024-10-29 at 09:49 -0400, Jeff Layton wrote:
> On Mon, 2024-10-28 at 13:27 -0400, Jeff Layton wrote:
> > On Mon, 2024-10-28 at 08:46 -0400, Tom Talpey wrote:
> > > On 10/28/2024 5:18 AM, Beno=C3=AEt Gschwind wrote:
> > > > Hello,
> > > >=20
> > > > The issue trigger again, I attached the result of:
> > > >=20
> > > > # dmesg -W | tee dmesg.txt
> > > >=20
> > > > using:
> > > >=20
> > > > # echo t > /proc/sysrq-trigger
> > > >=20
> > > > I have the following PID stuck:
> > > >=20
> > > >      1474 D (disk sleep)       0:54:58.602 [nfsd]
> > > >      1475 D (disk sleep)       0:54:58.602 [nfsd]
> > > >      1484 D (disk sleep)       0:54:58.602 [nfsd]
> > > >      1495 D (disk sleep)       0:54:58.602 [nfsd]
> > >=20
> > > Hmm, 1495 is stuck in nfsd4_create_session
> > >=20
> > >  > [427468.304955] task:nfsd            state:D stack:0     pid:1495=
=20
> > > ppid:2      flags:0x00004000
> > >  > [427468.304962] Call Trace:
> > >  > [427468.304965]  <TASK>
> > >  > [427468.304971]  __schedule+0x34d/0x9e0
> > >  > [427468.304983]  schedule+0x5a/0xd0
> > >  > [427468.304991]  schedule_timeout+0x118/0x150
> > >  > [427468.305003]  wait_for_completion+0x86/0x160
> > >  > [427468.305015]  __flush_workqueue+0x152/0x420
> > >  > [427468.305031]  nfsd4_create_session+0x79f/0xba0 [nfsd]
> > >  > [427468.305092]  nfsd4_proc_compound+0x34c/0x660 [nfsd]
> > >  > [427468.305147]  nfsd_dispatch+0x1a1/0x2b0 [nfsd]
> > >  > [427468.305199]  svc_process_common+0x295/0x610 [sunrpc]
> > >  > [427468.305269]  ? svc_recv+0x491/0x810 [sunrpc]
> > >  > [427468.305337]  ? nfsd_svc+0x370/0x370 [nfsd]
> > >  > [427468.305389]  ? nfsd_shutdown_threads+0x90/0x90 [nfsd]
> > >  > [427468.305437]  svc_process+0xad/0x100 [sunrpc]
> > >  > [427468.305505]  nfsd+0x99/0x140 [nfsd]
> > >  > [427468.305555]  kthread+0xda/0x100
> > >  > [427468.305562]  ? kthread_complete_and_exit+0x20/0x20
> > >  > [427468.305572]  ret_from_fork+0x22/0x30
> > >=20
> > > and the other three are stuck in nfsd4_destroy_session
> > >=20
> >=20
> > All 4 processes are stuck waiting on a flush_workqueue call. It's
> > probably one of these:
> >=20
> >     flush_workqueue(clp->cl_callback_wq);
> >=20
> > So the question here is really -- why are the callback workqueue jobs
> > stuck? I do see this:
> >=20
> > [427468.316839] Workqueue: nfsd4_callbacks nfsd4_run_cb_work [nfsd]
> > [427468.316899] Call Trace:
> > [427468.316902]  <TASK>
> > [427468.316908]  __schedule+0x34d/0x9e0
> > [427468.316919]  schedule+0x5a/0xd0
> > [427468.316927]  schedule_timeout+0x94/0x150
> > [427468.316937]  ? __bpf_trace_tick_stop+0x10/0x10
> > [427468.316947]  rpc_shutdown_client+0xf2/0x150 [sunrpc]
> > [427468.317015]  ? cpuusage_read+0x10/0x10
> > [427468.317026]  nfsd4_process_cb_update+0x4c/0x270 [nfsd]
> > [427468.317097]  nfsd4_run_cb_work+0x9f/0x150 [nfsd]
> > [427468.317146]  process_one_work+0x1c7/0x380
> > [427468.317158]  worker_thread+0x4d/0x380
> > [427468.317170]  ? rescuer_thread+0x3a0/0x3a0
> > [427468.317177]  kthread+0xda/0x100
> > [427468.317185]  ? kthread_complete_and_exit+0x20/0x20
> > [427468.317195]  ret_from_fork+0x22/0x30
> > [427468.317213]  </TASK>
> >=20
> > Maybe the RPC client is having trouble clearing clnt->cl_tasks ?=20
> >=20
>=20
> Interestingly, I hit this today while testing the patches that widen
> the backchannel:
>=20
> [  484.550350] INFO: task nfsd:1168 blocked for more than 120 seconds.
> [  484.551746]       Not tainted 6.12.0-rc5+ #188
> [  484.552854] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disable=
s this message.
> [  484.586316] task:nfsd            state:D stack:0     pid:1168  tgid:11=
68  ppid:2      flags:0x00004000
> [  484.588417] Call Trace:
> [  484.589070]  <TASK>
> [  484.589624]  __schedule+0x4e4/0xb90
> [  484.622306]  schedule+0x26/0xf0
> [  484.623162]  schedule_timeout+0x121/0x150
> [  484.624344]  ? __smp_call_single_queue+0xa7/0x110
> [  484.625375]  ? x2apic_send_IPI+0x45/0x50
> [  484.654299]  ? ttwu_queue_wakelist+0xbf/0x110
> [  484.655454]  __wait_for_common+0x91/0x1c0
> [  484.656372]  ? __pfx_schedule_timeout+0x10/0x10
> [  484.657429]  __flush_workqueue+0x13a/0x400
> [  484.686304]  nfsd4_create_session+0x9cd/0xd90 [nfsd]
> [  484.687562]  nfsd4_proc_compound+0x396/0x750 [nfsd]
> [  484.688746]  nfsd_dispatch+0xc6/0x210 [nfsd]
> [  484.689835]  svc_process_common+0x4e6/0x6d0 [sunrpc]
> [  484.722305]  ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
> [  484.723532]  svc_process+0x12d/0x1c0 [sunrpc]
> [  484.724619]  svc_recv+0x7cf/0x980 [sunrpc]
> [  484.725618]  ? __pfx_nfsd+0x10/0x10 [nfsd]
> [  484.758308]  nfsd+0x9f/0x100 [nfsd]
> [  484.759184]  kthread+0xdd/0x110
> [  484.759905]  ? __pfx_kthread+0x10/0x10
> [  484.760870]  ret_from_fork+0x30/0x50
> [  484.761603]  ? __pfx_kthread+0x10/0x10
> [  484.790302]  ret_from_fork_asm+0x1a/0x30
> [  484.791151]  </TASK>
>=20
> The host was hung after this, so I can't fully confirm the scenario
> below, but I think it's probably correct:
>=20
> The client might want to create a new session. When that happens, the
> create_session call tries to flush_workqueue() on the client-wide
> backchannel workqueue.
>=20
> That workqueue is stuck, as it's waiting for all of the callback RPCs
> to die off (as evidenced by the stack from Beno=C3=AEt's info that shows =
it
> hung in rpc_shutdown_client). So the question I guess at this point is
> why these RPC tasks aren't dying like they're supposed to when
> rpc_killall_tasks() is run.
>=20
> I'm guessing that the backchannel-widening patches may make this a bit
> easier to reproduce? In any case, this problem doesn't seem to be
> confined to v6.1.=20
>=20
> I'm still looking at this, so stay tuned...

The root cause in my case was that I had a bug in the backchannel
widening patch, and that was causing the client to recreate the session
occasionally.

I can't reproduce it now with the v2 version of that patch, but I still
suspect that this is related to problems killing backchannel rpc tasks.
--=20
Jeff Layton <jlayton@kernel.org>

