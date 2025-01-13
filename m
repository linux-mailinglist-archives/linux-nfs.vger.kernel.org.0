Return-Path: <linux-nfs+bounces-9155-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25C0AA0B6FD
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 13:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E767E3A375C
	for <lists+linux-nfs@lfdr.de>; Mon, 13 Jan 2025 12:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6659622AE7B;
	Mon, 13 Jan 2025 12:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvCzjAda"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5891BEF7A
	for <linux-nfs@vger.kernel.org>; Mon, 13 Jan 2025 12:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736771432; cv=none; b=gcFvpgHaIY8ckK4SxVRcuXDOKnG9nvdkfDFhkyXTWDLDUHUISGwoBewXNoh2izSDlVtvAl3VYb7FbZK9zC0QteWjZf2BNjaQyboMm766mu5D+p5aj4DJbb2O+ffjxC59wJy8sD+fNO35qen+caGZz16niQ2IMqczpsUsTaDqlEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736771432; c=relaxed/simple;
	bh=luJk1Glw8Fce36tE+Gk4gPmvIEpPqImQDIFnRJ7p32Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qq+a2DOW/dfSqpSNixySyZB3RsYJBbE1qtX06Yb0H6cwUhn3YsmWIDCvaTB7fJAdW9duBCqdjSiJjhlvJEp0F7q7jc01Q2VZudWaq2doldMHAbEUpVOXdazx64wpkp6nKg6kZmAVHl9Z3RSFd9B9poeP64BtAVxgF6bwcosAINw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IvCzjAda; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d90a5581fcso7118843a12.1
        for <linux-nfs@vger.kernel.org>; Mon, 13 Jan 2025 04:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736771428; x=1737376228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KugaIDcnl9/pyX7Gc5nqBp2entqxZORVfGMf0jmmSlc=;
        b=IvCzjAdaRTgTCB0auc6PXiGN+r0npLgtrWlZ5lJj2j53pkRLUnVUVwyhYp9r7HjBvh
         6Grszs+evo6tdrWNVtMM0uf4DDsjLpX71CdstoI0JfcAVF94xf7T1zIGlXSsxEL9ET1H
         gEeBzz5iW9B6VbrkDlsHIE7eEIebGJJCc8EFgMa4mSjOf8Zvq6/TT1b7qBkysGzr5M6b
         V6eIV/vb4oLI4eyUWQcB2q3zXotZfWfqelzYoTKoNk4fZOclRZBp0BB6Gam5rruaut5A
         rq26Cn2JiWfL2ZRnVZBBLnsQ93/0tsLst1hZlJHBj2GGmknNmrwxGmf8sjQzpKqYw7+z
         i5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736771428; x=1737376228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KugaIDcnl9/pyX7Gc5nqBp2entqxZORVfGMf0jmmSlc=;
        b=YPTpq3BWyrWOEEg+ymTSr2/jmFj7SCAP3RO3lOOsQFMdvbge6GK6WxS00lniSR33OT
         ggJEdT+UjPasJMMKkYLqu6Qc+/wbTN41TSfrqvDbBf7PWOkQmYoLzAI5ndSJPgWb63ug
         n88fQjtmWMhVdDL8mBVprrt2zBKwBhbom1Tddf3LAyyDoHXzb4A34O1uyo3DBfDeDniI
         mVmXrRUVtFekX3uUnGZPDdgl8ANFOaHy2zhbOxMLppIVBBef4PiSuXqyyTl0QXLUx/RK
         3kfh+oom7/XEeNDnWA26gxpkG4kxAih8TeN1/avWAbKq1cE6rC3VrmRt020b23L4+iAq
         jPkA==
X-Gm-Message-State: AOJu0YzHnyK19Oic9+1nj8gdlroWSdr//6z0wMD8Yrd1fRPTQAwS/6UV
	ej3SQN9CQzn1255FlgWnaDkeScmnTIe21Ly81FZ8wmFttyXb9f0rkIQIGVWjgRjsqh8jYtXfVow
	tAPQotzwl1YUZ7M70rz9fGXtD4r5BPSNANV4=
