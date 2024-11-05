Return-Path: <linux-nfs+bounces-7678-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F10A9BD8E8
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Nov 2024 23:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BDE2B21F50
	for <lists+linux-nfs@lfdr.de>; Tue,  5 Nov 2024 22:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E95B21621C;
	Tue,  5 Nov 2024 22:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="KB9u7dGt"
X-Original-To: linux-nfs@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5FD1CCB2D;
	Tue,  5 Nov 2024 22:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730846467; cv=none; b=tOJjqPTDqSYJ6iQ+yJ48QzkcGhpMi1IZ0bGI8Pud1Qt6iH/+UWb7o8mGcGvrYxL45mWy00m3cOcChxiNibNLfV9bPTi8shV5jPkMMytNtlc1LuYcAxbXHsgHe22s/JjOf5K1wg+Pxd7J/bJjPLS9jLDix4b016ELA7csdFqV6Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730846467; c=relaxed/simple;
	bh=DAPfxJYbJLsL+VFxHSs5HL+Cl8efPE/gNgKypZX0Td4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gvPTA07Y8mvrps9dYsHaZaZGvKUrsZkyG2NP2vTQaJnkFCjq9CiQUF70m2LTb6vJGordtHbUWvNYuk1dsLjlRjuwbWHYG0jWzsTrcHd30abrHIgRLNrI7WumZYL1ucZctZLpCIOEIlAat9tqHHDDw+rS1OiSh5eWTl5jcyY1HNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=KB9u7dGt; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2fb5111747cso57390251fa.2;
        Tue, 05 Nov 2024 14:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1730846461; x=1731451261; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJqFCkvF8SrLjBZxBORCGL76xs7eLJC7Y9lJIRYC1+M=;
        b=KB9u7dGto4yD7xzQAC7UFo7WOg1p4PVYPzwoy+GTEmMNJuw6OcFKzyOVQ6DACESBiq
         uSpbNCeDDb+CzQKmkxWHd+qAAV+Md4VKHug0leBITKtIXdR+Z0MzuQmPmBjhesfFhMQk
         aySzE4YyEAqvCGRNzq0iuvSsyo9VBdGDV1Am1d3WAL0zeBFwB4qC4ATDPIXo6BgjYnnJ
         WHDeQmTtE7sIp3Optl5TC7++zbyqDi8m9adxdcwE9lJ8Knv+A6EIMY/uYl/EUbtIKk/b
         HZcaE5pEWyFgo3NCAHpFX0pdf2AMvt2THYCJJQA2q/h4nANKYsxhZbsUvKRD2BBhKQ3f
         1xWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730846461; x=1731451261;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJqFCkvF8SrLjBZxBORCGL76xs7eLJC7Y9lJIRYC1+M=;
        b=Gp1USfLCzsnH9RD7lrjDDaXDuTNp8tZfb6gjj+11KrKmIlbV7vpfTmynyRfIOxjT6Z
         rxZQWlUxs/vQS8fxpKhza8Hy2Gz+VahieIt6ggCIxgAa82XMHqrRqTajxQOJiVxaZMj9
         hy2i4VY+g03S2p12P5X//Ih1o6lQ++WtVmG9J36Qo9EcOrq6330tj0uH1qf+Xmx1Si9O
         wRM05NoASIxjcJv85kZjPcErgOI7fY6wGz8WxySGL/ggu5BH9wY1YnDn/XxM5pwqC7oV
         W5yVZHrqCEgK9ZHs47dC7wdLVAw3cathTGOXst2tx3os2qKLW+poDLz3ASJoe4YAjLW3
         L1Iw==
X-Forwarded-Encrypted: i=1; AJvYcCWiie5YgowVwy77Jcjt3BBcJT0mUv87lYUiidkRNoFGwtKQB4f4bBRlsTdBKzRHoduc/U2AtXEO1+GF@vger.kernel.org, AJvYcCXMQ3cAiipyaBYlomtHkcVSqPd8OE0nOXhDGR6mm7rXDlNviaCKUkOzc7PshoaPbFkjemdn+qyh79sR0ko=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmoTxAlz04wM90Rk5CMpvk62itKLKFZkbLLMr00yr8f/9pwZq5
	7Tfx874pqGJ4/ZzvdjsEquolP5D63tlfjfpDRhl8/pLXcV7KBTebzkIV5U5CoMaw6kBJJBatid/
	Fwd0oqdG7Bo1TjQGtL7U3rQIR24A=
