Return-Path: <linux-nfs+bounces-7538-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46E229B379C
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Oct 2024 18:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 072F0282405
	for <lists+linux-nfs@lfdr.de>; Mon, 28 Oct 2024 17:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECF41DF254;
	Mon, 28 Oct 2024 17:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j1b3QSbc"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C101DF24B
	for <linux-nfs@vger.kernel.org>; Mon, 28 Oct 2024 17:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730136433; cv=none; b=MyxzsXx3A0YCWfrtIp5puZCMKuUg5CMVNMoksyMpF1jP0M+piFWHmHXEVoDRwLSouLiqfYZlUAjM4xHtnM/DQMrRlehP7GP/YNBrpDHZz9c5OzI4qFxmWUdx7deQFEsRlEHtpCTFQhQSHdlSnPS7Ow6+CVWrVlzWduvK5aluArI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730136433; c=relaxed/simple;
	bh=403o8Qb7BZKXK+sxqPRoP/UmCIhm4NavYhQSPxD2fX0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JN+Cmch4RxaAdWkMiw6Xf8mp+Rlc4d/VoUouodnNH9ryX4HDpRFumBRX04uaVEoI/eq3v0uS4SsJLwdOmF0Cjahaf35G544gktZ+AUwhZ1KVF13HHj7NixaNKakMxPrWxE5XyPK/B9bBAymKhTagbPRk/i/JmpAWioDS+dSRgLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j1b3QSbc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AB35C4CEE4;
	Mon, 28 Oct 2024 17:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730136433;
	bh=403o8Qb7BZKXK+sxqPRoP/UmCIhm4NavYhQSPxD2fX0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=j1b3QSbcGoICHjSI8atHYmG1LnDtrq/mCsH/0SETMi5XXKT9LVPMzSjtSasiEqAQX
	 vQR7V1mLemdiJClrcq79IKhPmcmGR3UkqZtxlMdxwVYY3WQfook+zMgYHl1i6A6y6J
	 sxXkN01Av05Ez7n3uaY+hv73mKmyIz0GZe7Z/hjlc/gPCVaOPAVuVLXrsbwAI3xrEA
	 HdZCiWgWrpl5qiu0HF4Wn8kPWsIJOa69lFoCE70n4fVl30ForPgH6yOEGUQ6pgAEpG
	 N7SFoJGQrTqaqsGEPFZtDSww2iBLyugzZX2mUiqyTfq4xG9bcuOxwrok3SLNnjEe4y
	 sLY9WzhJloB2w==
Message-ID: <3301c899e4d57f5a988373d76fdceb9ec2bee8af.camel@kernel.org>
Subject: Re: nfsd stuck in D (disk sleep) state
From: Jeff Layton <jlayton@kernel.org>
To: Tom Talpey <tom@talpey.com>, =?ISO-8859-1?Q?Beno=EEt?= Gschwind
 <benoit.gschwind@minesparis.psl.eu>, Chuck Lever III
 <chuck.lever@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date: Mon, 28 Oct 2024 13:27:11 -0400
In-Reply-To: <509abdda-9143-40da-bbf2-9bfdf8044d4c@talpey.com>
References: 
	<1cbdfe5e604d1e39a12bc5cca098684500f6a509.camel@minesparis.psl.eu>
	 <4A9BFCA9-7A15-4CA7-B198-0A15C3A24D11@oracle.com>
	 <f7aec65eab6180cf5e97bbfd3fad2a6b633d4613.camel@minesparis.psl.eu>
	 <509abdda-9143-40da-bbf2-9bfdf8044d4c@talpey.com>
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