X-Gm-Gg: ASbGncv0CxnDxB1bjhOJWbbxCOv/Wp7dunJHy+kFqQRRubMm0t7EPmCmgbHw8krztkm
	+Zrl6rSs7PjcumDeAbOUTQ+Zno4eaCygfp7ULchfQ
X-Google-Smtp-Source: AGHT+IEjWcxWzdAQ0J2fWg1fXfS0qLCXNF+Sfn+8dE3uUq9d/v7FJ8NcDV8MDHnVpyUOgq93ZjBxezKATHprH8kssqA=
X-Received: by 2002:a05:6402:26d2:b0:5d2:2768:4ee9 with SMTP id
 4fb4d7f45d1cf-5d972e15c99mr19812784a12.15.1736771427625; Mon, 13 Jan 2025
 04:30:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPwv0JnSQ=hsmUMy0VY-8k+dANBLNkJdFJ75q9EEE+Hj0XXB8A@mail.gmail.com>
 <d54d71f7-9bdb-49a4-8687-563558eca95e@oracle.com> <CAPwv0J=oKBnCia_mmhm-tYLPqw03jO=LxfUbShSyXFp-mKET5A@mail.gmail.com>
 <49654519-9166-4593-ac62-77400cebebb4@oracle.com> <CAPwv0J=ju3fZ8C_FFeDnzzKT-ppXaLCde64hQof3=g641Daudw@mail.gmail.com>
 <365e7037-733b-40d7-8046-b19ef3d803a8@oracle.com>
