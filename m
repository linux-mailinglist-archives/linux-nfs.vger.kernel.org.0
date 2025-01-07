Return-Path: <linux-nfs+bounces-8960-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A847FA04B75
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 22:17:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F9C83A067A
	for <lists+linux-nfs@lfdr.de>; Tue,  7 Jan 2025 21:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB38B18C031;
	Tue,  7 Jan 2025 21:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lACMowc4"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82524156968
	for <linux-nfs@vger.kernel.org>; Tue,  7 Jan 2025 21:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736284627; cv=none; b=sFZ2ZsQc/XRhqIYgcbuETwPSjkmbZnYaW5JOnXwn/CZNWQapjqHnOMu/+IMYMmqZVe5H5AwJqsvjycJotQEK+d+f625GfwxGNnCh0CWar6fXL1f27zJkS6c+o8dz04qqfWEIQanits7TnYQYrpfVOLQmWcJiKxhY8fuLh3Z6+Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736284627; c=relaxed/simple;
	bh=dddWGGzNYAscyAVs99RMf4cCm7oNoq1smSRJhbINiLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oevsNGk4IYgwXnP550zuNirXfCtiOIWLoJhdzkbCxnAjkOaYNfNC9BixZZi259oTyk9qT8kDEKQfm4DN6SUhXr+cPxgH7EPSrpLCuuqcyJoODhzRBe6sHf5OQiSqbRHwR4WapN4l1sHZJDlLo56J0u2PvdUZHshVOnSuSmminfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lACMowc4; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d3e8f64d5dso28849207a12.3
        for <linux-nfs@vger.kernel.org>; Tue, 07 Jan 2025 13:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736284624; x=1736889424; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CZpQWkqEueEV9e4RJPVRqpwL4AqNPz7eNsWUFOnPtkM=;
        b=lACMowc4OmofqTZ2VrEr7qzNIARPPWU/rOGbkuYTdXemppJy5ucud97cm9h5n+CfRS
         4DkDV9fZqzhn+Z202EWnKwFqXykIsnLlPzFvUp5OOoNMCH1MPwUuWpPm7U27uFETjg7Q
         Mad3Mt2/nHuw4Dw9D6kTnaTGJxDh8U6nHoVAuNpiYCH4mqEG+Wi7CcV8wPjFUYmUOq2q
         1v2NJt6PXgQPbtYwuAWZvpwpvlujpIVKUJdoMOJzNoESgHq9lHJSBuhC4EYQmqcNJCOE
         HKwdNSlKPcC0MRMwfh1x+3bce7KEnhO3b/CWYntzk5Kerus3XS7/Z2D1Stzppwml78g/
         6HTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736284624; x=1736889424;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CZpQWkqEueEV9e4RJPVRqpwL4AqNPz7eNsWUFOnPtkM=;
        b=JnvYyFGhC5RsGdO5pLrddOHIYIc+y64Vxi6EUEkkjTjWqQerfKjFlso2RzOzT9gdPK
         /cf4uGWct4OMATlXozNb/sVd1gFevCR64TEKUbn9Blr2UoC/1GUqTBa2OyIpm/8Xkf2W
         pZqYzPthFoKPEqMNwbC0cd5C5E4EK6YfMARkED0PZjPtCeYufLJG+C4i+3R72jptjrtf
         N3ZEPnxejxs1qnIartdkIQgeGIVAsUhx+Fc2UjRDZl2wJqpvka7VLufQQGreb1YQ2E8g
         T0BTfqBjx/FxNtqMr8Kg2NMDKRMItUFH+8SkNEcL/BbBpg3li0oP+hmdIKpDRIevD8ub
         L28A==
X-Forwarded-Encrypted: i=1; AJvYcCVcFjlZz4xx0LDp3960Tq03BpV9TZZp+MhX/R2PXcMXOHC4shDIux92m0TZEdJUIMcPgsHXltuIv9A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6HA0laFodO01+dpuvEScTqBwuHAZH9HFpPmVlwZ1fZ+vmFal3
	Cgi3bs0zSEiqwWZAeyQnqoWo5gHft11qpOJoukNj+FC8EWtzBKAw
