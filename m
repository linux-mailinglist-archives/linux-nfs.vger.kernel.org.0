Return-Path: <linux-nfs+bounces-9379-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 791CAA1584B
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2025 20:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 935A73A809B
	for <lists+linux-nfs@lfdr.de>; Fri, 17 Jan 2025 19:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B107F1A8F6B;
	Fri, 17 Jan 2025 19:43:39 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtpout1.ac-grenoble.fr (smtpout1.ac-grenoble.fr [195.221.235.16])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C5A19E7D1
	for <linux-nfs@vger.kernel.org>; Fri, 17 Jan 2025 19:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.221.235.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737143019; cv=none; b=ijcd8liQUbN7PlJIv4gJ44724k+m2WAYJB93Ep6Ym09goNhGZ4JN3RdxE2i1Bp+qb2QnN2ZDKlfThglMctimKFeLIfa1YTfgDEbp/9nw8uChcLkALDN5KGw5iyjR71PETi6nOalAWWU7EPqw5t295mD2I03ryEhLZnf8nQot0Dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737143019; c=relaxed/simple;
	bh=zL56HucNah8Dot+LsLrNZFUKt/+VRYkphS4adLXVBco=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G6tAi3xwydx/xw/lC+26tayU65LmrC3AQ8IpP8Icf+WEnTQVOTChCz1IyCJmV+gj0mPdwAVb3FtZwPQ3E2kKGTCCgwX7CsUMqhxVD9f2fjHj8Pbrulo2UcMJURyTAcnZP10FTyD0bYcLJ3Uq1C7JMc+sn25WXW5+ioDQ2duRWU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ac-grenoble.fr; spf=pass smtp.mailfrom=ac-grenoble.fr; arc=none smtp.client-ip=195.221.235.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ac-grenoble.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ac-grenoble.fr
Received: from mta2.ac-grenoble.fr (mta2.ac-grenoble.fr [195.221.235.166])
	by smtpout1.ac-grenoble.fr (Postfix) with ESMTP id 2154F21FAB;
	Fri, 17 Jan 2025 20:43:27 +0100 (CET)
Received: from imsva3.ac-grenoble.fr (imsva3.ac-grenoble.fr [195.221.235.179])
	by mta2.ac-grenoble.fr (Postfix) with ESMTP id 1B0322110A;
	Fri, 17 Jan 2025 20:43:27 +0100 (CET)
