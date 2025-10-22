Return-Path: <linux-nfs+bounces-15546-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C64CBBFE689
	for <lists+linux-nfs@lfdr.de>; Thu, 23 Oct 2025 00:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 471441A04F10
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Oct 2025 22:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED11304BCB;
	Wed, 22 Oct 2025 22:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="S8G2vyoL"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DC92F363E
	for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 22:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761171939; cv=none; b=r8LLym5ZYFbZp0oSu3ocF7qQhw/Mzq/AZjAYWDFuPVrtOcYel/bL79llr74Dthkwd2E8ayDFxn8B5DFzHGpmStnNn355VJVcdAR7mo+VKDa1xezFBPj2UWkcLzDy8nmKH8Bgm6i6nAHJkId7ML/Uz2/toS5Py+fi52PqIpWgExc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761171939; c=relaxed/simple;
	bh=385W1OI7PUjknYCVESArH4/jnRMQvDu0lisYKbIDiG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DYX6+xydshs50QEW0i8gNTL6uvqs0Zd1HLpj2F08EqHpHGI3d9BcvA2Vh8KNZLmbGdHqh1YNfNPD09W4r2t6gkZtevg+PmPa+AQPP9FfEbjO2q8dQjio6cxVvRP7/TNPViYdMlHfI0+66imM2EFfJHAYjxsIO6VLy/lC6Ez01lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=S8G2vyoL; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3778144a440so1268871fa.0
        for <linux-nfs@vger.kernel.org>; Wed, 22 Oct 2025 15:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1761171934; x=1761776734; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XsEMdo0FsyVoPrfUj8VIoxH72/dWe6RWp/3Q2SjKKYg=;
        b=S8G2vyoL1m8SSwulp0vg3FCZlkpg/uDWd0WGH0Z7W3EszRFYvWUKa0ohyVbp5gwiUX
         eRPWw3KhZtg4KdLy/zFMr9nDxmlzTWD1N5ccEgfGUtgac72gNu5i6f0zOLOzxloBaU2s
         IsVcjdA3NFWBG07V63elNm+8S5kEjhWndbJcWYFx80+87U2Z3GvyiNSUqMlWItlphlkp
         42US0xuJ/EU1cfJh84rYCOsY0DjjH7XZ9UdovqHSsXlZIENwhd29EfW6EyZu+4QVy3cJ
         KgaGftvJUxywTcVEZvxFkjAKN7hDLpQTnbcg75uTuOT0bqITxgDPwuNxoh4Q9gxS3JKG
         hSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761171934; x=1761776734;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XsEMdo0FsyVoPrfUj8VIoxH72/dWe6RWp/3Q2SjKKYg=;
        b=ao52oYzq8NttePjbdz5JiUNHXhelllSfyxixqD4dCuEsexENK7XMSXqIEweeSHiuvK
         OppD+LJTRVrARBrZWN76wTWnWq7CEQrUKGvFjenMkH33cyijia9rDTu3zc7HOwRAwUCi
         PE0dEbKqPcc+S4uuZoTIXWuYCOxqvryl5Z5fUarIJASCfu0ddlLIAAvbSeB2pipzj0mM
         EcCsdg7vwH45AWuu4WubBfVbAGTxUjpqf9lQa2afN/BUKBjqt68XY8TYy5ginMCwroVf
         LGx81TVsxBwOeLpncag8Di5PiVoqAfuNbRrxmoARLzT+zR5N6n0oP3LjZ4IB9o4I7TNk
         Y49w==
X-Forwarded-Encrypted: i=1; AJvYcCUPl2Hacr4QABjJVAKFc8lJfxNgFjJ/zlTuKoKOAee9VWA/Meig/mBVryIoURcZmhZbsUrWssciYYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQBqeGjl3Flguef6KFwAhRM80RbIFYeK81pIzFhE0v0YHjs0/V
	KlEEKoIXgm00N0v7zp8B6vHopUEjZubWGlmNUED4DTkzcjpnE4EicG4ONDwwZD+007z8PZj4jFC
	hYw/3Yk09h8+4Mr+BqJvtVi36ckQotMk=
X-Gm-Gg: ASbGncsv6jGRBYubSvW1somkcMgKYA0ckctZKZZumx3V/i93P790ij3udKMoXHjTgkn
	NCD/SBhKTlKlGoniVK6GIOLUdSydz/1xR1w5yNQHmy0jQSjB8YrNfpupNbKiQXTxX4yLxqR4B8S
	1dmF+9o8+3jxcn+GOrJ2WqbmNWfO90HpFObtQK61P8A1YTtDqgfjd/VnbWVJPhHAuiAUn44I+Ad
	xsX9FIZb/926i2wtgrNSLgN838PBz2Y1nPaiFFgVJshQFpdGnAbPVrTsq4DfdLMdP4owvZMfxWm
	VdACe9RegeLQLPkRB0s=
