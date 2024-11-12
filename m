Return-Path: <linux-nfs+bounces-7891-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8B49C4FAD
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 08:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22DD6B22C5F
	for <lists+linux-nfs@lfdr.de>; Tue, 12 Nov 2024 07:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42FA20B211;
	Tue, 12 Nov 2024 07:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="hXHqUo6Y"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AA420B20F
	for <linux-nfs@vger.kernel.org>; Tue, 12 Nov 2024 07:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731397160; cv=none; b=Sirw/Tka8uzU0zx+xXvpc9xPNoffVd2jdzp+YngUHtD4/w4HI1+Yd58kM8VZAzdPiSSO22QM0NSKZhiRvNJa5fmj970Akx3r1Uwm1mNL1p/1mgGS+fPjaBYsQbgEzxkUrHpstLuvUw37S1JNnoertYzmrcBB+pofdpYshjimYEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731397160; c=relaxed/simple;
	bh=brBHJST56CYaqnqRiBhljn11q0BksuZqYu1hezt+BIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=F/3xjqphU6goNhqdIyxxeJx7f3qB3rsdmj3biPHeHzZ82V8cE/dCgq2IniZS4WUvLiqTcrmlVa4n8aAiBWaVgAKWOkVcwL7xBs+ZeEh6gNNigzo2s7+uCpRKu179bjm5shdgwvm07c0/UH3h4r0Opb9ga2eGmIPGbfnkzP/wn7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=hXHqUo6Y; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9ed49ec0f1so906829866b.1
        for <linux-nfs@vger.kernel.org>; Mon, 11 Nov 2024 23:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1731397156; x=1732001956; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfcnEOaKbauAnD+2AGNlRSuuYiOZTGy8vLgvL8NgRZM=;
        b=hXHqUo6Y7xAr41myZfaVKyt5NSA66bcKtuB2Bu0q2CkTO2qaokJ+JiRMfHPBWMOXoq
         TgieqUNLVhWJAdPgw4TJ3ilT5ka5uqj+IsJagpLXQ3hjV6DtHCMUZUSVb42NvNpp/Ji2
         Up+8ydin8yaoaEOTByAmFgNFYe/D+jV4z2whaQkQhLEZH7DIxOSgIaaHLYg0fXtnJ3fT
         cNGPIj7KyPT6OadYPTUvAtRiA0cCLcLKC2v1TMpVBsmVZ77mTBAGVIBI1agv8jNoLVVl
         TRMW6twQXq98OMUT7dR8Xv4RuZuANa+CnEtnYiCgGVPJSO2o5TWEzNJuPqVMa02Y5xH1
         +Nkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731397156; x=1732001956;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gfcnEOaKbauAnD+2AGNlRSuuYiOZTGy8vLgvL8NgRZM=;
        b=DsatsdBJB9/I4EmBlik9al2vO2QUCDoMKpRX+aTv+QuoRpMR0SrSZ3EFyS9uLQHLuB
         hXV09E2b7pggn8x6ejd1OoubUVxS5Wrre3gth2Iy4/G0KnCFA00MLIQMKG+KfxGaKTE9
         +KKXa+agSazLSytK8j8d2h6KzpGajKyuLw5DQnBKvcuh2jsluGpLV/hIkJXLdaifPOkY
         ikYfvfrVh8zlIhL+ool5GAGX3cwkbe/gt1vbiHorEc/iy70lM61pYQ4MUC7KNecjjtr0
         CKMjTvztaHDcR2UCyRMRETh4ZLrW+D9embuHN1rriSjOSw4u9uegLRhHQdUrmptx2xLc
         kU5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWVyAlN2Te+GIsdvnvrcdZ5HuisFF2xzBxoyzM/rlnglhw92T+YmT5CkoFhIJBxoAkd+8+Gb+u5lnc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF0VjGShdh3HpN2FXsyMXrrduo8WuuFc9CBzbvCTydv3UTLDVs
	KeWi7gb4mhjFA1a3+rM9o/2o6Q+NTuZ/rtX42MGMO9ph4FLEFqEOOF/el9yt+2Jo5GdYgpbbeet
	5bgXc3SXY3vUcx6/Eq++ucpVpTt13I4N4SBZEwD8a88WWnHTqxs0=
X-Google-Smtp-Source: AGHT+IGDLlXQepJKnl19SVL5bGpUVYo9qmwPjkHvBTYefpFDgktT7J6AJaBvxOLyJLhbKETGj7/dsHkGOi1q0baPmR0=
X-Received: by 2002:a17:907:26c9:b0:a9e:d49e:c0aa with SMTP id
 a640c23a62f3a-aa1b1057df1mr183971366b.19.1731397156044; Mon, 11 Nov 2024
 23:39:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKPOu+9DyMbKLhyJb7aMLDTb=Fh0T8Teb9sjuf_pze+XWT1VaQ@mail.gmail.com>
 <CAKPOu+_XVhgg7Gq=izU9QDFyaVpZTSyNWOWLi5N8S6wSYdbf3A@mail.gmail.com>
