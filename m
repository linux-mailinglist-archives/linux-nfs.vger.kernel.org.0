Return-Path: <linux-nfs+bounces-9145-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E90FBA0A94E
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jan 2025 13:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74BC93A3B67
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jan 2025 12:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F55B1B4127;
	Sun, 12 Jan 2025 12:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jbsT8gk7"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B7E1B3925
	for <linux-nfs@vger.kernel.org>; Sun, 12 Jan 2025 12:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736685765; cv=none; b=FOL8ru+KB3wnhOk/urYPMt1coIORVQwdQzYpm/LPFeCAJpTG5GmBk1bEDwSQYcSmxp2CayRYsuNU7qnvtzDwaQh7xGpT42+mtmrbZukMCx3Ax3CnROReEJ9qtBIsyRHgueEAxQ5z3dO3Yg2pWKf8jjIsyAGZhfzegLjEU/tx0B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736685765; c=relaxed/simple;
	bh=2s+XLYLlQiGjQuRjxHrzJJslJZqs6zxgzuRBn5iAG70=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=n9hPaXXDqCN+yIJ+5SCv+MZLf/00Zq48V407qi1sZeaxQTvPiCfxENaUMwuIybXgUKtDDjdluBQq4WdqR30owUwAdlQSDWZ83vXns1nt/qs9WL50biprPFuXSB90QxWS0SoipBCCHxHUb5LGlu8hsM3/HoXlfV7R7haToBzW008=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jbsT8gk7; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d3f28881d6so5068969a12.1
        for <linux-nfs@vger.kernel.org>; Sun, 12 Jan 2025 04:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736685761; x=1737290561; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sgPmqi15jcSVtrDUGsV1kdhr5GMqW0KpVVJne1Xn/iI=;
        b=jbsT8gk7sOLQ9d8Rnt/D9+OYkhCuFAzIWvAcXbziuG9fXNJq8P7UqsfLkGuyBe43IB
         E2W3lkk/vYpNHivg5BgH8FEHhCV3GnY4HCOJ2B7OiEZV4f4/fy04t1OAiebeO+YAxpA1
         sIvPSyiGOdmyC9RfCtu4EI73rJ/eCzUBlGxIfK2XA41qHw2jajiHACSuEHw+PvPrm7Vt
         ZBQ/dasNuU/7H947tUi1cGU0KGOQbI1ByKQYM0Ob9K2c5YsuL8K0Nl/Qrso7qkgyf9nX
         wfQfJwOob5gRUsPo+mz5eAEpbPb03pqrtKyYxlmsZWUiaBZmWLedPKyPGDMSJVxYicEa
         B3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736685761; x=1737290561;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sgPmqi15jcSVtrDUGsV1kdhr5GMqW0KpVVJne1Xn/iI=;
        b=pK726rWjkLzty8o7wcJqYdOBiEhvXtX1ASG79cuqzlCyDCIXxlVogMo5xca0XNZotk
         OqpfGlhStXvtwJUIWIVM/rQdL+FEzn/6ERTh9bA/+RG0QqXBE+iqyJBpC4XfWrypHNSU
         2BYciUvWKirfiq8FDpe1JNtgQ5VzuFz8hZJq6H3FLRB0uqtlmVU38O8k5xMLX9EhjlzD
         rt3ujP/o1oenUtMS0FBhoNvw7KZnowA2rKtOwcQiSU82wdbahD9ogHJzmeAUCpDQ5t22
         DRWkF/wIJHcNdnC9wjE+qtO3AJhG/ZqS4wQWvi2UdVjS+RIrbLiGynjhNvMf1Jxfe7gZ
         mDeA==
X-Forwarded-Encrypted: i=1; AJvYcCXffegh5S0EyRvmASXARXU+4GY2FPB8F9IaTfRM5XGAAESL4B48uV3p9LxcLApmfkupCXKX2YJxEIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMTt+KOASp5WpM+HfvY5THiGlv6lDFCY6TfFpNlxAsDSbKqHP0
	4EWC/9+8pByP67Zy6z9eyi696rrrYX68k162fsfbCV5DRG8rxFZ1VAnj2ZFist1g8IYhfSz8Xnz
	vgij0NTeZgDvMYwSd+6N3d/CNdT8=
