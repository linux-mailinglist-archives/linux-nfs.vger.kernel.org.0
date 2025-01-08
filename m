Return-Path: <linux-nfs+bounces-8970-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96497A05F8D
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 16:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4F523A4196
	for <lists+linux-nfs@lfdr.de>; Wed,  8 Jan 2025 15:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650D81FA8F7;
	Wed,  8 Jan 2025 15:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=phys.ethz.ch header.i=@phys.ethz.ch header.b="L2saBqie"
X-Original-To: linux-nfs@vger.kernel.org
Received: from phd-imap.ethz.ch (phd-imap.ethz.ch [129.132.80.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B242249EB
	for <linux-nfs@vger.kernel.org>; Wed,  8 Jan 2025 15:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.132.80.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736348616; cv=none; b=ABxXnEbUlAMZMYIcda/2y3wM6XSLYF8d0GKqQdk/93iMe32IEWV1SpgFzq2nuq/GpxPYtuUkHASYRSnOLJo6CNLtwf5Am5ltOA/2/E8s1yn4pwXaGGfXhJt7vJZpANgyZV01MlglDqtzmmXXluipGew+CIddlRXNchRjNdTJW7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736348616; c=relaxed/simple;
	bh=X0RVq23F41F5yCQx/jC7GRpnLqNlhiR4KeDIzt8cvwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IYkedyASnlkRWTKlr+G8ucheS5DAgwGNscMs5/ptzgUWDyRH2dd7UEAudTwMFws+WQ7oOEGo650DyxtZOayyM3Duedsh+ny+2+drENWKd+bVNOys2MZHxtuyd3pd2Y7LXA0OBx/bJGSQNTx/M9+Tg2ByLEW+tSK8QSweQ+UL6kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phys.ethz.ch; spf=pass smtp.mailfrom=phys.ethz.ch; dkim=pass (2048-bit key) header.d=phys.ethz.ch header.i=@phys.ethz.ch header.b=L2saBqie; arc=none smtp.client-ip=129.132.80.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=phys.ethz.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phys.ethz.ch
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phys.ethz.ch;
	s=2023; t=1736348083;
	bh=zO43WwcOjlUpoPPjyWWT4cV+U/iVs6ipsRlZ8s6n33o=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=L2saBqieNJKFZd71mQ7pO8rOJMmu07bew4Q6fFvQqB+AMeCMvi9lnMEhjuBzH+cjv
	 Wi+MNR7GAcSP0ZsnYGaRcIxqLxKHkC7n73FZHN3G6VerPGVVg9s3zW+X90+luhH/7B
	 uEsBIshJ/HmYWMuaSmL7rA1ig7iAEW/406xCgMnAvvILli8Sbfmm+P1P+/P3InR1vW
	 WYzJv47UWPQI5SwrldgIiKFweVhRmRBxmifoDUuojpHReHEkSWadlc7QvvFUejjfx9
	 swaAOS4eQV91nm2Is7jbOwdh62RBfHs4VdqrtvlMJU9KV6sHzHOeVrEz1Mj9/Uu2RQ
	 EL8NV5NWRyWhQ==
Received: from localhost (192-168-127-49.net4.ethz.ch [192.168.127.49])
	by phd-imap.ethz.ch (Postfix) with ESMTP id 4YSrYH41Rrz8R;
	Wed,  8 Jan 2025 15:54:43 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at phys.ethz.ch
Received: from phd-mxin.ethz.ch ([192.168.127.53])
	by localhost (phd-mailscan.ethz.ch [192.168.127.49]) (amavisd-new, port 10024)
	with LMTP id UdbC1_e7zQnS; Wed,  8 Jan 2025 15:54:43 +0100 (CET)
Received: from phys.ethz.ch (mothership.ethz.ch [192.33.96.20])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: daduke@phd-mxin.ethz.ch)
	by phd-mxin.ethz.ch (Postfix) with ESMTPSA id 4YSrYH36xcz9w;
	Wed,  8 Jan 2025 15:54:43 +0100 (CET)
Date: Wed, 8 Jan 2025 15:54:42 +0100
From: Christian Herzog <herzog@phys.ethz.ch>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Salvatore Bonaccorso <carnil@debian.org>,
	Benjamin Coddington <bcodding@redhat.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Harald Dunkel <harald.dunkel@aixigo.com>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	Martin Svec <martin.svec@zoner.cz>,
	Michael Gernoth <debian@zerfleddert.de>,
	Pellegrin Baptiste <Baptiste.Pellegrin@ac-grenoble.fr>
Subject: Re: nfsd blocks indefinitely in nfsd4_destroy_session
Message-ID: <Z36RshcsxU1xFj_X@phys.ethz.ch>
Reply-To: Christian Herzog <herzog@phys.ethz.ch>
References: <4c3080af-eec7-4af5-8b0d-c35ac98ec074@aixigo.com>
 <C1CE3A96-599C-4D73-BCC0-3587EC68FCB0@oracle.com>
 <Z2vNQ6HXfG_LqBQc@eldamar.lan>
 <ecdae86c-2954-4aca-bf1c-f95408ad0ad4@oracle.com>
 <Z32ZzQiKfEeVoyfU@eldamar.lan>
 <3cdcf2ee-46b3-463d-bc14-0f44062c0bd0@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3cdcf2ee-46b3-463d-bc14-0f44062c0bd0@oracle.com>

Dear Chuck,

On Wed, Jan 08, 2025 at 08:33:23AM -0500, Chuck Lever wrote:
> On 1/7/25 4:17 PM, Salvatore Bonaccorso wrote:
> > Hi Chuck,
> > 
> > Thanks for your time on this, much appreciated.
> > 
> > On Wed, Jan 01, 2025 at 02:24:50PM -0500, Chuck Lever wrote:
> > > On 12/25/24 4:15 AM, Salvatore Bonaccorso wrote:
> > > > Hi Chuck, hi all,
> > > > 
> > > > [it was not ideal to pick one of the message for this followup, let me
> > > > know if you want a complete new thread, adding as well Benjamin and
> > > > Trond as they are involved in one mentioned patch]
> > > > 
> > > > On Mon, Jun 17, 2024 at 02:31:54PM +0000, Chuck Lever III wrote:
> > > > > 
> > > > > 
> > > > > > On Jun 17, 2024, at 2:55 AM, Harald Dunkel <harald.dunkel@aixigo.com> wrote:
> > > > > > 
> > > > > > Hi folks,
> > > > > > 
> > > > > > what would be the reason for nfsd getting stuck somehow and becoming
> > > > > > an unkillable process? See
> > > > > > 
> > > > > > - https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1071562
> > > > > > - https://bugs.launchpad.net/ubuntu/+source/nfs-utils/+bug/2062568
> > > > > > 
> > > > > > Doesn't this mean that something inside the kernel gets stuck as
> > > > > > well? Seems odd to me.
> > > > > 
> > > > > I'm not familiar with the Debian or Ubuntu kernel packages. Can
> > > > > the kernel release numbers be translated to LTS kernel releases
> > > > > please? Need both "last known working" and "first broken" releases.
> > > > > 
> > > > > This:
> > > > > 
> > > > > [ 6596.911785] RPC: Could not send backchannel reply error: -110
> > > > > [ 6596.972490] RPC: Could not send backchannel reply error: -110
> > > > > [ 6837.281307] RPC: Could not send backchannel reply error: -110
> > > > > 
> > > > > is a known set of client backchannel bugs. Knowing the LTS kernel
> > > > > releases (see above) will help us figure out what needs to be
> > > > > backported to the LTS kernels kernels in question.
> > > > > 
> > > > > This:
> > > > > 
> > > > > [11183.290619] wait_for_completion+0x88/0x150
> > > > > [11183.290623] __flush_workqueue+0x140/0x3e0
> > > > > [11183.290629] nfsd4_probe_callback_sync+0x1a/0x30 [nfsd]
> > > > > [11183.290689] nfsd4_destroy_session+0x186/0x260 [nfsd]
> > > > > 
> > > > > is probably related to the backchannel errors on the client, but
> > > > > client bugs shouldn't cause the server to hang like this. We
> > > > > might be able to say more if you can provide the kernel release
> > > > > translations (see above).
> > > > 
> > > > In Debian we hstill have the bug #1071562 open and one person notified
> > > > mye offlist that it appears that the issue get more frequent since
> > > > they updated on NFS client side from Ubuntu 20.04 to Debian bookworm
> > > > with a 6.1.y based kernel).
> > > > 
> > > > Some people around those issues, seem to claim that the change
> > > > mentioned in
> > > > https://lists.proxmox.com/pipermail/pve-devel/2024-July/064614.html
> > > > would fix the issue, which is as well backchannel related.
> > > > 
> > > > This is upstream: 6ddc9deacc13 ("SUNRPC: Fix backchannel reply,
> > > > again"). While this commit fixes 57331a59ac0d ("NFSv4.1: Use the
> > > > nfs_client's rpc timeouts for backchannel") this is not something
> > > > which goes back to 6.1.y, could it be possible that hte backchannel
> > > > refactoring and this final fix indeeds fixes the issue?
> > > > 
> > > > As people report it is not easily reproducible, so this makes it
> > > > harder to identify fixes correctly.
> > > > 
> > > > I gave a (short) stance on trying to backport commits up to
> > > > 6ddc9deacc13 ("SUNRPC: Fix backchannel reply, again") but this quickly
> > > > seems to indicate it is probably still not the right thing for
> > > > backporting to the older stable series.
> > > > 
> > > > As at least pre-requisites:
> > > > 
> > > > 2009e32997ed568a305cf9bc7bf27d22e0f6ccda
> > > > 4119bd0306652776cb0b7caa3aea5b2a93aecb89
> > > > 163cdfca341b76c958567ae0966bd3575c5c6192
> > > > f4afc8fead386c81fda2593ad6162271d26667f8
> > > > 6ed8cdf967f7e9fc96cd1c129719ef99db2f9afc
> > > > 57331a59ac0d680f606403eb24edd3c35aecba31
> > > > 
> > > > and still there would be conflicting codepaths (and does not seem
> > > > right).
> > > > 
> > > > Chuck, Benjamin, Trond, is there anything we can provive on reporters
> > > > side that we can try to tackle this issue better?
> > > 
> > > As I've indicated before, NFSD should not block no matter what the
> > > client may or may not be doing. I'd like to focus on the server first.
> > > 
> > > What is the result of:
> > > 
> > > $ cd <Bookworm's v6.1.90 kernel source >
> > > $ unset KBUILD_OUTPUT
> > > $ make -j `nproc`
> > > $ scripts/faddr2line \
> > > 	fs/nfsd/nfs4state.o \
> > > 	nfsd4_destroy_session+0x16d
> > > 
> > > Since this issue appeared after v6.1.1, is it possible to bisect
> > > between v6.1.1 and v6.1.90 ?
> > 
> > First please note, at least speaking of triggering the issue in
> > Debian, Debian has moved to 6.1.119 based kernel already (and soon in
> > the weekends point release move to 6.1.123).
> > 
> > That said, one of the users which regularly seems to be hit by the
> > issue was able to provide the above requested information, based for
> > 6.1.119:
> > 
> > ~/kernel/linux-source-6.1# make kernelversion
> > 6.1.119
> > ~/kernel/linux-source-6.1# scripts/faddr2line fs/nfsd/nfs4state.o nfsd4_destroy_session+0x16d
> > nfsd4_destroy_session+0x16d/0x250:
> > __list_del_entry at /root/kernel/linux-source-6.1/./include/linux/list.h:134
> > (inlined by) list_del at /root/kernel/linux-source-6.1/./include/linux/list.h:148
> > (inlined by) unhash_session at /root/kernel/linux-source-6.1/fs/nfsd/nfs4state.c:2062
> > (inlined by) nfsd4_destroy_session at /root/kernel/linux-source-6.1/fs/nfsd/nfs4state.c:3856
> > 
> > They could provide as well a decode_stacktrace output for the recent
> > hit (if that is helpful for you):
> > 
> > [Mon Jan 6 13:25:28 2025] INFO: task nfsd:55306 blocked for more than 6883 seconds.
> > [Mon Jan 6 13:25:28 2025]       Not tainted 6.1.0-28-amd64 #1 Debian 6.1.119-1
> > [Mon Jan 6 13:25:28 2025] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> > [Mon Jan 6 13:25:28 2025] task:nfsd            state:D stack:0     pid:55306 ppid:2      flags:0x00004000
> > [Mon Jan 6 13:25:28 2025] Call Trace:
> > [Mon Jan 6 13:25:28 2025]  <TASK>
> > [Mon Jan 6 13:25:28 2025] __schedule+0x34d/0x9e0
> > [Mon Jan 6 13:25:28 2025] schedule+0x5a/0xd0
> > [Mon Jan 6 13:25:28 2025] schedule_timeout+0x118/0x150
> > [Mon Jan 6 13:25:28 2025] wait_for_completion+0x86/0x160
> > [Mon Jan 6 13:25:28 2025] __flush_workqueue+0x152/0x420
> > [Mon Jan 6 13:25:28 2025] nfsd4_destroy_session (debian/build/build_amd64_none_amd64/include/linux/spinlock.h:351 debian/build/build_amd64_none_amd64/fs/nfsd/nfs4state.c:3861) nfsd
> > [Mon Jan 6 13:25:28 2025] nfsd4_proc_compound (debian/build/build_amd64_none_amd64/fs/nfsd/nfs4proc.c:2680) nfsd
> > [Mon Jan 6 13:25:28 2025] nfsd_dispatch (debian/build/build_amd64_none_amd64/fs/nfsd/nfssvc.c:1022) nfsd
> > [Mon Jan 6 13:25:28 2025] svc_process_common (debian/build/build_amd64_none_amd64/net/sunrpc/svc.c:1344) sunrpc
> > [Mon Jan 6 13:25:28 2025] ? svc_recv (debian/build/build_amd64_none_amd64/net/sunrpc/svc_xprt.c:897) sunrpc
> > [Mon Jan 6 13:25:28 2025] ? nfsd_svc (debian/build/build_amd64_none_amd64/fs/nfsd/nfssvc.c:983) nfsd
> > [Mon Jan 6 13:25:28 2025] ? nfsd_inet6addr_event (debian/build/build_amd64_none_amd64/fs/nfsd/nfssvc.c:922) nfsd
> > [Mon Jan 6 13:25:28 2025] svc_process (debian/build/build_amd64_none_amd64/net/sunrpc/svc.c:1474) sunrpc
> > [Mon Jan 6 13:25:28 2025] nfsd (debian/build/build_amd64_none_amd64/fs/nfsd/nfssvc.c:960) nfsd
> > [Mon Jan 6 13:25:28 2025] kthread+0xd7/0x100
> > [Mon Jan 6 13:25:28 2025] ? kthread_complete_and_exit+0x20/0x20
> > [Mon Jan 6 13:25:28 2025] ret_from_fork+0x1f/0x30
> > [Mon Jan  6 13:25:28 2025]  </TASK>
> > 
> > The question about bisection is actually harder, those are production
> > systems and I understand it's not possible to do bisect there, while
> > unfortunately not reprodcing the issue on "lab conditions".
> > 
> > Does the above give us still a clue on what you were looking for?
> 
> Thanks for the update.
> 
> It's possible that 38f080f3cd19 ("NFSD: Move callback_wq into struct
> nfs4_client"), while not a specific fix for this issue, might offer some
> relief by preventing the DESTROY_SESSION hang from affecting all other
> clients of the degraded server.
> 
> Not having a reproducer or the ability to bisect puts a damper on
> things. The next step, then, is to enable tracing on servers where this
> issue can come up, and wait for the hang to occur. The following command
> captures information only about callback operation, so it should not
> generate much data or impact server performance.
> 
>   # trace-cmd record -e nfsd:nfsd_cb\*
> 
> Let that run until the problem occurs, then ^C, compress the resulting
> trace.dat file, and either attach it to 1071562 or email it to me
> privately.
thanks for the follow-up.

I am the "customer" with two affected file servers. We have since moved those
servers to the backports kernel (6.11.10) in the hope of forward fixing the
issue. If this kernel is stable, I'm afraid I can't go back to the 'bad'
kernel (700+ researchers affected..), and we're also not able to trigger the
issue on our test environment.

I'm sorry I can't be of more help.

best,
-Christian



-- 
Dr. Christian Herzog <herzog@phys.ethz.ch>  support: +41 44 633 26 68
Head, IT Services Group, HPT H 8              voice: +41 44 633 39 50
Department of Physics, ETH Zurich           
8093 Zurich, Switzerland                     http://isg.phys.ethz.ch/