Received: from imsva3.ac-grenoble.fr (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0339E8057;
	Fri, 17 Jan 2025 20:43:26 +0100 (CET)
Received: from imsva3.ac-grenoble.fr (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9FF7BE8050;
	Fri, 17 Jan 2025 20:43:26 +0100 (CET)
Received: from smtp2.ac-grenoble.fr (unknown [195.221.235.183])
	by imsva3.ac-grenoble.fr (Postfix) with ESMTPS;
	Fri, 17 Jan 2025 20:43:26 +0100 (CET)
Received: from [192.168.0.15] (91-171-206-213.subs.proxad.net [91.171.206.213])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: bpellegrin)
	by smtp2.ac-grenoble.fr (Postfix) with ESMTPSA id B5B0120051;
	Fri, 17 Jan 2025 20:43:25 +0100 (CET)
Message-ID: <7a3cfd98-b82d-4e96-971e-2f2658ff55d8@ac-grenoble.fr>
Date: Fri, 17 Jan 2025 20:43:20 +0100
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: nfsd blocks indefinitely in nfsd4_destroy_session
To: Chuck Lever <chuck.lever@oracle.com>, Rik Theys <rik.theys@gmail.com>,
 Christian Herzog <herzog@phys.ethz.ch>
Cc: Salvatore Bonaccorso <carnil@debian.org>,
 Benjamin Coddington <bcodding@redhat.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Harald Dunkel <harald.dunkel@aixigo.com>,
 Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
 Martin Svec <martin.svec@zoner.cz>, Michael Gernoth <debian@zerfleddert.de>,
 Jeff Layton <jlayton@kernel.org>
References: <4c3080af-eec7-4af5-8b0d-c35ac98ec074@aixigo.com>
 <C1CE3A96-599C-4D73-BCC0-3587EC68FCB0@oracle.com>
 <Z2vNQ6HXfG_LqBQc@eldamar.lan>
 <ecdae86c-2954-4aca-bf1c-f95408ad0ad4@oracle.com>
 <Z32ZzQiKfEeVoyfU@eldamar.lan>
 <3cdcf2ee-46b3-463d-bc14-0f44062c0bd0@oracle.com>
 <Z36RshcsxU1xFj_X@phys.ethz.ch>
 <7fb711b1-c557-48de-bf91-d522bdbcc575@oracle.com>
 <Z3-5fOEXTSZvmM8F@phys.ethz.ch>
 <36f4892e1332e2322ab46e1343316eb187d78025.camel@kernel.org>
 <a4a3aca4-3e53-4537-a6f5-a46dc2258708@oracle.com>
 <f0705a65549ef253.67823675@ac-grenoble.fr>
 <7428f722-3456-42e1-91ba-7cb52468f364@oracle.com>
Content-Language: en-US
From: Baptiste PELLEGRIN <baptiste.pellegrin@ac-grenoble.fr>
In-Reply-To: <7428f722-3456-42e1-91ba-7cb52468f364@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSVA-9.1.0.1960-9.0.0.1006-28930.002
X-TM-AS-Result: No--34.890-9.0-31-10
X-imss-scan-details: No--34.890-9.0-31-10
X-TMASE-Version: IMSVA-9.1.0.1960-9.0.1006-28930.002
X-TMASE-Result: 10--34.890300-10.000000
X-TMASE-MatchedRID: 8HTFlOrbAtFtv0JNjNgkzK5i3jK3KDOoofZV/2Xa0cLkxTddgB4tzirm
	FDYXuSUMLoD4tn9vWJKelBtR7L2iNENBh77UZA81CtzGvPCy/m6wFIDW25lVJrXl40gTGJ5pGP5
	rEwOHJIhLEV7wyWkeFnJXuAX1c1SN7ABo0upccSrQ3MpnYlTHVmVHNkCQpEYNyBXJN3+n78iTE6
	UeymstxUiajREzSbE8HVFtlqNBKW5D6TXjy/EiW7xygpRxo469sVwPMKjZm1ZqrsOvUFEKy+m57
	3tusZjQ8Im5ul5n/W7FXqfNthcw6duUUgUooFtQI0cHLI6lhgK3ClSK/bUMDa0GJL2EV5pM7+bR
	uakMI0B1HB0VHBxFRXf/NZc3T81yseY8I2CDJmQgFhzkd+/gE00s9CXRACW08vJ7Gotm2YANleG
	9Mx1C74MQfhWIxRKXVYZ8VpaWoFxXb7U23XCEVfUMs5eBUu2dkt8nRRCBjU70lLwT367HfZMa95
	IHkZDC4Utg/grucZaapBMvgn3rU7gxa0WEhvU4L7p//vLv4bPKLdLRjLKhp8Xhlmai7p8x6Z4+z
	O31vRcgdAHANlBHE84JAhaGCFbl9N7X0Hh1nELEOJqSsn5KmWUyLrXVREJVp8OlUPvzGP2sw16a
	nkSpXRBILMv/9H7RNOxn1Q2tEi4DUZIVhwzaOC/T1r68E/jWLkxZDUhEe+V6YW2UQ6Wj8rGCkCx
	VGwe7IVhz3157Efl+WCHTqr3hQUSaaFy3o7RN+s0+QZYAcN/kP0R6h4dRnOQydRUvl3QTvvr5rY
	OmVDhCL0iaxKE1f5PbLdxJyuSxI5mvzuW9eEKeAiCmPx4NwFkMvWAuahr8ylNXFsiN4FpJKW4mD
	lJsMbxAi7jPoeEQftwZ3X11IV0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0



On 1/16/25 9:07 PM, Chuck Lever wrote:
> On 1/11/25 3:14 AM, Pellegrin Baptiste wrote:
>> On 09/01/25 17:32, *Chuck Lever * <chuck.lever@oracle.com> wrote:
>>> On 1/9/25 7:42 AM, Jeff Layton wrote:
>>> >On Thu, 2025-01-09 at 12:56 +0100, Christian Herzog wrote:
>>> >>Dear Chuck,
>>> >>
>>> >>On Wed, Jan 08, 2025 at 10:07:49AM -0500, Chuck Lever wrote:
>>> >>>On 1/8/25 9:54 AM, Christian Herzog wrote:
>>> >>>>Dear Chuck,
>>> >>>>
>>> >>>>On Wed, Jan 08, 2025 at 08:33:23AM -0500, Chuck Lever wrote:
>>> >>>>>On 1/7/25 4:17 PM, Salvatore Bonaccorso wrote:
>>> >>>>>>Hi Chuck,
>>> >>>>>>
>>> >>>>>>Thanks for your time on this, much appreciated.
>>> >>>>>>
>>> >>>>>>On Wed, Jan 01, 2025 at 02:24:50PM -0500, Chuck Lever wrote:
>>> >>>>>>>On 12/25/24 4:15 AM, Salvatore Bonaccorso wrote:
>>> >>>>>>>>Hi Chuck, hi all,
>>> >>>>>>>>
>>> >>>>>>>>[it was not ideal to pick one of the message for this 
>>> followup, let me
>>> >>>>>>>>know if you want a complete new thread, adding as well 
>>> Benjamin and
>>> >>>>>>>>Trond as they are involved in one mentioned patch]
>>> >>>>>>>>
>>> >>>>>>>>On Mon, Jun 17, 2024 at 02:31:54PM +0000, Chuck Lever III wrote:
>>> >>>>>>>>>
>>> >>>>>>>>>
>>> >>>>>>>>>>On Jun 17, 2024, at 2:55 AM, Harald Dunkel 
>>> <harald.dunkel@aixigo.com> wrote:
>>> >>>>>>>>>>
>>> >>>>>>>>>>Hi folks,
>>> >>>>>>>>>>
>>> >>>>>>>>>>what would be the reason for nfsd getting stuck somehow and 
>>> becoming
>>> >>>>>>>>>>an unkillable process? See
>>> >>>>>>>>>>
>>> >>>>>>>>>>- https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1071562 
>>> <https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1071562>
>>> >>>>>>>>>>- https://bugs.launchpad.net/ubuntu/+source/nfs-utils/ 
>>> +bug/2062568 <https://bugs.launchpad.net/ubuntu/+source/nfs-utils/ 
>>> +bug/2062568>
>>> >>>>>>>>>>
>>> >>>>>>>>>>Doesn't this mean that something inside the kernel gets 
>>> stuck as
>>> >>>>>>>>>>well? Seems odd to me.
>>> >>>>>>>>>
>>> >>>>>>>>>I'm not familiar with the Debian or Ubuntu kernel packages. Can
>>> >>>>>>>>>the kernel release numbers be translated to LTS kernel releases
>>> >>>>>>>>>please? Need both "last known working" and "first broken" 
>>> releases.
>>> >>>>>>>>>
>>> >>>>>>>>>This:
>>> >>>>>>>>>
>>> >>>>>>>>>[ 6596.911785] RPC: Could not send backchannel reply error: 
>>> -110
>>> >>>>>>>>>[ 6596.972490] RPC: Could not send backchannel reply error: 
>>> -110
>>> >>>>>>>>>[ 6837.281307] RPC: Could not send backchannel reply error: 
>>> -110
>>> >>>>>>>>>
>>> >>>>>>>>>is a known set of client backchannel bugs. Knowing the LTS 
>>> kernel
>>> >>>>>>>>>releases (see above) will help us figure out what needs to be
>>> >>>>>>>>>backported to the LTS kernels kernels in question.
>>> >>>>>>>>>
>>> >>>>>>>>>This:
>>> >>>>>>>>>
>>> >>>>>>>>>[11183.290619] wait_for_completion+0x88/0x150
>>> >>>>>>>>>[11183.290623] __flush_workqueue+0x140/0x3e0
>>> >>>>>>>>>[11183.290629] nfsd4_probe_callback_sync+0x1a/0x30 [nfsd]
>>> >>>>>>>>>[11183.290689] nfsd4_destroy_session+0x186/0x260 [nfsd]
>>> >>>>>>>>>
>>> >>>>>>>>>is probably related to the backchannel errors on the client, 
>>> but
>>> >>>>>>>>>client bugs shouldn't cause the server to hang like this. We
>>> >>>>>>>>>might be able to say more if you can provide the kernel release
>>> >>>>>>>>>translations (see above).
>>> >>>>>>>>
>>> >>>>>>>>In Debian we hstill have the bug #1071562 open and one person 
>>> notified
>>> >>>>>>>>mye offlist that it appears that the issue get more frequent 
>>> since
>>> >>>>>>>>they updated on NFS client side from Ubuntu 20.04 to Debian 
>>> bookworm
>>> >>>>>>>>with a 6.1.y based kernel).
>>> >>>>>>>>
>>> >>>>>>>>Some people around those issues, seem to claim that the change
>>> >>>>>>>>mentioned in
>>> >>>>>>>>https://lists.proxmox.com/pipermail/pve-devel/2024- 
>>> July/064614.html <https://lists.proxmox.com/pipermail/pve-devel/2024- 
>>> July/064614.html>
>>> >>>>>>>>would fix the issue, which is as well backchannel related.
>>> >>>>>>>>
>>> >>>>>>>>This is upstream: 6ddc9deacc13 ("SUNRPC: Fix backchannel reply,
>>> >>>>>>>>again"). While this commit fixes 57331a59ac0d ("NFSv4.1: Use the
>>> >>>>>>>>nfs_client's rpc timeouts for backchannel") this is not 
>>> something
>>> >>>>>>>>which goes back to 6.1.y, could it be possible that hte 
>>> backchannel
>>> >>>>>>>>refactoring and this final fix indeeds fixes the issue?
>>> >>>>>>>>
>>> >>>>>>>>As people report it is not easily reproducible, so this makes it
>>> >>>>>>>>harder to identify fixes correctly.
>>> >>>>>>>>
>>> >>>>>>>>I gave a (short) stance on trying to backport commits up to
>>> >>>>>>>>6ddc9deacc13 ("SUNRPC: Fix backchannel reply, again") but 
>>> this quickly
>>> >>>>>>>>seems to indicate it is probably still not the right thing for
>>> >>>>>>>>backporting to the older stable series.
>>> >>>>>>>>
>>> >>>>>>>>As at least pre-requisites:
>>> >>>>>>>>
>>> >>>>>>>>2009e32997ed568a305cf9bc7bf27d22e0f6ccda
>>> >>>>>>>>4119bd0306652776cb0b7caa3aea5b2a93aecb89
>>> >>>>>>>>163cdfca341b76c958567ae0966bd3575c5c6192
>>> >>>>>>>>f4afc8fead386c81fda2593ad6162271d26667f8
>>> >>>>>>>>6ed8cdf967f7e9fc96cd1c129719ef99db2f9afc
>>> >>>>>>>>57331a59ac0d680f606403eb24edd3c35aecba31
>>> >>>>>>>>
>>> >>>>>>>>and still there would be conflicting codepaths (and does not 
>>> seem
>>> >>>>>>>>right).
>>> >>>>>>>>
>>> >>>>>>>>Chuck, Benjamin, Trond, is there anything we can provive on 
>>> reporters
>>> >>>>>>>>side that we can try to tackle this issue better?
>>> >>>>>>>
>>> >>>>>>>As I've indicated before, NFSD should not block no matter what 
>>> the
>>> >>>>>>>client may or may not be doing. I'd like to focus on the 
>>> server first.
>>> >>>>>>>
>>> >>>>>>>What is the result of:
>>> >>>>>>>
>>> >>>>>>>$ cd <Bookworm's v6.1.90 kernel source >
>>> >>>>>>>$ unset KBUILD_OUTPUT
>>> >>>>>>>$ make -j `nproc`
>>> >>>>>>>$ scripts/faddr2line \
>>> >>>>>>> fs/nfsd/nfs4state.o \
>>> >>>>>>> nfsd4_destroy_session+0x16d
>>> >>>>>>>
>>> >>>>>>>Since this issue appeared after v6.1.1, is it possible to bisect
>>> >>>>>>>between v6.1.1 and v6.1.90 ?
>>> >>>>>>
>>> >>>>>>First please note, at least speaking of triggering the issue in
>>> >>>>>>Debian, Debian has moved to 6.1.119 based kernel already (and 
>>> soon in
>>> >>>>>>the weekends point release move to 6.1.123).
>>> >>>>>>
>>> >>>>>>That said, one of the users which regularly seems to be hit by the
>>> >>>>>>issue was able to provide the above requested information, 
>>> based for
>>> >>>>>>6.1.119:
>>> >>>>>>
>>> >>>>>>~/kernel/linux-source-6.1# make kernelversion
>>> >>>>>>6.1.119
>>> >>>>>>~/kernel/linux-source-6.1# scripts/faddr2line fs/nfsd/ 
>>> nfs4state.o nfsd4_destroy_session+0x16d
>>> >>>>>>nfsd4_destroy_session+0x16d/0x250:
>>> >>>>>>__list_del_entry at /root/kernel/linux-source-6.1/./include/ 
>>> linux/list.h:134
>>> >>>>>>(inlined by) list_del at /root/kernel/linux-source-6.1/./ 
>>> include/linux/list.h:148
>>> >>>>>>(inlined by) unhash_session at /root/kernel/linux-source-6.1/ 
>>> fs/ nfsd/nfs4state.c:2062
>>> >>>>>>(inlined by) nfsd4_destroy_session at /root/kernel/linux- 
>>> source-6.1/fs/nfsd/nfs4state.c:3856
>>> >>>>>>
>>> >>>>>>They could provide as well a decode_stacktrace output for the 
>>> recent
>>> >>>>>>hit (if that is helpful for you):
>>> >>>>>>
>>> >>>>>>[Mon Jan 6 13:25:28 2025] INFO: task nfsd:55306 blocked for 
>>> more than 6883 seconds.
>>> >>>>>>[Mon Jan 6 13:25:28 2025]       Not tainted 6.1.0-28-amd64 #1 
>>> Debian 6.1.119-1
>>> >>>>>>[Mon Jan 6 13:25:28 2025] "echo 0 > /proc/sys/kernel/ 
>>> hung_task_timeout_secs" disables this message.
>>> >>>>>>[Mon Jan 6 13:25:28 2025] task:nfsd            state:D 
>>> stack:0     pid:55306 ppid:2      flags:0x00004000
>>> >>>>>>[Mon Jan 6 13:25:28 2025] Call Trace:
>>> >>>>>>[Mon Jan 6 13:25:28 2025]  <TASK>
>>> >>>>>>[Mon Jan 6 13:25:28 2025] __schedule+0x34d/0x9e0
>>> >>>>>>[Mon Jan 6 13:25:28 2025] schedule+0x5a/0xd0
>>> >>>>>>[Mon Jan 6 13:25:28 2025] schedule_timeout+0x118/0x150
>>> >>>>>>[Mon Jan 6 13:25:28 2025] wait_for_completion+0x86/0x160
>>> >>>>>>[Mon Jan 6 13:25:28 2025] __flush_workqueue+0x152/0x420
>>> >>>>>>[Mon Jan 6 13:25:28 2025] nfsd4_destroy_session (debian/build/ 
>>> build_amd64_none_amd64/include/linux/spinlock.h:351 debian/build/ 
>>> build_amd64_none_amd64/fs/nfsd/nfs4state.c:3861) nfsd
>>> >>>>>>[Mon Jan 6 13:25:28 2025] nfsd4_proc_compound (debian/build/ 
>>> build_amd64_none_amd64/fs/nfsd/nfs4proc.c:2680) nfsd
>>> >>>>>>[Mon Jan 6 13:25:28 2025] nfsd_dispatch (debian/build/ 
>>> build_amd64_none_amd64/fs/nfsd/nfssvc.c:1022) nfsd
>>> >>>>>>[Mon Jan 6 13:25:28 2025] svc_process_common (debian/build/ 
>>> build_amd64_none_amd64/net/sunrpc/svc.c:1344) sunrpc
>>> >>>>>>[Mon Jan 6 13:25:28 2025] ? svc_recv (debian/build/ 
>>> build_amd64_none_amd64/net/sunrpc/svc_xprt.c:897) sunrpc
>>> >>>>>>[Mon Jan 6 13:25:28 2025] ? nfsd_svc (debian/build/ 
>>> build_amd64_none_amd64/fs/nfsd/nfssvc.c:983) nfsd
>>> >>>>>>[Mon Jan 6 13:25:28 2025] ? nfsd_inet6addr_event (debian/build/ 
>>> build_amd64_none_amd64/fs/nfsd/nfssvc.c:922) nfsd
>>> >>>>>>[Mon Jan 6 13:25:28 2025] svc_process (debian/build/ 
>>> build_amd64_none_amd64/net/sunrpc/svc.c:1474) sunrpc
>>> >>>>>>[Mon Jan 6 13:25:28 2025] nfsd (debian/build/ 
>>> build_amd64_none_amd64/fs/nfsd/nfssvc.c:960) nfsd
>>> >>>>>>[Mon Jan 6 13:25:28 2025] kthread+0xd7/0x100
>>> >>>>>>[Mon Jan 6 13:25:28 2025] ? kthread_complete_and_exit+0x20/0x20
>>> >>>>>>[Mon Jan 6 13:25:28 2025] ret_from_fork+0x1f/0x30
>>> >>>>>>[Mon Jan  6 13:25:28 2025]  </TASK>
>>> >>>>>>
>>> >>>>>>The question about bisection is actually harder, those are 
>>> production
>>> >>>>>>systems and I understand it's not possible to do bisect there, 
>>> while
>>> >>>>>>unfortunately not reprodcing the issue on "lab conditions".
>>> >>>>>>
>>> >>>>>>Does the above give us still a clue on what you were looking for?
>>> >>>>>
>>> >>>>>Thanks for the update.
>>> >>>>>
>>> >>>>>It's possible that 38f080f3cd19 ("NFSD: Move callback_wq into 
>>> struct
>>> >>>>>nfs4_client"), while not a specific fix for this issue, might 
>>> offer some
>>> >>>>>relief by preventing the DESTROY_SESSION hang from affecting all 
>>> other
>>> >>>>>clients of the degraded server.
>>> >>>>>
>>> >>>>>Not having a reproducer or the ability to bisect puts a damper on
>>> >>>>>things. The next step, then, is to enable tracing on servers 
>>> where this
>>> >>>>>issue can come up, and wait for the hang to occur. The following 
>>> command
>>> >>>>>captures information only about callback operation, so it should 
>>> not
>>> >>>>>generate much data or impact server performance.
>>> >>>>>
>>> >>>>>    # trace-cmd record -e nfsd:nfsd_cb\*
>>> >>>>>
>>> >>>>>Let that run until the problem occurs, then ^C, compress the 
>>> resulting
>>> >>>>>trace.dat file, and either attach it to 1071562 or email it to me
>>> >>>>>privately.
>>> >>>>thanks for the follow-up.
>>> >>>>
>>> >>>>I am the "customer" with two affected file servers. We have since 
>>> moved those
>>> >>>>servers to the backports kernel (6.11.10) in the hope of forward 
>>> fixing the
>>> >>>>issue. If this kernel is stable, I'm afraid I can't go back to 
>>> the 'bad'
>>> >>>>kernel (700+ researchers affected..), and we're also not able to 
>>> trigger the
>>> >>>>issue on our test environment.
>>> >>>
>>> >>>Hello Dr. Herzog -
>>> >>>
>>> >>>If the problem recurs on 6.11, the trace-cmd I suggest above works
>>> >>>there as well.
>>> >>the bad news is: it just happened again with the bpo kernel.
>>> >>
>>> >>We then immediately started trace-cmd since usually there are 
>>> several call
>>> >>traces in a row and we did get a trace.dat:
>>> >>http://people.phys.ethz.ch/~daduke/trace.dat <http:// 
>>> people.phys.ethz.ch/~daduke/trace.dat>
>>> >>
>>> >>we did notice however that the stack trace looked a bit different 
>>> this time:
>>> >>
>>> >>     INFO: task nfsd:2566 blocked for more than 5799 seconds.
>>> >>     Tainted: G        W          6.11.10+bpo-amd64 #1 Debia>
>>> >>     "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables t>
>>> >>     task:nfsd            state:D stack:0     pid:2566  tgid:2566 >
>>> >>     Call Trace:
>>> >>     <TASK>
>>> >>     __schedule+0x400/0xad0
>>> >>     schedule+0x27/0xf0
>>> >>     nfsd4_shutdown_callback+0xfe/0x140 [nfsd]
>>> >>     ? __pfx_var_wake_function+0x10/0x10
>>> >>     __destroy_client+0x1f0/0x290 [nfsd]
>>> >>     nfsd4_destroy_clientid+0xf1/0x1e0 [nfsd]
>>> >>     ? svcauth_unix_set_client+0x586/0x5f0 [sunrpc]
>>> >>     nfsd4_proc_compound+0x34d/0x670 [nfsd]
>>> >>     nfsd_dispatch+0xfd/0x220 [nfsd]
>>> >>     svc_process_common+0x2f7/0x700 [sunrpc]
>>> >>     ? __pfx_nfsd_dispatch+0x10/0x10 [nfsd]
>>> >>     svc_process+0x131/0x180 [sunrpc]
>>> >>     svc_recv+0x830/0xa10 [sunrpc]
>>> >>     ? __pfx_nfsd+0x10/0x10 [nfsd]
>>> >>     nfsd+0x87/0xf0 [nfsd]
>>> >>     kthread+0xcf/0x100
>>> >>     ? __pfx_kthread+0x10/0x10
>>> >>     ret_from_fork+0x31/0x50
>>> >>     ? __pfx_kthread+0x10/0x10
>>> >>     ret_from_fork_asm+0x1a/0x30
>>> >>     </TASK>
>>> >>
>>> >>and also the state of the offending client in `/proc/fs/nfsd/ 
>>> clients/*/info`
>>> >>used to be callback state: UNKNOWN while now it is DOWN or FAULT. 
>>> No idea
>>> >>what it means, but I thought it was worth mentioning.
>>> >>
>>> >
>>> >Looks like this is hung in nfsd41_cb_inflight_wait_complete() ? That
>>> >probably means that the cl_cb_inflight counter is stuck at >0. I'm
>>> >guessing that means that there is some callback that it's expecting to
>>> >complete that isn't. From nfsd4_shutdown_callback():
>>> >
>>> >         /*
>>> >          * Note this won't actually result in a null callback;
>>> >          * instead, nfsd4_run_cb_null() will detect the killed
>>> >          * client, destroy the rpc client, and stop:
>>> >          */
>>> >         nfsd4_run_cb(&clp->cl_cb_null);
>>> >         flush_workqueue(clp->cl_callback_wq);
>>> >         nfsd41_cb_inflight_wait_complete(clp);
>>> >
>>> >...it sounds like that isn't happening properly though.
>>> >
>>> >It might be interesting to see if you can track down the callback
>>> >client in /sys/kernel/debug/sunrpc and see what it's doing.
>>>
>>> Here's a possible scenario:
>>>
>>> The trace.dat shows the server is sending a lot of CB_RECALL_ANY
>>> operations.
>>>
>>> Normally a callback occurs only due to some particular client request.
>>> Such requests would be completed before a client unmounts.
>>>
>>> CB_RECALL_ANY is an operation which does not occur due to a particular
>>> client operation and can occur at any time. I believe this is the
>>> first operation of this type we've added to NFSD.
>>>
>>> My guess is that the server's laundromat has sent some CB_RECALL_ANY
>>> operations while the client is umounting -- DESTROY_SESSION is
>>> racing with those callback operations.
>>>
>>> deleg_reaper() was backported to 6.1.y in 6.1.81, which lines up
>>> more or less with when the issues started to show up.
>>>
>>> A quick way to test this theory would be to make deleg_reaper() a
>>> no-op. If this helps, then we know that shutting down the server's
>>> callback client needs to be more careful about cleaning up outstanding
>>> callbacks.
>>>
>>>
>>> -- 
>>> Chuck Lever
>>
>> Hello.
>>
>> Thanks a lot for all of this work !
>>
>> I have started recording traces using :
>>
>> # trace-cmd record -e nfsd:nfsd_cb\*
>>
>> and currently waiting for the bug to trigger. This generally happen in 
>> one/two weeks for me.
>>
>> If you want I adjust some recording parameters let me know.
> 
> After looking at your data and Rik's data, I decided to try reproducing
> the problem in my lab. No luck so far.
> 
> The signatures of these issues are slightly different from each other:
> 
> v6.1:
> - nfsd4_destroy_session hangs on the flush_workqueue in
>    nfsd4_shutdown_callback()
> - There might be outstanding callback RPCs that are not exiting
> - Lots of CB_RECALL_ANY traffic. Only place that's generated in
>    v6.1 is the NFSD shrinker when memory is short
> - There appear to be some unreachable clients -- evidence of client
>    crashes or network outages, perhaps
> 
> v6.12:
> - destroy_client() hangs on the wait_var_event in
>    nfsd4_shtudown_callback()
> - There are no callback RPCs left after the hang
> - There are some stuck clients listed under /proc/fs/nfsd/
> 
> Similar, but not the same.
> 
> I'm still open to clues, so please continue the regimen of starting
> the trace-cmd when the server boots, and doing an "echo t >
> /proc/sysrq-trigger" when the hang appears.
> 
>   # trace-cmd record -e nfsd:nfsd_cb\* -e sunrpc:svc_xprt_detach \
>     -p function -l nfsd4_destroy_session
> 
> 

Hello Chuck.

Sorry for my late reply but I need to find something
interesting for you.

Did you see my call trace analyze here ?

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1071562

On v6.1 did you see that nfsd4_shutdown_callback is reached from
both nfsd4 laundromat_main and nfsd4_state_shrinker_worker ?
For me the hang in V6.1 come also from wait_var_event.

Here the state of my RAM on my server with some load.

                total        used        free      shared  buff/cache 
available
Mem:           32083        4982         651           5       26919 
   27101
Swap:          16629         842       15787

My desktop clients use heavily suspend. The computer are almost
never rebooted. When a user logout, suspending is automatically 
launched. Do you think that some delegation can be accumulated,
locked by many suspended host, and can cause the
high memory/cache usage ?

Here my crash timeline between the desktop client salleprof13
(the one you think is unreachable) and the server fichdc02.
The failure come from suspend.


---
Client salleprof13 wake from sleep at 09:55:37
and was attached by the server.
The callback channel is initialized.
---

janv. 14 07:20:32 salleprofs13 kernel: PM: suspend entry (deep)

janv. 14 09:55:37 salleprofs13 kernel: PM: suspend exit
janv. 14 09:55:37 salleprofs13 ModemManager[621]: <info> 
[sleep-monitor-systemd] system is resuming
janv. 14 09:55:37 salleprofs13 NetworkManager[576]: <info> 
[1736844937.2382] manager: sleep: wake requested (sleeping: yes 
enabled: yes)
janv. 14 09:55:37 salleprofs13 systemd[1]: Stopping gssd-bug.service - 
Gssd credential cache hook...
janv. 14 09:55:37 salleprofs13 systemd[1]: Starting winbind.service - 
Samba Winbind Daemon...
janv. 14 09:55:37 salleprofs13 systemd[1]: Started winbind.service - 
Samba Winbind Daemon.
janv. 14 09:55:40 salleprofs13 NetworkManager[576]: <info> 
[1736844940.6304] device (enp2s0): carrier: link connected
janv. 14 09:55:40 salleprofs13 kernel: r8169 0000:02:00.0 enp2s0: Link 
is Up - 1Gbps/Full - flow control off

nfsd-1695  [047] ..... 190512.862590: nfsd_cb_probe: 
addr=172.16.118.121:0 client 67833e73:4dd32903 state=UNKNOWN
kworker/u96:8-225529 [047] ..... 190512.862782: nfsd_cb_setup: 
addr=172.16.118.121:0 client 67833e73:4dd32903 proto=tcp flavor=sys
kworker/u96:8-225529 [047] ..... 190512.862784: nfsd_cb_state: 
addr=172.16.118.121:0 client 67833e73:4dd32903 state=UP
2025-01-14T09:55:48.290546+01:00 fichdc02 rpc.mountd[1363]: v4.2 client 
attached: 0x4dd3290367833e73 from "172.16.118.121:825"


---
Someone logon on the station.
Immediately the server start sending nfsd_cb_recall_any.
Strange no ? What can be recalled on that host that just
wake up...
---

janv. 14 09:55:53 salleprofs13 nfsrahead[121742]: setting /dnfs/wine 
readahead to 128
janv. 14 09:56:13 salleprofs13 systemd-logind[569]: New session 36 of 
user xxxxxxxx.

kworker/u96:3-227781 [047] ..... 190541.974364: nfsd_cb_recall_any: 
addr=172.16.118.121:825 client 67833e73:4dd32903 keep=0 bmval0=RDATA_DLG
kworker/u96:2-220501 [013] ..... 190541.977732: nfsd_cb_recall_any_done: 
client 67833e73:4dd32903 status=0
kworker/u96:2-220501 [000] ..... 190550.387742: nfsd_cb_recall_any: 
addr=172.16.118.121:825 client 67833e73:4dd32903 keep=0 bmval0=RDATA_DLG
kworker/u96:0-228547 [003] ..... 190550.389602: nfsd_cb_recall_any_done: 
client 67833e73:4dd32903 status=0
kworker/u96:2-220501 [021] ..... 190565.367759: nfsd_cb_recall_any: 
addr=172.16.118.121:825 client 67833e73:4dd32903 keep=0 bmval0=RDATA_DLG
kworker/u96:1-230409 [000] ..... 190565.371391: nfsd_cb_recall_any_done: 
client 67833e73:4dd32903 status=0
kworker/u96:2-220501 [013] ..... 190579.748430: nfsd_cb_recall_any: 
addr=172.16.118.121:825 client 67833e73:4dd32903 keep=0 bmval0=RDATA_DLG
kworker/u96:8-225529 [026] ..... 190579.749946: nfsd_cb_recall_any_done: 
client 67833e73:4dd32903 status=0
kworker/u96:8-225529 [013] ..... 190592.749738: nfsd_cb_recall_any: 
addr=172.16.118.121:825 client 67833e73:4dd32903 keep=0 bmval0=RDATA_DLG
kworker/u96:2-220501 [001] ..... 190592.751192: nfsd_cb_recall_any_done: 
client 67833e73:4dd32903 status=0
kworker/u96:0-228547 [000] ..... 190599.849333: nfsd_cb_recall_any: 
addr=172.16.118.121:825 client 67833e73:4dd32903 keep=0 bmval0=RDATA_DLG
kworker/u96:0-228547 [000] ..... 190599.850872: nfsd_cb_recall_any_done: 
client 67833e73:4dd32903 status=0
kworker/u96:2-220501 [045] ..... 190686.760138: nfsd_cb_recall_any: 
addr=172.16.118.121:825 client 67833e73:4dd32903 keep=0 bmval0=RDATA_DLG
kworker/u96:1-230409 [014] ..... 190686.761181: nfsd_cb_recall_any_done: 
client 67833e73:4dd32903 status=0
kworker/u96:1-230409 [013] ..... 190694.103480: nfsd_cb_recall_any: 
addr=172.16.118.121:825 client 67833e73:4dd32903 keep=0 bmval0=RDATA_DLG
kworker/u96:8-225529 [022] ..... 190694.106120: nfsd_cb_recall_any_done: 
client 67833e73:4dd32903 status=0
kworker/u96:8-225529 [000] ..... 190749.678378: nfsd_cb_recall_any: 
addr=172.16.118.121:825 client 67833e73:4dd32903 keep=0 bmval0=RDATA_DLG
kworker/u96:2-220501 [007] ..... 190749.679870: nfsd_cb_recall_any_done: 
client 67833e73:4dd32903 status=0
kworker/u96:4-230705 [014] ..... 190782.830144: nfsd_cb_recall_any: 
addr=172.16.118.121:825 client 67833e73:4dd32903 keep=0 bmval0=RDATA_DLG
kworker/u96:1-230409 [010] ..... 190782.831220: nfsd_cb_recall_any_done: 
client 67833e73:4dd32903 status=0


---
Next the user suspend the host maybe by pressing
the power button without login out so the last
nfsd_cb_recall_any fail
Maybe the "unrecognized reply" related ?
---

janv. 14 10:01:18 salleprofs13 systemd-logind[569]: The system will 
suspend now!
janv. 14 10:01:18 salleprofs13 NetworkManager[576]: <info> 
[1736845278.5631] manager: sleep: sleep requested (sleeping: no 
enabled: yes)
janv. 14 10:01:18 salleprofs13 ModemManager[621]: <info> 
[sleep-monitor-systemd] system is about to suspend
janv. 14 10:01:20 salleprofs13 kernel: PM: suspend entry (deep)

kworker/u96:2-220501 [047] ..... 190851.843698: nfsd_cb_recall_any: 
addr=172.16.118.121:825 client 67833e73:4dd32903 keep=0 bmval0=RDATA_DLG
kworker/u96:2-220501 [047] ..... 190861.062828: nfsd_cb_state: 
addr=172.16.118.121:0 client 67833e73:4dd32903 state=FAULT

2025-01-14T10:06:06.586140+01:00 fichdc02 kernel: [191131.106081] 
receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 
00000000ad57929d xid 52751431


---
Got 5 unrecognized reply.
Seems not related .
---

2025-01-14T10:06:56.762137+01:00 fichdc02 kernel: [191181.279788] 
receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 
000000002dcd99c8 xid 5d819d7d
2025-01-14T10:06:56.762197+01:00 fichdc02 kernel: [191181.280005] 
receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 
000000002dcd99c8 xid 61819d7d
2025-01-14T10:06:56.762201+01:00 fichdc02 kernel: [191181.280054] 
receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 
000000002dcd99c8 xid 60819d7d
2025-01-14T10:06:56.762206+01:00 fichdc02 kernel: [191181.280223] 
receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 
000000002dcd99c8 xid 5f819d7d
2025-01-14T10:06:56.762209+01:00 fichdc02 kernel: [191181.280364] 
receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 
000000002dcd99c8 xid 5e819d7d


---
Just 10 minutes after suspend the host wake up (with xxxxxxxx still 
logged on).
The gssd-bug.service is a custom script that kill all the user processes
if the kerberos cache file has expired. This is due to a rpc.gssd bug
that hammer the server when the cache has expired during suspend.
It run "killall -u xxxxxxxx". But here, I don't know if the killall
was called or not.

Just after the wake. The server send again an nfsd_cb_recall_any. But 
this time
there is no nfsd_cb_state with state=FAULT. From this time there no more 
kworker
cb calls. I think this where the hang start.

And we got again an unrecognized reply.
---

janv. 14 10:10:24 salleprofs13 kernel: PM: suspend exit
janv. 14 10:10:24 salleprofs13 systemd-sleep[124910]: System returned 
from sleep state.
janv. 14 10:10:24 salleprofs13 systemd[1]: Stopping gssd-bug.service - 
Gssd credential cache hook...
janv. 14 10:10:24 salleprofs13 NetworkManager[576]: <info> 
[1736845824.4117] manager: sleep: wake requested (sleeping: yes 
enabled: yes)
janv. 14 10:10:24 salleprofs13 check-gssd-cache[124962]: id: 
« xxxxxxxx » : the user don't exist
janv. 14 10:10:24 salleprofs13 systemd[1]: Started winbind.service - 
Samba Winbind Daemon.
janv. 14 10:10:27 salleprofs13 kernel: r8169 0000:02:00.0 enp2s0: Link 
is Up - 1Gbps/Full - flow control off
janv. 14 10:10:27 salleprofs13 NetworkManager[576]: <info> 
[1736845827.6412] device (enp2s0): carrier: link connected
janv. 14 10:10:35 salleprofs13 systemd[1]: Stopped gssd-bug.service - 
Gssd credential cache hook.

kworker/u96:2-220501 [012] ..... 191417.544355: nfsd_cb_recall_any: 
addr=172.16.118.121:825 client 67833e73:4dd32903 keep=0 bmval0=RDATA_DLG

2025-01-14T10:10:58.426113+01:00 fichdc02 kernel: [191422.934976] 
receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 
000000007205cdb2 xid ee91a9d8


---
nfsd probe a failed State. Normal.
But as kworker hang, it can't reinit the callback channel
after the nfsd_cb_state "state=UNKNOWN".

I don't know why but nfsd started also
to send nfsd_cb_recall...
Note that is less than 120 second before the "BLOCKED" message.
so the thread may be already locked.
---

nfsd-1690  [014] ..... 191424.483249: nfsd_cb_probe: 
addr=172.16.118.121:0 client 67833e73:4dd32903 state=FAULT
nfsd-1690  [014] ..... 191424.483252: nfsd_cb_state: 
addr=172.16.118.121:0 client 67833e73:4dd32903 state=UNKNOWN
nfsd-1695  [013] ...1. 191441.265047: nfsd_cb_recall: 
addr=172.16.118.121:0 client 67833e73:4dd32903 stateid 00001c6e:00000001
nfsd-1695  [014] ...1. 191441.646104: nfsd_cb_recall: 
addr=172.16.118.121:0 client 67833e73:4dd32903 stateid 000015fc:00000001


---
Got some strange logs on the client
And 7 unrecognized reply on the server that seems not related.
---

janv. 14 10:11:00 salleprofs13 PackageKit[122249]: daemon quit
janv. 14 10:11:00 salleprofs13 systemd[1]: packagekit.service: 
Deactivated successfully.
janv. 14 10:11:00 salleprofs13 systemd[1]: packagekit.service: Consumed 
28.223s CPU time.
janv. 14 10:11:02 salleprofs13 gnome-shell[122127]: JS ERROR: 
Gio.IOErrorEnum: Erreur lors de l’appel de StartServiceByName pour 
org.vmware.viewagent.Credentials : Le délai d’>
  
_injectToMethod/klass[method]@resource:///org/gnome/gjs/modules/core/overrides/Gio.js:287:25
  
VmwareCredentials@resource:///org/gnome/shell/gdm/vmware.js:34:10
  
VmwareCredentialsManager@resource:///org/gnome/shell/gdm/vmware.js:41:29
  
getVmwareCredentialsManager@resource:///org/gnome/shell/gdm/vmware.js:51:37
  
ShellUserVerifier@resource:///org/gnome/shell/gdm/util.js:183:64
  
_init@resource:///org/gnome/shell/gdm/authPrompt.js:74:30
  
AuthPrompt@resource:///org/gnome/shell/gdm/authPrompt.js:51:4
  
_ensureAuthPrompt@resource:///org/gnome/shell/ui/unlockDialog.js:686:32
  
_showPrompt@resource:///org/gnome/shell/ui/unlockDialog.js:725:14
  
vfunc_key_press_event@resource:///org/gnome/shell/ui/unlockDialog.js:620:14
janv. 14 10:11:05 salleprofs13 gsd-power[122329]: Error setting property 
'PowerSaveMode' on interface org.gnome.Mutter.DisplayConfig: Le délai 
d’attente est dépassé (g-io-erro>
janv. 14 10:11:27 salleprofs13 gnome-shell[122127]: JS ERROR: 
Gio.IOErrorEnum: Erreur lors de l’appel de StartServiceByName pour 
org.vmware.viewagent.Credentials : Le délai d’>
  
_injectToMethod/klass[method]@resource:///org/gnome/gjs/modules/core/overrides/Gio.js:287:25
  
VmwareCredentials@resource:///org/gnome/shell/gdm/vmware.js:34:10
  
VmwareCredentialsManager@resource:///org/gnome/shell/gdm/vmware.js:41:29
  
getVmwareCredentialsManager@resource:///org/gnome/shell/gdm/vmware.js:51:37
  
ShellUserVerifier@resource:///org/gnome/shell/gdm/util.js:183:64
  
_init@resource:///org/gnome/shell/gdm/authPrompt.js:74:30
  
AuthPrompt@resource:///org/gnome/shell/gdm/authPrompt.js:51:4
  
_ensureAuthPrompt@resource:///org/gnome/shell/ui/unlockDialog.js:686:32
  
_showPrompt@resource:///org/gnome/shell/ui/unlockDialog.js:725:14
  
vfunc_key_press_event@resource:///org/gnome/shell/ui/unlockDialog.js:620:14



2025-01-14T10:12:36.730114+01:00 fichdc02 kernel: [191521.235822] 
receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 
00000000191d4459 xid d591b1ee
2025-01-14T10:12:36.730165+01:00 fichdc02 kernel: [191521.236547] 
receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 
00000000191d4459 xid d691b1ee
2025-01-14T10:12:36.730169+01:00 fichdc02 kernel: [191521.236666] 
receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 
00000000191d4459 xid da91b1ee
2025-01-14T10:12:36.730171+01:00 fichdc02 kernel: [191521.236743] 
receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 
00000000191d4459 xid db91b1ee
2025-01-14T10:12:36.730172+01:00 fichdc02 kernel: [191521.236769] 
receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 
00000000191d4459 xid d991b1ee
2025-01-14T10:12:36.730174+01:00 fichdc02 kernel: [191521.236824] 
receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 
00000000191d4459 xid d891b1ee
2025-01-14T10:12:36.730177+01:00 fichdc02 kernel: [191521.236840] 
receive_cb_reply: Got unrecognized reply: calldir 0x1 xpt_bc_xprt 
00000000191d4459 xid d791b1ee


---
And finally the hang syslog message
---

2025-01-14T10:14:29.370164+01:00 fichdc02 kernel: [191633.871204] INFO: 
task nfsd:1690 blocked for more than 120 seconds.
2025-01-14T10:14:29.374846+01:00 fichdc02 kernel: [191633.875410] INFO: 
task nfsd:1691 blocked for more than 120 seconds.
2025-01-14T10:14:29.374966+01:00 fichdc02 kernel: [191633.878106] INFO: 
task nfsd:1693 blocked for more than 120 seconds.
2025-01-14T10:14:29.378303+01:00 fichdc02 kernel: [191633.880748] INFO: 
task nfsd:1695 blocked for more than 120 seconds.


Hope this help.

I'm still recording.

Regards,

Baptiste.