X-Gm-Gg: ASbGncurJmkkRUn5pjoY9KtvucfO7OtgZVw/0MXbk1OBrX13Zlw8wLD0RMFi0YggDYB
	HWm/0vH3m93wF+23pc70QAa372cHn1N0v+9+1jsPVYOeBzEJRXM4I
X-Google-Smtp-Source: AGHT+IHWKgGkGhJ9oqCW2GEgltwP6jkRmpVlJm+jfn2uTclAs1J4BNZY88vYojOl+QQ6ohO1eegwm49bP1XFewcg4b4=
X-Received: by 2002:a50:c8ca:0:b0:5d9:84ee:ff31 with SMTP id
 4fb4d7f45d1cf-5d984ef7409mr25607608a12.3.1736685761052; Sun, 12 Jan 2025
 04:42:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPwv0JnSQ=hsmUMy0VY-8k+dANBLNkJdFJ75q9EEE+Hj0XXB8A@mail.gmail.com>
 <d54d71f7-9bdb-49a4-8687-563558eca95e@oracle.com> <CAPwv0J=oKBnCia_mmhm-tYLPqw03jO=LxfUbShSyXFp-mKET5A@mail.gmail.com>
 <49654519-9166-4593-ac62-77400cebebb4@oracle.com>
In-Reply-To: <49654519-9166-4593-ac62-77400cebebb4@oracle.com>
From: Rik Theys <rik.theys@gmail.com>
Date: Sun, 12 Jan 2025 13:42:29 +0100
X-Gm-Features: AbW1kvaxr2JKEGmpusEcyjD0pgINI8OwRwyf-3XJ5VwM4BucfW0q5CR9Wp6xuMI
Message-ID: <CAPwv0J=ju3fZ8C_FFeDnzzKT-ppXaLCde64hQof3=g641Daudw@mail.gmail.com>
Subject: Re: nfsd4 laundromat_main hung tasks
To: Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Jan 10, 2025 at 11:07=E2=80=AFPM Chuck Lever <chuck.lever@oracle.co=
m> wrote:
>
> On 1/10/25 3:51 PM, Rik Theys wrote:
> > Hi,
> >
> > Thanks for your prompt reply.
> >
> > On Fri, Jan 10, 2025 at 9:30=E2=80=AFPM Chuck Lever <chuck.lever@oracle=
.com> wrote:
> >>
> >> On 1/10/25 2:49 PM, Rik Theys wrote:
> >>> Hi,
> >>>
> >>> Our Rocky 9 NFS server running the upstream 6.11.11 kernel is startin=
g
> >>> to log the following hung task messages:
> >>>
> >>> INFO: task kworker/u194:11:1677933 blocked for more than 215285 secon=
ds.
> >>>         Tainted: G        W   E      6.11.11-1.el9.esat.x86_64 #1
> >>> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this mess=
age.
> >>> task:kworker/u194:11 state:D stack:0     pid:1677933 tgid:1677933
> >>> ppid:2      flags:0x00004000
> >>> Workqueue: nfsd4 laundromat_main [nfsd]
> >>> Call Trace:
> >>>    <TASK>
> >>>    __schedule+0x21c/0x5d0
> >>>    ? preempt_count_add+0x47/0xa0
> >>>    schedule+0x26/0xa0
> >>>    nfsd4_shutdown_callback+0xea/0x120 [nfsd]
> >>>    ? __pfx_var_wake_function+0x10/0x10
> >>>    __destroy_client+0x1f0/0x290 [nfsd]
> >>>    nfs4_process_client_reaplist+0xa1/0x110 [nfsd]
> >>>    nfs4_laundromat+0x126/0x7a0 [nfsd]
> >>>    ? _raw_spin_unlock_irqrestore+0x23/0x40
> >>>    laundromat_main+0x16/0x40 [nfsd]
> >>>    process_one_work+0x179/0x390
> >>>    worker_thread+0x239/0x340
> >>>    ? __pfx_worker_thread+0x10/0x10
> >>>    kthread+0xdb/0x110
> >>>    ? __pfx_kthread+0x10/0x10
> >>>    ret_from_fork+0x2d/0x50
> >>>    ? __pfx_kthread+0x10/0x10
> >>>    ret_from_fork_asm+0x1a/0x30
> >>>    </TASK>
> >>>
> >>> If I read this correctly, it seems to be blocked on a callback
> >>> operation during shutdown of a client connection?
> >>>
> >>> Is this a known issue that may be fixed in the 6.12.x kernel? Could
> >>> the following commit be relevant?
> >>
> >> It is a known issue that we're just beginning to work. It's not
> >> addressed in any kernel at the moment.
> >>
> >>
> >>> 8dd91e8d31febf4d9cca3ae1bb4771d33ae7ee5a    nfsd: fix race between
> >>> laundromat and free_stateid
> >>>
> >>> If I increase the hung_task_warnings sysctl and wait a few minutes,
> >>> the hung task message appears again, so the issue is still present on
> >>> the system. How can I debug which client is causing this issue?
> >>>
> >>> Is there any other information I can provide?
> >>
> >> Yes. We badly need a simple reproducer for this issue so that we
> >> can test and confirm that it is fixed before requesting that any
> >> fix is merged.
> >
> > Unfortunately, we've been unable to reliably reproduce the issue on
> > our test systems. Sometimes the server works fine for weeks, and
> > sometimes these (or other) issues pop up within hours. Similar to the
> > users from the mentioned thread, we let a few hundred engineers and
> > students loose. Our clients are both EL8/9 based, and also Fedora 41,
> > and they (auto)mount home directories from the NFS server. So clients
> > frequently mount and unmount file systems, students uncleanly shut
> > down systems,...
> >
> > We switched to the mainline kernel in the hope this would include a
> > fix for the issue.
> >
> > Are there any debugging commands we can run once the issue happens
> > that can help to determine the cause of this issue?
>
> Once the issue happens, the precipitating bug has already done its
> damage, so at that point it is too late.
>
> If you can start a trace command on the server before clients mount
> it, try this:
>
>    # trace-cmd record -e nfsd:nfsd_cb_\*
>
> After the issue has occurred, wait a few minutes then ^C this command
> and send me the trace.dat.
>
I can create a systemd unit to start this command when the system
boots and stop it when the issue happens.

