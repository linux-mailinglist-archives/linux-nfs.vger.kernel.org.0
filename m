Return-Path: <linux-nfs+bounces-7568-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 544529B6002
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2024 11:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DFBF28138D
	for <lists+linux-nfs@lfdr.de>; Wed, 30 Oct 2024 10:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA621E2834;
	Wed, 30 Oct 2024 10:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="CDXsIuyZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CAD1E0E12
	for <linux-nfs@vger.kernel.org>; Wed, 30 Oct 2024 10:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730283838; cv=none; b=oQetqpzJ7fKBGtkfTlu2POGWVKjVb3zmUC7KZ34lJohKUCfymKrJ/zdQ24NSaBP9tV22/beL9Hrxkq3FpQKyrymhzC2pvDAJOTUoLPSJt+0JWmojaTN2e8LMWl/tE0Ixr6a+trrqypOp37+kBlUHNvb3RW3x1tPfLKvT7P09XDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730283838; c=relaxed/simple;
	bh=lA//qZesgyraKynZBmuWjZqo2zD+sf15KS0VwoKI/nc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=Xkk9wji27vRdL3/SOBlhGjYNqG/odSNAVxRz52dVlhKhR+A5CO0v9B+DCchFxA+qEtaUnbQyaWJJ9fAh1SKUJ9EaCdF9LatKA9810KYbWUezw2Y9p/ZKY6W9ah/gZ1BvCklPBiHq7OmAwbwn7wE45Co/wuRqI5g4ugSYC7/HLH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=CDXsIuyZ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5c95a962c2bso7835138a12.2
        for <linux-nfs@vger.kernel.org>; Wed, 30 Oct 2024 03:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1730283834; x=1730888634; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uua1tstVo1jiKYBlbaHaBo0WmGm8rt33M09fbm0Vnlo=;
        b=CDXsIuyZCFffmxgTcELD5U8tVxsb5hBe0PtXmbivo4tOcpJVvfhGwO6AUIlJtd1cXB
         OOLZcCu1HuMIBRg8dXrCxRctf9+CBnKtOsy8fTXsJm2kaiTInJWYgmMoxsVlzguR34vc
         8iNKP49Cr26+49BobEy65EvKBvosGLa1lv0Ekn8n0GP5YZ2c60NxydfhBqp6vNu8gvjS
         dZeQx02v3KMdw9d6rtVTAH0/KGj0ZNY7Mmic8Iytja0PS8DN/QE6jj5hstHN6TGT2Yj4
         ceTa65FKQMRdP/Si7c1LpN/MYgU5g8ZXsRnysY2pHwiswq+/SHVCoZy6DleRnu/uL5pN
         5YtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730283834; x=1730888634;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uua1tstVo1jiKYBlbaHaBo0WmGm8rt33M09fbm0Vnlo=;
        b=ONnj2k31Ito07/nqjwkEKYKVc61bgj3K+V4Am+BC5vx2yoI9vL6oUDcJ6ItP77ABQb
         NU42JFdIZUivsiycsxJ2U8XRc/u2pfWPTtAFulYQwVxzZqKHcgBRtJ02iWK9j9G7OYnx
         ynvyCYGHpIqzBzWP/viz4Tycg5SPIzKrmvNbc7zgc5c9HctgNdvgaVrfw/5BE42/2RQv
         QWlpV+sZkVhq/dN75SB2fGy2RNBHrUDWGxleXCy5bYv6KaipQ77dAOrSC302mBOFq8Ww
         5K/1u0+at++vVLseeSVwJpvergmRW/wmdXF16LsVTXa0L6vHq++KmAEugDP+3VTWMAd7
         OFWA==
X-Forwarded-Encrypted: i=1; AJvYcCVi7SjU5CXYTeq3IQMPJr8TgbyL86XtltXHcShaH1FeRTRlRSG4Am0sFAVeKRbrRjMJrsi7AmnH4NA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQVwV+AxnQHR+Zzje1gCIW9N/k91G37Ho8e0pzQBI1fmnvx9my
	97yEja4atrcPmzfttf+HG5VIw0UjmilKFQJ1KHfqrpvvUr+maLpVLq6/FEfKRohjkwrTwlS4JnA
	mZAslcGzTZ5MYue9OQNIAd1nUa/8y0I5f4IoUTeiZbe5gx0Oe60A=
