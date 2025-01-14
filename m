Return-Path: <linux-nfs+bounces-9199-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DD4FA10AD8
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jan 2025 16:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D622162E08
	for <lists+linux-nfs@lfdr.de>; Tue, 14 Jan 2025 15:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9A3232424;
	Tue, 14 Jan 2025 15:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gkbyz9hJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7C5232422
	for <linux-nfs@vger.kernel.org>; Tue, 14 Jan 2025 15:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736868659; cv=none; b=iTrTPT/RhE3+VkKzNaCbJrEtfw3D5yieYyfr2qbxzaLY1Vh3ylhmThQshot2wJJZfTSpDFqbD4okNHVrceFMbvml2+6IUereJhpjAFFWs0k7+9+Ilxdq/1vzMBeM3AwGuGZVpzqderqNgT9wlq5tEnjd7NBDBovaBbGPfCvgkMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736868659; c=relaxed/simple;
	bh=jqD0x3WtpuCNtWhiFsZYn4n+8ZKc54w+ePsL/2KfNEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SZvHG2+zUgYQjS1EJwE4dtkosekR8pXvjyc/uwLcrGjnWLUlWB42OLUmxtvkIP/ruLhcjh7PuDJkqlPvDqCefDV7amNgPP/OXJCwKf4gHQAIwwyjGeaVqIFhfpZb+0t3xRtfeZQWDMovceLqFJ/BRz1KuZcGXPwh8qc5pFC2c8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gkbyz9hJ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d41848901bso3439740a12.0
        for <linux-nfs@vger.kernel.org>; Tue, 14 Jan 2025 07:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736868656; x=1737473456; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P461tIUJzrGsONM43Po1HEfvGYmn5Uzb2u7rf1sB+HY=;
        b=Gkbyz9hJueMLYA1GLCZ13gJlwruwalDXCQkWkKcs8i5xtHIjLboAlIj/ZUqGK9XXzh
         TvjYpAn6l9ySo/jxTLN/b9XE+lCxo4280+odAM5marQfm3Oaq8UaGj7a0NapcPlvQQtl
         uH7LMNAuNrNSKSBL95f4Rv+mF3e54FDMIABmPXeiYOHL1te63kL6EtQSaJwfx4oe3gGh
         aMcOyCBImht5hzyWqTyDrb8lnmoOjO2wjxlwjvq4wFyN/2xGBO4KWRZ6S9sDQLXQtJLL
         ZGXOlJ4DFlNwx6vGJ3tSHC23BtB0pfGAjGYW4Iq2LTN203L5mkPeKUFYiKMM1g3W5Z3C
         vHWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736868656; x=1737473456;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P461tIUJzrGsONM43Po1HEfvGYmn5Uzb2u7rf1sB+HY=;
        b=D2i8f4+6kr6d76RksbDU6hm8w00NA3tk9oMQLONA7cxLEK8eLCEnGJt7MDmNX9qg6N
         Jv7ubgYYiWdoMXMoinGE3eKf6Ap53d7VgNIzVUfqq0A8FzUvpVHRU+go5iErVqfQj0FU
         e07FF1HJ6wP/g2e9VUJenhiZWjVZc+VGn7JOvIJ9Sjlf99AL8G5AmD7Q7LVlUBxe0a1J
         i44Bv8KdE0EhiKlUxS3qJjkOet5FNUXWW/e8mRMIOIUtKWDKOUZ0iw/px05nW4wGbBeE
         0lmrQjoSPfmS9wQ9Lf6S7nAOKgDypSDthnbmyNtCIgL6D7EuN0lzH674lCwJtBqKgoUR
         TAug==
X-Forwarded-Encrypted: i=1; AJvYcCUmkOOOeiY2PABfdhYphbZByZ1WmSM23FsOQsDg3AvuIE14Uuh1Dx4OT/id4NNy2sO8ZxT5LWTfSdg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa+WKTv5MO4fFjFEZqAfOMG0STgSSCXtNiDPa6iqqY3fCjSjMb
	XOmV5eNa2JY782dCwUz+vNEJo3k49fp0LACESZ8jjopjV/7fe4GVuk3ISvCGQ7jdqsSUdzDsrI5
	bMcKep76JuCqr/nC7SAGi5X3/HII=
X-Gm-Gg: ASbGnctxalNOgo6j8mSprKlSLcO7W61+stUFbZBXya5Cv5KjEMhQzsr6pKnzSa3FrSQ
	ClX1+mfdRI2diJdviLxS5vNgLVaT85AnN9Ee6/jbx
X-Google-Smtp-Source: AGHT+IF2vyeLciT7GPLwKqv/v5wLZL76zPhz+wCzWI+yT9XH3RcYmBqBMN7Yxm3ICKeB7Aa38vu8jc7DpBzV9+T0Soc=
X-Received: by 2002:a05:6402:4315:b0:5d9:f8d3:6e62 with SMTP id
 4fb4d7f45d1cf-5d9f8d37133mr2711828a12.12.1736868655590; Tue, 14 Jan 2025
 07:30:55 -0800 (PST)
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
 <75633e31-53ae-4525-ae84-1400ae802359@oracle.com>