X-Gm-Gg: ASbGncu9cRnyWQVB+JCBkkKM5I7pX3YGE3snoB88s1LEGjgmBpeuspUitXvVA8odZYi
	NBc8NCW+ox1g7lHt+wF5DnjYpMH4GLIV2+Lbh4AANwaolBJqiSM8rgdyQiJgjxMk64ouuDNTGjn
	2jRxuGRo45J0W3qiD0oWmokRqxX9OM1APZIbGDWSe0WSTpTU2Hawr5vz0sq9Ut+o6O+Jn1wASlt
	mD+iMPLeCX17kW78y6gwKKEcQ3VTuH9eFXBtvZgjHjqjmNX9Mt448M+7PsjvoZFulaJgKXtmdLW
	RS0pakbQbOzcdqY7
X-Google-Smtp-Source: AGHT+IHdAq6N//wIz+7L6UP2yU4fttJWfHrFDz4q2raHAE5EOLmgDjU6QcdLIVDI9gAQ8eX1z9zDTw==
X-Received: by 2002:a05:6402:2554:b0:5d0:d30b:d53e with SMTP id 4fb4d7f45d1cf-5d972e1a980mr258832a12.19.1736284623470;
        Tue, 07 Jan 2025 13:17:03 -0800 (PST)
Received: from eldamar.lan (c-82-192-242-114.customer.ggaweb.ch. [82.192.242.114])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d9706479b5sm241980a12.80.2025.01.07.13.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 13:17:02 -0800 (PST)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 3E5C2BE2EE7; Tue, 07 Jan 2025 22:17:01 +0100 (CET)
Date: Tue, 7 Jan 2025 22:17:01 +0100
From: Salvatore Bonaccorso <carnil@debian.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Benjamin Coddington <bcodding@redhat.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Harald Dunkel <harald.dunkel@aixigo.com>,
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
	herzog@phys.ethz.ch, Martin Svec <martin.svec@zoner.cz>,
	Michael Gernoth <debian@zerfleddert.de>,
	Pellegrin Baptiste <Baptiste.Pellegrin@ac-grenoble.fr>
Subject: Re: nfsd blocks indefinitely in nfsd4_destroy_session
Message-ID: <Z32ZzQiKfEeVoyfU@eldamar.lan>
References: <4c3080af-eec7-4af5-8b0d-c35ac98ec074@aixigo.com>
 <C1CE3A96-599C-4D73-BCC0-3587EC68FCB0@oracle.com>
 <Z2vNQ6HXfG_LqBQc@eldamar.lan>
 <ecdae86c-2954-4aca-bf1c-f95408ad0ad4@oracle.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ecdae86c-2954-4aca-bf1c-f95408ad0ad4@oracle.com>

Hi Chuck,

Thanks for your time on this, much appreciated.