X-Google-Smtp-Source: AGHT+IFxuUwla/JZ0vPuZemP9dHRo1Gp2NZw4PQe1YoUlDO9XgRUKXEOFqWt8VNPv7t+1tnVBdcaGzRdNUy7wsmH0GY=
X-Received: by 2002:a17:907:724a:b0:a9a:345a:6873 with SMTP id
 a640c23a62f3a-a9de5d0aeb1mr1475360466b.24.1730283833954; Wed, 30 Oct 2024
 03:23:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKPOu+9DyMbKLhyJb7aMLDTb=Fh0T8Teb9sjuf_pze+XWT1VaQ@mail.gmail.com>
In-Reply-To: <CAKPOu+9DyMbKLhyJb7aMLDTb=Fh0T8Teb9sjuf_pze+XWT1VaQ@mail.gmail.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Wed, 30 Oct 2024 11:23:42 +0100
Message-ID: <CAKPOu+_XVhgg7Gq=izU9QDFyaVpZTSyNWOWLi5N8S6wSYdbf3A@mail.gmail.com>
Subject: Re: Oops in netfs_rreq_unlock_folios_pgpriv2
To: David Howells <dhowells@redhat.com>, netfs@lists.linux.dev, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

David,

Meanwhile, our servers crash many times a day due to this bug.

