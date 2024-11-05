Return-Path: <linux-nfs+bounces-7676-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BAF9BD827
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Nov 2024 23:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C013F1F22CE6
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Nov 2024 22:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949A8215C7D;
	Tue,  5 Nov 2024 22:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="Tgds+Bxz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB901FF7AF;
	Tue,  5 Nov 2024 22:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730844531; cv=none; b=SDevTvc5Zw+WZdkObOMSI9X+y3xH0Eg8ulv0NxgL2hClcFQHGidqddsHLAk85X6xg5xoQNUmxUobFwMs098dPDbLX+iayNOmbaCLJE+vNTyijVcAEOTYqnaYnQEiCohICtefz3GUxGruqg2LoKwmFtprVINjcxPSZUY2WA0UG/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730844531; c=relaxed/simple;
	bh=6TO+FoIIgq6vXRmjpzfQ+D69ImfxB3k9M4fCgSxTJss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WmTgMVuLYjw7VVWnvyyDq9+SkCAQz3O2kg+eoPvjK69SIEAVfj5Jtx83CRqNvv6ZMenhb0oF546uSqvQ7VFa14N1L7tqQEURJACUYgJAl1c/GW83VUX3a9ae5aCv7C1DlBFr4XNtmEFdw2T4yPqjKf/CiTko+ZQEUsm6U88eN7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=Tgds+Bxz; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2fb4fa17044so63732561fa.3;
        Tue, 05 Nov 2024 14:08:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1730844527; x=1731449327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0MZzQalBV2oxf552tg+17LTUObNw5fIUejHa0NEC7ZQ=;
        b=Tgds+Bxz3A4jxA6rfWWTWiEqVqFvHFLkky1/+22UpIULhctwxhYTrh6+ZnsM8k761I
         ufceU9wYKs6ciiAzXgzalOXCCCDyl6zh7wJeXk/WhOldooREbK6nSFeapxIbHE7r3O5o
         BqFG8z9gNmbrSvbv3pc1O/qbAuK2yHUJGPy3buKgxMjvCQKEdqUzDFKegTJkOI0b2FG1
         o5JnKX3MY+w0SORi4aPXxV3u9KB4sXN+Pvt1KiMdmAsG4NrksKkhteoTRpjCWHJNF95z
         s4kdnEYJJ5f53sTUa5BwPT9c2aXetf9N32nun4/B5imyKxlJOq86Zj3FQNudF5nwrnFm
         WCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730844527; x=1731449327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0MZzQalBV2oxf552tg+17LTUObNw5fIUejHa0NEC7ZQ=;
        b=p+mHqLROE5BTwYZ0N6RKrNh2XMUCYQ+dL/wDU6RnJXnQbMT05OQse996Bsp7LdQqTh
         VjRHOSwtqlZHZ1GPozLc57XXXJK/QY/a92ayOvKRLEh9t6YP2Sb9vMu7MHmZKBI0XDqh
         gLmTI3M1xvwcoHdHIlNObqYZgxui90Tu+x555I4b36JN3zBl/I+g1ouxDOD9uafF7aKk
         PZJqY9S7QSisuqul4DfIbK6erqDtFqWhh5sK/GqJ5nCazeU+qWewXIgWDxJmezWeoPon
         A0XSAy+ycrHdu6DIhi047iAbrq2L/f3pZZvcGVx4k++6FCL10hFUFpP9yrqExAI2di4D
         hTYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUGeQTilc6uaOZVEwgjsMYbAKcdkCNhM4vGSUHfvWrV51nLNJ2URqLt6ZbqioWG2tj3FNsqLG9aL7n2klg=@vger.kernel.org, AJvYcCVB3ymI49QD0iDfO/v4By3YC5C3j4KgQ0psqpzQ4PrEaJaPLRwO90bukc3aIN9UHtbbJEa0dSmAQpIj@vger.kernel.org
X-Gm-Message-State: AOJu0YxHQM5HtzMqc6jBoaS8Gr3G/qzYzrQ1IgcWG9jKiw67J/Fm0Iss
	1uCi6qZdRy1Gwl+UDIWHwVVlS2HWs1D5LYIqGPx/hvq7a+kXgd7mZKloHC2tuuAKNmbMA3xP0kb
	ehQ9HF6fz2bHnaIe7jCRrrJHipDc=
X-Google-Smtp-Source: AGHT+IHTex7oWkQE6+7IIQRRVadmTMB8R1JcvDz+gZTmXAU2CJJznF9zocRudSlI++LozCH3qNey0N/b6W0DftpOMYI=
X-Received: by 2002:a2e:bc0e:0:b0:2fb:61c0:103 with SMTP id
 38308e7fff4ca-2fedb757a88mr88168011fa.4.1730844526759; Tue, 05 Nov 2024
 14:08:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030-bcwide-v3-0-c2df49a26c45@kernel.org> <173032010891.47979.16372737966948328031.b4-ty@oracle.com>