X-Google-Smtp-Source: AGHT+IF1W0ntrn+/xHMbpg2MN5o8UUXgSTL9oxd2rhRZIWWW8KR1dCfIGOfX7WKV7oy9I1kNG8ILLcZixYp83Es8LJs=
X-Received: by 2002:a2e:a7ca:0:b0:376:41f5:a6ca with SMTP id
 38308e7fff4ca-378cf72bc99mr9459501fa.0.1761171933980; Wed, 22 Oct 2025
 15:25:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021130506.45065-1-okorniev@redhat.com> <33ba39d2ff01eb0e52c80aa7015d27e34dde7fd2.camel@kernel.org>
 <CAN-5tyEuV2UO17w97b8weJUQR7hgqX=jz-kvGR9Sr_m3NZp8ww@mail.gmail.com>
 <d0a1a1ccec73ee56e614b91c4a75941f557398b8.camel@kernel.org>
 <CAN-5tyGK4MHgYaN1SqpygtvWM8BFrapT-rXY_y9msVfnRjN1Jw@mail.gmail.com>
 <ff353db93ca47b8fae530695ea44c0a34cd40af8.camel@kernel.org>
 <fe1489b3c55bdb32cd7ad460a2403bc23abdde81.camel@kernel.org>
 <f61025a96df19c64ba372cdcab8b12f3fa2fff9e.camel@kernel.org>
 <CAN-5tyFWvP2ZTeYFN6ybGoxvsAw=TKFJAo0dVLU_=s_5t=LCGg@mail.gmail.com>
 <f5073caf3e3db05702ed196042053fc864645750.camel@kernel.org>
 <CAN-5tyHWWkmgcFCgpZR2Bqm7tAued_JPZ-i0rGaa+FzLtFhMjw@mail.gmail.com> <f1aae34ddba90583b20d56d9b66efe09b8e8fa31.camel@kernel.org>
In-Reply-To: <f1aae34ddba90583b20d56d9b66efe09b8e8fa31.camel@kernel.org>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Wed, 22 Oct 2025 18:25:21 -0400
X-Gm-Features: AS18NWATwtAx_TFCHM3X6mw55ZubwJxkd2IcW8_L16ihj389GmWXbmeiO3H3XGw
Message-ID: <CAN-5tyEZ822enzcWidAN5HxtmyZVFrNGtYjdB3JapvhH8fZeoQ@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] lockd: prevent UAF in nlm4svc_proc_test in
 reexport NLM
To: Jeff Layton <jlayton@kernel.org>
Cc: Olga Kornievskaia <okorniev@redhat.com>, chuck.lever@oracle.com, linux-nfs@vger.kernel.org, 
	neilb@brown.name, Dai.Ngo@oracle.com, tom@talpey.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 22, 2025 at 3:51=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wr=