In-Reply-To: <365e7037-733b-40d7-8046-b19ef3d803a8@oracle.com>
From: Rik Theys <rik.theys@gmail.com>
Date: Mon, 13 Jan 2025 13:30:16 +0100
X-Gm-Features: AbW1kvZA6M7EZUiWhFZyEv58VS71EcnN6UVzeosFaGBCTe-jWF4C_ZROh34XRXU
Message-ID: <CAPwv0JmJErKaquZMApyUkpkFn9_x6C+32Dcfxeg0a4-=iR9wEQ@mail.gmail.com>
Subject: Re: nfsd4 laundromat_main hung tasks
To: Chuck Lever <chuck.lever@oracle.com>
Cc: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jan 12, 2025 at 7:57=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On 1/12/25 7:42 AM, Rik Theys wrote:
> > Hi,
> >
> > On Fri, Jan 10, 2025 at 11:07=E2=80=AFPM Chuck Lever <chuck.lever@oracl=
e.com> wrote:
> >>
> >> On 1/10/25 3:51 PM, Rik Theys wrote:
> >>> Hi,
> >>>
> >>> Thanks for your prompt reply.
> >>>
> >>> On Fri, Jan 10, 2025 at 9:30=E2=80=AFPM Chuck Lever <chuck.lever@orac=
le.com> wrote:
> >>>>
> >>>> On 1/10/25 2:49 PM, Rik Theys wrote:
> >>>>> Hi,
> >>>>>
> >>>>> Our Rocky 9 NFS server running the upstream 6.11.11 kernel is start=
ing
> >>>>> to log the following hung task messages:
> >>>>>
> >>>>> INFO: task kworker/u194:11:1677933 blocked for more than 215285 sec=
onds.
> >>>>>          Tainted: G        W   E      6.11.11-1.el9.esat.x86_64 #1
> >>>>> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this me=
ssage.
> >>>>> task:kworker/u194:11 state:D stack:0     pid:1677933 tgid:1677933
> >>>>> ppid:2      flags:0x00004000
> >>>>> Workqueue: nfsd4 laundromat_main [nfsd]
> >>>>> Call Trace:
> >>>>>     <TASK>
> >>>>>     __schedule+0x21c/0x5d0
> >>>>>     ? preempt_count_add+0x47/0xa0
> >>>>>     schedule+0x26/0xa0
> >>>>>     nfsd4_shutdown_callback+0xea/0x120 [nfsd]
> >>>>>     ? __pfx_var_wake_function+0x10/0x10
> >>>>>     __destroy_client+0x1f0/0x290 [nfsd]
> >>>>>     nfs4_process_client_reaplist+0xa1/0x110 [nfsd]
> >>>>>     nfs4_laundromat+0x126/0x7a0 [nfsd]
> >>>>>     ? _raw_spin_unlock_irqrestore+0x23/0x40
> >>>>>     laundromat_main+0x16/0x40 [nfsd]
> >>>>>     process_one_work+0x179/0x390
> >>>>>     worker_thread+0x239/0x340
> >>>>>     ? __pfx_worker_thread+0x10/0x10
> >>>>>     kthread+0xdb/0x110
> >>>>>     ? __pfx_kthread+0x10/0x10
> >>>>>     ret_from_fork+0x2d/0x50
> >>>>>     ? __pfx_kthread+0x10/0x10
> >>>>>     ret_from_fork_asm+0x1a/0x30
> >>>>>     </TASK>
> >>>>>
> >>>>> If I read this correctly, it seems to be blocked on a callback
> >>>>> operation during shutdown of a client connection?
> >>>>>
> >>>>> Is this a known issue that may be fixed in the 6.12.x kernel? Could
> >>>>> the following commit be relevant?
> >>>>
> >>>> It is a known issue that we're just beginning to work. It's not
> >>>> addressed in any kernel at the moment.
> >>>>
> >>>>
> >>>>> 8dd91e8d31febf4d9cca3ae1bb4771d33ae7ee5a    nfsd: fix race between
> >>>>> laundromat and free_stateid
> >>>>>
> >>>>> If I increase the hung_task_warnings sysctl and wait a few minutes,
> >>>>> the hung task message appears again, so the issue is still present =
on
> >>>>> the system. How can I debug which client is causing this issue?
> >>>>>
> >>>>> Is there any other information I can provide?
> >>>>
> >>>> Yes. We badly need a simple reproducer for this issue so that we
> >>>> can test and confirm that it is fixed before requesting that any
> >>>> fix is merged.
> >>>
> >>> Unfortunately, we've been unable to reliably reproduce the issue on
> >>> our test systems. Sometimes the server works fine for weeks, and
> >>> sometimes these (or other) issues pop up within hours. Similar to the
> >>> users from the mentioned thread, we let a few hundred engineers and
> >>> students loose. Our clients are both EL8/9 based, and also Fedora 41,
> >>> and they (auto)mount home directories from the NFS server. So clients
> >>> frequently mount and unmount file systems, students uncleanly shut
> >>> down systems,...
> >>>
> >>> We switched to the mainline kernel in the hope this would include a
> >>> fix for the issue.
> >>>
> >>> Are there any debugging commands we can run once the issue happens
> >>> that can help to determine the cause of this issue?
> >>
> >> Once the issue happens, the precipitating bug has already done its
> >> damage, so at that point it is too late.
> >>
> >> If you can start a trace command on the server before clients mount
> >> it, try this:
> >>
> >>     # trace-cmd record -e nfsd:nfsd_cb_\*
> >>
> >> After the issue has occurred, wait a few minutes then ^C this command
> >> and send me the trace.dat.
> >>
> > I can create a systemd unit to start this command when the system
> > boots and stop it when the issue happens.
>
> It would help to include "-p function -l nfsd4_destroy_session" as
> well on the trace-cmd command line so that DESTROY_SESSION operations
> are annotated in the log as well.
>
I've created a systemd unit to run trace-cmd on boot. I've started it
(before rebooting the system) to see how much disk space would be in
use by having it running.
When I stopped it and ran "trace-cmd report", it showed a lot of
[FAILED TO PARSE] lines, such as:

            nfsd-6279  [035] 2560643.942059: nfsd_cb_queue:
