Return-Path: <linux-nfs+bounces-9293-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB7BDA1361A
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2025 10:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 468AF7A37DC
	for <lists+linux-nfs@lfdr.de>; Thu, 16 Jan 2025 09:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1401D88AC;
	Thu, 16 Jan 2025 09:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUNKzryJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B29A1D7E5F
	for <linux-nfs@vger.kernel.org>; Thu, 16 Jan 2025 09:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737018231; cv=none; b=SzXro12Qa3Pm/jRSNEpIrPq8mFMi0Prv3sYDRePfXo2ugq8HLbRKjyGbQ8tjxDy1fcBrrHoaMUle5SsRo3/FyDZH26KJD3oeZvjUB8Ol2d0qghQDeHKRhSIfEGHAGNC9ZmTvT1f2fpzVqXDGjiCrTEgIEKTCWvpybQICqhp88c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737018231; c=relaxed/simple;
	bh=8D9yo2ZPsFhGtL2raSBn0d2Oqyrgp42i6+NDKyAjHWo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K1K01JT/sSHacs5n+ZxUi3hK2isZ43E35ReVtffB19opU1depvWnghct8H1flE+M3fQvr6Ex2UDzl5RVDJDwwMHAL38x/VD0rtAXuFEWzxxfpYAFKaiiBU0pVu27XLw2JfDh59cvZ7GRm7ugR7H959ex3X+D6RE16qPmHjK2jcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUNKzryJ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d982de9547so1377149a12.2
        for <linux-nfs@vger.kernel.org>; Thu, 16 Jan 2025 01:03:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737018227; x=1737623027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SjXpB4q2Ql2EwpkJ4g1n0VH6TrWylIqq/lgQUFxCC2Y=;
        b=BUNKzryJL4MnbEcyxMJGRWHonXjsXiAxtdPJjwVK+rOGO1rwz+Y/dYBD6jHsG0JEe0
         leUqqxGnPWY9uvUzJxfAa68AuC3xOC0+so1LcLIKOGMfz8JO/7eWM0rf5if0mlr3TFfb
         Am9vZeNmShXWTi0S40oEKZ0XcsObp9bcYK0Sd5coJm1BcqGfrXyvnqGS3Pk4NyYhF/Db
         2jPCIG4UHLVRqQsMOUoQuZZF7p4lQAc9tJ6e4tgt9noELPEVOD51Yt6QisnDICj9Wn78
         AKEOxvJ+YklKLl2wPMMF+gF47JI8UL3Ti5oLQyg8sjSVXyDPbi+ZVuN2K7GvtQ/thg77
         lzwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737018227; x=1737623027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SjXpB4q2Ql2EwpkJ4g1n0VH6TrWylIqq/lgQUFxCC2Y=;
        b=WBcpIMyASgZJUyJlmRYI9CI/8Fr/JC1nWzSmyuEAzMjXhipzho5cWKZKbLPVZZGO5S
         IlOZ1tPSeDV5QHHT2/0PGAJuiYlUVbBU9essuto0rsKaXefGNn68peadIr3qUnAUXp3V
         Y9jWBoTGPGhRbP7zVgO2cfbGSpGeD+elK34u1eBBEi3HKqCVKOLdzvUDPai/zGbp9BsO
         gnnMJs8Sgx+bx2svzNwafKvAI2I8Iv3O1fnHBFcnHYfcfEikn3gDgM2AQBLCz2hSyC67
         u6TaZ3DlwToMhGLJL+SgVDW9vRdrLFt91KGkHUqxq50X4+fHiPQ5ptQLE7foehOWWKxV
         NDXg==
X-Forwarded-Encrypted: i=1; AJvYcCWecC0aYGkFZM+i8+lpl2/ffBsTMt2KbmLhrIrRWl3+WxF1fZ455EGtyeCh3pAo0zayBZJsXgvoBec=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQJyWQUSdsJCW+JEAYTTbjJp1fgx0Yksjr8vjB1wHaJOzB08rm
	NqVsCZABQFxY7TOw1Qf8ykvBKS+f/fMUmW6TeRkvMkbyionSk/v7PwYu8G+pJnR87tDlK+iDo5K
	/aIXGPOnjHNPUf5crZ3BY3im4L84=
X-Gm-Gg: ASbGncvV4Or+2digFhrnzb1XebB6TnyDVWgb1nqT+BvQME9yEqIK6UugsqWdNUm7lIZ
	ES1ErERo/MXXweHm3wbvXes4aTU067dUjU4rUgYHQ97l08bGLpDde