ote:
>
> On Wed, 2025-10-22 at 13:56 -0400, Olga Kornievskaia wrote:
> > On Wed, Oct 22, 2025 at 12:06=E2=80=AFPM Jeff Layton <jlayton@kernel.or=
g> wrote:
> > >
> > > On Wed, 2025-10-22 at 11:38 -0400, Olga Kornievskaia wrote:
> > > > On Tue, Oct 21, 2025 at 1:45=E2=80=AFPM Jeff Layton <jlayton@kernel=
.org> wrote:
> > > > >
> > > > > On Tue, 2025-10-21 at 13:15 -0400, Jeff Layton wrote:
> > > > > > On Tue, 2025-10-21 at 13:03 -0400, Jeff Layton wrote:
> > > > > > > On Tue, 2025-10-21 at 12:17 -0400, Olga Kornievskaia wrote:
> > > > > > > > On Tue, Oct 21, 2025 at 11:59=E2=80=AFAM Jeff Layton <jlayt=
on@kernel.org> wrote:
> > > > > > > > >
> > > > > > > > > On Tue, 2025-10-21 at 11:23 -0400, Olga Kornievskaia wrot=
e:
> > > > > > > > > > On Tue, Oct 21, 2025 at 9:40=E2=80=AFAM Jeff Layton <jl=
ayton@kernel.org> wrote:
> > > > > > > > > > >
> > > > > > > > > > > On Tue, 2025-10-21 at 09:05 -0400, Olga Kornievskaia =
wrote:
> > > > > > > > > > > > When knfsd is a reexport nfs server, it nlm4svc_pro=
c_test() in
> > > > > > > > > > > > calling nlmsvc_testlock() with a lock conflict lock=
_release_private()
> > > > > > > > > > > > call would end up calling nlmsvc_put_lockowner() an=
d then back in
> > > > > > > > > > > > nlm4svc_proc_test() function there will be another =
call to
> > > > > > > > > > > > nlmsvc_put_lockowner() for the same owner leading t=
o use-after-free
> > > > > > > > > > > > violation (below).
> > > > > > > > > > > >
> > > > > > > > > > > > The problem only arises when the underlying file sy=
stem has been
> > > > > > > > > > > > re-exported as different paths are taken in vfs_tes=
t_lock().
> > > > > > > > > > > > When it's reexport, filp->f_op->lock is set and whe=
n vfs_test_lock()
> > > > > > > > > > > > is done fl_lmops pointer is non-null. When it's reg=
ular export,
> > > > > > > > > > > > vfs_test_lock() calls posix_test_lock() which ends =
up calling
> > > > > > > > > > > > locks_copy_conflock() and it copies NULL into fl_lm=
ops and then
> > > > > > > > > > > > calling into lock_release_private() does not call
> > > > > > > > > > > > nlmsvc_put_lockowner().
> > > > > > > > > > > >
> > > > > > > > > > > > The proposed solution is to intentionally clear fl_=
lmops pointer to
> > > > > > > > > > > > make sure that if there is a conflict (be it a loca=
l file system
> > > > > > > > > > > > or reexport), lock_release_private() would not call
> > > > > > > > > > > > nlmsvc_put_lockowner().
> > > > > > > > > > > >
> > > > > > > > > > > > kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > > > > > > > > > > > kernel: BUG: KASAN: slab-use-after-free in nlmsvc_p=
ut_lockowner+0x30/0x250 [lockd]
> > > > > > > > > > > > kernel: Read of size 4 at addr ffff0000bf3bca10 by =
task lockd/6092
> > > > > > > > > > > > kernel:
> > > > > > > > > > > > kernel: CPU: 0 UID: 0 PID: 6092 Comm: lockd Kdump: =
loaded Not tainted 6.18.0-rc1+ #23 PREEMPT(voluntary)
> > > > > > > > > > > > kernel: Hardware name: VMware, Inc. VMware20,1/VBSA=
, BIOS VMW201.00V.24006586.BA64.2406042154 06/04/2024
> > > > > > > > > > > > kernel: Call trace:
> > > > > > > > > > > > kernel:  show_stack+0x34/0x98 (C)
> > > > > > > > > > > > kernel:  dump_stack_lvl+0x80/0xa8
> > > > > > > > > > > > kernel:  print_address_description.constprop.0+0x90=
/0x310
> > > > > > > > > > > > kernel:  print_report+0x108/0x1f8
> > > > > > > > > > > > kernel:  kasan_report+0xc8/0x120
> > > > > > > > > > > > kernel:  kasan_check_range+0xe8/0x190
> > > > > > > > > > > > kernel:  __kasan_check_read+0x20/0x30
> > > > > > > > > > > > kernel:  nlmsvc_put_lockowner+0x30/0x250 [lockd]
> > > > > > > > > > > > kernel:  __nlm4svc_proc_test+0x2a8/0x318 [lockd]
> > > > > > > > > > > > kernel:  nlm4svc_proc_test+0x44/0xb78 [lockd]
> > > > > > > > > > > > kernel:  nlmsvc_dispatch+0xb0/0x200 [lockd]
> > > > > > > > > > > > kernel:  svc_process_common+0xb20/0x17b0 [sunrpc]
> > > > > > > > > > > > kernel:  svc_process+0x414/0x900 [sunrpc]
> > > > > > > > > > > > kernel:  svc_handle_xprt+0x5c8/0xd60 [sunrpc]
> > > > > > > > > > > > kernel:  svc_recv+0x1a4/0x520 [sunrpc]
> > > > > > > > > > > > kernel:  lockd+0x154/0x298 [lockd]
> > > > > > > > > > > > kernel:  kthread+0x2f8/0x398
> > > > > > > > > > > > kernel:  ret_from_fork+0x10/0x20
> > > > > > > > > > > > kernel:
> > > > > > > > > > > > kernel: Allocated by task 6092:
> > > > > > > > > > > > kernel:  kasan_save_stack+0x3c/0x70
> > > > > > > > > > > > kernel:  kasan_save_track+0x20/0x40
> > > > > > > > > > > > kernel:  kasan_save_alloc_info+0x40/0x58
> > > > > > > > > > > > kernel:  __kasan_kmalloc+0xd4/0xd8
> > > > > > > > > > > > kernel:  __kmalloc_cache_noprof+0x1a8/0x5c0
> > > > > > > > > > > > kernel:  nlmsvc_locks_init_private+0xe4/0x520 [lock=
d]
> > > > > > > > > > > > kernel:  nlm4svc_retrieve_args+0x38c/0x530 [lockd]
> > > > > > > > > > > > kernel:  __nlm4svc_proc_test+0x194/0x318 [lockd]
> > > > > > > > > > > > kernel:  nlm4svc_proc_test+0x44/0xb78 [lockd]
> > > > > > > > > > > > kernel:  nlmsvc_dispatch+0xb0/0x200 [lockd]
> > > > > > > > > > > > kernel:  svc_process_common+0xb20/0x17b0 [sunrpc]
> > > > > > > > > > > > kernel:  svc_process+0x414/0x900 [sunrpc]
> > > > > > > > > > > > kernel:  svc_handle_xprt+0x5c8/0xd60 [sunrpc]
> > > > > > > > > > > > kernel:  svc_recv+0x1a4/0x520 [sunrpc]
> > > > > > > > > > > > kernel:  lockd+0x154/0x298 [lockd]
> > > > > > > > > > > > kernel:  kthread+0x2f8/0x398
> > > > > > > > > > > > kernel:  ret_from_fork+0x10/0x20
> > > > > > > > > > > > kernel:
> > > > > > > > > > > > kernel: Freed by task 6092:
> > > > > > > > > > > > kernel:  kasan_save_stack+0x3c/0x70
> > > > > > > > > > > > kernel:  kasan_save_track+0x20/0x40
> > > > > > > > > > > > kernel:  __kasan_save_free_info+0x4c/0x80
> > > > > > > > > > > > kernel:  __kasan_slab_free+0x88/0xc0
> > > > > > > > > > > > kernel:  kfree+0x110/0x480
> > > > > > > > > > > > kernel:  nlmsvc_put_lockowner+0x1b4/0x250 [lockd]
> > > > > > > > > > > > kernel:  nlmsvc_put_owner+0x18/0x30 [lockd]
> > > > > > > > > > > > kernel:  locks_release_private+0x190/0x2a8
> > > > > > > > > > > > kernel:  nlmsvc_testlock+0x2e0/0x648 [lockd]
> > > > > > > > > > > > kernel:  __nlm4svc_proc_test+0x244/0x318 [lockd]
> > > > > > > > > > > > kernel:  nlm4svc_proc_test+0x44/0xb78 [lockd]
> > > > > > > > > > > > kernel:  nlmsvc_dispatch+0xb0/0x200 [lockd]
> > > > > > > > > > > > kernel:  svc_process_common+0xb20/0x17b0 [sunrpc]
> > > > > > > > > > > > kernel:  svc_process+0x414/0x900 [sunrpc]
> > > > > > > > > > > > kernel:  svc_handle_xprt+0x5c8/0xd60 [sunrpc]
> > > > > > > > > > > > kernel:  svc_recv+0x1a4/0x520 [sunrpc]
> > > > > > > > > > > > kernel:  lockd+0x154/0x298 [lockd]
> > > > > > > > > > > > kernel:  kthread+0x2f8/0x398
> > > > > > > > > > > > kernel:  ret_from_fork+0x10/0x20
> > > > > > > > > > > > kernel:
> > > > > > > > > > > > kernel: The buggy address belongs to the object at =
ffff0000bf3bca00
> > > > > > > > > > > >         which belongs to the cache kmalloc-64 of si=
ze 64
> > > > > > > > > > > > kernel: The buggy address is located 16 bytes insid=
e of
> > > > > > > > > > > >         freed 64-byte region [ffff0000bf3bca00, fff=
f0000bf3bca40)
> > > > > > > > > > > > kernel:
> > > > > > > > > > > > kernel: The buggy address belongs to the physical p=
age:
> > > > > > > > > > > > kernel: page: refcount:0 mapcount:0 mapping:0000000=
000000000 index:0x0 pfn:0x13f3bc
> > > > > > > > > > > > kernel: flags: 0x2fffff00000000(node=3D0|zone=3D2|l=
astcpupid=3D0xfffff)
> > > > > > > > > > > > kernel: page_type: f5(slab)
> > > > > > > > > > > > kernel: raw: 002fffff00000000 ffff0000800028c0 dead=
000000000122 0000000000000000
> > > > > > > > > > > > kernel: raw: 0000000000000000 0000000080200020 0000=
0000f5000000 0000000000000000
> > > > > > > > > > > > kernel: page dumped because: kasan: bad access dete=
cted
> > > > > > > > > > > > kernel:
> > > > > > > > > > > > kernel: Memory state around the buggy address:
> > > > > > > > > > > > kernel:  ffff0000bf3bc900: fa fb fb fb fb fb fb fb =
fc fc fc fc fc fc fc fc
> > > > > > > > > > > > kernel:  ffff0000bf3bc980: fa fb fb fb fb fb fb fb =
fc fc fc fc fc fc fc fc
> > > > > > > > > > > > kernel: >ffff0000bf3bca00: fa fb fb fb fb fb fb fb =
fc fc fc fc fc fc fc fc
> > > > > > > > > > > > kernel:                          ^
> > > > > > > > > > > > kernel:  ffff0000bf3bca80: fa fb fb fb fb fb fb fb =
fc fc fc fc fc fc fc fc
> > > > > > > > > > > > kernel:  ffff0000bf3bcb00: fc fc fc fc fc fc fc fc =
fc fc fc fc fc fc fc fc
> > > > > > > > > > > > kernel: =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > > > > > > > > > > > kernel: Disabling lock debugging due to kernel tain=
t
> > > > > > > > > > > > kernel: AGLO: nlmsvc_put_lockowner 00000000028055fb=
 count=3D0