What is the expected performance impact of keeping this tracing
running? Is there an easy way to rotate the trace.dat file as I assume
it will grow quite large?

> The current theory is that deleg_reaper() is running concurrently with
> the client's DESTROY_SESSION request, and that leaves callback RPCs
> outstanding when the callback RPC client is destroyed. Session shutdown
> then hangs waiting for a completion that will never fire.

Would it be possible to capture this using a bpftrace script? If so,
which events would be interesting to capture to confirm this theory?

Is there an easy way to forcefully trigger the deleg_reaper to run so
we can try running it in a loop and then reboot/unmount the client in
an attempt to trigger the issue?


>
> If your server runs chronically short on physical memory, that might
> be a trigger.

Before the server was upgraded to EL9, it ran CentOS 7 for 5 years
without any issue and we never experienced any physical memory
shortage.  Why does the system think it's running low on memory and
needs to send the RECALL_ANY callbacks? It never did in the past and
the system seemed to do fine. Is there a way to turn off the
RECALL_ANY callbacks (at runtime)?

>
>
> >> An environment where we can test patches against the upstream
> >> kernel would also be welcome.

Our current plan is to run the 6.12 kernel as this is an LTS kernel.
If there are patches for this kernel version we can try, we may be
able to apply them. But we can't reboot the system every few days as
hundreds of people depend on it. It can also take quite some time to
actually trigger it (or assume it was fixed by a patch).

Regards,
Rik