In-Reply-To: <75633e31-53ae-4525-ae84-1400ae802359@oracle.com>
From: Rik Theys <rik.theys@gmail.com>
Date: Tue, 14 Jan 2025 16:30:44 +0100
X-Gm-Features: AbW1kvZ_HEncYvMm4foGYIBWN5tGXf9H6PFC9LrDPNgiSE5Xgo-mO4eyadkoI5o
Message-ID: <CAPwv0Jk1UaHqNX27AtR+sPrCdVbckpR5ayQ-u+kZ=w3C+sOsgQ@mail.gmail.com>
Subject: Re: nfsd4 laundromat_main hung tasks
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Christian Herzog <herzog@phys.ethz.ch>, Salvatore Bonaccorso <carnil@debian.org>, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Jan 14, 2025 at 3:51=E2=80=AFPM Chuck Lever <chuck.lever@oracle.com=
> wrote:
>
> On 1/14/25 3:23 AM, Rik Theys wrote:
> > Hi,
> >
> > On Mon, Jan 13, 2025 at 11:12=E2=80=AFPM Chuck Lever <chuck.lever@oracl=
e.com> wrote:
> >>
> >> On 1/12/25 7:42 AM, Rik Theys wrote:
> >>> On Fri, Jan 10, 2025 at 11:07=E2=80=AFPM Chuck Lever <chuck.lever@ora=
cle.com> wrote:
> >>>>
> >>>> On 1/10/25 3:51 PM, Rik Theys wrote:
> >>>>> Are there any debugging commands we can run once the issue happens
> >>>>> that can help to determine the cause of this issue?
> >>>>
> >>>> Once the issue happens, the precipitating bug has already done its
> >>>> damage, so at that point it is too late.
> >>
> >> I've studied the code and bug reports a bit. I see one intriguing
> >> mention in comment #5:
> >>
> >> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1071562#5
> >>
> >> /proc/130/stack:
> >> [<0>] rpc_shutdown_client+0xf2/0x150 [sunrpc]
> >> [<0>] nfsd4_process_cb_update+0x4c/0x270 [nfsd]
> >> [<0>] nfsd4_run_cb_work+0x9f/0x150 [nfsd]
> >> [<0>] process_one_work+0x1c7/0x380
> >> [<0>] worker_thread+0x4d/0x380
> >> [<0>] kthread+0xda/0x100
> >> [<0>] ret_from_fork+0x22/0x30
> >>
> >> This tells me that the active item on the callback_wq is waiting for t=
he
> >> backchannel RPC client to shut down. This is probably the proximal cau=
se
> >> of the callback workqueue stall.
> >>
> >> rpc_shutdown_client() is waiting for the client's cl_tasks to become
> >> empty. Typically this is a short wait. But here, there's one or more R=
PC
> >> requests that are not completing.
> >>
> >> Please issue these two commands on your server once it gets into the
> >> hung state:
> >>
> >> # rpcdebug -m rpc -c
> >> # echo t > /proc/sysrq-trigger
> >
> > There were no rpcdebug entries configured, so I don't think the first
> > command did much.
> >
> > You can find the output from the second command in attach.
>
> I don't see any output for "echo t > /proc/sysrq-trigger" here. What I
> do see is a large number of OOM-killer notices. So, your server is out
> of memory. But I think this is due to a memory leak bug, probably this
> one:

I'm confused. Where do you see the OOM-killer notices in the log I provided=
?

The first lines of the file is after increasing the hung_task_warnings
and waiting a few minutes. This triggered the hun task on the nfsd4
laundromat_main workqueue:

Workqueue: nfsd4 laundromat_main [nfsd]
Jan 14 09:06:45 kwak.esat.kuleuven.be kernel: Call Trace:

Then I executed the commands you provided. Are the lines after the

Jan 14 09:07:00 kwak.esat.kuleuven.be kernel: sysrq: Show State

Line not the output you're looking for?

Regards,
Rik

>
>     https://bugzilla.kernel.org/show_bug.cgi?id=3D219535
>
> So that explains the source of the frequent deleg_reaper() calls on your
> system; it's the shrinker. (Note these calls are not the actual problem.
> The real bug is somewhere in the callback code, but frequent callbacks
> are making it easy to hit the callback bug).
>
> Please try again, but wait until you see "INFO: task nfsd:XXXX blocked
> for more than 120 seconds." in the journal before issuing the rpcdebug
> and "echo t" commands.
>
>
> > Regards,
> > Rik
> >
> >>
> >> Then gift-wrap the server's system journal and send it to me. I need t=
o
> >> see only the output from these two commands, so if you want to
> >> anonymize the journal and truncate it to just the day of the failure,
> >> I think that should be fine.
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