[FAILED TO PARSE] cl_boot=3D1734210227 cl_id=3D1829245597
cb=3D0xffff94488e9c8d90 need_restart=3D0 addr=3DARRAY[]
  kworker/u192:4-4169949 [032] 2560643.942079: nfsd_cb_start:
[FAILED TO PARSE] state=3D0x1 cl_boot=3D1734210227 cl_id=3D1829245597
addr=3DARRAY[]
  kworker/u192:4-4169949 [032] 2560643.942081: nfsd_cb_bc_update:
[FAILED TO PARSE] cl_boot=3D1734210227 cl_id=3D1829245597
cb=3D0xffff94488e9c8d90 need_restart=3D0 addr=3DARRAY[]
  kworker/u192:4-4169949 [032] 2560643.942082: nfsd_cb_destroy:
[FAILED TO PARSE] cl_boot=3D1734210227 cl_id=3D1829245597
cb=3D0xffff94488e9c8d90 need_restart=3D0 addr=3DARRAY[]
            nfsd-6328  [028] 2560643.942503: nfsd_cb_probe:
[FAILED TO PARSE] state=3D0x1 cl_boot=3D1734210227 cl_id=3D1829245598
addr=3DARRAY[02, 00, 00, 00, 0a, 57, 18, a4, 00, 00, 00, 00, 00, 00, 00,
00]
            nfsd-6328  [028] 2560643.942504: nfsd_cb_queue:
[FAILED TO PARSE] cl_boot=3D1734210227 cl_id=3D1829245598
cb=3D0xffff94488e9c8300 need_restart=3D0 addr=3DARRAY[02, 00, 00, 00, 0a,
57, 18, a4, 00, 00, 00, 00, 00, 00, 00, 00]
  kworker/u192:4-4169949 [032] 2560643.942515: nfsd_cb_start:
[FAILED TO PARSE] state=3D0x1 cl_boot=3D1734210227 cl_id=3D1829245598
addr=3DARRAY[02, 00, 00, 00, 0a, 57, 18, a4, 00, 00, 00, 00, 00, 00, 00,
00]
  kworker/u192:4-4169949 [032] 2560643.942515: nfsd_cb_bc_update:
[FAILED TO PARSE] cl_boot=3D1734210227 cl_id=3D1829245598
cb=3D0xffff94488e9c8300 need_restart=3D0 addr=3DARRAY[02, 00, 00, 00, 0a,
57, 18, a4, 00, 00, 00, 00, 00, 00, 00, 00]
  kworker/u192:4-4169949 [032] 2560643.942769: nfsd_cb_setup:
[FAILED TO PARSE] cl_boot=3D1734210227 cl_id=3D1829245598 authflavor=3D0x1
addr=3DARRAY[02, 00, 00, 00, 0a, 57, 18, a4, 00, 00, 00, 00, 00, 00, 00,
00] netid=3Dtcp
  kworker/u192:4-4169949 [032] 2560643.942770: nfsd_cb_new_state:
[FAILED TO PARSE] state=3D0x0 cl_boot=3D1734210227 cl_id=3D1829245598
addr=3DARRAY[02, 00, 00, 00, 0a, 57, 18, a4, 00, 00, 00, 00, 00, 00, 00,
00]
  kworker/u192:4-4169949 [032] 2560643.942770: nfsd_cb_destroy:
[FAILED TO PARSE] cl_boot=3D1734210227 cl_id=3D1829245598
cb=3D0xffff94488e9c8300 need_restart=3D0 addr=3DARRAY[02, 00, 00, 00, 0a,
57, 18, a4, 00, 00, 00, 00, 00, 00, 00, 00]

Is there any additional option I need to specify, or can these items be ign=
ored?