> >>
> >>
> >>> Could this be related to the following thread:
> >>> https://lore.kernel.org/linux-nfs/Z2vNQ6HXfG_LqBQc@eldamar.lan/T/#u ?
> >>
> >> Yes.
> >>
> >>
> >>> I don't know if this is relevant but I've noticed that some clients
> >>> have multiple entries in the /proc/fs/nfsd/clients directory, so I
> >>> assume these clients are not cleaned up correctly?
> >
> > You don't think this is relevant for this issue? Is this normal?
>
> It might be a bug, but I can't say whether it's related.
>
>
> >>> For example:
> >>>
> >>> clientid: 0x6d077c99675df2b3
> >>> address: "10.87.29.32:864"
> >>> status: confirmed
> >>> seconds from last renew: 0
> >>> name: "Linux NFSv4.2 betelgeuse.esat.kuleuven.be"
> >>> minor version: 2
> >>> Implementation domain: "kernel.org"
> >>> Implementation name: "Linux 4.18.0-553.32.1.el8_10.x86_64 #1 SMP Wed
> >>> Dec 11 16:33:48 UTC 2024 x86_64"
> >>> Implementation time: [0, 0]
> >>> callback state: UP
> >>> callback address: 10.87.29.32:0
> >>> admin-revoked states: 0
> >>> ***
> >>> clientid: 0x6d0596d0675df2b3
> >>> address: "10.87.29.32:864"
> >>> status: courtesy
> >>> seconds from last renew: 2288446
> >>> name: "Linux NFSv4.2 betelgeuse.esat.kuleuven.be"
> >>> minor version: 2
> >>> Implementation domain: "kernel.org"
> >>> Implementation name: "Linux 4.18.0-553.32.1.el8_10.x86_64 #1 SMP Wed
> >>> Dec 11 16:33:48 UTC 2024 x86_64"
> >>> Implementation time: [0, 0]
> >>> callback state: UP
> >>> callback address: 10.87.29.32:0
> >>> admin-revoked states: 0
> >>>
> >>> The first one has status confirmed and the second one "courtesy" with
> >>> a high "seconds from last renew". The address and port matches for
> >>> both client entries and the callback state is both UP.
> >>>
> >>> For another client, there's a different output:
> >>>
> >>> clientid: 0x6d078a79675df2b3
> >>> address: "10.33.130.34:864"
> >>> status: unconfirmed
> >>> seconds from last renew: 158910
> >>> name: "Linux NFSv4.2 bujarski.esat.kuleuven.be"
> >>> minor version: 2
> >>> Implementation domain: "kernel.org"
> >>> Implementation name: "Linux 5.14.0-503.19.1.el9_5.x86_64 #1 SMP
> >>> PREEMPT_DYNAMIC Thu Dec 19 12:55:03 UTC 2024 x86_64"
> >>> Implementation time: [0, 0]
> >>> callback state: UNKNOWN
> >>> callback address: (einval)
> >>> admin-revoked states: 0
> >>> ***
> >>> clientid: 0x6d078a7a675df2b3
> >>> address: "10.33.130.34:864"
> >>> status: confirmed
> >>> seconds from last renew: 2
> >>> name: "Linux NFSv4.2 bujarski.esat.kuleuven.be"
> >>> minor version: 2
> >>> Implementation domain: "kernel.org"
> >>> Implementation name: "Linux 5.14.0-503.19.1.el9_5.x86_64 #1 SMP
> >>> PREEMPT_DYNAMIC Thu Dec 19 12:55:03 UTC 2024 x86_64"
> >>> Implementation time: [0, 0]
> >>> callback state: UP
> >>> callback address: 10.33.130.34:0
> >>> admin-revoked states: 0
> >>>
> >>>
> >>> Here the first status is unconfirmed and the callback state is UNKNOW=
N.
> >>>
> >>> The clients are Rocky 8, Rocky 9 and Fedora 41 clients.
> >>>
> >>> Regards,
> >>>
> >>> Rik
> >>>
> >>
> >>
> >> --
> >> Chuck Lever
> >
>
>
> --
> Chuck Lever



--=20

Rik