X-Google-Smtp-Source: AGHT+IGZUoD4cfR+vkFKYzUL5QrOnu2gbXzgy428pvjGXo60wt58nVDQgTO8HMwth2Uf2rpa1uyR5ycIz/TV27Fctm4=
X-Received: by 2002:a2e:beac:0:b0:2fb:955e:5c17 with SMTP id
 38308e7fff4ca-2fdecc4d509mr114880621fa.40.1730846461202; Tue, 05 Nov 2024
 14:41:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241030-bcwide-v3-0-c2df49a26c45@kernel.org> <173032010891.47979.16372737966948328031.b4-ty@oracle.com>
 <CAN-5tyEtZbD8TDMbyxutf_LCT1-aoG_BUF2gjBiMJ0HG9eLMMg@mail.gmail.com> <badb3156aa3778c21b3c76e5ad129eb6f91fb799.camel@kernel.org>
In-Reply-To: <badb3156aa3778c21b3c76e5ad129eb6f91fb799.camel@kernel.org>
From: Olga Kornievskaia <aglo@umich.edu>
Date: Tue, 5 Nov 2024 17:40:49 -0500
Message-ID: <CAN-5tyHo_3b7gGVnrnkr3J+tAYSUB=70UZyesAE4fEwOTzso4A@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] nfsd: allow the use of multiple backchannel slots
To: Jeff Layton <jlayton@kernel.org>
Cc: cel@kernel.org, Neil Brown <neilb@suse.de>, Dai Ngo <Dai.Ngo@oracle.com>, 
	Tom Talpey <tom@talpey.com>, Chuck Lever <chuck.lever@oracle.com>, 
	Olga Kornievskaia <okorniev@redhat.com>, linux-nfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 5:27=E2=80=AFPM Jeff Layton <jlayton@kernel.org> wro=
te:
>
> On Tue, 2024-11-05 at 17:08 -0500, Olga Kornievskaia wrote:
> > Hi Jeff/Chuck,
> >
> > Hitting the following softlockup when running using nfsd-next code.
> > testing is same open bunch of file get delegations, do local
> > conflicting operation. Network trace shows a few cb_recalls occurring
> > successfully before the soft lockup (I can confirm that more than 1
> > slot was used. But I also see that the server isn't trying to use the
> > lowest available slot but instead just bumps the number and uses the
> > next one. By that I mean, say slot 0 was used and a reply came back
> > but the next callback would use slot 1 instead of slot 0).
> >
>
> If the slots are being consumed and not released then that's what you'd
> see. The question is why those slots aren't being released.
>
> Did the client return a SEQUENCE error on some of those callbacks? It
> looks like the slot doesn't always get released if that occurs, so that
> might be one possibility.

No sequence errors. CB_SEQUENCE and CB_RECALL replies are all successful.