On Mon, 2024-10-28 at 08:46 -0400, Tom Talpey wrote:
> On 10/28/2024 5:18 AM, Beno=C3=AEt Gschwind wrote:
> > Hello,
> >=20
> > The issue trigger again, I attached the result of:
> >=20
> > # dmesg -W | tee dmesg.txt
> >=20
> > using:
> >=20
> > # echo t > /proc/sysrq-trigger
> >=20
> > I have the following PID stuck:
> >=20
> >      1474 D (disk sleep)       0:54:58.602 [nfsd]
> >      1475 D (disk sleep)       0:54:58.602 [nfsd]
> >      1484 D (disk sleep)       0:54:58.602 [nfsd]
> >      1495 D (disk sleep)       0:54:58.602 [nfsd]
>=20
> Hmm, 1495 is stuck in nfsd4_create_session
>=20
>  > [427468.304955] task:nfsd            state:D stack:0     pid:1495=20
> ppid:2      flags:0x00004000
>  > [427468.304962] Call Trace:
>  > [427468.304965]  <TASK>
>  > [427468.304971]  __schedule+0x34d/0x9e0
>  > [427468.304983]  schedule+0x5a/0xd0
>  > [427468.304991]  schedule_timeout+0x118/0x150
>  > [427468.305003]  wait_for_completion+0x86/0x160
>  > [427468.305015]  __flush_workqueue+0x152/0x420
>  > [427468.305031]  nfsd4_create_session+0x79f/0xba0 [nfsd]
>  > [427468.305092]  nfsd4_proc_compound+0x34c/0x660 [nfsd]
>  > [427468.305147]  nfsd_dispatch+0x1a1/0x2b0 [nfsd]
>  > [427468.305199]  svc_process_common+0x295/0x610 [sunrpc]
>  > [427468.305269]  ? svc_recv+0x491/0x810 [sunrpc]
>  > [427468.305337]  ? nfsd_svc+0x370/0x370 [nfsd]
>  > [427468.305389]  ? nfsd_shutdown_threads+0x90/0x90 [nfsd]
>  > [427468.305437]  svc_process+0xad/0x100 [sunrpc]
>  > [427468.305505]  nfsd+0x99/0x140 [nfsd]
>  > [427468.305555]  kthread+0xda/0x100
>  > [427468.305562]  ? kthread_complete_and_exit+0x20/0x20
>  > [427468.305572]  ret_from_fork+0x22/0x30
>=20
> and the other three are stuck in nfsd4_destroy_session
>=20

All 4 processes are stuck waiting on a flush_workqueue call. It's
probably one of these:

    flush_workqueue(clp->cl_callback_wq);

So the question here is really -- why are the callback workqueue jobs
stuck? I do see this:

[427468.316839] Workqueue: nfsd4_callbacks nfsd4_run_cb_work [nfsd]
[427468.316899] Call Trace:
[427468.316902]  <TASK>
[427468.316908]  __schedule+0x34d/0x9e0
[427468.316919]  schedule+0x5a/0xd0
[427468.316927]  schedule_timeout+0x94/0x150
[427468.316937]  ? __bpf_trace_tick_stop+0x10/0x10
[427468.316947]  rpc_shutdown_client+0xf2/0x150 [sunrpc]
[427468.317015]  ? cpuusage_read+0x10/0x10
[427468.317026]  nfsd4_process_cb_update+0x4c/0x270 [nfsd]
[427468.317097]  nfsd4_run_cb_work+0x9f/0x150 [nfsd]
[427468.317146]  process_one_work+0x1c7/0x380
[427468.317158]  worker_thread+0x4d/0x380
[427468.317170]  ? rescuer_thread+0x3a0/0x3a0
[427468.317177]  kthread+0xda/0x100
[427468.317185]  ? kthread_complete_and_exit+0x20/0x20
[427468.317195]  ret_from_fork+0x22/0x30
[427468.317213]  </TASK>

Maybe the RPC client is having trouble clearing clnt->cl_tasks ?=20