X-Google-Smtp-Source: AGHT+IHPOghLcQzghWceoCztxrdimPoGa9J0qQccDj4YIyRQNY26Krd9LaLtAwtjkTyHE6g8npoEFp1LdPAWvjXUv9E=
X-Received: by 2002:a05:6402:388b:b0:5d0:e826:f10a with SMTP id
 4fb4d7f45d1cf-5d972df676fmr32729925a12.6.1737018226993; Thu, 16 Jan 2025
 01:03:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPwv0JnSQ=hsmUMy0VY-8k+dANBLNkJdFJ75q9EEE+Hj0XXB8A@mail.gmail.com>
 <d54d71f7-9bdb-49a4-8687-563558eca95e@oracle.com> <CAPwv0J=oKBnCia_mmhm-tYLPqw03jO=LxfUbShSyXFp-mKET5A@mail.gmail.com>
 <49654519-9166-4593-ac62-77400cebebb4@oracle.com> <CAPwv0J=ju3fZ8C_FFeDnzzKT-ppXaLCde64hQof3=g641Daudw@mail.gmail.com>
 <cbc55c4a-ac98-4121-b590-13f32a257d65@oracle.com> <CAPwv0JmA+29fujmmrugY0AFdtDDqjSvn6RTHzwYNR9a4skXfeQ@mail.gmail.com>
 <75633e31-53ae-4525-ae84-1400ae802359@oracle.com> <CAPwv0Jk1UaHqNX27AtR+sPrCdVbckpR5ayQ-u+kZ=w3C+sOsgQ@mail.gmail.com>
 <42da212b-071b-4c20-b7da-97ca02413c5a@oracle.com> <02d46ca4-59fc-4760-a9a0-6d8fe41df1cf@oracle.com>
In-Reply-To: <02d46ca4-59fc-4760-a9a0-6d8fe41df1cf@oracle.com>
From: Rik Theys <rik.theys@gmail.com>
Date: Thu, 16 Jan 2025 10:03:35 +0100
X-Gm-Features: AbW1kvbYcdSpv0JGfhh8gHZLLf9NL2wc-43HEQSV4IzgxMd-TcH1kVQ-gRUvExA
Message-ID: <CAPwv0JnM=Cz=sMazCSuuRbOjHURQ2bDox7F=OqQoT9DxbsaHzw@mail.gmail.com>
Subject: Re: nfsd4 laundromat_main hung tasks
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Christian Herzog <herzog@phys.ethz.ch>, Salvatore Bonaccorso <carnil@debian.org>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chuck,

On Tue, Jan 14, 2025 at 8:02=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On 1/14/25 11:10 AM, Chuck Lever wrote:
> > On 1/14/25 10:30 AM, Rik Theys wrote:
> >> Hi,
> >>
> >> On Tue, Jan 14, 2025 at 3:51=E2=80=AFPM Chuck Lever <chuck.lever@oracl=
e.com>
> >> wrote:
> >>>
> >>> On 1/14/25 3:23 AM, Rik Theys wrote:
> >>>> Hi,
> >>>>
> >>>> On Mon, Jan 13, 2025 at 11:12=E2=80=AFPM Chuck Lever
> >>>> <chuck.lever@oracle.com> wrote:
> >>>>>
> >>>>> On 1/12/25 7:42 AM, Rik Theys wrote:
> >>>>>> On Fri, Jan 10, 2025 at 11:07=E2=80=AFPM Chuck Lever
> >>>>>> <chuck.lever@oracle.com> wrote:
> >>>>>>>
> >>>>>>> On 1/10/25 3:51 PM, Rik Theys wrote:
> >>>>>>>> Are there any debugging commands we can run once the issue happe=
ns
> >>>>>>>> that can help to determine the cause of this issue?
> >>>>>>>
> >>>>>>> Once the issue happens, the precipitating bug has already done it=
s
> >>>>>>> damage, so at that point it is too late.
> >>>>>
> >>>>> I've studied the code and bug reports a bit. I see one intriguing
> >>>>> mention in comment #5:
> >>>>>
> >>>>> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1071562#5
> >>>>>
> >>>>> /proc/130/stack:
> >>>>> [<0>] rpc_shutdown_client+0xf2/0x150 [sunrpc]
> >>>>> [<0>] nfsd4_process_cb_update+0x4c/0x270 [nfsd]
> >>>>> [<0>] nfsd4_run_cb_work+0x9f/0x150 [nfsd]
> >>>>> [<0>] process_one_work+0x1c7/0x380
> >>>>> [<0>] worker_thread+0x4d/0x380
> >>>>> [<0>] kthread+0xda/0x100
> >>>>> [<0>] ret_from_fork+0x22/0x30
> >>>>>
> >>>>> This tells me that the active item on the callback_wq is waiting
> >>>>> for the
> >>>>> backchannel RPC client to shut down. This is probably the proximal
> >>>>> cause
> >>>>> of the callback workqueue stall.
> >>>>>
> >>>>> rpc_shutdown_client() is waiting for the client's cl_tasks to becom=
e
> >>>>> empty. Typically this is a short wait. But here, there's one or
> >>>>> more RPC
> >>>>> requests that are not completing.
> >>>>>
> >>>>> Please issue these two commands on your server once it gets into th=
e
> >>>>> hung state:
> >>>>>
> >>>>> # rpcdebug -m rpc -c
> >>>>> # echo t > /proc/sysrq-trigger
> >>>>
> >>>> There were no rpcdebug entries configured, so I don't think the firs=
t
> >>>> command did much.
>
> The laundromat failure mode is not blocked in rpc_shutdown_client, so
> there aren't any outstanding callback RPCs to observe.
>
> The DESTROY_SESSION failure mode is blocking on the flush_workqueue call
> in nfsd4_shutdown_callback(), while this failure mode appears to have
> passed that call and blocked on the wait for in-flight RPCs to go to
> zero (as Jeff analyzed a few days ago).