> > > > > > > > > > > > kernel: CPU: 0 UID: 0 PID: 6092 Comm: lockd Kdump: =
loaded Tainted: G    B               6.18.0-rc1+ #23 PREEMPT(voluntary)
> > > > > > > > > > > > kernel: Tainted: [B]=3DBAD_PAGE
> > > > > > > > > > > > kernel: Hardware name: VMware, Inc. VMware20,1/VBSA=
, BIOS VMW201.00V.24006586.BA64.2406042154 06/04/2024
> > > > > > > > > > > > kernel: Call trace:
> > > > > > > > > > > > kernel:  show_stack+0x34/0x98 (C)
> > > > > > > > > > > > kernel:  dump_stack_lvl+0x80/0xa8
> > > > > > > > > > > > kernel:  dump_stack+0x1c/0x30
> > > > > > > > > > > > kernel:  nlmsvc_put_lockowner+0x7c/0x250 [lockd]
> > > > > > > > > > > > kernel:  __nlm4svc_proc_test+0x2a8/0x318 [lockd]
> > > > > > > > > > > > kernel:  nlm4svc_proc_test+0x44/0xb78 [lockd]
> > > > > > > > > > > > kernel:  nlmsvc_dispatch+0xb0/0x200 [lockd]
> > > > > > > > > > > > kernel:  svc_process_common+0xb20/0x17b0 [sunrpc]
> > > > > > > > > > > > kernel:  svc_process+0x414/0x900 [sunrpc]
> > > > > > > > > > > > kernel:  svc_handle_xprt+0x5c8/0xd60 [sunrpc]
> > > > > > > > > > > > kernel:  svc_recv+0x1a4/0x520 [sunrpc]
> > > > > > > > > > > > kernel:  lockd+0x154/0x298 [lockd]
> > > > > > > > > > > > kernel:  kthread+0x2f8/0x398
> > > > > > > > > > > > kernel:  ret_from_fork+0x10/0x20
> > > > > > > > > > > > kernel: ------------[ cut here ]------------
> > > > > > > > > > > > kernel: refcount_t: underflow; use-after-free.
> > > > > > > > > > > > kernel: WARNING: CPU: 0 PID: 6092 at lib/refcount.c=
:87 refcount_dec_not_one+0x198/0x1b0
> > > > > > > > > > > > kernel: Modules linked in: rpcrdma rdma_cm iw_cm ib=
_cm ib_core nfsd nfsv3 nfs_acl nfs lockd grace nfs_localio netfs ext4 crc16=
 mbcache jbd2 overlay uinput snd_seq_dummy snd_hrtimer qrtr rfkill vfat fat=
 uvcvideo snd_hda_codec_generic videobuf2_vmalloc videobuf2_memops uvc snd_=