In-Reply-To: <CAKPOu+_XVhgg7Gq=izU9QDFyaVpZTSyNWOWLi5N8S6wSYdbf3A@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Tue, 12 Nov 2024 08:39:05 +0100
Message-ID: <CAKPOu+8iNpKkduNqOg4kfbnOBren58xx5hQ78DAs5FjD+FysHA@mail.gmail.com>
Subject: Re: Oops in netfs_rreq_unlock_folios_pgpriv2
To: David Howells <dhowells@redhat.com>, netfs@lists.linux.dev, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

David,

It has been two weeks since my crash bug report. Our servers are still
crashing all the time, and instead of going back to 6.6, I have
enabled `panic_on_oops` so the servers reboot automatically, hoping
that you would come up with a fix for the netfs regression soon, but I
cannot hold this up for much longer. Please help!

(Are we really the only ones experiencing this bug?)

Max

On Wed, Oct 30, 2024 at 11:23=E2=80=AFAM Max Kellermann
<max.kellermann@ionos.com> wrote:
>
> David,
>
> Meanwhile, our servers crash many times a day due to this bug.
>
> The code was added by your commit 7b589a9b45a ("netfs: Fix handling of
> USE_PGPRIV2 and WRITE_TO_CACHE flags") after I found Ceph-related bugs
> in your commit 2ff1e97587f4 ("netfs: Replace PG_fscache by setting
> folio->private and marking dirty"). Since this fix, the Ceph problems
> were gone, but yesterday, out of the blue, the NFS-using server
> started crashing (after running stable with 6.11.5 for 5 days).
>
> We can't go back to 6.10 (EOL); the newest kernel prior to your
> refactoring was 6.9 which has been EOL since July, leaving a downgrade
> to 6.6 LTS as the only remaining option.
>
> Max
>
>
>
> On Tue, Oct 29, 2024 at 9:02=E2=80=AFAM Max Kellermann <max.kellermann@io=
nos.com> wrote:
> >
> > Hi David,
> >
> > maybe this crash is related to your recent netfs refactoring work; it i=
s on
> > a server with heavy NFS traffic (with fscache enabled). The kernel is
> > 6.11.5 plus a dozen patches that are not relevant for NFS/netfs/fscache=
.
> >
> >  BUG: unable to handle page fault for address: 0000025882015121
> >  #PF: supervisor read access in kernel mode
> >  #PF: error_code(0x0000) - not-present page
> >  PGD 0 P4D 0
> >  Oops: Oops: 0000 [#1] SMP PTI
> >  CPU: 11 UID: 0 PID: 247837 Comm: kworker/u193:32 Not tainted
> > 6.11.5-cm4all1-hp+ #219
> >  Hardware name: HP ProLiant DL380 Gen9/ProLiant DL380 Gen9, BIOS P89
> > 10/17/2018
> >  Workqueue: nfsiod rpc_async_release
> >  RIP: 0010:netfs_rreq_unlock_folios_pgpriv2+0xd2/0x360
> >  Code: 4c 8b 04 24 48 85 c0 49 89 c5 0f 84 38 01 00 00 49 81 fd 06 04 0=
0 00
> > 0f 84 f2 00 00 00 49 81 fd 02 04 00 00 0f 84 35 02 00 00 <49> 8b 45 20 =
ba
> > 00 10 00 00 49 8b 4d 00 48 c1 e0 0c 83 e1 40 74 08
> >  RSP: 0018:ffffb0056373fc90 EFLAGS: 00010216
> >  RAX: 000000000000002d RBX: ffff89de0d2a6780 RCX: 0000000000000001
> >  RDX: 00000000000000ad RSI: 0000000000000001 RDI: ffff89deb02e7b50
> >  RBP: 0000000000000000 R08: ffff89de3c9e9400 R09: 000000000000002c
> >  R10: 0000000000000008 R11: 0000000000000001 R12: 00000000000000b7
> >  R13: 0000025882015101 R14: 0000000000000000 R15: ffffb0056373fd28
> >  FS:  0000000000000000(0000) GS:ffff89f51fac0000(0000)
> > knlGS:0000000000000000
> >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >  CR2: 0000025882015121 CR3: 000000005942e006 CR4: 00000000001706f0
> >  Call Trace:
> >   <TASK>
> >   ? __die+0x1f/0x60
> >   ? page_fault_oops+0x15c/0x450
> >   ? search_extable+0x22/0x30
> >   ? netfs_rreq_unlock_folios_pgpriv2+0xd2/0x360
> >   ? search_module_extables+0xe/0x40
> >   ? exc_page_fault+0x5e/0x100
> >   ? asm_exc_page_fault+0x22/0x30
> >   ? netfs_rreq_unlock_folios_pgpriv2+0xd2/0x360
> >   ? select_task_rq_fair+0x1ed/0x1370
> >   netfs_rreq_unlock_folios+0x40c/0x4b0
> >   netfs_rreq_assess+0x348/0x580
> >   netfs_subreq_terminated+0x193/0x2a0
> >   nfs_netfs_read_completion+0x97/0xb0
> >   nfs_read_completion+0x12e/0x200
> >   rpc_free_task+0x39/0x60
> >   rpc_async_release+0x2b/0x40
> >   process_one_work+0x134/0x2e0
> >   worker_thread+0x299/0x3a0
> >   ? __pfx_worker_thread+0x10/0x10
> >   kthread+0xba/0xe0
> >   ? __pfx_kthread+0x10/0x10
> >   ret_from_fork+0x30/0x50
> >   ? __pfx_kthread+0x10/0x10
> >   ret_from_fork_asm+0x1a/0x30
> >   </TASK>
> >  Modules linked in:
> >  CR2: 0000025882015121
> >  ---[ end trace 0000000000000000 ]---
> >  ERST: [Firmware Warn]: Firmware does not respond in time.
> >  pstore: backend (erst) writing error (-5)
> >  RIP: 0010:netfs_rreq_unlock_folios_pgpriv2+0xd2/0x360
> >  Code: 4c 8b 04 24 48 85 c0 49 89 c5 0f 84 38 01 00 00 49 81 fd 06 04 0=
0 00
> > 0f 84 f2 00 00 00 49 81 fd 02 04 00 00 0f 84 35 02 00 00 <49> 8b 45 20 =
ba
> > 00 10 00 00 49 8b 4d 00 48 c1 e0 0c 83 e1 40 74 08
> >  RSP: 0018:ffffb0056373fc90 EFLAGS: 00010216
> >  RAX: 000000000000002d RBX: ffff89de0d2a6780 RCX: 0000000000000001
> >  RDX: 00000000000000ad RSI: 0000000000000001 RDI: ffff89deb02e7b50
> >  RBP: 0000000000000000 R08: ffff89de3c9e9400 R09: 000000000000002c
> >  R10: 0000000000000008 R11: 0000000000000001 R12: 00000000000000b7
> >  R13: 0000025882015101 R14: 0000000000000000 R15: ffffb0056373fd28
> >  FS:  0000000000000000(0000) GS:ffff89f51fac0000(0000)
> > knlGS:0000000000000000
> >  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> >  CR2: 0000025882015121 CR3: 000000005942e006 CR4: 00000000001706f0
> >  note: kworker/u193:32[247837] exited with irqs disabled
> >
> >  (gdb) p netfs_rreq_unlock_folios_pgpriv2+0xd2
> >  $1 =3D (void (*)(struct netfs_io_request *, size_t *)) 0xffffffff813d8=
0c2
> > <netfs_rreq_unlock_folios_pgpriv2+210>
> >  (gdb) disassemble netfs_rreq_unlock_folios_pgpriv2+0xd2
> >  Dump of assembler code for function netfs_rreq_unlock_folios_pgpriv2:
> >  [...]
> >    0xffffffff813d8093 <+163>: call   0xffffffff81f0ec70 <xas_find>
> >    0xffffffff813d8098 <+168>: mov    (%rsp),%r8
> >    0xffffffff813d809c <+172>: test   %rax,%rax
> >    0xffffffff813d809f <+175>: mov    %rax,%r13
> >    0xffffffff813d80a2 <+178>: je     0xffffffff813d81e0
> > <netfs_rreq_unlock_folios_pgpriv2+496>
> >    0xffffffff813d80a8 <+184>: cmp    $0x406,%r13
> >    0xffffffff813d80af <+191>: je     0xffffffff813d81a7
> > <netfs_rreq_unlock_folios_pgpriv2+439>
> >    0xffffffff813d80b5 <+197>: cmp    $0x402,%r13
> >    0xffffffff813d80bc <+204>: je     0xffffffff813d82f7
> > <netfs_rreq_unlock_folios_pgpriv2+775>
> >    0xffffffff813d80c2 <+210>: mov    0x20(%r13),%rax
> >    0xffffffff813d80c6 <+214>: mov    $0x1000,%edx
> >    0xffffffff813d80cb <+219>: mov    0x0(%r13),%rcx
> >    0xffffffff813d80cf <+223>: shl    $0xc,%rax
> >    0xffffffff813d80d3 <+227>: and    $0x40,%ecx
> >    0xffffffff813d80d6 <+230>: je     0xffffffff813d80e0
> > <netfs_rreq_unlock_folios_pgpriv2+240>
> >    0xffffffff813d80d8 <+232>: movzbl 0x40(%r13),%ecx
> >    0xffffffff813d80dd <+237>: shl    %cl,%rdx
> >
> >
> > Right now, the machine is running and I have an unstripped kernel, just=
 in
> > case you need more information from /proc/kcore.
> >
> > Max
> >
> > [resent as text/plain only - damn you, gmail!]