If I look at the trace, nfs4_laundromat calls
nfs4_process_client_reaplist, which calls __destroy_client at some
point.

When I look at the __destroy_client function in nfs4state.c, I see it
does a spin_lock(&state_lock) and spin_unlock(&state_lock) to perform
certain actions, but it seems the lock is not (again) acquired when
the nfsd4_shutdown_callback() function is called? According to the
comment above the nfsd4_shutdown_callback function in nfs4callback.c,
the function must be called under the state lock? Is it possible that
the function is called without this state lock? Or is the comment no
longer relevant?

Another thing I've noticed (but I'm not sure it's relevant here) is
that there's a client in /proc/nfs/nfsd/clients that has a states file
that crashes nfsdclnts as the field does not have a "superblock"
field:

# cat 8536/{info,states}
clientid: 0x6d0596d0675df2b3
address: "10.87.29.32:864"
status: courtesy
seconds from last renew: 2807740
name: "Linux NFSv4.2 betelgeuse.esat.kuleuven.be"
minor version: 2
Implementation domain: "kernel.org"
Implementation name: "Linux 4.18.0-553.32.1.el8_10.x86_64 #1 SMP Wed
Dec 11 16:33:48 UTC 2024 x86_64"
Implementation time: [0, 0]
callback state: UNKNOWN
callback address: 10.87.29.32:0
admin-revoked states: 0
- 0x00000001b3f25d67d096056d19facf00: { type: deleg, access: w }

This is one of the clients that has multiple entries in the
/proc/fs/nfsd/clients directory, but of all the clients that have
duplicate entries, this is the only one where the "broken" client is
in the "courtesy" state for a long time now. It's also the only
"broken" client that still has an entry in the states file. The others
are all in the "unconfirmed" state and the states file is empty.

Regards,
Rik





>
> Next time it happens, please collect the rpcdebug and "echo t" output as
> well as the trace-cmd output.
>
>
> >>>> You can find the output from the second command in attach.
> >>>
> >>> I don't see any output for "echo t > /proc/sysrq-trigger" here. What =
I
> >>> do see is a large number of OOM-killer notices. So, your server is ou=
t
> >>> of memory. But I think this is due to a memory leak bug, probably thi=
s
> >>> one:
> >>
> >> I'm confused. Where do you see the OOM-killer notices in the log I
> >> provided?
> >
> > Never mind: my editor opened an old file at the same time. The window
> > with your dump was on another screen.
> >
> > Looking at your journal now.
> >
> >
> >> The first lines of the file is after increasing the hung_task_warnings
> >> and waiting a few minutes. This triggered the hun task on the nfsd4
> >> laundromat_main workqueue:
> >>
> >> Workqueue: nfsd4 laundromat_main [nfsd]
> >> Jan 14 09:06:45 kwak.esat.kuleuven.be kernel: Call Trace:
> >>
> >> Then I executed the commands you provided. Are the lines after the
> >>
> >> Jan 14 09:07:00 kwak.esat.kuleuven.be kernel: sysrq: Show State
> >>
> >> Line not the output you're looking for?
> >>
> >> Regards,
> >> Rik
> >>
> >>>
> >>>      https://bugzilla.kernel.org/show_bug.cgi?id=3D219535
> >>>
> >>> So that explains the source of the frequent deleg_reaper() calls on y=
our
> >>> system; it's the shrinker. (Note these calls are not the actual probl=
em.
> >>> The real bug is somewhere in the callback code, but frequent callback=
s
> >>> are making it easy to hit the callback bug).
> >>>
> >>> Please try again, but wait until you see "INFO: task nfsd:XXXX blocke=
d
> >>> for more than 120 seconds." in the journal before issuing the rpcdebu=
g
> >>> and "echo t" commands.
> >>>
> >>>
> >>>> Regards,
> >>>> Rik
> >>>>
> >>>>>
> >>>>> Then gift-wrap the server's system journal and send it to me. I
> >>>>> need to
> >>>>> see only the output from these two commands, so if you want to
> >>>>> anonymize the journal and truncate it to just the day of the failur=
e,
> >>>>> I think that should be fine.
> >>>>>
> >>>>>
> >>>>> --
> >>>>> Chuck Lever
> >>>>
> >>>>
> >>>>
> >>>
> >>>
> >>> --
> >>> Chuck Lever
> >>
> >>
> >>
> >
> >
>
>
> --
> Chuck Lever



--=20

Rik