>  > [427468.298315] task:nfsd            state:D stack:0     pid:1474=20
> ppid:2      flags:0x00004000
>  > [427468.298322] Call Trace:
>  > [427468.298326]  <TASK>
>  > [427468.298332]  __schedule+0x34d/0x9e0
>  > [427468.298343]  schedule+0x5a/0xd0
>  > [427468.298350]  schedule_timeout+0x118/0x150
>  > [427468.298362]  wait_for_completion+0x86/0x160
>  > [427468.298375]  __flush_workqueue+0x152/0x420
>  > [427468.298392]  nfsd4_destroy_session+0x1b6/0x250 [nfsd]
>  > [427468.298456]  nfsd4_proc_compound+0x34c/0x660 [nfsd]
>  > [427468.298515]  nfsd_dispatch+0x1a1/0x2b0 [nfsd]
>  > [427468.298568]  svc_process_common+0x295/0x610 [sunrpc]
>  > [427468.298643]  ? svc_recv+0x491/0x810 [sunrpc]
>  > [427468.298711]  ? nfsd_svc+0x370/0x370 [nfsd]
>  > [427468.298776]  ? nfsd_shutdown_threads+0x90/0x90 [nfsd]
>  > [427468.298825]  svc_process+0xad/0x100 [sunrpc]
>  > [427468.298896]  nfsd+0x99/0x140 [nfsd]
>  > [427468.298946]  kthread+0xda/0x100
>  > [427468.298954]  ? kthread_complete_and_exit+0x20/0x20
>  > [427468.298963]  ret_from_fork+0x22/0x30
>=20
> There aren't a lot of 6.1-era changes in either of these, but there
> are some interesting behavior updates around session create replay
> from early this year. I wonder if the 6.1 server is mishandling an
> nfserr_jukebox situation in nfsd4_session_create.
>=20
> Was the client actually attempting to mount or unmount?
>=20
> Tom.
>=20
> >=20
> > Thank by advance,
> > Best regards
> >=20
> > Le mercredi 23 octobre 2024 =C3=A0 19:38 +0000, Chuck Lever III a =C3=
=A9crit=C2=A0:
> > >=20
> > >=20
> > > > On Oct 23, 2024, at 3:27=E2=80=AFPM, Beno=C3=AEt Gschwind
> > > > <benoit.gschwind@minesparis.psl.eu> wrote:
> > > >=20
> > > > Hello,
> > > >=20
> > > > I have a nfs server using debian 11 (Linux hostname 6.1.0-25-amd64
> > > > #1
> > > > SMP PREEMPT_DYNAMIC Debian 6.1.106-3 (2024-08-26) x86_64 GNU/Linux)
> > > >=20
> > > > In some heavy workload some nfsd goes in D state and seems to never
> > > > leave this state. I did a python script to monitor how long a
> > > > process
> > > > stay in particular state and I use it to monitor nfsd state. I get
> > > > the
> > > > following result :
> > > >=20
> > > > [...]
> > > > 178056 I (idle) 0:25:24.475 [nfsd]
> > > > 178057 I (idle) 0:25:24.475 [nfsd]
> > > > 178058 I (idle) 0:25:24.475 [nfsd]
> > > > 178059 I (idle) 0:25:24.475 [nfsd]
> > > > 178060 I (idle) 0:25:24.475 [nfsd]
> > > > 178061 I (idle) 0:25:24.475 [nfsd]
> > > > 178062 I (idle) 0:24:15.638 [nfsd]
> > > > 178063 I (idle) 0:24:13.488 [nfsd]
> > > > 178064 I (idle) 0:24:13.488 [nfsd]
> > > > 178065 I (idle) 0:00:00.000 [nfsd]
> > > > 178066 I (idle) 0:00:00.000 [nfsd]
> > > > 178067 I (idle) 0:00:00.000 [nfsd]
> > > > 178068 I (idle) 0:00:00.000 [nfsd]
> > > > 178069 S (sleeping) 0:00:02.147 [nfsd]
> > > > 178070 S (sleeping) 0:00:02.147 [nfsd]
> > > > 178071 S (sleeping) 0:00:02.147 [nfsd]
> > > > 178072 S (sleeping) 0:00:02.147 [nfsd]
> > > > 178073 S (sleeping) 0:00:02.147 [nfsd]
> > > > 178074 D (disk sleep) 1:29:25.809 [nfsd]
> > > > 178075 S (sleeping) 0:00:02.147 [nfsd]
> > > > 178076 S (sleeping) 0:00:02.147 [nfsd]
> > > > 178077 S (sleeping) 0:00:02.147 [nfsd]
> > > > 178078 S (sleeping) 0:00:02.147 [nfsd]
> > > > 178079 S (sleeping) 0:00:02.147 [nfsd]
> > > > 178080 D (disk sleep) 1:29:25.809 [nfsd]
> > > > 178081 D (disk sleep) 1:29:25.809 [nfsd]
> > > > 178082 D (disk sleep) 0:28:04.444 [nfsd]
> > > >=20
> > > > All process not shown are in idle state. Columns are the following:
> > > > PID, state, state name, amoung of time the state did not changed
> > > > and
> > > > the process was not interrupted, and /proc/PID/status Name entry.
> > > >=20
> > > > As you can read some nfsd process are in disk sleep state since
> > > > more
> > > > than 1 hour, but looking at the disk activity, there is almost no
> > > > I/O.
> > > >=20
> > > > I tried to restart nfs-server but I get the following error from
> > > > the
> > > > kernel:
> > > >=20
> > > > oct. 23 11:59:49 hostname kernel: rpc-srv/tcp: nfsd: got error -104
> > > > when sending 20 bytes - shutting down socket
> > > > oct. 23 11:59:49 hostname kernel: rpc-srv/tcp: nfsd: got error -104
> > > > when sending 20 bytes - shutting down socket
> > > > oct. 23 11:59:49 hostname kernel: rpc-srv/tcp: nfsd: got error -104
> > > > when sending 20 bytes - shutting down socket
> > > > oct. 23 11:59:49 hostname kernel: rpc-srv/tcp: nfsd: got error -104
> > > > when sending 20 bytes - shutting down socket
> > > > oct. 23 11:59:49 hostname kernel: rpc-srv/tcp: nfsd: got error -104
> > > > when sending 20 bytes - shutting down socket
> > > > oct. 23 11:59:59 hostname kernel: rpc-srv/tcp: nfsd: got error -104
> > > > when sending 20 bytes - shutting down socket
> > > > oct. 23 11:59:59 hostname kernel: rpc-srv/tcp: nfsd: got error -104
> > > > when sending 20 bytes - shutting down socket
> > > > oct. 23 11:59:59 hostname kernel: rpc-srv/tcp: nfsd: got error -104
> > > > when sending 20 bytes - shutting down socket
> > > > oct. 23 11:59:59 hostname kernel: rpc-srv/tcp: nfsd: got error -104
> > > > when sending 20 bytes - shutting down socket
> > > > oct. 23 11:59:59 hostname kernel: rpc-srv/tcp: nfsd: got error -104
> > > > when sending 20 bytes - shutting down socket
> > > > oct. 23 12:00:09 hostname kernel: rpc-srv/tcp: nfsd: got error -104
> > > > when sending 20 bytes - shutting down socket
> > > > oct. 23 12:00:09 hostname kernel: rpc-srv/tcp: nfsd: got error -104
> > > > when sending 20 bytes - shutting down socket
> > > > oct. 23 12:00:09 hostname kernel: rpc-srv/tcp: nfsd: got error -104
> > > > when sending 20 bytes - shutting down socket
> > > > oct. 23 12:00:10 hostname kernel: rpc-srv/tcp: nfsd: got error -32
> > > > when sending 20 bytes - shutting down socket
> > > > oct. 23 12:00:10 hostname kernel: rpc-srv/tcp: nfsd: got error -32
> > > > when sending 20 bytes - shutting down socket
> > > >=20
> > > > The only way to recover seems to reboot the kernel. I guess because
> > > > the
> > > > kernel force the reboot after a given timeout.
> > > >=20
> > > > My setup involve in order :
> > > > - scsi driver
> > > > - mdraid on top of scsi (raid6)
> > > > - btrfs ontop of mdraid
> > > > - nfsd ontop of btrfs
> > > >=20
> > > >=20
> > > > The setup is not very fast as expected, but it seems that in some
> > > > situation nfsd never leave the disk sleep state. the exports
> > > > options
> > > > are: gss/krb5i(rw,sync,no_wdelay,no_subtree_check,fsid=3DXXXXX). Th=
e
> > > > situation is not commun but it's always happen at some point. For
> > > > instance in the case I report here, my server booted the 2024-10-01
> > > > and
> > > > was stuck about the 2024-10-23. I did reduced by a large amount the
> > > > frequency of issue by using no_wdelay (I did thought that I did
> > > > solved
> > > > the issue when I started to use this option).
> > > >=20
> > > > My guess is hadware bug, scsi bug, btrfs bug or nfsd bug ?
> > > >=20
> > > > Any clue on this topic or any advice is wellcome.
> > >=20
> > > Generate stack traces for each process on the system
> > > using "sudo echo t > /proc/sysrq-trigger" and then
> > > examine the output in the system journal. Note the
> > > stack contents for the processes that look stuck.
> > >=20
> > > --
> > > Chuck Lever
> > >=20
> > >=20
> >=20
>=20
>=20

--=20
Jeff Layton <jlayton@kernel.org>