The code was added by your commit 7b589a9b45a ("netfs: Fix handling of
USE_PGPRIV2 and WRITE_TO_CACHE flags") after I found Ceph-related bugs
in your commit 2ff1e97587f4 ("netfs: Replace PG_fscache by setting
folio->private and marking dirty"). Since this fix, the Ceph problems
were gone, but yesterday, out of the blue, the NFS-using server
started crashing (after running stable with 6.11.5 for 5 days).

We can't go back to 6.10 (EOL); the newest kernel prior to your
refactoring was 6.9 which has been EOL since July, leaving a downgrade
to 6.6 LTS as the only remaining option.

Max



On Tue, Oct 29, 2024 at 9:02=E2=80=AFAM Max Kellermann <max.kellermann@iono=
s.com> wrote:
>
> Hi David,
>
> maybe this crash is related to your recent netfs refactoring work; it is =
on
> a server with heavy NFS traffic (with fscache enabled). The kernel is
> 6.11.5 plus a dozen patches that are not relevant for NFS/netfs/fscache.
>
>  BUG: unable to handle page fault for address: 0000025882015121
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 0 P4D 0
>  Oops: Oops: 0000 [#1] SMP PTI
>  CPU: 11 UID: 0 PID: 247837 Comm: kworker/u193:32 Not tainted
> 6.11.5-cm4all1-hp+ #219
>  Hardware name: HP ProLiant DL380 Gen9/ProLiant DL380 Gen9, BIOS P89
> 10/17/2018
>  Workqueue: nfsiod rpc_async_release
>  RIP: 0010:netfs_rreq_unlock_folios_pgpriv2+0xd2/0x360
>  Code: 4c 8b 04 24 48 85 c0 49 89 c5 0f 84 38 01 00 00 49 81 fd 06 04 00 =
00
> 0f 84 f2 00 00 00 49 81 fd 02 04 00 00 0f 84 35 02 00 00 <49> 8b 45 20 ba
> 00 10 00 00 49 8b 4d 00 48 c1 e0 0c 83 e1 40 74 08
>  RSP: 0018:ffffb0056373fc90 EFLAGS: 00010216
>  RAX: 000000000000002d RBX: ffff89de0d2a6780 RCX: 0000000000000001
>  RDX: 00000000000000ad RSI: 0000000000000001 RDI: ffff89deb02e7b50
>  RBP: 0000000000000000 R08: ffff89de3c9e9400 R09: 000000000000002c
>  R10: 0000000000000008 R11: 0000000000000001 R12: 00000000000000b7
>  R13: 0000025882015101 R14: 0000000000000000 R15: ffffb0056373fd28
>  FS:  0000000000000000(0000) GS:ffff89f51fac0000(0000)
> knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 0000025882015121 CR3: 000000005942e006 CR4: 00000000001706f0
>  Call Trace:
>   <TASK>
>   ? __die+0x1f/0x60
>   ? page_fault_oops+0x15c/0x450
>   ? search_extable+0x22/0x30
>   ? netfs_rreq_unlock_folios_pgpriv2+0xd2/0x360
>   ? search_module_extables+0xe/0x40
>   ? exc_page_fault+0x5e/0x100
>   ? asm_exc_page_fault+0x22/0x30
>   ? netfs_rreq_unlock_folios_pgpriv2+0xd2/0x360
>   ? select_task_rq_fair+0x1ed/0x1370
>   netfs_rreq_unlock_folios+0x40c/0x4b0
>   netfs_rreq_assess+0x348/0x580
>   netfs_subreq_terminated+0x193/0x2a0
>   nfs_netfs_read_completion+0x97/0xb0
>   nfs_read_completion+0x12e/0x200
>   rpc_free_task+0x39/0x60
>   rpc_async_release+0x2b/0x40
>   process_one_work+0x134/0x2e0
>   worker_thread+0x299/0x3a0
>   ? __pfx_worker_thread+0x10/0x10
>   kthread+0xba/0xe0
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork+0x30/0x50
>   ? __pfx_kthread+0x10/0x10
>   ret_from_fork_asm+0x1a/0x30
>   </TASK>
>  Modules linked in:
>  CR2: 0000025882015121
>  ---[ end trace 0000000000000000 ]---
>  ERST: [Firmware Warn]: Firmware does not respond in time.
>  pstore: backend (erst) writing error (-5)
>  RIP: 0010:netfs_rreq_unlock_folios_pgpriv2+0xd2/0x360
>  Code: 4c 8b 04 24 48 85 c0 49 89 c5 0f 84 38 01 00 00 49 81 fd 06 04 00 =
00
> 0f 84 f2 00 00 00 49 81 fd 02 04 00 00 0f 84 35 02 00 00 <49> 8b 45 20 ba
> 00 10 00 00 49 8b 4d 00 48 c1 e0 0c 83 e1 40 74 08
>  RSP: 0018:ffffb0056373fc90 EFLAGS: 00010216
>  RAX: 000000000000002d RBX: ffff89de0d2a6780 RCX: 0000000000000001
>  RDX: 00000000000000ad RSI: 0000000000000001 RDI: ffff89deb02e7b50
>  RBP: 0000000000000000 R08: ffff89de3c9e9400 R09: 000000000000002c
>  R10: 0000000000000008 R11: 0000000000000001 R12: 00000000000000b7
>  R13: 0000025882015101 R14: 0000000000000000 R15: ffffb0056373fd28
>  FS:  0000000000000000(0000) GS:ffff89f51fac0000(0000)
> knlGS:0000000000000000
>  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>  CR2: 0000025882015121 CR3: 000000005942e006 CR4: 00000000001706f0
>  note: kworker/u193:32[247837] exited with irqs disabled
>
>  (gdb) p netfs_rreq_unlock_folios_pgpriv2+0xd2
>  $1 =3D (void (*)(struct netfs_io_request *, size_t *)) 0xffffffff813d80c=
2
> <netfs_rreq_unlock_folios_pgpriv2+210>
>  (gdb) disassemble netfs_rreq_unlock_folios_pgpriv2+0xd2
>  Dump of assembler code for function netfs_rreq_unlock_folios_pgpriv2:
>  [...]
>    0xffffffff813d8093 <+163>: call   0xffffffff81f0ec70 <xas_find>
>    0xffffffff813d8098 <+168>: mov    (%rsp),%r8
>    0xffffffff813d809c <+172>: test   %rax,%rax
>    0xffffffff813d809f <+175>: mov    %rax,%r13
>    0xffffffff813d80a2 <+178>: je     0xffffffff813d81e0
> <netfs_rreq_unlock_folios_pgpriv2+496>
>    0xffffffff813d80a8 <+184>: cmp    $0x406,%r13
>    0xffffffff813d80af <+191>: je     0xffffffff813d81a7
> <netfs_rreq_unlock_folios_pgpriv2+439>
>    0xffffffff813d80b5 <+197>: cmp    $0x402,%r13
>    0xffffffff813d80bc <+204>: je     0xffffffff813d82f7
> <netfs_rreq_unlock_folios_pgpriv2+775>
>    0xffffffff813d80c2 <+210>: mov    0x20(%r13),%rax
>    0xffffffff813d80c6 <+214>: mov    $0x1000,%edx
>    0xffffffff813d80cb <+219>: mov    0x0(%r13),%rcx
>    0xffffffff813d80cf <+223>: shl    $0xc,%rax
>    0xffffffff813d80d3 <+227>: and    $0x40,%ecx
>    0xffffffff813d80d6 <+230>: je     0xffffffff813d80e0
> <netfs_rreq_unlock_folios_pgpriv2+240>
>    0xffffffff813d80d8 <+232>: movzbl 0x40(%r13),%ecx
>    0xffffffff813d80dd <+237>: shl    %cl,%rdx
>
>
> Right now, the machine is running and I have an unstripped kernel, just i=
n
> case you need more information from /proc/kcore.
>
> Max
>
> [resent as text/plain only - damn you, gmail!]

