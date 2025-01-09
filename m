Return-Path: <linux-nfs+bounces-9012-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 229A4A075F1
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jan 2025 13:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC85F18897A3
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jan 2025 12:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDF8217F23;
	Thu,  9 Jan 2025 12:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pJJ0gJKo"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08592217738
	for <linux-nfs@vger.kernel.org>; Thu,  9 Jan 2025 12:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736426541; cv=none; b=iksN2pjDQemevGPeQTj3mR+90OXfgEk9Rf5Qs9fkw1FoMlQVGgXb0U1IG7TShlgBPeP8MRG+kKH59qo7iuzz9LLkzO9Trfb+QwJHdbmJWb8uNESeOPOHO5BH1cfNir4ueHmmxqkKJtzxz5MK9J1ERnxy7ZeY+XUu/iPxcCmFrlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736426541; c=relaxed/simple;
	bh=nmbqlmUvy74H9NXuWnDgUUvWDPp7chWmd0RBoi2eblI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qxESVMpm8ybJbCnuuPTeDnfuWH1HfftNXS9sdeQIOZiuPx+FcFa909tcYv0GWBLBw2vKVPsdVOH5Z3VlQ+lmMsOUeSAz/NDdWWq33Eqonaj9s/KhiwArfwQ7TjlGRNzgg4wtOKHk4MO1wSEAoD8EsCyY8zOzuVJ9YeQsn5u1GNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pJJ0gJKo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA0FC4CED6;
	Thu,  9 Jan 2025 12:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736426538;
	bh=nmbqlmUvy74H9NXuWnDgUUvWDPp7chWmd0RBoi2eblI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=pJJ0gJKo/glw2vNfO4yFVJBafFxKSsBcgZKvtqTAEZX+BVa911r72NZGs6ES++W0Q
	 jbDXYNFjJDD/9DUh/f5IFHn9nKCVRVJ584Zm078OS78gwY33P7HD6u8iY5JlgZfsRy
	 OouyoWBXgxJk8QzGP2tVVkEZh+MmTLhfbbhVy122BKkhTQtLel7nB7pXH6JVV4Sfy4
	 aNEkpIWNDNLLxPX0n3UGh90ZTP8FcUaUBGkWyhpNEHagGHdxRjTDIshqA75nwE3WLS
	 Aj8cHnLtBV5EGnvnT0F3c/+DRfIKgHkDgAt/yyjT1unNvkSigADVV0pa4Uow4iC8x4
	 zwPSMjebBdv+Q==
Message-ID: <36f4892e1332e2322ab46e1343316eb187d78025.camel@kernel.org>
Subject: Re: nfsd blocks indefinitely in nfsd4_destroy_session
From: Jeff Layton <jlayton@kernel.org>
To: Christian Herzog <herzog@phys.ethz.ch>, Chuck Lever
 <chuck.lever@oracle.com>
Cc: Salvatore Bonaccorso <carnil@debian.org>, Benjamin Coddington	
 <bcodding@redhat.com>, Trond Myklebust <trond.myklebust@hammerspace.com>, 
 Harald Dunkel <harald.dunkel@aixigo.com>, Linux NFS Mailing List
 <linux-nfs@vger.kernel.org>, Martin Svec	 <martin.svec@zoner.cz>, Michael
 Gernoth <debian@zerfleddert.de>, Pellegrin Baptiste
 <Baptiste.Pellegrin@ac-grenoble.fr>
Date: Thu, 09 Jan 2025 07:42:16 -0500
In-Reply-To: <Z3-5fOEXTSZvmM8F@phys.ethz.ch>
References: <4c3080af-eec7-4af5-8b0d-c35ac98ec074@aixigo.com>
	 <C1CE3A96-599C-4D73-BCC0-3587EC68FCB0@oracle.com>
	 <Z2vNQ6HXfG_LqBQc@eldamar.lan>
	 <ecdae86c-2954-4aca-bf1c-f95408ad0ad4@oracle.com>
	 <Z32ZzQiKfEeVoyfU@eldamar.lan>
	 <3cdcf2ee-46b3-463d-bc14-0f44062c0bd0@oracle.com>
	 <Z36RshcsxU1xFj_X@phys.ethz.ch>
	 <7fb711b1-c557-48de-bf91-d522bdbcc575@oracle.com>
	 <Z3-5fOEXTSZvmM8F@phys.ethz.ch>
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