hda_intel videobuf2_v4l2 videobuf2_common snd_intel_dspcfg videodev snd_hda=
_codec snd_hda_core mc snd_hwdep snd_seq snd_seq_device snd_pcm snd_timer s=
nd soundcore sg loop auth_rpcgss vsock_loopback vmw_vsock_virtio_transport_=
common vmw_vsock_vmci_transport vmw_vmci vsock xfs 8021q garp stp llc mrp n=
vme nvme_core nvme_keyring nvme_auth ghash_ce hkdf e1000e sr_mod cdrom vmwg=
fx drm_ttm_helper ttm sunrpc dm_mirror dm_region_hash dm_log iscsi_tcp libi=
scsi_tcp libiscsi scsi_transport_iscsi fuse dm_multipath dm_mod nfnetlink
> > > > > > > > > > > > kernel: CPU: 0 UID: 0 PID: 6092 Comm: lockd Kdump: =
loaded Tainted: G    B               6.18.0-rc1+ #23 PREEMPT(voluntary)
> > > > > > > > > > > > kernel: Tainted: [B]=3DBAD_PAGE
> > > > > > > > > > > > kernel: Hardware name: VMware, Inc. VMware20,1/VBSA=
, BIOS VMW201.00V.24006586.BA64.2406042154 06/04/2024
> > > > > > > > > > > > kernel: pstate: 61400005 (nZCv daif +PAN -UAO -TCO =
+DIT -SSBS BTYPE=3D--)
> > > > > > > > > > > > kernel: pc : refcount_dec_not_one+0x198/0x1b0
> > > > > > > > > > > > kernel: lr : refcount_dec_not_one+0x198/0x1b0
> > > > > > > > > > > > kernel: sp : ffff80008a627930
> > > > > > > > > > > > kernel: x29: ffff80008a627990 x28: ffff0000bf3bca00=
 x27: ffff0000ba5c7000
> > > > > > > > > > > > kernel: x26: 1fffe000191eeb84 x25: 1ffff000114c4f48=
 x24: ffff0000c8f75c24
> > > > > > > > > > > > kernel: x23: 0000000000000007 x22: ffff80008a627950=
 x21: 1ffff000114c4f26
> > > > > > > > > > > > kernel: x20: 00000000ffffffff x19: ffff0000bf3bca10=
 x18: 0000000000000310
> > > > > > > > > > > > kernel: x17: 0000000000000000 x16: 0000000000000000=
 x15: 0000000000000000
> > > > > > > > > > > > kernel: x14: 0000000000000000 x13: 0000000000000001=
 x12: ffff60004fd90aa3
> > > > > > > > > > > > kernel: x11: 1fffe0004fd90aa2 x10: ffff60004fd90aa2=
 x9 : dfff800000000000
> > > > > > > > > > > > kernel: x8 : 00009fffb026f55e x7 : ffff00027ec85513=
 x6 : 0000000000000001
> > > > > > > > > > > > kernel: x5 : ffff00027ec85510 x4 : ffff60004fd90aa3=
 x3 : ffff800080787bc0
> > > > > > > > > > > > kernel: x2 : 0000000000000000 x1 : 0000000000000000=
 x0 : ffff0000a75a8000