>
> > What is the expected performance impact of keeping this tracing
> > running? Is there an easy way to rotate the trace.dat file as I assume
> > it will grow quite large?
>
> Callback traffic should be light. I don't expect a huge amount of data
> will be generated unless the trace runs for weeks without incident, and
> therefore I expect any performance impact will be unnoticeable.
>
>
> >> The current theory is that deleg_reaper() is running concurrently with
> >> the client's DESTROY_SESSION request, and that leaves callback RPCs
> >> outstanding when the callback RPC client is destroyed. Session shutdow=
n
> >> then hangs waiting for a completion that will never fire.
> >
> > Would it be possible to capture this using a bpftrace script? If so,
> > which events would be interesting to capture to confirm this theory?
>
> You can capture this information however you like. I'm familiar with
> trace points, so that's the command I can give you.
>
>
> > Is there an easy way to forcefully trigger the deleg_reaper to run so
> > we can try running it in a loop and then reboot/unmount the client in
> > an attempt to trigger the issue?
>
> Reduce the server's lease time. deleg_reaper() is run during every pass
> of the server's NFSv4 state laundromat.
>
> It is also run via a shrinker. Forcing memory exhaustion might also
> result in more calls to deleg_reaper(), but that can have some less
> desirable side effects.
>
>
> >> If your server runs chronically short on physical memory, that might
> >> be a trigger.
> >
> > Before the server was upgraded to EL9, it ran CentOS 7 for 5 years
> > without any issue and we never experienced any physical memory
> > shortage.  Why does the system think it's running low on memory
>
> Different kernels have different memory requirements, different memory
> watermarks, and different bugs. Sometimes what barely fits within a
> server's RSS and throughput envelope with one kernel does not fit at
> all with another kernel.
>
> I'm trying not to make assumptions. Some folks like running NFS servers
> with less than 4GB of RAM in virtual environments.
>
> So what I'm asking is how much physical RAM is available on your server,
> and do you see other symptoms of memory shortages?

The system has 192GB ram and runs nfsd and samba. Most memory is used
for cache and buffers. There are no symptoms of memory shortage.


>
>
> > and
> > needs to send the RECALL_ANY callbacks? It never did in the past and
> > the system seemed to do fine.
>
> CB_RECALL_ANY is a new feature in recent kernels.
>
>
> > Is there a way to turn off the
> > RECALL_ANY callbacks (at runtime)?
>
> No.
>
>
> >>>> An environment where we can test patches against the upstream
> >>>> kernel would also be welcome.
> >
> > Our current plan is to run the 6.12 kernel as this is an LTS kernel.
> > If there are patches for this kernel version we can try, we may be
> > able to apply them. But we can't reboot the system every few days as
> > hundreds of people depend on it. It can also take quite some time to
> > actually trigger it (or assume it was fixed by a patch).
>
> Any code change has to go into the upstream kernel first before it is
> backported to LTS kernels.
>
> What I'm hearing is that you are not able to provide any testing for
> an upstream patch. Fair enough.

If there's a patch you can certainly let me know and we can see then
if we can try it on our system.

Regards,
Rik

>
>
> > Regards,
> > Rik
> >
> >>>>
> >>>>
> >>>>> Could this be related to the following thread:
> >>>>> https://lore.kernel.org/linux-nfs/Z2vNQ6HXfG_LqBQc@eldamar.lan/T/#u=
 ?