On Thu, 2025-01-09 at 12:56 +0100, Christian Herzog wrote:
> Dear Chuck,
>=20
> On Wed, Jan 08, 2025 at 10:07:49AM -0500, Chuck Lever wrote:
> > On 1/8/25 9:54 AM, Christian Herzog wrote:
> > > Dear Chuck,
> > >=20
> > > On Wed, Jan 08, 2025 at 08:33:23AM -0500, Chuck Lever wrote:
> > > > On 1/7/25 4:17 PM, Salvatore Bonaccorso wrote:
> > > > > Hi Chuck,
> > > > >=20
> > > > > Thanks for your time on this, much appreciated.
> > > > >=20
> > > > > On Wed, Jan 01, 2025 at 02:24:50PM -0500, Chuck Lever wrote:
> > > > > > On 12/25/24 4:15 AM, Salvatore Bonaccorso wrote:
> > > > > > > Hi Chuck, hi all,
> > > > > > >=20
> > > > > > > [it was not ideal to pick one of the message for this followu=
p, let me
> > > > > > > know if you want a complete new thread, adding as well Benjam=
in and
> > > > > > > Trond as they are involved in one mentioned patch]
> > > > > > >=20
> > > > > > > On Mon, Jun 17, 2024 at 02:31:54PM +0000, Chuck Lever III wro=
te:
> > > > > > > >=20
> > > > > > > >=20
> > > > > > > > > On Jun 17, 2024, at 2:55=E2=80=AFAM, Harald Dunkel <haral=
d.dunkel@aixigo.com> wrote:
> > > > > > > > >=20
> > > > > > > > > Hi folks,
> > > > > > > > >=20
> > > > > > > > > what would be the reason for nfsd getting stuck somehow a=
nd becoming
> > > > > > > > > an unkillable process? See
> > > > > > > > >=20
> > > > > > > > > - https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D107=
1562
> > > > > > > > > - https://bugs.launchpad.net/ubuntu/+source/nfs-utils/+bu=
g/2062568
> > > > > > > > >=20
> > > > > > > > > Doesn't this mean that something inside the kernel gets s=
tuck as
> > > > > > > > > well? Seems odd to me.
> > > > > > > >=20
> > > > > > > > I'm not familiar with the Debian or Ubuntu kernel packages.=
 Can
> > > > > > > > the kernel release numbers be translated to LTS kernel rele=
ases
> > > > > > > > please? Need both "last known working" and "first broken" r=
eleases.
> > > > > > > >=20
> > > > > > > > This:
> > > > > > > >=20
> > > > > > > > [ 6596.911785] RPC: Could not send backchannel reply error:=
 -110
> > > > > > > > [ 6596.972490] RPC: Could not send backchannel reply error:=
 -110
> > > > > > > > [ 6837.281307] RPC: Could not send backchannel reply error:=
 -110
> > > > > > > >=20
> > > > > > > > is a known set of client backchannel bugs. Knowing the LTS =
kernel
> > > > > > > > releases (see above) will help us figure out what needs to =
be
> > > > > > > > backported to the LTS kernels kernels in question.
> > > > > > > >=20
> > > > > > > > This:
> > > > > > > >=20
> > > > > > > > [11183.290619] wait_for_completion+0x88/0x150
> > > > > > > > [11183.290623] __flush_workqueue+0x140/0x3e0
> > > > > > > > [11183.290629] nfsd4_probe_callback_sync+0x1a/0x30 [nfsd]
> > > > > > > > [11183.290689] nfsd4_destroy_session+0x186/0x260 [nfsd]
> > > > > > > >=20
> > > > > > > > is probably related to the backchannel errors on the client=
, but
> > > > > > > > client bugs shouldn't cause the server to hang like this. W=
e
> > > > > > > > might be able to say more if you can provide the kernel rel=
ease
> > > > > > > > translations (see above).
> > > > > > >=20
> > > > > > > In Debian we hstill have the bug #1071562 open and one person=
 notified