> > > > > > > > > > > > kernel: Call trace:
> > > > > > > > > > > > kernel:  refcount_dec_not_one+0x198/0x1b0 (P)
> > > > > > > > > > > > kernel:  refcount_dec_and_lock+0x1c/0xb8
> > > > > > > > > > > > kernel:  nlmsvc_put_lockowner+0x9c/0x250 [lockd]
> > > > > > > > > > > > kernel:  __nlm4svc_proc_test+0x2a8/0x318 [lockd]
> > > > > > > > > > > > kernel:  nlm4svc_proc_test+0x44/0xb78 [lockd]
> > > > > > > > > > > > kernel:  nlmsvc_dispatch+0xb0/0x200 [lockd]
> > > > > > > > > > > > kernel:  svc_process_common+0xb20/0x17b0 [sunrpc]
> > > > > > > > > > > > kernel:  svc_process+0x414/0x900 [sunrpc]
> > > > > > > > > > > > kernel:  svc_handle_xprt+0x5c8/0xd60 [sunrpc]
> > > > > > > > > > > > kernel:  svc_recv+0x1a4/0x520 [sunrpc]
> > > > > > > > > > > > kernel:  lockd+0x154/0x298 [lockd]
> > > > > > > > > > > > kernel:  kthread+0x2f8/0x398
> > > > > > > > > > > > kernel:  ret_from_fork+0x10/0x20
> > > > > > > > > > > > kernel: ---[ end trace 0000000000000000 ]---
> > > > > > > > > > > >
> > > > > > > > > > > > Signed-off-by: Olga Kornievskaia <okorniev@redhat.c=
om>
> > > > > > > > > > > > ---
> > > > > > > > > > > >  fs/lockd/svclock.c | 1 +
> > > > > > > > > > > >  1 file changed, 1 insertion(+)
> > > > > > > > > > > >
> > > > > > > > > > > > diff --git a/fs/lockd/svclock.c b/fs/lockd/svclock.=
c
> > > > > > > > > > > > index a31dc9588eb8..1dd0fec186de 100644
> > > > > > > > > > > > --- a/fs/lockd/svclock.c
> > > > > > > > > > > > +++ b/fs/lockd/svclock.c
> > > > > > > > > > > > @@ -652,6 +652,7 @@ nlmsvc_testlock(struct svc_rqst=
 *rqstp, struct nlm_file *file,
> > > > > > > > > > > >       conflock->fl.c.flc_type =3D lock->fl.c.flc_ty=
pe;
> > > > > > > > > > > >       conflock->fl.fl_start =3D lock->fl.fl_start;
> > > > > > > > > > > >       conflock->fl.fl_end =3D lock->fl.fl_end;
> > > > > > > > > > > > +     conflock->fl.fl_lmops =3D NULL;
> > > > > > > > > > > >       locks_release_private(&lock->fl);
> > > > > > > > > > > >
> > > > > > > > > > > >       ret =3D nlm_lck_denied;
> > > > > > > > > > >
> > > > > > > > > > > The problem sounds real, but I'm not sure I like this=
 solution.
> > > > > > > > > >
> > > > > > > > > > I have no claim that this solution is the best. I was c=
ontemplating on
> > > > > > > > > > setting this to NULL only in the case when ->f_ops->loc=
k() is NULL
> > > > > > > > > > thus restricting it to the path that does not call posi=
x_test_lock().
> > > > > > > > > >
> > > > > > > > > > > It seems like this is gaming the refcounting such tha=
t we take a
> > > > > > > > > > > reference in locks_copy_conflock() but then you zero =
out fl_lmops
> > > > > > > > > > > before that reference can be put.
> > > > > > > > > >
> > > > > > > > > > IF lock_copy_conflock() is called then fl_lmops is alre=
ady NULL.
> > > > > > > > > >
> > > > > > > > > > Let me try to lay out the sequence of steps for both ca=
ses.
> > > > > > > > > >
> > > > > > > > > > Reexport
> > > > > > > > > > 1. when nlmsvc_test_lock() is called file->f_file[mode]=
->f_ops->lock
> > > > > > > > > > is set (fl_lmops is set too) prior to calling vfs_test_=
lock.
> > > > > > > > > > 2. Because ->lock is set vfs_test_lock() calls the ->lo=
ck function
> > > > > > > > > > (instead of posix_test_lock)
> > > > > > > > > > 3. After vfs_test_lock() fl_lmops is still set so lock_=
release_private
> > > > > > > > > > is called and calls nlmscv_put_lockowner().
> > > > > > > > > >
> > > > > > > > > > Normal export
> > > > > > > > > > 1. when nlmsvc_test_lock() is called ->lock is not set =
(fl_lmops is
> > > > > > > > > > set) prior to calling vfs_test_lock
> > > > > > > > > > 2. Because -> is not set posix_test_lock() is called wh=
ich will call
> > > > > > > > > > local_copy_conflock() which will set fl_lmops to NULL.
> > > > > > > > > > 3. Since fl_lmops is NULL put_lockowner isn't called.
> > > > > > > > > >
> > > > > > > > > > Reexport is where I'm hazy. I'm assuming that reexporte=
d server opened
> > > > > > > > > > a file and the "file" is the NFS file object and that's=
 why
> > > > > > > > > > file->f_file[mode]->f_ops->lock is set? So perhaps if w=
e take the
> > > > > > > > > > presence of ->lock to mean reexport, we can do as I did=
 (ie., set
> > > > > > > > > > fl_lmops to null), or maybe we can take an extra refere=
nce knowing
> > > > > > > > > > that we'd need to put it in lock_release_private() ( --=
 this
> > > > > > > > > > suggestion ties to your next question). I don't see any=
 difference to
> > > > > > > > > > either setting it to NULL or taking an extra reference =
for when
> > > > > > > > > > ->lock() is set . Both are confusing and I would say wa=
rrant a comment
> > > > > > > > > > for why we are doing it.
> > > > > > > > > >
> > > > > > > > >
> > > > > > > > > To be clear, there is nothing "special" about NFS reexpor=
t here. The
> > > > > > > > > NFS client just has some limitations as to what it can do=
 when it's