> >>>>
> >>>> Yes.
> >>>>
> >>>>
> >>>>> I don't know if this is relevant but I've noticed that some clients
> >>>>> have multiple entries in the /proc/fs/nfsd/clients directory, so I
> >>>>> assume these clients are not cleaned up correctly?
> >>>
> >>> You don't think this is relevant for this issue? Is this normal?
> >>
> >> It might be a bug, but I can't say whether it's related.
> >>
> >>
> >>>>> For example:
> >>>>>
> >>>>> clientid: 0x6d077c99675df2b3
> >>>>> address: "10.87.29.32:864"
> >>>>> status: confirmed
> >>>>> seconds from last renew: 0
> >>>>> name: "Linux NFSv4.2 betelgeuse.esat.kuleuven.be"
> >>>>> minor version: 2
> >>>>> Implementation domain: "kernel.org"
> >>>>> Implementation name: "Linux 4.18.0-553.32.1.el8_10.x86_64 #1 SMP We=
d
> >>>>> Dec 11 16:33:48 UTC 2024 x86_64"
> >>>>> Implementation time: [0, 0]
> >>>>> callback state: UP
> >>>>> callback address: 10.87.29.32:0
> >>>>> admin-revoked states: 0
> >>>>> ***
> >>>>> clientid: 0x6d0596d0675df2b3
> >>>>> address: "10.87.29.32:864"
> >>>>> status: courtesy
> >>>>> seconds from last renew: 2288446
> >>>>> name: "Linux NFSv4.2 betelgeuse.esat.kuleuven.be"
> >>>>> minor version: 2
> >>>>> Implementation domain: "kernel.org"
> >>>>> Implementation name: "Linux 4.18.0-553.32.1.el8_10.x86_64 #1 SMP We=
d
> >>>>> Dec 11 16:33:48 UTC 2024 x86_64"
> >>>>> Implementation time: [0, 0]
> >>>>> callback state: UP
> >>>>> callback address: 10.87.29.32:0
> >>>>> admin-revoked states: 0
> >>>>>
> >>>>> The first one has status confirmed and the second one "courtesy" wi=
th
> >>>>> a high "seconds from last renew". The address and port matches for
> >>>>> both client entries and the callback state is both UP.
> >>>>>
> >>>>> For another client, there's a different output:
> >>>>>
> >>>>> clientid: 0x6d078a79675df2b3
> >>>>> address: "10.33.130.34:864"
> >>>>> status: unconfirmed
> >>>>> seconds from last renew: 158910
> >>>>> name: "Linux NFSv4.2 bujarski.esat.kuleuven.be"
> >>>>> minor version: 2
> >>>>> Implementation domain: "kernel.org"
> >>>>> Implementation name: "Linux 5.14.0-503.19.1.el9_5.x86_64 #1 SMP
> >>>>> PREEMPT_DYNAMIC Thu Dec 19 12:55:03 UTC 2024 x86_64"
> >>>>> Implementation time: [0, 0]
> >>>>> callback state: UNKNOWN
> >>>>> callback address: (einval)
> >>>>> admin-revoked states: 0
> >>>>> ***
> >>>>> clientid: 0x6d078a7a675df2b3
> >>>>> address: "10.33.130.34:864"
> >>>>> status: confirmed
> >>>>> seconds from last renew: 2
> >>>>> name: "Linux NFSv4.2 bujarski.esat.kuleuven.be"
> >>>>> minor version: 2
> >>>>> Implementation domain: "kernel.org"
> >>>>> Implementation name: "Linux 5.14.0-503.19.1.el9_5.x86_64 #1 SMP
> >>>>> PREEMPT_DYNAMIC Thu Dec 19 12:55:03 UTC 2024 x86_64"
> >>>>> Implementation time: [0, 0]
> >>>>> callback state: UP
> >>>>> callback address: 10.33.130.34:0
> >>>>> admin-revoked states: 0
> >>>>>
> >>>>>
> >>>>> Here the first status is unconfirmed and the callback state is UNKN=
OWN.
> >>>>>
> >>>>> The clients are Rocky 8, Rocky 9 and Fedora 41 clients.
> >>>>>
> >>>>> Regards,
> >>>>>
> >>>>> Rik
> >>>>>
> >>>>
> >>>>
> >>>> --
> >>>> Chuck Lever
> >>>
> >>
> >>
> >> --
> >> Chuck Lever
> >
> >
> >
>
>
> --
> Chuck Lever



--=20

Rik