In-Reply-To: <173032010891.47979.16372737966948328031.b4-ty@oracle.com>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Tue, 5 Nov 2024 17:08:35 -0500
Message-ID: <CAN-5tyEtZbD8TDMbyxutf_LCT1-aoG_BUF2gjBiMJ0HG9eLMMg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] nfsd: allow the use of multiple backchannel slots
To: cel@kernel.org, Jeff Layton <jlayton@kernel.org>
Cc: Neil Brown <neilb@suse.de>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	Chuck Lever <chuck.lever@oracle.com>, Olga Kornievskaia <okorniev@redhat.com>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jeff/Chuck,

Hitting the following softlockup when running using nfsd-next code.
testing is same open bunch of file get delegations, do local
conflicting operation. Network trace shows a few cb_recalls occurring
successfully before the soft lockup (I can confirm that more than 1
slot was used. But I also see that the server isn't trying to use the
lowest available slot but instead just bumps the number and uses the
next one. By that I mean, say slot 0 was used and a reply came back
but the next callback would use slot 1 instead of slot 0).

[  344.045843] watchdog: BUG: soft lockup - CPU#0 stuck for 26s!
[kworker/u24:28:205]
[  344.047669] Modules linked in: rpcrdma rdma_cm iw_cm ib_cm ib_core
nfsd auth_rpcgss nfs_acl lockd grace uinput isofs snd_seq_dummy
snd_hrtimer vsock_loopback vmw_vsock_virtio_transport_common qrtr
rfkill vmw_vsock_vmci_transport vsock sunrpc vfat fat uvcvideo
snd_hda_codec_generic snd_hda_intel videobuf2_vmalloc snd_intel_dspcfg
videobuf2_memops uvc snd_hda_codec videobuf2_v4l2 snd_hda_core
snd_hwdep videodev snd_seq snd_seq_device videobuf2_common snd_pcm mc
snd_timer snd vmw_vmci soundcore xfs libcrc32c vmwgfx nvme
drm_ttm_helper ttm crct10dif_ce ghash_ce sha2_ce sha256_arm64
drm_kms_helper nvme_core sha1_ce sr_mod e1000e nvme_auth cdrom drm sg
fuse
[  344.050421] CPU: 0 UID: 0 PID: 205 Comm: kworker/u24:28 Kdump:
loaded Not tainted 6.12.0-rc4+ #42
[  344.050821] Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS
VMW201.00V.21805430.BA64.2305221830 05/22/2023
[  344.051248] Workqueue: rpciod rpc_async_schedule [sunrpc]
[  344.051513] pstate: 11400005 (nzcV daif +PAN -UAO -TCO +DIT -SSBS BTYPE=
=3D--)
[  344.051821] pc : kasan_check_range+0x0/0x188
[  344.052011] lr : __kasan_check_write+0x1c/0x28
[  344.052208] sp : ffff800087027920
[  344.052352] x29: ffff800087027920 x28: 0000000000040000 x27: ffff0000a52=
0f170
[  344.052710] x26: 0000000000000000 x25: 1fffe00014a41e2e x24: ffff0002841=
692c0
[  344.053159] x23: ffff0002841692c8 x22: 0000000000000000 x21: 1ffff00010e=
04f2a
[  344.053612] x20: ffff0002841692c0 x19: ffff80008318c2c0 x18: 00000000000=
00000
[  344.054054] x17: 0000006800000000 x16: 1fffe0000010fd60 x15: 0a0d3730373=
6205d
[  344.054501] x14: 3136335b0a0d3630 x13: 1ffff000104751c9 x12: ffff600014a=
41e2f
[  344.054952] x11: 1fffe00014a41e2e x10: ffff600014a41e2e x9 : dfff8000000=
00000
[  344.055402] x8 : 00009fffeb5be1d2 x7 : ffff0000a520f173 x6 : 00000000000=
00001
[  344.055735] x5 : ffff0000a520f170 x4 : 0000000000000000 x3 : ffff8000823=
129fc
[  344.056058] x2 : 0000000000000001 x1 : 0000000000000002 x0 : ffff0000a52=
0f172
[  344.056479] Call trace:
[  344.056636]  kasan_check_range+0x0/0x188
[  344.056886]  queued_spin_lock_slowpath+0x5f4/0xaa0
[  344.057192]  _raw_spin_lock+0x180/0x1a8
[  344.057436]  rpc_sleep_on+0x78/0xe8 [sunrpc]
[  344.057700]  nfsd4_cb_prepare+0x15c/0x468 [nfsd]
[  344.057935]  rpc_prepare_task+0x70/0xa0 [sunrpc]
[  344.058165]  __rpc_execute+0x1e8/0xa48 [sunrpc]
[  344.058388]  rpc_async_schedule+0x90/0x100 [sunrpc]
[  344.058623]  process_one_work+0x598/0x1100
[  344.058818]  worker_thread+0x6c0/0xa58
[  344.058992]  kthread+0x288/0x310
[  344.059145]  ret_from_fork+0x10/0x20
[  344.075846] watchdog: BUG: soft lockup - CPU#1 stuck for 26s!
[kworker/u24:27:204]
[  344.076295] Modules linked in: rpcrdma rdma_cm iw_cm ib_cm ib_core
nfsd auth_rpcgss nfs_acl lockd grace uinput isofs snd_seq_dummy
snd_hrtimer vsock_loopback vmw_vsock_virtio_transport_common qrtr
rfkill vmw_vsock_vmci_transport vsock sunrpc vfat fat uvcvideo
snd_hda_codec_generic snd_hda_intel videobuf2_vmalloc snd_intel_dspcfg
videobuf2_memops uvc snd_hda_codec videobuf2_v4l2 snd_hda_core
snd_hwdep videodev snd_seq snd_seq_device videobuf2_common snd_pcm mc
snd_timer snd vmw_vmci soundcore xfs libcrc32c vmwgfx nvme
drm_ttm_helper ttm crct10dif_ce ghash_ce sha2_ce sha256_arm64
drm_kms_helper nvme_core sha1_ce sr_mod e1000e nvme_auth cdrom drm sg
fuse
[  344.079648] CPU: 1 UID: 0 PID: 204 Comm: kworker/u24:27 Kdump:
loaded Tainted: G             L     6.12.0-rc4+ #42
[  344.080290] Tainted: [L]=3DSOFTLOCKUP
[  344.080495] Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS
VMW201.00V.21805430.BA64.2305221830 05/22/2023
[  344.080930] Workqueue: rpciod rpc_async_schedule [sunrpc]
[  344.081212] pstate: 21400005 (nzCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=
=3D--)
[  344.081630] pc : _raw_spin_lock+0x108/0x1a8
[  344.081815] lr : _raw_spin_lock+0xf4/0x1a8
[  344.081998] sp : ffff800087017a30
[  344.082146] x29: ffff800087017a90 x28: ffff0000a520f170 x27: ffff6000148=
a1081
[  344.082467] x26: 1fffe000148a1081 x25: ffff0000a450840c x24: ffff0000a52=
0ed40
[  344.082892] x23: ffff0000a4508404 x22: ffff0002e9028000 x21: ffff8000870=
17a50
[  344.083338] x20: 1ffff00010e02f46 x19: ffff0000a520f170 x18: 00000000000=
00000
[  344.083775] x17: 0000000000000000 x16: 0000000000000000 x15: 0000aaab024=
bdd10
[  344.084217] x14: 0000000000000000 x13: 0000000000000000 x12: ffff700010e=
02f4b
[  344.084625] x11: 1ffff00010e02f4a x10: ffff700010e02f4a x9 : dfff8000000=
00000
[  344.084945] x8 : 0000000000000004 x7 : 0000000000000003 x6 : 00000000000=
00001
[  344.085264] x5 : ffff800087017a50 x4 : ffff700010e02f4a x3 : ffff8000823=
11154
[  344.085587] x2 : 0000000000000001 x1 : 0000000000000000 x0 : 00000000000=
00000
[  344.085915] Call trace:
[  344.086028]  _raw_spin_lock+0x108/0x1a8
[  344.086210]  rpc_wake_up_queued_task+0x5c/0xf8 [sunrpc]
[  344.086465]  nfsd4_cb_prepare+0x168/0x468 [nfsd]
[  344.086694]  rpc_prepare_task+0x70/0xa0 [sunrpc]
[  344.086922]  __rpc_execute+0x1e8/0xa48 [sunrpc]
[  344.087148]  rpc_async_schedule+0x90/0x100 [sunrpc]
[  344.087389]  process_one_work+0x598/0x1100
[  344.087584]  worker_thread+0x6c0/0xa58
[  344.087758]  kthread+0x288/0x310
[  344.087909]  ret_from_fork+0x10/0x20

On Wed, Oct 30, 2024 at 4:30=E2=80=AFPM <cel@kernel.org> wrote:
>
> From: Chuck Lever <chuck.lever@oracle.com>
>
> On Wed, 30 Oct 2024 10:48:45 -0400, Jeff Layton wrote:
> > A few more minor updates to the set to fix some small-ish bugs, and do =
a
> > bit of cleanup. This seems to test OK for me so far.
> >
> >
>
> Applied to nfsd-next for v6.13, thanks! Still open for comments and
> test results.
>
> [1/2] nfsd: make nfsd4_session->se_flags a bool
>       commit: d10f8b7deb4e8a3a0c75855fdad7aae9c1943816
> [2/2] nfsd: allow for up to 32 callback session slots
>       commit: 6c8910ac1cd360ea01136d707158690b5159a1d0
>
> --
> Chuck Lever
>
>