> > > > > > > > > being (re)exported. Exporting other sorts of network or c=
lustered
> > > > > > > > > filesystems can also be problematic for similar reasons.
> > > > > > > > >
> > > > > > > > > So, we should focus on making this generically work, and =
not take -
> > > > > > > > > > lock being set to mean that this is an NFS reexport.
> > > > > > > >
> > > > > > > > I guess it doesn't matter what kind of re-export but the fa=
ct that if
> > > > > > > > ->lock is set we know that posix_test_lock and then
> > > > > > > > local_copy_conflock won't be called and thus there is a gre=
at chance
> > > > > > > > that fl_lmops will still be set on return from vfs_test_loc=
k().
> > > > > > > >
> > > > > > > > > A question: you mentioned this is a reexporting server. A=
re you
> > > > > > > > > reexporting an NFSv4 mount as NFSv3? Or is this a v3->v3 =
reexport?
> > > > > > > >
> > > > > > > > v3->v3 reexport.
> > > > > > > >
> > > > > > > >
> > > > > > >
> > > > > > > Ok, looking now:
> > > > > > >
> > > > > > > The test_owner in __nlm4svc_proc_test() comes from the args, =
which
> > > > > > > happens during the decode phase. That gets a valid reference =
to an NLM
> > > > > > > lockowner in nlmsvc_locks_init_private(). Therefore, this cal=
l in
> > > > > > > __nlm4svc_proc_test() seems legit.
> > > > > > >
> > > > > > >         nlmsvc_put_lockowner(test_owner);
> > > > > > >
> > > > > > > Now, between those two gets/puts, there is the call to vfs_te=
st_lock()
> > > > > > > in nlmsvc_testlock(). That uses the same file_lock argument s=
tructure
> > > > > > > to represent both the lock and the conflock.
> > > > > > >
> > > > > > >         error =3D vfs_test_lock(file->f_file[mode], &lock->fl=
);
> > > > > > >
> > > > > > > ...so the flc_owner field at this point is still set to the (=
original)
> > > > > > > nlmclient's owner.
> > > > > > >
> > > > > > > In this case, that call ends up calling down in nlmclnt_test(=
), which
> > > > > > > ignores the flc_owner field. It also ends up overwriting the =
other
> > > > > > > fields in &fl with conflock info.
> > > > > > >
> > > > > > > I think the bug is actually there. Before nlmclnt_test() over=
writes the
> > > > > > > fields in "fl", it needs to release the owner reference (and =
zero out
> > > > > > > the owner). Would this patch fix the bug?
> > > > > > >
> > > > > > > ---------------------8------------------------
> > > > > > >
> > > > > > > diff --git a/fs/lockd/clntproc.c b/fs/lockd/clntproc.c
> > > > > > > index cebcc283b7ce..200309ee1a74 100644
> > > > > > > --- a/fs/lockd/clntproc.c
> > > > > > > +++ b/fs/lockd/clntproc.c
> > > > > > > @@ -438,6 +438,8 @@ nlmclnt_test(struct nlm_rqst *req, struct=
 file_lock
> > > > > > > *fl)
> > > > > > >         if (status < 0)
> > > > > > >                 goto out;
> > > > > > >
> > > > > > > +       locks_release_private(&fl);
> > > > > > > +
> > > > > > >         switch (req->a_res.status) {
> > > > > > >                 case nlm_granted:
> > > > > > >                         fl->c.flc_type =3D F_UNLCK;
> > > > > >
> > > > > >
> > > > > > Sorry, I take it back. That alone won't fix it because of the p=
ointer-
> > > > > > saving shenanigans in __nlm4svc_proc_test. We'll need to do thi=
s a bit
> > > > > > more carefully, I think.
> > > > >
> > > > > How about this patch? The changelog still needs some work, but I =
think
> > > > > this is the most correct way to handle it:
> > > > >
> > > > > -------------------------8<----------------------------
> > > > >
> > > > > [PATCH] nlm: fix handling of conflocks by NLM
> > > > >
> > > > > The handling of conflocks can result in a refcount overput on the
> > > > > flc_owner in the case of a reexported NFSv3 fs.
> > > > >
> > > > > lockd will pass down a file_lock structure in its arguments with
> > > > > flc_owner set to an NLM owner and a valid reference. Once that ge=
ts
> > > > > down to the reexported NFS client, it will ignore that field and =
leave
> > > > > it intact when copying in conflock info.
> > > > >
> > > > > The NLM server code will then end up releasing the conflock, and =
then
> > > > > releasing the one from the arguments, not realizing that the lock=
 has
> > > > > already been released.
> > > > >
> > > > > The owner info in the arguments to vfs_test_lock() is there to gi=
ve
> > > > > information about the requestor. Once nlmclnt_test() is going to =
copy in
> > > > > the conflock info however, it needs to release the old owner.
> > > > >
> > > > > Have nlmclnt_test() do call locks_release_private() after testing=
 the
> > > > > lock to release any info that was in the old file_lock structure.
> > > > >
> > > > > This creates another problem: __nlm4svc_proc_test() and
> > > > > __nlmsvc_proc_test() both call nlmsvc_put_lockowner() uncondition=
ally on
> > > > > the original lockowner that it got from decoding the args. Switch=
 them
> > > > > both to just call locks_release_private() on &argp->lock instead,=
 which
> > > > > should handle the case properly where the info in argp->lock has =
already
> > > > > been released.
> > > > >
> > > > > With that changed, we can also eliminate the call to
> > > > > locks_release_private() in nlmsvc_testlock() since the callers wi=
ll now
> > > > > handle that.
> > > > >
> > > > > Reported-by: Olga Kornievskaia <aglo@umich.edu>
> > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > ---
> > > > >  fs/lockd/clntproc.c | 3 +++
> > > > >  fs/lockd/svc4proc.c | 4 +---
> > > > >  fs/lockd/svclock.c  | 1 -
> > > > >  fs/lockd/svcproc.c  | 5 +----
> > > > >  4 files changed, 5 insertions(+), 8 deletions(-)
> > > > >
> > > > > diff --git a/fs/lockd/clntproc.c b/fs/lockd/clntproc.c
> > > > > index cebcc283b7ce..d3dd04137677 100644
> > > > > --- a/fs/lockd/clntproc.c
> > > > > +++ b/fs/lockd/clntproc.c
> > > > > @@ -438,6 +438,9 @@ nlmclnt_test(struct nlm_rqst *req, struct fil=
e_lock *fl)
> > > > >         if (status < 0)
> > > > >                 goto out;
> > > > >
> > > > > +       /* Release any references held by fl before copying in co=
nflock info */
> > > > > +       locks_release_private(fl);
> > > > > +
> > > > >         switch (req->a_res.status) {
> > > > >                 case nlm_granted:
> > > > >                         fl->c.flc_type =3D F_UNLCK;
> > > > > diff --git a/fs/lockd/svc4proc.c b/fs/lockd/svc4proc.c
> > > > > index 109e5caae8c7..cbfec12296a4 100644
> > > > > --- a/fs/lockd/svc4proc.c
> > > > > +++ b/fs/lockd/svc4proc.c
> > > > > @@ -97,7 +97,6 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, str=
uct nlm_res *resp)
> > > > >         struct nlm_args *argp =3D rqstp->rq_argp;
> > > > >         struct nlm_host *host;
> > > > >         struct nlm_file *file;
> > > > > -       struct nlm_lockowner *test_owner;
> > > > >         __be32 rc =3D rpc_success;
> > > > >
> > > > >         dprintk("lockd: TEST4        called\n");
> > > > > @@ -107,7 +106,6 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, s=
truct nlm_res *resp)
> > > > >         if ((resp->status =3D nlm4svc_retrieve_args(rqstp, argp, =
&host, &file)))
> > > > >                 return resp->status =3D=3D nlm_drop_reply ? rpc_d=
rop_reply :rpc_success;
> > > > >
> > > > > -       test_owner =3D argp->lock.fl.c.flc_owner;
> > > > >         /* Now check for conflicting locks */
> > > > >         resp->status =3D nlmsvc_testlock(rqstp, file, host, &argp=
->lock,
> > > > >                                        &resp->lock);
> > > > > @@ -116,7 +114,7 @@ __nlm4svc_proc_test(struct svc_rqst *rqstp, s=
truct nlm_res *resp)
> > > > >         else
> > > > >                 dprintk("lockd: TEST4        status %d\n", ntohl(=
resp->status));
> > > > >
> > > > > -       nlmsvc_put_lockowner(test_owner);
> > > > > +       locks_release_private(&argp->lock.fl);
> > > > >         nlmsvc_release_host(host);
> > > > >         nlm_release_file(file);
> > > > >         return rc;
> > > >
> > > > Aren't these svc4proc changes defeat the purpose of the following c=
ommit:
> > > >
> > > > commit 184cefbe62627730c30282df12bcff9aae4816ea
> > > > Author: Benjamin Coddington <bcodding@redhat.com>
> > > > Date:   Mon Jun 13 09:40:06 2022 -0400
> > > >
> > > >     NLM: Defend against file_lock changes after vfs_test_lock()
> > > >
> > > >     Instead of trusting that struct file_lock returns completely un=
changed
> > > >     after vfs_test_lock() when there's no conflicting lock, stash a=
way our
> > > >     nlm_lockowner reference so we can properly release it for all c=
ases.
> > > >
> > > >
> > > >     This defends against another file_lock implementation overwriti=
ng fl_owner
> > > >     when the return type is F_UNLCK.
> > > >
> > > > Not that they are the cause of the crash but I would imagine it wou=
ld
> > > > cause a problem fixed by the patch....
> > > >
> > >
> > > Yes, it would. I'm not sure that patch is correct.
> >
> > But it seems wrong that we are now considering putting a patch that
> > fixes one issue (ie crash on reexport) but re-introduces another issue
> > (that the reverted code fixed be it not in a correct manner).
> >
>
> I'm not sure what you mean by reintroducing another issue? What bug
> would be reintroduced?