> > [  344.045843] watchdog: BUG: soft lockup - CPU#0 stuck for 26s!
> > [kworker/u24:28:205]
> > [  344.047669] Modules linked in: rpcrdma rdma_cm iw_cm ib_cm ib_core
> > nfsd auth_rpcgss nfs_acl lockd grace uinput isofs snd_seq_dummy
> > snd_hrtimer vsock_loopback vmw_vsock_virtio_transport_common qrtr
> > rfkill vmw_vsock_vmci_transport vsock sunrpc vfat fat uvcvideo
> > snd_hda_codec_generic snd_hda_intel videobuf2_vmalloc snd_intel_dspcfg
> > videobuf2_memops uvc snd_hda_codec videobuf2_v4l2 snd_hda_core
> > snd_hwdep videodev snd_seq snd_seq_device videobuf2_common snd_pcm mc
> > snd_timer snd vmw_vmci soundcore xfs libcrc32c vmwgfx nvme
> > drm_ttm_helper ttm crct10dif_ce ghash_ce sha2_ce sha256_arm64
> > drm_kms_helper nvme_core sha1_ce sr_mod e1000e nvme_auth cdrom drm sg
> > fuse
> > [  344.050421] CPU: 0 UID: 0 PID: 205 Comm: kworker/u24:28 Kdump:
> > loaded Not tainted 6.12.0-rc4+ #42
> > [  344.050821] Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS
> > VMW201.00V.21805430.BA64.2305221830 05/22/2023
> > [  344.051248] Workqueue: rpciod rpc_async_schedule [sunrpc]
> > [  344.051513] pstate: 11400005 (nzcV daif +PAN -UAO -TCO +DIT -SSBS BT=
YPE=3D--)
> > [  344.051821] pc : kasan_check_range+0x0/0x188
> > [  344.052011] lr : __kasan_check_write+0x1c/0x28
> > [  344.052208] sp : ffff800087027920
> > [  344.052352] x29: ffff800087027920 x28: 0000000000040000 x27: ffff000=
0a520f170
> > [  344.052710] x26: 0000000000000000 x25: 1fffe00014a41e2e x24: ffff000=
2841692c0
> > [  344.053159] x23: ffff0002841692c8 x22: 0000000000000000 x21: 1ffff00=
010e04f2a
> > [  344.053612] x20: ffff0002841692c0 x19: ffff80008318c2c0 x18: 0000000=
000000000
> > [  344.054054] x17: 0000006800000000 x16: 1fffe0000010fd60 x15: 0a0d373=
03736205d
> > [  344.054501] x14: 3136335b0a0d3630 x13: 1ffff000104751c9 x12: ffff600=
014a41e2f
> > [  344.054952] x11: 1fffe00014a41e2e x10: ffff600014a41e2e x9 : dfff800=
000000000
> > [  344.055402] x8 : 00009fffeb5be1d2 x7 : ffff0000a520f173 x6 : 0000000=
000000001
> > [  344.055735] x5 : ffff0000a520f170 x4 : 0000000000000000 x3 : ffff800=
0823129fc
> > [  344.056058] x2 : 0000000000000001 x1 : 0000000000000002 x0 : ffff000=
0a520f172
> > [  344.056479] Call trace:
> > [  344.056636]  kasan_check_range+0x0/0x188
> > [  344.056886]  queued_spin_lock_slowpath+0x5f4/0xaa0
> > [  344.057192]  _raw_spin_lock+0x180/0x1a8
> > [  344.057436]  rpc_sleep_on+0x78/0xe8 [sunrpc]
> > [  344.057700]  nfsd4_cb_prepare+0x15c/0x468 [nfsd]
> > [  344.057935]  rpc_prepare_task+0x70/0xa0 [sunrpc]
> > [  344.058165]  __rpc_execute+0x1e8/0xa48 [sunrpc]
> > [  344.058388]  rpc_async_schedule+0x90/0x100 [sunrpc]
> > [  344.058623]  process_one_work+0x598/0x1100
> > [  344.058818]  worker_thread+0x6c0/0xa58
> > [  344.058992]  kthread+0x288/0x310
> > [  344.059145]  ret_from_fork+0x10/0x20
> > [  344.075846] watchdog: BUG: soft lockup - CPU#1 stuck for 26s!
> > [kworker/u24:27:204]
> > [  344.076295] Modules linked in: rpcrdma rdma_cm iw_cm ib_cm ib_core
> > nfsd auth_rpcgss nfs_acl lockd grace uinput isofs snd_seq_dummy
> > snd_hrtimer vsock_loopback vmw_vsock_virtio_transport_common qrtr
> > rfkill vmw_vsock_vmci_transport vsock sunrpc vfat fat uvcvideo
> > snd_hda_codec_generic snd_hda_intel videobuf2_vmalloc snd_intel_dspcfg
> > videobuf2_memops uvc snd_hda_codec videobuf2_v4l2 snd_hda_core
> > snd_hwdep videodev snd_seq snd_seq_device videobuf2_common snd_pcm mc
> > snd_timer snd vmw_vmci soundcore xfs libcrc32c vmwgfx nvme
> > drm_ttm_helper ttm crct10dif_ce ghash_ce sha2_ce sha256_arm64
> > drm_kms_helper nvme_core sha1_ce sr_mod e1000e nvme_auth cdrom drm sg
> > fuse
> > [  344.079648] CPU: 1 UID: 0 PID: 204 Comm: kworker/u24:27 Kdump:
> > loaded Tainted: G             L     6.12.0-rc4+ #42
> > [  344.080290] Tainted: [L]=3DSOFTLOCKUP
> > [  344.080495] Hardware name: VMware, Inc. VMware20,1/VBSA, BIOS
> > VMW201.00V.21805430.BA64.2305221830 05/22/2023
> > [  344.080930] Workqueue: rpciod rpc_async_schedule [sunrpc]
> > [  344.081212] pstate: 21400005 (nzCv daif +PAN -UAO -TCO +DIT -SSBS BT=
YPE=3D--)
> > [  344.081630] pc : _raw_spin_lock+0x108/0x1a8
> > [  344.081815] lr : _raw_spin_lock+0xf4/0x1a8
> > [  344.081998] sp : ffff800087017a30
> > [  344.082146] x29: ffff800087017a90 x28: ffff0000a520f170 x27: ffff600=
0148a1081
> > [  344.082467] x26: 1fffe000148a1081 x25: ffff0000a450840c x24: ffff000=
0a520ed40
> > [  344.082892] x23: ffff0000a4508404 x22: ffff0002e9028000 x21: ffff800=
087017a50
> > [  344.083338] x20: 1ffff00010e02f46 x19: ffff0000a520f170 x18: 0000000=
000000000
> > [  344.083775] x17: 0000000000000000 x16: 0000000000000000 x15: 0000aaa=
b024bdd10
> > [  344.084217] x14: 0000000000000000 x13: 0000000000000000 x12: ffff700=
010e02f4b
> > [  344.084625] x11: 1ffff00010e02f4a x10: ffff700010e02f4a x9 : dfff800=
000000000
> > [  344.084945] x8 : 0000000000000004 x7 : 0000000000000003 x6 : 0000000=
000000001
> > [  344.085264] x5 : ffff800087017a50 x4 : ffff700010e02f4a x3 : ffff800=
082311154
> > [  344.085587] x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000=
000000000
> > [  344.085915] Call trace:
> > [  344.086028]  _raw_spin_lock+0x108/0x1a8
> > [  344.086210]  rpc_wake_up_queued_task+0x5c/0xf8 [sunrpc]
> > [  344.086465]  nfsd4_cb_prepare+0x168/0x468 [nfsd]
> > [  344.086694]  rpc_prepare_task+0x70/0xa0 [sunrpc]
> > [  344.086922]  __rpc_execute+0x1e8/0xa48 [sunrpc]
> > [  344.087148]  rpc_async_schedule+0x90/0x100 [sunrpc]
> > [  344.087389]  process_one_work+0x598/0x1100
> > [  344.087584]  worker_thread+0x6c0/0xa58
> > [  344.087758]  kthread+0x288/0x310
> > [  344.087909]  ret_from_fork+0x10/0x20
> >
> > On Wed, Oct 30, 2024 at 4:30=E2=80=AFPM <cel@kernel.org> wrote:
> > >
> > > From: Chuck Lever <chuck.lever@oracle.com>
> > >
> > > On Wed, 30 Oct 2024 10:48:45 -0400, Jeff Layton wrote:
> > > > A few more minor updates to the set to fix some small-ish bugs, and=
 do a
> > > > bit of cleanup. This seems to test OK for me so far.
> > > >
> > > >
> > >
> > > Applied to nfsd-next for v6.13, thanks! Still open for comments and
> > > test results.
> > >
> > > [1/2] nfsd: make nfsd4_session->se_flags a bool
> > >       commit: d10f8b7deb4e8a3a0c75855fdad7aae9c1943816
> > > [2/2] nfsd: allow for up to 32 callback session slots
> > >       commit: 6c8910ac1cd360ea01136d707158690b5159a1d0
> > >
> > > --
> > > Chuck Lever
> > >
> > >
>
> --
> Jeff Layton <jlayton@kernel.org>