On Wed, Jan 01, 2025 at 02:24:50PM -0500, Chuck Lever wrote:
> On 12/25/24 4:15 AM, Salvatore Bonaccorso wrote:
> > Hi Chuck, hi all,
> > 
> > [it was not ideal to pick one of the message for this followup, let me
> > know if you want a complete new thread, adding as well Benjamin and
> > Trond as they are involved in one mentioned patch]
> > 
> > On Mon, Jun 17, 2024 at 02:31:54PM +0000, Chuck Lever III wrote:
> > > 
> > > 
> > > > On Jun 17, 2024, at 2:55 AM, Harald Dunkel <harald.dunkel@aixigo.com> wrote:
> > > > 
> > > > Hi folks,
> > > > 
> > > > what would be the reason for nfsd getting stuck somehow and becoming
> > > > an unkillable process? See
> > > > 
> > > > - https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1071562
> > > > - https://bugs.launchpad.net/ubuntu/+source/nfs-utils/+bug/2062568
> > > > 
> > > > Doesn't this mean that something inside the kernel gets stuck as
> > > > well? Seems odd to me.
> > > 
> > > I'm not familiar with the Debian or Ubuntu kernel packages. Can
> > > the kernel release numbers be translated to LTS kernel releases
> > > please? Need both "last known working" and "first broken" releases.
> > > 
> > > This:
> > > 
> > > [ 6596.911785] RPC: Could not send backchannel reply error: -110
> > > [ 6596.972490] RPC: Could not send backchannel reply error: -110
> > > [ 6837.281307] RPC: Could not send backchannel reply error: -110
> > > 
> > > is a known set of client backchannel bugs. Knowing the LTS kernel
> > > releases (see above) will help us figure out what needs to be
> > > backported to the LTS kernels kernels in question.
> > > 
> > > This:
> > > 
> > > [11183.290619] wait_for_completion+0x88/0x150
> > > [11183.290623] __flush_workqueue+0x140/0x3e0
> > > [11183.290629] nfsd4_probe_callback_sync+0x1a/0x30 [nfsd]
> > > [11183.290689] nfsd4_destroy_session+0x186/0x260 [nfsd]
> > > 
> > > is probably related to the backchannel errors on the client, but
> > > client bugs shouldn't cause the server to hang like this. We
> > > might be able to say more if you can provide the kernel release
> > > translations (see above).
> > 
> > In Debian we hstill have the bug #1071562 open and one person notified
> > mye offlist that it appears that the issue get more frequent since
> > they updated on NFS client side from Ubuntu 20.04 to Debian bookworm
> > with a 6.1.y based kernel).
> > 
> > Some people around those issues, seem to claim that the change
> > mentioned in
> > https://lists.proxmox.com/pipermail/pve-devel/2024-July/064614.html
> > would fix the issue, which is as well backchannel related.
> > 
> > This is upstream: 6ddc9deacc13 ("SUNRPC: Fix backchannel reply,
> > again"). While this commit fixes 57331a59ac0d ("NFSv4.1: Use the
> > nfs_client's rpc timeouts for backchannel") this is not something
> > which goes back to 6.1.y, could it be possible that hte backchannel
> > refactoring and this final fix indeeds fixes the issue?
> > 
> > As people report it is not easily reproducible, so this makes it
> > harder to identify fixes correctly.
> > 
> > I gave a (short) stance on trying to backport commits up to
> > 6ddc9deacc13 ("SUNRPC: Fix backchannel reply, again") but this quickly
> > seems to indicate it is probably still not the right thing for
> > backporting to the older stable series.
> > 
> > As at least pre-requisites:
> > 
> > 2009e32997ed568a305cf9bc7bf27d22e0f6ccda
> > 4119bd0306652776cb0b7caa3aea5b2a93aecb89
> > 163cdfca341b76c958567ae0966bd3575c5c6192
> > f4afc8fead386c81fda2593ad6162271d26667f8
> > 6ed8cdf967f7e9fc96cd1c129719ef99db2f9afc
> > 57331a59ac0d680f606403eb24edd3c35aecba31
> > 
> > and still there would be conflicting codepaths (and does not seem
> > right).
> > 
> > Chuck, Benjamin, Trond, is there anything we can provive on reporters
> > side that we can try to tackle this issue better?
> 
> As I've indicated before, NFSD should not block no matter what the
> client may or may not be doing. I'd like to focus on the server first.
> 
> What is the result of:
> 
> $ cd <Bookworm's v6.1.90 kernel source >
> $ unset KBUILD_OUTPUT
> $ make -j `nproc`
> $ scripts/faddr2line \
> 	fs/nfsd/nfs4state.o \
> 	nfsd4_destroy_session+0x16d
> 
> Since this issue appeared after v6.1.1, is it possible to bisect
> between v6.1.1 and v6.1.90 ?

First please note, at least speaking of triggering the issue in
Debian, Debian has moved to 6.1.119 based kernel already (and soon in
the weekends point release move to 6.1.123).

That said, one of the users which regularly seems to be hit by the
issue was able to provide the above requested information, based for
6.1.119:

~/kernel/linux-source-6.1# make kernelversion
6.1.119
~/kernel/linux-source-6.1# scripts/faddr2line fs/nfsd/nfs4state.o nfsd4_destroy_session+0x16d
nfsd4_destroy_session+0x16d/0x250:
__list_del_entry at /root/kernel/linux-source-6.1/./include/linux/list.h:134
(inlined by) list_del at /root/kernel/linux-source-6.1/./include/linux/list.h:148
(inlined by) unhash_session at /root/kernel/linux-source-6.1/fs/nfsd/nfs4state.c:2062
(inlined by) nfsd4_destroy_session at /root/kernel/linux-source-6.1/fs/nfsd/nfs4state.c:3856

They could provide as well a decode_stacktrace output for the recent
hit (if that is helpful for you):

[Mon Jan 6 13:25:28 2025] INFO: task nfsd:55306 blocked for more than 6883 seconds.
[Mon Jan 6 13:25:28 2025]       Not tainted 6.1.0-28-amd64 #1 Debian 6.1.119-1
[Mon Jan 6 13:25:28 2025] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[Mon Jan 6 13:25:28 2025] task:nfsd            state:D stack:0     pid:55306 ppid:2      flags:0x00004000
[Mon Jan 6 13:25:28 2025] Call Trace:
[Mon Jan 6 13:25:28 2025]  <TASK>
[Mon Jan 6 13:25:28 2025] __schedule+0x34d/0x9e0
[Mon Jan 6 13:25:28 2025] schedule+0x5a/0xd0
[Mon Jan 6 13:25:28 2025] schedule_timeout+0x118/0x150
[Mon Jan 6 13:25:28 2025] wait_for_completion+0x86/0x160
[Mon Jan 6 13:25:28 2025] __flush_workqueue+0x152/0x420
[Mon Jan 6 13:25:28 2025] nfsd4_destroy_session (debian/build/build_amd64_none_amd64/include/linux/spinlock.h:351 debian/build/build_amd64_none_amd64/fs/nfsd/nfs4state.c:3861) nfsd
[Mon Jan 6 13:25:28 2025] nfsd4_proc_compound (debian/build/build_amd64_none_amd64/fs/nfsd/nfs4proc.c:2680) nfsd
[Mon Jan 6 13:25:28 2025] nfsd_dispatch (debian/build/build_amd64_none_amd64/fs/nfsd/nfssvc.c:1022) nfsd
[Mon Jan 6 13:25:28 2025] svc_process_common (debian/build/build_amd64_none_amd64/net/sunrpc/svc.c:1344) sunrpc
[Mon Jan 6 13:25:28 2025] ? svc_recv (debian/build/build_amd64_none_amd64/net/sunrpc/svc_xprt.c:897) sunrpc
[Mon Jan 6 13:25:28 2025] ? nfsd_svc (debian/build/build_amd64_none_amd64/fs/nfsd/nfssvc.c:983) nfsd
[Mon Jan 6 13:25:28 2025] ? nfsd_inet6addr_event (debian/build/build_amd64_none_amd64/fs/nfsd/nfssvc.c:922) nfsd
[Mon Jan 6 13:25:28 2025] svc_process (debian/build/build_amd64_none_amd64/net/sunrpc/svc.c:1474) sunrpc
[Mon Jan 6 13:25:28 2025] nfsd (debian/build/build_amd64_none_amd64/fs/nfsd/nfssvc.c:960) nfsd
[Mon Jan 6 13:25:28 2025] kthread+0xd7/0x100
[Mon Jan 6 13:25:28 2025] ? kthread_complete_and_exit+0x20/0x20
[Mon Jan 6 13:25:28 2025] ret_from_fork+0x1f/0x30
[Mon Jan  6 13:25:28 2025]  </TASK>

The question about bisection is actually harder, those are production
systems and I understand it's not possible to do bisect there, while
unfortunately not reprodcing the issue on "lab conditions".

Does the above give us still a clue on what you were looking for?

Regards,
Salvatore