> > > > > > > mye offlist that it appears that the issue get more frequent =
since
> > > > > > > they updated on NFS client side from Ubuntu 20.04 to Debian b=
ookworm
> > > > > > > with a 6.1.y based kernel).
> > > > > > >=20
> > > > > > > Some people around those issues, seem to claim that the chang=
e
> > > > > > > mentioned in
> > > > > > > https://lists.proxmox.com/pipermail/pve-devel/2024-July/06461=
4.html
> > > > > > > would fix the issue, which is as well backchannel related.
> > > > > > >=20
> > > > > > > This is upstream: 6ddc9deacc13 ("SUNRPC: Fix backchannel repl=
y,
> > > > > > > again"). While this commit fixes 57331a59ac0d ("NFSv4.1: Use =
the
> > > > > > > nfs_client's rpc timeouts for backchannel") this is not somet=
hing
> > > > > > > which goes back to 6.1.y, could it be possible that hte backc=
hannel
> > > > > > > refactoring and this final fix indeeds fixes the issue?
> > > > > > >=20
> > > > > > > As people report it is not easily reproducible, so this makes=
 it
> > > > > > > harder to identify fixes correctly.
> > > > > > >=20
> > > > > > > I gave a (short) stance on trying to backport commits up to
> > > > > > > 6ddc9deacc13 ("SUNRPC: Fix backchannel reply, again") but thi=
s quickly
> > > > > > > seems to indicate it is probably still not the right thing fo=
r
> > > > > > > backporting to the older stable series.
> > > > > > >=20
> > > > > > > As at least pre-requisites:
> > > > > > >=20
> > > > > > > 2009e32997ed568a305cf9bc7bf27d22e0f6ccda
> > > > > > > 4119bd0306652776cb0b7caa3aea5b2a93aecb89
> > > > > > > 163cdfca341b76c958567ae0966bd3575c5c6192
> > > > > > > f4afc8fead386c81fda2593ad6162271d26667f8
> > > > > > > 6ed8cdf967f7e9fc96cd1c129719ef99db2f9afc
> > > > > > > 57331a59ac0d680f606403eb24edd3c35aecba31
> > > > > > >=20
> > > > > > > and still there would be conflicting codepaths (and does not =
seem
> > > > > > > right).
> > > > > > >=20
> > > > > > > Chuck, Benjamin, Trond, is there anything we can provive on r=
eporters
> > > > > > > side that we can try to tackle this issue better?
> > > > > >=20
> > > > > > As I've indicated before, NFSD should not block no matter what =
the
> > > > > > client may or may not be doing. I'd like to focus on the server=
 first.
> > > > > >=20
> > > > > > What is the result of:
> > > > > >=20
> > > > > > $ cd <Bookworm's v6.1.90 kernel source >
> > > > > > $ unset KBUILD_OUTPUT
> > > > > > $ make -j `nproc`
> > > > > > $ scripts/faddr2line \
> > > > > > 	fs/nfsd/nfs4state.o \
> > > > > > 	nfsd4_destroy_session+0x16d
> > > > > >=20
> > > > > > Since this issue appeared after v6.1.1, is it possible to bisec=
t
> > > > > > between v6.1.1 and v6.1.90 ?
> > > > >=20
> > > > > First please note, at least speaking of triggering the issue in
> > > > > Debian, Debian has moved to 6.1.119 based kernel already (and soo=
n in
> > > > > the weekends point release move to 6.1.123).
> > > > >=20
> > > > > That said, one of the users which regularly seems to be hit by th=
e
> > > > > issue was able to provide the above requested information, based =
for
> > > > > 6.1.119:
> > > > >=20
> > > > > ~/kernel/linux-source-6.1# make kernelversion
> > > > > 6.1.119
> > > > > ~/kernel/linux-source-6.1# scripts/faddr2line fs/nfsd/nfs4state.o=
 nfsd4_destroy_session+0x16d
> > > > > nfsd4_destroy_session+0x16d/0x250:
> > > > > __list_del_entry at /root/kernel/linux-source-6.1/./include/linux=
/list.h:134
> > > > > (inlined by) list_del at /root/kernel/linux-source-6.1/./include/=
linux/list.h:148
> > > > > (inlined by) unhash_session at /root/kernel/linux-source-6.1/fs/n=
fsd/nfs4state.c:2062
> > > > > (inlined by) nfsd4_destroy_session at /root/kernel/linux-source-6=
.1/fs/nfsd/nfs4state.c:3856
> > > > >=20
> > > > > They could provide as well a decode_stacktrace output for the rec=
ent
> > > > > hit (if that is helpful for you):
> > > > >=20
> > > > > [Mon Jan 6 13:25:28 2025] INFO: task nfsd:55306 blocked for more =
than 6883 seconds.
> > > > > [Mon Jan 6 13:25:28 2025]       Not tainted 6.1.0-28-amd64 #1 Deb=
ian 6.1.119-1
> > > > > [Mon Jan 6 13:25:28 2025] "echo 0 > /proc/sys/kernel/hung_task_ti=
meout_secs" disables this message.
> > > > > [Mon Jan 6 13:25:28 2025] task:nfsd            state:D stack:0   =
  pid:55306 ppid:2      flags:0x00004000
> > > > > [Mon Jan 6 13:25:28 2025] Call Trace:
> > > > > [Mon Jan 6 13:25:28 2025]  <TASK>
> > > > > [Mon Jan 6 13:25:28 2025] __schedule+0x34d/0x9e0
> > > > > [Mon Jan 6 13:25:28 2025] schedule+0x5a/0xd0
> > > > > [Mon Jan 6 13:25:28 2025] schedule_timeout+0x118/0x150
> > > > > [Mon Jan 6 13:25:28 2025] wait_for_completion+0x86/0x160
> > > > > [Mon Jan 6 13:25:28 2025] __flush_workqueue+0x152/0x420
> > > > > [Mon Jan 6 13:25:28 2025] nfsd4_destroy_session (debian/build/bui=
ld_amd64_none_amd64/include/linux/spinlock.h:351 debian/build/build_amd64_n=
one_amd64/fs/nfsd/nfs4state.c:3861) nfsd
> > > > > [Mon Jan 6 13:25:28 2025] nfsd4_proc_compound (debian/build/build=
_amd64_none_amd64/fs/nfsd/nfs4proc.c:2680) nfsd
> > > > > [Mon Jan 6 13:25:28 2025] nfsd_dispatch (debian/build/build_amd64=
_none_amd64/fs/nfsd/nfssvc.c:1022) nfsd
> > > > > [Mon Jan 6 13:25:28 2025] svc_process_common (debian/build/build_=
amd64_none_amd64/net/sunrpc/svc.c:1344) sunrpc
> > > > > [Mon Jan 6 13:25:28 2025] ? svc_recv (debian/build/build_amd64_no=
ne_amd64/net/sunrpc/svc_xprt.c:897) sunrpc
> > > > > [Mon Jan 6 13:25:28 2025] ? nfsd_svc (debian/build/build_amd64_no=
ne_amd64/fs/nfsd/nfssvc.c:983) nfsd
> > > > > [Mon Jan 6 13:25:28 2025] ? nfsd_inet6addr_event (debian/build/bu=
ild_amd64_none_amd64/fs/nfsd/nfssvc.c:922) nfsd
> > > > > [Mon Jan 6 13:25:28 2025] svc_process (debian/build/build_amd64_n=
one_amd64/net/sunrpc/svc.c:1474) sunrpc
> > > > > [Mon Jan 6 13:25:28 2025] nfsd (debian/build/build_amd64_none_amd=
64/fs/nfsd/nfssvc.c:960) nfsd
> > > > > [Mon Jan 6 13:25:28 2025] kthread+0xd7/0x100
> > > > > [Mon Jan 6 13:25:28 2025] ? kthread_complete_and_exit+0x20/0x20
> > > > > [Mon Jan 6 13:25:28 2025] ret_from_fork+0x1f/0x30
> > > > > [Mon Jan  6 13:25:28 2025]  </TASK>
> > > > >=20
> > > > > The question about bisection is actually harder, those are produc=
tion
> > > > > systems and I understand it's not possible to do bisect there, wh=
ile
> > > > > unfortunately not reprodcing the issue on "lab conditions".
> > > > >=20
> > > > > Does the above give us still a clue on what you were looking for?
> > > >=20
> > > > Thanks for the update.
> > > >=20
> > > > It's possible that 38f080f3cd19 ("NFSD: Move callback_wq into struc=
t
> > > > nfs4_client"), while not a specific fix for this issue, might offer=
 some
> > > > relief by preventing the DESTROY_SESSION hang from affecting all ot=
her
> > > > clients of the degraded server.
> > > >=20
> > > > Not having a reproducer or the ability to bisect puts a damper on
> > > > things. The next step, then, is to enable tracing on servers where =
this
> > > > issue can come up, and wait for the hang to occur. The following co=
mmand
> > > > captures information only about callback operation, so it should no=
t
> > > > generate much data or impact server performance.
> > > >=20
> > > >    # trace-cmd record -e nfsd:nfsd_cb\*
> > > >=20
> > > > Let that run until the problem occurs, then ^C, compress the result=
ing
> > > > trace.dat file, and either attach it to 1071562 or email it to me
> > > > privately.
> > > thanks for the follow-up.
> > >=20
> > > I am the "customer" with two affected file servers. We have since mov=
ed those
> > > servers to the backports kernel (6.11.10) in the hope of forward fixi=
ng the
> > > issue. If this kernel is stable, I'm afraid I can't go back to the 'b=
ad'
> > > kernel (700+ researchers affected..), and we're also not able to trig=
ger the
> > > issue on our test environment.
> >=20
> > Hello Dr. Herzog -
> >=20
> > If the problem recurs on 6.11, the trace-cmd I suggest above works
> > there as well.
> the bad news is: it just happened again with the bpo kernel.
>=20
> We then immediately started trace-cmd since usually there are several cal=
l
> traces in a row and we did get a trace.dat:
> http://people.phys.ethz.ch/~daduke/trace.dat
>=20
> we did notice however that the stack trace looked a bit different this ti=
me:
>=20
>     INFO: task nfsd:2566 blocked for more than 5799 seconds.
>     Tainted: G        W          6.11.10+bpo-amd64 #1 Debia>
>     "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables t>
>     task:nfsd            state:D stack:0     pid:2566  tgid:2566 >
>     Call Trace:
>     <TASK>
>     __schedule+0x400/0xad0
>     schedule+0x27/0xf0
>     nfsd4_shutdown_callback+0xfe/0x140 [nfsd]
>     ? __pfx_var_wake_function+0x10/0x10
>     __destroy_client+0x1f0/0x290 [nfsd]
>     nfsd4_destroy_clientid+0xf1/0x1e0 [nfsd]
>     ? svcauth_unix_set_client+0x586/0x5f0 [sunrpc]
>     nfsd4_proc_compound+0x34d/0x670 [nfsd]
>     nfsd_dispatch+0xfd/0x220 [nfsd]
>     svc_process_common+0x2f7/0x700 [sunrpc]
>     ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
>     svc_process+0x131/0x180 [sunrpc]
>     svc_recv+0x830/0xa10 [sunrpc]
>     ? __pfx_nfsd+0x10/0x10 [nfsd]
>     nfsd+0x87/0xf0 [nfsd]
>     kthread+0xcf/0x100
>     ? __pfx_kthread+0x10/0x10
>     ret_from_fork+0x31/0x50
>     ? __pfx_kthread+0x10/0x10
>     ret_from_fork_asm+0x1a/0x30
>     </TASK>
>=20
> and also the state of the offending client in `/proc/fs/nfsd/clients/*/in=
fo`
> used to be callback state: UNKNOWN while now it is DOWN or FAULT. No idea
> what it means, but I thought it was worth mentioning.
>=20

Looks like this is hung in nfsd41_cb_inflight_wait_complete() ? That
probably means that the cl_cb_inflight counter is stuck at >0. I'm
guessing that means that there is some callback that it's expecting to
complete that isn't. From nfsd4_shutdown_callback():

        /*
         * Note this won't actually result in a null callback;
         * instead, nfsd4_run_cb_null() will detect the killed
         * client, destroy the rpc client, and stop:
         */
        nfsd4_run_cb(&clp->cl_cb_null);
        flush_workqueue(clp->cl_callback_wq);
        nfsd41_cb_inflight_wait_complete(clp);

...it sounds like that isn't happening properly though.

It might be interesting to see if you can track down the callback
client in /sys/kernel/debug/sunrpc and see what it's doing.
--=20
Jeff Layton <jlayton@kernel.org>