I might be reading the changes incorrectly so bear with me. The
proposal that in nlm4srv_proc_test() we don't save the tets_owner
pointer prior to calling nlmsvc_testlock() and then do a put on the
original file (args->lock.fl). now this lock is the one being modified
by vfs_test_lock() am I not correct?

When you asked what bug would be reintroduced. Here's what I got from
a bugzilla opened with regards to the "NLM: Defend against file_lock
changes after vfs_test_lock()" patch. I believe it describes the
problem that would come back.

"If underlying filesystem implementation modifies file_lock->fl_owner
for F_GETLK operations, returned owner may not be even a mapped
address on the box. This scenario, when dealing with a non-conflictive
locks may cause oops, panicing the box while accessing unmapped
address trying to get rid of the owner through :

__nlm4svc_proc_test() / __nlm4svc_proc_test() ->
nlmsvc_release_lockowner() -> nlmsvc_put_lockowner

oops stack :

[6823679.912979] RIP: 0010:nlmsvc_put_lockowner+0x6/0x80 [lockd]
....
[6823679.923427] Call Trace:
[6823679.924012]  __nlm4svc_proc_test+0xe8/0x110 [lockd]
[6823679.924674]  svc_process_common+0x64f/0x700 [sunrpc]
[6823679.925273]  ? svc_recv+0x3d0/0x820 [sunrpc]
[6823679.925823]  ? grace_ender+0x20/0x20 [lockd]
[6823679.926388]  svc_process+0xb7/0xf0 [sunrpc]
[6823679.926949]  lockd+0xae/0x190 [lockd]
[6823679.927467]  ? __kthread_parkme+0x4c/0x70
[6823679.927976]  kthread+0x116/0x130
[6823679.928467]  ? kthread_flush_work_fn+0x10/0x10
[6823679.928972]  ret_from_fork+0x1f/0x40


POSIX imposes flock structures to remain intact (but l_type set to
F_UNLCK) for F_GETLK cases when lock is not held,
but not necessary file_lock->fl_owner struct. NLM should be more
defensive on that situation if underlying fs implementation changes
the owner.

Steps to reproduce:
1.GPFS cluster, several nodes acting as NFS server
2.adv. locking operations over nfs3 shares "

> My main concern is that when you clear fl_lmops pointer in the way that
> you were suggesting, you're making assumptions about the lockowner that
> eventually ends up in flc_owner.

> Calling vfs_test_lock() may populate flc_owner with a valid reference.
> Maybe it ends up returning an nfsd4 lock in that field. At that point
> you've just leaked that reference.

I'm rather unclear here why a lock that's being tested is supposed to
be responsible for releasing something on a conflicting lock. I would
rather think that like an example of GPFS it is not something we
should be touching but why is a conflicting NFSD lock (saying coming
from a different namespace) should be any different. On that basis I
thought my solution is a plausible stepping stone


> The right fix here is doing what Neil suggested -- adding a separate
> conflock argument to the ->lock operation. That would fix all of this.
> A lot of filesystems have ->lock operations though and they will all
> need to be touched.
>
> How about we just do this:
>
> Make lockd's client side respect EXPORT_OP_NOLOCKS just like the nfs4
> client does. That would prevent this particular problem (albeit with a
> heavy hammer). That should be easy to backport to stable too.
>
> Then we do a separate patch series that adds a separate conflock
> parameter to the ->lock f_op and vfs_test_lock()
>
> Thoughts?
> --
> Jeff Layton <jlayton@kernel.org>

